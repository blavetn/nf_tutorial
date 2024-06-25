#! /usr/bin/env nextflow

  println "\nI want to BLAST $params.query to $params.dbDir/$params.dbName using $params.threads CPUs and output it to $params.outdir\n"

  process runBlast {
    conda '/wrappers/blast/env.yaml'

    script:
    """
    blastn  -num_threads 2 -db $PWD/DB/blastDB -query $PWD/input.fasta -outfmt 6 -out input.blastout
    """
  }

  if (params.genome) {
  process runMakeBlastDB {
    conda '/wrappers/blast/env.yaml'
    script:
    """
    makeblastdb -in ${params.genome} -dbtype 'nucl' -out $dbDir/$dbName
    """
  }

  println "It worked"
  exit 0
}
