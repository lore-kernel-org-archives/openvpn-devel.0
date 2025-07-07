From: Gert Doering <gert@...1296...>
Date: Mon,  7 Jul 2025 15:34:39 +0200
Message-ID: <20250707133447.12404-1-gert@...1296...>
In-Reply-To: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
References: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Added PQE to WolfSSL
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

From: rein.vanbaaren <rein.vanbaaren@...1435...>

Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
Signed-off-by: comododragon <rein.vanbaaren@...1435...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1046
This mail reflects revision 6 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/README.wolfssl b/README.wolfssl
index a5dfe31..7475164 100644
--- a/README.wolfssl
+++ b/README.wolfssl
@@ -28,3 +28,33 @@
  * blowfish support (BF-CBC), you must use something like
    cipher AES-128-CBC to avoid trying to use BF-CBC
  * Windows CryptoAPI support
+
+*************************************************************************
+To build WolfSSL with post-quantum KEMs built in, the following command is used:
+
+./configure --enable-openvpn --enable-kyber=all --enable-curve25519
+
+WolfSSL supports the following post-quantum KEMs and post-quantum hybrid KEMs which must be specified 
+using the tls-groups option in an OpenVPN config. Unlike OpenSSL, which includes X25519MLKEM768 
+in the default config, WolfSSL requires explicit configuration of tls-groups to include 
+at least one post-quantum KEM.
+
+ML_KEM_512
+ML_KEM_768
+ML_KEM_1024
+
+P256_ML_KEM_512
+X25519_ML_KEM_512
+
+P384_ML_KEM_768
+P256_ML_KEM_768
+X448_ML_KEM_768
+X25519_ML_KEM_768
+
+P384_ML_KEM_1024
+P521_ML_KEM_1024
+
+The naming conventions of algorithms differ between WolfSSL and OpenSSL. An example is that
+OpenSSL omits underscores for their naming notation whereas WolfSSL expects them. Additionally, 
+OpenSSL does not accept the P curve notation and instead uses the equivalent secp notation. 
+A specific example is that WolfSSL expects P384_ML_KEM_1024, while OpenSSL expects secp384r1MLKEM1024.
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 2fc77d8..4c11cd4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -560,7 +560,7 @@
 tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
 {
     ASSERT(ctx);
-#if OPENSSL_VERSION_NUMBER < 0x30000000L
+#if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(ENABLE_CRYPTO_WOLFSSL)
     struct gc_arena gc = gc_new();
     /* This method could be as easy as
      *  SSL_CTX_set1_groups_list(ctx->ctx, groups)

