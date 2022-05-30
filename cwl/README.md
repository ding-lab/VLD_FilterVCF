VLD_FilterVCF.cwl - this is older version being used for TinJasmine which has one script for all filters


Individual filters:
    allele_depth_filter.cwl
    germline_depth_filter.cwl
    somatic_depth_filter.cwl
    germline_vaf_filter.cwl
    somatic_vaf_filter.cwl
    length_filter.cwl
TinDaisy has the somatic depth, somatic vaf, and length filters implemented separately.

VLDA_Filter-germline.cwl is an updated workflow for TinJasmine which calls germline vaf, length, germline depth, and allele depth
filters independently.  It is designed to replace VLD_FilterVCF
