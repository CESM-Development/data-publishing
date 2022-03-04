export ESGINI=/usr/local/esg-publisher-config/CCSM4/esg.ini
export ESGCCSMINI=/usr/local/esg-publisher-config/CCSM4/NCAR/LE/esg-le.CCSM.ini
#
for var in `cat fix_ocnm`
do
  echo "doing $var"
  esgpublish --map CCSM_ucar.cgd.ccsm4.cesmLME.ocn.proc.monthly_ave.$var.txt --project CCSM --per-variable  --parent ucar.cgd.ccsm4.cesmLME.ocn.proc.monthly_ave
  esgpublish --map CCSM_ucar.cgd.ccsm4.cesmLME.ocn.proc.monthly_ave.$var.txt --project CCSM --per-variable  --parent ucar.cgd.ccsm4.cesmLME.ocn.proc.monthly_ave  --noscan --thredds --publish --service fileService
#  esgpublish --map CCSM_ucar.cgd.ccsm4.cesmLME.ocn.proc.monthly_ave.$var.txt --project CCSM --per-variable  --parent ucar.cgd.ccsm4.cesmLME.ocn.proc.monthly_ave  --noscan --publish --service fileService
done
