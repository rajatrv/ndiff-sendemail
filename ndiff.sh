#!/bin/bash
#http://nmap.org/book/ndiff-man-periodic.html
#http://www.security-marathon.be/?p=22
# Variables
TODAY=`date +%F`
OUTPUT_DIR=/home/sgaudet/nmap/scans
SCAN_BASE=$OUTPUT_DIR/scan_baseline.xml
SCAN_CURR=$OUTPUT_DIR/scan_current.xml
REPORT_FILE=$OUTPUT_DIR/scan_ndiff.txt
RECIPIENT='samuel.gaudet@maine.edu'
NET_BLOCK='10.0.0.0'

# Script
touch $SCAN_BASE
nmap -v -T4 -F -sV -oX $SCAN_CURR $NET_BLOCK
ndiff $SCAN_BASE $SCAN_CURR > $REPORT_FILE
#email results
#mail $RECIPIENT -s "Network Scan" < $REPORT_FILE
#download - http://caspian.dotconf.net/menu/Software/SendEmail/
./sendEmail -f "nmap@security-scanner2.iso.maine.edu" -t $RECIPIENT -s mail.maine.edu -u "Network diff report" -o message-file=$REPORT_FILE

cp $SCAN_CURR $SCAN_BASE

# add to crontab
# ex 00:10
# 10 0 * * * sh /home/sgaudet/nmap/ndiff.sh
