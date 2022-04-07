# This script concatenates mapfiles for all variables into one mapfile that can be used for the entire ocean monthly dataset including many variables.
# Note that it is useful to have a mapfiles directory to store all of the mapfiles, and then concatenate them into a general mapfile in the main directory.

export ESGINI=/usr/local/esg-publisher-config/esg-le.ini
for var in `cat levars_ocnfix` 
do
  echo "doing $var"
  cat CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ocn.proc.monthly_ave.$var.txt >> CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ocn.proc.monthly_ave.txt
#  esgpublish --map CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.monthly_ave.$var.txt --project CCSM --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.monthly_ave
#  esgpublish --map CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.monthly_ave.$var.txt --noscan --thredds --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.monthly_ave
done
