From: Arne Schwabe <arne@...1227...>
Date: Sat, 17 Sep 2016 11:00:35 +0200
Message-Id: <1474102835-13402-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Prefer RECVDSTADDR to PKTINFO for IPv4 in
	OS X since it actually works (unlike PKTINFO)
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

---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 418ad57..6dfe256 100644
--- a/configure.ac
+++ b/configure.ac
@@ -337,6 +337,7 @@ case "$host" in
 		have_tap_header="yes"
 		dnl some Mac OS X tendering (we use vararg macros...)
 		CPPFLAGS="$CPPFLAGS -no-cpp-precomp"
+		ac_cv_type_struct_in_pktinfo=no
 		;;
 	*-mingw*)
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
-- 
2.8.4 (Apple Git-73)


