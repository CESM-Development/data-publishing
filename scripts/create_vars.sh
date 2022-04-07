# /glade/campaign/cesm/development/espwg/SMYLE/archive/

# Note: these lines should be uncommented one frequency at a time (in alignment with the uncommented bit
# of ext_comp_freq_vars.sh) in order to run. Replace with the required components.

#year_1
#sh ext_comp_freq_vars.sh glc year_1 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_glcy

#month_1
#sh ext_comp_freq_vars.sh atm month_1 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_atmm
#sh ext_comp_freq_vars.sh ocn month_1 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_ocnm
#sh ext_comp_freq_vars.sh ice month_1 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_icem
#sh ext_comp_freq_vars.sh lnd month_1 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_lndm
#sh ext_comp_freq_vars.sh rof month_1 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_rofm

#day_1
#sh ext_comp_freq_vars.sh atm day_1 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_atmd1
#sh ext_comp_freq_vars.sh ice day_1 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_iced1
#sh ext_comp_freq_vars.sh ocn day_1 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_ocnd1
#sh ext_comp_freq_vars.sh lnd day_1 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_lndd1
#sh ext_comp_freq_vars.sh rof day_1 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_rofd1

#hour_3
#sh ext_comp_freq_vars.sh atm hour_3 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_atmh3

#hour_6
#sh ext_comp_freq_vars.sh atm hour_6 | sort | uniq | grep -v -e __xarray -e nc_temp_ > levars_atmh6
