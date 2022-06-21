From: Arne Schwabe <arne@...1227...>
Date: Tue, 21 Jun 2022 18:16:46 +0200
Message-Id: <20220621161649.2872985-3-arne@...1227...>
In-Reply-To: <20220621161649.2872985-1-arne@...1227...>
References: <20220621161649.2872985-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/6] Extract update_session_cipher into
 standalone function
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

This allow the code later to check if the cipher is okay to use and
update it for the calculation for the max MTU size.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c     | 11 +----------
 src/openvpn/ssl_ncp.c | 22 ++++++++++++++++++++++
 src/openvpn/ssl_ncp.h |  8 ++++++++
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 61dea996d..ddd90080b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1678,17 +1678,8 @@ tls_session_update_crypto_params(struct tls_session *session,
                                  struct frame *frame_fragment,
                                  struct link_socket_info *lsi)
 {
-
-    bool cipher_allowed_as_fallback = options->enable_ncp_fallback
-                                      && streq(options->ciphername, session->opt->config_ciphername);
-
-    if (!session->opt->server && !cipher_allowed_as_fallback
-        && !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
+    if (!update_session_cipher(session, options))
     {
-        msg(D_TLS_ERRORS, "Error: negotiated cipher not allowed - %s not in %s",
-            options->ciphername, options->ncp_ciphers);
-        /* undo cipher push, abort connection setup */
-        options->ciphername = session->opt->config_ciphername;
         return false;
     }
 
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 564942503..c800f718f 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -490,3 +490,25 @@ p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
 
     gc_free(&gc);
 }
+
+
+bool
+update_session_cipher(struct tls_session *session, struct options *options)
+{
+    bool cipher_allowed_as_fallback = options->enable_ncp_fallback
+                                      && streq(options->ciphername, session->opt->config_ciphername);
+
+    if (!session->opt->server && !cipher_allowed_as_fallback
+        && !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
+    {
+        msg(D_TLS_ERRORS, "Error: negotiated cipher not allowed - %s not in %s",
+            options->ciphername, options->ncp_ciphers);
+        /* undo cipher push, abort connection setup */
+        options->ciphername = session->opt->config_ciphername;
+        return false;
+    }
+    else
+    {
+        return true;
+    }
+}
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 853017f5f..5ba2f7ae7 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -148,4 +148,12 @@ const char *
 get_p2p_ncp_cipher(struct tls_session *session, const char *peer_info,
                    struct gc_arena *gc);
 
+
+/**
+ * Checks if the cipher is allowed and updates the TLS session cipher with it,
+ * otherwise returns false
+ */
+bool
+update_session_cipher(struct tls_session *session, struct options *options);
+
 #endif /* ifndef OPENVPN_SSL_NCP_H */
-- 
2.32.1 (Apple Git-133)


