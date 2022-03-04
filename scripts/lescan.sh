export ESGINI=/usr/local/esg-publisher-config/CCSM4/esg.ini
export ESGCCSMINI=/usr/local/esg-publisher-config/CCSM4/NCAR/LE/esg-le.CCSM.ini
rm CCSM_ucar.cgd.ccsm4.cesmLME.ice.proc.daily_ave.*.txt
for var in `cat levars_iced`
do
  echo "doing $var"
  esgscan_directory --project CCSM --dataset ucar.cgd.ccsm4.cesmLME.ice.proc.daily_ave.$var --filter '.+\.nc$' --output CCSM_ucar.cgd.ccsm4.cesmLME.ice.proc.daily_ave.$var.txt --service fileService /datazone/campaign/cesm/collections/cesmLME/CESM-CAM5-LME/ice/proc/tseries/daily/$var
#  cat CCSM_ucar.cgd.ccsm4.cesmLME.ice.proc.daily_ave.$var.txt >> CCSM_ucar.cgd.ccsm4.cesmLME.ice.proc.daily_ave.xx.txt
done

