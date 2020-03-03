
OUTD="/data/VLD_FilterVCF.out"
mkdir -p $OUTD

VCF="/data/GATK.indel.Final.vcf"
CONFIG="../../params/VLD_FilterVCF-GATK.config.ini"

OUT="$OUTD/GATK.indel.VLD.vcf"

bash ../../src/run_vaf_length_depth_filters.sh $@ $VCF $CONFIG

