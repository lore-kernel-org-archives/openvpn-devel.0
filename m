Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B78C56205
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JxPJW2TH+740FX6bKjhzflR1Z2xYDDkXHPx/udIWjKo=; b=NPAPIsJyMIV2o9+4c4QpvQeDoP
	bbQ8jgbMtBZ5E7ett8oX1DMCAGSlqNI+rI0Gr447+IooC/9eAu7KLcuVToI+aU9qGpWGt+41/wnnS
	r2Sp7DNa97k3Q5LywUsFbTesalX2vISzcwt9o6B/qx6cuj5tbtQ4S4o1H+mDOERJFxu4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ws05Q-0000tx-P0;
	Thu, 06 Aug 2026 15:32:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1ws05O-0000to-3e
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:32:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tWORsImqoez+4otC4pF5ie/Bq7Y2Jnhb/US7QZzu+fM=; b=kvlPlwNi+FiSnpK/lpxzrKgmHM
 8KiGe6GjdU+EqnX1R1iPI0FFI4hIGqdVy2feDi7VaI302/E6PZCiS32zlECvR5//r1+acFJAFInGD
 /GR5P5YdKZSrxB/nbPCyEinY9I0XRRSgqTrlFxyO37HdJgYpzoD4rvoiVbj5JtPqJLEs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tWORsImqoez+4otC4pF5ie/Bq7Y2Jnhb/US7QZzu+fM=; b=gqRnIMYHmbxA8DQWDxrdwcSwij
 BLeTV5sDFyh3LqG/1QW8GAtBkzaDwqp1vj1q0iv/7/dZvvxPY782Mny/8ylkiPwnI+3xLav8MuMkH
 N4vsn5moOsK1ONVgSJOX8luNYsyrpdeBubA6yINRFp+lmz2mNbnEFJdtqsHDcNKl8YeE=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ws05M-0003LJ-Fw for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:32:43 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hGB9X3zqvzMlFW;
 Thu, 06 Aug 2026 17:32:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1786030352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tWORsImqoez+4otC4pF5ie/Bq7Y2Jnhb/US7QZzu+fM=;
 b=f4rkQjJIIgkUCn5OuLnTWGUFFHS6u2CpaGwGHLrLzW8gon4KG9VdNYi7kj2eymq1IHqyYM
 DUAZE7lvxbo81/4yC4T0cLi+yASiz4FN28AGpi5z+jIX6zMvSNKxOgQAlRWHLeKfECNOLI
 QINheeS5TRJOR3X68gz5AuSvfUhn02kn68uUV9RMYeDRYSV6B4Nw/K4qrnZGkspeXPmc+d
 9MEjvl8asosbulB/o7tkJgRD4GOtoFZ9n5Klv90IVAEPTM7QZnsGZ3bm5NrqlVNp6B/+dh
 9LlYDLwSITsKJ2nEhk3AKAHTzDcDtN9uqugQEhTXr+SpxbQtyqvNgyQqhqZqoA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  6 Aug 2026 17:32:30 +0200
Message-ID: <20260806153230.65971-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hGB9X3zqvzMlFW
X-Headers-End: 1ws05M-0003LJ-Fw
Subject: [Openvpn-devel] [PATCH v30] Use OpenSSL's SIPHASH implementation to
 double check our implementation
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

OpenSSL library is currently slower than the reference implementation
(about 1.5x to 2x depending of the compiler).

The OpenSSL API for using the SIPHASH MAC is different enough from using
normal HMAC or Digest that we already implement that combining them into
one API does not make sense.

SIPHASH is only available on OpenSSL 3.1 and later. We still check for
support on 3.0 and later as the whole API to allow using the SIPHASH alrady
exists in OpenSSL 3.0. Some of the later OpenSSL 3.0.x might get support
for it. Theoretically, a provider can be loaded in OpenSSL 3.0 that
implements SIPHASH.

With OpenSSL's implementation being slower, we currently only use it to
check that our reference implementation and the OpenSSL implementation
yield the same result in unit tests

Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/31
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/31
This mail reflects revision 30 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7473f15..9e1dde1 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -572,6 +572,8 @@
     src/openvpn/shaper.h
     src/openvpn/sig.c
     src/openvpn/sig.h
+    src/openvpn/siphash.h
+    src/openvpn/siphash_reference.c
     src/openvpn/socket.c
     src/openvpn/socket.h
     src/openvpn/socket_util.c
@@ -784,6 +786,7 @@
         )
 
     target_sources(test_crypto PRIVATE
+        tests/unit_tests/openvpn/siphash_openssl.c
         src/openvpn/crypto_mbedtls.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto_epoch.c
@@ -792,6 +795,7 @@
         src/openvpn/packet_id.c
         src/openvpn/mtu.c
         src/openvpn/mss.c
+        src/openvpn/siphash_reference.c
         )
 
     target_sources(test_ssl PRIVATE
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index ff8cc54..1f77384 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -128,6 +128,7 @@
 	session_id.c session_id.h \
 	shaper.c shaper.h \
 	sig.c sig.h \
+	siphash_reference.c siphash.h \
 	socket.c socket.h \
 	socket_util.c socket_util.h \
 	socks.c socks.h \
diff --git a/src/openvpn/siphash.h b/src/openvpn/siphash.h
index ef61110..bddddc3 100644
--- a/src/openvpn/siphash.h
+++ b/src/openvpn/siphash.h
@@ -18,12 +18,26 @@
 #ifndef SIPHASH_H
 #define SIPHASH_H
 
-#include <inttypes.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdbool.h>
 
 /* siphash always uses 128-bit keys */
 #define SIPHASH_KEY_SIZE 16
 
-int siphash(const void *in, size_t inlen, const void *k, uint8_t *out,
-            size_t outlen);
+/**
+ * Calculates SIPHASH using the reference implementation
+ */
+int
+siphash_reference(const void *in, size_t inlen, const void *k,
+                  uint8_t *out, size_t outlen);
 
-#endif
+
+static inline int
+siphash(const void *in, size_t inlen, const void *k,
+        uint8_t *out, size_t outlen)
+{
+    return siphash_reference(in, inlen, k, out, outlen);
+}
+
+#endif /* ifndef SIPHASH_H */
\ No newline at end of file
diff --git a/src/openvpn/siphash_reference.c b/src/openvpn/siphash_reference.c
index b21a86e..ad19a51 100644
--- a/src/openvpn/siphash_reference.c
+++ b/src/openvpn/siphash_reference.c
@@ -100,8 +100,8 @@
  *  outlen: length of the output in bytes, must be 8 or 16
  */
 int
-siphash(const void *in, const size_t inlen, const void *k, uint8_t *out,
-        const size_t outlen)
+siphash_reference(const void *in, const size_t inlen, const void *k, uint8_t *out,
+                  const size_t outlen)
 {
     const unsigned char *ni = (const unsigned char *)in;
     const unsigned char *kk = (const unsigned char *)k;
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index d861ef9..ae15759 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -73,6 +73,7 @@
 crypto_testdriver_LDFLAGS = @TEST_LDFLAGS@
 crypto_testdriver_SOURCES = test_crypto.c \
 	mock_msg.c mock_msg.h test_common.h \
+	siphash_openssl.c siphash_openssl.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -84,7 +85,8 @@
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/mtu.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
-	$(top_srcdir)/src/openvpn/mss.c
+	$(top_srcdir)/src/openvpn/mss.c \
+	$(top_srcdir)/src/openvpn/siphash_reference.c
 
 dhcp_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
 dhcp_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
diff --git a/tests/unit_tests/openvpn/siphash_openssl.c b/tests/unit_tests/openvpn/siphash_openssl.c
new file mode 100644
index 0000000..c301f2d
--- /dev/null
+++ b/tests/unit_tests/openvpn/siphash_openssl.c
@@ -0,0 +1,144 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *  Copyright (C) 2026 Arne Schwabe <arne@rfc2549.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "siphash.h"
+
+#ifdef ENABLE_CRYPTO_OPENSSL
+#include <openssl/opensslv.h>
+#endif
+
+/* OpenSSL siphash is currently 2-3 times slower than the reference
+ * implementation, so we only use it for unit testing that our implementation
+ * and OpenSSL agree */
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x30000000L
+#include <openssl/evp.h>
+#include "crypto_openssl.h"
+#include "crypto_backend.h"
+#include "buffer.h"
+
+struct siphash_context
+{
+    EVP_MAC *mac;
+    EVP_MAC_CTX *ctx;
+    size_t size;
+    OSSL_PARAM params[3];
+};
+
+/*
+ *  Computes a SipHash value
+ * in: pointer to input data (read-only)
+ *  inlen: input data length in bytes (any size_t value)
+ * k: pointer to the key data (read-only), must be 16 bytes
+ * out: pointer to output data (write-only), outlen bytes must be allocated
+ *  outlen: length of the output in bytes, must be 8 or 16
+ */
+int
+siphash_openssl(void *sip_context, const void *in, const size_t inlen,
+                const void *k, uint8_t *out, const size_t outlen)
+{
+    struct siphash_context *sip = sip_context;
+
+
+    sip->params[1] = OSSL_PARAM_construct_octet_string("key", (void *)k,
+                                                       SIPHASH_KEY_SIZE);
+    if (!EVP_MAC_init(sip->ctx, NULL, 0, sip->params))
+    {
+        crypto_msg(M_FATAL, "EVP_MAC_init failed");
+    }
+    EVP_MAC_update(sip->ctx, in, inlen);
+
+    size_t outl = 0;
+    EVP_MAC_final(sip->ctx, out, &outl, outlen);
+    return 0;
+}
+
+void *
+siphash_openssl_init(size_t hash_size)
+{
+    struct siphash_context *sip;
+    ALLOC_OBJ(sip, struct siphash_context);
+
+    sip->mac = EVP_MAC_fetch(NULL, "SIPHASH", NULL);
+    if (!sip->mac)
+    {
+        /* Our OpenSSL library does not support SIPHASH */
+        return sip;
+    }
+    sip->ctx = EVP_MAC_CTX_new(sip->mac);
+
+    /* OpenSSL will truly hold a pointer to an int in that parameter */
+    sip->size = hash_size;
+    sip->params[0] = OSSL_PARAM_construct_size_t("size", &sip->size);
+    /* params[1] will hold the key that changes which each invocation */
+    sip->params[2] = OSSL_PARAM_construct_end();
+    return sip;
+}
+
+bool
+siphash_openssl_available(void *sip_context)
+{
+    struct siphash_context *sip = sip_context;
+
+    return (bool)(sip->mac);
+}
+
+void
+siphash_openssl_uninit(void *sip_context)
+{
+    struct siphash_context *sip = sip_context;
+    EVP_MAC_CTX_free(sip->ctx);
+    EVP_MAC_free(sip->mac);
+    free(sip_context);
+}
+#else
+/* Do avoid a lot more ifdefs in the test we put dummy functions here */
+int
+siphash_openssl(void *sip_context, const void *in, const size_t inlen,
+                const void *k, uint8_t *out, const size_t outlen)
+{
+    return -1;
+}
+
+bool
+siphash_openssl_available(void *sip_context)
+{
+    return false;
+}
+
+void *
+siphash_openssl_init(size_t hash_size)
+{
+    return NULL;
+}
+
+void
+siphash_openssl_uninit(void *sip_context)
+{
+}
+
+
+#endif /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x30000000L */
diff --git a/tests/unit_tests/openvpn/siphash_openssl.h b/tests/unit_tests/openvpn/siphash_openssl.h
new file mode 100644
index 0000000..0f1d329
--- /dev/null
+++ b/tests/unit_tests/openvpn/siphash_openssl.h
@@ -0,0 +1,64 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+#ifndef SIPHASH_OPENSSL_H
+#define SIPHASH_OPENSSL_H
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdbool.h>
+
+
+/* Prototypes for an implementation of SIPHASH in a crypto library */
+/**
+ *
+ * @param hash_size the size of the output hash size
+ * @return initialised context for siphash
+ */
+void *
+siphash_openssl_init(size_t hash_size);
+
+
+/**
+ * Calculates SIPHASH using the crypto library function.
+ */
+int
+siphash_openssl(void *sip_context, const void *in, size_t inlen,
+                const void *k, uint8_t *out, size_t outlen);
+
+/**
+ * Free the siphash context used for the crypto library
+ * @param sip_context
+ */
+void
+siphash_openssl_uninit(void *sip_context);
+
+/**
+ * Returns if the crypto library is available (and should be used)
+ *
+ * This returns if there is a crypto library version of Siphash24 is
+ * available and should be used (OpenSSL 3/4 version is quite slow, so
+ * we prefer the reference implementation)
+ *
+ */
+bool
+siphash_openssl_available(void *sip_context);
+#endif /* ifndef SIPHASH_OPENSSL_H */
\ No newline at end of file
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index cb4eaa2..77cf295 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -31,12 +31,15 @@
 #include <stdarg.h>
 #include <string.h>
 #include <setjmp.h>
+#include <inttypes.h>
 #include <cmocka.h>
 
 #include "crypto.h"
 #include "crypto_epoch.h"
 #include "options.h"
 #include "ssl_backend.h"
+#include "siphash.h"
+#include "siphash_openssl.h"
 
 #include "mss.h"
 #include "test_common.h"
@@ -923,6 +926,69 @@
     assert_memory_equal(key_parameters.hmac, exp_impl_iv, sizeof(exp_impl_iv));
 }
 
+/* Use a define here since some c compilers don't like array initialisation
+ * with an integer */
+#define UT_SIPHASH_HASH_SIZE 16
+
+static const char *ut_message = "Look behind you, a Three-Headed Monkey!";
+static const uint8_t ut_key[SIPHASH_KEY_SIZE] = { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };
+const uint8_t expected_hash[UT_SIPHASH_HASH_SIZE] = { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+                                                      0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };
+
+static void
+test_siphash(void **state)
+{
+    uint8_t out[UT_SIPHASH_HASH_SIZE] = { 0 };
+    siphash_reference(ut_message, strlen(ut_message), ut_key, out, UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);
+}
+
+static void
+test_siphash_openssl(void **state)
+{
+    void *sipctx = siphash_openssl_init(UT_SIPHASH_HASH_SIZE);
+
+    if (!siphash_openssl_available(sipctx))
+    {
+        siphash_openssl_uninit(sipctx);
+        skip();
+    }
+
+    uint8_t out[UT_SIPHASH_HASH_SIZE] = { 0 };
+
+    siphash_openssl(sipctx, ut_message, strlen(ut_message), ut_key, out,
+                    UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);
+
+    /* check that calling the function twice is safe */
+    siphash_openssl(sipctx, ut_message, strlen(ut_message), ut_key, out,
+                    UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);
+
+    /* Test a few random strings and ensure that our implementation behave the
+     * same */
+    for (int i = 0; i < 1000; i++)
+    {
+        size_t len = random() % 1000u;
+        uint8_t buf[1024] = { 0 };
+        uint8_t key[SIPHASH_KEY_SIZE] = { 0 };
+
+        assert_true(rand_bytes(buf, (int)len));
+        assert_true(rand_bytes(key, sizeof(key)));
+
+
+        siphash_openssl(sipctx, buf, len, key, out, UT_SIPHASH_HASH_SIZE);
+
+        uint8_t outref[UT_SIPHASH_HASH_SIZE] = { 0 };
+        siphash_reference(buf, len, key, outref, UT_SIPHASH_HASH_SIZE);
+
+        assert_memory_equal(out, outref, UT_SIPHASH_HASH_SIZE);
+    }
+
+    siphash_openssl_uninit(sipctx);
+}
+
+
 int
 main(void)
 {
@@ -960,7 +1026,9 @@
         cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_edge,
                                                  crypto_test_epoch_setup,
                                                  crypto_test_epoch_teardown, &prestate_num13),
-        cmocka_unit_test(epoch_test_derive_data_key)
+        cmocka_unit_test(epoch_test_derive_data_key),
+        cmocka_unit_test(test_siphash),
+        cmocka_unit_test(test_siphash_openssl)
     };
 
     return cmocka_run_group_tests_name("crypto tests", tests, NULL, NULL);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
