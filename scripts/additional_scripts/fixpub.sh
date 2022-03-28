export ESGINI=/usr/local/esg-publisher-config/CCSM4/esg.ini
export ESGCCSMINI=/usr/local/esg-publisher-config/CCSM4/NCAR/LE/esg-le.CCSM.ini
#
for var in `cat fixvars_atmd`
do
  echo "doing $var"
  esgpublish --map fix.cesmLME.atm.proc.daily_ave.$var.txt --project CCSM --per-variable  --parent ucar.cgd.ccsm4.cesmLME.atm.proc.daily_ave --update
  esgpublish --map fix.cesmLME.atm.proc.daily_ave.$var.txt --project CCSM --per-variable  --parent ucar.cgd.ccsm4.cesmLME.atm.proc.daily_ave  --noscan --thredds --publish --service fileService --update
done
