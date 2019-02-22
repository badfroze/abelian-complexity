unc = c('A','T','C','G')
tetranuc = data.frame(0)
for (x in 1:4){
	xx = unc[x]
	for (y in 1:4){
		yy = unc[y]
		for (z in 1:4){
			zz = unc[z]
			for (a in 1:4){
				aa = unc[a]
				tetra = paste0(xx,yy,zz,aa)
				num = 64*(x - 1) + 16*(y - 1) + 4*(z - 1) + a
				tetranuc[num,1] = tetra
			}
		}
	}
}
for (w in 1:256){     
	tetranuc[w,2] = w
}
pa = read.table('parameter_110.txt')
load('an.Rdata')
##col1 feature number col2 acc col3 auc col4 mcc
sx = pa[order(pa[,3]),]
num = sx[1:100,1]
ab = abel_num[num[which(num <= 209)]]
n4 = num[which(num > 209)] - 209
tt = tetranuc[n4,]
