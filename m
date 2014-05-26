Sender: daniel kubec <kubec.daniel@...277...>
Date: Mon, 26 May 2014 15:25:55 +0200
From: Daniel Kubec <niel@...1898...>
Message-ID: <20140526132551.GA9011@...1915...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH] Add support for Keying Material Exporter
	[RFC 5705]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add support for TLS Keying Material Exporters [RFC 5705].
    
Keying Material Exporter allow additional keying material to be derived from existing TLS channel. 
This exported keying material can then be used for a variety of purposes.


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Added-support-for-TLS-Keying-Material-Exporters.patch"

From df9b59db8099ce7cd754cf3dc4adf4c8af81c973 Mon Sep 17 00:00:00 2001
From: Daniel Kubec <niel@...1898...>
Date: Mon, 26 May 2014 14:55:32 +0200
Subject: [PATCH] Added support for TLS Keying Material Exporters [RFC 5705].

Keying Material Exporter allow additional keying material to be derived from
existing TLS channel. This exported keying material can then be used for a
variety of purposes.
---
 doc/openvpn.8             |   15 +++++++++++++++
 src/openvpn/init.c        |   13 +++++++++++++
 src/openvpn/options.c     |   28 ++++++++++++++++++++++++++++
 src/openvpn/options.h     |    4 ++++
 src/openvpn/ssl.c         |    2 ++
 src/openvpn/ssl_backend.h |   12 ++++++++++++
 src/openvpn/ssl_common.h  |    6 ++++++
 src/openvpn/ssl_openssl.c |   33 +++++++++++++++++++++++++++++++++
 8 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 34894e5..d3b3925 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2691,6 +2691,16 @@ client-connect), then
 every module and script must return success (0) in order for
 the connection to be authenticated.
 .\"*********************************************************
+.TP
+.B \-\-keying-material-exporter label len
+Save Exported Keying Material [RFC5705] of len bytes using label in environment
+for use by plugins.
+
+Note that exporter labels have the potential to collide with existing PRF
+labels. In order to prevent this, labels MUST begin with "EXPORTER".
+
+This option requires OpenSSL 1.0.1 or newer.
+.\"*********************************************************
 .SS Server Mode
 Starting with OpenVPN 2.0, a multi-client TCP/UDP server mode
 is supported, and can be enabled with the
@@ -6116,6 +6126,11 @@ Like
 but in hex form (e.g. "12:34:56:78:9A").
 .\"*********************************************************
 .TP
+.B tls_binding_key
+TLS Binding Key is a pseudorandom hex string based on Exported Keying Material
+[RFC 5705].
+.\"*********************************************************
+.TP
 .B tun_mtu
 The MTU of the TUN/TAP device.
 Set prior to
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 467b98a..715b5ab 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2294,6 +2294,19 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.comp_options = options->comp;
 #endif
 
+  /* TLS Exported Keying Material [RFC 5705] */
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
+
   /* TLS handshake authentication (--tls-auth) */
   if (options->tls_auth_file)
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fe9b99d..5f29d79 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -630,6 +630,10 @@ static const char usage_message[] =
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
@@ -6995,6 +6999,30 @@ add_option (struct options *options,
       options->persist_mode = 1;
     }
 #endif
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
+              "\"EXPORTER\"");
+          goto err;
+        }
+
+      if (ekm_length < 1 || ekm_length >= (1 << 16))
+	{
+	  msg (msglevel, "Invalid keying material exporter length");
+	  goto err;
+	}
+
+      options->keying_material_exporter_label = p[1];
+      options->keying_material_exporter_length = ekm_length;
+    }
+#endif
   else
     {
       int i;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 092eac4..dcf081e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -602,6 +602,10 @@ struct options
   bool show_net_up;
   int route_method;
 #endif
+
+  /* Keying Material Exporters [RFC 5705] */
+  const char *keying_material_exporter_label;
+  int keying_material_exporter_length;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9bcb2ac..3c5fdd9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2131,6 +2131,8 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
    */
   if (ks->authenticated && plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
     {
+      key_state_export_keying_material(&ks->ks_ssl, session);
+
       if (plugin_call (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	ks->authenticated = false;
     }
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 37a458c..67b61e7 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -333,6 +333,18 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
  */
 void key_state_ssl_free(struct key_state_ssl *ks_ssl);
 
+/**
+ * Keying Material Exporters [RFC 5705] allows additional keying material to be
+ * derived from existing TLS channel. This exported keying material can then be
+ * used for a variety of purposes.
+ *
+ * @param ks_ssl	The SSL channel's state info
+ * @param session	The session associated with the given key_state
+ */
+void
+key_state_export_keying_material(struct key_state_ssl *ks_ssl,
+    struct tls_session *session) __attribute__((nonnull));
+
 /**************************************************************************/
 /** @addtogroup control_tls
  *  @{ */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 04ba789..eefc3c5 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -314,6 +314,12 @@ struct tls_options
 
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
index 1481850..80743d9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1286,6 +1286,39 @@ key_state_read_plaintext (struct key_state_ssl *ks_ssl, struct buffer *buf,
   return ret;
 }
 
+void
+key_state_export_keying_material(struct key_state_ssl *ssl,
+    struct tls_session *session)
+{
+  if (session->opt->ekm_used)
+    {
+#if (OPENSSL_VERSION_NUMBER >= 0x10001000)
+      unsigned char ekm[session->opt->ekm_size];
+
+      if (SSL_export_keying_material(ssl->ssl, ekm, sizeof(ekm),
+	  session->opt->ekm_label, session->opt->ekm_label_size, NULL, 0, 0))
+	{
+	  const char *ekm_hex = NULL;
+	  struct gc_arena gc = gc_new();
+
+	  ekm_hex = format_hex (ekm, sizeof(ekm), 0, &gc);
+	  setenv_str (session->opt->es, "tls_binding_key", ekm_hex);
+	  dmsg(M_DEBUG, "%s: exported keying material: %s", __func__,
+	      ekm_hex);
+
+	  gc_free(&gc);
+	}
+      else
+	{
+	  msg (M_WARN, "WARNING: Export keying material failed!");
+	  setenv_del (session->opt->es, "tls_binding_key");
+	}
+#else
+      ASSERT(0);
+#endif
+    }
+}
+
 /* **************************************
  *
  * Information functions
-- 
1.7.1


--Dxnq1zWXvFF0Q93v--

