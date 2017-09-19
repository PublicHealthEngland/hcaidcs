<!-- README.md is generated from README.Rmd. Please edit that file -->
This is a collection of functions to make working with data from the [HCAI DCS](https://hcaidcs.phe.org.uk/) easier. The plan is to include Rmd documents to produce the IS six-monthly reports and other standard outputs, including the quarterly epidemiologic commentary.

Installation
------------

Please email me for the zip file of the package. Once you have received the file, please do the following:

1.  Save the zip file to `H:\` but do not unzip
2.  Open RStudio
3.  Run the following line: `install.packages(file.choose(), repos=NULL)`
4.  This will launch a file chooser where you can select the zip file you have just downloaded.

This should install the package to the R package library.

If installation is successful you will then be able to load the package with `library(hcaidcs)`

Use
---

Functions that begin `aec_` are intended for producing tables or plots for the annual epidemiologic commentary.

Functions beginning `ann_tab_` are intended for the production of the annual tables.

Functions prefixed `nice_` indicate that they format values for nice printing in text, such as financial year, or an estimate with its' 95% confidence interval.

Functions prefixed `kh03_` indicate functions for use in the preparation of the kh03 denominator data.

Functions prefixed `mf_` indicate functions for use in the preparation of the HCAI monthly factsheet for the department of health.

Contributions
-------------

Contributions to this package are welcome. Please see the [Contribution guidelines](http://bioinformatics-git.phe.gov.uk/Simon.Thelwall/hcaidcs/blob/master/CONTRIBUTING.md).
