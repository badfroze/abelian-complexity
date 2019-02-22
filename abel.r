argv <- commandArgs(TRUE)
start <- as.numeric(argv[1])
end <- as.numeric(argv[2])
input <- as.character(argv[3])
output <- as.character(argv[4])
# i = start
fasta = read.table(input)
for (i in start:end){
	temp = as.character(fasta[i,1])
	cd = nchar(temp)
	if (substr(temp,1,1) != '>'){
		temp = toupper(temp)
		abel = c()
		for (j in 1:cd){#
			win = j
			mat = array(0,dim = c((cd - win + 1),4))
			for (k in 1:(cd - win + 1)){#
				tem = substr(temp,k,(k + win - 1))#
				aa = 0
				at = 0
				ac = 0
				ag = 0
				for (m in 1:win){#
					te = substr(tem,m,m)
					if (te == 'A'){
						aa = aa + 1
					}
					if (te == 'T'){
						at = at + 1
					}
					if (te == 'C'){
						ac = ac + 1
					}
					if (te == 'G'){
						ag = ag + 1
					}
				}
				count = c(aa,at,ac,ag)#
				mat[k,] = count
			}
			mat = unique(mat)
			counting = nrow(mat)
			abel[j] = counting
		}
		write.table(t(abel),file = output,append = T,quote = F,row.names = F,col.names = F)
	}
	else{
		next
	}
}
