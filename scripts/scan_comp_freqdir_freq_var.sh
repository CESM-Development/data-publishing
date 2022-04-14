rootdir=/datazone/campaign/cesm/development/cvcwg/cvwg/b.e21.BHISTSSP370cmip6.f09_g17.pacemaker_pacific/*

comp=$1
freqdir=$2
freq=$3
var=$4

parentdataset=ucar.cgd.cesm2.pacific.pacemaker.${comp}.proc.${freq}
dataset=${parentdataset}.${var}
outfile=mapfiles/${dataset}.txt

esgscan_directory --project CESM --dataset ${dataset} --filter ".*\.${var}\..*nc$" --output ${outfile} ${rootdir}/${comp}/proc/tseries/${freqdir}
