# replace path with relevant data directory and uncomment relevant section when running dovars.sh for a particular frequency

comp=$1
freqdir=$2

for path in `find /datazone/campaign/cesm/development/espwg/SMYLE/archive/b.e21.BSMYLE.f09_g17.2019-11.020/${comp}/proc/tseries/${freqdir}/ -type f -name "*.nc"`
do
  file=`basename $path`

  #yearly
  #var=$(echo $file | sed -e "s/^.*\.\(.*\)\.....-.....nc$/\1/");

  #monthly
  #var=$(echo $file | sed -e "s/^.*\.\(.*\)\.......-.......nc$/\1/");

  #daily
  #var=$(echo $file | sed -e "s/^.*\.\(.*\)\.........-.........nc$/\1/");

  #hourly (1,3,6)
  #var=$(echo $file | sed -e "s/^.*\.\(.*\)\...........-...........nc$/\1/");

  echo $var
done