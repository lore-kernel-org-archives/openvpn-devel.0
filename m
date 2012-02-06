Message-ID: <4F2FAE4A.9000401@...1147...>
Date: Mon, 06 Feb 2012 11:41:14 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000400050104050406050309"
Subject: [Openvpn-devel] Elliptic curve patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000400050104050406050309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi all,

attached is my elliptic curve patch, to add support for using ECDSA 
curves in combination with SHA256/SHA512 signed certificates; currently 
you can do either ECDSA with SHA1-signed certificates, or no ECDSA but 
SHA256/SHA512 signed certs . The error message seen is
  SSL3_CLIENT_GET_HELLO:no shared cipher
 This patch overcomes this.

With the patch you should see for the control channel:
   Control Channel: TLSv1, cipher TLSv1/SSLv3 ECDHE-ECDSA-AES256-SHA

Two new parameters are added to OpenVPN
  --show-curves
to list the available elliptic curves, and
  --ecdh <name>
to select a curve name.

TODO: this code is currently only enabled using '#ifdef USE_SSL_EC' ; 
I've manually added a line
  #define USE_SSL_EC 1
to config.h after a './configure' step. I'm not familiar enough with 
autoconf and friends to turn it into an .ac script:
- you need OpenSSL 1.0+ WITH EC support enabled (RedHat , for example, 
disables it by default)
- PolarSSL does not support it (yet).

It would be great if somebody can help me sort the autoconf thing out.

The patch was tested on Fedora 14 64bit using a git cloned repo , but 
without the latest buffer.c patch.


cheers,

JJK


--------------000400050104050406050309
Content-Type: text/plain;
 name="ecdsa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ecdsa.patch"

diff -Naur openvpn.git/init.c openvpn.git-ecdsa/init.c
--- openvpn.git/init.c	2012-02-06 11:21:16.393339212 +0100
+++ openvpn.git-ecdsa/init.c	2012-02-06 10:53:25.936655131 +0100
@@ -895,6 +895,9 @@
   if (options->show_ciphers || options->show_digests || options->show_engines
 #ifdef USE_SSL
       || options->show_tls_ciphers
+#ifdef USE_SSL_EC
+|| options->show_curves
+#endif
 #endif
     )
     {
@@ -907,6 +910,10 @@
 #ifdef USE_SSL
       if (options->show_tls_ciphers)
 	show_available_tls_ciphers ();
+#ifdef USE_SSL_EC
+      if (options->show_curves)
+    show_available_curves ();
+#endif
 #endif
       return true;
     }
diff -Naur openvpn.git/options.c openvpn.git-ecdsa/options.c
--- openvpn.git/options.c	2012-02-06 11:21:16.401340746 +0100
+++ openvpn.git-ecdsa/options.c	2012-02-06 10:51:02.289625514 +0100
@@ -836,6 +836,9 @@
 #ifdef ENABLE_X509ALTUSERNAME
   o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
 #endif
+#ifdef USE_SSL_EC
+  o->curve_name = NULL;
+#endif
 #endif /* USE_SSL */
 #endif /* USE_CRYPTO */
 #ifdef ENABLE_PKCS11
@@ -6368,6 +6371,18 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->show_tls_ciphers = true;
     }
+#ifdef USE_SSL_EC
+  else if (streq (p[0], "show-curves"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->show_curves = true;
+    }
+  else if (streq (p[0], "ecdh") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      options->curve_name= p[1];
+    }
+#endif
   else if (streq (p[0], "tls-server"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff -Naur openvpn.git/options.h openvpn.git-ecdsa/options.h
--- openvpn.git/options.h	2012-02-06 11:21:16.401340746 +0100
+++ openvpn.git-ecdsa/options.h	2012-02-06 10:51:11.030222937 +0100
@@ -200,6 +200,9 @@
   bool show_engines;
 #ifdef USE_SSL
   bool show_tls_ciphers;
+#ifdef USE_SSL_EC
+  bool show_curves;
+#endif
 #endif
   bool genkey;
 #endif
@@ -533,6 +536,9 @@
   const char *priv_key_file;
   const char *pkcs12_file;
   const char *cipher_list;
+#ifdef USE_SSL_EC
+  const char *curve_name;
+#endif
   const char *tls_verify;
   const char *tls_export_cert;
   const char *tls_remote;
diff -Naur openvpn.git/ssl.c openvpn.git-ecdsa/ssl.c
--- openvpn.git/ssl.c	2012-02-06 11:21:16.410342470 +0100
+++ openvpn.git-ecdsa/ssl.c	2012-02-06 10:51:20.431949238 +0100
@@ -308,6 +308,9 @@
     {
       tls_ctx_server_new(new_ctx);
       tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_inline);
+#ifdef USE_SSL_EC
+      tls_ctx_load_ecdh_params(new_ctx, options->curve_name);
+#endif
     }
   else				/* if client */
     {
diff -Naur openvpn.git/ssl_backend.h openvpn.git-ecdsa/ssl_backend.h
--- openvpn.git/ssl_backend.h	2012-02-06 11:21:16.410342470 +0100
+++ openvpn.git-ecdsa/ssl_backend.h	2012-02-06 10:39:19.840445199 +0100
@@ -145,6 +145,16 @@
     );
 
 /**
+ * Load Elliptic Curve Parameters, and load them into the library-specific
+ * TLS context.
+ *
+ * @param ctx			TLS context to use
+ * @param curve_name	The name of the elliptic curve to load.
+ */
+void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
+    );
+
+/**
  * Load PKCS #12 file for key, cert and (optionally) CA certs, and add to
  * library-specific TLS context.
  *
diff -Naur openvpn.git/ssl_openssl.c openvpn.git-ecdsa/ssl_openssl.c
--- openvpn.git/ssl_openssl.c	2012-02-06 11:21:16.410342470 +0100
+++ openvpn.git-ecdsa/ssl_openssl.c	2012-02-06 10:51:39.447464796 +0100
@@ -50,6 +50,9 @@
 #include <openssl/pkcs12.h>
 #include <openssl/x509.h>
 #include <openssl/crypto.h>
+#ifdef USE_SSL_EC
+#include <openssl/ec.h>
+#endif
 
 /*
  * Allocate space in SSL objects in which to store a struct tls_session
@@ -238,6 +241,46 @@
   DH_free (dh);
 }
 
+void
+tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char *curve_name
+    )
+{
+#ifdef USE_SSL_EC
+  if (curve_name != NULL)
+  {
+    int nid;
+    EC_KEY   *ecdh  = NULL;
+  
+    nid = OBJ_sn2nid(curve_name);
+  
+    if (nid == 0)
+      msg(M_SSLERR, "unknown curve name (%s)", curve_name);
+    else
+    {
+      ecdh = EC_KEY_new_by_curve_name(nid);
+      if (ecdh == NULL)
+        msg (M_SSLERR, "Unable to create curve (%s)", curve_name);
+      else
+      {
+        const char *sname;
+  
+        if (!SSL_CTX_set_tmp_ecdh(ctx->ctx, ecdh))
+          msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh: cannot add curve");
+  
+        /* Translate NID back to name , just for kicks */
+        sname   = OBJ_nid2sn(nid);
+        if (sname == NULL) sname = "(Unknown)";
+        msg (D_TLS_DEBUG_LOW, "ECDH curve %s added", sname);
+  
+        EC_KEY_free(ecdh);
+      }
+    }
+  }
+#else
+  msg(M_SSLERR, "Elliptic Curves not supported by this version of OpenSSL");
+#endif
+}
+
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 #if ENABLE_INLINE_FILES
@@ -1273,6 +1316,47 @@
   SSL_CTX_free (ctx);
 }
 
+/*
+ *  * Show the Elliptic curves that are available for us to use
+ *   * in the OpenSSL library.
+ *    */
+#ifdef USE_SSL_EC
+void
+show_available_curves()
+{
+  EC_builtin_curve *curves = NULL;
+  size_t crv_len = 0;
+  size_t n = 0;
+
+  crv_len = EC_get_builtin_curves(NULL, 0);
+
+  curves = OPENSSL_malloc((int)(sizeof(EC_builtin_curve) * crv_len));
+
+  if (curves == NULL)
+    msg (M_SSLERR, "Cannot create EC_builtin_curve object");
+  else
+  {
+    if (EC_get_builtin_curves(curves, crv_len))
+    {
+      printf ("Available Elliptic curves:\n");
+      for (n = 0; n < crv_len; n++)
+      {
+        const char *sname;
+        sname   = OBJ_nid2sn(curves[n].nid);
+        if (sname == NULL) sname = "";
+
+        printf("%s\n", sname);
+      }
+    }
+    else
+    {
+      msg (M_SSLERR, "Cannot get list of builtin curves");
+    }
+    OPENSSL_free(curves);
+  }
+}
+#endif
+
 void
 get_highest_preference_tls_cipher (char *buf, int size)
 {
diff -Naur openvpn.git/ssl_polarssl.c openvpn.git-ecdsa/ssl_polarssl.c
--- openvpn.git/ssl_polarssl.c	2012-02-06 11:21:16.411342662 +0100
+++ openvpn.git-ecdsa/ssl_polarssl.c	2012-02-06 10:51:57.180770725 +0100
@@ -218,6 +218,15 @@
       (counter_type) 8 * mpi_size(&ctx->dhm_ctx->P));
 }
 
+#ifdef USE_SSL_EC
+void
+tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char *curve_name
+    )
+{
+    msg(M_WARN, "Elliptic Curves not yet supported by PolarSSL");
+}
+#endif
+
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 #if ENABLE_INLINE_FILES

--------------000400050104050406050309--

