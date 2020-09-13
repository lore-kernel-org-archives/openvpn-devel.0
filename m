From: Gert Doering <gert@...1296...>
Date: Sun, 13 Sep 2020 16:56:21 +0200
Message-Id: <20200913145621.12125-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix --show-gateway for IPv6 on NetBSD/i386.
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

Our ROUNDUP() macro to achieve the required system-specific alignment
for data structures sent to the routing socket was wrong for NetBSD -
unlike OpenBSD/FreeBSD, NetBSD is not using "long" (32/64 bit depending
on OS architecture), and not "uint32_t" either (32/32) like MacOS, but
uint64_t.

So our use of "long" always worked on NetBSD/amd64 and stopped working
on NetBSD/i386 when this was changed on the OS side...

NetBSD conveniently exports a RT_ROUNDUP() macro from <net/route.h> - use
that, and avoid trying to second-guess OS requirements.

While at it, add M_ERRNO to ominous "GDG6: problem writing to routing socket"
error message to differenciate between "EINVAL" and other errors.

Trac: #734

Signed-off-by: Gert Doering <gert@...2576...>
---
 src/openvpn/route.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index f127a90a..87febf49 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -49,6 +49,10 @@
 #include <linux/rtnetlink.h>            /* RTM_GETROUTE etc. */
 #endif
 
+#if defined(TARGET_NETBSD)
+#include <net/route.h>			/* RT_ROUNDUP(), RT_ADVANCE() */
+#endif
+
 #ifdef _WIN32
 #include "openvpn-msg.h"
 
@@ -3408,11 +3412,15 @@ struct rtmsg {
 
 /* the route socket code is identical for all 4 supported BSDs and for
  * MacOS X (Darwin), with one crucial difference: when going from
- * 32 bit to 64 bit, the BSDs increased the structure size but kept
+ * 32 bit to 64 bit, FreeBSD/OpenBSD increased the structure size but kept
  * source code compatibility by keeping the use of "long", while
  * MacOS X decided to keep binary compatibility by *changing* the API
  * to use "uint32_t", thus 32 bit on all OS X variants
  *
+ * NetBSD does the MacOS way of "fixed number of bits, no matter if
+ * 32 or 64 bit OS", but chose uint64_t.  For maximum portability, we
+ * just use the OS RT_ROUNDUP() macro, which is guaranteed to be correct.
+ *
  * We used to have a large amount of duplicate code here which really
  * differed only in this (long) vs. (uint32_t) - IMHO, worse than
  * having a combined block for all BSDs with this single #ifdef inside
@@ -3421,6 +3429,8 @@ struct rtmsg {
 #if defined(TARGET_DARWIN)
 #define ROUNDUP(a) \
     ((a) > 0 ? (1 + (((a) - 1) | (sizeof(uint32_t) - 1))) : sizeof(uint32_t))
+#elif defined(TARGET_NETBSD)
+#define ROUNDUP(a) RT_ROUNDUP(a)
 #else
 #define ROUNDUP(a) \
     ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
@@ -3729,7 +3739,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
     }
     if (write(sockfd, (char *)&m_rtmsg, l) < 0)
     {
-        msg(M_WARN, "GDG6: problem writing to routing socket");
+        msg(M_WARN|M_ERRNO, "GDG6: problem writing to routing socket");
         goto done;
     }
 
-- 
2.22.0


