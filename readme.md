# checkOutboundIP


<br/><br/>
<img src="https://github.com/colamanlabs/checkOutboundIP/blob/main/home_server_network_20211024.drawio.png?raw=true" />

<br/><br/><br/>
## 1. 목표
- 홈서버 관리를 위해서는 홈서버의 outbound NAT IP 를 알아야 한다.
- 홈서버의 outbound NAT IP 는 고정 IP 가 아닌, 유동 IP 이다.
- 관리자에게 정기적으로 outbound NAT IP 알림을 보낸다.
- 알림은 라인 앱 봇을 사용해서 전달한다.


<br/><br/><br/>
## 2. 홈서버의 outbound NAT IP 를 확인하기

outbound IP 를 확인해주는 웹 서비스가 있다.

ex)
http://ipconfig.co.kr/

그러나, 많은 곳이 스타일을 포함한 완성된 페이지(html) 이거나,   
IP 외에 추가적인 정보를 제공한다.   
   
**따라서, IP 만 추려내기 위해서는 텍스트 가공이 불가피 하다.**

작업량을 줄이기 위해서는 IP 만 제공하는 서비스를 찾아야 한다.   
   
   
https://ipinfo.io/ip


IP 만 응답해주는 API 이다. 별도로 가공이 불필요하다.


<br/><br/><br/>
## 3. outbound NAT IP 를 확인하는 스크립트 작성(checkOutboundIP.sh)

curl 로 API 를 호출해서, 결과를 지정된 경로에 파일로 적재한다.

<pre><code>
colaman@default3:~/WORKS/WORKS_COLAMAN/networkWorks/checkOutboundIP$ cat ./checkOutboundIP.sh 

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

colaman@default3:~/WORKS/WORKS_COLAMAN/networkWorks/checkOutboundIP$ 
</code></pre>



<br/><br/><br/>
## 4. 주기적으로 확인하기 위하여 에약작업(crontab)을 등록한다.

1시간 주기로 매시 30분에 확인한다.

<pre><code>
colaman@default3:~$ crontab -l | grep checkOutboundIP
# checkOutboundIP.sh
30 * * * * /home/colaman/WORKS/WORKS_COLAMAN/networkWorks/checkOutboundIP/checkOutboundIP.sh
colaman@default3:~$ 
</code></pre>



<br/><br/><br/>
## 5. 실행결과
<img src="https://github.com/colamanlabs/checkOutboundIP/blob/main/2021-10-24_14-31-23.png?raw=true" />

<br/><br/>
\-\- 끝 -- 

