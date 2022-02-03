export ESGINI=/usr/local/esg-publisher-config/CCSM4/esg.ini
export ESGCCSMINI=/usr/local/esg-publisher-config/CCSM4/NCAR/LE/esg-le.CCSM.ini
#export ESGINI=/usr/local/esg-publisher-config/CCSM4/NCAR/LE/esg-le.ini
rm CCSM_ucar.cgd.ccsm4.CESM_CAM5_LME.atm.proc.6hourly_inst.*.txt
for var in `cat levars_atm6` 
do
  echo "doing $var"
  esgscan_directory --project CCSM --dataset ucar.cgd.ccsm4.CESM_CAM5_LME.atm.proc.6hourly_inst.$var --filter '.+\.nc$' --output CCSM_ucar.cgd.ccsm4.CESM_CAM5_LME.atm.proc.6hourly_inst.$var.txt --offline --service HRMatNCAR /CCSM/csm/CESM-CAM5-LME/atm/proc/tseries/hourly6/$var
  cat CCSM_ucar.cgd.ccsm4.CESM_CAM5_LME.atm.proc.6hourly_inst.$var.txt >> CCSM_ucar.cgd.ccsm4.CESM_CAM5_LME.atm.proc.6hourly_inst.xx.txt
done
