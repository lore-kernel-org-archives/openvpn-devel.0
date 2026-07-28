Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABC2C53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ErM79lkO8eDMlJIMUaxq1m8UvxF44/Rols1lcOmEgLI=; b=CvZ8rr+FIIFU08j+cGwx1qfBw+
	sUylr76fwWoEOdVuZAqL2sHU25GkjQZEAFNgyFJc3Pmg8twOUVjEyvYAMgB4LbA6kFVb6uC7KXcSS
	JC1wpJbqC0R1r9OPzYraGqQVWK+oZOKNvzx0Cd9KwwNu0Lys4ascCqOZAmQV4v8yxD2k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wobRM-0003iF-Fs;
	Tue, 28 Jul 2026 06:37:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wobR1-0003gK-Ma
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 06:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7K2jijvEGDSW5Irw4bw6sRWZ9OofsJFWi/6vADpuku0=; b=SFPnNsYWoW0/GBs7/ZLpgd58EW
 y78ohCuPuhwKGQLyPziGvyLy+iyXsiVWBHT1T5HxpOkkkQt6pD7rBnu2lm1qFR3tsVHVwZprQN0CN
 RQI83uaMCmJXJ0d2R0x+lSnFEYyGfLHx88vTmc6NBLM4P+u38fSv/lCYosW5m6FyaGCw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7K2jijvEGDSW5Irw4bw6sRWZ9OofsJFWi/6vADpuku0=; b=fVjCBv5gD5K7o7DNstlTyuZRG/
 yJgHqiSkNLXxT0UCm3/AEkguCNkX/193dN9EerYIkAnBMR/Wk2Qu2yOxek3H7c6mcns61TKFiTjVk
 fdPyw/ssqXLb1mg9/5nYis7Aaj3li0cfwjGgykYOtx55wU00mgpKOO8/hU449fZzVv/8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wobR1-0001KO-LT for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 06:37:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66S6aqcl010479
 for <openvpn-devel@lists.sourceforge.net>; Tue, 28 Jul 2026 08:36:52 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66S6aqWu010478
 for openvpn-devel@lists.sourceforge.net; Tue, 28 Jul 2026 08:36:52 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 28 Jul 2026 08:36:47 +0200
Message-ID: <20260728063652.10456-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784824991000.Iae76f10fa683369ca3f718dc24fd54560bb74112@gerrit.openvpn.net>
References: <gerrit.1784824991000.Iae76f10fa683369ca3f718dc24fd54560bb74112@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wobR1-0001KO-LT
Subject: [Openvpn-devel] [PATCH v1] Drop support for OpenSSL 1.1.0
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Slight simplification of the code since we can then
assume that TLS 1.3 support is present.

Change-Id: Iae76f10fa683369ca3f718dc24fd54560bb74112
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1821
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1821
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/INSTALL b/INSTALL
index 77656b2c..78390d5 100644
--- a/INSTALL
+++ b/INSTALL
@@ -66,10 +66,10 @@
   (1) TUN and/or TAP driver to allow user-space programs to control
       a virtual point-to-point IP or Ethernet device.
       See TUN/TAP Driver References section below for more info.
-  (2a) OpenSSL library, necessary for encryption, version 1.1.0 or higher
+  (2a) OpenSSL library, necessary for encryption, version 1.1.1 or higher
       required, available from https://www.openssl.org/
       or
-  (2b) mbed TLS library, an alternative for encryption, version 2.0 or higher
+  (2b) mbed TLS library, an alternative for encryption, version 3.2.1 or higher
       required, available from https://tls.mbed.org/
   (3) on Linux, "libnl-gen" is required for kernel netlink support
   (4) on Linux, "libcap-ng" is required for Linux capability handling
diff --git a/configure.ac b/configure.ac
index 188f8fa..1aec805 100644
--- a/configure.ac
+++ b/configure.ac
@@ -776,7 +776,7 @@
 		# if the user did not explicitly specify flags, try to autodetect
 		PKG_CHECK_MODULES(
 			[OPENSSL],
-			[openssl >= 1.1.0],
+			[openssl >= 1.1.1],
 			[have_openssl="yes"],
 			[AC_MSG_WARN([OpenSSL not found by pkg-config ${pkg_config_found}])] # If this fails, we will do another test next
 		)
@@ -799,7 +799,7 @@
 				]],
 				[[
 /*	     Version encoding: MNNFFPPS - see opensslv.h for details */
-#if OPENSSL_VERSION_NUMBER < 0x10100000L
+#if OPENSSL_VERSION_NUMBER < 0x10101000L
 #error OpenSSL too old
 #endif
 				]]
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index b61bcbf..098bdd5 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -26,9 +26,9 @@
  * OpenSSL compatibility stub
  *
  * This file provide compatibility stubs for the OpenSSL libraries
- * prior to version 1.1. This version introduces many changes in the
- * library interface, including the fact that various objects and
- * structures are not fully opaque.
+ * prior to the current major version. Newer versions may introduce changes
+ * in the library interface, including replacing functions or enforcing
+ * various objects and structures as fully opaque.
  */
 
 #ifndef OPENSSL_COMPAT_H_
@@ -62,11 +62,6 @@
 #endif
 
 
-/* Functionality missing in 1.1.0 */
-#if OPENSSL_VERSION_NUMBER < 0x10101000L && !defined(ENABLE_CRYPTO_WOLFSSL)
-#define SSL_CTX_set1_groups SSL_CTX_set1_curves
-#endif
-
 /* Functionality missing in LibreSSL before 3.5 */
 #if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050000fL
 #define EVP_CTRL_AEAD_SET_TAG EVP_CTRL_GCM_SET_TAG
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index ef99b22..32b13db 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -200,42 +200,12 @@
 
 /*
  * Return maximum TLS version supported by local OpenSSL library.
- * Assume that presence of SSL_OP_NO_TLSvX macro indicates that
- * TLSvX is supported.
+ * We only support OpenSSL versions that support TLS 1.3.
  */
 int
 tls_version_max(void)
 {
-#if defined(TLS1_3_VERSION)
-    /* If this is defined we can safely assume TLS 1.3 support */
     return TLS_VER_1_3;
-#elif OPENSSL_VERSION_NUMBER >= 0x10100000L
-    /*
-     * If TLS_VER_1_3 is not defined, we were compiled against a version that
-     * did not support TLS 1.3.
-     *
-     * However, the library we are *linked* against might be OpenSSL 1.1.1
-     * and therefore supports TLS 1.3. This needs to be checked at runtime
-     * since we can be compiled against 1.1.0 and then the library can be
-     * upgraded to 1.1.1.
-     * We only need to check this for OpenSSL versions that can be
-     * upgraded to 1.1.1 without recompile (>= 1.1.0)
-     */
-    if (OpenSSL_version_num() >= 0x1010100fL)
-    {
-        return TLS_VER_1_3;
-    }
-    else
-    {
-        return TLS_VER_1_2;
-    }
-#elif defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
-    return TLS_VER_1_2;
-#elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
-    return TLS_VER_1_1;
-#else /* if defined(TLS1_3_VERSION) */
-    return TLS_VER_1_0;
-#endif
 }
 
 /** Convert internal version number to openssl version number */
@@ -256,22 +226,7 @@
     }
     else if (ver == TLS_VER_1_3)
     {
-        /*
-         * Supporting the library upgraded to TLS1.3 without recompile
-         * is enough to support here with a simple constant that the same
-         * as in the TLS 1.3, so spec it is very unlikely that OpenSSL
-         * will change this constant
-         */
-#ifndef TLS1_3_VERSION
-        /*
-         * We do not want to define TLS_VER_1_3 if not defined
-         * since other parts of the code use the existance of this macro
-         * as proxy for TLS 1.3 support
-         */
-        return 0x0304;
-#else
         return TLS1_3_VERSION;
-#endif
     }
     return 0;
 }
@@ -491,8 +446,8 @@
      */
     if (strlen(ciphers) >= (len - 1))
     {
-        msg(M_FATAL, "Failed to set restricted TLS 1.3 cipher list, too long (>%d).",
-            (int)(len - 1));
+        msg(M_FATAL, "Failed to set restricted TLS 1.3 cipher list, too long (>%zd).",
+            len - 1);
     }
 
     strncpy(openssl_ciphers, ciphers, len);
@@ -511,17 +466,11 @@
 {
     if (ciphers == NULL)
     {
-        /* default cipher list of OpenSSL 1.1.1 is sane, do not set own
+        /* default cipher list of OpenSSL is sane, do not set own
          * default as we do with tls-cipher */
         return;
     }
 
-#if !defined(TLS1_3_VERSION)
-    crypto_msg(M_WARN,
-               "Not compiled with OpenSSL 1.1.1 or higher. "
-               "Ignoring TLS 1.3 only tls-ciphersuites '%s' setting.",
-               ciphers);
-#else
     ASSERT(NULL != ctx);
 
     char openssl_ciphers[4096];
@@ -531,14 +480,12 @@
     {
         crypto_msg(M_FATAL, "Failed to set restricted TLS 1.3 cipher list: %s", openssl_ciphers);
     }
-#endif
 }
 
 void
 tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
 {
-#if OPENSSL_VERSION_NUMBER > 0x10100000L                                            \
-    && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3060000fL) \
+#if (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3060000fL) \
     && !defined(OPENSSL_IS_AWSLC)
     /* OpenSSL does not have certificate profiles, but a complex set of
      * callbacks that we could try to implement to achieve something similar.
@@ -565,7 +512,7 @@
     {
         msg(M_FATAL, "ERROR: Invalid cert profile: %s", profile);
     }
-#else  /* if OPENSSL_VERSION_NUMBER > 0x10100000L */
+#else
     if (profile)
     {
         msg(M_WARN,
@@ -573,7 +520,7 @@
             "support --tls-cert-profile, ignoring user-set profile: '%s'",
             profile);
     }
-#endif /* if OPENSSL_VERSION_NUMBER > 0x10100000L */
+#endif
 }
 
 void
@@ -2597,14 +2544,12 @@
         crypto_msg(M_FATAL, "Cannot create SSL_CTX object");
     }
 
-#if defined(TLS1_3_VERSION)
     if (tls13)
     {
         SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
         tls_ctx_restrict_ciphers_tls13(&tls_ctx, cipher_list);
     }
     else
-#endif
     {
         SSL_CTX_set_max_proto_version(tls_ctx.ctx, TLS1_2_VERSION);
         tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
@@ -2618,7 +2563,7 @@
         crypto_msg(M_FATAL, "Cannot create SSL object");
     }
 
-#if OPENSSL_VERSION_NUMBER < 0x1010000fL || defined(OPENSSL_IS_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL)
+#if defined(OPENSSL_IS_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL)
     STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
 #else
     STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);
@@ -2646,9 +2591,7 @@
             printf("%s\n", pair->iana_name);
         }
     }
-#if (OPENSSL_VERSION_NUMBER >= 0x1010000fL)
     sk_SSL_CIPHER_free(sk);
-#endif
     SSL_free(ssl);
     SSL_CTX_free(tls_ctx.ctx);
 }
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 29365db..99e1aac 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -110,7 +110,7 @@
     assert_string_equal(mutate_ncp_cipher_list("AES-256-GCM:?AES-128-CCM:AES-128-GCM", &gc),
                         aes_ciphers);
 
-    /* For testing that with OpenSSL 1.1.0+ that also accepts ciphers in
+    /* For testing that with OpenSSL that also accepts ciphers in
      * a different spelling the normalised cipher output is the same */
     bool have_chacha_mixed_case = cipher_valid("ChaCha20-Poly1305");
     if (have_chacha_mixed_case)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
