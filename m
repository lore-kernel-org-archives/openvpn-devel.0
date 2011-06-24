From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:54:58 +0200
Message-ID: <1308909312-17824-6-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 14/28] Refactored show_available_* functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

---
 crypto.c         |   85 --------------------------------------
 crypto.h         |    6 ---
 crypto_backend.h |    6 +++
 crypto_openssl.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+), 91 deletions(-)

diff --git a/crypto.c b/crypto.c
index a1986e0..409c298 100644
--- a/crypto.c
+++ b/crypto.c
@@ -1451,91 +1451,6 @@ key_len_err:
   return 0;
 }
 
-void
-show_available_ciphers ()
-{
-  int nid;
-
-
-#ifndef ENABLE_SMALL
-  printf ("The following ciphers and cipher modes are available\n"
-	  "for use with " PACKAGE_NAME ".  Each cipher shown below may be\n"
-	  "used as a parameter to the --cipher option.  The default\n"
-	  "key size is shown as well as whether or not it can be\n"
-          "changed with the --keysize directive.  Using a CBC mode\n"
-	  "is recommended.\n\n");
-#endif
-
-  for (nid = 0; nid < 10000; ++nid)	/* is there a better way to get the size of the nid list? */
-    {
-      const EVP_CIPHER *cipher = EVP_get_cipherbynid (nid);
-      if (cipher && cipher_ok (OBJ_nid2sn (nid)))
-	{
-	  const unsigned int mode = EVP_CIPHER_mode (cipher);
-	  if (mode == EVP_CIPH_CBC_MODE
-#ifdef ALLOW_NON_CBC_CIPHERS
-	      || mode == EVP_CIPH_CFB_MODE || mode == EVP_CIPH_OFB_MODE
-#endif
-	      )
-	    printf ("%s %d bit default key (%s)\n",
-		    OBJ_nid2sn (nid),
-		    EVP_CIPHER_key_length (cipher) * 8,
-		    ((EVP_CIPHER_flags (cipher) & EVP_CIPH_VARIABLE_LENGTH) ?
-		     "variable" : "fixed"));
-	}
-    }
-  printf ("\n");
-}
-
-void
-show_available_digests ()
-{
-  int nid;
-
-#ifndef ENABLE_SMALL
-  printf ("The following message digests are available for use with\n"
-	  PACKAGE_NAME ".  A message digest is used in conjunction with\n"
-	  "the HMAC function, to authenticate received packets.\n"
-	  "You can specify a message digest as parameter to\n"
-	  "the --auth option.\n\n");
-#endif
-
-  for (nid = 0; nid < 10000; ++nid)
-    {
-      const EVP_MD *digest = EVP_get_digestbynid (nid);
-      if (digest)
-	{
-	  printf ("%s %d bit digest size\n",
-		  OBJ_nid2sn (nid), EVP_MD_size (digest) * 8);
-	}
-    }
-  printf ("\n");
-}
-
-void
-show_available_engines ()
-{
-#if CRYPTO_ENGINE
-  ENGINE *e;
-
-  printf ("OpenSSL Crypto Engines\n\n");
-
-  ENGINE_load_builtin_engines ();
-
-  e = ENGINE_get_first ();
-  while (e)
-    {
-      printf ("%s [%s]\n",
-	      ENGINE_get_name (e),
-	      ENGINE_get_id (e));
-      e = ENGINE_get_next (e);
-    }
-  ENGINE_cleanup ();
-#else
-  printf ("Sorry, OpenSSL hardware crypto engine functionality is not available.\n");
-#endif
-}
-
 /*
  * Enable crypto acceleration, if available
  */
diff --git a/crypto.h b/crypto.h
index 069a66f..abb2e4c 100644
--- a/crypto.h
+++ b/crypto.h
@@ -434,12 +434,6 @@ void test_crypto (const struct crypto_options *co, struct frame* f);
 
 const char *md5sum(uint8_t *buf, int len, int n_print_chars, struct gc_arena *gc);
 
-void show_available_ciphers (void);
-
-void show_available_digests (void);
-
-void show_available_engines (void);
-
 void init_crypto_lib_engine (const char *engine_name);
 
 void init_crypto_lib (void);
diff --git a/crypto_backend.h b/crypto_backend.h
index 31935ed..b099f47 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -38,6 +38,12 @@
 
 #include "basic.h"
 
+void show_available_ciphers (void);
+
+void show_available_digests (void);
+
+void show_available_engines (void);
+
 /*
  *
  * Random number functions, used in cases where we want
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 9e547b4..9edcf40 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -51,6 +51,127 @@
 
 /*
  *
+ * Workarounds for incompatibilites between OpenSSL libraries.
+ * Right now we accept OpenSSL libraries from 0.9.5 to 0.9.7.
+ *
+ */
+
+#if SSLEAY_VERSION_NUMBER < 0x00907000L
+
+#endif
+
+#if SSLEAY_VERSION_NUMBER < 0x00906000
+
+static inline bool
+cipher_ok (const char* name)
+{
+  const int i = strlen (name) - 4;
+  if (i >= 0)
+    return !strcmp (name + i, "-CBC");
+  else
+    return false;
+}
+
+#else
+
+static inline bool
+cipher_ok (const char* name)
+{
+  return true;
+}
+
+#endif
+
+#if SSLEAY_VERSION_NUMBER < 0x0090581f
+
+#endif
+
+void
+show_available_ciphers ()
+{
+  int nid;
+
+#ifndef ENABLE_SMALL
+  printf ("The following ciphers and cipher modes are available\n"
+	  "for use with " PACKAGE_NAME ".  Each cipher shown below may be\n"
+	  "used as a parameter to the --cipher option.  The default\n"
+	  "key size is shown as well as whether or not it can be\n"
+          "changed with the --keysize directive.  Using a CBC mode\n"
+	  "is recommended.\n\n");
+#endif
+
+  for (nid = 0; nid < 10000; ++nid)	/* is there a better way to get the size of the nid list? */
+    {
+      const EVP_CIPHER *cipher = EVP_get_cipherbynid (nid);
+      if (cipher && cipher_ok (OBJ_nid2sn (nid)))
+	{
+	  const unsigned int mode = EVP_CIPHER_mode (cipher);
+	  if (mode == EVP_CIPH_CBC_MODE
+#ifdef ALLOW_NON_CBC_CIPHERS
+	      || mode == EVP_CIPH_CFB_MODE || mode == EVP_CIPH_OFB_MODE
+#endif
+	      )
+	    printf ("%s %d bit default key (%s)\n",
+		    OBJ_nid2sn (nid),
+		    EVP_CIPHER_key_length (cipher) * 8,
+		    ((EVP_CIPHER_flags (cipher) & EVP_CIPH_VARIABLE_LENGTH) ?
+		     "variable" : "fixed"));
+	}
+    }
+  printf ("\n");
+}
+
+void
+show_available_digests ()
+{
+  int nid;
+
+#ifndef ENABLE_SMALL
+  printf ("The following message digests are available for use with\n"
+	  PACKAGE_NAME ".  A message digest is used in conjunction with\n"
+	  "the HMAC function, to authenticate received packets.\n"
+	  "You can specify a message digest as parameter to\n"
+	  "the --auth option.\n\n");
+#endif
+
+  for (nid = 0; nid < 10000; ++nid)
+    {
+      const EVP_MD *digest = EVP_get_digestbynid (nid);
+      if (digest)
+	{
+	  printf ("%s %d bit digest size\n",
+		  OBJ_nid2sn (nid), EVP_MD_size (digest) * 8);
+	}
+    }
+  printf ("\n");
+}
+
+void
+show_available_engines ()
+{
+#if CRYPTO_ENGINE /* Only defined for OpenSSL */
+  ENGINE *e;
+
+  printf ("OpenSSL Crypto Engines\n\n");
+
+  ENGINE_load_builtin_engines ();
+
+  e = ENGINE_get_first ();
+  while (e)
+    {
+      printf ("%s [%s]\n",
+	      ENGINE_get_name (e),
+	      ENGINE_get_id (e));
+      e = ENGINE_get_next (e);
+    }
+  ENGINE_cleanup ();
+#else
+  printf ("Sorry, OpenSSL hardware crypto engine functionality is not available.\n");
+#endif
+}
+
+/*
+ *
  * Random number functions, used in cases where we want
  * reasonably strong cryptographic random number generation
  * without depleting our entropy pool.  Used for random
-- 
1.7.4.1


