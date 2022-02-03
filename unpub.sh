export ESGINI=/usr/local/esg-publisher-config/CCSM4/NCAR/LE/esg-le.ini
  echo "doing rof.proc.monthly_ave"
  esgpublish --map unpub_rof.proc.monthly_ave.txt --delete-files --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.rof.proc.monthly_ave
  esgpublish --map unpub_rof.proc.monthly_ave.txt --delete-files --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.rof.proc.monthly_ave
