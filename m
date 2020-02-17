From: Arne Schwabe <arne@...1227...>
Date: Mon, 17 Feb 2020 14:34:53 +0100
Message-Id: <20200217133453.29300-1-arne@...1227...>
In-Reply-To: <20200217115522.20068-1-arne@...1227...>
References: <20200217115522.20068-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 6/6] Use gc_arena in ncp_get_best_cipher
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

This avoids using the session specific gc arena to hold the temporary
string returned by tls_peer_ncp_list for the whole session.
---
 src/openvpn/ssl_ncp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 00400c1f..4c6af38d 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -216,10 +216,12 @@ ncp_get_best_cipher(const char *server_list, const char *server_cipher,
                     const char *peer_info,  const char *remote_cipher,
                     struct gc_arena *gc)
 {
-    const char *peer_ncp_list = tls_peer_ncp_list(peer_info, gc);
 
-    char *tmp_ciphers = string_alloc(server_list, NULL);
-    char *tmp_ciphers_orig = tmp_ciphers;
+    struct gc_arena gc_tmp = gc_new();
+
+    const char *peer_ncp_list = tls_peer_ncp_list(peer_info, &gc_tmp);
+
+    char *tmp_ciphers = string_alloc(server_list, &gc_tmp);
 
     const char *token = strsep(&tmp_ciphers, ":");
     while (token)
@@ -247,7 +249,7 @@ ncp_get_best_cipher(const char *server_list, const char *server_cipher,
         ret = string_alloc(token, gc);
     }
 
-    free(tmp_ciphers_orig);
+    gc_free(&gc_tmp);
     return ret;
 }
 
-- 
2.25.0


