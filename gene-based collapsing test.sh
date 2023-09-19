pheno="phenotype"
for i in {1..22};do
docker run -v /home/dnanexus/:/home/dnanexus/ -w /home/dnanexus/ wzhou88/saige:1.1.6 step1_fitNULLGLMM.R \
    --sparseGRMFile=/home/dnanexus/GRM/UKB_GRM_relatednessCutoff_0.05_5000_randomMarkersUsed_unrelated_2nd_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx \
    --sparseGRMSampleIDFile=/home/dnanexus/GRM/UKB_GRM_relatednessCutoff_0.05_5000_randomMarkersUsed_unrelated_2nd_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt \
    --plinkFile=/home/dnanexus/wes_data/ukb_wes_chr${i}_sample_qc_final_unrelated \
    --phenoFile=/home/dnanexus/anno/${pheno}.csv \
    --useSparseGRMtoFitNULL=FALSE   \
    --useSparseGRMforVarRatio=TRUE \
    --covarColList=sex,age,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10 \
    --qCovarColList=sex  \
    --phenoCol=${pheno} \
    --sampleIDColinphenoFile=eid \
    --isCovariateOffset=FALSE \
    --traitType=quantitative       \ #for binary phenotype, change this to --traitType=binary
    --nThreads=20   \
    --isCateVarianceRatio=TRUE	\
    --SampleIDIncludeFile=/home/dnanexus/british_id_sample.txt \
    --outputPrefix=/home/dnanexus/STEP1/traits/sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed_chr${i}_${pheno}_years_british_10pca_2nd	 \
    --IsOverwriteVarianceRatioFile=TRUE	

docker run -v /home/dnanexus/:/home/dnanexus/ -w /home/dnanexus/ wzhou88/saige:1.1.6 step2_SPAtests.R \
     --bedFile=/home/dnanexus/wes_data/ukb_wes_chr${i}_sample_qc_final_unrelated.bed \
     --bimFile=/home/dnanexus/wes_data/ukb_wes_chr${i}_sample_qc_final_unrelated.bim \
     --famFile=/home/dnanexus/wes_data/ukb_wes_chr${i}_sample_qc_final_unrelated.fam \
     --SAIGEOutputFile=/home/dnanexus/STEP2/traits/sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed_chr${i}_${pheno}_years_british_10pca_2nd_new_group_v2.txt \
     --AlleleOrder=alt-first \
     --minMAF=0 \
     --minMAC=0.5 \
     --GMMATmodelFile=/home/dnanexus/STEP1/traits/sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed_chr${i}_${pheno}_years_british_10pca_2nd.rda \
     --varianceRatioFile=/home/dnanexus/STEP1/traits/sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed_chr${i}_${pheno}_years_british_10pca_2nd.varianceRatio.txt \
     --sparseGRMFile=/home/dnanexus/GRM/UKB_GRM_relatednessCutoff_0.05_5000_randomMarkersUsed_unrelated_2nd_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx \
     --sparseGRMSampleIDFile=/home/dnanexus/GRM/UKB_GRM_relatednessCutoff_0.05_5000_randomMarkersUsed_unrelated_2nd_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt \
     --groupFile=/home/dnanexus/SNPEFF/SnpEff_gene_group_chr${i}.txt \
     --annotation_in_groupTest="lof,missense,missense:lof" \
     --maxMAF_in_groupTest=0.000005,0.00001,0.0001,0.001,0.01 \
     --is_output_markerList_in_groupTest=TRUE \
     --LOCO=FALSE \
     --is_overwrite_output=TRUE \
     --is_fastTest=TRUE
