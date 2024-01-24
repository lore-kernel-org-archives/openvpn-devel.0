From: Kristof Provost <kprovost@...2661...>
Date: Wed, 24 Jan 2024 16:27:39 +0100
Message-ID: <20240124152739.28248-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco-freebsd: dynamically re-allocate buffer
 if it's too small
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

It's possible for the buffer we provude for OVPN_GET_PEER_STATS to be
too small. Handle the error, re-allocate a larger buffer and try again
rather than failing.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/dco_freebsd.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 3ba1c817..577c65f8 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -698,7 +698,8 @@ dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
 {
 
     struct ifdrv drv;
-    uint8_t buf[4096];
+    uint8_t *buf = NULL;
+    size_t buf_size = 4096;
     nvlist_t *nvl;
     const nvlist_t *const *nvpeers;
     size_t npeers;
@@ -712,17 +713,28 @@ dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
     CLEAR(drv);
     snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
     drv.ifd_cmd = OVPN_GET_PEER_STATS;
-    drv.ifd_len = sizeof(buf);
+
+retry:
+    buf = realloc(buf, buf_size);
+    drv.ifd_len = buf_size;
     drv.ifd_data = buf;
 
     ret = ioctl(dco->fd, SIOCGDRVSPEC, &drv);
+    if (ret && errno == ENOSPC)
+    {
+        buf_size *= 2;
+        goto retry;
+    }
+
     if (ret)
     {
+        free(buf);
         msg(M_WARN | M_ERRNO, "Failed to get peer stats");
         return -EINVAL;
     }
 
     nvl = nvlist_unpack(buf, drv.ifd_len, 0);
+    free(buf);
     if (!nvl)
     {
         msg(M_WARN, "Failed to unpack nvlist");
-- 
2.43.0


