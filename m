From: selva.nair@...277...
Date: Tue,  2 Nov 2021 00:23:14 -0400
Message-Id: <20211102042314.19113-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix tls-version-min default once again
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

commit 51be733ba236610dff6a1c361cf59172db97473a
claimed to correct this but did not do it properly.
(my fault). The check whether tls-version-min is set
by the user or not was still wrong.

Hope this fixes it for good.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/options.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4a5db8a6..6b15d898 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3165,7 +3165,9 @@ static void
 options_set_backwards_compatible_options(struct options *o)
 {
     /* TLS min version is not set */
-    if ((o->ssl_flags & SSLF_TLS_VERSION_MIN_MASK) == 0)
+    int tls_ver_min = (o->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT)
+                          & SSLF_TLS_VERSION_MIN_MASK;
+    if (tls_ver_min == 0)
     {
         int tls_ver_max = (o->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
                           & SSLF_TLS_VERSION_MAX_MASK;
-- 
2.30.2


