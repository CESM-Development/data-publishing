export ESGINI=/usr/local/esg-publisher-config/esg-le.ini
for var in `cat mevars_atmm` 
do
  echo "doing $var"
  esgscan_directory --project CCSM --dataset ucar.cgd.ccsm4.CESM_CAM5_BGC_ME.atm.proc.monthly_ave.$var --filter '.+\.nc$' --output CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_ME.atm.proc.monthly_ave.$var.txt --offline --service HRMatNCAR /CCSM/csm/CESM-CAM5-BGC-ME/atm/proc/tseries/monthly/$var
#  esgpublish --map CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.monthly_ave.$var.txt --project CCSM --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.monthly_ave
#  esgpublish --map CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.monthly_ave.$var.txt --noscan --thredds --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.monthly_ave
done
