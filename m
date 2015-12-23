Message-ID: <567AB995.70204@...1147...>
Date: Wed, 23 Dec 2015 16:11:17 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...>
	<5670890D.7050501@...1147...>
	<CAA1AbxJbKeLqeDgBVLJ4HB22NPv+rbL=nB6bXiTqv+d_BLuRbg@...278...>
In-Reply-To: <CAA1AbxJbKeLqeDgBVLJ4HB22NPv+rbL=nB6bXiTqv+d_BLuRbg@...278...>
Content-Type: multipart/mixed; boundary="------------070608040206030900050707"
Subject: Re: [Openvpn-devel] [PATCH] Warn user if their certificate has
	expired
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070608040206030900050707
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Steffan Karger wrote:
> [...]
> Just use mbedtls ;-)
>
> OpenSSL 1.0.2 has been released almost a year ago, so upcoming distro
> releases will probably contain 1.0.2+ (e.g. Ubuntu 15.10 already has
> it, 16.04 LTS will have it too).  Should not take too long, right?
>
> As you've probably noticed in the other thread, I don't particularly
> like the idea of adding that extra code.  But I won't actively oppose
> such a patch either.
>   

I justed wanted to get back to this one one more time: attached is a 
patch to ssl_openssl.c that works in combination with Steffan's patch to 
check for expired certificates. This new patch-patch works on my CentOS 
6 (openssl 1.0.1e) box :)  This patch was done against the v2.3.9 code 
base and I have no clue how to get it into proper git formatting ;)


happy holidays,

JJK


--------------070608040206030900050707
Content-Type: text/x-patch;
 name="expire-v2.3.9.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="expire-v2.3.9.patch"

--- openvpn-2.3.9/src/openvpn/ssl_openssl.c	2015-12-16 12:39:07.000000000 +0100
+++ openvpn-2.3.9-expirepatch/src/openvpn/ssl_openssl.c	2015-12-23 16:00:44.334665832 +0100
@@ -335,6 +335,41 @@
 }
 
 void
+tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
+{
+  int ret;
+  const X509 *cert;
+#if OPENSSL_VERSION_NUMBER >= 0x10002000L
+  cert = SSL_CTX_get0_certificate(ctx->ctx);
+#else
+/* OpenSSL 1.0.1 and earlier need an SSL object to get at the certificate */
+  SSL *ssl = SSL_new(ctx->ctx);
+  cert = SSL_get_certificate(ssl);
+  SSL_free(ssl);
+#endif
+
+  ret = X509_cmp_time (X509_get_notBefore (cert), NULL);
+  if (ret == 0)
+    {
+      msg (D_TLS_DEBUG_MED, "Failed to read certificate notBefore field.");
+    }
+  if (ret > 0)
+    {
+      msg (M_WARN, "WARNING: Your certificate is not yet valid!");
+    }
+
+  ret = X509_cmp_time (X509_get_notAfter (cert), NULL);
+  if (ret == 0)
+    {
+      msg (D_TLS_DEBUG_MED, "Failed to read certificate notAfter field.");
+    }
+  if (ret < 0)
+    {
+      msg (M_WARN, "WARNING: Your certificate has expired!");
+    }
+}
+
+void
 tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file,
     const char *dh_file_inline
     )

--------------070608040206030900050707--

