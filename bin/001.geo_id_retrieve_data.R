


####======================================================================================================
##  scRNA-seq brain datasets   -------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

gsid=unique(toupper(c("gse74672","gse85721")))	## "gse82187" ,"gse71585" contain multiple platforms - not currently compatible with geo.matrix

in_path='/Data/geo_query/dtb/raw/'



lprogr<-function(xvar,xful){
	cat(xvar,which(xful==xvar),'of',length(xful),'\n')
}




geo.matrix<-function(datid,path){
##  USE: download GEO matrix data and process into smth usable
cur_dir=getwd()
datid=toupper(datid)
#	dir.create(paste0(path,'/dtb/'))
#	dir.create(paste0(path,'/dtb/',datid))
	dir.create(paste0(path,'/',datid))
#	dir.create(file.path(path,'dtb',datid))

#	paste0(path,'/dtb/',datid)
	#setwd(file.path(path,'dtb',datid))
	setwd(file.path(paste0(path,'/',datid)))
	getwd()

	system(paste0('wget -r -nH --cut-dirs=7 ftp://ftp.ncbi.nlm.nih.gov/geo/series/',substr(datid,1,5),'nnn/',datid,'/matrix/'))

#	system(paste0('wget -r -nH --cut-dirs=7 https://www.ncbi.nlm.nih.gov/geo/download/?acc=',datid,'&format=file'))
	# -r 								##  recursively Dounload
	# -nH (--no-host-directories)		##  cuts out hostname 
	# --cut-dirs=X 						##  (cuts out X directories)

	system(paste0('gunzip ',datid,'_series_matrix.txt.gz'))
#	list.files()

	gse=readLines(file.path(paste0(path,'/',datid,'/',datid,'_series_matrix.txt')))

	cord=c(
		grep('!Sample_title',gse)
		,grep('!series_matrix_table_begin',gse)
		,grep('!series_matrix_table_end',gse)
	)

	meta=as.data.frame(strsplit(gse[1:(cord[1]-2)],'\t'))
		colnames(meta)=meta[1,]
		meta=t(meta[-1,])
	samp=as.data.frame(strsplit(gse[cord[1]:(cord[2]-1)],'\t'))
	for(icol in colnames(samp)){
		samp[,icol]=(gsub('"','',samp[,icol],fixed=T))
	}
		colnames(samp)=samp[1,]
		samp=samp[-1,]
		colnames(samp)=(gsub('"','',colnames(samp),fixed=T))
		colnames(samp)=(gsub('!Sample_','',colnames(samp),fixed=T))

		rownames(samp)=samp$geo_accession
#		Head(samp)
	cat('\t',datid,'contains phenotype data for',nrow(samp),'samples\n')



	expr=as.data.frame(strsplit(gse[(cord[2]+1):(cord[3]-1)],'\t'))
		colnames(expr)=as.character(expr[1,])
		rownames(expr)=as.character(expr[,1])
		expr=t(expr[-1,-1])


		if(nrow(expr)==0){
			cat('\t\tno expression data available\n')
			return(invisible(list(samp=samp,meta=meta)))
		}

	    if(nrow(expr)>0){
	cat('\t',datid,'contains expression data for',ncol(expr),'samples\n')
#	expr=as.data.frame(strsplit(gse[(cord[2]+1):(cord[3]-1)],'\t'))
#		colnames(expr)=as.character(expr[1,])
#		rownames(expr)=as.character(expr[,1])
#		expr=t(expr[-1,-1])

	expr=make.numeric(expr)
		rownames(expr)=(gsub('"','',rownames(expr),fixed=T))
		colnames(expr)=(gsub('"','',colnames(expr),fixed=T))
		Head(expr)


	overlap(rownames(samp),colnames(expr))

	samp=samp[colnames(expr),]
		colnames(expr)=gsub(' ','.',samp$title)


			cat('\t\texpression data available,',nrow(expr),' genes\n')
setwd(cur_dir)
			return(invisible(list(expr=expr,samp=samp,meta=meta)))
		}


}

geom=list()
for(igeo in gsid){
	lprogr(igeo,gsid)
	geom[[igeo]]=geo.matrix(toupper(igeo),in_path)$samp	##  function updated - auto-convert to upper - but not yet in github	

}




	Head(geom)
	Head(geom[[1]]$samp)
	Head(geom[[2]]$samp)

geom[[1]]$treatment_protocol_ch1






















