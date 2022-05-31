# Direct run of germline_vaf_filter.cwl with data `GATK_INDEL`
VCF=/data/call-bcftools_normalize_gatk_indel/execution/output.normalized.vcf.gz

OUT="/results/germline_vaf_filter.GATK_INDEL.vcf"

# min_vaf = 0.2
# max_vaf = 1
ARGS="-m 0.2 -x 1.0 -c GATK"

cd ../..
CMD="bash src/run_germline_vaf_filter.sh $@ $ARGS -o $OUT $VCF"

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
