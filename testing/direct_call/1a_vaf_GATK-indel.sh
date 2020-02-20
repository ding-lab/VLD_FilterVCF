
OUTD="/data/VLD_FilterVCF.out"
mkdir -p $OUTD

FILTER="/opt/VLD_FilterVCF/src/vaf_filter.py"
VCF="/data/GATK.indel.Final.vcf"

OUT="$OUTD/GATK.indel.VLD.vcf"

/usr/local/bin/python $FILTER $@ --input $VCF --output $OUT

echo Written to $OUT
