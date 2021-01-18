


####======================================================================================================
##  GEO brute force - get all GEO ids from ftp site   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


#ftp://ftp.ncbi.nlm.nih.gov/geo/datasets/	##  currenlty only datasets and series are of any interest
# readme.txt has a lot of useful info regarding dir structure


##  full listing of all series currently in NCBI GEO ftp site
pltin=system('curl -s ftp://ftp.ncbi.nlm.nih.gov/geo/platforms/ --list-only',intern=T)
pltal=as.data.frame(matrix('',nrow=1,ncol=2))
	colnames(pltal)=c('id','subset')
k=1
for(idat in pltin){
	holder=as.data.frame(system(paste0('curl -s ftp://ftp.ncbi.nlm.nih.gov/geo/platforms/',idat,'/ --list-only'),intern=T))
		colnames(holder)='id'
	holder$subset=idat
	pltal=rbind(pltal,holder)
	k=lcount(k,length(pltin))
}
pltal=pltal[-1,]
	str(pltal)

str(pltal)

#save(pltal,file='/Data/geod/dtb/ref/160317.geo.platform.ftp.ids.Rdata')



####======================================================================================================
##  retrieve full platform information using known GEO ids   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.clean.160317.Rdata')
seri=serin[serin$platform!='',c('platform','species')]
	colnames(seri)=c('id','subset')
Load('/Data/geod/dtb/ref/160317.geo.platform.ftp.ids.Rdata')
	rownames(pltal)=1:nrow(pltal)

in_path='/Data/geod/dtb/raw'
	setwd(in_path)
	getwd()

fser=list.files(in_path,pattern='GPL')
#
pltal=rbind(seri,pltal)
pltal=pltal[!duplicated(pltal$id),]
pltal=pltal[!(pltal$id%in%gsub('geo_(.*)_curl[.]txt','\\1',fser)),]

	length(fser)
	str(pltal)
for(igeo in pltal$id){
	cat('========================',igeo,'========================\n')
	system(paste0('curl https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=',igeo,' > geo_',igeo,'_curl.txt'))
}





####======================================================================================================
##  alternative way to export ?? browser of platforms (also available for series and different format for datasets)
##https://www.ncbi.nlm.nih.gov/geo/browse/?view=platforms&display=20







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
fser=list.files(in_path,pattern='GPL')
#
	length(fser)
#Load('/Data/geod/dtb/ref/geo.platform.info.refined.proj.Rdata')
#system('cp /Data/geod/dtb/raw/geo_GPL13112_curl.txt /Data/ks/tester/')


#fser=overlap(pltin$id,fser)$inb

#fser=fdat

#iser='geo_GPL13112_curl.txt'
k=1
dumpty=as.data.frame(matrix('',nrow=1,ncol=8))
	colnames(dumpty)=c("id","name","title","main","species","platform","nsamp","ref")

for(iser in fser){
#	t1=Sys.time()
#	print(iser)
	holder=readLines(paste0(in_path,'/',iser))

	humpty=as.data.frame(matrix('',nrow=1,ncol=8))
		colnames(humpty)=c("id","name","title","main","species","platform","nsamp","ref")

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

	main=holder[grep('<tr valign="top"><td nowrap>Description</td>',holder)+1]
	if(length(main)==1){humpty$main=main}

	design=holder[grep('<tr valign="top"><td nowrap>Overall design</td>',holder)+1]
	if(length(design)==1){humpty$design=design}

	ref=holder[grep('>Citation',holder)+1]
	if(length(ref)==1){humpty$ref=ref}

	platform=holder[grep('<tr valign="top"><td>Series',holder)+1]
	if(length(platform)==1){humpty$platform=platform}

	nsamp=holder[grep('<tr valign="top"><td>Sample',holder)+1]
	if(length(nsamp)==1){humpty$nsamp=nsamp}

	dumpty=rbind(dumpty,humpty)
	k=lcount(k,length(fser))
	rm(name,title,species,type,main,design,ref,platform,nsamp,holder,humpty)
#	print(Sys.time()-t1)
}

dumpty=dumpty[-1,]	##  remove the lazy var initiate leftover
#
	str(pltin)
	str(dumpty)

	apply(dumpty,2,function(x){sum(x=='')})

pltin=dumpty

pltin=pltin[order(pltin$id),]
	str(pltin)
	apply(pltin,2,function(x){sum(x=='')})


	overlap(fser,pltin$id)

#save(pltin,file='/Data/geod/dtb/ref/geo.platform.info.refined.proj.160317.Rdata')

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


Load('/Data/geod/dtb/ref/geo.platform.info.refined.proj.160317.Rdata')


pltin=as.data.frame(apply(pltin,2,tolower))

pltin$id=gsub('geo_(.*)_curl.txt','\\1',pltin$id)
pltin$title=gsub('_td style__text-align_ justify_*(.*)__td.*','\\1',gsub('[^A-Za-z0-9 _.,!-]', '_',pltin$title))
pltin$main=gsub('_td style__text-align_ justify_*(.*)_br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!-]', '_',pltin$main))
pltin$main=gsub('_td style__text-align_ justify_','',gsub('[^A-Za-z0-9 _.,!-]', '_',pltin$main))
#pltin$name=gsub('.*href___gds__term_(gse.*)_accession___query.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',pltin$name))

pltin$species=gsub('.*geoaxema_organismus___(.*)__a___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',pltin$species))
#pltin$platform=gsub('.*geo_query_acc.cgi_acc_(gpl.*)_ onmouseout__onlinkout__helpmessage_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',pltin$platform))
pltin$ref=gsub('.*pubmed_id_ id__(.*)___a href___pubmed_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',pltin$ref))


#pltin$name=gsub('.*_td align__right_ onmouseout__onlinkout__helpmessage_ , geo_empty_help__ onmouseover__onlinkover__helpmessage_ , geoaxema_gds____a href___gds__term_(.*)_accession___query datasets for .*__a___td_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',pltin$name))

pltin$nsamp=gsub('.*pubmed_id_ id__(.*)___a href___pubmed_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',pltin$nsamp))

pltin$platform=gsub('.*pubmed_id_ id__(.*)___a href___pubmed_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',pltin$platform))





pltin=pltin[,c("id","title","main","species","ref")]
	str(pltin)


#save(pltin,file='/Data/geod/dtb/ref/geo.platform.info.refined.proj.clean.160317.Rdata')





































