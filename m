From: Antonio Quartulli <a@...2181...>
Date: Thu, 13 Jul 2017 16:05:26 +0800
Message-Id: <20170713080527.13299-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 1/2] use M_ERRNO instead of explicitly
 printing errno
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

the msg() function will print the errno for us when
provided with the M_ERRNO flag.

Therefore, don't bother printing errno explicitly and always
pass M_ERRNO to msg().

Signed-off-by: Antonio Quartulli <antonio@...515...>
---

- compile tested with travis-ci

 src/openvpn/manage.c  | 14 ++++++--------
 src/openvpn/misc.c    |  6 ++----
 src/openvpn/mtcp.c    |  2 +-
 src/openvpn/mudp.c    |  2 +-
 src/openvpn/multi.c   |  2 +-
 src/openvpn/options.c |  3 +--
 src/openvpn/socket.c  | 13 +++++--------
 src/openvpn/status.c  |  2 +-
 src/openvpn/tun.c     |  9 +++------
 9 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index e850e0a4..29c9e2ec 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1878,17 +1878,15 @@ man_connect(struct management *man)
 #if UNIX_SOCK_SUPPORT
         if (man->settings.flags & MF_UNIX_SOCK)
         {
-            msg(D_LINK_ERRORS,
-                "MANAGEMENT: connect to unix socket %s failed: %s",
-                sockaddr_unix_name(&man->settings.local_unix, "NULL"),
-                strerror_ts(status, &gc));
+            msg(D_LINK_ERRORS | M_ERRNO,
+                "MANAGEMENT: connect to unix socket %s failed",
+                sockaddr_unix_name(&man->settings.local_unix, "NULL"));
         }
         else
 #endif
-        msg(D_LINK_ERRORS,
-            "MANAGEMENT: connect to %s failed: %s",
-            print_sockaddr(man->settings.local->ai_addr, &gc),
-            strerror_ts(status, &gc));
+        msg(D_LINK_ERRORS | M_ERRNO,
+            "MANAGEMENT: connect to %s failed",
+            print_sockaddr(man->settings.local->ai_addr, &gc));
         throw_signal_soft(SIGTERM, "management-connect-failed");
         goto done;
     }
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 965869a7..ef779ee3 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -928,10 +928,8 @@ create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
         else if (fd == -1 && errno != EEXIST)
         {
             /* Something else went wrong, no need to retry.  */
-            struct gc_arena gcerr = gc_new();
-            msg(M_FATAL, "Could not create temporary file '%s': %s",
-                retfname, strerror_ts(errno, &gcerr));
-            gc_free(&gcerr);
+            msg(M_FATAL | M_ERRNO, "Could not create temporary file '%s'",
+                retfname);
             return NULL;
         }
     }
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index cb940d8a..851643a9 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -797,7 +797,7 @@ tunnel_server_tcp(struct context *top)
     multi.top.c2.inotify_fd = inotify_init();
     if (multi.top.c2.inotify_fd < 0)
     {
-        msg(D_MULTI_ERRORS, "MULTI: inotify_init error: %s", strerror(errno));
+        msg(D_MULTI_ERRORS | M_ERRNO, "MULTI: inotify_init error");
     }
 #endif
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 793678d8..eb28ca2b 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -325,7 +325,7 @@ tunnel_server_udp_single_threaded(struct context *top)
     multi.top.c2.inotify_fd = inotify_init();
     if (multi.top.c2.inotify_fd < 0)
     {
-        msg(D_MULTI_ERRORS, "MULTI: inotify_init error: %s", strerror(errno));
+        msg(D_MULTI_ERRORS | M_ERRNO, "MULTI: inotify_init error");
     }
 #endif
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8d3d67fd..7edfee1b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2355,7 +2355,7 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
             }
             else
             {
-                msg(M_NONFATAL, "MULTI: inotify_add_watch error: %s", strerror(errno));
+                msg(M_NONFATAL | M_ERRNO, "MULTI: inotify_add_watch error");
             }
         }
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 505c5b2e..1d5b62ca 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3137,8 +3137,7 @@ check_file_access(const int type, const char *file, const int mode, const char *
     /* Scream if an error is found */
     if (errcode > 0)
     {
-        msg(M_NOPREFIX|M_OPTERR, "%s fails with '%s': %s",
-            opt, file, strerror(errno));
+        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails with '%s'", opt, file);
     }
 
     /* Return true if an error occured */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 4e7e3f99..a814b952 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1297,11 +1297,9 @@ socket_bind(socket_descriptor_t sd,
     }
     if (bind(sd, cur->ai_addr, cur->ai_addrlen))
     {
-        const int errnum = openvpn_errno();
-        msg(M_FATAL, "%s: Socket bind failed on local address %s: %s",
+        msg(M_FATAL | M_ERRNO, "%s: Socket bind failed on local address %s",
             prefix,
-            print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc),
-            strerror_ts(errnum, &gc));
+            print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
     }
     gc_free(&gc);
 }
@@ -3888,12 +3886,11 @@ socket_bind_unix(socket_descriptor_t sd,
 
     if (bind(sd, (struct sockaddr *) local, sizeof(struct sockaddr_un)))
     {
-        const int errnum = openvpn_errno();
-        msg(M_FATAL, "%s: Socket bind[%d] failed on unix domain socket %s: %s",
+        msg(M_FATAL | M_ERRNO,
+            "%s: Socket bind[%d] failed on unix domain socket %s",
             prefix,
             (int)sd,
-            sockaddr_unix_name(local, "NULL"),
-            strerror_ts(errnum, &gc));
+            sockaddr_unix_name(local, "NULL"));
     }
 
 #ifdef HAVE_UMASK
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index a1634083..d2f0b133 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -178,7 +178,7 @@ status_flush(struct status_output *so)
             const off_t off = lseek(so->fd, (off_t)0, SEEK_CUR);
             if (ftruncate(so->fd, off) != 0)
             {
-                msg(M_WARN, "Failed to truncate status file: %s", strerror(errno));
+                msg(M_WARN | M_ERRNO, "Failed to truncate status file");
             }
         }
 #elif defined(HAVE_CHSIZE)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 75a156c1..c09f9700 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3022,16 +3022,14 @@ utun_open_helper(struct ctl_info ctlInfo, int utunnum)
 
     if (fd < 0)
     {
-        msg(M_INFO, "Opening utun (%s): %s", "socket(SYSPROTO_CONTROL)",
-            strerror(errno));
+        msg(M_INFO | M_ERRNO, "Opening utun (socket(SYSPROTO_CONTROL))");
         return -2;
     }
 
     if (ioctl(fd, CTLIOCGINFO, &ctlInfo) == -1)
     {
         close(fd);
-        msg(M_INFO, "Opening utun (%s): %s", "ioctl(CTLIOCGINFO)",
-            strerror(errno));
+        msg(M_INFO | M_ERRNO, "Opening utun (ioctl(CTLIOCGINFO))");
         return -2;
     }
 
@@ -3049,8 +3047,7 @@ utun_open_helper(struct ctl_info ctlInfo, int utunnum)
 
     if (connect(fd, (struct sockaddr *)&sc, sizeof(sc)) < 0)
     {
-        msg(M_INFO, "Opening utun (%s): %s", "connect(AF_SYS_CONTROL)",
-            strerror(errno));
+        msg(M_INFO | M_ERRNO, "Opening utun (connect(AF_SYS_CONTROL))");
         close(fd);
         return -1;
     }
-- 
2.13.2


