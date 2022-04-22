From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:41 +0200
Message-Id: <20220422142953.3805364-7-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 16/28] Move CRL reload to key_state_init
 from S_START transition
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

The current place that we reload is a bit more efficient since it only
triggers reload after a completed 3way handshake. On the other hand the
key_state_init is a much more logical place and with the upcoming
HMAC based UDP code and TCP code, the initialisation will only be done
after a 3way handshake.
---
 src/openvpn/ssl.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 097be8c02..d7fec0276 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -958,6 +958,17 @@ key_state_init(struct tls_session *session, struct key_state *ks)
 #ifdef ENABLE_MANAGEMENT
     ks->mda_key_id = session->opt->mda_context->mda_key_id_counter++;
 #endif
+
+    /*
+     * Attempt CRL reload before TLS negotiation. Won't be performed if
+     * the file was not modified since the last reload
+     */
+    if (session->opt->crl_file
+        && !(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))
+    {
+        tls_ctx_reload_crl(&session->opt->ssl_ctx,
+                           session->opt->crl_file, session->opt->crl_file_inline);
+    }
 }
 
 
@@ -2512,20 +2523,8 @@ tls_process_state(struct tls_multi *multi,
         ks->state = S_START;
         state_change = true;
 
-        /*
-         * Attempt CRL reload before TLS negotiation. Won't be performed if
-         * the file was not modified since the last reload
-         */
-        if (session->opt->crl_file
-            && !(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))
-        {
-            tls_ctx_reload_crl(&session->opt->ssl_ctx,
-                               session->opt->crl_file, session->opt->crl_file_inline);
-        }
-
         /* New connection, remove any old X509 env variables */
         tls_x509_clear_env(session->opt->es);
-
         dmsg(D_TLS_DEBUG_MED, "STATE S_START");
     }
 
-- 
2.32.0 (Apple Git-132)


