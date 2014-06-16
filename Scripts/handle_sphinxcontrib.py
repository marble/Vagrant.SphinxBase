#! /usr/bin/python
# handle_sphinxcontrib.py, mb, 2014-06-13, 2014-06-14

from __future__ import print_function
import re
import sys
import urllib

site = 'https://bitbucket.org'
downloadpage = '/xperseguers/sphinx-contrib/downloads'
unpackfolderprefix = 'xperseguers-sphinx-contrib-'
result = ''
exitcode = 1
try:
    # looking for: href="/xperseguers/sphinx-contrib/get/3fe09d84cbef.zip"
    data = urllib.urlopen(site + downloadpage).read()
except:
    data = None
if data:
    m = re.search('href="(/xperseguers/sphinx-contrib/get/([0-9a-f]+)\.zip)"', data)
    if m:
        result = site + m.group(1)
        exitcode = 0
if exitcode == 0:
    print('sphinxcontrib_zip_url=%s%s' % (site, m.group(1)))
    print('sphinxcontrib_hash=%s' % m.group(2) )
    print('sphinxcontrib_unpackfolder=%s%s' % (unpackfolderprefix, m.group(2)))
sys.exit(exitcode)
