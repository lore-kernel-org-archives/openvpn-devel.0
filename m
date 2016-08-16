From: Steffan Karger <steffan@...1856...>
Date: Tue, 16 Aug 2016 16:45:42 +0200
Message-Id: <1471358742-8773-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (master)] Discourage using 64-bit block
	ciphers
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

As discussed with the development team, we should start moving away from
ciphers with a small block size.  For OpenVPN in particular this means
moving away from 64-bit block ciphers, towards 128-bit block ciphers.
This patch makes a start with that by moving ciphers with a block
size < 128 bits to the bottom of the --show-ciphers output, and printing
a warning in the connection phase if such a cipher is used.

While touching this function, improve the output of --show-ciphers by
ordering the output alphabetically, and changing the output format
slightly.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c         |  11 +++--
 src/openvpn/crypto_mbedtls.c |  44 ++++++++++++-----
 src/openvpn/crypto_openssl.c | 111 ++++++++++++++++++++++++++++++++++---------
 tests/t_lpback.sh            |   2 +-
 4 files changed, 131 insertions(+), 37 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d6d0251..6f57841 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -825,9 +825,14 @@ init_key_ctx (struct key_ctx *ctx, struct key *key,
       dmsg (D_SHOW_KEYS, "%s: CIPHER KEY: %s", prefix,
           format_hex (key->cipher, kt->cipher_length, 0, &gc));
       dmsg (D_CRYPTO_DEBUG, "%s: CIPHER block_size=%d iv_size=%d",
-          prefix,
-          cipher_kt_block_size(kt->cipher),
-          cipher_kt_iv_size(kt->cipher));
+          prefix, cipher_kt_block_size(kt->cipher),
+	  cipher_kt_iv_size(kt->cipher));
+      if (cipher_kt_block_size(kt->cipher) < 128/8)
+	{
+	  msg (M_WARN, "WARNING: this cipher's block size is less than 128 bit "
+	      "(%d bit).  Consider using a --cipher with a larger block size.",
+	      cipher_kt_block_size(kt->cipher)*8);
+	}
     }
   if (kt->digest && kt->hmac_length > 0)
     {
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index da1b417..92cba49 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -132,6 +132,25 @@ const cipher_name_pair cipher_name_translation_table[] = {
 const size_t cipher_name_translation_table_count =
     sizeof (cipher_name_translation_table) / sizeof (*cipher_name_translation_table);
 
+static void print_cipher(const cipher_kt_t *info)
+{
+  if (info && (cipher_kt_mode_cbc(info)
+#ifdef HAVE_AEAD_CIPHER_MODES
+      || cipher_kt_mode_aead(info)
+#endif
+  ))
+    {
+      const char *ssl_only = cipher_kt_mode_cbc(info) ?
+	  "" : ", TLS client/server mode only";
+      const char *var_key_size = info->flags & MBEDTLS_CIPHER_VARIABLE_KEY_LEN ?
+	  " by default" : "";
+
+      printf ("%s  (%d bit key%s, %d bit block%s)\n",
+	  cipher_kt_name(info), cipher_kt_key_size(info) * 8, var_key_size,
+	  cipher_kt_block_size(info) * 8, ssl_only);
+    }
+}
+
 void
 show_available_ciphers ()
 {
@@ -147,20 +166,23 @@ show_available_ciphers ()
   while (*ciphers != 0)
     {
       const cipher_kt_t *info = mbedtls_cipher_info_from_type(*ciphers);
-
-      if (info && (cipher_kt_mode_cbc(info)
-#ifdef HAVE_AEAD_CIPHER_MODES
-          || cipher_kt_mode_aead(info)
-#endif
-          ))
+      if (info && cipher_kt_block_size(info) >= 128/8)
 	{
-	  const char *ssl_only = cipher_kt_mode_cbc(info) ?
-	      "" : " (TLS client/server mode)";
-
-	  printf ("%s %d bit default key%s\n",
-	      cipher_kt_name(info), cipher_kt_key_size(info) * 8, ssl_only);
+	  print_cipher(info);
 	}
+      ciphers++;
+    }
 
+  printf ("\nThe following ciphers have a block size of less than 128 bits, \n"
+	  "and are therefore deprecated.  Do not use unless you have to.\n\n");
+  ciphers = mbedtls_cipher_list();
+  while (*ciphers != 0)
+    {
+      const cipher_kt_t *info = mbedtls_cipher_info_from_type(*ciphers);
+      if (info && cipher_kt_block_size(info) < 128/8)
+	{
+	  print_cipher(info);
+	}
       ciphers++;
     }
   printf ("\n");
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 376c8be..ef7aae0 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -249,11 +249,42 @@ const size_t cipher_name_translation_table_count =
     sizeof (cipher_name_translation_table) / sizeof (*cipher_name_translation_table);
 
 
+static int
+cipher_name_cmp(const void *a, const void *b)
+{
+  const EVP_CIPHER * const *cipher_a = a;
+  const EVP_CIPHER * const *cipher_b = b;
+
+  const char *cipher_name_a =
+      translate_cipher_name_to_openvpn(EVP_CIPHER_name(*cipher_a));
+  const char *cipher_name_b =
+      translate_cipher_name_to_openvpn(EVP_CIPHER_name(*cipher_b));
+
+  return strcmp(cipher_name_a, cipher_name_b);
+}
+
+static void
+print_cipher(const EVP_CIPHER *cipher)
+{
+  const char *var_key_size =
+	(EVP_CIPHER_flags (cipher) & EVP_CIPH_VARIABLE_LENGTH) ?
+	     " by default" : "";
+  const char *ssl_only = cipher_kt_mode_cbc(cipher) ?
+	"" : ", TLS client/server mode only";
+
+  printf ("%s  (%d bit key%s, %d bit block%s)\n",
+	translate_cipher_name_to_openvpn (EVP_CIPHER_name (cipher)),
+	EVP_CIPHER_key_length (cipher) * 8, var_key_size,
+	cipher_kt_block_size (cipher) * 8, ssl_only);
+}
+
 void
 show_available_ciphers ()
 {
-  int nid;
-
+  /* If we ever exceed this, we must be more selective */
+  const size_t cipher_list_len = 1000;
+  const EVP_CIPHER *cipher_list[cipher_list_len];
+  size_t num_ciphers = 0;
 #ifndef ENABLE_SMALL
   printf ("The following ciphers and cipher modes are available for use\n"
 	  "with " PACKAGE_NAME ".  Each cipher shown below may be use as a\n"
@@ -263,32 +294,40 @@ show_available_ciphers ()
 	  "In static key mode only CBC mode is allowed.\n\n");
 #endif
 
-  for (nid = 0; nid < 10000; ++nid)	/* is there a better way to get the size of the nid list? */
+  for (int nid = 0; nid < 10000; ++nid)
     {
-      const EVP_CIPHER *cipher = EVP_get_cipherbynid (nid);
-      if (cipher)
-	{
-	  if (cipher_kt_mode_cbc(cipher)
+      const EVP_CIPHER *cipher = EVP_get_cipherbynid(nid);
+      if (cipher && (cipher_kt_mode_cbc(cipher)
 #ifdef ENABLE_OFB_CFB_MODE
 	      || cipher_kt_mode_ofb_cfb(cipher)
 #endif
 #ifdef HAVE_AEAD_CIPHER_MODES
 	      || cipher_kt_mode_aead(cipher)
 #endif
-	      )
-	    {
-	      const char *var_key_size =
-		  (EVP_CIPHER_flags (cipher) & EVP_CIPH_VARIABLE_LENGTH) ?
-		       "variable" : "fixed";
-	      const char *ssl_only = cipher_kt_mode_cbc(cipher) ?
-		  "" : " (TLS client/server mode)";
-
-	      printf ("%s %d bit default key (%s)%s\n",
-		  translate_cipher_name_to_openvpn(OBJ_nid2sn (nid)),
-		  EVP_CIPHER_key_length (cipher) * 8, var_key_size, ssl_only);
-	    }
+          ))
+	{
+	  cipher_list[num_ciphers++] = cipher;
+	}
+      if (num_ciphers == cipher_list_len)
+	{
+	  msg (M_WARN, "WARNING: Too many ciphers, not showing all");
+	  break;
 	}
     }
+
+  qsort (cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cmp);
+
+  for (size_t i = 0; i < num_ciphers; i++) {
+      if (cipher_kt_block_size(cipher_list[i]) >= 128/8)
+	print_cipher(cipher_list[i]);
+  }
+
+  printf ("\nThe following ciphers have a block size of less than 128 bits, \n"
+	  "and are therefore deprecated.  Do not use unless you have to.\n\n");
+  for (size_t i = 0; i < num_ciphers; i++) {
+      if (cipher_kt_block_size(cipher_list[i]) < 128/8)
+	print_cipher(cipher_list[i]);
+  }
   printf ("\n");
 }
 
@@ -494,9 +533,37 @@ cipher_kt_iv_size (const EVP_CIPHER *cipher_kt)
 }
 
 int
-cipher_kt_block_size (const EVP_CIPHER *cipher_kt)
-{
-  return EVP_CIPHER_block_size (cipher_kt);
+cipher_kt_block_size (const EVP_CIPHER *cipher) {
+  /* OpenSSL reports OFB/CFB/GCM cipher block sizes as '1 byte'.  To work
+   * around that, try to replace the mode with 'CBC' and return the block size
+   * reported for that cipher, if possible.  If that doesn't work, just return
+   * the value reported by OpenSSL.
+   */
+  char *name = NULL;
+  char *mode_str = NULL;
+  const char *orig_name = NULL;
+  const EVP_CIPHER *cbc_cipher = NULL;
+
+  int block_size = EVP_CIPHER_block_size(cipher);
+
+  orig_name = cipher_kt_name(cipher);
+  if (!orig_name)
+    goto cleanup;
+
+  name = string_alloc(translate_cipher_name_to_openvpn(orig_name), NULL);
+  mode_str = strrchr (name, '-');
+  if (!mode_str || strlen(mode_str) < 4)
+    goto cleanup;
+
+  strcpy (mode_str, "-CBC");
+
+  cbc_cipher = EVP_get_cipherbyname(translate_cipher_name_from_openvpn(name));
+  if (cbc_cipher)
+    block_size = EVP_CIPHER_block_size(cbc_cipher);
+
+cleanup:
+  free (name);
+  return block_size;
 }
 
 int
diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index d7792cd..2052c62 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -26,7 +26,7 @@ trap "rm -f key.$$ log.$$ ; exit 1" 0 3
 
 # Get list of supported ciphers from openvpn --show-ciphers output
 CIPHERS=$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \
-            sed -e '1,/^$/d' -e s'/ .*//' -e '/^\s*$/d' | sort)
+            sed -e '/The following/,/^$/d' -e s'/ .*//' -e '/^\s*$/d')
 
 # SK, 2014-06-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is
 # broken (see http://rt.openssl.org/Ticket/Display.html?id=2867), so exclude
-- 
2.7.4


