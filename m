From: Rosen Penev <rosenp@...277...>
Date: Wed,  3 Apr 2019 15:57:40 -0700
Message-Id: <20190403225740.8285-1-rosenp@...277...>
Subject: [Openvpn-devel] [PATCH] Remove wrong poll.h include
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

musl reports:

warning redirecting incorrect #include <sys/poll.h> to <poll.h>

Signed-off-by: Rosen Penev <rosenp@...277...>
---
 configure.ac          | 2 +-
 src/openvpn/syshead.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 891799ea..37880d29 100644
--- a/configure.ac
+++ b/configure.ac
@@ -436,7 +436,7 @@ AC_CHECK_HEADERS([ \
 	unistd.h signal.h libgen.h stropts.h \
 	syslog.h pwd.h grp.h \
 	sys/sockio.h sys/uio.h linux/sockios.h \
-	linux/types.h sys/poll.h sys/epoll.h err.h \
+	linux/types.h poll.h sys/epoll.h err.h \
 ])
 
 SOCKET_INCLUDES="
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index d2a50341..2b4c49ff 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -179,8 +179,8 @@
 #include <resolv.h>
 #endif
 
-#ifdef HAVE_SYS_POLL_H
-#include <sys/poll.h>
+#ifdef HAVE_POLL_H
+#include <poll.h>
 #endif
 
 #ifdef HAVE_SYS_EPOLL_H
-- 
2.17.1


