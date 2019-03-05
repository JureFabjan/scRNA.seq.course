import pandas
from pathlib import PurePath

# Path to data folder
path = PurePath("Vaje", "GSE93374")
# Reading the csv with all the data
# Data is in log2(normalized) values with doubles already removed
file = pandas.read_csv(PurePath(path, "GSE93374_Merged_all_020816_" +
                                      "BatchCorrected_LNtransformed_" +
                                      "doubletsremoved_Data.txt"), sep="\t")
file.head()

# Reading metadata
metadata = pandas.read_csv(PurePath(path, "GSE93374_cell_metadata.txt"),
                           sep="\t")
metadata.head()
# Filtering metadata to only include POMC neurons
chosen_meta = metadata[metadata["10.clust_neurons"].isin(("n14",
                                                          "n15",
                                                          "n21"))]
chosen_meta.head()
# Filtering prefiltered metadata to include Chow group from the same batch
# The batch is the only one in Chow diet with both sexes
chow_meta = chosen_meta[(chosen_meta["5.Diet"] == "Chow") &
                        (chosen_meta["3.batches"] == "b6")]
chow_meta

# Keeping only data from animals in the filtered metadata
file_slice = file[chow_meta["1.ID"]]
file_slice.head()

# Saving the data file
file_slice.to_csv(PurePath(path, "GSE93374_sliced.txt"), sep="\t")
