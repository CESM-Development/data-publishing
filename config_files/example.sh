# example test publish script/steps
#
# pre-reqs
# -  Climate Data Gateway account, write privs, token
# -  API Token File: ~/.gateway-auth/api_token
# -  Update configuration files and contact Teagan King if need help with retreiving usernames/passwords marked as 'NEED_TO_RETRIEVE_THIS_VALUE'
# -  Review $ESGINI: checksums? other ?
#
# publishing steps
#
# 1) setup $ESGCCSMINI file for experiment/files (path, experiment, maps, etc)
# 2) scan files
# 3) register files with database
# 4) publish files to thredds
# 5) publish files to climate data gateway

# scan files, register with database
esgscan_directory --project CCSM --output mapfile.txt --filter ^.*\.nc$ /glade/scratch/tking/f.e21.B1850.f19_g17.25yr_test.001/run/

# publish step 1 - register with publisher client database
# add experiment to $ESGCCSMINI file

esgpublish --project CCSM --map mapfile.txt --offline

# publish step 2 - publish to thredds 

esgpublish --noscan --project CCSM --map mapfile.txt --thredds --service fileService

# publish step 2 - publish to gateway

esgpublish --noscan --project CCSM --map mapfile.txt --publish

# unpublish/delete dataset

esgunpublish --database-delete --project CCSM --skip-gateway  ucar.cgd.cesm.f.e21.B1850.f19_g17.25yr_test.001
