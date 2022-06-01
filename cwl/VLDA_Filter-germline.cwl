class: Workflow
cwlVersion: v1.0
id: vlda_filter_germline
label: VLDA_Filter_Germline
inputs:
  - id: VCF
    type: File
  - id: vaf_caller
    type: string?
    doc: >-
      specifies tool used for variant call. 'strelka', 'varscan', 'pindel',
      'merged', 'mutect', 'GATK'
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
        default: 0
      - id: max_length
        default: 100
    out:
      - id: output
    run: ./length_filter.cwl
    label: Length Filter
  - id: germline_vaf_filter
    in:
      - id: VCF
        source: VCF
      - id: min_vaf
        default: 0.2
      - id: max_vaf
        default: 1
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
        default: 0
      - id: min_allele_depth_alternate
        default: 5
      - id: caller
        source: allele_depth_caller
    out:
      - id: output
    run: ./allele_depth_filter.cwl
    label: Allele Depth Filter
  - id: depth_filter
    in:
      - id: VCF
        source: length_filter/output
      - id: min_depth
        default: 8
    out:
      - id: output
    run: ./germline_depth_filter.cwl
    label: Depth Filter
requirements: []
