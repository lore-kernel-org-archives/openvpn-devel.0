From: Gert Doering <gert@...1296...>
Date: Mon,  5 May 2025 16:22:16 +0200
Message-ID: <20250505142224.24935-1-gert@...1296...>
In-Reply-To: <gerrit.1746440138000.I9cae7314203424e4a604073c5445559260172477@...2715...>
References: <gerrit.1746440138000.I9cae7314203424e4a604073c5445559260172477@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Add information-gathering about DNS
 resolvers configured to t_client.sh(.in)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

With the patchsets to add DNS configuration on Unix+MacOS systems, and
the addition of test stanzas to excercise and verify the OS specific
"dns-updown" script, it becomes important to trace test failures
("did it not ping because the DNS was not installed, or did something
else fail?") and also verify that DNS config is properly restored at
the end of each test.

Linux is probed with "resolvectl status", if available, and
"cat resolv.conf" if not.  MacOS uses scutil --dns.

All other platforms use "cat resolv.conf" for now (because even if
"a tool to maintain DNS config" is available, in the end resolv.conf
is always where the final config lands).

Include a bit of restructuring to handle linux iproute2 testing in the
"Linux" branch, and make the control flow more amenable to having a
second case / esac block.

Change-Id: I9cae7314203424e4a604073c5445559260172477
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/961
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 1ccadeb..7a271b6 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -166,53 +166,71 @@
 # this is higly system dependent...
 get_ifconfig_route()
 {
-    # linux / iproute2? (-> if configure got a path)
-    if [ -n "@IPROUTE@" ]
-    then
-	echo "-- linux iproute2 --"
-	@IPROUTE@ addr show     | grep -v valid_lft
-	@IPROUTE@ route show
-	@IPROUTE@ -o -6 route show | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
-	return
-    fi
-
-    # try uname
-    case `uname -s` in
+    UNAME=`uname -s`
+    case $UNAME in
 	Linux)
-	   echo "-- linux / ifconfig --"
-	   LANG=C @IFCONFIG@ -a |egrep  "( addr:|encap:)"
-	   LANG=C @NETSTAT@ -rn -4 -6
-	   return
-	   ;;
+            # linux / iproute2? (-> if configure got a path)
+            if [ -n "@IPROUTE@" ]
+            then
+                echo "-- linux iproute2 --"
+                @IPROUTE@ addr show     | grep -v valid_lft
+                @IPROUTE@ route show
+                @IPROUTE@ -o -6 route show | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
+            else
+	        echo "-- linux / ifconfig --"
+	        LANG=C @IFCONFIG@ -a |egrep  "( addr:|encap:)"
+	        LANG=C @NETSTAT@ -rn -4 -6
+            fi
+            ;;
 	FreeBSD|NetBSD|Darwin)
 	   echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
 	   @IFCONFIG@ -a | egrep "(flags=|inet)"
 	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   return
 	   ;;
 	OpenBSD)
 	   echo "-- OpenBSD --"
 	   @IFCONFIG@ -a | egrep "(flags=|inet)" | \
 		sed -e 's/pltime [0-9]*//' -e 's/vltime [0-9]*//'
 	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
-	   return
 	   ;;
 	SunOS)
 	   echo "-- Solaris --"
 	   @IFCONFIG@ -a | egrep "(flags=|inet)"
 	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   return
 	   ;;
 	AIX)
 	   echo "-- AIX --"
 	   @IFCONFIG@ -a | egrep "(flags=|inet)"
 	   @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$6 }'
-	   return
 	   ;;
+        *)
+           echo "get_ifconfig_route(): no idea how to get info on your OS (`uname -s`).  FAIL." >&2
+           exit 20
+           ;;
     esac
 
-    echo "get_ifconfig_route(): no idea how to get info on your OS.  FAIL." >&2
-    exit 20
+    # another round of per-platform information gathering, for DNS info
+    # for most of the platforms "cat /etc/resolv.conf" is good enough
+    # except Linux and MacOS
+    case $UNAME in
+	Linux)
+            if [ -x /usr/bin/resolvectl ] ; then
+                echo "-- linux resolvectl --"
+                resolvectl status
+            else
+                echo "-- linux resolv.conf --"
+                cat /etc/resolv.conf
+            fi
+            ;;
+	Darwin)
+            echo "-- MacOS scutil --dns"
+            scutil --dns
+            ;;
+        *)
+            echo "-- resolv.conf --"
+            cat /etc/resolv.conf
+            ;;
+    esac
 }
 
 # ----------------------------------------------------------

