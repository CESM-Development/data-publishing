# data-publishing
This repository includes scripts for publishing data which were originally created by Ilana Stern. It is currently under heavy development. Much of the information in this document and supporting scripts were also created by Eric Nienhouse.


## Steps for Publishing Data:
### Setup
1. It is useful to begin by creating a repository with a recognizable short name in which to include the configuration files. It may be useful to locate this repository on the sagepubprod2 machine within `/usr/local/esg-publisher-config/CESM/LE/`.
2. It may be useful to create aliases to change directories into both the dataset repository and the publishing configuration repository. To do this, create a .aliases file in the home directory, include lines such as `alias shortname_config='cd /usr/local/esg-publisher-config/CESM/LE/<shortname>'` and `alias shortname_dataset='cd /glade/campaign/<dataset>'`.
3. It is recommended that users clone this repository into the configuration repository for the dataset being published in order to obtain template scripts and configuration files.
4. You will also need to get an API token from Climate Data Gateway and put it in your home directory under`~/.gateway-auth/api_token`.
### Editing configuration files
1. Begin by editing `env.sh`. This file should include the following lines, with the shortname altered as needed:
      ```
      export ESGINI=/usr/local/esg-publisher-config/CESM/LE/<shortname>/esg-le.ini
      export ESGCESMINI=/usr/local/esg-publisher-config/CESM/LE/<shortname>/esg-le.CESM.ini
      ```
2. Next, edit `esg-le.ini` with a tool such as `vi`. Include any missing passwords or secrets (you can reach out to CISL, Eric Nienhouse, or Teagan King for this information). If you need to include a new project, it can be done by changing `project_options`. One can add additional `thredds_dataset_roots` which can help minimize warnings to the console when running publishing scripts. Most of the information in this file should remain constant.
3. After editing the general configuration file, we can edit the project-specific configuration file, eg `esg-le.CESM.ini`. Be sure that the `project` matches the name that you expect, and the `experiment` matches a shortname given to the specific project you are publishing. The `dataset_id` should follow the format `ucar.cgd.cesm1.<specific_project_name>.%(submodel)s.%(product)s.%(time_frequency)s.%(myvar)s`. The directory_format should be the filepath to the data followed by `%(submodel)s/%(product)s/tseries/%(time_frequency_short)s/`. `experiment_options` should include the project-specific short name (twice). Note that the filepath should be in `/glade/campaign` or `/glade/collections` in order to ensure that it accessible for a substantial period of time. Coordinate with the PI and Gary Strand to move the dataset to a more permanent location if it is somewhere such as `/glade/scratch` or `/glade/p/univ`.
4. Once the configuration files have been loaded, run `source env.sh`. If you log out before finishing publishing, you may need to do this again to make sure `$ESGINI` and `$ESGCESMINI` are recognized.

### Create a new project, if needed

### Create variable lists for components. 
1. Edit `ext_comp_freq_vars.sh` for filepath, base dataset ID, and frequency matching string
2. Run `dovars.sh`. This will generate files named `levars_*` containing all of the variables for each component/frequency pair. If the file includes additional filepaths, check that your configuration filepaths are correct.

### Create mapfiles
1. Make a new directory within your configuration directory called `mapfiles`.
2. Edit `scan_comp_freqdir_freq_var.sh` for path and dataset ID.
3. Run `scan_<component><frequency>.sh` files to generate the checksums and create mapfiles. If it is an urgent request, you can turn off the checksums in the configuration file, but it is best to do this during this time if possible, as it may require re-doing steps if you do checksums later. Note that the scan step takes a while, but can be run simultaneously for various components in multiple terminal windows.
4. Concatenate all mapfiles into single mapfile by going into the `mapfiles` directory and running `cat ucar.cgd.cesm2.<specific_dataset_name>.<component>.proc.<freq>_ave.*.txt > ../ucar.cgd.cesm2.<specific_dataset_name>.<component>.proc.<freq>_ave.xx.txt`.

### Once configuration is set up, you are ready to publish the dataset
Note that these steps take a while, and must be done in order for each dataset, but can be run simultaneously for various components in multiple terminal windows. It may be useful to run all three commands in a script for each component.
1. Register with Publisher: This step makes sure that the publisher recognizes the dataset and is ready for publishing.
`esgpublish --offline --project CESM --parent ucar.cgd.cesm2.smyle.atm.proc.monthly_ave --map ucar.cgd.cesm2.smyle.atm.proc.monthly_ave.xx.txt`
2. Publish to THREDDS: This step publishes to the THREDDS database and must be done before publishing to the gateway.
`esgpublish --offline --noscan --project CESM --parent ucar.cgd.cesm2.smyle.atm.proc.monthly_ave --map ucar.cgd.cesm2.smyle.atm.proc.monthly_ave.xx.txt --thredds  --service fileService`
3. Publish to Gateway: This step publishes to Climate Data Gateway, where the dataset is visible in the user interface.
`esgpublish --offline --noscan --project CESM --parent ucar.cgd.cesm2.smyle.atm.proc.monthly_ave --map ucar.cgd.cesm2.smyle.atm.proc.monthly_ave.xx.txt --publish`

### Make adjustments and add metadata on the Gateway
1. The files may be put in lexical order with capital letters first and lowercase letters second. You can reorder these alphabetically by hand by clicking the `Edit` tab and `Order Datasets`. It may help to zoom out for faster scrolling and use `Ctrl-F` to mark where similar datasets need to be moved to.
2. Add the DOI, author information, and project description.
3. Grant access to the PI for reviewing a dataset by going to the parent dataset, clicking the `Edit` tab, then `Set User Permissions`, and granting read access. 
4. Once the PI has reviewed the dataset and any changes have been made, publish by clicking `Edit`, `Change Published State`, and setting the dataset to `Published`.

### Include additional metadata for DASH Search

## Steps for Unpublishing/Republishing Data:
1. Unpublish the data from Climate Data Gateway.
`esgunpublish --database-delete --map ucar.cgd.cesm2.smyle.atm.proc.6hourly_ave.xx.txt --project CESM`
2. Create a list of all of the dataset ID's to delete (part `i`), and then delete with a curl script that is created is part `ii` by running the command in part `iii`. This fully deletes the dataset.
i. `awk '{print $1}' ucar.cgd.cesm2.smyle.atm.proc.6hourly_ave.xx.txt | uniq > delete_list_atm6h.txt`
ii. `sh delete_from_list.sh delete_list_atm6h.txt > curl_delete_atm6h.sh`
iii. `sh curl_delete_atm6h.sh`
3. Republish with all three publishing steps listed above if desired.

## Close DASH request
1. Include the DOI in the `description` field.
2. Click `info recorded in description`, which will change the ticket status to `Closed`.

