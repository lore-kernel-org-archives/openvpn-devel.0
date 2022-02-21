From: Gert Doering <gert@...1296...>
Date: Mon, 21 Feb 2022 18:38:18 +0100
Message-Id: <20220221173818.10693-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix --mtu-disc maybe|yes on Linux.
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

--mtu-disc (on Linux) needs two components to work:
   - setsockopt() with IP_MTU_DISCOVER or IPV6_MTU_DISCOVER
   - "extended error reporting" (setsockopt(IP_RECVERR) and
     then via mtu.c/format_extended_socket_error()) to react on
     "packet too big" errors on sendto() / sendmsg()

Some configure.ac reorganization broke detection of <linux/errqueue.h>
and "struct sock_extended_err".  Fix configure.ac, leave syshead.h mess.

Thus:

2022-02-21 18:21:11 write UDPv4 [EMSGSIZE Path-MTU=800]: Message too long (fd=3,code=90)
2022-02-21 18:21:11 Note adjusting 'mssfix 1400  mtu' to 'mssfix 800 mtu' according to path MTU discovery
2022-02-21 18:21:11 Note adjusting 'fragment 800  mtu' to 'fragment 800 mtu' according to path MTU discovery

... while at it, fix extra space in first part of message.

Trac: #1452

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac      | 8 +++++++-
 src/openvpn/mss.c | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index d42185d0..7f4c239c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -425,7 +425,7 @@ AC_CHECK_HEADERS([ \
 	unistd.h libgen.h stropts.h \
 	syslog.h pwd.h grp.h termios.h \
 	sys/sockio.h sys/uio.h linux/sockios.h \
-	linux/types.h poll.h sys/epoll.h err.h \
+	linux/types.h linux/errqueue.h poll.h sys/epoll.h err.h \
 ])
 
 SOCKET_INCLUDES="
@@ -457,6 +457,12 @@ SOCKET_INCLUDES="
 #ifdef HAVE_NETINET_IP_H
 #include <netinet/ip.h>
 #endif
+#ifdef HAVE_LINUX_TYPES_H
+#include <linux/types.h>
+#endif
+#ifdef HAVE_LINUX_ERRQUEUE_H
+#include <linux/errqueue.h>
+#endif
 "
 
 AC_CHECK_HEADERS(
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 81692e91..c131183f 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -361,7 +361,7 @@ frame_adjust_path_mtu(struct context *c)
         || (o->ce.mssfix_encap && pmtu < o->ce.mssfix + encap_overhead))
     {
         const char* mtustr = o->ce.mssfix_encap ? " mtu" : "";
-        msg(D_MTU_INFO, "Note adjusting 'mssfix %d %s' to 'mssfix %d mtu' "
+        msg(D_MTU_INFO, "Note adjusting 'mssfix %d%s' to 'mssfix %d mtu' "
                         "according to path MTU discovery", o->ce.mssfix,
             mtustr, pmtu);
         o->ce.mssfix = pmtu;
@@ -374,7 +374,7 @@ frame_adjust_path_mtu(struct context *c)
         (o->ce.fragment_encap && pmtu < o->ce.fragment + encap_overhead))
     {
         const char* mtustr = o->ce.fragment_encap ? " mtu" : "";
-        msg(D_MTU_INFO, "Note adjusting 'fragment %d %s' to 'fragment %d mtu' "
+        msg(D_MTU_INFO, "Note adjusting 'fragment %d%s' to 'fragment %d mtu' "
                         "according to path MTU discovery", o->ce.mssfix,
             mtustr, pmtu);
         o->ce.fragment = pmtu;
-- 
2.26.3


