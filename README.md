# Updated software package [here](https://github.com/refresh-bio/SPLASH)

Since the initial release of this software package, we have worked with collaborators to develop an improved codebase for this project which is publicly available on github [here](https://github.com/refresh-bio/SPLASH). This builds on the following works:

Marek Kokot, Roozbeh Dehghannasiri, Tavor Baharav, Julia Salzman, and Sebastian Deorowicz.
[SPLASH2 provides ultra-efficient, scalable, and unsupervised discovery on raw sequencing reads](https://www.biorxiv.org/content/10.1101/2023.03.17.533189) 
bioRxiv (2023)
 
Kaitlin Chaung, Tavor Baharav,  Ivan Zheludev, Julia Salzman. [SPLASH: a statistical, reference-free genomic algorithm unifies biological discovery
](https://doi.org/10.1101/2022.06.24.497555), to appear in Cell (2023)
 
Tavor Baharav, David Tse, and Julia Salzman. 
[An Interpretable, Finite Sample Valid Alternative to Pearson’s X2 for Scientific Discovery](https://www.biorxiv.org/content/10.1101/2023.03.16.533008), bioRxiv (2023)

# Introduction

The pipeline is built using [Nextflow](https://www.nextflow.io), a workflow tool to run tasks across multiple compute infrastructures in a very portable manner. It uses Docker/Singularity containers making installation trivial and results highly reproducible. The [Nextflow DSL2](https://www.nextflow.io/docs/latest/dsl2.html) implementation of this pipeline uses one container per process which makes it much easier to maintain and update software dependencies. Where possible, these processes have been submitted to and installed from [nf-core/modules](https://github.com/nf-core/modules) in order to make them available to all nf-core pipelines, and to everyone within the Nextflow community!

# NOMAD
A statistical, reference-free algorithm subsumes myriad problems in genome science and enables novel discovery

![nomad_1](https://github.com/salzmanlab/nomad/blob/main/assets/nomad_1.png?raw=true "Title")
![nomad_2](https://github.com/salzmanlab/nomad/blob/main/assets/nomad_2.png?raw=true "Title2")

# Prerequisites

1. Install Java.
2. Install [`nextflow`](https://nf-co.re/usage/installation) (`>=20.04.0`).
3. Depending on your use case, install [`conda`](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html#regular-installation), [`docker`](https://www.docker.com/), or [`singularity`](https://sylabs.io/guides/3.5/user-guide/introduction.html). By using the `docker` or `singularity` nextflow profile, the pipeline can be run within the NOMAD docker container (also available on [dockerhub](https://hub.docker.com/repository/docker/kaitlinchaung/stringstats), which contains all the required dependencies.

# Try the pipeline
To test this pipeine, use the command below. The `test` profile will launch a pipeline run with a small dataset.

How to run with singularity:
```bash
nextflow run salzmanlab/nomad \
    -profile test,singularity \
    -r main \
    -latest
```

How to run with docker:
```bash
nextflow run salzmanlab/nomad \
    -profile test,docker \
    -r main \
    -latest
```

How to run with conda:
```bash
nextflow run salzmanlab/nomad \
    -profile test,conda \
    -r main \
    -latest
```

# Usage
Please see this [document](https://github.com/salzmanlab/nomad/blob/main/docs/usage.md) for descriptions of NOMAD inputs and parameters.
# Outputs
Please see this [document](https://github.com/salzmanlab/nomad/blob/main/docs/output.md) for descriptions of NOMAD output.


# Citations

This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) initative, and reused here under the [MIT license](https://github.com/nf-core/tools/blob/master/LICENSE).

> The nf-core framework for community-curated bioinformatics pipelines.
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> Nat Biotechnol. 2020 Feb 13. doi: 10.1038/s41587-020-0439-x.
>

