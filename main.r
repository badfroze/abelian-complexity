##main
argv <- commandArgs(TRUE)
# ratio <- as.numeric(argv[1])
# pos.file <- as.character(argv[2])
# neg.file <- as.character(argv[3])
##
# pos.abel = read.table('abel_enh_10646.txt')
# pos.263 = read.table('263_enh_10646.txt')
# neg.abel = read.table('165772_non_enhancer_abel_feature.txt')
# neg.263 = read.table('165772_non_enhancer_263_feature.txt')
##
##
pv = load('pv.Rdata')#me
d  = which(me[17:500] > 20) + 16
##
##
pos.abel = read.table('abel_enhancer_seq_4653_to.fasta')
pos.263 = read.table('263_enhancer_seq_4653.txt')
neg.abel= read.table('non_xxxx_union_1000.txt')
neg.263 = read.table('49248_non_enhancer_263_feature.txt')
pos = cbind(pos.abel[,d],pos.263[,1:257])
neg = cbind(neg.abel[,d],neg.263[,1:257])
##
##
pos = pos[sample(nrow(pos),4000),]
neg = neg[sample(nrow(neg),40000),]
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


