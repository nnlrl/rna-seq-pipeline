# Snakemake workflow: rna-seq-star-deseq2

- 使用`STAR`进行比对并计数
- 使用`RSEQC`进行fastq文件的质控,并用`multiqc`生成报告
- 使用`DESeq2`进行差异分析

RNA-seq 流程, 将fastq文件存放于sra

## Usage

```
# 创建运行所需的conda环境
snakemake --use-conda --conda-create-envs-only -j 10 -p

# 运行
snakemake --use-conda --cache -j 10 -p

# 生成report
snakemake --report report.html
```

修改自<https://github.com/snakemake-workflows/rna-seq-star-deseq2>
