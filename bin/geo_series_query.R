


####======================================================================================================
##  clean up processed series html   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.171020.Rdata')

#query=c(' glioma. ',' astrocytoma. ','diffuse.astrocytoma','anaplastic.astrocytoma','low.grade.glioma')	##  adding space avoid partial matches to things like 'oligodendro"glioma"'
#

#Drop-Seq





query=tolower(c('Amyotrophic Lateral Sclerosis','Lou Gehrig',' ALS ','Amyotrophic','Sclerosis'))
#qubq1=tolower(c('brain ','neuron','nervous','neural','motor.neuro','neurodegenerat','cerebellum','frontal cortex','spinal cord','ventral horns','Central nervous system'))
qubq1=tolower(c('spinal cord'))
qubq1=tolower(c('spinal cord'))


# qubq2=c('fetal','esc','ips')

qspec=c('homo sapiens')#,'mus musculus'
#qmthd=c('expression profiling by high throughput sequencing')
qmthd=c('expression profiling by high throughput sequencing','expression profiling by array')

#
stuffs=serin[
		 (
		 (grepl(paste(query,collapse='|'),serin$title)	| grepl(paste(query,collapse='|'),serin$main)	| grepl(paste(query,collapse='|'),serin$design))
		 &(grepl(paste(qubq1,collapse='|'),serin$title)	| grepl(paste(qubq1,collapse='|'),serin$main)	| grepl(paste(qubq1,collapse='|'),serin$design))
		 # &!(grepl(paste(qubq2,collapse='|'),serin$title)	| grepl(paste(qubq2,collapse='|'),serin$main)	| grepl(paste(qubq2,collapse='|'),serin$design))

		 ),]
stuffs=stuffs[grepl(paste(qspec,collapse='|'),stuffs$species),]


	str(stuffs)





write.delim(stuffs,file='/Data/geod/out/table/als.spinal_cord.matches.txt')








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

