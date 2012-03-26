From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon, 26 Mar 2012 23:26:35 +0200
Message-Id: <1332797200-9295-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
Subject: [Openvpn-devel] [PATCH 1/6] build: openbsd: detect netinet/ip.h
	correctly
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index a30e873..b0dcdb7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -395,6 +395,9 @@ SOCKET_INCLUDES="
 #ifdef HAVE_WS2TCPIP_H
 #include <ws2tcpip.h>
 #endif
+#ifdef HAVE_NETINET_IN_SYSTM_H
+#include <netinet/in_systm.h>
+#endif
 "
 
 AC_CHECK_HEADERS(
-- 
1.7.3.4


