class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: length_filter
baseCommand:
  - /bin/bash
  - /opt/VLD_FilterVCF/src/run_length_filter.sh
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
  - id: min_length
    type: int?
    inputBinding:
      position: 0
      prefix: '-m'
    doc: Retain sites where indel length > given value
  - id: max_length
    type: int?
    inputBinding:
      position: 0
      prefix: '-x'
    doc: Retain sites where indel length <= given value. 0 disables test
outputs:
  - id: output
    type: File
    outputBinding:
      glob: length_filter.output.vcf
doc: >-
  Filter VCF files according to indel length.

  Retain calls where length of variant and reference > min_length and <
  max_length 
label: Length Filter
arguments:
  - position: 0
    prefix: '-o'
    valueFrom: length_filter.output.vcf
requirements:
  - class: ResourceRequirement
    ramMin: 2000
  - class: DockerRequirement
    dockerPull: 'mwyczalkowski/vld_filter_vcf:20220531'
  - class: InlineJavascriptRequirement
