From: Gert Doering <gert@...1296...>
Date: Fri, 16 Sep 2016 21:45:11 +0200
Message-Id: <20160916194511.46137-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Show compile-time variant for --multihome
	in --version output.
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

Instead of just [MH], show [MH/PKTINFO] or [MH/RECVDA], to see more
easily which compile-time variant was chosen by configure and syshead.h

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e052042..c9688c3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -97,7 +97,11 @@ const char title_string[] =
   " [PKCS11]"
 #endif
 #if ENABLE_IP_PKTINFO
-  " [MH]"
+# if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
+  " [MH/PKTINFO]"
+# elif defined(IP_RECVDSTADDR)
+  " [MH/RECVDA]"
+# endif
 #endif
   " [IPv6]"
   " built on " __DATE__
-- 
2.9.2


