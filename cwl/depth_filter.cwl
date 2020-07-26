class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: depth_filter
baseCommand:
  - /bin/bash
  - /opt/VLD_FilterVCF/src/run_depth_filter.sh
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
  - id: config
    type: File?
    inputBinding:
      position: 0
      prefix: '-C'
    label: config
    doc: optional filter configuration file with `depth` section
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
    type: float?
    inputBinding:
      position: 0
      prefix: '-m'
    doc: Retain sites where read depth > min_depth
outputs:
  - id: output
    type: File
    outputBinding:
      glob: depth_filter.output.vcf
doc: |-
    Filter VCF files according to read depth
    For multi-sample VCFs this criterion is applied to all samples
label: Depth Filter
arguments:
  - position: 0
    prefix: '-o'
    valueFrom: depth_filter.output.vcf
requirements:
  - class: ResourceRequirement
    ramMin: 2000
  - class: DockerRequirement
    dockerPull: 'mwyczalkowski/vld_filter_vcf:20200725'
  - class: InlineJavascriptRequirement
