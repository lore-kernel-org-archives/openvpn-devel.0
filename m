From: Gert Doering <gert@...1296...>
Date: Sun, 20 Apr 2014 20:41:01 +0200
Message-Id: <1398019261-30180-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Minor t_client.sh cleanups
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

- remove built tests/t_client.sh script on "make clean"
- ignore Linux iproute2 "ssthresh <n>" output that sometimes shows up
  in "ip -6 route show" and breaks before/after comparison

Signed-off-by: Gert Doering <gert@...1296...>
---
 Makefile.am          | 2 +-
 tests/t_client.sh.in | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 1a30aa5..66d9f23 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -41,7 +41,7 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/config.guess $(srcdir)/config.sub
 
 CLEANFILES = \
-	config-version.h
+	config-version.h tests/t_client.sh
 
 EXTRA_DIST = \
 	contrib \
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 6c9de6c..52c5ed1 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -103,7 +103,7 @@ get_ifconfig_route()
 	echo "-- linux iproute2 --"
 	@IPROUTE@ addr show     | grep -v valid_lft
 	@IPROUTE@ route show
-	@IPROUTE@ -o -6 route show | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
+	@IPROUTE@ -o -6 route show | grep -v ' cache' | sed -E -e 's/ expires [0-9]*sec//' -e 's/ (mtu|hoplimit|cwnd|ssthresh) [0-9]+//g' -e 's/ (rtt|rttvar) [0-9]+ms//g'
 	return
     fi
 
-- 
1.8.3.2


