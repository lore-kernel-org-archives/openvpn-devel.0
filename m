Date: Tue, 10 Jun 2008 08:45:05 +0200 (CEST)
From: Andrzej Chmielowiec <ac181080@...1019...>
Message-ID: <alpine.LNX.1.00.0806100842340.5779@...1019...>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY=------------050308010005010406050305
Content-ID: <alpine.LNX.1.00.0806100842341.5779@...1019...>
Subject: [Openvpn-devel] OpenVPN and ECC support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--------------050308010005010406050305
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <alpine.LNX.1.00.0806100842342.5779@...1019...>

Hi All,

I send two patches to OpenVPN which gives Elliptic Curve support.
New cipher suites (NSA Suit B) are not visible if OpenVPN works with
standard version of OpenSSL. If you want to use them, there is a need
to edit openssl/ssl/ssl_ciph.c. Simply remove options

    ~SSL_kECDH and ~SSL_kECDHE

from cipher_aliases table. And compile OpenVPN with new OpenSSL version.

This patch add two new options (--ecdh and --engkey) and extends one
option (--engine).

Works same as --dh, but with ECDH parameters:
+  "--ecdh file     : File containing Elliptic Curve Diffie Hellman parameters\n"
+  "                  Object Identifier in .pem format (for --tls-server only).\n"
+  "                  Use \"openssl ecparam -out ecdh_oid.pem -name curve\" to\n"
+  "                  generate and \"openssl ecparam -list_curves\" to get\n"
+  "                  avaliable and supported domains.\n"

Use it when key is stored in OpenSSL ENGINE (for example hardware device)
+  "--engkey        : This option must be specified if key file is avaliable only\n"
+  "                  by OpenSSL engine indicated by --engine option.\n"

Extends engine option to send some options to the engine during its setup.
I think it should be better repleace by two options - --engine with previous
statement and --engctrl [cmd:val]. Unfortunately I don't have too much time to
work on this option.
+  "--engine [name[:cmd:val]..[:cmd:val]] : Enable OpenSSL hardware crypto \n"
+  "                  engine functionality. You can also pass control commands\n"
+  "                  and its values to the engine (use ':' char to separate\n"
+  "                  them).\n"

Best Regards,
Andrzej Chmielowiec,
CMM Sigma (http://www.cmmsigma.eu)


--------------050308010005010406050305
Content-Type: TEXT/X-DIFF; NAME=openvpn-2.0.9-ecc.patch
Content-Disposition: INLINE; FILENAME=openvpn-2.0.9-ecc.patch
Content-ID: <alpine.LNX.1.00.0806100842343.5779@...1019...>

diff -Naur openvpn-2.0.9/crypto.c openvpn-2.0.9-ecc/crypto.c
--- openvpn-2.0.9/crypto.c	2005-11-01 12:06:11.000000000 +0100
+++ openvpn-2.0.9-ecc/crypto.c	2008-06-09 12:17:54.000000000 +0200
@@ -1542,12 +1542,28 @@
 }
 
 static ENGINE *
-setup_engine (const char *engine)
+setup_engine (char *engine)
 {
+  char *engine_ctrl[128];
+  char *engine_ptr = engine;
   ENGINE *e = NULL;
+  
+  int n = 0;
+  int i;
 
   ENGINE_load_builtin_engines ();
 
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
@@ -1562,6 +1578,22 @@
 	  msg (M_FATAL, "OpenSSL error: cannot load engine '%s'", engine);
 	}
 
+      /* Load engine control commands. */
+      for (i = 0; i < n; i += 2)
+        {
+	  if (!ENGINE_ctrl_cmd_string(e, engine_ctrl[i], engine_ctrl[i + 1], 0))
+	    {
+	       msg (M_FATAL, "OpenSSL error: ENGINE_ctrl_cmd_string failed on engine '%s', "
+	            "command '%s' and value '%s'", engine, engine_ctrl[i], engine_ctrl[i + 1]);
+	    }
+	}
+	
+      /* Clear engine commands and its values. */
+      for (i = 0; i < n; i++)
+        {
+	  memset(engine_ctrl[i], 0, strlen(engine_ctrl[i]));
+	}
+
       if (!ENGINE_set_default (e, ENGINE_METHOD_ALL))
 	{
 	  msg (M_FATAL, "OpenSSL error: ENGINE_set_default failed on engine '%s'",
@@ -1576,7 +1608,7 @@
 #endif
 
 void
-init_crypto_lib_engine (const char *engine_name)
+init_crypto_lib_engine (char *engine_name)
 {
   if (!engine_initialized)
     {
@@ -1597,10 +1629,12 @@
  */
 void init_crypto_lib ()
 {
+  OPENSSL_config (NULL);
 }
 
 void uninit_crypto_lib ()
 {
+  CONF_modules_unload (1);
 #if CRYPTO_ENGINE
   if (engine_initialized)
     {
diff -Naur openvpn-2.0.9/crypto.h openvpn-2.0.9-ecc/crypto.h
--- openvpn-2.0.9/crypto.h	2005-11-01 12:06:11.000000000 +0100
+++ openvpn-2.0.9-ecc/crypto.h	2008-02-23 01:06:40.000000000 +0100
@@ -32,9 +32,10 @@
 #if defined(HAVE_OPENSSL_ENGINE_H) && defined(HAVE_ENGINE_LOAD_BUILTIN_ENGINES) && defined(HAVE_ENGINE_REGISTER_ALL_COMPLETE) && defined(HAVE_ENGINE_CLEANUP)
 #define CRYPTO_ENGINE 1
 #else
-#define CRYPTO_ENGINE 0
+#define CRYPTO_ENGINE 1
 #endif
 
+#include <openssl/conf.h>
 #include <openssl/objects.h>
 #include <openssl/rand.h>
 #include <openssl/evp.h>
@@ -338,7 +339,7 @@
 
 void show_available_engines (void);
 
-void init_crypto_lib_engine (const char *engine_name);
+void init_crypto_lib_engine (char *engine_name);
 
 void init_crypto_lib (void);
 
diff -Naur openvpn-2.0.9/options.c openvpn-2.0.9-ecc/options.c
--- openvpn-2.0.9/options.c	2005-12-13 00:50:43.000000000 +0100
+++ openvpn-2.0.9-ecc/options.c	2008-02-23 01:06:40.000000000 +0100
@@ -373,7 +373,10 @@
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
@@ -397,9 +400,16 @@
   "--dh file       : File containing Diffie Hellman parameters\n"
   "                  in .pem format (for --tls-server only).\n"
   "                  Use \"openssl dhparam -out dh1024.pem 1024\" to generate.\n"
+  "--ecdh file     : File containing Elliptic Curve Diffie Hellman parameters\n"
+  "                  Object Identifier in .pem format (for --tls-server only).\n"
+  "                  Use \"openssl ecparam -out ecdh_oid.pem -name curve\" to\n"
+  "                  generate and \"openssl ecparam -list_curves\" to get\n"
+  "                  avaliable and supported domains.\n"
   "--cert file     : Local certificate in .pem format -- must be signed\n"
   "                  by a Certificate Authority in --ca file.\n"
   "--key file      : Local private key in .pem format.\n"
+  "--engkey        : This option must be specified if key file is avaliable only\n"
+  "                  by OpenSSL engine indicated by --engine option.\n"
   "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
   "                  and root CA certificate.\n"
 #ifdef WIN32
@@ -1106,8 +1116,10 @@
   SHOW_INT (key_method);
   SHOW_STR (ca_file);
   SHOW_STR (dh_file);
+  SHOW_STR (ecdh_file);
   SHOW_STR (cert_file);
   SHOW_STR (priv_key_file);
+  SHOW_BOOL (priv_eng_key);
   SHOW_STR (pkcs12_file);
 #ifdef WIN32
   SHOW_STR (cryptoapi_cert);
@@ -1563,7 +1575,8 @@
 
   if (options->tls_server)
     {
-      notnull (options->dh_file, "DH file (--dh)");
+      if (!options->dh_file && !options->ecdh_file)
+        msg (M_USAGE, "You must define DH or ECDH file (--dh or --ecdh)");
     }
   if (options->tls_server || options->tls_client)
     {
@@ -1572,22 +1585,22 @@
 	{
           notnull (options->ca_file, "CA file (--ca)");
           if (options->cert_file)
-	    msg(M_USAGE, "Parameter --cert cannot be used when --cryptoapicert is also specified.");
+	    msg (M_USAGE, "Parameter --cert cannot be used when --cryptoapicert is also specified.");
           if (options->priv_key_file)
-	    msg(M_USAGE, "Parameter --key cannot be used when --cryptoapicert is also specified.");
+	    msg (M_USAGE, "Parameter --key cannot be used when --cryptoapicert is also specified.");
           if (options->pkcs12_file)
-	    msg(M_USAGE, "Parameter --pkcs12 cannot be used when --cryptoapicert is also specified.");
+	    msg (M_USAGE, "Parameter --pkcs12 cannot be used when --cryptoapicert is also specified.");
 	}
       else
 #endif
       if (options->pkcs12_file)
         {
           if (options->ca_file)
-	    msg(M_USAGE, "Parameter --ca cannot be used when --pkcs12 is also specified.");
+	    msg (M_USAGE, "Parameter --ca cannot be used when --pkcs12 is also specified.");
           if (options->cert_file)
-	    msg(M_USAGE, "Parameter --cert cannot be used when --pkcs12 is also specified.");
+	    msg (M_USAGE, "Parameter --cert cannot be used when --pkcs12 is also specified.");
           if (options->priv_key_file)
-	    msg(M_USAGE, "Parameter --key cannot be used when --pkcs12 is also specified.");
+	    msg (M_USAGE, "Parameter --key cannot be used when --pkcs12 is also specified.");
         }
       else
         {
@@ -1600,13 +1613,13 @@
 #if P2MP
 		  if (!options->auth_user_pass_file)
 #endif
-		    msg (M_USAGE, "No client-side authentication method is specified.  You must use either --cert/--key, --pkcs12, or --auth-user-pass");
+		    msg (M_USAGE, "No client-side authentication method is specified. You must use either --cert/--key, --pkcs12, or --auth-user-pass");
 		}
 	      else if (sum == 2)
 		;
 	      else
 		{
-		  msg (M_USAGE, "If you use one of --cert or --key, you must use them both");
+		  msg (M_USAGE, "If you are using --cert or --key, you must use both");
 		}
 	    }
 	  else
@@ -1629,8 +1642,10 @@
 
       MUST_BE_UNDEF (ca_file);
       MUST_BE_UNDEF (dh_file);
+      MUST_BE_UNDEF (ecdh_file);
       MUST_BE_UNDEF (cert_file);
       MUST_BE_UNDEF (priv_key_file);
+      MUST_BE_UNDEF (priv_eng_key);
       MUST_BE_UNDEF (pkcs12_file);
       MUST_BE_UNDEF (cipher_list);
       MUST_BE_UNDEF (tls_verify);
@@ -4361,6 +4376,12 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->dh_file = p[1];
     }
+  else if (streq (p[0], "ecdh") && p[1])
+    {
+      ++i;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->ecdh_file = p[1];
+    }
   else if (streq (p[0], "cert") && p[1])
     {
       ++i;
@@ -4381,6 +4402,11 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->priv_key_file = p[1];
     }
+  else if (streq (p[0], "engkey"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->priv_eng_key = true;
+    }
   else if (streq (p[0], "pkcs12") && p[1])
     {
       ++i;
diff -Naur openvpn-2.0.9/options.h openvpn-2.0.9-ecc/options.h
--- openvpn-2.0.9/options.h	2005-11-01 12:06:11.000000000 +0100
+++ openvpn-2.0.9-ecc/options.h	2008-02-23 01:06:40.000000000 +0100
@@ -343,7 +343,7 @@
   bool authname_defined;
   const char *authname;
   int keysize;
-  const char *engine;
+  char *engine;
   bool replay;
   bool mute_replay_warnings;
   int replay_window;
@@ -358,8 +358,10 @@
   bool tls_client;
   const char *ca_file;
   const char *dh_file;
+  const char *ecdh_file;
   const char *cert_file;
   const char *priv_key_file;
+  bool priv_eng_key;
   const char *pkcs12_file;
   const char *cipher_list;
   const char *tls_verify;
diff -Naur openvpn-2.0.9/ssl.c openvpn-2.0.9-ecc/ssl.c
--- openvpn-2.0.9/ssl.c	2005-12-13 18:10:01.000000000 +0100
+++ openvpn-2.0.9-ecc/ssl.c	2008-02-23 01:06:40.000000000 +0100
@@ -743,7 +743,12 @@
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
 
@@ -757,18 +762,44 @@
 
       SSL_CTX_set_tmp_rsa_callback (ctx, tmp_rsa_cb);
 
-      /* Get Diffie Hellman Parameters */
-      if (!(bio = BIO_new_file (options->dh_file, "r")))
-	msg (M_SSLERR, "Cannot open %s for DH parameters", options->dh_file);
-      dh = PEM_read_bio_DHparams (bio, NULL, NULL, NULL);
-      BIO_free (bio);
-      if (!dh)
-	msg (M_SSLERR, "Cannot load DH parameters from %s", options->dh_file);
-      if (!SSL_CTX_set_tmp_dh (ctx, dh))
-	msg (M_SSLERR, "SSL_CTX_set_tmp_dh");
-      msg (D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with %d bit key",
-	   8 * DH_size (dh));
-      DH_free (dh);
+      if (!options->dh_file && !options->ecdh_file)
+        msg (M_SSLERR, "There is no file for DH or ECDH parameters");
+      else
+        {
+	  if (options->dh_file)
+	    {
+              /* Get Diffie Hellman Parameters */
+              if (!(bio = BIO_new_file (options->dh_file, "r")))
+                msg (M_SSLERR, "Cannot open %s for DH parameters", options->dh_file);
+              dh = PEM_read_bio_DHparams (bio, NULL, NULL, NULL);
+              BIO_free (bio);
+              if (!dh)
+	        msg (M_SSLERR, "Cannot load DH parameters from %s", options->dh_file);
+              if (!SSL_CTX_set_tmp_dh (ctx, dh))
+	        msg (M_SSLERR, "SSL_CTX_set_tmp_dh");
+              msg (D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with %d bit key",
+	        8 * DH_size (dh));
+              DH_free (dh);
+	    }
+	  if (options->ecdh_file)
+	    {
+              /* Get Elliptic Curve Diffie Hellman Parameters */
+              if (!(bio = BIO_new_file (options->ecdh_file, "r")))
+                msg (M_SSLERR, "Cannot open %s for ECDH parameters", options->ecdh_file);
+              ecdh_group = PEM_read_bio_ECPKParameters (bio, NULL, NULL, NULL);
+              BIO_free (bio);
+              if (!ecdh_group)
+	        msg (M_SSLERR, "Cannot load ECDH parameters from %s", options->ecdh_file);
+	      ecdh = EC_KEY_new();
+	      EC_KEY_set_group(ecdh, ecdh_group);
+              if (!SSL_CTX_set_tmp_ecdh (ctx, ecdh) || !SSL_CTX_set_options(ctx, SSL_OP_SINGLE_ECDH_USE))
+	        msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh");
+              msg (D_TLS_DEBUG_LOW, "Elliptic Curve Diffie-Hellman initialized with %d bit key",
+	        EC_GROUP_get_degree (ecdh_group));
+	      EC_GROUP_free(ecdh_group);
+              EC_KEY_free (ecdh);
+	    }
+	}
     }
   else				/* if client */
     {
@@ -789,7 +820,6 @@
     /* Use PKCS #12 file for key, cert and CA certs */
 
       FILE *fp;
-      EVP_PKEY *pkey;
       X509 *cert;
       STACK_OF(X509) *ca = NULL;
       PKCS12 *p12;
@@ -866,8 +896,8 @@
 		msg (M_SSLERR, "Cannot load certificate file %s", options->cert_file);
 	    }
 
-	  /* Load Private Key */
-	  if (options->priv_key_file)
+	  /* Load Private Key from PEM file */
+	  if (options->priv_key_file && !options->priv_eng_key)
 	    {
 	      if (!SSL_CTX_use_PrivateKey_file (ctx, options->priv_key_file, SSL_FILETYPE_PEM))
 		{
@@ -884,6 +914,24 @@
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
 
       /* Load CA file for verifying peer supplied certificate */
diff -Naur openvpn-2.0.9/ssl.h openvpn-2.0.9-ecc/ssl.h
--- openvpn-2.0.9/ssl.h	2005-12-13 18:10:00.000000000 +0100
+++ openvpn-2.0.9-ecc/ssl.h	2008-02-23 01:06:40.000000000 +0100
@@ -28,6 +28,7 @@
 #if defined(USE_CRYPTO) && defined(USE_SSL)
 
 #include <openssl/ssl.h>
+#include <openssl/ui.h>
 #include <openssl/bio.h>
 #include <openssl/rand.h>
 #include <openssl/err.h>

--------------050308010005010406050305
Content-Type: TEXT/X-DIFF; NAME=openvpn-2.1_rc4-ecc.patch
Content-Disposition: INLINE; FILENAME=openvpn-2.1_rc4-ecc.patch
Content-ID: <alpine.LNX.1.00.0806100842344.5779@...1019...>

diff -Naur openvpn-2.1_rc4/crypto.c openvpn-2.1_rc4-ecc/crypto.c
--- openvpn-2.1_rc4/crypto.c	2007-04-25 23:38:46.000000000 +0200
+++ openvpn-2.1_rc4-ecc/crypto.c	2008-02-23 01:07:15.000000000 +0100
@@ -1577,12 +1577,28 @@
 }
 
 static ENGINE *
-setup_engine (const char *engine)
+setup_engine (char *engine)
 {
+  char *engine_ctrl[128];
+  char *engine_ptr = engine;
   ENGINE *e = NULL;
+  
+  int n = 0;
+  int i;
 
   ENGINE_load_builtin_engines ();
 
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
@@ -1596,6 +1612,22 @@
 	{
 	  msg (M_FATAL, "OpenSSL error: cannot load engine '%s'", engine);
 	}
+      
+      /* Load engine control commands. */
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
 
       if (!ENGINE_set_default (e, ENGINE_METHOD_ALL))
 	{
@@ -1611,7 +1643,7 @@
 #endif
 
 void
-init_crypto_lib_engine (const char *engine_name)
+init_crypto_lib_engine (char *engine_name)
 {
   if (!engine_initialized)
     {
@@ -1632,10 +1664,12 @@
  */
 void init_crypto_lib ()
 {
+  OPENSSL_config (NULL);
 }
 
 void uninit_crypto_lib ()
 {
+  CONF_modules_unload (1);
 #if CRYPTO_ENGINE
   if (engine_initialized)
     {
diff -Naur openvpn-2.1_rc4/crypto.h openvpn-2.1_rc4-ecc/crypto.h
--- openvpn-2.1_rc4/crypto.h	2007-04-25 23:38:46.000000000 +0200
+++ openvpn-2.1_rc4-ecc/crypto.h	2008-02-23 01:07:15.000000000 +0100
@@ -32,7 +32,7 @@
 #if defined(HAVE_OPENSSL_ENGINE_H) && defined(HAVE_ENGINE_LOAD_BUILTIN_ENGINES) && defined(HAVE_ENGINE_REGISTER_ALL_COMPLETE) && defined(HAVE_ENGINE_CLEANUP)
 #define CRYPTO_ENGINE 1
 #else
-#define CRYPTO_ENGINE 0
+#define CRYPTO_ENGINE 1
 #endif
 
 #include <openssl/objects.h>
@@ -340,7 +340,7 @@
 
 void show_available_engines (void);
 
-void init_crypto_lib_engine (const char *engine_name);
+void init_crypto_lib_engine (char *engine_name);
 
 void init_crypto_lib (void);
 
diff -Naur openvpn-2.1_rc4/options.c openvpn-2.1_rc4-ecc/options.c
--- openvpn-2.1_rc4/options.c	2007-04-25 23:38:46.000000000 +0200
+++ openvpn-2.1_rc4-ecc/options.c	2008-02-23 01:07:15.000000000 +0100
@@ -411,7 +411,10 @@
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
@@ -442,9 +445,16 @@
   "--dh file       : File containing Diffie Hellman parameters\n"
   "                  in .pem format (for --tls-server only).\n"
   "                  Use \"openssl dhparam -out dh1024.pem 1024\" to generate.\n"
+  "--ecdh file     : File containing Elliptic Curve Diffie Hellman parameters\n"
+  "                  Object Identifier in .pem format (for --tls-server only).\n"
+  "                  Use \"openssl ecparam -out ecdh_oid.pem -name curve\" to\n"
+  "                  generate and \"openssl ecparam -list_curves\" to get\n"
+  "                  avaliable and supported domains.\n"
   "--cert file     : Local certificate in .pem format -- must be signed\n"
   "                  by a Certificate Authority in --ca file.\n"
   "--key file      : Local private key in .pem format.\n"
+  "--engkey        : This option must be specified if key file is avaliable only\n"
+  "                  by OpenSSL engine indicated by --engine option.\n"
   "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
   "                  and optionally the root CA certificate.\n"
 #ifdef WIN32
@@ -562,7 +572,7 @@
   "                    DISABLE-NBT : Disable Netbios-over-TCP/IP.\n"
   "--dhcp-renew       : Ask Windows to renew the TAP adapter lease on startup.\n"
   "--dhcp-pre-release : Ask Windows to release the previous TAP adapter lease on\n"
-"                       startup.\n"
+  "                     startup.\n"
   "--dhcp-release     : Ask Windows to release the TAP adapter lease on shutdown.\n"
   "--tap-sleep n   : Sleep for n seconds after TAP adapter open before\n"
   "                  attempting to set adapter properties.\n"
@@ -1231,8 +1241,10 @@
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
@@ -1755,7 +1767,8 @@
 
   if (options->tls_server)
     {
-      notnull (options->dh_file, "DH file (--dh)");
+      if (!options->dh_file && !options->ecdh_file)
+        msg (M_USAGE, "You must define DH or ECDH file (--dh or --ecdh)");
     }
   if (options->tls_server || options->tls_client)
     {
@@ -1871,8 +1884,10 @@
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
@@ -4872,6 +4887,17 @@
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
@@ -4901,6 +4927,11 @@
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
diff -Naur openvpn-2.1_rc4/options.h openvpn-2.1_rc4-ecc/options.h
--- openvpn-2.1_rc4/options.h	2007-04-25 23:38:46.000000000 +0200
+++ openvpn-2.1_rc4-ecc/options.h	2008-02-23 01:07:15.000000000 +0100
@@ -375,7 +375,7 @@
   bool authname_defined;
   const char *authname;
   int keysize;
-  const char *engine;
+  char *engine;
   bool replay;
   bool mute_replay_warnings;
   int replay_window;
@@ -391,8 +391,10 @@
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
@@ -404,6 +406,7 @@
   const char *cert_file_inline;
   char *priv_key_file_inline;
   const char *dh_file_inline;
+  const char *ecdh_file_inline;
 #endif
 
   int ns_cert_type; /* set to 0, NS_SSL_SERVER, or NS_SSL_CLIENT */
diff -Naur openvpn-2.1_rc4/ssl.c openvpn-2.1_rc4-ecc/ssl.c
--- openvpn-2.1_rc4/ssl.c	2007-04-25 23:38:46.000000000 +0200
+++ openvpn-2.1_rc4-ecc/ssl.c	2008-02-23 01:07:15.000000000 +0100
@@ -1029,7 +1029,12 @@
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
 
@@ -1043,29 +1048,66 @@
 
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
 
-      dh = PEM_read_bio_DHparams (bio, NULL, NULL, NULL);
-      BIO_free (bio);
-      if (!dh)
-	msg (M_SSLERR, "Cannot load DH parameters from %s", options->dh_file);
-      if (!SSL_CTX_set_tmp_dh (ctx, dh))
-	msg (M_SSLERR, "SSL_CTX_set_tmp_dh");
-      msg (D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with %d bit key",
-	   8 * DH_size (dh));
-      DH_free (dh);
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
+
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
@@ -1190,8 +1232,8 @@
 		}
 	    }
 
-	  /* Load Private Key */
-	  if (options->priv_key_file)
+          /* Load Private Key from PEM file */
+          if (options->priv_key_file && !options->priv_eng_key)
 	    {
 	      int status;
 	      
@@ -1220,6 +1262,24 @@
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
 
diff -Naur openvpn-2.1_rc4/ssl.h openvpn-2.1_rc4-ecc/ssl.h
--- openvpn-2.1_rc4/ssl.h	2007-04-25 23:38:46.000000000 +0200
+++ openvpn-2.1_rc4-ecc/ssl.h	2008-02-23 01:07:15.000000000 +0100
@@ -28,6 +28,7 @@
 #if defined(USE_CRYPTO) && defined(USE_SSL)
 
 #include <openssl/ssl.h>
+#include <openssl/ui.h>
 #include <openssl/bio.h>
 #include <openssl/rand.h>
 #include <openssl/err.h>

--------------050308010005010406050305--

