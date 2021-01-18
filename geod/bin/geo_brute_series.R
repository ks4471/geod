


####======================================================================================================
##  GEO brute force - get all GEO ids from ftp site   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


#ftp://ftp.ncbi.nlm.nih.gov/geo/datasets/	##  currenlty only series are of any interest
# readme.txt has a lot of useful info regarding dir structure


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

# save(seral,file='/Data/geod/dtb/ref/171027.geo.series.ftp.ids.Rdata')



####======================================================================================================
##  retrieve full dataset/series information using known GEO ids   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

##  current dtb version requires raw files to be available (take a while to re-build if deleted)
##   + 16.03.17 versioin takes 2.6 gb of storage space
in_path='/Data/geod/dtb/raw'



fser=list.files(in_path,pattern='GSE')


Load('/Data/geod/dtb/ref/171027.geo.series.ftp.ids.Rdata')
	rownames(seral)=1:nrow(seral)
	# rownames(datal)=1:nrow(datal)

seral$fname=paste0('geo_',seral$id,'_curl.txt')
	priv=overlap(seral$fname,fser)$inb

	setwd(in_path)
	getwd()
seral=seral[!(seral$fname%in%fser),]  ##  if updating, limit to novel GSE only
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


fser=list.files(in_path,pattern='GSE')
#
	length(fser)
#Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.Rdata')

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
# ##  add platform names    --------------------------------
# #╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
# options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
# options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
# #╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


# # Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.clean.160317.Rdata')
# # Load('/Data/geod/dtb/ref/geo.platform.info.refined.proj.clean.160317.Rdata')





# plat=unique(pltin[,c('id','title')])
# 	colnames(plat)=c('platform','platf.name')


# 	overlap(serin$platform,plat$platform)

# serp=serin[serin$platform!='',]

# 	apply(serp,2,function(x){sum(x=='')})
# 	dim(serp)



# plats=merge(serp,plat,by='platform',all=T)
# 	str(plats)

















