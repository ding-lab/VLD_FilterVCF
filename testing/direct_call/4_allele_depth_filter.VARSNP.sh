# length_filter with data `GATK_SNP
# max_length = 100
# min_length = 0 
VCF=/data/call-bcftools_normalize_varscan_snp/execution/output.normalized.vcf.gz

OUT="/results/allele_depth_filter.VARSNP"

ARGS="-m 0 -M 5 -c VCF"

cd ../..
CMD="bash src/run_allele_depth_filter.sh $@ $ARGS -o $OUT $VCF"
#-h: Print this help message
#-d: Dry run - output commands but do not execute them
#-o OUT_VCF: Output VCF.  Default writes to STDOUT
#-e: filter debug mode
#-E: filter bypass
#-C CONFIG_FN: optional filter configuration file with `allele_depth` section
#-R: remove filtered variants.  Default is to retain filtered variants with filter name in VCF FILTER field
#-m min_depth_reference: Retain sites where reference allele depth > given value
#-M min_depth_alternate: Retain sites where alternate allele depth > given value
#-c caller: Anticipated format of AD field.  Values "VCF" or "varscan"


>&2 echo Running: $CMD
eval $CMD

rc=$?
if [[ $rc != 0 ]]; then
    >&2 echo Fatal ERROR $rc: $!.  Exiting.
    exit $rc;
fi

>&2 echo Success.  Written to $OUT
