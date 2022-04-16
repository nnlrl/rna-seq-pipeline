rule get_genome:
    input:
        config["ref"]["genome"]
    output:
        "resources/genome.fasta"
    log:
        "logs/get_genome.log"
    cache: True
    # params:
    #     species=config["ref"]["species"],
    # script:
    #     "../scripts/get_genome.py"
    shell:
        "zcat {input} > {output}"


rule get_annotation:
    input:
        config["ref"]["annotation"]
    output:
        "resources/genome.gtf"
    log:
        "logs/get_annotation.log"
    cache: True
    # params:
    #     species=config["ref"]["species"],
    #     fmt="gtf",
    #     assembly=config["ref"]["assembly"],
    # script:
    #     "../scripts/get_annotation.py"
    shell:
        "zcat {input} > {output}"


rule genome_faidx:
    input:
        "resources/genome.fasta",
    output:
        "resources/genome.fasta.fai",
    log:
        "logs/genome-faidx.log",
    cache: True
    conda:
        "../envs/samtools.yaml"
    script:
        "../scripts/samtools-faidx.py"


rule bwa_index:
    input:
        "resources/genome.fasta",
    output:
        multiext("resources/genome.fasta", ".amb", ".ann", ".bwt", ".pac", ".sa"),
    log:
        "logs/bwa_index.log",
    resources:
        mem_mb=369000,
    cache: True
    conda:
        "../envs/bwa.yaml"
    script:
        "../scripts/bwa-index.py"


rule star_index:
    input:
        fasta="resources/genome.fasta",
        annotation="resources/genome.gtf"
    output:
        directory("resources/star_genome"),
    threads: 4
    params:
        extra="--sjdbGTFfile resources/genome.gtf --sjdbOverhang 100",
    log:
        "logs/star_index_genome.log",
    cache: True
    conda:
        "../envs/star.yaml"
    script:
        "../scripts/star-index.py"
