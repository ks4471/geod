


####======================================================================================================
##  another attempt at using GEOquery   ----------------------------------------
#---------------------------------------------------------------------------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

options('download.file.method'='curl')

##  http://stackoverflow.com/questions/23028760/download-a-file-from-https-using-download-file
# install.packages("RCurl")
#library(RCurl)
#URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
#x <- getURL(URL)
## Or 
## x <- getURL(URL, ssl.verifypeer = FALSE)
#out <- read.csv(textConnection(x))
#head(out[1:6])




##  siple tutorial at :   https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE36509&format=file
#install.bioc('GEOquery')
# appears incapable of downloading anything
#
library(GEOquery)
#
dtb_path='/Users/ks/Dropbox/proj/geo_query'
gse=getGEO(GEO='GSE21653',destdir=dtb_path,GSEMatrix=TRUE,filename=NULL,GSElimits=NULL,AnnotGPL=FALSE,getGPL=TRUE)
#show(gse)

#gpl <- getGEO('GPL6887', destdir=".")
#Meta(gpl)$title


#filePaths=getGEOSuppFiles("GSE21653")
#filePaths
#dim(pData(gse[[1]]))
#head(pData(gse[[1]])[, 1:3])
#df1 <- getGSEDataTables("GSE3494")
#lapply(df1, head)




geoid=c("GSE56623","GSE76664","GSE36509","GSE54218","GSE68690","GSE26791","GSE47346","GSE26792","GSE36444")


stuffs=geo.matrix(geoid[1],path=dtb_path)




#
geo.matrix<-function(datid,path){
##  USE: download GEO matrix data and process into smth usable
	dir.create(paste0(path,'/dtb/',datid))
#	dir.create(file.path(path,'dtb',datid))

	paste0(path,'/dtb/',datid)
#	setwd(file.path(path,'dtb',datid))
#	getwd()

	system(paste0('wget -r -nH --cut-dirs=7 ftp://ftp.ncbi.nlm.nih.gov/geo/series/',substr(datid,1,5),'nnn/',datid,'/matrix/'))
	# -r 								##  recursively Dounload
	# -nH (--no-host-directories)		##  cuts out hostname 
	# --cut-dirs=X 						##  (cuts out X directories)

	system(paste0('gunzip ',datid,'_series_matrix.txt.gz'))
#	list.files()

	gse=readLines(file.path(path,'dtb',datid,paste0(datid,'_series_matrix.txt')))

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
			return(invisible(list(expr=expr,samp=samp,meta=meta)))
		}

}





geo.query<-function(file_loc){
	cat('\treading file\n')
##  INPUTS:  - location of the file downloaded from geo as 'query' for datasets / series / both
	arri=readLines(file_loc)

	pos=as.data.frame(grep('^[0-9]*[.] ',arri))	##  all entries start as: '1. ' '2. ' '3. '   etc..
		colnames(pos)='start'
	pos$end=c((pos$start[2:nrow(pos)]-1),length(arri))

	cat('\t',nrow(pos),'datasets detected\n')
	#nstat=list()
	cat('\t\tparsing entries\n')
	gdat=list()
	for(idat in 1:nrow(pos)){
		dummy=arri[pos[idat,'start']:pos[idat,'end']]
		dummy=dummy[dummy!='']

	#	grepl('Organism:',dummy)
	#	grepl('Type:',dummy)
	#	grepl('Platform:',dummy)
	#	grepl('download:',dummy)
	#	grepl('DataSet',dummy)

		if(length(dummy)==7){
			gdat[[paste0('n',idat)]]=as.data.frame(dummy)
		}
		lcount(idat,nrow(pos))
	##	nstat[[as.character(idat)]]=length(dummy) ## used to determine what the datasets look like, as below
	}

	cat('\n\t\tcleaning up\n')
	#nstat=t(as.data.frame(nstat))
	#matst(nstat)

	#names(nstat[nstat[,1]==6,])[1]
	#names(nstat[nstat[,1]==7,])[1]
	#names(nstat[nstat[,1]==8,])[1]
	gdat=t(as.data.frame(gdat))
#		Head(gdat)


	geod=as.data.frame(tolower(gdat[,1]))
		colnames(geod)='title'
	geod$full=tolower(gdat[,2])
	geod$organism=gsub('Organism:\t','',gdat[,3])
	geod$type=gsub('Type:\t\t','',gdat[,4])
#	geod$type=gsub('Type:\t\t','',gdat[,4])

	holder=strsplit(gdat[,5],' ')
	dummy=list()
	k=1
	for(idat in names(holder)){
		dummy[[idat]]=holder[[idat]][(length(holder[[idat]])-1)]
		k=lcount(k,length(holder))
	}

	geod$n=as.numeric(unlist(dummy))
	geod$platforms=gdat[,5]
	geod$ftp=gdat[,6]
	geod$ids=gdat[,7]

	rownames(geod)=1:nrow(geod)
	dummy=geod$ids
	geod$id=gsub('.*\t\tAccession: (G.*)\tID: (.*)','\\1',dummy)
	geod$otr=gsub('.*\t\tAccession: (G.*)\tID: (.*)','\\2',dummy)
	geod$ftp=gsub('.* (ftp:.*)','\\1',geod$ftp)
	dummy=geod$platforms
	geod$platform=gsub('Platform: (.*) (.*) Samples','\\1',dummy)
	geod$n.samp=gsub('Platform: (.*) (.*) Samples','\\2',dummy)

	return(invisible(geod))
}

