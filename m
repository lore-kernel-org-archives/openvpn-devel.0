From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 May 2021 15:15:04 +0200
Message-Id: <20210512131511.1309914-3-arne@...1227...>
In-Reply-To: <20210512131511.1309914-1-arne@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/9] Remove getpeername, getpid check
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

getpeername is part of SUSv3 and Windows also provides the function
as part of winsocks.

getpid is also provided by both Posix and windows and we do not even
use getpid on Windows since we rather call GetCurrentProcessId.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 configure.ac           | 4 ++--
 src/openvpn/platform.c | 4 ----
 src/openvpn/socket.c   | 7 -------
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index dce7982cc..cc1dedbb9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -619,10 +619,10 @@ AC_CHECK_DECLS(
 AC_FUNC_FORK
 
 AC_CHECK_FUNCS([ \
-	daemon chroot getpwnam setuid nice system getpid dup dup2 \
+	daemon chroot getpwnam setuid nice system dup dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
 	setgroups flock readv writev time gettimeofday \
-	setsid chdir getpeername \
+	setsid chdir \
 	chsize ftruncate execve getpeereid basename dirname access \
 	epoll_create strsep \
 ])
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index bf7b1aa0a..831cc46b1 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -184,11 +184,7 @@ platform_getpid(void)
 #ifdef _WIN32
     return (unsigned int) GetCurrentProcessId();
 #else
-#ifdef HAVE_GETPID
     return (unsigned int) getpid();
-#else
-    return 0;
-#endif
 #endif
 }
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 407e411c0..02a6a7db4 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1227,7 +1227,6 @@ socket_do_accept(socket_descriptor_t sd,
 
     CLEAR(*act);
 
-#ifdef HAVE_GETPEERNAME
     if (nowait)
     {
         new_sd = getpeername(sd, &act->dest.addr.sa, &remote_len);
@@ -1241,12 +1240,6 @@ socket_do_accept(socket_descriptor_t sd,
             new_sd = sd;
         }
     }
-#else  /* ifdef HAVE_GETPEERNAME */
-    if (nowait)
-    {
-        msg(M_WARN, "TCP: this OS does not provide the getpeername() function");
-    }
-#endif
     else
     {
         new_sd = accept(sd, &act->dest.addr.sa, &remote_len);
-- 
2.31.1


