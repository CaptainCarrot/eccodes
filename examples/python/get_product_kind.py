#
# Copyright 2005-2015 ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
#
# In applying this licence, ECMWF does not waive the privileges and immunities granted to it by
# virtue of its status as an intergovernmental organisation nor does it submit to any jurisdiction.
#

# Python implementation: get_product_kind
#
# Description: how to process a file containing a mix of messages
#              and print the kind of product (e.g. GRIB, BUFR etc)


import traceback
import sys
from eccodes import *

VERBOSE=1 # verbose error reporting

def example():
    if len(sys.argv) < 2:
        print >>sys.stderr, 'Usage: ',sys.argv[0],' file'
        sys.exit(1)

    f = open(sys.argv[1])
    while 1:
        id = codes_new_from_file(f, CODES_PRODUCT_ANY)
        if id is None: break
        
        print 'product: ', codes_get(id, 'kindOfProduct', str)

        codes_release(id)

    f.close()

def main():
    try:
        example()
    except CodesInternalError,err:
        if VERBOSE:
            traceback.print_exc(file=sys.stderr)
        else:
            print >>sys.stderr,err.msg

        return 1

if __name__ == "__main__":
    sys.exit(main())
