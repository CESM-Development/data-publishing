# data-publishing
## These scripts are for use by the NCAR CGD data publishing team. If you are a PI who would like to publish a dataset on Climate Data Gateway, please submit a [DASH ticket](https://ithelp.ucar.edu/plugins/servlet/desk/site/dash), and we'll take care of the publishing process for you!

## Note that we are undergoing a transition from the Climate Data Gateway to the RDA as of early 2024, so the processes and scripts in this repository may become obsolete.

## Authors:
- Teagan King
- Ilana Stern
- Eric Nienhouse

## Steps for Publishing Data:
### Create Dataset on Climate Data Gateway
1. Navigate to the [Climate Data Gateway](https://www.earthsystemgrid.org/), select a relevant model output type, and create a new child dataset by clicking on the `Edit` tab and then selecting `Create New Child Dataset`. The shortname should be something like `ucar.cgd.<model>.<experiment>` and the longname can be the title of the experiment.
2. Include description, authors, and DOI in the project description.
3. Create child datasets for each component/frequency pair. These can have a long name such as `<model> <experiment> <component> Post Processed Data <frequency> Averages` and a short name such as `ucar.cgd.<model>.<experiment>.<component>.proc.<freq>_ave`

### Setup
1. It is useful to begin by logging into the sagepubprodalma machine via `SSH` and moving to the `/usr/local/esg-publisher-config/CESM/LE/` directory. Then, clone this repository with `git clone https://github.com/CESM-Development/data-publishing.git`. In order to create new directories for each dataset, it is recommended to then move this directory to a new name, i.e. `mv data-publishing <short name for dataset>`.
2. It may be useful to create aliases to change directories into both the dataset repository and the publishing configuration repository. To do this, create a .aliases file in the home directory, include lines such as `alias shortname_config='cd /usr/local/esg-publisher-config/CESM/LE/<shortname>'` and `alias shortname_dataset='cd /glade/campaign/<dataset>'`. It may also be a nice feature to automatically source the env.sh file within the `shortname_config` command; to do so, add an additional line within the quotes that reads `source config_files/env.sh`, for instance.
3. You will also need to get an API token from Climate Data Gateway and put it in your home directory under`~/.gateway-auth/api_token`.
4. Ensure that your bash profile includes the correct information to activate the publisher environment with `. /usr/local/publisher_activate`. Talk to Teagan King or Jason Cunning to do this. There should be an `ncar-pub` publisher environment listed in the prompt, and `esgpublish` and `esgscan_directory` for instance should point to `/usr/local/conda/envs/ncar-pub/bin/esgpublish` and `/usr/local/conda/envs/ncar-pub/bin/esgscan_directory`, respectively. 

### Editing configuration files
1. Begin by editing `env.sh`. This file should include the following lines, with the shortname altered as needed:
      ```
      export ESGINI=/usr/local/esg-publisher-config/CESM/LE/<shortname>/config_files/esg-le.ini
      export ESGCESMINI=/usr/local/esg-publisher-config/CESM/LE/<shortname>/config_files/esg-le.CESM.ini
      ```
2. Next, edit `esg-le.ini` with a tool such as `vi`. Include any missing passwords or secrets (you can reach out to CISL, Eric Nienhouse, or Teagan King for this information). If you need to change the project, it can be done by changing `project_options`. You should also change `thredds_dataset_roots` to the lowest-level dataset root that encompasses the project. Most of the other information in this file should remain constant.
3. After editing the general configuration file, we can edit the project-specific configuration file, eg `esg-le.CESM.ini`. Be sure that the `project` matches the name that you expect, and the `experiment` matches a shortname given to the specific project you are publishing. The `dataset_id` should follow the format `ucar.cgd.cesm1.<specific_project_name>.%(submodel)s.%(product)s.%(time_frequency)s.%(myvar)s`. The directory_format should be the filepath to the data followed by `%(submodel)s/%(product)s/tseries/%(time_frequency_short)s/`. `experiment_options` should include the project-specific short name (twice). Note that the filepath should be in `/datazone/campaign` or `/datazone/collections` in order to ensure that it accessible for a substantial period of time. Coordinate with the PI and Gary Strand to move the dataset to a more permanent location in `glade/` if it is somewhere such as `/glade/scratch` or `/glade/p/univ`.
4. Once the configuration files have been loaded, run `source env.sh`. If you log out before finishing publishing, you may need to do this again to make sure `$ESGINI` and `$ESGCESMINI` are recognized.

### Create a new project, if needed
This should only be done if you need a new `project` equivalent to CESM, CCSM, AMPS, ARTMIP, etc.
1. Add project (and additional relevant information that is consistent with the rest of the table formatting) to the table listed at /usr/local/esg-publisher-config/esgcet_models_table.txt
2. Update the `project` in both `esg-le.ini` and `esg-le.<project_name>.ini`. Source `env.sh`, ensuring that it is pointing to the correct `esg-le.ini` and `esg-le.<project_name>.ini` files, as this will be used in the next step to determine which projects to reinitialize.
3. Run `esginitialize -c` in order to reinitialize the esg publisher.
4. Create a new project at [https://www.earthsystemgrid.org/root/index.html](https://www.earthsystemgrid.org/root/index.html).
5. Create a new top level dataset at [https://www.earthsystemgrid.org/root/index.html](https://www.earthsystemgrid.org/root/index.html), and change the project from 'inherited' to the project name that was created in the previous step.
6. To confirm that your project was created, you can check that it is listed on the [Projects](https://www.earthsystemgrid.org/project.html) page.

### Create a new parent dataset
1. Navigate to a parent dataset in [Climate Data Gateway](https://www.earthsystemgrid.org/), such as the [CESM2 Model Output](https://www.earthsystemgrid.org/dataset/ucar.cgd.cesm2.output.html).
2. In the `Edit` tab, `Create New Child Dataset`. Fill in the title of dataset and shortname.

### Create variable lists for components
1. In the `scripts` directory, create a subdirectory `levars` with `mkdir levars`. This directory will contain lists of large ensemble variables.
2. Edit `ext_comp_freq_vars.sh` for filepath, base dataset ID, and frequency matching string
3. Run `create_vars.sh` for each of the frequencies. This will generate files named `levars_*` containing all of the variables for each component/frequency pair. If the file includes additional filepaths, check that your configuration filepaths are correct.

### Create mapfiles
1. Make a new directory within your configuration directory called `mapfiles`.
2. Edit `scan_comp_freqdir_freq_var.sh` for path and dataset ID.
3. Duplicate the `scan_<component><frequency>.sh` file for however many component/frequency pairs are needed. Edit the component/frequency listed in each of the files. Be sure to edit `comp`, `freqdir`, `freq`, as well as the `levars_<comp><freq>` file listed in the for loop. Note that it may be useful to test with one frequency/component pair before running all of these.
4. Make a directory for the command line output for running with no hangups with `mkdir nohup`.
5. Run `scan_<component><frequency>.sh` files to generate the checksums and create mapfiles with a command such as `nohup sh scan_<component><frequency>.sh > nohup/scan_<component><frequency>.out` in order to run with no hangups. If it is an urgent request, you can turn off the checksums in the configuration file, but it is best to do this during this time if possible, as it may require re-doing steps if you do checksums later. Note that the scan step takes a while, but can be run simultaneously for various components in multiple terminal windows.
7. Concatenate all mapfiles into single mapfile by going into the `mapfiles` directory and running `cat ucar.cgd.cesm2.<specific_dataset_name>.<component>.proc.<freq>_ave.*.txt > ../ucar.cgd.cesm2.<specific_dataset_name>.<component>.proc.<freq>_ave.xx.txt`. In order to do this, it may be useful to duplicate the line in `main_publishing_script.sh` and then run all of the commands in the terminal consecutively.
8. Check that the file paths look as expected in the mapfiles; eg, look for any additional slashes and ensure that `datazone` is used instead of `glade`.

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
1. In order to include a dataset in [DASH Search](https://data.ucar.edu/dataset), the metadata must include a valid title, description, short name, author, publisher (UCAR/NCAR - Climate and Global Dynamics Laboratory), metadata support contact (esg-support@earthsystemgrid.org), resource support contact (esg-support@earthsystemgrid.org), legal constraints, access constraints, and language. If any of these need to be added, please do so in the Climate Data Gateway user interface. You can verify whether any of these need to be updated by going to the dataset in Climate Data Gateway, clicking `Edit` and then `Check dataset publishing state`; any red `x` will result in a failure to be added to DASH.
2. Include any desired GCMD keywords.
3. Add dataset record to DASH search by generating ISO using the following URL: `https://www.earthsystemgrid.org/dataset/<short>.xml?type=iso19139`. Right click to save the `.xml` file (copying will remove the formatting), then upload this ISO XML file to the [CGD git repo](https://github.com/NCAR/dash-cgd-prod).
4. Error logs and output from the last production job that transferred data from the github repo to DASH are available [here](https://data.ucar.edu/harvest/dash-cgd-prod/job/last) if you have a login. If debugging is needed, there is also a [dev version of WAF](https://github.com/NCAR/dset-web-accessible-folder-dev) where one can upload `.xml` files to a [development version of DASH](https://ckandev.ucar.edu/). [Error logs and output for the dev version](https://ckandev.ucar.edu/harvest/dev-waf/job/last) are also available.

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

## Common Errors / FAQ's
1. There's a 404 error on Climate Data Gateway netcdf headers when click `view`; what do I do?
There may be an issue with the filepath (eg, make sure your project specific config file points to `/datazone` instead of `/glade`). Try unpublishing and republishing.
2. The project does not have an option to share with the PI. 
Try temporarily adding PI as having view permissions on parent dataset.
3. The files are now labeled as `.nc_0` or some other `.nc_#`, and the NetCDF Header View is no longer working. 
One way to address this issue with automatic renaming of files due to multiple versions is to "delete", then "api delete from gateway", then "database delete". To do this, use the following steps:
    - `$ esgunpublish --database-delete –project CESM ucar.cgd.cesm2.SHORTNAME.COMP.proc.FREQ.VARIABLE`
    - `$ sh curl_delete_VARIABLE.sh` (see section above titled [`Steps for Unpublishing/Republishing Data`](https://github.com/CESM-Development/data-publishing/blob/main/README.md#steps-for-unpublishingrepublishing-data) to see how to generate this script)
    - `$ esgunpublish --database-delete --database-only --project CESM ucar.cgd.cesm2.SHORTNAME.COMP.proc.FREQ.VARIABLE`
4. NetCDF headers are not showing up, or 404 errors result from trying to download file that is available on /datazone. Why would they not be available?
There may be an issue with soft links that are created on sagepubprodalma, but not on the TDS virtual machine (for downloading file issue) or not on the esg production instance (for viewing NetCDF headers). Check for missing soft links! Talk to Jason Cunning to add soft links.
5. Publishing failures might be due to either endpoints not being normalized (double slashes) or 'campaign' existing in the filepath. In order to address double slashes, you might need to remove the slash after `fileServer` in `esg-le.ini` and maintain the slash before `datazone` in the second part of the tds root path but remove the slash before the first part of the tds root path. In order to remove 'campaign' from filepaths, soft links are recommended (See #4 and add soft link to all three locations). 
