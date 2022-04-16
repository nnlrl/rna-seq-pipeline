rule align:
    input:
        unpack(get_fq),
        index="resources/star_genome"
    output:
        bam="results/star/{sample}-{unit}/Aligned.sortedByCoord.out.bam",
        reads_per_gene="results/star/{sample}-{unit}/ReadsPerGene.out.tab",
        log="results/star/{sample}-{unit}/Log.out"
    log:
        "logs/star/{sample}-{unit}.log",
    params:
        index=lambda wc, input: input.index,
        extra="--outSAMtype BAM SortedByCoordinate --quantMode GeneCounts --sjdbGTFfile {} {}".format(
            "resources/genome.gtf", config["params"]["star"]
        ),
    threads: 24
    conda:
        "../envs/star.yaml"
    script:
        "../scripts/star-align.py"

rule samtools_index:
    input:
        "results/star/{sample}-{unit}/Aligned.sortedByCoord.out.bam",
    output:
        "results/star/{sample}-{unit}/Aligned.sortedByCoord.out.bam.bai",
    log:
        "logs/samtools/index/{sample}-{unit}.log",
    params:
        extra="",  # optional params string
    threads: 4  # This value - 1 will be sent to -@
    conda:
        "../envs/samtools.yaml"
    script:
        "../scripts/samtools-index.py"
