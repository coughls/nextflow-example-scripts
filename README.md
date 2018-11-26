

# nextflow-example-scripts

## sending-channel-of-false-results-to-file-example.nf

Split a channel into two channels based on a True/False stdout result 
-> 1 true and 1 false channel

Report contents of false channel in a csv file

To run 

```shell
nextflow run sending-channel-of-false-results-to-file-example.nf
```

## To see how using quotes in bash can deal with spaces in filenames 

First make two files in your directory 

```shell
touch 'test.txt'
touch 'test 2.txt'
```

Then try this script which will fail 

```shell
nextflow run spaces-in-filenames-failing-example.nf 
```

Try the script below which should complete


```shell
nextflow run spaces-in-filenames-passing-example.nf
```


To deal with spaces in filenames, add quotes - for example instead of 


```
process foo {


    script:
    """
    wc -l $txt_file > ${filename}.num_lines.txt 
    """

}
```

 
do
 
 ```
process foo { 


    script:
    """
    wc -l "$txt_file" > "${filename}.num_lines.txt"
    """
    
}
```
 

