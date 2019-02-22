Hybrid abelian-complexity features extraction and implementation SVM
-------------------------------------------------------------------------------

# dependencies #

* Libsvm tools for linux

_The library for support vector machine can be download at site https://www.csie.ntu.edu.tw/~cjlin/libsvm/_

# usage #

## use commands ##

There are 2 main functions in this work: extract hybrid abelian-complexity features and run support vector machine.

Extract hybrid abelian-complexity features: getting abelian-complexity features and tetra-nucleotide frequency features from a fasta file  
```
Rscript abel.r start end input output
#start and end refer to the responding fasta sequence position and the input file is fasta format
Rscript 256_feature.r input output
```

Run support vector machine: run this machine learning tools by libsvm and output the parameters
```
Rscript main.r ratio pos.file neg.file
#ratio refer to the ratio between positive sample and negative sample
```


## notice ##

1.Beyond the R script code to extract abelian complexity features, actually we give an python code which is more efficiency.

```
python abel-python.py input output 
```

2.The process.data.R input the features extracted and process into lib-svm style.

3.The final two R script used to implementation SVM by lib-svm, of which one is for parameters optimization on the basis of accuracy and AUC etc., another is for the main process and finally output all the machine learning parameters for exhibition.
