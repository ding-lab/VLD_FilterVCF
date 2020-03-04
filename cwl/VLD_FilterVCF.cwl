class: CommandLineTool
cwlVersion: v1.0
id: VLD_FilterVCF
baseCommand:
  - /bin/bash
  - /opt/VLD_FilterVCF/src/run_vaf_length_depth_filters.sh
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '--input'
    label: VCF file
  - id: output
    type: string
    inputBinding:
      position: 0
      prefix: '--output'
    label: output VCF file name
outputs:
  - id: remapped_VCF
    type: File
    outputBinding:
      glob: $(inputs.output)
label: VLD_FilterVCF
requirements:
  - class: DockerRequirement
    dockerPull: 'mwyczalkowski/vld_filter_vcf:latest'   # will want to update this to a fixed tag
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 2000

