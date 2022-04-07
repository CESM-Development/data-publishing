# This script provides methods for fixing scans of an example CCSM4 atmospheric daily dataset.

export ESGINI=/usr/local/esg-publisher-config/CCSM4/esg.ini
export ESGCCSMINI=/usr/local/esg-publisher-config/CCSM4/NCAR/LE/esg-le.CCSM.ini
rm fix.cesmLME.atm.proc.daily_ave.*.txt
for var in `cat levars_atmd`
do
  echo "doing $var"
#  esgscan_directory --project CCSM --dataset ucar.cgd.ccsm4.cesmLME.atm.proc.daily_ave.$var --filter '.+\.nc$' --output CCSM_ucar.cgd.ccsm4.cesmLME.atm.proc.daily_ave.$var.txt --service fileService /datazone/campaign/cesm/collections/cesmLME/CESM-CAM5-LME/atm/proc/tseries/daily/$var
  esgscan_directory --project CCSM --dataset ucar.cgd.ccsm4.cesmLME.atm.proc.daily_ave.$var --filter '.+abrupt.+\.nc$' --output fix.cesmLME.atm.proc.daily_ave.$var.txt --service fileService /datazone/campaign/cesm/collections/cesmLME/CESM-CAM5-LME/atm/proc/tseries/daily/$var
  esgscan_directory --project CCSM --dataset ucar.cgd.ccsm4.cesmLME.atm.proc.daily_ave.$var --filter '.+ramp.+\.nc$' --output fix1.cesmLME.atm.proc.daily_ave.$var.txt --service fileService /datazone/campaign/cesm/collections/cesmLME/CESM-CAM5-LME/atm/proc/tseries/daily/$var
  cat fix1.cesmLME.atm.proc.daily_ave.$var.txt >> fix.cesmLME.atm.proc.daily_ave.$var.txt
  rm fix1.cesmLME.atm.proc.daily_ave.$var.txt
done

