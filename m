From: selva.nair@...277...
Date: Fri, 15 Oct 2021 00:32:27 -0400
Message-Id: <20211015043227.10679-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix the "default" tls-version-min setting
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

From: Selva Nair <selva.nair@...277...>

commit 968569f83b1561ea4dff5b8b1f0d7768e2a18e69
defined TLS 1.2 as the minimum version if not set
by user. But the patch introduced two errors:

(i) ssl_flags is overwritten without regard to other
    options set in the flags
(ii) Any tls-version-max set by the user is not taken into
     account.
Makes it impossible to set tls-version-max without also setting
tls-version-min along with loss of other bits set in ssl_flags.

Fix it.

The fix retains the original intent when possible, and tries to
use the maximum possible value when it cannot be set to TLS 1.2
without conflicting with user-specified tls-version-max, if any.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/options.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 763dd330..7f14c1f3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3168,15 +3168,22 @@ options_set_backwards_compatible_options(struct options *o)
     /* TLS min version is not set */
     if ((o->ssl_flags & SSLF_TLS_VERSION_MIN_MASK) == 0)
     {
+        int tls_ver_max = (o->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
+                          & SSLF_TLS_VERSION_MAX_MASK;
         if (need_compatibility_before(o, 20307))
         {
             /* 2.3.6 and earlier have TLS 1.0 only, set minimum to TLS 1.0 */
-            o->ssl_flags = (TLS_VER_1_0 << SSLF_TLS_VERSION_MIN_SHIFT);
+            o->ssl_flags |= (TLS_VER_1_0 << SSLF_TLS_VERSION_MIN_SHIFT);
         }
-        else
+        else if (tls_ver_max == 0 || tls_ver_max >= TLS_VER_1_2)
         {
             /* Use TLS 1.2 as proper default */
-            o->ssl_flags = (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIFT);
+            o->ssl_flags |= (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIFT);
+        }
+        else
+        {
+            /* Maximize the minimum version */
+            o->ssl_flags |= (tls_ver_max << SSLF_TLS_VERSION_MIN_SHIFT);
         }
     }
 
-- 
2.20.1


