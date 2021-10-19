From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:31:25 +0200
Message-Id: <20211019183127.614175-20-arne@...1227...>
In-Reply-To: <20211019183127.614175-1-arne@...1227...>
References: <20211019183127.614175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 19/21] Add insecure tls-cert-profile
 options
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

The recent deprecation of SHA1 certificates in OpenSSL 3.0 makes it necessary
to reallow them in certain deployments. Currently this works by using the
hack of using tls-cipher "DEFAULT:@SECLEVEL=0". Add insecure as option to
tls-cert-profile to allow setting a seclevel of 0.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/tls-options.rst | 6 ++++++
 src/openvpn/ssl_mbedtls.c        | 3 ++-
 src/openvpn/ssl_openssl.c        | 6 +++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index eaf38395d..ac5756034 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -373,6 +373,9 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
 
   The following profiles are supported:
 
+  :code:`insecure`
+      Identical for mbed TLS to `legacy`
+
   :code:`legacy` (default)
       SHA1 and newer, RSA 2048-bit+, any elliptic curve.
 
@@ -385,6 +388,9 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   This option is only fully supported for mbed TLS builds. OpenSSL builds
   use the following approximation:
 
+  :code:`insecure`
+      sets "security level 0"
+
   :code:`legacy` (default)
       sets "security level 1"
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index e7c45c099..acf4993fd 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -336,7 +336,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 void
 tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
 {
-    if (!profile || 0 == strcmp(profile, "legacy"))
+    if (!profile || 0 == strcmp(profile, "legacy")
+        || 0 == strcmp(profile, "insecure"))
     {
         ctx->cert_profile = openvpn_x509_crt_profile_legacy;
     }
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d93292700..b29765daf 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -532,7 +532,11 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
      * callbacks that we could try to implement to achieve something similar.
      * For now, use OpenSSL's security levels to achieve similar (but not equal)
      * behaviour. */
-    if (!profile || 0 == strcmp(profile, "legacy"))
+    if (!profile || 0 == strcmp(profile, "insecure"))
+    {
+        SSL_CTX_set_security_level(ctx->ctx, 0);
+    }
+    else if (!profile || 0 == strcmp(profile, "legacy"))
     {
         SSL_CTX_set_security_level(ctx->ctx, 1);
     }
-- 
2.33.0


