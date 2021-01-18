


#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝


# Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.clean.160317.Rdata')
Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.clean.170526.Rdata')
gep=read.delim('/Data/geod/dtb/working/published_paper_gse.txt')
gep$pub.link=tolower(gsub(' ','',gep$pub.link))
sset=gep$pub.link[grepl('gse',gep$pub.link)]
checks=overlap(serin$id,sset)
	checks$inb[grepl('gse',checks$inb)]



#query=c(' glioma. ',' astrocytoma. ','diffuse.astrocytoma','anaplastic.astrocytoma','low.grade.glioma')	##  adding space avoid partial matches to things like 'oligodendro"glioma"'
#Drop-Seq

# query='pioglitazone'
#query=c('B.cell','T.cell','CD4+','CD8+','monocyte','neutrophil','macrophage','endothelial precursor','megakaryocyte','erythroblast','fetal thymus')
#query=c(' brain ',' brains ')
#query=c('quantseq','lexogen')
#query=c("3,4',5-stilbenetriol","3,5,4'-trihydroxystilbene","resveratrol","trans-resveratrol")
#query=c('single.cell','individual.cell','single.nucleus','individual.nucleus','single.nuclei','individual.nucleus','single.nuclear','individual.nuclear')
#query=c('single.nucleus','individual.nucleus','single.nuclei','individual.nucleus','single.nuclear','individual.nuclear')
query=c('single.cell','individual.cell')
#nuery=c('single.nucleotide','individual.nucleotide')
#query=c(' single.nucleus',' individual.nucleus',' nuclear.seq')
qubq1=c('brain ',' neuron','nervous','neural',"gabaergic","glutamatergic","cerebral","cerebellum","hippocampus","somatosensory")
#qubq1=c("hippocampus","hippocampal",'CA1','CA2','CA3','CA4')
#qubq2=c('fetal','esc','ips')
#qubq2=c('control')

qspec=c('homo sapiens')#,'mus musculus')
#qspec=c('homo sapiens','mus musculus','rattus norvegicus')
#qmthd=c('expression profiling by high throughput sequencing')
#qmthd=c('expression profiling by high throughput sequencing','expression profiling by array')

#
stuffs=serin[
		 (
		 (grepl(paste(query,collapse='|'),serin$title)	| grepl(paste(query,collapse='|'),serin$main)	| grepl(paste(query,collapse='|'),serin$design))
#		 (!grepl(paste(nuery,collapse='|'),serin$title)	| !grepl(paste(nuery,collapse='|'),serin$main)	| !grepl(paste(nuery,collapse='|'),serin$design))
		 &(grepl(paste(qubq1,collapse='|'),serin$title)	| grepl(paste(qubq1,collapse='|'),serin$main)	| grepl(paste(qubq1,collapse='|'),serin$design))
#		 &!(grepl(paste(qubq2,collapse='|'),serin$title)	| grepl(paste(qubq2,collapse='|'),serin$main)	| grepl(paste(qubq2,collapse='|'),serin$design))
#		 &(grepl(paste(qubq2,collapse='|'),serin$title)	| grepl(paste(qubq2,collapse='|'),serin$main)	| grepl(paste(qubq2,collapse='|'),serin$design))
			 &(grepl(paste(qspec,collapse='|'),serin$species))
			 # &(grepl(paste(qmthd,collapse='|'),serin$type))
		 ),]
	str(stuffs)


	overlap(sset,serin$id)
oda=overlap(sset,stuffs$id)

	nrow(stuffs)
stuffs=stuffs[grepl('expression profiling by array|expression profiling by high throughput sequencing',stuffs$type),]
	Head(stuffs)

write.file(stuffs,file='/Data/geod/out/table/geo_datasets.pioglitazone_only.no_drug_synonyms.txt',row.names=F)
#write.file(stuffs,file='/Data/geod/out/table/immune.geo_datasets.txt',row.names=F)
#write.file(stuffs,file='/Data/geod/out/table/ans.quantseq_lexogen.txt',row.names=F)
#write.file(stuffs,file='/Data/geod/out/table/ans.single_cell_nucleus.brain.txt',row.names=F)
#write.file(stuffs,file='/Data/geod/out/table/ans.single_cell_nucleus.hippocampus.txt',row.names=F)




























#╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╗╔╦╗╔═╗╔═╦╗╔═╦═╦╦╦╦╗╔═╗╔╗═╦╗╔═╦╗╔╦╦╗
options(stringsAsFactors=F);library(colorout);rm(list=ls());ls()#╚═╣║ ╚╣║¯\_(•_•)_/¯║╚╣╔╣╔╣║║║║╚╣
options(menu.graphics=FALSE);library(R.helper)#╣═╩╚╣║╔╔╣╦═║║╔╚║╔╚╔╣╩╚╚╦╣║╩╔╦║║ ╚╩╣╚╚╣║╣╚╩╔╦╩╚╦╚╩╣
#╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩═╩╝╚═╝╩═╩╝╚═╩══╩═╩═╩═╩╝╩═╩╝╚═╩═╩╩═╝

Load('/Data/geod/dtb/in/drugs_input_eilidh.Rdata')
Load('/Data/geod/dtb/ref/geo.series.info.refined.proj.clean.160317.Rdata')
dsyn$synon=gsub('(.*)[,] .*','\\1',dsyn$synon)
	Head(dsyn)
dsyn=dsyn[!grepl('[-_]',dsyn$synon),]
	Head(dsyn)

#query=unique(tolower(dsyn$drug))
#query=unique(tolower(dsyn$synon))
udru=unique(dsyn$drug)

idru='propofol'
#as.data.frame(udru)
k=1
for(idru in udru){

	 cat('\t',idru,'\t',k,' of ',length(udru),'\n')
	query=unique(unlist(dsyn[dsyn$drug==idru,]))

	#query=c(' single.nucleus',' individual.nucleus',' nuclear.seq')
	#qubq1=c('brain ',' neuron','nervous','neural',"gabaergic","glutamatergic","cerebral","cerebellum","hippocampus","somatosensory")
	#qubq2=c('fetal','esc','ips')

	#qspec=c('homo sapiens','mus musculus')
	#qmthd=c('expression profiling by high throughput sequencing')
	#qmthd=c('expression profiling by high throughput sequencing','expression profiling by array')

	#
	stuffs=serin[
			 (
			 (grepl(paste(query,collapse='|'),serin$title)	| grepl(paste(query,collapse='|'),serin$main)	| grepl(paste(query,collapse='|'),serin$design))
	#		 &(grepl(paste(qubq1,collapse='|'),serin$title)	| grepl(paste(qubq1,collapse='|'),serin$main)	| grepl(paste(qubq1,collapse='|'),serin$design))
	#		 &!(grepl(paste(qubq2,collapse='|'),serin$title)	| grepl(paste(qubq2,collapse='|'),serin$main)	| grepl(paste(qubq2,collapse='|'),serin$design))
			 ),]
#		str(stuffs)

	if(nrow(stuffs)>0){
		 cat('\t\t\tn datasets matches :',nrow(stuffs),'\n')
		stuffs$drug=idru
		write.file(stuffs,file=paste0('/Data/geod/out/table/',idru,'.matched_geo.txt'))
	}
	k=k+1
}


out_path='/Data/geod/out/table/'
	setwd(out_path)
	getwd()
for(idru in udru){

#	 cat('\t',idru,'\t',k,' of ',length(udru),'\n')
	# system(paste0('curl https://www.ncbi.nlm.nih.gov/gds?term=%28%22',idru,'%22%5BMeSH%20Terms%5D%20OR%20',idru,'%5BAll%20Fields%5D%29%20AND%20%28%22gds%22%5BFilter%5D%20OR%20%22gse%22%5BFilter%5D%29&cmd=DetailsSearch > ',out_path,'/query_gse_gds_',idru,'_curl.txt'))
	system(paste0('curl https://www.ncbi.nlm.nih.gov/gds?term=%28%22',idru,'%22%5BMeSH%20Terms%5D%20OR%20',idru,'%5BAll%20Fields%5D%29%20AND%20%28%22gds%22%5BFilter%5D%20OR%20%22gse%22%5BFilter%5D%29&cmd=DetailsSearch > query_gse_gds_',idru,'_curl.txt'))
}



#curl -o geoq.txt https://www.ncbi.nlm.nih.gov/gds?term=%28%22propofol%22%5BMeSH%20Terms%5D%20OR%20propofol%5BAll%20Fields%5D%29%20AND%20%28%22gds%22%5BFilter%5D%20OR%20%22gse%22%5BFilter%5D%29&cmd=DetailsSearch








































