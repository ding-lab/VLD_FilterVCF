class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: somatic_vaf_filter
baseCommand:
  - /bin/bash
  - /opt/VLD_FilterVCF/src/run_somatic_vaf_filter.sh
inputs:
  - id: debug
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-e'
    label: Debug
    doc: Filter debug mode
  - id: VCF
    type: File
    inputBinding:
      position: 1
    label: VCF
    doc: VCF input file to filter
  - id: remove_filtered
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-R'
    doc: >-
      Remove filtered variants.  Default is to retain filtered variants with
      filter name in VCF FILTER field
  - id: bypass
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-E'
    label: Bypass filter
  - id: min_vaf_tumor
    type: float?
    inputBinding:
      position: 0
      prefix: '-m'
    doc: Retain sites where tumor VAF > min_vaf_tumor
  - id: max_vaf_normal
    type: float?
    inputBinding:
      position: 0
      prefix: '-x'
    doc: Retain sites where normal VAF <= max_vaf_normal
  - id: caller
    type: string?
    inputBinding:
      position: 0
      prefix: '-c'
    doc: >-
      specifies tool used for variant call. 'strelka', 'varscan', 'mutect', 'pindel', 'merged'
outputs:
  - id: output
    type: File
    outputBinding:
      glob: somatic_vaf_filter.output.vcf
doc: |-
  Filter VCF files according to tumor, normal VAF values
label: Somatic VAF Filter
arguments:
  - position: 0
    prefix: '-T'
    valueFrom: TUMOR
  - position: 0
    prefix: '-N'
    valueFrom: NORMAL
  - position: 0
    prefix: '-o'
    valueFrom: somatic_vaf_filter.output.vcf
requirements:
  - class: ResourceRequirement
    ramMin: 2000
  - class: DockerRequirement
    dockerPull: 'mwyczalkowski/vld_filter_vcf:20220611'
  - class: InlineJavascriptRequirement
