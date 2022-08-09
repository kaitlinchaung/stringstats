include { TRIMGALORE                } from '../../modules/nf-core/modules/trimgalore/main'
include { FETCH_ANCHORS             } from '../../modules/local/fetch_anchors'
include { COUNT_ANCHORS             } from '../../modules/local/count_anchors'
include { STRATIFY_ANCHORS          } from '../../modules/local/stratify_anchors'
include { GET_ABUNDANT_ANCHORS      } from '../../modules/local/get_abundant_anchors'
include { MERGE_ABUNDANT_ANCHORS    } from '../../modules/local/merge_abundant_anchors'
include { COMPUTE_PVALS             } from '../../modules/local/compute_pvals'
include { SIGNIFICANT_ANCHORS       } from '../../modules/local/significant_anchors'


workflow FETCH {

    take:
    ch_fastqs
    lookahead

    main:

    if (params.run_trimming) {
        /*
        // Trim fastqs
        */
        TRIMGALORE(
            ch_fastqs
        )
        ch_fastqs = TRIMGALORE.out.fastq
    }

    /*
    // Process to get all candidate anchors and targets
    */
    FETCH_ANCHORS(
        ch_fastqs,
        params.is_10X,
        params.num_reads_first_pass,
        params.kmer_size,
        lookahead,
        params.anchor_mode,
        params.window_slide

    )

    /*
    // Process to count anchors and targets
    */
    COUNT_ANCHORS(
        FETCH_ANCHORS.out.seqs
    )

    /*
    // Process to stratify counts files by 3mers
    */
    STRATIFY_ANCHORS(
        COUNT_ANCHORS.out.seqs.collect(),
        params.stratify_level
    )

    // Do not proceed with TTT file if in RNAseq mode
    if (params.is_RNAseq) {
        ch_stratified_anchors = STRATIFY_ANCHORS.out.seqs
            .flatten()
            .filter {
                it -> !file(it).name.contains("TTT")
            }

    } else {
        ch_stratified_anchors = STRATIFY_ANCHORS.out.seqs.flatten()

    }

    /*
    // Process to filter kmer counts for abundant anchors
    */
    GET_ABUNDANT_ANCHORS(
        ch_stratified_anchors,
        params.anchor_count_threshold,
        params.kmer_size
    )

    abudant_seqs                    = GET_ABUNDANT_ANCHORS.out.anchor_counts
    abundant_stratified_anchors     = GET_ABUNDANT_ANCHORS.out.seqs

    if (params.run_decoy) {
        MERGE_ABUNDANT_ANCHORS(
            abudant_seqs,
            params.num_decoy_anchors
        )

        anchors_pvals   = MERGE_ABUNDANT_ANCHORS.out.seqs
        anchors_Cjs     = Channel.empty()


    } else {
        /*
        // Process to get significant anchors and their scores
        */
        COMPUTE_PVALS(
            abundant_stratified_anchors,
            params.kmer_size,
            file(params.input),
            params.K_num_hashes,
            params.L_num_random_Cj,
            params.anchor_count_threshold,
            params.anchor_unique_targets_threshold,
            params.anchor_samples_threshold,
            params.anchor_sample_counts_threshold,
            params.anchor_batch_size
        )

        /*
        // Process to output top 5000 anchors as sorted by pvalue
        */
        SIGNIFICANT_ANCHORS(
            COMPUTE_PVALS.out.scores.collect(),
            params.fdr_threshold,
            file(params.input)
        )

        anchors_pvals   = SIGNIFICANT_ANCHORS.out.scores
            .filter{
                it.countLines() > 1
            }

        anchors_Cjs     = SIGNIFICANT_ANCHORS.out.cjs

    }

    emit:
    anchors_pvals               = anchors_pvals
    anchors_Cjs                 = anchors_Cjs
    abundant_stratified_anchors = abundant_stratified_anchors.collect()

}
