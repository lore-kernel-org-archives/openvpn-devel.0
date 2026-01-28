From: Gert Doering <gert@...1296...>
Date: Wed, 28 Jan 2026 16:06:35 +0100
Message-ID: <20260128150640.13867-1-gert@...1296...>
In-Reply-To: <gerrit.1769611655000.Idcb1421b9f7fcbee9620fd1d45cceab050751373@...2715...>
References: <gerrit.1769611655000.Idcb1421b9f7fcbee9620fd1d45cceab050751373@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] tunnel_server_*(): close correct inotify
 fd
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

On a full SIGUSR1 restart of a p2mp server compiled with
--enable-async-push, tunnel_server_{udp,tcp}() will try to close and
reopen the "inotify" control file descriptor.  For whatever reason,
the original code referenced the wrong context, always closing fd 0.

As a consequence of this, on the second SIGUSR1 restart, the server
will close() the first active socket file descriptor, and if there
are active DCO clients, the resulting event confusion will lead to
an ASSERT(!mi->halt).

Fix by closing the correct FD. Add logging.

This is a backport of commit 5521872f80313060 to the "old p2mp code"
with a separate mudp.c and mtcp.c for UDP and TCP servers, respectively.

Github: fixes OpenVPN/openvpn#966

Change-Id: Idcb1421b9f7fcbee9620fd1d45cceab050751373
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1499
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1499
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 96408d1..3e33b15 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -850,7 +850,9 @@
     }
 
 #ifdef ENABLE_ASYNC_PUSH
-    close(top->c2.inotify_fd);
+    msg(D_LOW, "%s: close multi.top.c2.inotify_fd (%d)",
+        __func__, multi.top.c2.inotify_fd);
+    close(multi.top.c2.inotify_fd);
 #endif
 
     /* shut down management interface */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 0492311..f7c9ffd 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -524,7 +524,9 @@
     }
 
 #ifdef ENABLE_ASYNC_PUSH
-    close(top->c2.inotify_fd);
+    msg(D_LOW, "%s: close multi.top.c2.inotify_fd (%d)",
+        __func__, multi.top.c2.inotify_fd);
+    close(multi.top.c2.inotify_fd);
 #endif
 
     /* shut down management interface */

