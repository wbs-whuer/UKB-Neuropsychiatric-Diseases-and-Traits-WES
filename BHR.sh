library(bhr)
baseline <- read.table("ms_baseline_oe5.txt")

#Estimates the burden heritability for each function-maf group
BHR_univariate <- BHR(mode = "univariate",
                            trait1_sumstats = sumstats_pLoF/missense,
                            annotations = list(baseline))

#Estimates the total burden heritability across multiple sets of function-maf group
BHR_aggregate<-BHR(mode = "aggregate", 
  ss_list = list(sumstats_pLoF,sumstats_missense)),
  trait_list = list(pheno_name),
  annotations = list(baseline))

#Estimates the burden genetic correlation and burden genetic correlation standard error for the trait pair
BHR_bivariate <- BHR(mode = "bivariate",
                 trait1_sumstats = sumstats_pheno1_pLoF,
                 trait2_sumstats = sumstats_pheno2_pLoF,
                 annotations = list(baseline))
rg<-bivariate$rg$rg_mixed
rg_se<-bivariate$rg$rg_mixed_se