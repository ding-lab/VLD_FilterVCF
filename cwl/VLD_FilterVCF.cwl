class: CommandLineTool
cwlVersion: v1.0
id: vld_filter_vcf
baseCommand:
  - /bin/bash
  - /opt/VLD_FilterVCF/src/run_vaf_length_depth_filters.sh
inputs:
  - id: dryrun
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-d'
    label: dryrun
    doc: Output commands but do not execute them
  - id: no_pipe
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-N'
    label: No Pipe
    doc: Write out intermediate VCFs rather than using pipes for debugging
  - id: debug_VAF
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-e'
    label: Debug VAF
    doc: VAF filter debug mode
  - id: bypass_VAF
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-E'
    label: Bypass VAF
    doc: VAF filter bypass mode
  - id: debug_length
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-f'
    label: Debug length
    doc: Length filter debug mode
  - id: bypass_length
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-F'
    label: Bypass length
    doc: Length filter bypass mode
  - id: debug_depth
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-g'
    label: Debug depth
    doc: Depth filter debug mode
  - id: bypass_depth
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-G'
    label: Bypass depth
    doc: Depth filter bypass mode
  - id: debug_allele_depth
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-j'
    label: Debug allele depth
    doc: Allele depth filter debug mode
  - id: bypass_allele_depth
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-G'
    label: Bypass allele depth
    doc: Allele depth filter bypass mode
  - id: VCF
    type: File
    inputBinding:
      position: 1
    label: VCF
    doc: VCF input file to filter
  - id: config
    type: File
    inputBinding:
      position: 2
    label: config
    doc: configuration file used by all filters
outputs:
  - id: output
    type: File
    outputBinding:
      glob: VLD_FilterVCF_output.vcf
label: VLD_FilterVCF
arguments:
  - position: 0
    prefix: '-o'
    valueFrom: VLD_FilterVCF_output.vcf
  - position: 0
    prefix: '-s'
    valueFrom: SAMPLE
requirements:
  - class: ResourceRequirement
    ramMin: 2000
  - class: DockerRequirement
    dockerPull: 'mwyczalkowski/vld_filter_vcf:latest'
  - class: InlineJavascriptRequirement
