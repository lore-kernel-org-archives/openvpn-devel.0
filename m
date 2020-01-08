From: Simon Rozman <simon@...2293...>
Date: Wed,  8 Jan 2020 12:52:24 +0100
Message-Id: <20200108115224.38-1-simon@...2293...>
In-Reply-To: <CAGyAFMXMkCf=qoYopK0N=FrWxVvBQ4RKKKQ2y+dUnhwpjh=LPQ@...278...>
References: <CAGyAFMXMkCf=qoYopK0N=FrWxVvBQ4RKKKQ2y+dUnhwpjh=LPQ@...278...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 6/7] wintun: stop sending TAP-Windows6
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
 src/openvpn/error.c | 5 ++++-
 src/openvpn/sig.c   | 7 +++++--
 src/openvpn/tun.c   | 4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index b2492f2b..ad4f0ef4 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -688,7 +688,10 @@ x_check_status(int status,
         }
 #elif defined(_WIN32)
         /* get possible driver error from TAP-Windows driver */
-        extended_msg = tap_win_getinfo(tt, &gc);
+        if (tuntap_defined(tt))
+        {
+            extended_msg = tap_win_getinfo(tt, &gc);
+        }
 #endif
         if (!ignore_sys_error(my_errno))
         {
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index d7f2abb8..6e3379fe 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -317,8 +317,11 @@ print_status(const struct context *c, struct status_output *so)
 #ifdef _WIN32
     if (tuntap_defined(c->c1.tuntap))
     {
-        status_printf(so, "TAP-WIN32 driver status,\"%s\"",
-                      tap_win_getinfo(c->c1.tuntap, &gc));
+        const char *extended_msg = tap_win_getinfo(c->c1.tuntap, &gc);
+        if (extended_msg)
+        {
+            status_printf(so, "TAP-WIN32 driver status,\"%s\"", extended_msg);
+        }
     }
 #endif
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 30fb78b2..e36c49b1 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6411,7 +6411,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 const char *
 tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc)
 {
-    if (tt && tt->hand != NULL)
+    if (!tt->wintun)
     {
         struct buffer out = alloc_buf_gc(256, gc);
         DWORD len;
@@ -6429,7 +6429,7 @@ tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc)
 void
 tun_show_debug(struct tuntap *tt)
 {
-    if (tt && tt->hand != NULL)
+    if (!tt->wintun)
     {
         struct buffer out = alloc_buf(1024);
         DWORD len;
-- 
2.24.1.windows.2

v3 changes:
* tuntap_defined() checks revised according to Lev's recommendations

