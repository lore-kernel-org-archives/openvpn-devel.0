From: Arne Schwabe <arne@...1227...>
Date: Sun, 30 Aug 2020 15:03:35 +0200
Message-Id: <20200830130335.9425-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix client NCP OCC fallback when server and
 client cipher are identical
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

If we do not get a cipher pushed we call tls_poor_mans_ncp to determine
if we can use the cipher that the server uses. Left over from OpenVPN
2.4's code we only did this check when the ciphers were different.
Since OpenVPN 2.5 does not assume that our cipher we report in OCC
(options->ciphername) is always a valid cipher we always need to the
check.

Reported-By: Rafael Gava <gava100@...277...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_ncp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index c9ab85ce..d82419fb 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -268,15 +268,11 @@ ncp_get_best_cipher(const char *server_list, const char *peer_info,
 static bool
 tls_poor_mans_ncp(struct options *o, const char *remote_ciphername)
 {
-    if (remote_ciphername
-        && 0 != strcmp(o->ciphername, remote_ciphername))
+    if (tls_item_in_cipher_list(remote_ciphername, o->ncp_ciphers))
     {
-        if (tls_item_in_cipher_list(remote_ciphername, o->ncp_ciphers))
-        {
-            o->ciphername = string_alloc(remote_ciphername, &o->gc);
-            msg(D_TLS_DEBUG_LOW, "Using peer cipher '%s'", o->ciphername);
-            return true;
-        }
+        o->ciphername = string_alloc(remote_ciphername, &o->gc);
+        msg(D_TLS_DEBUG_LOW, "Using peer cipher '%s'", o->ciphername);
+        return true;
     }
     return false;
 }
-- 
2.26.2


