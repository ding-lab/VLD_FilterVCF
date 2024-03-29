class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: depth_filter
baseCommand:
  - /bin/bash
  - /opt/VLD_FilterVCF/src/run_germline_depth_filter.sh
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
  - id: min_depth
    type: int?
    inputBinding:
      position: 0
      prefix: '-m'
    doc: Retain sites where read depth > min_depth
  - id: caller
    type: string
    inputBinding:
      position: 0
      prefix: '-c'
    doc: 'specifies tool used for variant call. ''GATK'', ''varscan'', ''pindel'''
outputs:
  - id: output
    type: File
    outputBinding:
      glob: germline_depth_filter.output.vcf
doc: |-
  Filter VCF files according to read depth
  For multi-sample VCFs this criterion is applied to all samples
label: Germline Depth Filter
arguments:
  - position: 0
    prefix: '-o'
    valueFrom: germline_depth_filter.output.vcf
requirements:
  - class: ResourceRequirement
    ramMin: 2000
  - class: DockerRequirement
    dockerPull: 'mwyczalkowski/vld_filter_vcf:20220611'
  - class: InlineJavascriptRequirement
