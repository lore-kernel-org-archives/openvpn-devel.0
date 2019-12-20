From: Simon Rozman <simon@...2293...>
Date: Fri, 20 Dec 2019 17:11:16 +0100
Message-Id: <20191220161117.1434-6-simon@...2293...>
In-Reply-To: <CAGyAFMWrp0L3hJeJSPhE619hOLZVXkJWvm3oOCRdq=NqMXiKzw@...278...>
References: <CAGyAFMWrp0L3hJeJSPhE619hOLZVXkJWvm3oOCRdq=NqMXiKzw@...278...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 6/7] wintun: stop sending TAP-Windows6
 ioctls to NDIS device
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

Wintun doesn't have its own I/O device. Rather, it taps on existing
Windows-provided NDIS device. Sending TAP-Windows6 IOCTL requests to it
is risky, as TAP-Windows6 is using one of the well-known device types
(FILE_DEVICE_UNKNOWN) with function IDs as 1, 2, 3 etc. raising a chance
of collision as NDIS might react to one of these IOCTLs.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 18f06bb6..6762402c 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6412,7 +6412,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 const char *
 tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc)
 {
-    if (tt && tt->hand != NULL)
+    if (tuntap_defined(tt) && !tt->wintun)
     {
         struct buffer out = alloc_buf_gc(256, gc);
         DWORD len;
@@ -6430,7 +6430,7 @@ tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc)
 void
 tun_show_debug(struct tuntap *tt)
 {
-    if (tt && tt->hand != NULL)
+    if (tuntap_defined(tt) && !tt->wintun)
     {
         struct buffer out = alloc_buf(1024);
         DWORD len;
-- 
2.24.1.windows.2


