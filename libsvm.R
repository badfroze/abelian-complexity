libsvm <- function(x,y){
	#R for SVM 
	#pwd for libsvm
	path1="/home/ccwu/data1/libsvm/libsvm-3.22/svm-train"
	path2="/home/ccwu/data1/libsvm/libsvm-3.22/svm-predict"
	############################################################
	num1 = ceiling(nrow(pos)*(1 - ratio))
	num2 = ceiling(nrow(neg)*(1 - ratio))
	############################################################
	write.table("C G ACC AUC MCC SEN SPE GM TP TN",file = "parameter.txt",append = F,quote = F,row.names = F,col.names = F)
	##
	ii = x
	jj = y
	##
	train = paste(path1,"-c",ii,"-g",jj,"-b","1","train.txt","model.txt")
	system(train)
	test = paste(path2,"-b","1","test.txt","model.txt","out.txt")
	system(test)
	#####################################################################
	out = read.table("out.txt",header = T)
	b = out#out
	auc_table = matrix(nrow = 102,ncol = 2)
	for (i in 1:100){#求TP FP
		temp = i/100
		n = 0
		for (j in 1:num1){
			if (b[j,2] > temp){
				n = n + 1
			}
		}
		n = n/num1
		m = 0
		for (k in ((num1 + 1):(num1 + num2))){
			if (b[k,2] > temp){
				m = m + 1
			}
		}
		m = m/num2
		auc_table[i,] = c(n,m)
	}
	auc_table[101,] = c(1,1)
	auc_table[102,] = c(0,0)
	write.table(auc_table,'AUC.txt',append = T,quote = F,row.names =F,col.names =F)
	point = auc_table
	pin = point[order(point[,1]),]
	x = pin[,2]
	y = pin[,1]
	mj = (x[2] - x[1])*y[1]
	for (z in 3:102){
		mj = mj + (x[z] - x[z-1])*y[z-1]
	}
	auc = mj
	#####################################################
	n = 0 #TP
	for (j in 1:num1){
		if (b[j,2] > 0.5){
			n = n + 1
		}
	}
	m = 0
	for (k in ((num1 + 1):(num1 + num2))){
		if (b[k,3] > 0.5){
			m = m + 1
		}	
	}
	acc = (m + n)/(num1 + num2)
	TP = n/num1
	TN = m/num2
	FP = 1 - TP
	FN = 1 - TN
	MCC = (TP*TN - FP*FN)/sqrt((TP + FP)*(TP + FN)*(TN + FP)*(TN + FN))
	SEN = TP/(FN + TP)
	SPE = TN/(TN + FP)
	PRE = TP/(TP + FP)
	REC = TP/(TP + FN)
	GM = sqrt(PRE*REC)
	tem = paste(ii,jj,acc,auc,MCC,SEN,SPE,GM,TP,TN)
	write.table(tem,'parameter.txt',append =T, quote =F, row.names =F,col.names =F)
}
