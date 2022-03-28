# request
# put DASH link request here

# path to data
# put path to data here

# prerequisites: create variable lists for components, edit this file for frequency and component.
# It may be useful to create duplicates of this file for various component/frequency pairs and run in parallel.

source env.sh # load esg.ini config

# scan files and make checksums; this step takes a while (potentially days)
sh scan_atmm.sh

# concatenate all mapfiles for component into single mapfile (atm mon)
cat mapfiles/ucar.cgd.cesm2.smyle.atm.proc.monthly_ave.*.txt > ucar.cgd.cesm2.smyle.atm.proc.monthly_ave.xx.txt

# register with publisher DB
esgpublish --offline --project CESM --parent ucar.cgd.cesm2.smyle.atm.proc.monthly_ave --map ucar.cgd.cesm2.smyle.atm.proc.monthly_ave.xx.txt

# publish to thredds
esgpublish --offline --noscan --project CESM --parent ucar.cgd.cesm2.smyle.atm.proc.monthly_ave --map ucar.cgd.cesm2.smyle.atm.proc.monthly_ave.xx.txt --thredds  --service fileService

# publish to gateway (atm mon)
esgpublish --offline --noscan --project CESM --parent ucar.cgd.cesm2.smyle.atm.proc.monthly_ave --map ucar.cgd.cesm2.smyle.atm.proc.monthly_ave.xx.txt --publish
