#!/bin/bash

comp=ocn
freqdir=month_1
freq=monthly_ave

for var in `cat levars_ocnm`
do
  sh scan_comp_freqdir_freq_var.sh ${comp} ${freqdir} ${freq} ${var}
done
