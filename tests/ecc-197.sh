#!/bin/sh
# Copyright 2005-2016 ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# 
# In applying this licence, ECMWF does not waive the privileges and immunities granted to it by
# virtue of its status as an intergovernmental organisation nor does it submit to any jurisdiction.
#

. ./include.sh

# ---------------------------------------------------------
# This is the test for the JIRA issue ECC-197.
# It tests decoding a BUFR file which cannot be done unless
# we extend the definitions to include extra files
# ---------------------------------------------------------

# Create a temporary directory which holds the tables etc
TEMP_DIR=ecc-197-temp-dir.$$
rm -rf $TEMP_DIR
mkdir -p $TEMP_DIR/definitions/bufr/tables/0/wmo/26

# Copy the definition files needed to decode BUFR file
def_files="${proj_dir}/tests/ECC-197/*"
for df in ${def_files}; do
  cp -f $df $TEMP_DIR/definitions/bufr/tables/0/wmo/26
done

# Point ecCodes to look in this dir as well as standard one
MY_DEFS=`pwd`/$TEMP_DIR/definitions
export ECCODES_DEFINITION_PATH=$MY_DEFS:$ECCODES_DEFINITION_PATH

# Now decode
${tools_dir}bufr_dump ${data_dir}/bufr/vos308014_v3_26.bufr >/dev/null

rm -rf $TEMP_DIR

