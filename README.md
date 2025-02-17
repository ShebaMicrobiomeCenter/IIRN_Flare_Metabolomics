# IIRN_Flare_Metabolomics
This repository is associated with the paper :

Fecal and serum metabolome in Crohn’s Disease linked with future flare

Gut and systemic metabolites are crucial in various physiological functions. However, there is a lack of data linking their levels to future Crohn’s Disease (CD) flare. We analyzed serum and fecal metabolomes in a prospective cohort of patients with quiescent CD who were monitored until either a clinical flare occurred or the end of the study follow-up. We aimed to identify metabolic changes that precede flare, generate a metabolite-based index that predicts flare using the test cohort (cohort 1), and validate the predictions in an independent cohort (cohort 2).
Using the “Leave-One-Out” approach to compensate for any possible over-fitting bias, we identified specific metabolic changes in pre-flare samples of CD patients and developed prediction models for a subsequent flare using serum and fecal metabolic signatures. Among the fecal metabolites linked to future flare, metabolite classification indicated significantly fewer fatty acids and more carbohydrates in pre-flare samples in those that eventually flared. Serum metabolites linked with flare included reduced levels of two TCA-cycle ketogenic derivates (3-hydroxybutyrate and acetoacetate) and higher urate in pre-flare samples. The predictions based on fecal metabolomics were validated in the independent CD cohort with a similar design. Lastly, we developed a clinical blood-based index [UA/Cr ratio+log2(CRP)] derived from the serum metabolomics model, which was also predictive in the validation cohort 2. Our results suggest that metabolites linked with future flare can provide insight into mechanisms prompting the transition from quiescent to inflammatory CD states and may support identifying those at risk for a flare.

Metadata and normalized data files are under the Datasets/ directory.

MaAsLin analyses results are under the Maaslin2/ directory.

HAllA analyses results are under the halla_res/ directory.

Additional run guides are available as readme.txt files under the appropriate subdirectories, as necessary.

## R session info:
R version 4.4.1 (2024-06-14)

Platform: aarch64-apple-darwin20

Running under: macOS 15.3


Matrix products: default

BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib

LAPACK: /Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.0

locale: [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:

[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:

 [1] pROC_1.18.5        patchwork_1.2.0    ggside_0.3.1       ggsankey_0.0.99999
 [5] ggsignif_0.6.4     lubridate_1.9.3    forcats_1.0.0      stringr_1.5.1     
 [9] dplyr_1.1.4        purrr_1.0.2        readr_2.1.5        tidyr_1.3.1       
[13] tibble_3.2.1       ggplot2_3.5.1      tidyverse_2.0.0   

loaded via a namespace (and not attached):

 [1] gtable_0.3.6      compiler_4.4.1    Rcpp_1.0.13       tidyselect_1.2.1 
 [5] scales_1.3.0      plyr_1.8.9        R6_2.5.1          generics_0.1.3   
 [9] knitr_1.48        munsell_0.5.1     pillar_1.10.1     tzdb_0.4.0       
[13] rlang_1.1.4       stringi_1.8.4     xfun_0.47         timechange_0.3.0 
[17] cli_3.6.3         withr_3.0.2       magrittr_2.0.3    grid_4.4.1       
[21] rstudioapi_0.16.0 hms_1.1.3         lifecycle_1.0.4   vctrs_0.6.5      
[25] glue_1.8.0        sessioninfo_1.2.2 colorspace_2.1-1  tools_4.4.1      
[29] pkgconfig_2.0.3

