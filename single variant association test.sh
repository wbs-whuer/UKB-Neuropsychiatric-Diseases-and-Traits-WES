for i in {1..22};do
plink2 \
--bfile ukb_wes_chr${i}_sample_qc_final_unrelated \
--glm hide-covar cols=chrom,pos,ax,a1freq,nobs,beta,se,tz,p \
--geno 0.05 \
--mind 0.05 \
--maf 0.01 \
--hwe 1e-6 \
--vif 1000 \
--pheno common_pheno.txt \
--covar common_cov.txt \
--covar-col-nums 3,4,5,6,7,8,9,10,11,12,13,14 \
--threads 140 \
--out traits_chr${i}
done

#for binary phenotype: add --1 in the script