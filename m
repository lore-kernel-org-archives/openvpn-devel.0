From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:46 +0300
Message-Id: <1336850389-23719-14-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 13/16] cleanup: syshead: remove dead code
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/syshead.h |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 657c884..f908752 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -375,14 +375,6 @@
 #endif
 
 /*
- * Disable ESEC
- */
-#if 0
-#undef EXTENDED_SOCKET_ERROR_CAPABILITY
-#define EXTENDED_SOCKET_ERROR_CAPABILITY 0
-#endif
-
-/*
  * Do we have a syslog capability?
  */
 #if defined(HAVE_OPENLOG) && defined(HAVE_SYSLOG)
@@ -548,12 +540,6 @@
 #define EPOLL 0
 #endif
 
-/* Disable EPOLL */
-#if 0
-#undef EPOLL
-#define EPOLL 0
-#endif
-
 /*
  * Should we allow ca/cert/key files to be
  * included inline, in the configuration file?
-- 
1.7.3.4


