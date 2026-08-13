Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C00C5CFDB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H4OeRV42Di3pvvV9WVPoQPlrJgaoI2oxWXtfaowOxkk=; b=NFHYPdTy9Mt0s6xmHUmrwqlGR7
	BtYiMP+AbwYkRSj+sHOMMrtoF9qyOb5izcq37QV0fiEWRueo9fOqc7oZlfmGykD7U9X+85N5pwC21
	euAbNdXRbqJdTeWAgFs9CrjNjcbXoJh2pwx0Y5VTkf2R3bHSDngnLFshTdmO74ySMBko=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuaYC-0006Ch-Lj;
	Thu, 13 Aug 2026 18:53:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wuaY7-0006CX-3r
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:53:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Su9HSQ4/mLr8uScFtBgr2OcdfNN+vfdn3rdokM2meNs=; b=FS9QZltJMPyfr6SLaoSBOT7VaP
 XX1JhM6+gj3PUJmZuLNa2UXikbtmP9dnFpyAsdQEqsI4nS/9Mz41Vr7ORRBzrqfR697vYzbzTk3kE
 V0rPnp3RzJfiZvQXeTovjmdCxhw6Dv0ioN1MIr3zmk4ksSuSV+9VHgixTdFU3dzVqPD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Su9HSQ4/mLr8uScFtBgr2OcdfNN+vfdn3rdokM2meNs=; b=exymqtw3ML9rLv+l5i3ME4fc/u
 NhBkyNWycGRpH6+jpZACQ+yYfIeudFxfedy+Knuk9IrS2WWralUjtFnZEYOyO5B7OcGRgUz7hxbVw
 Bmw4V5UOGJkUg25dQ1XtOxBJTCHwRoQy8n7qdYhdimzfnCM67eRVgxv2ZPSClhDFuWw0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuaY5-0000R8-8B for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:53:07 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67DIqwIO007098
 for <openvpn-devel@lists.sourceforge.net>; Thu, 13 Aug 2026 20:52:58 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DIqwns007097
 for openvpn-devel@lists.sourceforge.net; Thu, 13 Aug 2026 20:52:58 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 13 Aug 2026 20:52:51 +0200
Message-ID: <20260813185258.7084-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
References: <gerrit.1782142268000.Iaf1f3475e4f27a920c028cd73b1a2497953583d0@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wuaY5-0000R8-8B
Subject: [Openvpn-devel] [PATCH v6] Do not differentiate TLS server and
 client context initialisation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Arne Schwabe <arne@rfc2549.org>

OpenSSL has the quite curious way of allowing to create contexts
that allow only server or only client. This creates extra
complications when we want to use both server and client SSL
objects and does not seem to have any advantages.

We later explicitly tell OpenSSL to initialise the SSL objects
to be a server or client object in key_state_ssl_init via
SSL_set_accept_state or SSL_set_connect_state. If this is
mismatched we end up getting an error from OpenSSL ("called a
function you should not call") that ends up calling a function
that is not defined in that TLS_method.

Looking into the OpenSSL source (IMPLEMENT_tls_meth_func) the main
difference between the methods is whether they have a proper
accept/connect or have the ssl_undefined_function that triggers the
"called a function you should not call".

Our mbed TLS code basically does not give the TLS context any personality
of client or server until we are in the same area in which the OpenSSL
code calls SSL_set_accept_state/SSL_set_connect_state.

This also modifies the mbedTLS backend to make the decision to use
client or server TLS context personality in key_state_ssl_init.
same as the OpenSSL backend.

Change-Id: Iaf1f3475e4f27a920c028cd73b1a2497953583d0
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1728
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1728
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ccd8264..17808f7 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -525,18 +525,11 @@
     struct tls_root_ctx *new_ctx;
     ALLOC_OBJ_CLEAR(new_ctx, struct tls_root_ctx);
 
-    if (options->tls_server)
-    {
-        tls_ctx_server_new(new_ctx);
+    tls_ctx_new(new_ctx);
 
-        if (options->dh_file)
-        {
-            tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_inline);
-        }
-    }
-    else /* if client */
+    if (options->tls_server && options->dh_file)
     {
-        tls_ctx_client_new(new_ctx);
+        tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_inline);
     }
 
     /* Restrict allowed certificate crypto algorithms */
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 816fb9c..a6d57f2 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -117,18 +117,11 @@
 int tls_version_max(void);
 
 /**
- * Initialise a library-specific TLS context for a server.
+ * Initialise a library-specific TLS context.
  *
  * @param ctx           TLS context to initialise
  */
-void tls_ctx_server_new(struct tls_root_ctx *ctx);
-
-/**
- * Initialises a library-specific TLS context for a client.
- *
- * @param ctx           TLS context to initialise
- */
-void tls_ctx_client_new(struct tls_root_ctx *ctx);
+void tls_ctx_new(struct tls_root_ctx *ctx);
 
 /**
  * Frees the library-specific TLSv1 context
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 07caf08..6d7ac04 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -88,7 +88,7 @@
 }
 
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_new(struct tls_root_ctx *ctx)
 {
     ASSERT(NULL != ctx);
     CLEAR(*ctx);
@@ -99,24 +99,9 @@
 
     ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 
-    ctx->endpoint = MBEDTLS_SSL_IS_SERVER;
     ctx->initialised = true;
 }
 
-void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
-{
-    ASSERT(NULL != ctx);
-    CLEAR(*ctx);
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
-#endif
-    ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
-
-    ctx->endpoint = MBEDTLS_SSL_IS_CLIENT;
-    ctx->initialised = true;
-}
 
 void
 tls_ctx_free(struct tls_root_ctx *ctx)
@@ -1141,7 +1126,8 @@
     /* Initialise SSL config */
     ALLOC_OBJ_CLEAR(ks_ssl->ssl_config, mbedtls_ssl_config);
     mbedtls_ssl_config_init(ks_ssl->ssl_config);
-    mbedtls_ssl_config_defaults(ks_ssl->ssl_config, ssl_ctx->endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,
+    int endpoint = is_server ? MBEDTLS_SSL_IS_SERVER : MBEDTLS_SSL_IS_CLIENT;
+    mbedtls_ssl_config_defaults(ks_ssl->ssl_config, endpoint, MBEDTLS_SSL_TRANSPORT_STREAM,
                                 MBEDTLS_SSL_PRESET_DEFAULT);
 #ifdef MBEDTLS_DEBUG_C
     /* We only want to have mbed TLS generate debug level logging when we would
@@ -1530,7 +1516,7 @@
     struct tls_root_ctx tls_ctx;
     const int *ciphers = mbedtls_ssl_list_ciphersuites();
 
-    tls_ctx_server_new(&tls_ctx);
+    tls_ctx_new(&tls_ctx);
     tls_ctx_set_cert_profile(&tls_ctx, tls_cert_profile);
     tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
 
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 6b678b2..32d4f60 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -114,8 +114,6 @@
 {
     bool initialised; /**< True if the context has been initialised */
 
-    int endpoint;     /**< Whether or not this is a server or a client */
-
 #if MBEDTLS_VERSION_NUMBER < 0x04000000
     mbedtls_dhm_context *dhm_ctx;          /**< Diffie-Helmann-Merkle context */
 #endif
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 32b13db..e4e78e9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -100,37 +100,19 @@
 }
 
 void
-tls_ctx_server_new(struct tls_root_ctx *ctx)
+tls_ctx_new(struct tls_root_ctx *ctx)
 {
     ASSERT(NULL != ctx);
 
-    ctx->ctx = SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_server_method());
+    ctx->ctx = SSL_CTX_new_ex(tls_libctx, NULL, TLS_method());
 
     if (ctx->ctx == NULL)
     {
-        crypto_msg(M_FATAL, "SSL_CTX_new SSLv23_server_method");
+        crypto_msg(M_FATAL, "SSL_CTX_new TLS_method");
     }
     if (ERR_peek_error() != 0)
     {
-        crypto_msg(M_WARN, "Warning: TLS server context initialisation "
-                           "has warnings.");
-    }
-}
-
-void
-tls_ctx_client_new(struct tls_root_ctx *ctx)
-{
-    ASSERT(NULL != ctx);
-
-    ctx->ctx = SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_client_method());
-
-    if (ctx->ctx == NULL)
-    {
-        crypto_msg(M_FATAL, "SSL_CTX_new SSLv23_client_method");
-    }
-    if (ERR_peek_error() != 0)
-    {
-        crypto_msg(M_WARN, "Warning: TLS client context initialisation "
+        crypto_msg(M_WARN, "Warning: TLS context initialisation "
                            "has warnings.");
     }
 }
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index d473d67..54d52a0 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -175,7 +175,7 @@
     struct gc_arena gc = gc_new();
 
     struct tls_root_ctx ctx = { 0 };
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
     tls_ctx_load_cert_file(&ctx, unittest_cert, true);
 
     openvpn_x509_cert_t *cert = NULL;
@@ -208,13 +208,13 @@
     /* test loading of inlined cert and key.
      * loading the key also checks that it matches the loaded certificate
      */
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
     tls_ctx_load_cert_file(&ctx, unittest_cert, true);
     assert_int_equal(tls_ctx_load_priv_file(&ctx, unittest_key, true), 0);
     tls_ctx_free(&ctx);
 
     /* test loading of cert and key from file */
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
     tls_ctx_load_cert_file(&ctx, global_state.certfile, false);
     assert_int_equal(tls_ctx_load_priv_file(&ctx, global_state.keyfile, false), 0);
     tls_ctx_free(&ctx);
@@ -252,7 +252,7 @@
     string_mod(BSTR(&keyuri), CC_ANY, CC_BACKSLASH, '/');
 #endif /* _WIN32 */
 
-    tls_ctx_client_new(&ctx);
+    tls_ctx_new(&ctx);
     tls_ctx_load_cert_file(&ctx, BSTR(&certuri), false);
     assert_int_equal(tls_ctx_load_priv_file(&ctx, BSTR(&keyuri), false), 0);
     tls_ctx_free(&ctx);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
