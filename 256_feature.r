argv <- commandArgs(TRUE)
input <- as.character(argv[1])
output <- as.character(argv[2])
#256 feature
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
	tetranuc[w,2] = 0
}
#
#
#list.files
library(stringr)
# name = list.files()
# for (n in 1:length(name)){
	# file.name = name[n]
sequ = read.table(input)
for (ii in 1:nrow(sequ)){
	mat = tetranuc
	fasta = as.character(sequ[ii,])
	fh = substr(fasta,1,1)
	if (fh != '>'){
		fasta = toupper(as.character(sequ[ii,]))
		#256
		for (j in 1:(nchar(fasta) - 3)){
			temp = substr(fasta,j,(j + 3))
			lo = which(mat[,1] == temp)
			mat[lo,2] = as.numeric(mat[lo,2]) + 1
		}
		mat = mat[,2]/(nchar(fasta) - 3)
		#8
		aa = str_locate_all(fasta,'A')
		aa = nrow(aa[[1]])
		tt = str_locate_all(fasta,'T')
		tt = nrow(tt[[1]])
		cc = str_locate_all(fasta,'C')
		cc = nrow(cc[[1]])
		gg = str_locate_all(fasta,'G')
		gg = nrow(gg[[1]])
		cg = (cc + gg)/nchar(fasta)
		# cgi = cg/(cc*gg*nchar(fasta))
		# if (cc == 0){
			# cgi = 0
		# }
		# if (gg == 0){
			# cgi = 0
		# }
		m1 = abs(cc - gg)/nchar(fasta)
		m2 = abs(aa - tt)/nchar(fasta)
		m3 = aa/tt
		if (tt == 0){
			m3 = 0
		}
		m4 = cc/gg
		if (gg == 0){
			m4 = 0
		}
		m5 = cc*gg/nchar(fasta)
		m6 = aa*tt/nchar(fasta)
		m = c(cg,m1,m2,m3,m4,m5,m6)
		#cbind
		final = t(c(mat,m))
		write.table(final, file = output, append = T, quote = F, row.names = F, col.names = F)
	}
}
# }
