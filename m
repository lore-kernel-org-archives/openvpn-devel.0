From: Gert Doering <gert@...1296...>
Date: Fri, 27 Feb 2026 23:47:39 +0100
Message-ID: <20260227224745.3175-1-gert@...1296...>
In-Reply-To: <gerrit.1771685160000.I84fe7a11391eafde3660d25a3c99094a0c525f3d@...2715...>
References: <gerrit.1771685160000.I84fe7a11391eafde3660d25a3c99094a0c525f3d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco_freebsd: use AF_LOCAL sockets for
 ioctl() communication with DCO driver
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

DCO FreeBSD uses ioctl() calls for userland -> driver communication, on
a socket() file descriptor.  The original code uses AF_INET sockets,
which fails if using a kernel compiled without IPv4 support.

The kernel side ioctl() handling does not differentiate between AF_INET,
AF_INET6 and AF_LOCAL sockets, and only the latter are guaranteed to be
present.

While add it, add a clear message if the socket() call in dco_available()
fails (it will lead to disabling of DCO).

FreeBSD PR: https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=286263
Reported-by: Marek Zarychta <zarychtam@...2997...>

Change-Id: I84fe7a11391eafde3660d25a3c99094a0c525f3d
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1551
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1551
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index ee3a5d0..718cd8b 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -205,7 +205,7 @@
         return -1;
     }
 
-    dco->fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+    dco->fd = socket(AF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);
     if (dco->fd != -1)
     {
         dco->open = true;
@@ -715,9 +715,10 @@
      * loaded, or built into the kernel. */
     (void)kldload("if_ovpn");
 
-    fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+    fd = socket(AF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);
     if (fd < 0)
     {
+        msg(M_WARN | M_ERRNO, "%s: socket() failed, disabling data channel offload", __func__);
         return false;
     }
 

