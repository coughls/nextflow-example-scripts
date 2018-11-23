#!/usr/bin/env nextflow

params.files="./*.txt"

files_ch = Channel
    .fromPath(params.files)
    .ifEmpty { error "Cannot find any files matching: ${params.files}" }
    .map { file -> tuple(file.name - ~/.txt$/ , file) } 

files_ch.into { files_ch_1; files_ch_2 }

files_ch_1.println()

process test_noquotes {

   tag "$filename"

    input:
    set filename, file(txt_file) from files_ch_2

    output: 
    file("${filename}.num_lines.txt") into files_out

    script:
    """
    wc -l $txt_file > ${filename}.num_lines.txt 
    """
 
}

files_out.println()
