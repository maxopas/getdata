run_analysis.R
==============

This script uses Samsung data to create a summary of different activities performed
by different subjects.
Data is downloaded into `"data/"` directory and then it's unpacked. If data is already
downloaded or packed, this operation will not be repeated.
Usage:
`$ R --vanilla < run_analysis.R`
Script will save results in file `data/tidy_set.txt`.
Script requires 'plyr' library to be installed.
