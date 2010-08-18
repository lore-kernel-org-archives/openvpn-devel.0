From: David Sommerseth <dazo@...384...>
Date: Wed, 18 Aug 2010 17:06:27 +0200
Message-Id: <1282143987-24356-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] More t_client.sh updates - exit with SKIP
	when we want to skip
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

Several places we exited with 0 instead of 77 when we want to indicate
that we should skip this test.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 t_client.sh.in |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t_client.sh.in b/t_client.sh.in
index d3a4295..b273964 100755
--- a/t_client.sh.in
+++ b/t_client.sh.in
@@ -36,12 +36,12 @@ fi
 
 if [ -z "$CA_CERT" ] ; then
     echo "CA_CERT not defined in 't_client.rc'. SKIP test." >&2
-    exit 0
+    exit 77
 fi
 
 if [ -z "$TEST_RUN_LIST" ] ; then
     echo "TEST_RUN_LIST empty, no tests defined.  SKIP test." >&2
-    exit 0
+    exit 77
 fi
 
 # make sure we have permissions to run ifconfig/route from OpenVPN
@@ -51,7 +51,7 @@ if expr "$ID" : "uid=0" >/dev/null
 then :
 else
     echo "$0: this test must run be as root. SKIP." >&2
-    exit 0
+    exit 77
 fi
 
 LOGDIR=t_client-`hostname`-`date +%Y%m%d-%H%M%S`
-- 
1.7.2.1


