


####======================================================================================================
##  GEO brute force - get all GEO ids from ftp site   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(adds)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


#ftp://ftp.ncbi.nlm.nih.gov/geo/datasets/	##  currenlty only datasets and series are of any interest
# readme.txt has a lot of useful info regarding dir structure


##  full listing of all datasets currently in NCBI GEO ftp site
datin=system('curl -s ftp://ftp.ncbi.nlm.nih.gov/geo/datasets/ --list-only',intern=T)
datal=as.data.frame(matrix('',nrow=1,ncol=2))
	colnames(datal)=c('id','subset')
k=1
for(idat in datin){
	holder=as.data.frame(system(paste0('curl -s ftp://ftp.ncbi.nlm.nih.gov/geo/datasets/',idat,'/ --list-only'),intern=T))
		colnames(holder)='id'
	holder$subset=idat
	datal=rbind(datal,holder)
	k=lcount(k,length(datin))
}
datal=datal[-1,]
	str(datal)
#save(datal,file='/Data/geod/dtb/ref/geo.datasets.ftp.ids.Rdata')


##  full listing of all series currently in NCBI GEO ftp site
serin=system('curl -s ftp://ftp.ncbi.nlm.nih.gov/geo/series/ --list-only',intern=T)
seral=as.data.frame(matrix('',nrow=1,ncol=2))
	colnames(seral)=c('id','subset')
k=1
for(idat in serin){
	holder=as.data.frame(system(paste0('curl -s ftp://ftp.ncbi.nlm.nih.gov/geo/series/',idat,'/ --list-only'),intern=T))
		colnames(holder)='id'
	holder$subset=idat
	seral=rbind(seral,holder)
	k=lcount(k,length(serin))
}
seral=seral[-1,]
	str(seral)

str(seral)
#save(seral,file='/Data/geod/dtb/ref/geo.series.ftp.ids.Rdata')
#save(seral,file='/Data/geod/dtb/ref/160317.geo.series.ftp.ids.Rdata')
# save(seral,file='/Data/geod/dtb/ref/171027.geo.series.ftp.ids.Rdata')


## above listings can subsequently be used to retrieve relevant dateset/series information for query for keywords
##  existing dateset/series information can also be updated by checking which are missin from above












####======================================================================================================
##  retrieve full dataset/series information using known GEO ids   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

##  current dtb version requires raw files to be available (take a while to re-build if deleted)
##   + 16.03.17 versioin takes 2.6 gb of storage space
in_path='/Data/geod/dtb/raw'


#fdat=list.files(in_path,pattern='GDS')
#	length(fdat)
#
fser=list.files(in_path,pattern='GSE')

#Load('/Data/geod/dtb/ref/geo.series.ftp.ids.Rdata')			#"gse"[Filter]	##  81692		##  alternative way to get the info from GEO DataSets search
# Load('/Data/geod/dtb/ref/160317.geo.series.ftp.ids.Rdata')
# Load('/Data/geod/dtb/ref/geo.datasets.ftp.ids.Rdata')		#"gds"[Filter] 	##  4348		##  alternative way to get the info from GEO DataSets search
# Load('/Data/geod/dtb/ref/170526.geo.series.ftp.ids.Rdata')
Load('/Data/geod/dtb/ref/171027.geo.series.ftp.ids.Rdata')
	rownames(seral)=1:nrow(seral)
	# rownames(datal)=1:nrow(datal)

seral$fname=paste0('geo_',seral$id,'_curl.txt')
	priv=overlap(seral$fname,fser)$inb

	setwd(in_path)
	getwd()
seral=seral[!(seral$fname%in%fser),]
	str(seral)
for(igeo in seral$id){
	cat('========================',igeo,'========================\n')
	system(paste0('curl https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=',igeo,' > geo_',igeo,'_curl.txt'))
}





####======================================================================================================
##  process retrieved dataset/series html   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

in_path='/Data/geod/dtb/raw'

#fdat=list.files(in_path,pattern='GDS')
#	length(fdat)
#
fser=list.files(in_path,pattern='GSE')
#
	length(fser)
#Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.Rdata')


#fser=overlap(serin$id,fser)$inb

#fser=fdat

#iser='geo_GSE40002_curl.txt'
k=1
dumpty=as.data.frame(matrix('',nrow=1,ncol=11))
	colnames(dumpty)=c("id","platform","name","title","main","design","project","type","species","ref","nsamp")

for(iser in fser){
#	t1=Sys.time()
#	print(iser)
	holder=readLines(paste0(in_path,'/',iser))

	humpty=as.data.frame(matrix('',nrow=1,ncol=11))
		colnames(humpty)=c("id","platform","name","title","main","design","project","type","species","ref","nsamp")

	humpty$id=iser

	name=holder[grep('>Query DataSets for ',holder)]
	if(length(name)==1){humpty$name=name}

	title=holder[grep('<tr valign="top"><td nowrap>Title</td>',holder)+1]
	if(length(title)==1){humpty$title=title}

	project=holder[grep('valign="top"><td nowrap>Project',holder)+1]
	if(length(project)==1){humpty$project=project}


##  multiple possible match options...
	species=holder[grep('<tr valign="top"><td nowrap>Organism',holder)+1]	##  match cut short due to possibilities of 'Organism' or 'Organisms', can be fixed with wildcards, but this is specific enough => wildcard addition irrelevant
	if(length(species)==1){humpty$species=species}

	species=holder[grep('<tr valign="top"><td nowrap>Sample organism',holder)+1]
	if(length(species)==1){humpty$species=species}



	type=holder[grep('<tr valign="top"><td nowrap>Experiment type</td>',holder)+1]
	if(length(type)==1){humpty$type=type}

	main=holder[grep('<tr valign="top"><td nowrap>Summary</td>',holder)+1]
	if(length(main)==1){humpty$main=main}

	design=holder[grep('<tr valign="top"><td nowrap>Overall design</td>',holder)+1]
	if(length(design)==1){humpty$design=design}

	ref=holder[grep('>Citation',holder)+1]
	if(length(ref)==1){humpty$ref=ref}

	platform=holder[grep('<tr valign="top"><td>Platform',holder)+1]
	if(length(platform)==1){humpty$platform=platform}

	nsamp=holder[grep('<tr valign="top"><td>Sample',holder)]
	if(length(nsamp)==1){humpty$nsamp=nsamp}

	dumpty=rbind(dumpty,humpty)
	k=lcount(k,length(fser))
	rm(name,title,species,type,main,design,ref,platform,nsamp,holder,humpty)
#	print(Sys.time()-t1)
}

dumpty=dumpty[-1,]	##  remove the lazy var initiate leftover
#
	str(serin)
	str(dumpty)

	apply(dumpty,2,function(x){sum(x=='')})

serin=dumpty
#serin=rbind(serin,dumpty)
serin=serin[order(serin$id),]
	str(serin)
	apply(serin,2,function(x){sum(x=='')})

#save(serin,file='/Data/geod/dtb/ref/geo.series.info.refined.proj.Rdata')
#save(serin,file='/Data/geod/dtb/ref/geo.series.info.refined.proj.160317.Rdata')
# save(serin,file='/Data/geod/dtb/ref/geo.series.info.refined.proj.170526.Rdata')
# save(serin,file='/Data/geod/dtb/ref/geo.series.info.refined.proj.171020.Rdata')

##  idealy need a few keywords to auto - recognise when page failed to load.. for quick re-load & update of dtb
##   + remove ids with failed load
##   + attempt to re-download missing dtb
##   + update dtb (rbind probably)


####======================================================================================================
##  clean up processed series html   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝




####======================================================================================================
# ##  check database completeness   --------------------------------
# Load('/Data/geod/dtb/ref/geo.series.ftp.ids.Rdata')			#"gse"[Filter]	##  81692		##  alternative way to get the info from GEO DataSets search
# Load('/Data/geod/dtb/ref/geo.datasets.ftp.ids.Rdata')		#"gds"[Filter] 	##  4348		##  alternative way to get the info from GEO DataSets search
#idlis=c(seral$id,datal$id)
#Load('/Data/geod/dtb/ref/geo.series.info.Rdata')
#Load('/Data/geod/dtb/ref/geo.series.info.refined.Rdata')
#
# Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.170526.Rdata')

Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.171020.Rdata')



serin=as.data.frame(apply(serin,2,tolower))

serin$id=gsub('geo_(.*)_curl.txt','\\1',serin$id)
serin$nsamp=gsub('.*_tr valign__top___td_samples _(.*)__div id__.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',serin$nsamp))
serin$nsamp=gsub('.*_tr valign__top___td_samples _(.*)___td_.*','\\1',serin$nsamp)
#serin$nsamp=as.numeric(serin$nsamp)
serin$name=gsub('.*href___gds__term_(gse.*)_accession___query.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',serin$name))

##  currently incomplete, likely due to issues of grepping when multiple platforms
serin$platform=gsub('.*geo_query_acc.cgi_acc_(gpl.*)_ onmouseout__onlinkout__helpmessage_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',serin$platform))

serin$ref=gsub('.*pubmed_id_ id__(.*)___a href___pubmed_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',serin$ref))
serin$ref[grepl('has this study been published',serin$ref)]='unpublished'

##  currently incomplete, likely due to issues of grepping when multiple species
serin$species=gsub('.*geoaxema_organismus___(.*)__a___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',serin$species))
serin$title=gsub('.*td style__text-align_ justify__(.*)__td.*','\\1',gsub('[^A-Za-z0-9 _.,!-]', '_',serin$title))
serin$main=gsub('.*td style__text-align_ justify__(.*)_br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!-]', '_',serin$main))
serin$design=gsub('.*td style__text-align_ justify__(.*)_br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!-]', '_',serin$design))
serin$type=gsub('.*td_(.*)_br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!-]', '_',serin$type))
	str(serin)

serin$project=gsub('.*_td__a href__http___(.*)__a__br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!-]', '_',serin$project))

	matst(serin$id==serin$name)
serin=serin[,c("id","platform","name","title","main","design","project","type","species","ref","nsamp")]

####  identify and correct any mis-processed cells
	apply(serin,2,function(x){sum(x=='')})

	overlap(serin$id,tolower(seral$id))			##  all series
	overlap(serin$id,tolower(datal$id))			##  no datasets




#in_path='/Data/geod/dtb/raw'

##  39 appear to have what is likely all entries missing 39   ----------------------------------------
##   + most entries appear to have been unable to connect properlty (for whatever reason)
##   + single entry - GEO id exists but the entry is private till actual release..
#serl=serin[serin$name=='','id']
#	setwd(in_path)
#holder=readLines(paste0(in_path,'/',serl[1]))
##   + geo_GSE62585_curl.txt ## appears to be a perfectly normal dataset - error extract [45] "There was a problem executing your request. If the problem persists, please write to <a href=\"mailto:geo@ncbi.nlm.nih.gov?subject=Unexpected exception in GEO\">geo@ncbi.nlm.nih.gov</a>, describing in detail what you were trying to do and quoting the following message:<br><br>"  
##   + collate and re-run queries

#
#serl=gsub('geo_(.*)_curl.txt','\\1',serl)
#for(igeo in serl){
#	cat('========================',igeo,'========================\n')
#	system(paste0('curl https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=',igeo,' > geo_',igeo,'_curl.txt'))
#}



##	 platform & nsamp - some sort of related issue? both 83   ----------------------------------------
#serl=serin[serin$nsamp==''&serin$name!='',]
#	apply(serl,2,function(x){sum(x=='')})
#holder=readLines(paste0(in_path,'/geo_GSE29971_curl.txt'))
##  + dataset is experiment type == 'Third-party reanalysis' -> do not provide sample or platform info..
##  + "sample organism" rather than 'organism' - above loop modified accordingly


##   design - not all datasets have one..                     ----------------------------------------
#serl=serin[serin$design==''&serin$nsamp!=''&serin$name!='',]
#	apply(serl,2,function(x){sum(x=='')})
#holder=readLines(paste0(in_path,'/geo_GSE1000_curl.txt'))

##   species is clearly having issues..                       ----------------------------------------
##   design - not all datasets have one..                     ----------------------------------------
#serl=serin[serin$species==''&serin$name!='',]

#serin[serin$id=='gse10407',]


##  final check - re-load pages missing spp, ref, platform, nsamp to make sure its not some partial retrieve error
##   ++ spp - 2 proj missing the data both have "homo sapiens" on the GEO page but not in saved code (both from Lincs)
#serl=serin[serin$ref=='' | serin$species=="" | serin$platform=="" | serin$platform=="",'id']
#in_path='/Data/geod/dtb/raw'
#	setwd(in_path)
##holder=readLines(paste0(in_path,'/',serl[1]))

#serl=toupper(gsub('geo_(.*)_curl.txt','\\1',serl))
#for(igeo in serl){
#	cat('========================',igeo,'========================\n')
#	system(paste0('curl https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=',igeo,' > geo_',igeo,'_curl.txt'))
#}


#system(paste0('curl https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE86357 > geo_GSE86357_curl.txt'))
#system('less /Data/geod/dtb/raw/geo_GSE86357_curl.txt')
#system('cp /Data/geod/dtb/raw/geo_GSE86357_curl.txt /Data/ks/tester/')


	matst(serin$id==serin$name)
	apply(serin,2,function(x){sum(x=='')})
#save(serin,file='/Data/geod/dtb/ref/geo.series.info.refined.proj.clean.170526.Rdata')
save(serin,file='/Data/geod/dtb/ref/geo.series.info.refined.proj.171020.Rdata')









####======================================================================================================
##  clean up processed series html   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


# Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.clean.160317.Rdata')
# Load('/Data/geod/dtb/ref/geo.platform.info.refined.proj.clean.160317.Rdata')





plat=unique(pltin[,c('id','title')])
	colnames(plat)=c('platform','platf.name')


	overlap(serin$platform,plat$platform)

serp=serin[serin$platform!='',]

	apply(serp,2,function(x){sum(x=='')})
	dim(serp)



plats=merge(serp,plat,by='platform',all=T)
	str(plats)


#https://pubchem.ncbi.nlm.nih.gov/idexchange/idexchange.cgi
dsyn=read.file('/Data/geod/dtb/in/drugs_input_eilidh.txt',header=F)
	colnames(dsyn)=c('drug','syno')



#dsyn$syno=gsub('(.*) .INN.*','\\1',dsyn$syno)
dsyn$synon=gsub('(.*) [[].*','\\1',dsyn$syno)
dsyn$synon=gsub('(.*) [(].*','\\1',dsyn$synon)
dsyn$synon=gsub('(.*)[,] .*','\\1',dsyn$synon)
dsyn$synon=gsub('(.*)[;] .*','\\1',dsyn$synon)


dsyn[grepl('(.*) .INN.*',dsyn$syno),]
dsyn[grepl('(.*) [[].*',dsyn$syno),]
dsyn[grepl('(.*) [(].*',dsyn$syno),]
dsyn[grepl('(.*), .*',dsyn$syno),]
dsyn[grepl('(.*); .*',dsyn$syno),]

#dsyn[nchar(dsyn$synon)>30,'synon']
#gsub('(.*)[,] .*','\\1','Piperidine, 4-(9,10-dihydro-4H-benzo[ 4,5]cyclohepta[1,2-b]thien-4-ylidene)-1-methyl-')
#gsub('(.*)[,] .*','\\1','Propofol, pharmaceutical secondary standard')


	Head(dsyn)
dsyn=unique(dsyn[nchar(dsyn$synon)<30,c('drug','synon')])
	Head(dsyn)

#save(dsyn,file='/Data/geod/dtb/in/drugs_input_eilidh.Rdata')

####======================================================================================================
##  clean up processed series html   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.clean.160317.Rdata')
gep=read.delim('/Data/geod/dtb/working/published_paper_gse.txt')
gep$pub.link=tolower(gsub(' ','',gep$pub.link))
sset=gep$pub.link[grepl('gse',gep$pub.link)]
checks=overlap(serin$id,sset)
	checks$inb[grepl('gse',checks$inb)]	 ## 



#query=c(' glioma. ',' astrocytoma. ','diffuse.astrocytoma','anaplastic.astrocytoma','low.grade.glioma')	##  adding space avoid partial matches to things like 'oligodendro"glioma"'
#

#Drop-Seq

query=c('single.cell','single.nucle','individual.cell','individual.nucle')
#query=c(' single.nucleus',' individual.nucleus',' nuclear.seq')
qubq1=c('brain ',' neuron','nervous','neural',"gabaergic","glutamatergic","cerebral","cerebellum","hippocampus","somatosensory")
qubq2=c('fetal','esc','ips')

qspec=c('homo sapiens','mus musculus')
#qmthd=c('expression profiling by high throughput sequencing')
qmthd=c('expression profiling by high throughput sequencing','expression profiling by array')

#
stuffs=serin[
		 (
		 (grepl(paste(query,collapse='|'),serin$title)	| grepl(paste(query,collapse='|'),serin$main)	| grepl(paste(query,collapse='|'),serin$design))
		 &(grepl(paste(qubq1,collapse='|'),serin$title)	| grepl(paste(qubq1,collapse='|'),serin$main)	| grepl(paste(qubq1,collapse='|'),serin$design))
		 &!(grepl(paste(qubq2,collapse='|'),serin$title)	| grepl(paste(qubq2,collapse='|'),serin$main)	| grepl(paste(qubq2,collapse='|'),serin$design))
		 ),]
	str(stuffs)

	#matst(stuffs$platform)



#Head(stuffs[grepl(tolower(paste(sset,collapse='|')),stuffs$id),])
	overlap(sset,serin$id)
oda=overlap(sset,stuffs$id)


dummy=serin[serin$id%in%oda$ina,]
	dummy[,c('id','title','main','design')]
grepl(paste(qubq1,collapse='|'),dummy$title)	| grepl(paste(qubq1,collapse='|'),dummy$main)	| grepl(paste(qubq1,collapse='|'),dummy$design)
grepl(paste(query,collapse='|'),dummy$title)	| grepl(paste(query,collapse='|'),dummy$main)	| grepl(paste(query,collapse='|'),dummy$design)


#write.delim(dummy,file='/Data/geod/dtb/working/serin.match_refine.txt')
#write.delim(stuffs,file='/Data/geod/dtb/working/serin.matches.txt')
#write.delim(stuffs,file='/Data/geod/dtb/working/serin.matches.adult.txt')



#system('cp /Data/geod/dtb/raw/geo_GSE55114_curl.txt /Data/ks/tester/')


query='fenfluramine'

stuffs=serin[
		 (grepl(paste(query,collapse='|'),serin$title)	| grepl(paste(query,collapse='|'),serin$main)	| grepl(paste(query,collapse='|'),serin$design))
#		|(grepl(paste(query,collapse='|'),serin$title)	| grepl(paste(qubq1,collapse='|'),serin$main)	| grepl(paste(qubq1,collapse='|'),serin$design))
		,]
	str(stuffs)


####  pointless but reassuring confirmation of what should be obviously the case by construction..  (which ofc assumes the author is competent..)
# che1=matst(serin[grepl(paste(query,collapse='|'),serin$title),'id'])
# che2=matst(serin[grepl(paste(qubq1,collapse='|'),serin$title),'id'])
# che3=matst(serin[(grepl(paste(query,collapse='|'),serin$title)	&grepl(paste(qubq1,collapse='|'),serin$title)),'id'])
# che4=overlap(che1$entry,che2$entry)
# 	overlap(che3$entry,che4$inter)



#stuffs=serin[grepl(paste(query,collapse='|'),serin$title)|grepl(paste(query,collapse='|'),serin$main),]
#	str(stuffs)

	head(matst(stuffs$type))
stuffs=stuffs[stuffs$type%in%qmthd,]
	str(stuffs)

	matst(stuffs$species)
stuffs=stuffs[stuffs$species%in%qspec,]
	str(stuffs)


#write.file(stuffs,file='/Data/geod/dtb/working/geo_datasets_series.query_single_cell_nucleus.txt',row.names=F,col.names=T)
write.file(stuffs,file='/Data/geod/dtb/working/geo_datasets_series.query_single_nucleus.txt',row.names=F,col.names=T)














stuffs=serin[grepl('dronc.seq',serin$title)|grepl('dronc.seq',serin$main),]

#stuffs=serin[grepl('single.cell',serin$title)|grepl('single.cell',serin$main),]
stuffs=serin[grepl('single.cell|individual.cell',serin$title)|grepl('single.cell|individual.cell',serin$main),]
			
	overlap(sset,stuffs$id)
	overlap(sset,serin$id)

#stuffs=stuffs[grepl(' brain| neuron',stuffs$title)|grepl(' brain| neuron',stuffs$main),]
	Head(stuffs)	
stuffs=stuffs[grepl('RNA.seq|transcriptom|rnaseq|sequencing',stuffs$title)|grepl('RNA.seq|transcriptom|rnaseq|sequencing',stuffs$main),]
	Head(stuffs)

	matst(stuffs$type)
	stuffs[stuffs$type=='<td>expression profiling by high throughput sequencing<br>genome binding/occupancy profiling by high throughput sequencing<br>methylation profiling by high throughput sequencing<br></td>',]

sset=tolower(c('GSE63576'		##  known single cell GEO entries
	  ,'GSE71585'
	  ,'GSE70844'
	  ,'GSE59739'
	  ,'GSE60361'
	  ,'GSE63473'	##
	  ,'GSE55114'	##
	  ))


#Head(stuffs[grepl(tolower(paste(sset,collapse='|')),stuffs$id),])

	overlap(sset,stuffs$id)
	overlap(sset,serin$id)





78030
78203
78214
78476
81704





GSE55114
GSE70844



dumpty=apply(humpty,2,function(x){gsub('[^A-Za-z0-9 _.,!]', '_',x)})

gsub('_td style__text_align_ justify__(.*)__td_','\\1',humpty$title)































setwd('/Data/geod/dtb/raw')
getwd()
for(igeo in datal$id){
	cat('========================',igeo,'========================\n')
	system(paste0('curl https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=',igeo,' > geo_',igeo,'_curl.txt'))
}













rawHTML <- paste(readLines("path/to/file.html"), collapse="\n")
doc = htmlTreeParse(paste0('https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=',igeo),useInternal = TRUE)

GSE1134
https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GDS1001


curl -o GPL1456.txt 'https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?view=data&acc=GPL1456&id=11315&db=GeoDb_blob92'






	system(paste0('curl http://dgidb.genome.wustl.edu/api/v1/interactions.json?genes=',igen,' | python -mjson.tool > ',paste0(ot_path,'dgidb_sjon.',igen,'.txt')))

	dgidb[[igen]]=fromJSON(paste0(ot_path,'dgidb_sjon.',igen,'.txt'))	##  fromJSON takes files and relevant objects
#	str(digidb[[igen]])




for(icid in cidq){
	system(paste0('curl https://pubchem.ncbi.nlm.nih.gov/compound/',icid,' > cid_',icid,'_curl.txt'))
#	holder=readLines(paste0('cid_',icid,'_curl.txt'))
#	gsub('.*content=(.*).* CID ','\\1',holder[grep('(.*meta name)(.*description)',holder)])
#	holder[grep('(.*meta name)(.*pubchem_uid_value)',holder)]
}

for(icid in 1:cidmax){
#	system(paste0('curl https://pubchem.ncbi.nlm.nih.gov/compound/',icid,' > cid_',icid,'_curl.txt'))
	holder=readLines(paste0('cid_',icid,'_curl.txt'))
	holder=gsub('','',gsub('.*content=(.*).* - structure.*','\\1',holder[grep('(.*meta name)(.*description)',holder)]))
	holder=substr(holder,2,nchar(holder))
	cidat[icid,]=unlist(strsplit(holder,' [|] '))[c(1,3)]

#	holder[grep('(.*meta name)(.*pubchem_uid_value)',holder)]
	k=lcount(k,cidmax)
}















