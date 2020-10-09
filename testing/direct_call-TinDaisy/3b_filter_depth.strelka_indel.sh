OUTD="/results"

# Processing output of step vaf filter
INPUT="$OUTD/length-strelka_indel-filtered.vcf"
OUT="$OUTD/depth-strelka_indel-filtered.vcf"

#-m min_depth_tumor: Retain sites where read depth for tumor > given value
#-M min_depth_normal: Retain sites where read depth for normal > given value
#-c caller: specifies tool used for variant call. 'strelka', 'varscan', 'pindel', 'mutect'
#-T tumor_name: Tumor sample name in VCF
#-N normal_name: Normal sample name in VCF

#min_depth_tumor = 14
#min_depth_normal = 8
#tumor_name = TUMOR
#normal_name = NORMAL
#caller = varscan

ARGS="-m 14 -M 8 -c varscan -T TUMOR -N NORMAL"

CMD="bash ../../src/run_somatic_depth_filter.sh $@ $ARGS -o $OUT $EXCLUDE $INPUT"

>&2 echo Running $CMD
eval $CMD

