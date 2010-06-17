Message-ID: <4C19ED93.50202@...1380...>
Date: Thu, 17 Jun 2010 11:40:35 +0200
From: Emilien Mantel <emilien.mantel@...1380...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090407000304020504020506"
Subject: [Openvpn-devel] [PATCH] Choose a different field in X509 to be
	username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090407000304020504020506
Content-Type: multipart/alternative;
	boundary="------------000408020705060409090105"

--------------000408020705060409090105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

For my company, we use a PKI (linked to a LDAP) with OpenVPN. We can't 
use "CN" to be username (few people can have the same "CN"). In our 
case, we only use the UID.

With my patch, you can choose another field to be username with a new 
option called "x509-username-field", the default value is "CN".

Best regards

-- 
Emilien Mantel


--------------000408020705060409090105
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
</head>
<body bgcolor="#ffffff" text="#000000">
<div class="moz-text-flowed"
 style="font-family: -moz-fixed; font-size: 12px;" lang="x-western">Hi,
<br>
<br>
For my company, we use a PKI (linked to a LDAP) with OpenVPN. We can't
use "CN" to be username (few people can have the same "CN"). In our
case, we only use the UID.
<br>
<br>
With my patch, you can choose another field to be username with a new
option called "x509-username-field", the default value is "CN".
<br>
<br>
Best regards
<br>
<br>
--
<br>
Emilien Mantel
<br>
</div>
<pre wrap="">
</pre>
</body>
</html>

--------------000408020705060409090105--

--------------090407000304020504020506
Content-Type: text/x-patch;
 name="openvpn.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="openvpn.patch"

diff --git a/options.c b/options.c
index 35f3f13..d2d04e2 100644
--- a/options.c
+++ b/options.c
@@ -533,6 +533,8 @@ static const char usage_message[] =
   "--key file      : Local private key in .pem format.\n"
   "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
   "                  and optionally the root CA certificate.\n"
+  "--x509-username-field : Field used in x509 certificat to be username.\n"
+  "                        Default is CN.\n"
 #ifdef WIN32
   "--cryptoapicert select-string : Load the certificate and private key from the\n"
   "                  Windows Certificate System Store.\n"
@@ -786,6 +788,7 @@ init_options (struct options *o, const bool init_gc)
   o->renegotiate_seconds = 3600;
   o->handshake_window = 60;
   o->transition_window = 3600;
+  o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
 #endif
 #endif
 #ifdef ENABLE_PKCS11
@@ -6191,6 +6194,27 @@ add_option (struct options *options,
 	}
       options->key_method = key_method;
     }
+  else if (streq (p[0], "x509-username-field") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      /* Uppercase if necessary */
+      {
+	char *s = p[1];
+	int c, flag = 0;
+
+	while ((c = *s) != '\0') 
+          {
+	    if (c >= 'a' && c <= 'z') 
+              {
+                c = c + 'A' - 'a';
+		flag++;
+              }
+            *s = (char) c;
+            s++;
+	  }
+      }
+      options->x509_username_field = p[1];
+    }
 #endif /* USE_SSL */
 #endif /* USE_CRYPTO */
 #ifdef ENABLE_PKCS11
diff --git a/options.h b/options.h
index ccc03df..1a90f86 100644
--- a/options.h
+++ b/options.h
@@ -526,6 +526,9 @@ struct options
      within n seconds of handshake initiation. */
   int handshake_window;
 
+  /* Field used to be the username in X509 cert. */
+  char *x509_username_field;
+
   /* Old key allowed to live n seconds after new key goes active */
   int transition_window;
 
diff --git a/ssl.c b/ssl.c
index b0fb6e4..f6e2410 100644
--- a/ssl.c
+++ b/ssl.c
@@ -734,6 +734,8 @@ get_peer_cert(X509_STORE_CTX *ctx, const char *tmp_dir, struct gc_arena *gc)
   return peercert_filename;
 }
 
+char * x509_username_field; /* GLOBAL */
+
 /*
  * Our verify callback function -- check
  * that an incoming peer certificate is good.
@@ -744,7 +746,7 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
 {
   char *subject = NULL;
   char envname[64];
-  char common_name[TLS_CN_LEN];
+  char common_name[TLS_USERNAME_LEN];
   SSL *ssl;
   struct tls_session *session;
   const struct tls_options *opt;
@@ -776,18 +778,20 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
   string_mod_sslname (subject, X509_NAME_CHAR_CLASS, opt->ssl_flags);
   string_replace_leading (subject, '-', '_');
 
-  /* extract the common name */
-  if (!extract_x509_field_ssl (X509_get_subject_name (ctx->current_cert), "CN", common_name, TLS_CN_LEN))
+  /* extract the username (default is CN) */
+  if (!extract_x509_field_ssl (X509_get_subject_name (ctx->current_cert), x509_username_field, common_name, TLS_USERNAME_LEN))
     {
       if (!ctx->error_depth)
-	{
-	  msg (D_TLS_ERRORS, "VERIFY ERROR: could not extract Common Name from X509 subject string ('%s') -- note that the Common Name length is limited to %d characters",
-	       subject,
-	       TLS_CN_LEN);
-	  goto err;
-	}
+        {
+          msg (D_TLS_ERRORS, "VERIFY ERROR: could not extract %s from X509 subject string ('%s') -- note that the username length is limited to %d characters",
+                 x509_username_field,
+                 subject,
+                 TLS_USERNAME_LEN);
+          goto err;
+        }
     }
 
+
   string_mod_sslname (common_name, COMMON_NAME_CHAR_CLASS, opt->ssl_flags);
 
   cert_hash_remember (session, ctx->error_depth, ctx->current_cert->sha1_hash);
@@ -1822,7 +1826,8 @@ init_ssl (const struct options *options)
     }
   else
 #endif
-    SSL_CTX_set_verify (ctx, SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT,
+  x509_username_field = (char *) options->x509_username_field;
+  SSL_CTX_set_verify (ctx, SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT,
 			verify_callback);
 
   /* Connection information callback */
@@ -3755,9 +3760,9 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
 	s2 = verify_user_pass_script (session, up);
 
       /* check sizing of username if it will become our common name */
-      if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) && strlen (up->username) >= TLS_CN_LEN)
+      if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) && strlen (up->username) >= TLS_USERNAME_LEN)
 	{
-	  msg (D_TLS_ERRORS, "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters", TLS_CN_LEN);
+	  msg (D_TLS_ERRORS, "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters", TLS_USERNAME_LEN);
 	  s1 = OPENVPN_PLUGIN_FUNC_ERROR;
 	}
 
diff --git a/ssl.h b/ssl.h
index 34c6988..02234c3 100644
--- a/ssl.h
+++ b/ssl.h
@@ -278,8 +278,8 @@
  * Buffer sizes (also see mtu.h).
  */
 
-/* Maximum length of common name */
-#define TLS_CN_LEN 64
+/* Maximum length of the username in cert */
+#define TLS_USERNAME_LEN 64
 
 /* Legal characters in an X509 or common name */
 #define X509_NAME_CHAR_CLASS   (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_COLON|CC_SLASH|CC_EQUAL)
@@ -288,6 +288,9 @@
 /* Maximum length of OCC options string passed as part of auth handshake */
 #define TLS_OPTIONS_LEN 512
 
+/* Default field in X509 to be username */
+#define X509_USERNAME_FIELD_DEFAULT "CN"
+
 /*
  * Range of key exchange methods
  */

--------------090407000304020504020506--

