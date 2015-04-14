From: Yegor Yefremov <yegorslists@...1030...>
Date: Tue, 14 Apr 2015 20:34:05 +0200
Message-Id: <1429036445-17223-1-git-send-email-yegorslists@...1030...>
Subject: [Openvpn-devel] [PATCH] m4: enable silent build
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

Signed-off-by: Yegor Yefremov <yegorslists@...1030...>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index 9132468..ca0d9c3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -374,6 +374,9 @@ AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
 AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
 AC_DEFINE_UNQUOTED([SYSTEMD_ASK_PASSWORD_PATH], ["$SYSTEMD_ASK_PASSWORD"], [Path to systemd-ask-password tool])
 
+# enable silent build
+m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
+
 #
 # Libtool
 #
-- 
2.1.0


