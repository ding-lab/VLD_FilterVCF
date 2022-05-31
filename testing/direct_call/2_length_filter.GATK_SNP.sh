# length_filter with data `GATK_SNP
# max_length = 100
# min_length = 0 
VCF=/data/call-bcftools_normalize_gatk_snp/execution/output.normalized.vcf.gz

OUT="/results/length_filter.GATK_SNP.vcf"

ARGS="-m 0 -x 100"
#-m min_length: Retain sites where indel length > given value
#-x max_length: Retain sites where indel length <= given value. 0 disables test

cd ../..
CMD="bash src/run_length_filter.sh $@ $ARGS -o $OUT $VCF"

#-h: Print this help message
#-d: Dry run - output commands but do not execute them
#-o OUT_VCF: Output VCF.  Default writes to STDOUT
#-e: filter debug mode
#-E: filter bypass
#-R: remove filtered variants.  Default is to retain filtered variants with filter name in VCF FILTER field
#-m min_vaf: Retain sites where VAF > min_vaf
#-x max_vaf: Retain sites where VAF <= max_vaf
#-c caller: specifies tool used for variant call. 'strelka', 'varscan', 'pindel', 'merged', 'mutect', 'GATK'


>&2 echo Running: $CMD
eval $CMD

rc=$?
if [[ $rc != 0 ]]; then
    >&2 echo Fatal ERROR $rc: $!.  Exiting.
    exit $rc;
fi

>&2 echo Success.  Written to $OUT
