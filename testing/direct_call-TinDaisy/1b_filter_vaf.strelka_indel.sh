OUTD="/results"
mkdir -p $OUTD

INPUT="/data/call-somatic_vaf_filter_strelka_indel/inputs/-525167129/somatic.indels.vcf.gz"

OUT="$OUTD/somatic_vaf-strelka_indel-filtered.vcf"

# -m min_vaf_tumor: Retain sites where tumor VAF > than given value (aka min_vaf_somatic)
# -x max_vaf_normal: Retain sites where normal VAF <= than given value (aka max_vaf_germline)
# -c caller: specifies tool used for variant call. 'strelka', 'varscan', 'mutect', 'pindel', 'merged'
# -T tumor_name: Tumor sample name in VCF
# -N normal_name: Normal sample name in VCF

ARGS="-m 0.05 -x 0.02 -c strelka -T TUMOR -N NORMAL"

CMD="bash ../../src/run_somatic_vaf_filter.sh $@ $ARGS -o $OUT $EXCLUDE $INPUT"

>&2 echo Running $CMD
eval $CMD

