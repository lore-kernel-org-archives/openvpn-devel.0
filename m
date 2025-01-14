From: Gert Doering <gert@...1296...>
Date: Tue, 14 Jan 2025 17:49:38 +0100
Message-ID: <20250114164938.12828-1-gert@...1296...>
In-Reply-To: <gerrit.1736858059000.Ifa06a3cb843dbf6a9639164d12aabe572aab162c@...2715...>
References: <gerrit.1736858059000.Ifa06a3cb843dbf6a9639164d12aabe572aab162c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] ssl_openssl: Clean up unused functions
 and add missing "static"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

Just some misc cleanups found while looking at the code.

Change-Id: Ifa06a3cb843dbf6a9639164d12aabe572aab162c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/860
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index a6a9695..e25727f 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -529,12 +529,12 @@
  *
  ***************************************/
 
-/*
+/**
  * Print a one line summary of SSL/TLS session handshake.
  */
 void print_details(struct key_state_ssl *ks_ssl, const char *prefix);
 
-/*
+/**
  * Show the TLS ciphers that are available for us to use in the
  * library depending on the TLS version. This function prints
  * a list of ciphers without headers/footers.
@@ -549,17 +549,11 @@
                                 const char *tls_cert_profile,
                                 bool tls13);
 
-/*
+/**
  * Show the available elliptic curves in the crypto library
  */
 void show_available_curves(void);
 
-/*
- * The OpenSSL library has a notion of preference in TLS ciphers.  Higher
- * preference == more secure. Return the highest preference cipher.
- */
-void get_highest_preference_tls_cipher(char *buf, int size);
-
 /**
  * return a pointer to a static memory area containing the
  * name and version number of the SSL library in use
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 56eef36..92b52fe 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1585,20 +1585,6 @@
     }
 }
 
-void
-get_highest_preference_tls_cipher(char *buf, int size)
-{
-    const char *cipher_name;
-    const int *ciphers = mbedtls_ssl_list_ciphersuites();
-    if (*ciphers == 0)
-    {
-        msg(M_FATAL, "Cannot retrieve list of supported SSL ciphers.");
-    }
-
-    cipher_name = mbedtls_ssl_get_ciphersuite_name(*ciphers);
-    strncpynt(buf, cipher_name, size);
-}
-
 const char *
 get_ssl_library_version(void)
 {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 98eba9d..89d0328 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -354,7 +354,7 @@
     return true;
 }
 
-void
+static void
 convert_tls_list_to_openssl(char *openssl_ciphers, size_t len, const char *ciphers)
 {
     /* Parse supplied cipher list and pass on to OpenSSL */
@@ -461,7 +461,7 @@
     }
 }
 
-void
+static void
 convert_tls13_list_to_openssl(char *openssl_ciphers, size_t len,
                               const char *ciphers)
 {
@@ -2638,31 +2638,6 @@
 #endif /* ifndef OPENSSL_NO_EC */
 }
 
-void
-get_highest_preference_tls_cipher(char *buf, int size)
-{
-    SSL_CTX *ctx;
-    SSL *ssl;
-    const char *cipher_name;
-
-    ctx = SSL_CTX_new(SSLv23_method());
-    if (!ctx)
-    {
-        crypto_msg(M_FATAL, "Cannot create SSL_CTX object");
-    }
-    ssl = SSL_new(ctx);
-    if (!ssl)
-    {
-        crypto_msg(M_FATAL, "Cannot create SSL object");
-    }
-
-    cipher_name = SSL_get_cipher_list(ssl, 0);
-    strncpynt(buf, cipher_name, size);
-
-    SSL_free(ssl);
-    SSL_CTX_free(ctx);
-}
-
 const char *
 get_ssl_library_version(void)
 {

