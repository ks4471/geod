


##======================================================================================================
##  GEO brute force - get all GEO ids from ftp site   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


#ftp://ftp.ncbi.nlm.nih.gov/geo/datasets/	##  currenlty only datasets and series are of any interest
# readme.txt has a lot of useful info regarding dir structure

in_path='/Data/geod/dtb/raw_samples'
setwd(in_path)
getwd()
##  full listing of all datasets currently in NCBI GEO ftp site
samin=system('curl -s ftp://ftp.ncbi.nlm.nih.gov/geo/samples/ --list-only',intern=T)
samal=as.data.frame(matrix('',nrow=1,ncol=2))
	colnames(samal)=c('id','subset')
str(samin)
k=1
##
ef=list()
for(idat in samin){
	holder=as.data.frame(system(paste0('curl -s ftp://ftp.ncbi.nlm.nih.gov/geo/samples/',idat,'/ --list-only'),intern=T))
	if(nrow(holder)==0){		##  appears that there are GSM folders that are actually empty? eg GSM1774nnn
#		cat('\t',idat,'\n')
		ef[[idat]]=''
	}

	if(nrow(holder)>0){
		colnames(holder)='id'
	holder$subset=idat
	samal=rbind(samal,holder)
	k=lcount(k,length(samin))

	}
}
samal=samal[-1,]
	str(samal)

##  due to common issues of connection breaks / timeout.. check for overlap
	overlap(samin,samal$subset)
##  add missing parts
samin=samin[!(samin%in%samal$subset)]
	str(samin)


ef=names(ef)
save(samal,samin,ef,file='/Data/geod/dtb/ref/170614.geo.samples.ftp.Rdata')





####======================================================================================================
##  retrieve full dataset/series information using known GEO ids   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

##  current dtb version requires raw files to be available (take a while to re-build if deleted)
##   + 16.03.17 versioin takes 2.6 gb of storage space
in_path='/Data/geod/dtb/raw_samples'


fnam=list.files(in_path,pattern='GSM')

Load('/Data/geod/dtb/ref/170614.geo.samples.ftp.Rdata')
	rownames(samal)=1:nrow(samal)

samal$fname=paste0('geo_',samal$id,'_curl.txt')
	priv=overlap(samal$fname,fnam)$ina

setwd(in_path)
getwd()
	str(samal)
samal=samal[!(samal$fname%in%fnam),]
	str(samal)
	overlap(samal$fname,fnam)


for(igeo in samal$id){
	cat('========================',igeo,'========================\n')
	system(paste0('curl https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=',igeo,' > geo_',igeo,'_curl.txt'))
}





####======================================================================================================
##  process retrieved dataset/series html   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
source('/Data/tools/adds.R')
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

in_path='/Data/geod/dtb/raw_samples'


fnam=list.files(in_path,pattern='GSM')
	length(fnam)


uset=round(seq(1,length(fnam),length.out=20),digits=0)
uset=as.data.frame(uset[2:length(uset)])
	colnames(uset)='end'
uset$start=c(1,(uset$end[1:(nrow(uset)-1)]+1))



k=1
	blank=as.data.frame(matrix('',nrow=1,ncol=20))
		colnames(blank)=c("id","status","title","stype","source","organism","characteristics","provider","treatment","growth","extraction","molecule","label","labprotocol","hybridisation","scan","description","processing","platform","series")

	 lprogr(iset,1:nrow(uset))
	sfnam=fnam[uset$start[iset]:uset$end[iset]]
	sfnam=sfnam[!is.na(sfnam)]
	dumpty=''

	for(iser in sfnam){
#	t1=Sys.time()
#	print(iser)
	holder=readLines(paste0(in_path,'/',iser))

	humpty=blank
	humpty$id=iser

	status=holder[grep('<tr valign="top"><td>Status',holder)+1]
		if(length(status)==1){humpty$status=status}
	title=holder[grep('<tr valign="top"><td nowrap>Title',holder)+1]
		if(length(title)==1){humpty$title=title}
	stype=holder[grep('<tr valign="top"><td nowrap>Sample type',holder)+1]
		if(length(stype)==1){humpty$stype=stype}
	source=holder[grep('<tr valign="top"><td nowrap>Source name',holder)+1]
		if(length(source)==1){humpty$source=source}
			if(length(source)>1){humpty$source=paste(source,collapse="--:-:--")}
	organism=holder[grep('<tr valign="top"><td nowrap>Organism',holder)+1]
		if(length(organism)==1){humpty$organism=organism}
				if(length(organism)>1){humpty$organism=paste(organism,collapse="--:-:--")}
	characteristics=holder[grep('<tr valign="top"><td nowrap>Characteristics',holder)+1]
		if(length(characteristics)==1){humpty$characteristics=characteristics}
			if(length(characteristics)>1){humpty$characteristics=paste(characteristics,collapse="--:-:--")}
	provider=holder[grep('<tr valign="top"><td nowrap>Biomaterial provider',holder)+1]
		if(length(provider)==1){humpty$provider=provider}
	treatment=holder[grep('<tr valign="top"><td nowrap>Treatment protocol',holder)+1]
		if(length(treatment)==1){humpty$treatment=treatment}
	growth=holder[grep('<tr valign="top"><td nowrap>Growth protocol',holder)+1]
		if(length(growth)==1){humpty$growth=growth}
	extraction=holder[grep('<tr valign="top"><td nowrap>Extracted molecule',holder)+1]
		if(length(extraction)==1){humpty$extraction=extraction}
	molecule=holder[grep('<tr valign="top"><td nowrap>Extraction protocol',holder)+1]
		if(length(molecule)==1){humpty$molecule=molecule}
			if(length(molecule)>1){humpty$molecule=paste(molecule,collapse="--:-:--")}
	label=holder[grep('<tr valign="top"><td nowrap>Label',holder)+1]
		if(length(label)==1){humpty$label=label}
			if(length(label)>1){humpty$label=paste(label,collapse="--:-:--")}
	labprotocol=holder[grep('<tr valign="top"><td nowrap>Label protocol',holder)+1]
		if(length(labprotocol)==1){humpty$labprotocol=labprotocol}
	hybridisation=holder[grep('<tr valign="top"><td nowrap>Hybridization protocol',holder)+1]
		if(length(hybridisation)==1){humpty$hybridisation=hybridisation}
	scan=holder[grep('<tr valign="top"><td nowrap>Scan protocol',holder)+1]
		if(length(scan)==1){humpty$scan=scan}
	description=holder[grep('<tr valign="top"><td nowrap>Description',holder)+1]
		if(length(description)==1){humpty$description=description}
	processing=holder[grep('<tr valign="top"><td nowrap>Data processing',holder)+1]
		if(length(processing)==1){humpty$processing=processing}
	platform=holder[grep('<tr valign="top"><td>Platform ID',holder)+1]
		if(length(platform)==1){humpty$platform=platform}
	series=holder[grep('<tr valign="top"><td>Series.*',holder)+1]
		if(length(series)==1){humpty$series=series}

	dumpty=rbind(dumpty,humpty)
	k=lcount(k,length(sfnam))
	rm(status,title,stype,source,organism,characteristics,provider,treatment,growth,extraction,molecule,label,labprotocol,hybridisation,scan,description,processing,platform,series)
#	print(Sys.time()-t1)
}
#	apply(dumpty,2,function(x){sum(x=='')})

samin=dumpty
samin=samin[order(samin$id),]
	# str(samin)
	# apply(samin,2,function(x){sum(x=='')})
# str(samin[samin$treatment=='',][45,])	#  2 channels => 2 protocols special case adjustment
# samin[samin$organism=='',][7,]	#  2 channels => 2 protocols special case adjustment	GSM101134

save(samin,file=paste0('/Data/geod/dtb/ref/210417.geo.series.raw.',uset$start[iset],'..',uset$end[iset],'.Rdata'))

	rm(samin)
	rm(dumpty)
}








##  idealy need a few keywords to auto - recognise when page failed to load.. for quick re-load & update of dtb
##   + remove ids with failed load
##   + attempt to re-download missing dtb
##   + update dtb (rbind probably)


#<tr valign="top"><td bgcolor="#DEEBDC">GSM100292.CEL.gz</td>
#<td bgcolor="#DEEBDC" title="6992618">6.7 Mb</td>
#<td bgcolor="#DEEBDC"><a href="ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM100nnn/GSM100292/suppl/GSM100292%2ECEL%2Egz">(ftp)</a><a href="/geo/download/?acc=GSM100292&amp;format=file&amp;file=GSM100292%2ECEL%2Egz">(http)</a></td>
#<td bgcolor="#DEEBDC">CEL</td>
#</tr>
#<tr valign="top"><td bgcolor="#EEEEEE">GSM100292.EXP.gz</td>
#<td bgcolor="#EEEEEE" title="396">396 b</td>
#<td bgcolor="#EEEEEE"><a href="ftp://ftp.ncbi.nlm.nih.gov/geo/samples/GSM100nnn/GSM100292/suppl/GSM100292%2EEXP%2Egz">(ftp)</a><a href="/geo/download/?acc=GSM100292&amp;format=file&amp;file=GSM100292%2EEXP%2Egz">(http)</a></td>
#<td bgcolor="#EEEEEE">EXP</td>
#</tr>









####======================================================================================================
##  process retrieved dataset/series html   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
source('/Data/tools/adds.R')
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


fnam=list.files('/Data/geod/dtb/ref/',pattern='210417.geo.series.raw',full.names=T)
	length(fnam)

Load(fnam[1])

samal=samin
for(ifle in fnam[2:length(fnam)]){
	Load(ifle)
	lprogr(ifle,fnam)
	samal=rbind(samin,samal)
}

samal=unique(samal)

	Head(samal)


#save(samal,file='/Data/geod/dtb/ref/210417.geo.series.dtb.Rdata')










####======================================================================================================
##  clean up processed series html   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


####======================================================================================================
##  check database completeness   --------------------------------
Load('/Data/geod/dtb/ref/210417.geo.series.dtb.Rdata')

samal=samal[-1,]

samal=as.data.frame(apply(samal,2,function(x){gsub("[^A-Za-z0-9 -.,!]","_",x)}))

samal=as.data.frame(apply(samal,2,tolower))

str(samal)



samal$id=gsub('geo_(.*)_curl.txt','\\1',samal$id)
samal$status=gsub('_td_(.*)__td_','\\1',samal$status)
samal$title=gsub('.*td style__text-align_ justify__(.*)__td.*','\\1',gsub('[^A-Za-z0-9 _.,!-]', '_',samal$title))
samal$organism=gsub('.*geoaxema_organismus___(.*)__a___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$organism ))
#samal$series=gsub('_td_onmouseout__onlinkout__helpmessage____geo_empty_help___onmouseover__onlinkover__helpmessage____geoaxema_recenter____table_cellpadding__3__style__position_relative_top__5px_left__5px___tr__td_valign__top___a_href___geo_query_acc_(gse.*)__onmouseout__onlinkout__helpmessage____geo_empty_help___onmouseover__onlinkover__helpmessage____geoaxema_recenter___(gse.*)__a___td','\\1',gsub('[^A-Za-z0-9]', '_',samal$series))
samal$series=gsub('.*geo_empty_help___onmouseover__onlinkover__helpmessage____geoaxema_recenter___(gse.*)__a___td_.*','\\1',samal$series)


samal$stype=gsub('_td_(.*)__td_','\\1',samal$stype)
samal$description=gsub('.*td style__text_align_ justify__(.*)br___td_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$description))
samal$processing=gsub('.*td style__text_align_ justify__(.*)__br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$processing ))
samal$source=gsub('.*td style__text_align_ justify__(.*)_br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$source))
samal$characteristics=gsub('.*td style__text_align_ justify__(.*)_br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$characteristics ))
samal$treatment=gsub('.*_td style__text_align_ justify__(.*)_br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$treatment ))


samal$growth=gsub('.*td style__text_align_ justify__(.*)__br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$growth ))
samal$extraction=gsub('.*td(.*)__td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$extraction ))
samal$molecule=gsub('.*td style__text_align_ justify__(.*)_br___td_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$molecule ))
samal$label=gsub('.*td style__text_align_ justify__(.*)_br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$label ))
samal$labprotocol=gsub('.*td style__text_align_ justify__(.*)_br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$labprotocol ))
samal$hybridisation=gsub('.*td style__text_align_ justify__(.*)_br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$hybridisation ))
samal$scan=gsub('.*td style__text_align_ justify__(.*)_br___td.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$scan ))

samal$platform=gsub('.*geo_query_acc.cgi_acc_(gpl.*)_ onmouseout__onlinkout__helpmessage_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$platform))
samal$platform=gsub('.*_td__a href___geo_query_acc.cgi_acc_(gpl.*)__(gpl.*)__a___td_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$platform))


samal$ref=gsub('.*pubmed_id_ id__(.*)___a href___pubmed_.*','\\1',gsub('[^A-Za-z0-9 _.,!]', '_',samal$ref))
samal$ref[grepl('has this study been published',samal$ref)]='unpublished'

samal=samal[,c("id","platform","name","title","main","design","project","type","species","ref","nsamp")]

####  identify and correct any mis-processed cells
	apply(samal,2,function(x){sum(x=='')})

	overlap(samal$id,tolower(seral$id))			##  all series
	overlap(samal$id,tolower(datal$id))			##  no datasets



save(samal,file='/Data/geod/dtb/ref/210417.geo.series.dtb.Rdata')








































#in_path='/Data/geod/dtb/raw'

##  39 appear to have what is likely all entries missing 39   ----------------------------------------
##   + most entries appear to have been unable to connect properlty (for whatever reason)
##   + single entry - GEO id exists but the entry is private till actual release..
#serl=samal[samal$name=='','id']
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
#serl=samal[samal$nsamp==''&samal$name!='',]
#	apply(serl,2,function(x){sum(x=='')})
#holder=readLines(paste0(in_path,'/geo_GSE29971_curl.txt'))
##  + dataset is experiment type == 'Third-party reanalysis' -> do not provide sample or platform info..
##  + "sample organism" rather than 'organism' - above loop modified accordingly


##   design - not all datasets have one..                     ----------------------------------------
#serl=samal[samal$design==''&samal$nsamp!=''&samal$name!='',]
#	apply(serl,2,function(x){sum(x=='')})
#holder=readLines(paste0(in_path,'/geo_GSE1000_curl.txt'))

##   species is clearly having issues..                       ----------------------------------------
##   design - not all datasets have one..                     ----------------------------------------
#serl=samal[samal$species==''&samal$name!='',]

#samal[samal$id=='gse10407',]


##  final check - re-load pages missing spp, ref, platform, nsamp to make sure its not some partial retrieve error
##   ++ spp - 2 proj missing the data both have "homo sapiens" on the GEO page but not in saved code (both from Lincs)
#serl=samal[samal$ref=='' | samal$species=="" | samal$platform=="" | samal$platform=="",'id']
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


	matst(samal$id==samal$name)
	apply(samal,2,function(x){sum(x=='')})
#save(samal,file='/Data/geod/dtb/ref/geo.series.info.refined.proj.clean.160317.Rdata')










####======================================================================================================
##  clean up processed series html   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.clean.160317.Rdata')
Load('/Data/geod/dtb/ref/geo.platform.info.refined.proj.clean.160317.Rdata')

plat=unique(pltin[,c('id','title')])
	colnames(plat)=c('platform','platf.name')
	 

serp=samal[samal$platform!='',]

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



























	