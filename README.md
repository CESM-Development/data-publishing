# data-publishing
This repository includes scripts for publishing data which were originally created by Ilana Stern. It is currently under heavy development.



## Publishing Data
### Setup
1. It is useful to begin by creating a repository with a recognizable short name in which to include the configuration files. It may be useful to locate this repository on the sagepubprod2 machine within `/usr/local/esg-publisher-config/CESM/LE/`.
2. It may be useful to create aliases to change directories into both the dataset repository and the publishing configuration repository. To do this, create a .aliases file in the home directory, include lines such as `alias shortname_config='cd /usr/local/esg-publisher-config/CESM/LE/<shortname>'` and `alias shortname_dataset='cd /glade/campaign/<dataset>'`.
3. It is recommended that users clone this repository `********` into the configuration repository for the dataset being published.
4. You will also need to get an API token from Climate Data Gateway and put it in your home directory under`*********`.
### Editing configuration files
1. Begin by editing `env.sh`. This file should include the following lines, with the shortname altered as needed:
      ```export ESGINI=/usr/local/esg-publisher-config/CESM/LE/<shortname>/esg-le.ini
      export ESGCESMINI=/usr/local/esg-publisher-config/CESM/LE/<shortname>/esg-le.CESM.ini```
2. Next, edit `esg-le.ini` with a tool such as `vi`. Include any missing passwords or secrets (you can reach out to CISL, Eric Nienhouse, or Teagan King for this information). If you need to include a new project, it can be done by changing `project_options`. One can add additional `thredds_dataset_roots` which can help minimize warnings to the console when running publishing scripts. Most of the information in this file should remain constant.
3. After editing the general configuration file, we can edit the project-specific configuration file, eg `esg-le.CESM.ini`. Be sure that the `project` matches the name that you expect, and the `experiment` matches a shortname given to the specific project you are publishing. The `dataset_id` should follow the format `ucar.cgd.cesm1.<specific_project_name>.%(submodel)s.%(product)s.%(time_frequency)s.%(myvar)s`. The directory_format should be the filepath to the data followed by `%(submodel)s/%(product)s/tseries/%(time_frequency_short)s/`. `experiment_options` should include the project-specific short name (twice).
4. Once the configuration files have been loaded, run `source env.sh`. If you log out before finishing publishing, you may need to do this again to make sure `$ESGINI` and `$ESGCESMINI` are recognized.

### Create variable lists for components. 
1. Edit `ext_comp_freq_vars.sh` for filepath, base dataset ID, and frequency matching string
2. Run `dovars.sh`. This will generate files named `levars_*` containing all of the variables for each component/frequency pair. If the file includes additional filepaths, check that your configuration filepaths are correct.

### Create mapfiles
1. Make a new directory within your configuration directory called `mapfiles`.
2. Edit `scan_comp_freqdir_freq_var.sh` for path and dataset ID.
3. Run `scan_<component><frequency>.sh` files to generate the checksums and create mapfiles. If it is an urgent request, you can turn off the checksums in the configuration file, but it is best to do this during this time if possible, as it may require re-doing steps if you do checksums later.
4. Concatenate all mapfiles into single mapfile by going into the `mapfiles` directory and running `cat ucar.cgd.cesm2.<specific_dataset_name>.<component>.proc.<freq>_ave.*.txt > ../ucar.cgd.cesm2.<specific_dataset_name>.<component>.proc.<freq>_ave.xx.txt`.

### Register with Publisher
`esgpublish --offline --project CESM --parent ucar.cgd.cesm2.smyle.atm.proc.monthly_ave --map ucar.cgd.cesm2.smyle.atm.proc.monthly_ave.xx.txt`
### Publish to THREDDS
`esgpublish --offline --noscan --project CESM --parent ucar.cgd.cesm2.smyle.atm.proc.monthly_ave --map ucar.cgd.cesm2.smyle.atm.proc.monthly_ave.xx.txt --thredds  --service fileService`
### Publish to Gateway
`esgpublish --offline --noscan --project CESM --parent ucar.cgd.cesm2.smyle.atm.proc.monthly_ave --map ucar.cgd.cesm2.smyle.atm.proc.monthly_ave.xx.txt --publish`


## Unpublishing Data
