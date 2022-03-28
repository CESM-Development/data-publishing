export ESGINI=/usr/local/esg-publisher-config/CCSM4/NCAR/LE/esg-le.ini
rm CCSM_ucar.cgd.ccsm4.CCSM4-HDEG.lnd.proc.6hourly_ave.xx.txt
for var in `cat levarshd_lnd6`
do
  echo "doing $var"
  esgscan_directory --project CCSM --dataset ucar.cgd.ccsm4.CCSM4-HDEG.lnd.proc.6hourly_ave.$var --filter '.+\.nc$' --output CCSM_ucar.cgd.ccsm4.CCSM4-HDEG.lnd.proc.6hourly_ave.$var.txt --offline --service HRMatNCAR /CCSM/csm/CCSM4-HDEG/lnd/proc/tseries/hourly6/$var
  cat CCSM_ucar.cgd.ccsm4.CCSM4-HDEG.lnd.proc.6hourly_ave.$var.txt >> CCSM_ucar.cgd.ccsm4.CCSM4-HDEG.lnd.proc.6hourly_ave.xx.txt
done

