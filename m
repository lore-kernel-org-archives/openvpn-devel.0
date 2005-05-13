Message-ID: <4284AF8E.6030808@...177...>
From: Farkas Levente <lfarkas@...177...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040400060402040007080902"
Subject: [Openvpn-devel] updated multilevel-init.patch
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri May 13 06:47:28 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040400060402040007080902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

hi,
here is an updated multilevel-init.patch for openvpn 2.0.
yours.

-- 
   Levente                               "Si vis pacem para bellum!"

--------------040400060402040007080902
Content-Type: text/x-patch;
 name="multilevel-init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="multilevel-init.patch"

--- openvpn	2005-05-13 15:40:17.070865970 +0200
+++ openvpn.old	2005-04-04 11:24:24.000000000 +0200
@@ -104,11 +104,6 @@
   exit 0
 fi
 
-# get the running openvpn processes' pids
-getpids() {
-	find $piddir -name "*.pid" 2>/dev/null
-}
-
 # See how we were called.
 case "$1" in
   start)
@@ -123,24 +118,18 @@
 
 	#echo 1 > /proc/sys/net/ipv4/ip_forward
 
-	cd $work
 	# Run startup script, if defined
-	if [ -f ./openvpn-startup ]; then
-	    ./openvpn-startup
+	if [ -f $work/openvpn-startup ]; then
+	    $work/openvpn-startup
 	fi
 
 	if [ ! -d  $piddir ]; then
 	    mkdir $piddir
 	fi
-	for d in `find * -type d`; do
-	    if [ ! -d  $piddir/$d ]; then
-	      mkdir $piddir/$d
-	    fi
-	done
 
 	if [ -f $lock ]; then
 	    # we were not shut down correctly
-	    for pidf in `getpids` ; do
+	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
 	      if [ -s $pidf ]; then
 		kill `cat $pidf` >/dev/null 2>&1
 	      fi
@@ -150,12 +139,13 @@
 	    sleep 2
 	fi
 
-	find $piddir -name "*.pid"|xargs rm -f
+	rm -f $piddir/*.pid
+	cd $work
 
 	# Start every .conf in $work and run .sh if exists
 	errors=0
 	successes=0
-	for c in `find * -name "*.conf" 2>/dev/null`; do
+	for c in `/bin/ls *.conf 2>/dev/null`; do
 	    bn=${c%%.conf}
 	    if [ -f "$bn.sh" ]; then
 		. $bn.sh
@@ -181,7 +171,7 @@
 	;;
   stop)
 	echo -n $"Shutting down openvpn: "
-	for pidf in `getpids`; do
+	for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
 	  if [ -s $pidf ]; then
 	    kill `cat $pidf` >/dev/null 2>&1
 	  fi
@@ -189,8 +179,8 @@
 	done
 
 	# Run shutdown script, if defined
-	if [ -f ./openvpn-shutdown ]; then
-	    ./openvpn-shutdown
+	if [ -f $work/openvpn-shutdown ]; then
+	    $work/openvpn-shutdown
 	fi
 
 	success; echo
@@ -203,7 +193,7 @@
 	;;
   reload)
 	if [ -f $lock ]; then
-	    for pidf in `getpids`; do
+	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
 		if [ -s $pidf ]; then
 		    kill -HUP `cat $pidf` >/dev/null 2>&1
 		fi
@@ -215,7 +205,7 @@
 	;;
   reopen)
 	if [ -f $lock ]; then
-	    for pidf in `getpids`; do
+	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
 		if [ -s $pidf ]; then
 		    kill -USR1 `cat $pidf` >/dev/null 2>&1
 		fi
@@ -235,7 +225,7 @@
 	;;
   status)
 	if [ -f $lock ]; then
-	    for pidf in `getpids`; do
+	    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
 		if [ -s $pidf ]; then
 		    kill -USR2 `cat $pidf` >/dev/null 2>&1
 		fi

--------------040400060402040007080902--


