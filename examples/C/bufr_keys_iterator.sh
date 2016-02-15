#!/bin/sh
# Copyright 2005-2016 ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# 
# In applying this licence, ECMWF does not waive the privileges and immunities granted to it by
# virtue of its status as an intergovernmental organisation nor does it submit to any jurisdiction.
#

set -x
. ./include.sh


#Define a common label for all the tmp files
label="bufr_keys_iterator_test_c"

#Define tmp file
fTmp=${label}".tmp.txt"
rm -f $fTmp | true

REDIRECT=/dev/null

f=${data_dir}/bufr/syno_1.bufr

#Dump the keys
${examples_dir}c_bufr_keys_iterator $f 2> $REDIRECT > $fTmp

#TODO: check the output

#cat  $fTmp

#Clean up
rm -f $fTmp | true
