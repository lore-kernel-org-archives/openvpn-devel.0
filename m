Sender: daniel kubec <kubec.daniel@...277...>
Date: Wed, 27 Aug 2014 11:34:11 +0200
From: Daniel Kubec <niel@...1898...>
Message-ID: <20140827093409.GA659@...1900...>
References: <20140526132551.GA9011@...1915...>
	<5390E0F0.5000808@...1114...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <5390E0F0.5000808@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Add support for Keying Material
 Exporter [RFC 5705]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I am sorry for the delay but I was very busy :( I hope that I resolved
all issues.

I made several tests with my aaa plugin prototype based on following
crypto backends: 

        openssl-1.0.0m    (no EKM support)
        openssl-1.0.1     (with EKM support)
        openssl-1.1.0-dev (with EKM support)
        PolarSSL 1.3.8    (no EKM support)

a) tls_binding_key is available in OPENVPN_PLUGIN_TLS_FINAL only.
b) It depends (if someone request such feature I am open for extending)
c) Hex format is without spaces
d) It is working with PolarSSL
f) Man pages were updated to:

Save Exported Keying Material [RFC5705] of len bytes using label in
environment (tls_binding_key) for use by plugins in OPENVPN_PLUGIN_TLS_FINAL
callback.

Note that exporter labels have the potential to collide with existing
PRF labels. In order to prevent this, labels MUST begin with "EXPORTER".
This option requires OpenSSL 1.0.1 or newer.


Regards

Daniel


On Thu, Jun 05, 2014 at 11:28:16PM +0200, David Sommerseth wrote:
> On 26/05/14 15:25, Daniel Kubec wrote:
> > Add support for TLS Keying Material Exporters [RFC 5705].
> >     
> > Keying Material Exporter allow additional keying material to be derived from existing TLS channel. 
> > This exported keying material can then be used for a variety of purposes.
> > 
> 
> I've finally had some time to compile and test this patch, as well as
> done code review of it.  First of all, this is a good piece of work!  So
> I'm looking forward to see this arrive in OpenVPN.  It will surely help
> develop more advanced authentication methods.
> 
> The patch does indeed work quite well.  It provides a tls_binding_key
> environment variable to plugins which supports OPENVPN_PLUGIN_TLS_FINAL.
> 
> Here's my comments, thoughts and questions ...
> 
> a) Is the intention that this tls_binding_key variable should only be
>    available when the OPENVPN_PLUGIN_TLS_FINAL plugin call happens?
> 
>    Currently tls_binding_key is available to all plugin *and* script
>    calls happening after OPENVPN_PLUGIN_TLS_FINAL has been called.  But
>    *only* after a plugin which supports this hook has run.  This smells
>    like a bug.
> 
>    I think I would recommend this variable only to available for the
>    OPENVPN_PLUGIN_TLS_FINAL call.  Which means you would need to add a
>    setenv_del() in ssl.c:key_method_2_read() after plugin_call().
> 
>    I spotted tls_binding_key in the following hooks (using a slightly
>    modified sample-plugin/log/log.c)
> 
>    Client side: PLUGIN_IPCHANGE, PLUGIN_UP, PLUGIN_ROUTE_UP
>                 and PLUGIN_ROUTE_DOWN
> 
>    Server side: PLUGIN_IPCHANGE, PLUGIN_CLIENT_CONNECT_V2*,
>                 PLUGIN_LEARN_ADDRESS and PLUGIN_CLIENT_DISCONNECT
> 
>                 * Most likely PLUGIN_CLIENT_CONNECT too
> 
>    I also tried to use a --client-connect script which dumps 'printenv'
>    to a file.  When this log.so plug-in was used, I saw tls_binding_key
>    in the printenv dump.  It was not present when log.so was not loaded.
> 
> 
> b) Should there be a script-hook available for this as well?
> 
>    This could make it possible to make authentication methods using
>    scripts as an addition to plug-ins written in C.  Just thinking
>    aloud, not saying it's a requirement.
> 
> 
> c) The format is currently like this:
>              0f3d5a7a 8b78fe1a 8a7fce61 58b89142
>    Is this format the preferred formatting?
> 
>    Other formats are available through format_hex_ex().  I would
>    probably recommend another separator than space, if a separator is
>    needed at all.
> 
> 
> d) This patch breaks building with PolarSSL.
> 
>    ssl.o: In function `key_method_2_read':
>    ~/openvpn.git/src/openvpn/ssl.c:2129: undefined reference to
>    `key_state_export_keying_material'
>    collect2: error: ld returned 1 exit status
> 
>    I would recommend to add a kind of wrapper function in
>    ssl_polarssl.c which adds this function.  Not sure if it would
>    be appropriate to do an ASSERT(0) or do something else.  Maybe it
>    should not set anything, just return without adding the
>    tls_binding_key.  When plug-ins expecting to see this fails to find
>    this variable, it will the plug-in's responsibility to not explode.
> 
> 
> e) Has this patch been tested with OpenSSL < 1.0.1?
> 
>    Is it really needed with the #else ASSERT(0); ?
> 
> 
> f) It should be stated better in the man page that this feature depends
>    on a plug-in supporting OPENVPN_PLUGIN_TLS_FINAL.
> 
> 
> -- 
> kind regards,
> 
> David Sommerseth
> 



--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Added-support-for-TLS-Keying-Material-Exporters-RFC-.patch"

From 2c4d6aeb0aa24792afb7df45a64de8e04416b95e Mon Sep 17 00:00:00 2001
From: Daniel Kubec <niel@...1898...>
Date: Wed, 27 Aug 2014 11:02:37 +0200
Subject: [PATCH] Added support for TLS Keying Material Exporters [RFC 5705].

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
index f2911c0..433dd86 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2684,6 +2684,16 @@ client-connect), then
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
index a673be5..a3c9606 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2249,6 +2249,20 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
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
index f536daa..e375235 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -623,6 +623,10 @@ static const char usage_message[] =
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
@@ -6985,6 +6989,29 @@ add_option (struct options *options,
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
index 5ba4f2f..bf7eb65 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -598,6 +598,12 @@ struct options
   bool show_net_up;
   int route_method;
 #endif
+
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000
+  /* Keying Material Exporters [RFC 5705] */
+  const char *keying_material_exporter_label;
+  int keying_material_exporter_length;
+#endif
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3ce1f60..0a486d2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2130,8 +2130,12 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
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
index bfd1549..db05e3b 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -333,6 +333,19 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
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
index adf3ae6..3c733ee 100644
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
index ddccf1d..f9072ef 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -146,6 +146,12 @@ tls_ctx_initialised(struct tls_root_ctx *ctx)
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


--YZ5djTAD1cGYuMQK--

