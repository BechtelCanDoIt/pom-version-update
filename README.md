What it is
==========

An extremely crude, quite unintelligent tool you can use to update the versions of pom.xml files inside a directory,
recursively.  The only thing it has going for it is that it will (attempt) to ensure pom version hierarchies (parent pom
versions, basically) are properly updated in the event that during the process, someone's parent pom got a version bump.  This tool is also quite limited in that you cannot control how it behaves apart from what version number to use (and whether it is running or not ;-)

How it works
===============

POSIX find and XSLT transforms (plus a few hacky tricks to appease the XML parser in the case of some very specific
cases of invalid XML (read: project-dependent, and thanks WSO2!)  For more info, just look at the code.  It's not that
long.
