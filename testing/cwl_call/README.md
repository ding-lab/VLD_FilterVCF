
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

# Setup
Currently using file-based cromwell database for one-off runs
Testing based on https://github.com/ding-lab/VEP_annotate.git

## WORKFLOW_ROOT
Prior to running, be sure to update the template Cromwell configuration to point to an appropirate work directory, which will
typically be different for each user.  As an example, for user `m.wyczalkowski`, the destination directory may be,
    WORKFLOW_ROOT="/scratch1/fs1/dinglab/m.wyczalkowski/cromwell-data"

Specifically,
* Create `$WORKFLOW_ROOT` if it does not exist
    * Also create `$WORKFLOW_ROOT/logs`
* `cp dat/cromwell-config-db.compute1-filedb.template.dat dat/cromwell-config-db.compute1-filedb.dat`
* Edit `dat/cromwell-config-db.compute1-filedb.dat` to replace all instances of the string WORKFLOW_ROOT with the
  appropriate value

# Starting

Can run directly from command line and make sure terminal stays open.  This is the easiest and good for initial
testing
```
bash 0_start_docker-compute1_cromwell.sh
bash 1_run_cromwell_demo.sh
```

This can also be run in tmux session or submitted via bsub

