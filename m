From: Arne Schwabe <arne@...1227...>
Date: Sun, 30 Aug 2020 16:07:36 +0200
Message-Id: <20200830140736.16571-3-arne@...1227...>
In-Reply-To: <20200830140736.16571-1-arne@...1227...>
References: <20200830140736.16571-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/2] Also announce IV_CIPHERS as client in
 OpenVPN 2.4
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

This improves compatbility to a OpenVPN 2.5 server and
allows to negotiate a different cipher than AES-128/256-GCM
without abusing the poor man's NCP support with --cipher.

We keep the IV_NCP=2 flag logic as broken as it is since 2.5 server
ignore the flag if IV_CIPHERS is set and this might break existing
2.4 setups.

Server support for IV_CIPHERS is not added since it would be quite
intrusive and users should rather upgrade to 2.5 on the server
if they want the full benefits.

This commit cherry picks a few parts of
868b200c3aef6ee5acfdf679770832018ebc7b70

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c       |  1 +
 src/openvpn/ssl.c        | 11 +++++++++++
 src/openvpn/ssl_common.h |  1 +
 3 files changed, 13 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e153682e..7ce6dd97 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2734,6 +2734,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.tcp_mode = link_socket_proto_connection_oriented(options->ce.proto);
     to.config_ciphername = c->c1.ciphername;
     to.config_authname = c->c1.authname;
+    to.config_ncp_ciphers = options->ncp_ciphers;
     to.ncp_enabled = options->ncp_enabled;
     to.transition_window = options->transition_window;
     to.handshake_window = options->handshake_window;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index dd9c52fb..d70dcb46 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2311,7 +2311,18 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         if (session->opt->ncp_enabled
             && (session->opt->mode == MODE_SERVER || session->opt->pull))
         {
+            /* We keep announcing IV_NCP=2 in OpenVPN 2.4 even though it is
+             * technically wrong to ensure not to break 2.4 setups on a
+             * minor release */
             buf_printf(&out, "IV_NCP=2\n");
+            buf_printf(&out, "IV_CIPHERS=%s", session->opt->config_ncp_ciphers);
+            if (!tls_item_in_cipher_list(session->opt->config_ciphername,
+                                         session->opt->config_ncp_ciphers))
+            {
+                buf_printf(&out, ":%s", session->opt->config_ciphername);
+            }
+            buf_printf(&out, "\n")
+
         }
 
         /* push compression status */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index ac25ffa7..378b81fd 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -286,6 +286,7 @@ struct tls_options
 
     const char *config_ciphername;
     const char *config_authname;
+    const char *config_ncp_ciphers;
     bool ncp_enabled;
 
     /** TLS handshake wrapping state */
-- 
2.26.2


