


####======================================================================================================
##  another attempt at using GEOquery   ----------------------------------------
#---------------------------------------------------------------------------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

#geoid=c("GSE56623","GSE76664","GSE36509","GSE54218","GSE68690","GSE26791","GSE47346","GSE26792","GSE36444")
geoid=read.delim('/Data/ks/geo_dat/indat/drug_geo_match_id.txt',header=F)
	colnames(geoid)=c('id','drug')
geoid=geoid[grepl("GSE",geoid$id),]


#dtb_path='/Users/ks/Dropbox/proj/geo_query'
dtb_path='/Data/ks/geo_dat'

geoid=geoid[!(geoid$id%in%c('GSE26791','GSE71127','GSE51428','GSE46502','GSE1056','GSE7184','GSE56','GSE1417','GSE9286','GSE2451')),]

Head(geoid)

stuffs=list()
#for(idat in geoid$id[35:length(geoid$id)]){
for(idat in geoid$id){
	stuffs[[idat]]=geo.matrix(idat,path=dtb_path)	
}



idat
which(geoid$id==idat)


geset=stuffs
# save(geset,file=paste0(dtb_path,'/drug_geo_match_id.Rdata'))









####======================================================================================================
##     ----------------------------------------
#---------------------------------------------------------------------------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝
dtb_path='/Data/ks/geo_dat'
Load(paste0(dtb_path,'/drug_geo_match_id.Rdata'))


dstat=unlist(lapply(geset,function(x){nrow(x$expr)}))
	matst(dstat)


#https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE37357&format=file


setwd('/Data/ks/scrap')


system(paste0('wget -r -nH --cut-dirs=7 https://www.ncbi.nlm.nih.gov/geo/download/?acc=',datid,'&format=file'))


	
geset=geset!names(geset)%in%'GSE26792'] 		##  contains an expression matrix of NA

pdf(paste0(dtb_path,'/out/img/clust.aldat.pdf'),height=10,width=12)

for(idat in names(geset)){
	cat('\t■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■   ',idat,'    ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■\n')

#	Head(geset[[idat]]$expr)
#
#	print(as.data.frame(colnames(geset[[idat]]$expr)))
	holder=geset[[idat]]$expr

#	if(nrow(holder)>1000){
	if(!is.null(holder)){
		clust(list(dat=holder),dat_descr=idat)

	}
	
}

is.missing((geset[[idat]]$expr))

dev.off()


annot.combine<-function(expr_mat,annot_mat,annot_from,annot_to,combine_method='median')





pdf(paste0(dtb_path,'/out/img/clust.',idat,'.pdf'),height=10,width=12)

molder=list()
idat='GSE20631'
	holder=geset[[idat]]$expr
	molder$one=holder[,1:3]
	molder$two=holder[,4:6]
	molder$tre=holder[,7:9]

	clust(molder)



dev.off()









##  getting raw data.. 
setwd('/Data/ks/scrap/raw')
getwd()

dtb_path='/Data/ks/scrap'

datid='GSE68355'
system(paste0("wget -O ",datid,".tar 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=",datid,"&format=file'"))  		##  -O re-name the file since auto-generated name is annoying & a pontential problem  ||    using quotes for cmd to circumvent mis-interpretation of the link

system(paste0('tar -xvf ',datid,'.tar'))

zipnam=list.files(pattern='.gz')

for(ifle in zipnam){
	system(paste0('gzip -d ',ifle))
}
s
#system(paste0("wget 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=",datid,"&format=file'"))		##  -O re-name the file since auto-generated name is annoying & a pontential problem  ||    using quotes for cmd to circumvent mis-interpretation of the link
#holder=read.zip(paste0(dtb_path,'/',datid,'.gz'))



















