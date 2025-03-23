process extract_umis {

    input:
      tuple val(meta), path(bam)

    output:
      tuple val(meta), path("*withUMI.bam"), emit: umibam

    script:

      def read_group  = "${meta.sample}.${meta.flowcell}.${meta.lane}"
      if (meta.single_end) {
        """
        echo "Single end reads with ExtractUmisFromBam is unsupported"
        """
      } else {
        """
        fgbio ExtractUmisFromBam \\
          --input=${bam} \\
          --output=${umibam} \\
          --read-structure=8M143T 8M143T \\
          --molecular-index-tags=ZA ZB \\
          --single-tag=RX
        """
      }
}