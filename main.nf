#!/usr/bin/env nextflow
/*
========================================================================================
    kaitlinchaung/nomad
========================================================================================
    Github : https://github.com/kaitlinchaung/nomad

----------------------------------------------------------------------------------------
*/

nextflow.enable.dsl = 2

/*
========================================================================================
    GENOME PARAMETER VALUES
========================================================================================
*/


/*
========================================================================================
    VALIDATE & PRINT PARAMETER SUMMARY
========================================================================================
*/

WorkflowMain.initialise(workflow, params, log)

/*
========================================================================================
    NAMED WORKFLOW FOR PIPELINE
========================================================================================
*/

include {ELEMENT_ANNOTATIONS } from './workflows/element_annotations'

//
// WORKFLOW: Run main kaitlinchaung/nomad analysis pipeline
//

workflow RUN_NOMAD {

    // Run pipeline
    ELEMENT_ANNOTATIONS ()

}

/*
========================================================================================
    RUN ALL WORKFLOWS
========================================================================================
*/

//
// WORKFLOW: Execute a single named workflow for the pipeline
// See: https://github.com/nf-core/rnaseq/issues/619
//
workflow {
    RUN_NOMAD ()
}

/*
========================================================================================
    THE END
========================================================================================
*/
