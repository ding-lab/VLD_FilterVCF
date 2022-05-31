Testing the following filters:
* `germline_vaf_filter` - Filters VCF files according to tumor, normal VAF values
* `length_filter` - Filters VCF files according to indel length:
* `germline_depth_filter` - Filters VCF files according to tumor, normal read depth
* `allele_depth_filter` - Filters VCF files according to allelic depth for alternate allele

For TinJasmine, testing 
  * germline_vaf_filter.cwl with data `GATK_INDEL`
  * length_filter.cwl with data `GATK_SNP`
  * germline_depth_filter.cwl with data `PINDEL`
  * allele_depth_filter.cwl with data `VARINDEL`
and workflow 
  * VLDA_Filter-germline.cwl with data `VARSNP`

where files obtained from previous TinJasmine run (workflow root WD) as,
    GATK_INDEL=$WD/call-bcftools_normalize_gatk_indel/$F
    GATK_SNP=$WD/call-bcftools_normalize_gatk_snp/$F
    PINDEL=$WD/call-bcftools_normalize_pindel/$F
    VARINDEL=$WD/call-bcftools_normalize_varscan_indel/$F
    VARSNP=$WD/call-bcftools_normalize_varscan_snp/$F
with 
    F=execution/output.normalized.vcf.gz

Here, WD=/storage1/fs1/m.wyczalkowski/Active/cromwell-data/cromwell-workdir/cromwell-executions/TinJasmine.cwl/020f0455-9d82-4da7-aee3-00408f91a822

Directory direct_call-TinDaisy has older scripts. Shouild all be merged
