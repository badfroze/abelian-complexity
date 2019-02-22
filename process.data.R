process.data <- function(){
	###process the data
	##############################################
	#2018.01.12 by chengchao wu
	############################################## read sample
	############################################
	ratio  = 1 #ratio equals the proportion of training sample druing the whole original sample, for example, pos:neg is 1:1, ratio is 0.5; pos:neg is 9:1 
	############################################# standardize
	temp = rbind(pos,neg)
	tem = matrix(nrow = nrow(temp),ncol = ncol(temp))
	n = ncol(temp)
	for (s in 1:n){
		ja = scale(temp[,s],center = T, scale = T)
		ja = as.matrix(ja)
		tem[,s] = ja
	}
	############################################# figure out the positive sample and negative sample
	pos_scale = tem[1:nrow(pos),]
	neg_scale = tem[(nrow(pos) + 1):nrow(tem),]
	pos_train = pos_scale[1:floor(nrow(pos)*ratio),]
	neg_train = neg_scale[1:floor(nrow(neg)*ratio),]
	# pos_test = pos_scale[-(1:floor(nrow(pos)*ratio)),]
	# neg_test = neg_scale[-(1:floor(nrow(neg)*ratio)),]
	#############################################
	#pos
	for (p in 1:nrow(pos_train)){
		temp = pos_train[p,]
		sh = c(1)
		for (q in 1:n){
			set11 = temp[q]
			tempo = paste0(q,":",set11)
			sh = paste(sh,tempo)
		}
		write.table(sh, file = 'train.txt', append = T, quote = F, row.names = F, col.names = F)
	}
	# for (p in 1:nrow(pos_test)){
		# temp = pos_test[p,]
		# sh = c(1)
		# for (q in 1:n){
			# set11 = temp[q]
			# tempo = paste0(q,":",set11)
			# sh = paste(sh,tempo)
		# }
		# write.table(sh, file = 'test.txt', append = T, quote = F, row.names = F, col.names = F)
	# }
	# neg
	for (p in 1:nrow(neg_train)){
		temp = neg_train[p,]
		sh = c(-1)
		for (q in 1:n){
			set11 = temp[q]
			tempo = paste0(q,":",set11)
			sh = paste(sh,tempo)
		}
		write.table(sh, file = 'train.txt', append = T, quote = F, row.names = F, col.names = F)
	}
	# for (p in 1:nrow(neg_test)){
		# temp = neg_test[p,]
		# sh = c(-1)
		# for (q in 1:n){
			# set11 = temp[q]
			# tempo = paste0(q,":",set11)
			# sh = paste(sh,tempo)
		# }
		# write.table(sh, file = 'test.txt', append = T, quote = F, row.names = F, col.names = F)
	# }
}