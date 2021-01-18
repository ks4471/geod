


####======================================================================================================
##  another attempt at using GEOquery   ----------------------------------------
#---------------------------------------------------------------------------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

dtb_path='/Data/ks/GEO/'
geoid=read.delim(paste0(dtb_path,'/ref/geo_dat_summary.txt'),header=T)
	str(geoid)
	matst(geoid$type)

geoid=geoid[geoid$type=='Expression profiling by array',]	##  only taking microarray data atm - and its the only type of data in experiment



stuffs=list()

#idat=geoid$id[1]
#datid=idat
#path=dtb_path


for(idat in unique(geoid$id)){
	stuffs[[idat]]=try(geo.matrix(datid=idat,path=dtb_path))
#	stuffs[[idat]]=geo.matrix(datid=idat,path=dtb_path)
}

dummy=unlist(lapply(stuffs, class))
	matst(dummy)


#GSE26791 man check the downloaded file

gset=stuffs[dummy=='list']
gann=geoid
#
save(gset,gann,file=paste0(dtb_path,'/ref/drug_geo_match_id.Rdata'))











#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝
dtb_path='/Data/ks/geoq/'
Load(paste0(dtb_path,'/dtb/ref/drug_geo_match_id.Rdata'))
	matst(names(gset)%in%gann$id)
##  remove data with now 'expression' provided


for(idat in names(gset)){
	write.delim(gset[[idat]]$samp,file=paste0(dtb_path,'/dtb/working/',idat,'_samp_info.txt'))
}




holder=unlist(lapply(gset,function(x){nrow(x$expr)}))
	matst(holder)
holder=unlist(lapply(gset,function(x){ncol(x$expr)}))
	matst(holder)

	matst(gsub('.*latform: (.*) .* Samples','\\1',gann$platforms))
#	matst(gsub('.*latform: (.*) .* Samples','\\1',gann$platforms)==gann$platform)
#	cbind(gsub('.*latform: (.*) .* Samples','\\1',gann$platforms),gann$platform)	##  gann$platform wrong, done using inferior knowledge of gsub() at the time

gann$platform=gsub('.*latform: (.*) .* Samples','\\1',gann$platforms)
	gann$platform












#curl -o GPL16686.txt 'https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?view=data&acc=GPL16686&id=17306&db=GeoDb_blob94'
#curl -o GPL1456.txt 'https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?view=data&acc=GPL1456&id=11315&db=GeoDb_blob92'
#curl -o GPL169.txt 'https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?view=data&acc=GPL169&id=10174&db=GeoDb_blob03'
#curl -o GPL4790.txt 'https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?view=data&acc=GPL4790&id=42511&db=GeoDb_blob09'
#curl -o GPL5953.txt https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?view=data&acc=GPL5953&id=22495&db=GeoDb_blob19



























####======================================================================================================
##   experimental code  ----------------------------------------
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



















