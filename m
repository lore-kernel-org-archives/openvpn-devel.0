From: Bernhard Schmidt <berni@...376...>
Message-ID: <80e6b449-c536-dc87-7215-3693872bce5a@...376...>
Date: Wed, 4 Oct 2017 16:38:39 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------483169EBD63CDC5D6C20314F"
Content-Language: de-LU
Subject: [Openvpn-devel] [PATCH] openssl 1.1 tls version support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Kurt Roeckx <kurt@...2310...>

This is a multi-part message in MIME format.
--------------483169EBD63CDC5D6C20314F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

in https://bugs.debian.org/873302 Kurt Roeckx (Debian OpenSSL
maintainer) submitted a patch for OpenVPN to properly set  the minimum
and maximum TLS version. On Debian Buster (current development) OpenSSL
1.1 defaults to TLSv1.2+ only.

I'm unwilling to carry crypto specific patches in Debian. Can anyone
make some sense out of this and apply the patch if possible?

Please keep Kurt CCed and direct any questions to him.

Bernhard


--------------483169EBD63CDC5D6C20314F
Content-Type: text/x-patch;
 name="openvpn-version.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="openvpn-version.patch"

--- src/openvpn/ssl_openssl.c.bak	2017-08-26 13:10:40.333428825 +0200
+++ src/openvpn/ssl_openssl.c	2017-08-26 13:12:05.143672978 +0200
@@ -215,6 +215,19 @@
 #endif
 }
 
+/* convert internal version number to openssl version number */
+static int
+openssl_tls_version(int ver)
+{
+    if (ver == TLS_VER_1_0)
+        return TLS1_VERSION;
+    else if (ver == TLS_VER_1_1)
+        return TLS1_1_VERSION;
+    else if (ver == TLS_VER_1_2)
+        return TLS1_2_VERSION;
+    return 0;
+}
+
 void
 tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
@@ -232,6 +245,17 @@
 
         tls_ver_max =
             (ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
+
+#if OPENSSL_VERSION_NUMBER >= 0x10100000
+        if (tls_ver_min <= TLS_VER_UNSPEC)
+        {
+            SSL_CTX_set_min_proto_version(ctx->ctx, openssl_tls_version(tls_ver_min));
+        }
+        if (tls_ver_max <= TLS_VER_UNSPEC)
+        {
+            SSL_CTX_set_max_proto_version(ctx->ctx, openssl_tls_version(tls_ver_max));
+        }
+#else /* OPENSSL_VERSION_NUMBER >= 0x10100000*/
         if (tls_ver_max <= TLS_VER_UNSPEC)
         {
             tls_ver_max = tls_version_max();
@@ -253,6 +277,7 @@
             sslopt |= SSL_OP_NO_TLSv1_2;
         }
 #endif
+#endif /* OPENSSL_VERSION_NUMBER */
 #ifdef SSL_OP_NO_COMPRESSION
         /* Disable compression - flag not available in OpenSSL 0.9.8 */
         sslopt |= SSL_OP_NO_COMPRESSION;


--------------483169EBD63CDC5D6C20314F--

