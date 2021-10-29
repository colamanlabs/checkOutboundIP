#!/bin/bash

################################################################################
# SCRIPT_COMMON_CONFIG
################################################################################
export TODAY_TIMESTAMP_FULL=`date +"%Y%m%d_%H%M%S"`
export TODAY_TIMESTAMP_DATE=`date +"%Y%m%d"`


################################################################################
# APP_CONFIG
################################################################################
export APP_NAME=checkOutboundIP
export APP_HOME=/home/colaman/WORKS/WORKS_COLAMAN/networkWorks/checkOutboundIP
export APP_LOG=$APP_HOME/logs/checkOutboundIP.log.$TODAY_TIMESTAMP_DATE.txt
export RESULT_FILE=$APP_HOME/data/ip.txt
export OUTBOUND_IP=`/usr/bin/curl ipinfo.io/ip`


################################################################################
# APP_EXECUTE
################################################################################
echo $OUTBOUND_IP > $RESULT_FILE
echo [$TODAY_TIMESTAMP_FULL] $OUTBOUND_IP >> $APP_LOG

