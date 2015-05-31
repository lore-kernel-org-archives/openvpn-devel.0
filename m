From: Gert Doering <gert@...1296...>
Date: Sun, 31 May 2015 15:59:09 +0200
Message-Id: <1433080749-6892-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Move res_init() call to inner
	openvpn_getaddrinfo() loop
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

A non-working nameserver in /etc/resolv.conf could lead to endless
loops inside openvpn_getaddrinfo(), because many systems will only
pick up changes to resolv.conf if res_init() is called again.

To reproduce, run openvpn with --resolv-retry infinite (2.3) or
--resolv-retry "a high number" (master) on a BSD system.  Linux
glibc seems to stat() resolv.conf on calls to getaddrinfo() and
pick up changes automatically.

Trac #523

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 13ed981..f9ee5ad 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -314,10 +314,6 @@ openvpn_getaddrinfo (unsigned int flags,
 
   ASSERT(res);
 
-#ifndef WIN32
-  res_init ();
-#endif
-
   ASSERT (hostname || servname);
   ASSERT (!(flags & GETADDR_HOST_ORDER));
 
@@ -394,6 +390,9 @@ openvpn_getaddrinfo (unsigned int flags,
        */
       while (true)
         {
+#ifndef WIN32
+	  res_init ();
+#endif
           /* try hostname lookup */
           hints.ai_flags &= ~AI_NUMERICHOST;
           dmsg (D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d",
-- 
2.4.0


