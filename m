From: Gert Doering <gert@...1296...>
Date: Tue, 22 Feb 2022 12:38:32 +0100
Message-Id: <20220222113832.13383-1-gert@...1296...>
In-Reply-To: <20220221173818.10693-1-gert@...1296...>
References: <20220221173818.10693-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix --mtu-disc maybe|yes on Linux.
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
and "struct sock_extended_err".  Re-add <linux/errqueue.h> to configure.ac,
remove all the other conditionals in syshead.h, and remove the
"struct sock_extended_err" check completely (assumption: if errqueue.h
exists, it contains what we need).

Thus, the "non-helpful" socket error message turns into:

2022-02-22 12:31:42 write UDPv4 [EMSGSIZE Path-MTU=800]: Message too long (fd=3,code=90)
2022-02-22 12:31:42 Note adjusting 'mssfix 1400 mtu' to 'mssfix 800 mtu' according to path MTU discovery
2022-02-22 12:31:42 Note adjusting 'fragment 1400 mtu' to 'fragment 800 mtu' according to path MTU discovery

... while at it, fix extra space in first part of these messages, and
print o->ce.fragment for the "fragment" message...

v2: assume that "if it's linux, and has these two headers, everything
else will be there as well" and get rid of most of the #ifdef checks

Trac: #1452

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac          | 8 +-------
 src/openvpn/mss.c     | 6 +++---
 src/openvpn/syshead.h | 2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index d42185d0..9c898718 100644
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
@@ -484,12 +484,6 @@ AC_CHECK_TYPE(
 	,
 	[[${SOCKET_INCLUDES}]]
 )
-AC_CHECK_TYPE(
-	[struct sock_extended_err],
-	[AC_DEFINE([HAVE_SOCK_EXTENDED_ERR], [1], [struct sock_extended_err needed for extended socket error support])],
-	,
-	[[${SOCKET_INCLUDES}]]
-)
 AC_CHECK_TYPE(
 	[struct msghdr],
 	[AC_DEFINE([HAVE_MSGHDR], [1], [struct msghdr needed for extended socket error support])],
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 81692e91..25b26405 100644
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
@@ -374,8 +374,8 @@ frame_adjust_path_mtu(struct context *c)
         (o->ce.fragment_encap && pmtu < o->ce.fragment + encap_overhead))
     {
         const char* mtustr = o->ce.fragment_encap ? " mtu" : "";
-        msg(D_MTU_INFO, "Note adjusting 'fragment %d %s' to 'fragment %d mtu' "
-                        "according to path MTU discovery", o->ce.mssfix,
+        msg(D_MTU_INFO, "Note adjusting 'fragment %d%s' to 'fragment %d mtu' "
+                        "according to path MTU discovery", o->ce.fragment,
             mtustr, pmtu);
         o->ce.fragment = pmtu;
         o->ce.fragment_encap = true;
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index d699c608..a638b3dd 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -371,7 +371,7 @@ typedef int MIB_TCP_STATE;
 /*
  * Do we have the capability to report extended socket errors?
  */
-#if defined(HAVE_LINUX_TYPES_H) && defined(HAVE_LINUX_ERRQUEUE_H) && defined(HAVE_SOCK_EXTENDED_ERR) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(IP_RECVERR) && defined(MSG_ERRQUEUE) && defined(SOL_IP)
+#if defined(HAVE_LINUX_TYPES_H) && defined(HAVE_LINUX_ERRQUEUE_H)
 #define EXTENDED_SOCKET_ERROR_CAPABILITY 1
 #else
 #define EXTENDED_SOCKET_ERROR_CAPABILITY 0
-- 
2.26.3


