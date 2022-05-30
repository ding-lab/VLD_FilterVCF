class: Workflow
cwlVersion: v1.0
id: _v_l_d_a__filter_germline
label: VLDA_Filter_Germline
inputs:
  - id: VCF
    type: File
  - id: min_vaf
    type: float?
  - id: max_vaf
    type: float?
  - id: vaf_caller
    type: string?
    doc: >-
      specifies tool used for variant call. 'strelka', 'varscan', 'pindel',
      'merged', 'mutect', 'GATK'
  - id: min_length
    type: int?
  - id: max_length
    type: int?
  - id: min_depth
    type: int?
  - id: min_allele_depth_reference
    type: float?
  - id: min_allele_depth_alternate
    type: float?
  - id: allele_depth_caller
    type: string?
    doc: Anticipated format of AD field.  Values "VCF" or "varscan"
outputs:
  - id: output
    outputSource:
      allele_depth_filter/output
    type: File
steps:
  - id: length_filter
    in:
      - id: VCF
        source: germline_vaf_filter/output
      - id: min_length
        source: min_length
      - id: max_length
        source: max_length
    out:
      - id: output
    run: ./length_filter.cwl
    label: Length Filter
  - id: depth_filter
    in:
      - id: VCF
        source: length_filter/output
      - id: min_depth
        source: min_depth
    out:
      - id: output
    run: ./germline_depth_filter.cwl
    label: Depth Filter
  - id: germline_vaf_filter
    in:
      - id: VCF
        source: VCF
      - id: min_vaf
        source: min_vaf
      - id: max_vaf
        source: max_vaf
      - id: caller
        source: vaf_caller
    out:
      - id: output
    run: ./germline_vaf_filter.cwl
    label: Germline VAF Filter
  - id: allele_depth_filter
    in:
      - id: VCF
        source: depth_filter/output
      - id: min_allele_depth_reference
        source: min_allele_depth_reference
      - id: min_allele_depth_alternate
        source: min_allele_depth_alternate
      - id: caller
        source: allele_depth_caller
    out:
      - id: output
    run: ./allele_depth_filter.cwl
    label: Allele Depth Filter
requirements: []
