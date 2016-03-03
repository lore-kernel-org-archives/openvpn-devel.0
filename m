From: <steffan.karger@...1435...>
Date: Thu, 3 Mar 2016 10:22:48 +0100
Message-ID: <1456996968-29472-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] hardening: add safe FD_SET() wrapper
	openvpn_fd_set()
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

From: Steffan Karger <steffan.karger@...1435...>

On many platforms (not Windows, for once), FD_SET() can write outside the
given fd_set if an fd >= FD_SETSIZE is given.  To make sure we don't do
that, add an ASSERT() to error out with a clear error message when this
does happen.

This patch was inspired by remarks about FD_SET() from Sebastian Krahmer
of the SuSE Security Team.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/event.c  |  8 ++++----
 src/openvpn/fdmisc.h | 16 ++++++++++++++++
 src/openvpn/proxy.c  |  2 +-
 src/openvpn/socket.c |  4 ++--
 src/openvpn/socks.c  |  6 +++---
 5 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 34a3c45..c642691 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -873,18 +873,18 @@ se_ctl (struct event_set *es, event_t event, unsigned int rwflags, void *arg)
       if (ses->fast)
 	{
 	  if (rwflags & EVENT_READ)
-	    FD_SET (event, &ses->readfds);
+	    openvpn_fd_set (event, &ses->readfds);
 	  if (rwflags & EVENT_WRITE)
-	    FD_SET (event, &ses->writefds);
+	    openvpn_fd_set (event, &ses->writefds);
 	}
       else
 	{
 	  if (rwflags & EVENT_READ)
-	    FD_SET (event, &ses->readfds);
+	    openvpn_fd_set (event, &ses->readfds);
 	  else
 	    FD_CLR (event, &ses->readfds);
 	  if (rwflags & EVENT_WRITE)
-	    FD_SET (event, &ses->writefds);
+	    openvpn_fd_set (event, &ses->writefds);
 	  else
 	    FD_CLR (event, &ses->writefds);
 	}
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index 4b6b6d0..13d6552 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -22,10 +22,26 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifndef FD_MISC_H
+#define FD_MISC_H
+
 #include "basic.h"
+#include "error.h"
+#include "syshead.h"
 
 bool set_nonblock_action (int fd);
 bool set_cloexec_action (int fd);
 
 void set_nonblock (int fd);
 void set_cloexec (int fd);
+
+static inline void openvpn_fd_set(int fd, fd_set *setp)
+{
+#ifndef WIN32 /* The Windows FD_SET() implementation does not overflow */
+  ASSERT (fd >= 0 && fd < FD_SETSIZE);
+#endif
+  FD_SET (fd, setp);
+}
+#undef FD_SET /* prevent direct use of FD_SET() */
+
+#endif /* FD_MISC_H */
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 2568e19..8ff6458 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -92,7 +92,7 @@ recv_line (socket_descriptor_t sd,
 	}
 
       FD_ZERO (&reads);
-      FD_SET (sd, &reads);
+      openvpn_fd_set (sd, &reads);
       tv.tv_sec = timeout_sec;
       tv.tv_usec = 0;
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 714a847..9bcf4d4 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1003,7 +1003,7 @@ socket_listen_accept (socket_descriptor_t sd,
       struct timeval tv;
 
       FD_ZERO (&reads);
-      FD_SET (sd, &reads);
+      openvpn_fd_set (sd, &reads);
       tv.tv_sec = 0;
       tv.tv_usec = 0;
 
@@ -1153,7 +1153,7 @@ openvpn_connect (socket_descriptor_t sd,
 	  struct timeval tv;
 
 	  FD_ZERO (&writes);
-	  FD_SET (sd, &writes);
+	  openvpn_fd_set (sd, &writes);
 	  tv.tv_sec = 0;
 	  tv.tv_usec = 0;
 
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index cef7a35..a9d04ae 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -134,7 +134,7 @@ socks_username_password_auth (struct socks_proxy_info *p,
       char c;
 
       FD_ZERO (&reads);
-      FD_SET (sd, &reads);
+      openvpn_fd_set (sd, &reads);
       tv.tv_sec = timeout_sec;
       tv.tv_usec = 0;
 
@@ -213,7 +213,7 @@ socks_handshake (struct socks_proxy_info *p,
       char c;
 
       FD_ZERO (&reads);
-      FD_SET (sd, &reads);
+      openvpn_fd_set (sd, &reads);
       tv.tv_sec = timeout_sec;
       tv.tv_usec = 0;
 
@@ -319,7 +319,7 @@ recv_socks_reply (socket_descriptor_t sd,
       char c;
 
       FD_ZERO (&reads);
-      FD_SET (sd, &reads);
+      openvpn_fd_set (sd, &reads);
       tv.tv_sec = timeout_sec;
       tv.tv_usec = 0;
 
-- 
2.5.0


