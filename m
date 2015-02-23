Sender: daniel kubec <kubec.daniel@...277...>
Date: Mon, 23 Feb 2015 16:51:34 +0100
From: Daniel Kubec <niel@...1898...>
Message-ID: <20150223155132.GA28440@...2018...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20140827093409.GA659@...1900...>
Subject: [Openvpn-devel] Add support for Keying Material Exporter [RFC 5705]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

Keying Material Exporter [RFC 5705] Patch rebased to actual master
branch.

Daniel


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-rfc5705.patch"

From aec0e05d02392bca61eca9ea41e10f9a2dec5d07 Mon Sep 17 00:00:00 2001
From: Daniel Kubec <niel@...1898...>
Date: Mon, 23 Feb 2015 16:04:48 +0100
Subject: [PATCH 1/1] Added support for TLS Keying Material Exporters [RFC 5705].

Keying Material Exporter allow additional keying material to be derived from
existing TLS channel. This exported keying material can then be used for a
variety of purposes.
---
 doc/openvpn.8              |   10 ++++++++++
 src/openvpn/init.c         |   14 ++++++++++++++
 src/openvpn/options.c      |   27 +++++++++++++++++++++++++++
 src/openvpn/options.h      |    6 ++++++
 src/openvpn/ssl.c          |    4 ++++
 src/openvpn/ssl_backend.h  |   13 +++++++++++++
 src/openvpn/ssl_common.h   |    6 ++++++
 src/openvpn/ssl_openssl.c  |   31 +++++++++++++++++++++++++++++++
 src/openvpn/ssl_polarssl.c |    6 ++++++
 9 files changed, 117 insertions(+), 0 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a8c189c..4b8680a 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2685,6 +2685,16 @@ client-connect), then
 every module and script must return success (0) in order for
 the connection to be authenticated.
 .\"*********************************************************
+.TP
+.B \-\-keying-material-exporter [label] [len]
+Save Exported Keying Material [RFC5705] of len bytes using label in environment
+(tls_binding_key) for use by plugins in OPENVPN_PLUGIN_TLS_FINAL callback.
+
+Note that exporter labels have the potential to collide with existing PRF
+labels. In order to prevent this, labels MUST begin with "EXPORTER".
+
+This option requires OpenSSL 1.0.1 or newer.
+.\"*********************************************************
 .SS Server Mode
 Starting with OpenVPN 2.0, a multi-client TCP/UDP server mode
 is supported, and can be enabled with the
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b670a48..ba43034 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2259,6 +2259,20 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.comp_options = options->comp;
 #endif
 
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000
+  if (options->keying_material_exporter_label)
+    {
+      to.ekm_used = true;
+      to.ekm_size = options->keying_material_exporter_length;
+      to.ekm_label = options->keying_material_exporter_label;
+      to.ekm_label_size = strlen(to.ekm_label);
+    }
+  else
+    {
+      to.ekm_used = false;
+    }
+#endif
+
   /* TLS handshake authentication (--tls-auth) */
   if (options->tls_auth_file)
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4ea03d1..d680731 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -613,6 +613,10 @@ static const char usage_message[] =
   "--x509-track x  : Save peer X509 attribute x in environment for use by\n"
   "                  plugins and management interface.\n"
 #endif
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000
+  "--keying-material-exporter label len : Save Exported Keying Material (RFC5705)\n"
+  "                  of len bytes using label in environment for use by plugins.\n"
+#endif
   "--remote-cert-ku v ... : Require that the peer certificate was signed with\n"
   "                  explicit key usage, you can specify more than one value.\n"
   "                  value should be given in hex format.\n"
@@ -7023,6 +7027,29 @@ add_option (struct options *options,
       options->use_peer_id = true;
       options->peer_id = atoi(p[1]);
     }
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000
+  else if (streq (p[0], "keying-material-exporter") && p[1] && p[2])
+    {
+      int ekm_length = positive_atoi (p[2]);
+
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+
+      if (strncmp(p[1], "EXPORTER", 8))
+        {
+          msg (msglevel, "Keying material exporter label must begin with "
+                         "\"EXPORTER\"");
+          goto err;
+        }
+      if (ekm_length < 1 || ekm_length >= (1 << 16))
+        {
+          msg (msglevel, "Invalid keying material exporter length");
+          goto err;
+        }
+
+      options->keying_material_exporter_label = p[1];
+      options->keying_material_exporter_length = ekm_length;
+    }
+#endif
   else
     {
       int i;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 7a8b21e..1068fe3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -597,6 +597,12 @@ struct options
 
   bool use_peer_id;
   uint32_t peer_id;
+
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000
+  /* Keying Material Exporters [RFC 5705] */
+  const char *keying_material_exporter_label;
+  int keying_material_exporter_length;
+#endif
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 222c828..547532d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2146,8 +2146,12 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
    */
   if (ks->authenticated && plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
     {
+      key_state_export_keying_material(&ks->ks_ssl, session);
+
       if (plugin_call (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	ks->authenticated = false;
+
+      setenv_del (session->opt->es, "tls_binding_key");
     }
 
   /*
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index b0777bf..99930e5 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -334,6 +334,19 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
  */
 void key_state_ssl_free(struct key_state_ssl *ks_ssl);
 
+/**
+ * Keying Material Exporters [RFC 5705] allows additional keying material to be
+ * derived from existing TLS channel. This exported keying material can then be
+ * used for a variety of purposes.
+ *
+ * @param ks_ssl       The SSL channel's state info
+ * @param session      The session associated with the given key_state
+ */
+
+void
+key_state_export_keying_material(struct key_state_ssl *ks_ssl,
+    struct tls_session *session) __attribute__((nonnull));
+
 /**************************************************************************/
 /** @addtogroup control_tls
  *  @{ */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 6222bd6..87c1438 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -316,6 +316,12 @@ struct tls_options
 
   /* --gremlin bits */
   int gremlin;
+
+  /* Keying Material Exporter [RFC 5705] parameters */
+  const char *ekm_label;
+  size_t ekm_label_size;
+  bool ekm_used; /* true when Keying Material should be exported */
+  size_t ekm_size;
 };
 
 /** @addtogroup control_processor
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d9abc6e..9e47935 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -133,6 +133,37 @@ bool tls_ctx_initialised(struct tls_root_ctx *ctx)
   return NULL != ctx->ctx;
 }
 
+void
+key_state_export_keying_material(struct key_state_ssl *ssl,
+                                 struct tls_session *session)
+{
+  if (session->opt->ekm_used)
+    {
+#if (OPENSSL_VERSION_NUMBER >= 0x10001000)
+      unsigned char ekm[session->opt->ekm_size];
+
+      if (SSL_export_keying_material(ssl->ssl, ekm, sizeof(ekm),
+          session->opt->ekm_label, session->opt->ekm_label_size, NULL, 0, 0))
+       {
+         const char *ekm_hex = NULL;
+         struct gc_arena gc = gc_new();
+
+         ekm_hex = format_hex_ex (ekm, sizeof(ekm), 40, 0, NULL, &gc);
+         setenv_str (session->opt->es, "tls_binding_key", ekm_hex);
+         dmsg(M_DEBUG, "%s: exported keying material: %s", __func__,
+             ekm_hex);
+
+         gc_free(&gc);
+       }
+      else
+       {
+         msg (M_WARN, "WARNING: Export keying material failed!");
+         setenv_del (session->opt->es, "tls_binding_key");
+       }
+#endif
+    }
+}
+
 /*
  * Print debugging information on SSL/TLS session negotiation.
  */
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 8cb328e..3b999b0 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -149,6 +149,12 @@ tls_ctx_initialised(struct tls_root_ctx *ctx)
 }
 
 void
+key_state_export_keying_material(struct key_state_ssl *ssl,
+                                 struct tls_session *session)
+{
+}
+
+void
 tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
 }
-- 
1.7.1


--TB36FDmn/VVEgNH/--

