# This script provides methods to unpublish datasets. Note that the datasets must also be deleted after unpublishing to fully remove from thredds.

export ESGINI=/usr/local/esg-publisher-config/CCSM4/NCAR/LE/esg-le.ini
  echo "doing rof.proc.monthly_ave"
  esgpublish --map unpub_rof.proc.monthly_ave.txt --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.rof.proc.monthly_ave
  esgpublish --map unpub_rof.proc.monthly_ave.txt --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.rof.proc.monthly_ave
  echo "doing rof.proc.daily_ave"
  esgpublish --map unpub_rof.proc.daily_ave --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.rof.proc.daily_ave
  esgpublish --map unpub_rof.proc.daily_ave --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.rof.proc.daily_ave
  echo "doing ocn.proc.daily_ave"
  esgpublish --map unpub_ocn.proc.daily_ave --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ocn.proc.daily_ave
  esgpublish --map unpub_ocn.proc.daily_ave --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ocn.proc.daily_ave
  echo "doing lnd.proc.monthly_ave"
  esgpublish --map unpub_lnd.proc.monthly_ave.txt --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.lnd.proc.monthly_ave
  esgpublish --map unpub_lnd.proc.monthly_ave.txt --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.lnd.proc.monthly_ave
  echo "doing ice.proc.monthly_ave"
  esgpublish --map unpub_ice.proc.monthly_ave.txt --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ice.proc.monthly_ave
  esgpublish --map unpub_ice.proc.monthly_ave.txt --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ice.proc.monthly_ave
  echo "doing atm.proc.monthly_ave"
  esgpublish --map unpub_atm.proc.monthly_ave.txt --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.monthly_ave
  esgpublish --map unpub_atm.proc.monthly_ave.txt --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.monthly_ave
  echo "doing atm.proc.6hourly.inst"
  esgpublish --map unpub_atm.proc.6hourly.inst --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.6hourly.inst
  esgpublish --map unpub_atm.proc.6hourly.inst --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.6hourly.inst
  echo "doing lnd.proc.daily_ave"
  esgpublish --map unpub_lnd.proc.daily_ave.txt --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.lnd.proc.daily_ave
  esgpublish --map unpub_lnd.proc.daily_ave.txt --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.lnd.proc.daily_ave
  echo "doing ice.proc.daily_ave"
  esgpublish --map unpub_ice.proc.daily_ave.txt --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ice.proc.daily_ave
  esgpublish --map unpub_ice.proc.daily_ave.txt --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.ice.proc.daily_ave
  echo "doing atm.proc.daily_ave"
  esgpublish --map unpub_atm.proc.daily_ave.txt --update --project CCSM  --offline --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.daily_ave
  esgpublish --map unpub_atm.proc.daily_ave.txt --update --noscan --thredds  --publish --project CCSM --service HRMatNCAR --per-variable --parent ucar.cgd.ccsm4.CESM_CAM5_BGC_LE.atm.proc.daily_ave
