From: Simon Rozman <simon@...2293...>
Date: Thu, 19 Dec 2019 23:39:16 +0100
Message-Id: <20191219223917.1614-6-simon@...2293...>
In-Reply-To: <20191219223917.1614-1-simon@...2293...>
References: <20191219223917.1614-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/7] wintun: stop sending TAP-Windows6
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
 src/openvpn/error.c   | 5 ++++-
 src/openvpn/forward.c | 2 +-
 src/openvpn/sig.c     | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index b2492f2b..8d91a131 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -688,7 +688,10 @@ x_check_status(int status,
         }
 #elif defined(_WIN32)
         /* get possible driver error from TAP-Windows driver */
-        extended_msg = tap_win_getinfo(tt, &gc);
+        if (!tt->wintun)
+        {
+            extended_msg = tap_win_getinfo(tt, &gc);
+        }
 #endif
         if (!ignore_sys_error(my_errno))
         {
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6b823613..2bc9d871 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1956,7 +1956,7 @@ pre_select(struct context *c)
     if (check_debug_level(D_TAP_WIN_DEBUG))
     {
         c->c2.timeval.tv_sec = 1;
-        if (tuntap_defined(c->c1.tuntap))
+        if (tuntap_defined(c->c1.tuntap) && !c->c1.tuntap->wintun)
         {
             tun_show_debug(c->c1.tuntap);
         }
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index d7f2abb8..f02aa57c 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -315,7 +315,7 @@ print_status(const struct context *c, struct status_output *so)
     status_printf(so, "Post-decrypt truncations," counter_format, c->c2.n_trunc_post_decrypt);
 #endif
 #ifdef _WIN32
-    if (tuntap_defined(c->c1.tuntap))
+    if (tuntap_defined(c->c1.tuntap) && !c->c1.tuntap->wintun)
     {
         status_printf(so, "TAP-WIN32 driver status,\"%s\"",
                       tap_win_getinfo(c->c1.tuntap, &gc));
-- 
2.24.1.windows.2


