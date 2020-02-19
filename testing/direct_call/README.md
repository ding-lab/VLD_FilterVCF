Currently testing on katmai, with test data on /home/mwyczalk_test/Projects/GermlineCaller/C3L-00001

To start, do,

bash ./0_start_docker.sh /home/mwyczalk_test/Projects/GermlineCaller/C3L-00001

TODO: provide test data which can be distributed (1000 Genomes?)

Testing the following filters:
* `vaf_filter` - Filters VCF files according to tumor, normal VAF values
  * `/opt/VLD_FilterVCF/src/vaf_filter.py`
* `length_filter` - Filters VCF files according to indel length:
  * `/opt/VLD_FilterVCF/src/length_filter.py`
* `depth_filter` - Filters VCF files according to tumor, normal read depth
  * `/opt/VLD_FilterVCF/src/depth_filter.py`
* `allele_depth_filter` - Filters VCF files according to allelic depth for alternate allele
  * `/opt/VLD_FilterVCF/src/allele_depth_filter.py`

Each of these will be tested on the following datasets:
* GATK
  * `/data/GATK.indel.Final.vcf`
  * `/data/GATK.snp.Final.vcf`
* varscan
  * `/data/varscan_remapped/varscan.indel.vcf-remapped.vcf`
  * `/data/varscan_remapped/varscan.snp.vcf-remapped.vcf`
* pindel
  * `/data/pindel_sifted.out.CvgVafStrand_pass.Homopolymer_pass.vcf`

Also, test the combined script
  * `/opt/VLD_FilterVCF/src/run_vaf_length_depth_filters.sh`
