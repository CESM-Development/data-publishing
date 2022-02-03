export ESGINI=/usr/local/esg-publisher-config/esg-le.ini
for var in `cat mevars_icem` 
do
  echo "doing $var"
  esgscan_directory --project CCSM --dataset ucar.cgd.ccsm4.CESM_CAM5_BGC_ME.ice.proc.monthly_ave.$var --filter '.+\.nc$' --output CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_ME.ice.proc.monthly_ave.$var.txt --offline --service HRMatNCAR /CCSM/csm/CESM-CAM5-BGC-ME/ice/proc/tseries/monthly/$var
  cat CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_ME.ice.proc.monthly_ave.$var.txt >> CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_ME.ice.proc.monthly_ave.all.txt
done
