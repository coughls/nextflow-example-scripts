#!/usr/bin/env nextflow

params.outdir = "./RESULTS"

input_ch = Channel.from(1,2,3,4,5)
//input_ch.println()

process filter_process {

    input: 
    val x from input_ch 

    output: 
    set stdout, x into output_ch 

    script:
    if( x >=3 ) {
    """
    #!/bin/bash
    printf "True"
    """     
    }
    else {
    
    """
    #"/bin/bash
    printf "False"
    """
     }     
}

/*
 * Filter to keep only true results from output_ch
 */

false_ch = Channel.create()
true_ch = Channel.create()

output_ch.choice( true_ch, false_ch ) { a -> a[0] =~ /^True.*/ ? 0 : 1 }

false_ch.into{false_ch1; false_ch2} 
false_ch1.println()

//use true channel in some other process

/*
 * Send info on each task in channel to a file 
 */

process create_fail_file{

    tag "$status - $num"

    input:
    set status, num from false_ch2

    output:
    file("*.fail.csv") into fail_file_ch 

    script:
    """
    echo "$status", "$num" > "${num}.fail.csv"
    """
}

/* 
 *Collect all files  
 */

process collect_fail_files{

    publishDir "${params.outdir}/", mode: 'copy'

    input:
    file("*") from fail_file_ch.collect()

    output:
    file("all_fail.csv") into fail_file_collect_ch

    script:
    """
    #!/bin/bash 
    cat * > all_fail.csv
    """

}

