


####======================================================================================================
##  clean up processed series html   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


Load('/Data/geod/dtb/ref/210417.geo.series.dtb.Rdata')



quer1=tolower(paste(c('trichostatin'),collapse='|'))
#quer2=c()

qspec=c('homo sapiens')
#qtype=c('_cytoplasmic rna','_nuclear rna','_total rna','_polya rna')
qtype=c('rna')
#     entry  count percent
# 1     rna 958621   0.666
# 2 genomic 202426   0.141
# 3     sra 166335   0.116
# 4          91762   0.064
# 5 protein   9358   0.007
# 6   other   6900   0.005
# 7   mixed   3731   0.003
# 8    mpss    110   0.000
# 9    sage     15   0.000



answ=samal[
		(grepl(quer1,samal$title)
		| grepl(quer1,samal$source)
		| grepl(quer1,samal$treatment)
		| grepl(quer1,samal$growth)

		| grepl(quer1,samal$label)
		| grepl(quer1,samal$labprotocol)
		| grepl(quer1,samal$hybridisation)
		| grepl(quer1,samal$scan)
		| grepl(quer1,samal$processing)
		)&
		grepl(qtype,samal$stype)
		&grepl(qspec,samal$organism)
		,]


write.file(answ,file='/Data/geod/out/table/answ.samp.trichostatin.txt')




































matst(samal[samal$extraction=='_nuclear rna','series'])


1  gse42508    36   0.118
2  gse24565    23   0.075
3  gse11576    21   0.069
4  gse29991    21   0.069
5  gse58731    17   0.056
6  gse83660    14   0.046
7  gse97143    14   0.046
8  gse34448    12   0.039
9  gse70061    12   0.039
10 gse26284    10   0.033
11 gse58838    10   0.033









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
checks=overlap(samal$id,sset)
	checks$inb[grepl('gse',checks$inb)]			 ## 





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
stuffs=samal[
		 (
		 (grepl(paste(query,collapse='|'),samal$title)	| grepl(paste(query,collapse='|'),samal$main)	| grepl(paste(query,collapse='|'),samal$design))
		 &(grepl(paste(qubq1,collapse='|'),samal$title)	| grepl(paste(qubq1,collapse='|'),samal$main)	| grepl(paste(qubq1,collapse='|'),samal$design))
		 &!(grepl(paste(qubq2,collapse='|'),samal$title)	| grepl(paste(qubq2,collapse='|'),samal$main)	| grepl(paste(qubq2,collapse='|'),samal$design))
		 ),]
	str(stuffs)

	#matst(stuffs$platform)



#Head(stuffs[grepl(tolower(paste(sset,collapse='|')),stuffs$id),])
	overlap(sset,samal$id)
oda=overlap(sset,stuffs$id)


dummy=samal[samal$id%in%oda$ina,]
	dummy[,c('id','title','main','design')]
grepl(paste(qubq1,collapse='|'),dummy$title)	| grepl(paste(qubq1,collapse='|'),dummy$main)	| grepl(paste(qubq1,collapse='|'),dummy$design)
grepl(paste(query,collapse='|'),dummy$title)	| grepl(paste(query,collapse='|'),dummy$main)	| grepl(paste(query,collapse='|'),dummy$design)


#write.delim(dummy,file='/Data/geod/dtb/working/samal.match_refine.txt')
#write.delim(stuffs,file='/Data/geod/dtb/working/samal.matches.txt')
#write.delim(stuffs,file='/Data/geod/dtb/working/samal.matches.adult.txt')



#system('cp /Data/geod/dtb/raw/geo_GSE55114_curl.txt /Data/ks/tester/')


query='fenfluramine'

stuffs=samal[
		 (grepl(paste(query,collapse='|'),samal$title)	| grepl(paste(query,collapse='|'),samal$main)	| grepl(paste(query,collapse='|'),samal$design))
#		|(grepl(paste(query,collapse='|'),samal$title)	| grepl(paste(qubq1,collapse='|'),samal$main)	| grepl(paste(qubq1,collapse='|'),samal$design))
		,]
	str(stuffs)


####  pointless but reassuring confirmation of what should be obviously the case by construction..  (which ofc assumes the author is competent..)
# che1=matst(samal[grepl(paste(query,collapse='|'),samal$title),'id'])
# che2=matst(samal[grepl(paste(qubq1,collapse='|'),samal$title),'id'])
# che3=matst(samal[(grepl(paste(query,collapse='|'),samal$title)	&grepl(paste(qubq1,collapse='|'),samal$title)),'id'])
# che4=overlap(che1$entry,che2$entry)
# 	overlap(che3$entry,che4$inter)



#stuffs=samal[grepl(paste(query,collapse='|'),samal$title)|grepl(paste(query,collapse='|'),samal$main),]
#	str(stuffs)

	head(matst(stuffs$type))
stuffs=stuffs[stuffs$type%in%qmthd,]
	str(stuffs)

	matst(stuffs$species)
stuffs=stuffs[stuffs$species%in%qspec,]
	str(stuffs)


#write.file(stuffs,file='/Data/geod/dtb/working/geo_datasets_series.query_single_cell_nucleus.txt',row.names=F,col.names=T)
# write.file(stuffs,file='/Data/geod/dtb/working/geo_datasets_series.query_single_nucleus.txt',row.names=F,col.names=T)














stuffs=samal[grepl('dronc.seq',samal$title)|grepl('dronc.seq',samal$main),]

#stuffs=samal[grepl('single.cell',samal$title)|grepl('single.cell',samal$main),]
stuffs=samal[grepl('single.cell|individual.cell',samal$title)|grepl('single.cell|individual.cell',samal$main),]
			
	overlap(sset,stuffs$id)
	overlap(sset,samal$id)

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
	overlap(sset,samal$id)





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















	