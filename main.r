##main
argv <- commandArgs(TRUE)
ratio <- as.numeric(argv[1])
pos.file <- as.character(argv[2])
neg.file <- as.character(argv[3])
##
##
##
pos = read.table(pos.file)
neg = read.table(neg.file)
# pos = read.table('te_enh.txt')
# pos = data.frame(x = pos[,1])
# neg = read.table('te_pro.txt')
# neg = data.frame(x = neg[,1])
##
source('process.data.R')
process.data()
## for parameter
# source('libsvm.for.parameter.R')
# libsvm.for.parameter()
##
## alternative choose
source('libsvm.R')
libsvm(4,0.03125)


