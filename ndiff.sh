#!/bin/sh
#http://nmap.org/book/ndiff-man-periodic.html
#http://intellavis.com/blog/?p=233
#http://www.security-marathon.be/?p=22
# Variables
TODAY=`date +%F`
OUTPUT_DIR=$(dirname $0)/scans
SCAN_BASE=$OUTPUT_DIR/baseline.xml
SCAN_CURR=$OUTPUT_DIR/current.xml
REPORT_FILE=$OUTPUT_DIR/ndiff.xml
RECIPIENT='samuel.gaudet@maine.edu'
NET_BLOCK='192.168.1.0/24'
 
# Script
touch $SCAN_BASE
nmap -v -T4 -F -sV -oX $SCAN_CURR $NET_BLOCK
ndiff --xml $SCAN_BASE $SCAN_CURR > $REPORT_FILE

# PeepingTom - LaNMaSteR53
#python ./peepingtom.py -x /scans/ndiff.xml

# SendEmail - http://caspian.dotconf.net/menu/Software/SendEmail/
./sendEmail -f "nmap@security-scanner2.iso.maine.edu" -t samuel.gaudet@maine.edu -s mail.maine.edu -u "Network diff report" -o message-file=/home/sgaudet/nmap/scans/scan_ndiff.txt

cp $SCAN_CURR $SCAN_BASE
