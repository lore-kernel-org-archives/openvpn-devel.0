Sender: daniel kubec <kubec.daniel@...277...>
Date: Wed, 14 May 2014 14:34:08 +0200
From: Daniel Kubec <niel@...1898...>
Message-ID: <20140514123406.GA2465@...1915...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <53661960.9080704@...1856...>
Subject: [Openvpn-devel] [PATCH] Keying Material Exporters [RFC 5705]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steffan,

Thank you for your comments. 

Based on our previous conversation, I'd like to offer you splitted EKM
patch without the vpn_binding_key attribute.

Later I'd like to discucess concept of TLS identifier which lives
across negotiations.

Daniel





--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-ekm.patch"

From d6c231cae830e1045c2debdb04a166e4b81f363e Mon Sep 17 00:00:00 2001
From: Daniel Kubec <niel@...1898...>
Date: Wed, 14 May 2014 12:37:30 +0200
Subject: [PATCH 1/2] TLS Keying Material Exporters [RFC 5705] allows additional keying material to
 be derived from existing TLS channel. This exported keying material can then
 be used for a variety of purposes.

---
 src/openvpn/init.c        |    8 ++++++++
 src/openvpn/options.c     |   19 +++++++++++++++++++
 src/openvpn/options.h     |    4 ++++
 src/openvpn/ssl.c         |   12 ++++++++++++
 src/openvpn/ssl_common.h  |   10 ++++++++++
 src/openvpn/ssl_openssl.c |   30 ++++++++++++++++++++++++++++++
 6 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 467b98a..90598ef 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2294,6 +2294,14 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.comp_options = options->comp;
 #endif
 
+  /* TLS Exported Keying Material [RFC 5705] */
+  to.ekm_size = options->keying_material_exporter_length;
+
+  to.ekm_label = (uint8_t*)options->keying_material_exporter_label;
+  to.ekm_label_size = to.ekm_label ? strlen(to.ekm_label) : 0;
+
+  to.ekm_used = (to.ekm_label_size && to.ekm_size >= 20) ? true : false;
+
   /* TLS handshake authentication (--tls-auth) */
   if (options->tls_auth_file)
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fe9b99d..8011c01 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -639,6 +639,8 @@ static const char usage_message[] =
   "--remote-cert-tls t: Require that peer certificate was signed with explicit\n"
   "                  key usage and extended key usage based on RFC3280 TLS rules.\n"
   "                  t = 'client' | 'server'.\n"
+  "--keying-material-exporter-label l  : Exported Keying Material Label RFC5705.\n"
+  "--keying-material-exporter-length l : Exported Keying Material Length RFC5705.\n"
 #endif				/* ENABLE_SSL */
 #ifdef ENABLE_PKCS11
   "\n"
@@ -6995,6 +6997,23 @@ add_option (struct options *options,
       options->persist_mode = 1;
     }
 #endif
+  else if (streq (p[0], "keying-material-exporter-label") && p[1])
+    {
+      if (strncmp(p[1], "EXPORTER", 8))
+        {
+          msg (msglevel, "keying material exporter labels SHOULD begin with \"EXPORTER\"");
+          goto err;
+        }
+        VERIFY_PERMISSION (OPT_P_GENERAL);
+        options->keying_material_exporter_label = p[1];
+    }
+  else if (streq (p[0], "keying-material-exporter-length"))
+    {
+      int len = positive_atoi (p[1]);
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+
+      options->keying_material_exporter_length = len;
+    }
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
index 9bcb2ac..49bd8c0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -891,6 +891,12 @@ tls_session_init (struct tls_multi *multi, struct tls_session *session)
 	P_CONTROL_HARD_RESET_SERVER_V2 : P_CONTROL_HARD_RESET_CLIENT_V2;
     }
 
+  /* allocate buffers for Exported Keying Material [RFC 5705] */
+  session->ekm = malloc (session->opt->ekm_size);
+  session->ekm_exported = false;
+
+  memset (session->ekm, 0, session->opt->ekm_size);
+
   /* Initialize control channel authentication parameters */
   session->tls_auth = session->opt->tls_auth;
 
@@ -2131,6 +2137,12 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
    */
   if (ks->authenticated && plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
     {
+      const char *tls_binding_key = format_hex (session->ekm, session->opt->ekm_size, 0, &gc);
+      dmsg (M_INFO, "TLS: Exported Keying Material [RFC5705] : length=%d, key=%s",
+                     session->opt->ekm_size, tls_binding_key);
+
+      setenv_str (session->opt->es, "tls_binding_key",  tls_binding_key);
+
       if (plugin_call (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	ks->authenticated = false;
     }
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 04ba789..d12be0e 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -314,6 +314,12 @@ struct tls_options
 
   /* --gremlin bits */
   int gremlin;
+
+  /* Keying Material Exporter [RFC 5705] parameters */
+  uint8_t *ekm_label;
+  int ekm_label_size;
+  bool ekm_used; /* true when Keying Material should be exported */
+  int ekm_size;
 };
 
 /** @addtogroup control_processor
@@ -355,6 +361,10 @@ struct tls_session
   /* during hard reset used to control burst retransmit */
   bool burst;
 
+  /* Exported Keying Material [RFC 5705] */
+  uint8_t *ekm;                 /* buffer size: session->opt->ekm_size */
+  bool ekm_exported;            /* true when ekm contains updated material */
+
   /* authenticate control packets */
   struct crypto_options tls_auth;
   struct packet_id tls_auth_pid;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 1481850..6ec7bcc 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -134,6 +134,30 @@ bool tls_ctx_initialised(struct tls_root_ctx *ctx)
 }
 
 /*
+ * Keying Material Exporters [RFC 5705] allows additional keying material to be 
+ * derived from existing TLS channel. This exported keying material can then be 
+ * used for a variety of purposes.
+ */
+
+static void
+export_keying_material(const SSL *ssl)
+{
+  struct tls_session *tls = SSL_get_ex_data (ssl, mydata_index);
+  ASSERT(tls != NULL);
+
+  tls->ekm_exported = false;
+
+#if (OPENSSL_VERSION_NUMBER >= 0x10001000)
+  tls->ekm_exported = (bool)SSL_export_keying_material((SSL *)ssl,
+                                                       tls->ekm,           
+                                                       tls->opt->ekm_size, 
+                                                       tls->opt->ekm_label,
+                                                       tls->opt->ekm_label_size,
+                                                       NULL, 0, 0);
+#endif
+}
+
+/*
  * Print debugging information on SSL/TLS session negotiation.
  */
 
@@ -157,6 +181,12 @@ info_callback (INFO_CALLBACK_SSL_CONST SSL * s, int where, int ret)
 	   SSL_alert_type_string_long (ret),
 	   SSL_alert_desc_string_long (ret));
     }
+  else if (where & SSL_CB_HANDSHAKE_DONE)
+    {
+      export_keying_material(s);
+
+      dmsg (D_HANDSHAKE_VERBOSE, "SSL handshake done.");
+    }
 }
 
 /*
-- 
1.7.1


From 64bd4ead32cf304537eb006bf2b13ca1680ea5e1 Mon Sep 17 00:00:00 2001
From: Daniel Kubec <niel@...1898...>
Date: Wed, 14 May 2014 13:30:24 +0200
Subject: [PATCH 2/2] Updated doc/openvpn.8

Exported Keying Material [RFC5705]

Parameters:
  keying-material-exporter-label
  keying-material-exporter-length

Output:
  tls_binding_key
---
 doc/openvpn.8 |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 34894e5..6f72b4e 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2691,6 +2691,17 @@ client-connect), then
 every module and script must return success (0) in order for
 the connection to be authenticated.
 .\"*********************************************************
+.TP
+.B \-\-keying-material-exporter-label label [RFC 5705]
+Labels here have the same definition as in TLS, i.e., an ASCII string with no 
+terminating NULL. Note that exporter labels have the potential to collide with 
+existing PRF labels.  In order to prevent this, labels MUST begin with 
+"EXPORTER".
+.\"*********************************************************
+.TP
+.B \-\-keying-material-exporter-length length [RFC 5705]
+The output is a pseudorandom bit string of length bytes derived from TLS.
+.\"*********************************************************
 .SS Server Mode
 Starting with OpenVPN 2.0, a multi-client TCP/UDP server mode
 is supported, and can be enabled with the
@@ -6116,6 +6127,11 @@ Like
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
-- 
1.7.1


--sm4nu43k4a2Rpi4c--

