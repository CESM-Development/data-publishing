export ESGINI=/usr/local/esg-publisher-config/esg-le.ini
  esgpublish --map CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_ME.ice.proc.monthly_ave.all.txt --project CCSM --replace --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_ME.ice.proc.monthly_ave
  esgpublish --map CCSM_ucar.cgd.ccsm4.CESM_CAM5_BGC_ME.ice.proc.monthly_ave.all.txt --project CCSM --replace --noscan --thredds --publish --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_ME.ice.proc.monthly_ave
