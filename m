From: Gert Doering <gert@...1296...>
Date: Wed, 25 Sep 2024 08:30:16 +0200
Message-ID: <20240925063016.22532-1-gert@...1296...>
In-Reply-To: <gerrit.1726754803000.Ice015df81543c01094479929f0cb3075ca4f3813@...2715...>
References: <gerrit.1726754803000.Ice015df81543c01094479929f0cb3075ca4f3813@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Ensure that the AF_UNIX socket pair has
 at least 65k of buffer space
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

From: Arne Schwabe <arne@...1227...>

Without this change, pinging a lwipovpn client with something like a
3000 byte payload on macOS often fails as the default buffer sizes on
macOS are 2048 for send and 4096 for receive.

Change-Id: Ice015df81543c01094479929f0cb3075ca4f3813
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/754
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6c790a0..7b1e603 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -890,20 +890,23 @@
 #endif
 }
 
-static void
-socket_set_buffers(socket_descriptor_t fd, const struct socket_buffer_size *sbs)
+void
+socket_set_buffers(socket_descriptor_t fd, const struct socket_buffer_size *sbs,
+                   bool reduce_size)
 {
     if (sbs)
     {
         const int sndbuf_old = socket_get_sndbuf(fd);
         const int rcvbuf_old = socket_get_rcvbuf(fd);
 
-        if (sbs->sndbuf)
+        if (sbs->sndbuf
+            && (reduce_size || sndbuf_old < sbs->sndbuf))
         {
             socket_set_sndbuf(fd, sbs->sndbuf);
         }
 
-        if (sbs->rcvbuf)
+        if (sbs->rcvbuf
+            && (reduce_size || rcvbuf_old < sbs->rcvbuf))
         {
             socket_set_rcvbuf(fd, sbs->rcvbuf);
         }
@@ -986,7 +989,7 @@
     {
         ls->socket_buffer_sizes.sndbuf = sndbuf;
         ls->socket_buffer_sizes.rcvbuf = rcvbuf;
-        socket_set_buffers(ls->sd, &ls->socket_buffer_sizes);
+        socket_set_buffers(ls->sd, &ls->socket_buffer_sizes, true);
     }
 }
 
@@ -1136,7 +1139,7 @@
     sock->info.af = addr->ai_family;
 
     /* set socket buffers based on --sndbuf and --rcvbuf options */
-    socket_set_buffers(sock->sd, &sock->socket_buffer_sizes);
+    socket_set_buffers(sock->sd, &sock->socket_buffer_sizes, true);
 
     /* set socket to --mark packets with given value */
     socket_set_mark(sock->sd, sock->mark);
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index bbdabfb..2e583af 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -157,6 +157,18 @@
     int sndbuf;
 };
 
+/**
+ * Sets the receive and send buffer sizes of a socket descriptor.
+ *
+ * @param fd            The socket to modify
+ * @param sbs           new sizes.
+ * @param reduce_size   apply the new size even if smaller than current one
+ */
+void
+socket_set_buffers(socket_descriptor_t fd,
+                   const struct socket_buffer_size *sbs,
+                   bool reduce_size);
+
 /*
  * This is the main socket structure used by OpenVPN.  The SOCKET_
  * defines try to abstract away our implementation differences between
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index f4ce4b7..6b6c159 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -35,6 +35,7 @@
 #include "wfp_block.h"
 #include "argv.h"
 #include "options.h"
+#include "socket.h"
 
 #ifndef WIN32
 /* Windows does implement some AF_UNIX functionality but key features
@@ -80,6 +81,13 @@
         return;
     }
 
+
+    /* Ensure that the buffer sizes are decently sized. Otherwise macOS will
+     * just have 2048 */
+    struct socket_buffer_size newsizes = {65536, 65536 };
+    socket_set_buffers(fds[0], &newsizes, false);
+    socket_set_buffers(fds[1], &newsizes, false);
+
     /* Use the first file descriptor for our side and avoid passing it
      * to the child */
     tt->fd = fds[1];

