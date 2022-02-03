export ESGINI=/usr/local/esg-publisher-config/CCSM4/NCAR/LE/esg-le.ini
  echo "doing ice.proc.monthly_ave"
  esgpublish --map CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ice.proc.monthly_ave.xx.txt --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ice.proc.monthly_ave
  esgpublish --map CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ice.proc.monthly_ave.xx.txt --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ice.proc.monthly_ave
