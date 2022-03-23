MM_to_amiga<- function() {
  folder <- ""
  time <- ""
  output_filename <- ""
  while (folder == "") {
    folder<-readline(prompt = "Enter the location of folder:") }
  while (time == "") {
    time<-readline(prompt = "Enter the number of rows/readings:") }
  while (output_filename == "") {
    output_filename<-readline(prompt = "Enter the name of the outputfile:") }
  #set global variable for files in folder
  a<-paste(folder,"/*.tsv",sep="")
  #set list of files in folder
  b<-Sys.glob(a)
  #define length of string for deliniation between samples
  c<-nchar(folder)+2
  #global variable for final output
  time<-as.numeric(time)
  d<-as.data.frame(seq(0, length.out=time, by=20))
  colnames(d)<-c("Time")
  #loop through files
  for (e in b) {
    #define length of string for deliniation between samples
    f<-nchar(e)-4
    #read in file
    g<-read.table(e,header=T)
    #remove SD and mean
    g<-g[,c(2:4)]
    #set variables for column names and change column names
    h<-substr(e,c,f)
    i<-paste0(h,"_port_1")
    j<-paste0(h,"_port_2")
    k<-paste0(h,"_port_3")
    colnames(g)<-c(i,j,k)
    #remove negatives
    l<-abs(g)
    #add time in increments of 20
    l$Time<-seq(0, length.out=nrow(l), by=20)
    #merge data
    d<-merge(d,l,by="Time")
  }
  #transpose data
  m<-as.data.frame(t(d))
  n<-paste0(folder,"/",output_filename,".txt")
  write.table(m,n, sep="\t",row.names=T,quote=F,col.names=F)
}
