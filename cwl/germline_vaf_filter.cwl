class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: germline_vaf_filter
baseCommand:
  - /bin/bash
  - /opt/VLD_FilterVCF/src/run_germline_vaf_filter.sh
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
    doc: optional filter configuration file with `germline_vaf` section
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
  - id: min_vaf
    type: float?
    inputBinding:
      position: 0
      prefix: '-m'
    doc: Retain sites where VAF > min_vaf
  - id: max_vaf
    type: float?
    inputBinding:
      position: 0
      prefix: '-x'
    doc: Retain sites where VAF <= max_vaf
  - id: caller
    type: string?
    inputBinding:
      position: 0
      prefix: '-c'
    doc: >-
      specifies tool used for variant call. 'strelka', 'varscan', 'pindel',
      'merged', 'mutect', 'GATK'
outputs:
  - id: output
    type: File
    outputBinding:
      glob: germline_vaf_filter.output.vcf
doc: |-
  Filter VCF files according to VAF values.
  Include only variants with min_vaf < VAF <= max_vaf.
  For multi-sample VCFs this criterion is applied to all samples.
label: Germline VAF Filter
arguments:
  - position: 0
    prefix: '-o'
    valueFrom: germline_vaf_filter.output.vcf
requirements:
  - class: ResourceRequirement
    ramMin: 2000
  - class: DockerRequirement
    dockerPull: 'mwyczalkowski/vld_filter_vcf:20201001'
  - class: InlineJavascriptRequirement
