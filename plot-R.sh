#!/bin/bash
#
# Generate a statistical summary for the given data vector
#
# Version 0.5
# (c) 2008 Everthon Valadao <everthonaladao@gmail.com> under the GPL
#          http://www.gnu.org/copyleft/gpl.html
#

#cd `dirname "$0"`
rm -f "/tmp/r.dat" "/tmp/r-summary.png"
#ln -s "$1" "/tmp/r.dat"

#cp "$1" "/tmp/r.dat" ; sed -i 's/,/\./g' "/tmp/r.dat"
cat "$1" | sed 's/,/\./g' > "/tmp/r.dat"

echo '
x = scan("/tmp/r.dat",na.strings = "*")
#csv = read.csv(file="/tmp/r.dat",head=TRUE,na.strings = "*",sep=" ")
#x = csv[1]

results = NULL
#results["N"] 	      = length(x)[1]
#results["%N*"]        = sum(is.na(x))/length(x)[1]*100
results["Mean"]       = mean(x,na.rm=TRUE)
results["TrMean"]     = mean (x, trim=0.05000000, na.rm=TRUE)
results["StDev"]      = sd(x,na.rm=TRUE)
results["CV"]         = sd(x,na.rm=TRUE)/mean(x,na.rm=TRUE)
results["Min"]        = min(x,na.rm=TRUE)
results["Median"]     = median(x,na.rm=TRUE)
results["Q_95"]       = quantile(x,c(0.95),na.rm=TRUE)
results["Q_99"]       = quantile(x,c(0.99),na.rm=TRUE)
results["Max"]        = max(x,na.rm=TRUE)

individual.plot = function(x) {
        png("/tmp/r-summary.png",width=640,height=480,bg="white")
#        png("/tmp/r-summary.png",width=400,height=300,bg="white")
                old.par = par(no.readonly = TRUE)
                layout(matrix(c(1,2,1,2,1,3,4,3), 2,4))

                hist(x, main="Histogram",xlab="",breaks="Sturges",lty="solid",density=-1)                
                #rug(x, side=3)                

#                histlogarea = hist(log(x), main="Histogram",xlab="",breaks="Sturges",lty="solid",density=-1,plot=FALSE);histlogarea$mids = exp(histlogarea$mids);histlogarea$breaks = exp(histlogarea$breaks);plot(histlogarea,main="Histogram",xlab="",xlim=c(0,quantile(x,na.rm=TRUE,probs=c(0.95))[1]*2));
                #rug(x, side=3)

                quantiles = quantile(x,na.rm=TRUE,probs=c(0.25,0.75))
                #q1 = quantile(x,na.rm=TRUE)[2]
                #q3 = quantile(x,na.rm=TRUE)[4] 
                q1 =  quantiles[1]
                q3 =  quantiles[2]
                IQR = abs( q3 - q1 )
#                ybounds=c( max(0,q1-IQR*1.5) , q3+IQR*1.5 )
                ybounds=c( min(min(x,na.rm=TRUE),q1-IQR*1.5) , q3+IQR*1.5 )
                boxplot (x,outline=TRUE,horizontal=TRUE,main="Boxplot",xlab="",ylim=ybounds)


                plot.ecdf (x, verticals=TRUE,col.vert="red",col.points="red",col.hor="red",main="CDF",xlab="")
#                plot.ecdf (x, verticals=TRUE,col.vert="red",col.points="red",col.hor="red",main="CDF",xlab="",xlim=c(1,max(x,na.rm=TRUE)),log="x")
#                plot.ecdf (x, verticals=TRUE,col.vert="red",col.points="red",col.hor="red",main="CDF",xlab="",xlim=c(0.01,max(x,na.rm=TRUE)),log="x")
#                plot.ecdf (x, verticals=TRUE,col.vert="red",col.points="red",col.hor="red",main="CDF",xlab="",xlim=c(max(1,min(x,na.rm=TRUE)),max(x,na.rm=TRUE)),log="x")

                plot(0:6,0:6, type = "n", axes=FALSE, xlab="", ylab="")                
                tmp = ""
                for (j in 1:length(results)[1]){
                        tmp = paste(tmp
                                        ,format(strtrim(gsub("\t","",names(results)[j]),10),width=7)," "
                                        ,format(results[j],digits=3,trim=TRUE),"\n"
                                     )
                }
		#par(family="mono") 
                legend(-1.8,8.50, tmp,bty="n",cex=1.5)		
#                legend(-0.50,7.50, tmp,bty="n")
#                legend(-1.35,7.50, tmp,bty="n")
#                legend(0.25,7.00, tmp,bty="n")
                #rect(0,0,6,6)

                par(old.par)
        graphics.off()
}

cdf.plot = function(x) {
  png("/tmp/CDF.png",width=400,height=300,bg="white")
    plot.ecdf (x, verticals=TRUE,col.vert="red",col.points="red",col.hor="red",main="CDF",xlab="")

    #mean#plot.ecdf (x, verticals=TRUE,col.vert="red",col.points="red",col.hor="red",main="CDF",xlab="",xlim=c(1,600))
    #loss#plot.ecdf (x, verticals=TRUE,col.vert="red",col.points="red",col.hor="red",main="CDF",xlab="",xlim=c(0.01,100),log="x")
    #cv  #plot.ecdf (x, verticals=TRUE,col.vert="red",col.points="red",col.hor="red",main="CDF",xlab="",xlim=c(0.1,70),log="x")
    #stdev#plot.ecdf (x, verticals=TRUE,col.vert="red",col.points="red",col.hor="red",main="CDF",xlab="",xlim=c(1,5000),log="x")
    #min#plot.ecdf (x, verticals=TRUE,col.vert="red",col.points="red",col.hor="red",main="CDF",xlab="",xlim=c(1,500))
    #assimetry#plot.ecdf (x, verticals=TRUE,col.vert="red",col.points="red",col.hor="red",main="CDF",xlab="",xlim=c(0.01,20),log="x")

  graphics.off()
}

scatterplot.plot = function(x) {
  png("/tmp/scatterplot.png",width=400,height=300,bg="white")
    plot(x,main="RTT Scatterplot",ylab="RTT (ms)",xlab="",xlim=c(0,65000),ylim=c(0,2000),type="l")
  graphics.off()
}

individual.plot(x)
#cdf.plot(x)
#scatterplot.plot(x)

q()' | R --no-save > /tmp/r.log 2>&1

mv "/tmp/r-summary.png" "${1}-r-summary.png" > /dev/null 2>&1
mv "/tmp/CDF.png" "${1}-CDF.png" > /dev/null  2>&1
mv "/tmp/scatterplot.png" "${1}-scatterplot.png" > /dev/null  2>&1

echo "$1-r-summary.png"
#eog "$1-r-summary.png" &
#open "$1-r-summary.png" &
