# standard settings for each file..
options(stringsAsFactors=F)
rm(list=ls())
ls()
t0=Sys.time()

library(colorout)
#`·._ .·  `·. _ .·  `·._ .·  `·. _ .·  `·._ .·  `·. _ .·  `·.. 
source("~/Dropbox/SHARED/tools/R_functions/000.R_functions.R")  #╣║╚╣═╣║╚╣║║║╚╣╔╣╔╣║╚╣═╣╔╗║╚╚╣║╚╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝



####-----------------------------------------------------------------------------------------------------------
###   parse file
##

#dt=readLines("~/Dropbox/PROJ/NatNeuro/dtb/secondary/gds_result.txt")
#dt=readLines("~/Dropbox/PROJ/NatNeuro/dtb/secondary/brain_refined37_arrayExpr20151028.txt")

# datasets and series - GEO classifications for datasets
#dat=readLines("~/Dropbox/PROJ/NatNeuro/dtb/secondary/brain_datasets_filt_skip1_20151030.txt")
#ser=readLines("~/Dropbox/PROJ/NatNeuro/dtb/secondary/brain_series_filt_skip1_20151030.txt")

dat=readLines("~/Dropbox/PROJ/NatNeuro/dtb/secondary/geo_brain_human_only_datasets.txt")
ser=readLines("~/Dropbox/PROJ/NatNeuro/dtb/secondary/geo_brain_human_only_series.txt")
	dat=dat[-1]
	ser=ser[-1]
# 150 entries
	dat[1:8]
# 1757 entries
	ser[1:8]
# data structures as slightly different (mostly concerning location of GSE:) => parse separately


grep("GSE46706",dat)


ind=as.data.frame((which(ser=="")))
	colnames(ind)="ind"

ind$idx=c(0,ind[-nrow(ind),"ind"])
ind$dif=ind$ind-ind$idx

matst(ind$dif)


#dt=c(dat,ser)
#ind=which(dt=="")
serl=list()
k=0
for(ient in 1:length(ind$ind)){
	serl[[ient]]=((ser[k:(ind$ind[ient]-1)]))
	k=ind$ind[ient]+1

}


ser8=t(as.data.frame(serl[which(ind$dif==8)]))
	colnames(ser8)=1:ncol(ser8)
	rownames(ser8)=1:nrow(ser8)
	Head(ser8)

ser9=t(as.data.frame(serl[which(ind$dif==9)]))
	colnames(ser9)=1:ncol(ser9)
	rownames(ser9)=1:nrow(ser9)
	Head(ser9)



ind=as.data.frame((which(dat=="")))
	colnames(ind)="ind"

ind$idx=c(0,ind[-nrow(ind),"ind"])
ind$dif=ind$ind-ind$idx

matst(ind$dif)
#dt=c(dat,ser)
#ind=which(dt=="")
serl=list()
k=0
for(ient in 1:length(ind$ind)){
	serl[[ient]]=((dat[k:(ind$ind[ient]-1)]))
	k=ind$ind[ient]+1

}


sern=t(as.data.frame(serl))
	colnames(sern)=1:ncol(sern)
	rownames(sern)=1:nrow(sern)
	Head(sern)



####-----------------------------------------------------------------------------------------------------------
###   extract info and merge
##

# descr
# n 	 		# n.samples
# type 			# type of dataset eg RNAseq, microarray, Methylation
# id 			# GSE id
# class : classification based on Disease / Healthy / Other (search based on descr)

head(ser8)

dat=as.data.frame(ser8[,1])
	colnames(dat)="descr"
library(stringr)
dat$n=gsub(" Sampl.*","",str_extract(ser8[,5], " [0-9]+ Sampl.*"))
#dat$samples=gsub(" Sampl.*","",str_extract(ser8[,5], " [0-9]+ Sampl.*"))
dat$id=str_extract(ser8[,7], "GSE[0-9]+")
dat$type=gsub("Type:\t\t","",ser8[,4])
dat$org=gsub("Organism:\t","",ser8[,3])
dat$full=ser8[,2]

rm(ser8)

inf=dat
	Head(inf)
#	head(ser9)

dat=as.data.frame(ser9[,1])
	colnames(dat)="descr"
library(stringr)
dat$n=gsub(" Sampl.*","",str_extract(ser9[,6], " [0-9]+ Sampl.*"))
#dat$samples=gsub(" Sampl.*","",str_extract(ser9[,5], " [0-9]+ Sampl.*"))
dat$id=str_extract(ser9[,8], "GSE[0-9]+")
dat$type=gsub("Type:\t\t","",ser9[,5])
dat$org=gsub("Organism:\t","",ser9[,4])
dat$full=ser9[,2]
	rm(ser9)

inf=rbind(inf,dat)
	Head(inf)
#	head(sern)

dat=as.data.frame(sern[,1])
	colnames(dat)="descr"
library(stringr)
dat$n=gsub(" Sampl.*","",str_extract(sern[,5], " [0-9]+ Sampl.*"))
#dat$samples=gsub(" Sampl.*","",str_extract(sern[,5], " [0-9]+ Sampl.*"))
dat$id=str_extract(sern[,5], "GSE[0-9]+")
dat$type=gsub(",.*","",gsub("Type:\t\t","",sern[,4]))
dat$org=gsub("Organism:\t","",sern[,3])
dat$full=sern[,2]

inf=rbind(inf,dat)
	Head(inf)
inf$n=as.numeric(inf$n)

inf$class="other"


types=as.data.frame(c(
	
	" .ealthy"
	," .ontrol"
	," .ormal"
	," .atabase"
	," .isease"
	," .isorder"
	," .yndrom"
	,".eurodegenerative"
	,".arkinson."
	,".chizophren"
	,".ett "
	,".ultiple .clerosis"
	,".myotrophic .ateral .clerosis|ALS"
	,".pilepsy"
	,".ipolar .isorder"
	,".lzheimer"
	," .utis"
	,".ajor .epress"
	," .own.*yndrom"
	,".ental .etardation"
	,"untington"
	
	," .umor"
	," .ancer"
	," .lioma"
	," .strocytoma"
	," .lioblastoma"
	," .arcoma"
	," .edulloblastoma"
	," .lood"
	," .eart"
	," .pithelial"
	," .irus"
	))
colnames(types)="search"
types$full=c(
	"Healthy"
	,"Healthy"
	,"Healthy"
	,"Database"
	,"other.disease/disorder"
	,"other.disease/disorder"
	,"other.disease/disorder"
	,"Neurodegenerative.disease"
	,"Parkinson's"
	,"Schizophrenia"
	,"Rett"
	,"Multiple.Sclerosis"
	,"Amyotrophic.Lateral.Sclerosis"
	,"Epilepsy"
	,"Bipolar"
	,"Alzheimer"
	,"Autism"
	,"Major.Depressive"
	,"Downs"
	,"Mental.Retardation"
	,"Huntington's"
	
	,"Tumor"
	,"Tumor"
	,"Tumor"
	,"Tumor"
	,"Tumor"
	,"Tumor"
	,"Tumor"
	,"Blood"
	,"Heart"
	,"Epithelial"
	,"Virus"

	)
types$short=c(
	"HLY"
	,"HLY"
	,"HLY"
	,"DTB"
	,"CSE"
	,"CSE"
	,"CSE"
	,"NDD"
	,"PD"
	,"SCZ"
	,"RS"
	,"MS"
	,"ALS"
	,"EE"
	,"BP"
	,"AD"
	,"ASD"
	,"MDD"
	,"DWN"
	,"MRD"
	,"HTD"

	
	,"TMR"
	,"TMR"
	,"TMR"
	,"TMR"
	,"TMR"
	,"TMR"
	,"TMR"
	,"BLD"
	,"HRT"
	,"SKN"
	,"VRS"
	)



"Creutzfeldt"
"motor neuron disease"
"Obsessive Psychiatric Syndromes"
"neurodegenerative diseases"
"Cerebral Palsy"
"Timothy syndrome"


# check full info for 'brain' keyword
inf[grep(" .rain",inf[,"full"]),"class"]="Brain"
inf[grep(" .ancer",inf[,"full"]),"class"]="Tumor"
inf[grep(" .ell .ine",inf[,"full"]),"class"]="Cell Line"
inf[grep(" .tem .ell",inf[,"full"]),"class"]="Cell Line"
inf[grep(" .luripotent",inf[,"full"]),"class"]="Cell Line"
	matst(inf$class)
#inf[inf$class=="Brain",1]


for(ityp in 1:nrow(types)){
	cat("------------------------",types$short[ityp],"------------------------\n")
	print(inf[grep(types$search[ityp],inf[,1]),1])
	inf[grep(types$search[ityp],inf[,1]),"class"]=types$full[ityp]
}


rm(dat)
dat=inf[grep(".xpression",inf$type),]
	dim(dat)
	
dat=dat[dat$n>122,]
	matst(dat$class)
	dim(dat)


#write.delim(dat,"~/Dropbox/PROJ/NatNeuro/dtb/secondary/brain_diseaseOnly_n>122_20151103.txt")


#inf[inf$class=="other",1]
matst(inf$class)


inf[inf$id %in% c("GSE60863","GSE60862","GSE46706"),]

inf[grep(" .own's",inf[,1]),1]

inf[inf$class=="other disease/disorder",1]
#inf[inf$class=="other",1]





inf[inf$class=="Healthy" & inf$n>122 ,1]
inf[grep(".xon-level",inf[,1]),]
GSE60863


pdf("~/Dropbox/PROJ/NatNeuro/dtb/secondary/brain_filt_skip1_20151030.pdf",paper="a4")

info=inf[grep("xpression",inf$type),]
hist(as.numeric(info$n),breaks=100,main="full")
	abline(v=122,col="dodgerblue")
boxplot(as.numeric(info$n),breaks=100,pch=16,main="full")
	points(x=1,y=122,col="dodgerblue",pch=16)

sum(as.numeric(info$n)>122)

info=info[!(info$class%in%c("other","Healthy")),]
hist(as.numeric(info$n),breaks=100,main="disease only")
	abline(v=122,col="dodgerblue")
boxplot(as.numeric(info$n),breaks=100,pch=16,main="disease, only")
	points(x=1,y=122,col="dodgerblue",pch=16)

sum(as.numeric(info$n)>122)

dev.off()




#write.delim(inf[as.numeric(info$n)>122,],"~/Dropbox/PROJ/NatNeuro/dtb/secondary/brain_diseaseOnly_n>122_20151030.txt")
write.delim(matst(inf$type),"~/Dropbox/PROJ/NatNeuro/dtb/secondary/brain_dataset_types.txt")

##>>>>>>>>>>>>>>>>>>>>>>>>>>>>  93. Temporal lobe epilepsy and Alzheimer's disease   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## RBFOX1 Splicing and Transcriptional Regulation in Neurons
## "23. DNA methylation profiles of human brain tissue samples" 
## "30. Methylomic trajectories across human fetal brain development"
## "45. Gene expression in primate postnatal brain through lifespan"
## "54. microRNA expression in human brain development"
## "56. RNA sequencing of transcriptomes in human brain regions: protein-coding and non-coding RNAs, isoforms and alleles"




# extra columns appear to be due to extra annotation
#ser[grep("Project: ",ser)]
#ser=ser[-grep("Project: Roadmap Epigenomics",ser)]
#
#ser=ser[-grep("Project: ENCODE",ser)]
#ser=gsub("\t","",ser)
#length(ser)/8

#ser=t(as.data.frame(serl))
#	dim(ser)

#
#ser=list.as.df(serl)
#ser=gsub(",","",ser)

#write.delim(ser,"~/Dropbox/PROJ/NatNeuro/dtb/secondary/brain_series_mat.txt",row.names=F,col.names=F)


#matrix(dat,ncol=8,byrow=T)

#sem=matrix(ser,ncol=8,byrow=T) # not all entres are 8 rows... sadly

#which(dat=="")-c(0,which(dat=="")[-length(which(dat==""))])
#dummy=matrix(which(dat==""),ncol=2,byrow=T)
#matst(dummy[,1]-dummy[,2])


# extract n.samples
geo=list(n.samples=as.numeric(gsub(" ","",pos)))

pos=ser[grepl("(?=.*Platform)(?=.* Samples)",ser,perl=T)]
library(stringr)
pos=gsub(" Samples","",str_extract(pos, " [0-9]+ Samples"))
pos=gsub(" ","",pos)

geo$n.samples=c(geo$n.samples,pos)
length(geo$n.samples)
483+38



###	basically goes in increments of 7 as each dataset has 7 rows of 'descriptions'
##	 - a large number of samples at the end do not have any 'DataSets' info, appears to be a single sample
##	 - may be more effective to index from 'DataSets' ie -2 etc to specify only datasets with relevant info
#pod=grep("(Submitter supplied)",dt,perl=T)-1
#poi=grep("(Submitter supplied)",dt,perl=T)
#pos=dt[grep(" Samples",dt,perl=T)]
pos=dt[grepl("(?=.*Platform)(?=.* Samples)",dt,perl=T)]
library(stringr)
pos=gsub(" Samples","",str_extract(pos, " [0-9]+ Samples"))
pos=gsub(" ","",pos)


pog=dt[grepl("(?=.*Platform)(?=.* Samples)",dt,perl=T)]
library(stringr)
pog=str_extract(pog, "GSE.* ")
pog=gsub(" .*","",pog)

pod=dt[which(grepl("(?=.*Platform)(?=.* Samples)",dt,perl=T))-4]
pod=gsub("\t","",pod)

poi=dt[which(grepl("(?=.*Platform)(?=.* Samples)",dt,perl=T))-1]
poi=substr(poi,40,nchar(poi)-2)

geo=as.data.frame(list(info=pod,geo=pog,n.sampl=pos,design=poi))
	Head((geo))



geo$disease=("other")
geo$disease[grep(".lzheimer",geo$info)]="AD"
geo$disease[grep(".arkinson",geo$info)]="PD"
geo$disease[grep(".ipolar",geo$info)]="BP"
geo$disease[grep(".chizophrenia",geo$info)]="SZ"
geo$disease[grep(".ett syndrome",geo$info)]="RS"
geo$disease[grep(".ultiple .clerosis",geo$info)]="MS"

#poi=gsub('"Type:\t\t\"',"",poi)
#poi=gsub("\t","",poi)
#poi=gsub("Type:","",poi)


#poa=grep("Accession",dt,perl=T)

#'([0-9])([[:alpha:]])'
#[[:alnum:]]
pod=strsplit(gsub("[^[:alpha:] ]", "", pod), " +")
pod=gsub("\t","",pod)





pod=pos-3
poi=pos-2
poa=pos+2

head(dt[pos])
head(dt[poi])

dat=as.list(datasets=gsub(" DataSets.*","",dt[pos]))
dat$seriesdat=gsub(" Series.*","",gsub(".*DataSets ","",dt[pos]))
dat$samples=gsub(" Samples.*","",gsub(".*Platform. ","",dt[pos]))




gsub(".*Series ","",(gsub(".*Platforms ","",(gsub(".*Platform ","",dt[pos]))))
pos=grep(paste("(?=.*",paste(enrich_type,collapse="|"),")",sep=""),mod,perl=T)


527 DataSets 4080 Series 54 Related Platforms 114924 Samples
Platform: GPL8490 724 Samples
4 related Platforms 354 Samples
Platforms: GPL9052 GPL9115 208 Samples
Platform: GPL570 Series: GSE25507 146 Samples



#Use the new stringr package which wraps all the existing regular expression operates in a consistent syntax and adds a few that are missing:
library(stringr)
#str_locate("aaa12xxx", "[0-9]+")
#      start end
# [1,]     4   5


#str_extract("aaa12xxx", "[0-9]+")
# [1] "12"
#str_extract_all(dat, pattern)

enrich_type=1:3
mod_names=c("a","c")

paste("(?=.*",enrich_type,")","(?=.*",paste(mod_names,collapse="|"),")",sep="")














