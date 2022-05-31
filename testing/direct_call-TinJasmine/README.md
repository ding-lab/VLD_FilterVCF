Currently testing on katmai, with test data on /home/mwyczalk_test/Projects/GermlineCaller/C3L-00001

To start, do,

bash ./0_start_docker.sh /home/mwyczalk_test/Projects/GermlineCaller/C3L-00001

TODO: provide test data which can be distributed (1000 Genomes?)

Testing the following filters:
* `vaf_filter` - Filters VCF files according to tumor, normal VAF values
  * `/opt/VLD_FilterVCF/src/vaf_filter.py`
  * GATK implemented
* `length_filter` - Filters VCF files according to indel length:
  * `/opt/VLD_FilterVCF/src/length_filter.py`
  * does not have caller argument
* `depth_filter` - Filters VCF files according to tumor, normal read depth
  * `/opt/VLD_FilterVCF/src/depth_filter.py`
  * GATK is calculated same way as mutect
* `allele_depth_filter` - Filters VCF files according to allelic depth for alternate allele
  * `/opt/VLD_FilterVCF/src/allele_depth_filter.py`
  * has "VCF" or "varscan" as caller, and handling of remapped varscan is described

Each of these will be tested with script `src/run_vaf_length_depth_filters.sh` on the following datasets:
* GATK
  * `/data/GATK.indel.Final.vcf`
  * `/data/GATK.snp.Final.vcf`
* varscan
  * `/data/varscan_remapped/varscan.indel.vcf-remapped.vcf`
  * `/data/varscan_remapped/varscan.snp.vcf-remapped.vcf`
* pindel
  * `/data/pindel_sifted.out.CvgVafStrand_pass.Homopolymer_pass.vcf`


TODO: use FFPE_Filter as model

Discussion
    /home/mwyczalk_test/Projects/TinDaisy/modules/FFPE_Filter-dev/README.md

Local implementation:
    /home/m.wyczalkowski/Projects/CWL-dev/FFPE_Filter-dev/FFPE_Filter/testing/direct_call


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
