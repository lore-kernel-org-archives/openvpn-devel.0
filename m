Message-ID: <4854293F.8090107@...1107...>
Date: Sat, 14 Jun 2008 22:25:35 +0200
From: Andrzej Chmielowiec <andrzej.chmielowiec@...1107...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060104000909050806070402"
Subject: Re: [Openvpn-devel] OpenVPN and ECC support
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
--------------060104000909050806070402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

James Yonan pisze:
> Andrzej Chmielowiec wrote:
>> Hi All,
>>
>> I send two patches to OpenVPN which gives Elliptic Curve support.
>
> Thanks for the patch.  It would be great if you could resubmit the 
> patch against the OpenVPN 2.1 head in the subversion repository, since 
> that is where we will need to merge it.
>
> http://svn.openvpn.net/
>
> Also, make sure that "./configure --enable-strict && make" compiles 
> your code without warnings.
>
> Thanks,
> James
>
Here is a patch for OpenVPN 2.1 which has been taken form http://svn.openvpn.net/ 
(11.06.2008). After patching OpenVPN project there are no new warnings.

This OpenVPN version is tested by my company over one year in different 
configurations. I hope it will be also usefull for others.

We are also under development of GPL GUI (Windows, MacOS and Linux) based on Qt. 
It will be used to
  * generate keys and certificete requests,
  * generate certificetes, manage them and CRLs distribution,
  * setup OpenVPN client connections based on certificates.
I hope it will be ready soon.

Regards,
Andrzej



--------------060104000909050806070402
Content-Type: text/x-diff;
 name="openvpn-ecc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-ecc.patch"

diff -Naur openvpn/crypto.c openvpn-ecc/crypto.c
--- openvpn/crypto.c	2008-06-11 18:48:23.000000000 +0200
+++ openvpn-ecc/crypto.c	2008-06-11 20:05:08.000000000 +0200
@@ -1571,12 +1571,29 @@
 }
 
 static ENGINE *
-setup_engine (const char *engine)
+setup_engine (char *engine)
 {
+  char *engine_ctrl[128];
+  char *engine_ptr = engine;
   ENGINE *e = NULL;
 
+  int n = 0;
+  int i;
+
   ENGINE_load_builtin_engines ();
 
+  /* Read engine ctrol commands and its values. */
+  while ((n < 128) && ((engine_ptr = strchr(engine_ptr, ':')) != 0))
+    {
+      engine_ptr[0] = '\0';
+      engine_ctrl[n++] = ++engine_ptr;
+    }
+
+  if (n & 1)
+    {
+      msg (M_FATAL, "Wrong number of paramethers for engine '%s'", engine);
+    }
+
   if (engine)
     {
       if (strcmp (engine, "auto") == 0)
@@ -1591,6 +1608,22 @@
 	  msg (M_FATAL, "OpenSSL error: cannot load engine '%s'", engine);
 	}
 
+      /* Apply engine control commands. */
+      for (i = 0; i < n; i += 2)
+        {
+          if (!ENGINE_ctrl_cmd_string(e, engine_ctrl[i], engine_ctrl[i + 1], 0))
+            {
+              msg (M_FATAL, "OpenSSL error: ENGINE_ctrl_cmd_string failed on engine '%s', "
+                "command '%s' and value '%s'", engine, engine_ctrl[i], engine_ctrl[i + 1]);
+            }
+        }
+
+      /* Clear engine commands and its values. */
+      for (i = 0; i < n; i++)
+        {
+          memset(engine_ctrl[i], 0, strlen(engine_ctrl[i]));
+        }
+
       if (!ENGINE_set_default (e, ENGINE_METHOD_ALL))
 	{
 	  msg (M_FATAL, "OpenSSL error: ENGINE_set_default failed on engine '%s'",
@@ -1605,7 +1638,7 @@
 #endif
 
 void
-init_crypto_lib_engine (const char *engine_name)
+init_crypto_lib_engine (char *engine_name)
 {
   if (!engine_initialized)
     {
@@ -1626,10 +1659,14 @@
  */
 void init_crypto_lib ()
 {
+  /* Read OpenSSL default configuration file (loading CONF modules). */
+  OPENSSL_config (NULL);
 }
 
 void uninit_crypto_lib ()
 {
+  /* Unload OpenSSL CONF modules. */
+  CONF_modules_unload (1);
 #if CRYPTO_ENGINE
   if (engine_initialized)
     {
diff -Naur openvpn/crypto.h openvpn-ecc/crypto.h
--- openvpn/crypto.h	2008-06-11 18:48:23.000000000 +0200
+++ openvpn-ecc/crypto.h	2008-06-11 20:36:47.000000000 +0200
@@ -37,6 +37,7 @@
 #define CRYPTO_ENGINE 0
 #endif
 
+#include <openssl/conf.h>
 #include <openssl/objects.h>
 #include <openssl/rand.h>
 #include <openssl/evp.h>
@@ -345,7 +346,7 @@
 
 void show_available_engines (void);
 
-void init_crypto_lib_engine (const char *engine_name);
+void init_crypto_lib_engine (char *engine_name);
 
 void init_crypto_lib (void);
 
diff -Naur openvpn/options.c openvpn-ecc/options.c
--- openvpn/options.c	2008-06-11 18:48:23.000000000 +0200
+++ openvpn-ecc/options.c	2008-06-11 19:38:14.000000000 +0200
@@ -423,7 +423,10 @@
   "--keysize n     : Size of cipher key in bits (optional).\n"
   "                  If unspecified, defaults to cipher-specific default.\n"
 #endif
-  "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
+  "--engine [name[:cmd:val]..[:cmd:val]] : Enable OpenSSL hardware crypto \n"
+  "                  engine functionality. You can also pass control commands\n"
+  "                  and its values to the engine (use ':' char to separate\n"
+  "                  them).\n"
   "--no-replay     : Disable replay protection.\n"
   "--mute-replay-warnings : Silence the output of replay warnings to log file.\n"
   "--replay-window n [t]  : Use a replay protection sliding window of size n\n"
@@ -454,9 +457,16 @@
   "--dh file       : File containing Diffie Hellman parameters\n"
   "                  in .pem format (for --tls-server only).\n"
   "                  Use \"openssl dhparam -out dh1024.pem 1024\" to generate.\n"
+  "--ecdh file     : File containing Elliptic Curve Diffie Hellman parameters\n"
+  "                  Object Identifier in .pem format (for --tls-server only).\n"
+  "                  Use \"openssl ecparam -out ecdh_oid.pem -name curve\" to\n"
+  "                  generate and \"openssl ecparam -list_curves\" to get\n"
+  "                  avaliable and supported ECC domains.\n"
   "--cert file     : Local certificate in .pem format -- must be signed\n"
   "                  by a Certificate Authority in --ca file.\n"
   "--key file      : Local private key in .pem format.\n"
+  "--engkey        : This option must be specified if key file is avaliable only\n"
+  "                  by OpenSSL engine indicated by --engine option.\n"
   "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
   "                  and optionally the root CA certificate.\n"
 #ifdef WIN32
@@ -567,7 +577,7 @@
   "                    DISABLE-NBT : Disable Netbios-over-TCP/IP.\n"
   "--dhcp-renew       : Ask Windows to renew the TAP adapter lease on startup.\n"
   "--dhcp-pre-release : Ask Windows to release the previous TAP adapter lease on\n"
-"                       startup.\n"
+  "                     startup.\n"
   "--dhcp-release     : Ask Windows to release the TAP adapter lease on shutdown.\n"
   "--tap-sleep n   : Sleep for n seconds after TAP adapter open before\n"
   "                  attempting to set adapter properties.\n"
@@ -1254,8 +1264,10 @@
   SHOW_STR (ca_file);
   SHOW_STR (ca_path);
   SHOW_STR (dh_file);
+  SHOW_STR (ecdh_file);
   SHOW_STR (cert_file);
   SHOW_STR (priv_key_file);
+  SHOW_BOOL (priv_eng_key);
   SHOW_STR (pkcs12_file);
 #ifdef WIN32
   SHOW_STR (cryptoapi_cert);
@@ -1738,7 +1750,8 @@
 
   if (options->tls_server)
     {
-      notnull (options->dh_file, "DH file (--dh)");
+      if (!options->dh_file && !options->ecdh_file)
+        msg (M_USAGE, "You must define DH or ECDH file (--dh or --ecdh)");
     }
   if (options->tls_server || options->tls_client)
     {
@@ -1829,8 +1842,10 @@
       MUST_BE_UNDEF (ca_file);
       MUST_BE_UNDEF (ca_path);
       MUST_BE_UNDEF (dh_file);
+      MUST_BE_UNDEF (ecdh_file);
       MUST_BE_UNDEF (cert_file);
       MUST_BE_UNDEF (priv_key_file);
+      MUST_BE_UNDEF (priv_eng_key);
       MUST_BE_UNDEF (pkcs12_file);
       MUST_BE_UNDEF (cipher_list);
       MUST_BE_UNDEF (tls_verify);
@@ -5092,6 +5107,17 @@
 	}
 #endif
     }
+  else if (streq (p[0], "ecdh") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->ecdh_file = p[1];
+#if ENABLE_INLINE_FILES
+      if (streq (p[1], INLINE_FILE_TAG) && p[2])
+	{
+	  options->ecdh_file_inline = p[2];
+	}
+#endif
+    }
   else if (streq (p[0], "cert") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -5121,6 +5147,11 @@
 	}
 #endif
     }
+  else if (streq (p[0], "engkey"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->priv_eng_key = true;
+    }
   else if (streq (p[0], "pkcs12") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff -Naur openvpn/options.h openvpn-ecc/options.h
--- openvpn/options.h	2008-06-11 18:48:23.000000000 +0200
+++ openvpn-ecc/options.h	2008-06-11 19:55:48.000000000 +0200
@@ -409,7 +409,7 @@
   bool authname_defined;
   const char *authname;
   int keysize;
-  const char *engine;
+  char *engine;
   bool replay;
   bool mute_replay_warnings;
   int replay_window;
@@ -425,8 +425,10 @@
   const char *ca_file;
   const char *ca_path;
   const char *dh_file;
+  const char *ecdh_file;
   const char *cert_file;
   const char *priv_key_file;
+  bool priv_eng_key;
   const char *pkcs12_file;
   const char *cipher_list;
   const char *tls_verify;
@@ -438,6 +440,7 @@
   const char *cert_file_inline;
   char *priv_key_file_inline;
   const char *dh_file_inline;
+  const char *ecdh_file_inline;
 #endif
 
   int ns_cert_type; /* set to 0, NS_SSL_SERVER, or NS_SSL_CLIENT */
diff -Naur openvpn/ssl.c openvpn-ecc/ssl.c
--- openvpn/ssl.c	2008-06-11 18:48:23.000000000 +0200
+++ openvpn-ecc/ssl.c	2008-06-11 19:55:48.000000000 +0200
@@ -1264,7 +1264,12 @@
 init_ssl (const struct options *options)
 {
   SSL_CTX *ctx = NULL;
+  ENGINE *e;
   DH *dh;
+  EC_GROUP *ecdh_group;
+  EC_KEY *ecdh;
+  EVP_PKEY *pkey;
+  UI_METHOD *ui_method;
   BIO *bio;
   bool using_cert_file = false;
 
@@ -1278,29 +1283,66 @@
 
       SSL_CTX_set_tmp_rsa_callback (ctx, tmp_rsa_cb);
 
-#if ENABLE_INLINE_FILES
-      if (!strcmp (options->dh_file, INLINE_FILE_TAG) && options->dh_file_inline)
-	{
-	  if (!(bio = BIO_new_mem_buf ((char *)options->dh_file_inline, -1)))
-	    msg (M_SSLERR, "Cannot open memory BIO for inline DH parameters");
-	}
+      if (!options->dh_file && !options->ecdh_file)
+        msg (M_SSLERR, "There is no file for DH or ECDH parameters");
       else
+        {
+          if (options->dh_file)
+            {
+#if ENABLE_INLINE_FILES
+              if (!strcmp (options->dh_file, INLINE_FILE_TAG) && options->dh_file_inline)
+                {
+                  if (!(bio = BIO_new_mem_buf ((char *)options->dh_file_inline, -1)))
+                    msg (M_SSLERR, "Cannot open memory BIO for inline DH parameters");
+                }
+              else
 #endif
-	{
-	  /* Get Diffie Hellman Parameters */
-	  if (!(bio = BIO_new_file (options->dh_file, "r")))
-	    msg (M_SSLERR, "Cannot open %s for DH parameters", options->dh_file);
-	}
+                {
+                  /* Get Diffie Hellman Parameters */
+                  if (!(bio = BIO_new_file (options->dh_file, "r")))
+                    msg (M_SSLERR, "Cannot open %s for DH parameters", options->dh_file);
+                }
+
+              dh = PEM_read_bio_DHparams (bio, NULL, NULL, NULL);
+              BIO_free (bio);
+              if (!dh)
+                msg (M_SSLERR, "Cannot load DH parameters from %s", options->dh_file);
+              if (!SSL_CTX_set_tmp_dh (ctx, dh))
+                msg (M_SSLERR, "SSL_CTX_set_tmp_dh");
+              msg (D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with %d bit key",
+                8 * DH_size (dh));
+              DH_free (dh);
+            }
+          if (options->ecdh_file)
+            {
+#if ENABLE_INLINE_FILES
+              if (!strcmp (options->ecdh_file, INLINE_FILE_TAG) && options->ecdh_file_inline)
+                {
+                  if (!(bio = BIO_new_mem_buf ((char *)options->ecdh_file_inline, -1)))
+                    msg (M_SSLERR, "Cannot open memory BIO for inline ECDH parameters");
+                }
+              else
+#endif
+                {
+                  /* Get Elliptic Curve Diffie Hellman Parameters */
+                  if (!(bio = BIO_new_file (options->ecdh_file, "r")))
+                    msg (M_SSLERR, "Cannot open %s for ECDH parameters", options->ecdh_file);
+                }
 
-      dh = PEM_read_bio_DHparams (bio, NULL, NULL, NULL);
-      BIO_free (bio);
-      if (!dh)
-	msg (M_SSLERR, "Cannot load DH parameters from %s", options->dh_file);
-      if (!SSL_CTX_set_tmp_dh (ctx, dh))
-	msg (M_SSLERR, "SSL_CTX_set_tmp_dh");
-      msg (D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with %d bit key",
-	   8 * DH_size (dh));
-      DH_free (dh);
+              ecdh_group = PEM_read_bio_ECPKParameters (bio, NULL, NULL, NULL);
+              BIO_free (bio);
+              if (!ecdh_group)
+                msg (M_SSLERR, "Cannot load ECDH parameters from %s", options->ecdh_file);
+              ecdh = EC_KEY_new();
+              EC_KEY_set_group(ecdh, ecdh_group);
+              if (!SSL_CTX_set_tmp_ecdh (ctx, ecdh) || !SSL_CTX_set_options(ctx, SSL_OP_SINGLE_ECDH_USE))
+                msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh");
+              msg (D_TLS_DEBUG_LOW, "Elliptic Curve Diffie-Hellman initialized with %d bit key",
+              EC_GROUP_get_degree (ecdh_group));
+              EC_GROUP_free(ecdh_group);
+              EC_KEY_free (ecdh);
+            }
+        }
     }
   else				/* if client */
     {
@@ -1424,8 +1466,8 @@
 		}
 	    }
 
-	  /* Load Private Key */
-	  if (options->priv_key_file)
+          /* Load Private Key from PEM file */
+          if (options->priv_key_file && !options->priv_eng_key)
 	    {
 	      int status;
 	      
@@ -1454,6 +1496,24 @@
 	      if (!SSL_CTX_check_private_key (ctx))
 		msg (M_SSLERR, "Private key does not match the certificate");
 	    }
+	  /* Load Private Key from ENGINE file */
+	  else if (options->priv_key_file && options->priv_eng_key && options->engine)
+	    {
+	      if ((e = ENGINE_by_id(options->engine)) == NULL)
+	        msg (M_SSLERR, "OpenSSL engine with id %s is not initialized", options->engine);
+
+	      ui_method = UI_OpenSSL ();
+
+	      if ((pkey = ENGINE_load_private_key(e, options->priv_key_file, ui_method, NULL)) == NULL)
+	        msg (M_SSLERR, "Cannot load private key %s from engine", options->priv_key_file);
+
+	      if (!SSL_CTX_use_PrivateKey (ctx, pkey))
+	        msg (M_SSLERR, "Cannot use private key %s in SSL context", options->priv_key_file);
+
+	      /* Check Private Key */
+	      if (!SSL_CTX_check_private_key (ctx))
+		msg (M_SSLERR, "Private key does not match the certificate");
+	    }
 	}
     }
 
diff -Naur openvpn/ssl.h openvpn-ecc/ssl.h
--- openvpn/ssl.h	2008-06-11 18:48:23.000000000 +0200
+++ openvpn-ecc/ssl.h	2008-06-11 19:55:32.000000000 +0200
@@ -28,6 +28,7 @@
 #if defined(USE_CRYPTO) && defined(USE_SSL)
 
 #include <openssl/ssl.h>
+#include <openssl/ui.h>
 #include <openssl/bio.h>
 #include <openssl/rand.h>
 #include <openssl/err.h>


--------------060104000909050806070402--

