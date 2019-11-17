From: Arne Schwabe <arne@...1227...>
Date: Sun, 17 Nov 2019 19:12:40 +0100
Message-Id: <20191117181243.28919-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/4] Only announce IV_NCP=2 when we are
 willing to support these ciphers
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

We currently always announce IV_NCP=2 when we support these ciphers even
when we do not accept them. This lead to a server pushing a AES-GCM-128
cipher to clients and the client then rejecting it.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8            | 2 ++
 src/openvpn/init.c       | 4 ++++
 src/openvpn/openvpn.h    | 1 +
 src/openvpn/ssl.c        | 4 +++-
 src/openvpn/ssl_common.h | 1 +
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 457c2667..ae24b6c0 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4392,6 +4392,8 @@ NCP server (v2.4+) with "\-\-cipher BF\-CBC" and "\-\-ncp\-ciphers
 AES\-256\-GCM:AES\-256\-CBC" set can either specify "\-\-cipher BF\-CBC" or
 "\-\-cipher AES\-256\-CBC" and both will work.
 
+Note, for using NCP with a OpenVPN 2.4 server this list must include
+the AES\-256\-GCM and AES\-128\-GCM ciphers.
 .\"*********************************************************
 .TP
 .B \-\-ncp\-disable
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0bdb0a9c..8f142311 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -623,6 +623,7 @@ save_ncp_options(struct context *c)
     c->c1.ciphername = c->options.ciphername;
     c->c1.authname = c->options.authname;
     c->c1.keysize = c->options.keysize;
+    c->c1.ncp_ciphers = c->options.ncp_ciphers;
 }
 
 /* Restores NCP-negotiable options to original values */
@@ -632,6 +633,7 @@ restore_ncp_options(struct context *c)
     c->options.ciphername = c->c1.ciphername;
     c->options.authname = c->c1.authname;
     c->options.keysize = c->c1.keysize;
+    c->options.ncp_ciphers = c->c1.ncp_ciphers;
 }
 
 void
@@ -2827,6 +2829,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.tcp_mode = link_socket_proto_connection_oriented(options->ce.proto);
     to.config_ciphername = c->c1.ciphername;
     to.config_authname = c->c1.authname;
+    to.config_ncp_ciphers = c->c1.ncp_ciphers;
     to.ncp_enabled = options->ncp_enabled;
     to.transition_window = options->transition_window;
     to.handshake_window = options->handshake_window;
@@ -4532,6 +4535,7 @@ inherit_context_child(struct context *dest,
     dest->c1.ciphername = src->c1.ciphername;
     dest->c1.authname = src->c1.authname;
     dest->c1.keysize = src->c1.keysize;
+    dest->c1.ncp_ciphers = src->c1.ncp_ciphers;
 
     /* inherit auth-token */
     dest->c1.ks.auth_token_key = src->c1.ks.auth_token_key;
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 900db7e1..9e46ad6c 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -209,6 +209,7 @@ struct context_1
 
     const char *ciphername;     /**< Data channel cipher from config file */
     const char *authname;       /**< Data channel auth from config file */
+    const char *ncp_ciphers;    /**< NCP Ciphers */
     int keysize;                /**< Data channel keysize from config file */
 #endif
 };
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4455ebb8..6ca5c79a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2322,7 +2322,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 
         /* support for Negotiable Crypto Parameters */
         if (session->opt->ncp_enabled
-            && (session->opt->mode == MODE_SERVER || session->opt->pull))
+            && (session->opt->mode == MODE_SERVER || session->opt->pull)
+            && tls_item_in_cipher_list("AES-128-GCM", session->opt->config_ncp_ciphers)
+            && tls_item_in_cipher_list("AES-256-GCM", session->opt->config_ncp_ciphers))
         {
             buf_printf(&out, "IV_NCP=2\n");
         }
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 8dd08862..fb82f610 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -290,6 +290,7 @@ struct tls_options
 
     const char *config_ciphername;
     const char *config_authname;
+    const char *config_ncp_ciphers;
     bool ncp_enabled;
 
     bool tls_crypt_v2;
-- 
2.22.0


