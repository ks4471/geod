


####======================================================================================================
##  clean up processed series html   --------------------------------
#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.171020.Rdata')

query=tolower(c('Amyotrophic Lateral Sclerosis','Lou Gehrig',' ALS ','Amyotrophic','Sclerosis'))
#qubq1=tolower(c('brain ','neuron','nervous','neural','motor.neuro','neurodegenerat','cerebellum','frontal cortex','spinal cord','ventral horns','Central nervous system'))
qubq1=tolower(c('spinal cord'))			##  AND
# qubq2=c('fetal','esc','ips')  		##  NOT

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























