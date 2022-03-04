export ESGINI=/usr/local/esg-publisher-config/CCSM4/NCAR/LE/esg-le.ini
  echo "doing atm.proc.6hourly_inst"
  esgpublish --map unpub_atm.proc.6hourly_inst.txt --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.6hourly_inst
  esgpublish --map unpub_atm.proc.6hourly_inst.txt --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.6hourly_inst
