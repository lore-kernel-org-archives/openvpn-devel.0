From: Kristof Provost <kprovost@...2661...>
Date: Fri, 25 Nov 2022 16:53:41 +0100
Message-Id: <20221125155341.19456-2-kprovost@...2661...>
In-Reply-To: <20221125155341.19456-1-kprovost@...2661...>
References: <20221125155341.19456-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: pass control packets through the
 socket on FreeBSD
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

FreeBSD allows packets to be sent through the socket even when the
if_dco driver is active, so prefer that path.

Also remove the FreeBSD dco_do_write() implementation, as this function
will never be called any more on FreeBSD. Assert this.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/dco_freebsd.c | 33 ++++-----------------------------
 src/openvpn/forward.c     |  7 +++++--
 2 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 8e5ee436..9102222f 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -536,35 +536,10 @@ dco_do_read(dco_context_t *dco)
 int
 dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
 {
-    struct ifdrv drv;
-    nvlist_t *nvl;
-    int ret;
-
-    nvl = nvlist_create(0);
-
-    nvlist_add_binary(nvl, "packet", BSTR(buf), BLEN(buf));
-    nvlist_add_number(nvl, "peerid", peer_id);
-
-    CLEAR(drv);
-    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
-    drv.ifd_cmd = OVPN_SEND_PKT;
-    drv.ifd_data = nvlist_pack(nvl, &drv.ifd_len);
-
-    ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
-    if (ret)
-    {
-        msg(M_WARN | M_ERRNO, "Failed to send control packet");
-        ret = -errno;
-    }
-    else
-    {
-        ret = BLEN(buf);
-    }
-
-    free(drv.ifd_data);
-    nvlist_destroy(nvl);
-
-    return ret;
+    /* Control packets are passed through the socket, so this should never get
+     * called. See should_use_dco_socket(). */
+    assert(false);
+    return -EINVAL;
 }
 
 bool
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 622be841..1dcaabd8 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1635,20 +1635,23 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
     }
 }
 
-/* Linux-like DCO implementations pass the socket to the kernel and
+/* Linux DCO implementations pass the socket to the kernel and
  * disallow usage of it from userland, so (control) packets sent and
  * received by OpenVPN need to go through the DCO interface.
  *
  * Windows DCO needs control packets to be sent via the normal
  * standard Overlapped I/O.
  *
+ * FreeBSD DCO allows control packets to pass through the socket in both
+ * directions.
+ *
  * Hide that complexity (...especially if more platforms show up
  * in the future...) in a small inline function.
  */
 static inline bool
 should_use_dco_socket(struct link_socket_actual *actual)
 {
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(TARGET_LINUX)
     return actual->dco_installed;
 #else
     return false;
-- 
2.38.1


