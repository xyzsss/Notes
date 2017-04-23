#!/usr/bin/python

import sys
import locale

# Get python sys default encode,value is 'ascii'
default_code = sys.getdefaultencoding()
print "Before,Current system default code is:", default_code

# Reset sys default code 'ascii' to utf-8
reload(sys)
sys.setdefaultencoding('utf-8')

default_code = sys.getdefaultencoding()
print "After,changed,Current system default code is:", default_code

print "Unicode filename to system filename code:", sys.getfilesystemencoding()
print "System locale settting and code way:", locale.getdefaultlocale()
print "Text data file encoding way:", locale.getpreferredencoding()

# stdin/stdout/stderr code style
print sys.stdin.encoding
print sys.stdout.encoding
print sys.stderr.encoding
