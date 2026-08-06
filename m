Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F56C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12a5IOEk7sXZ6gZU6ii9l5n3vFwj7iybyK4TUGfZFHw=; b=XlX9P23IJY1aYuB+P17Po45vd1
	RddO1YQ2itSQZB6im3X1yaeEybOK/pxc9Q69HhX49gFBg74yv0nxArq7V5i/iCffHt8M5lUs9DXH2
	gWHtJvXnlb/FPRdWg4hTlAgahQNUfMQMWCYxJHwZR5980fx/tIqlfLF2QTZDooKBv9yw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ws05g-0000ZH-R4;
	Thu, 06 Aug 2026 15:33:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1ws05f-0000ZA-Bv
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:33:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0VgNzOD5oePwB3kUVfT6vEJ/Nd2PSXRPo+Vosu0jfXo=; b=KoioK4sffSGWNyj745IqHsL/t1
 EGXcOQoLp5aNshkVhrrNtGviec1dIJ/f/Tlu+NFGmgrmGS/ZznGJH/hPAEsmvak8wGq9zV8xI/4Ko
 5HLQWN7i/A+l64fMn0TsUl1VGbaBrSVLdxklrtZDCeUSSWoq3c0PwZsd0lMI6x7A6Pn0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0VgNzOD5oePwB3kUVfT6vEJ/Nd2PSXRPo+Vosu0jfXo=; b=fnuxcew4pgjnFbuQFawo+aM/wS
 G/AnuKtZjhkAjoaRRChldFidhAvBuZnuFmpZtAMD+eNJymzy1iuQW1fJA6cl96yRU/wDPWg60FWvh
 L2JJ8TD8NhKwJPUrc64Vk+ccLiv8cqcxXQZYTSJ3xsIYDomPTByiCbVYiQiylJHJZUgM=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ws05d-0007lx-94 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:33:03 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hGB9w4sr0zMlMR;
 Thu, 06 Aug 2026 17:32:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1786030372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VgNzOD5oePwB3kUVfT6vEJ/Nd2PSXRPo+Vosu0jfXo=;
 b=jKMAilhTWhzP1KiA1aBdikMZfdihU8BDz705LC6gRUFEk118f64JNvQBeWv9fA8hSd4CK9
 qjioWNVEmceyxX8IJH26QknAEi56wi3NrH3gZTP2fMotMMAUrY7Ic8V8wXCaw4EE4g4emp
 JSSbgaXFojkdXPtkot+lYM22ME4BlwALF7hHAqCQcBjaodV4fcB6b8ZUALr/85SRGVUuNR
 Irv8tcBupXGxEGtQUxbZfv1ki+sIPEB8gLYGv3oMWHLdUJn4Lw6WrQ+OY0TI+dfO2m/1Q+
 CWPU9Uk6b4Jpzl/cmhuKzvSD3Xo5buc71Viy3Y0wsQ7R1gsn3GIEK9OvaA/WPw==
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  6 Aug 2026 17:32:51 +0200
Message-ID: <20260806153251.66170-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1ws05d-0007lx-94
Subject: [Openvpn-devel] [PATCH v24] Add aws-lc siphash implementation
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

AWS-LC has a siphash implementation that is just a simple function call
that also performs the same/better than the reference implementation that
it looks to be based on. AWS-lc variant seems to have come from boringssl
according to the Google copyright.

The return type of the siphash related function has been also removed as
neither the reference nor the aws-lc implementation can fail. Only the
OpenSSL based implementation needed a return type.

Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1572
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1572
This mail reflects revision 24 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/siphash.h b/src/openvpn/siphash.h
index bddddc3..ade7762 100644
--- a/src/openvpn/siphash.h
+++ b/src/openvpn/siphash.h
@@ -18,26 +18,63 @@
 #ifndef SIPHASH_H
 #define SIPHASH_H
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdint.h>
 #include <stdio.h>
 #include <stdbool.h>
 
+/* We need to include this to check for the OPENSSL_IS_AWSLC macro */
+#ifdef ENABLE_CRYPTO_OPENSSL
+#include <openssl/opensslv.h>
+#endif
+
 /* siphash always uses 128-bit keys */
 #define SIPHASH_KEY_SIZE 16
 
 /**
  * Calculates SIPHASH using the reference implementation
  */
-int
+void
 siphash_reference(const void *in, size_t inlen, const void *k,
                   uint8_t *out, size_t outlen);
 
 
-static inline int
+#if defined(OPENSSL_IS_AWSLC)
+#define USE_CRYPOTOLIB_SIPHASH
+#include <openssl/siphash.h>
+#include <string.h>
+#include "error.h"
+/**
+ *  Computes a SipHash value
+ * @param   in      pointer to input data (read-only)
+ * @param   inlen   input data length in bytes (any size_t value)
+ * @param   k       pointer to the key data (read-only), must be 16 bytes
+ * @param   out     pointer to output data (write-only), outlen bytes must be allocated
+ * @param   outlen  length of the output in bytes, must be 8
+ */
+static inline void
+siphash_cryptolib(const void *in, const size_t inlen,
+                  const void *k, uint8_t *out, const size_t outlen)
+{
+    ASSERT(outlen == sizeof(uint64_t));
+    uint64_t sipout = SIPHASH_24(k, in, inlen);
+
+    memcpy(out, &sipout, sizeof(uint64_t));
+}
+#endif
+
+static inline void
 siphash(const void *in, size_t inlen, const void *k,
         uint8_t *out, size_t outlen)
 {
-    return siphash_reference(in, inlen, k, out, outlen);
+#if defined(USE_CRYPOTOLIB_SIPHASH)
+    siphash_cryptolib(in, inlen, k, out, outlen);
+#else
+    siphash_reference(in, inlen, k, out, outlen);
+#endif
 }
 
-#endif /* ifndef SIPHASH_H */
\ No newline at end of file
+#endif /* ifndef SIPHASH_H */
diff --git a/src/openvpn/siphash_reference.c b/src/openvpn/siphash_reference.c
index ad19a51..5f0adb9 100644
--- a/src/openvpn/siphash_reference.c
+++ b/src/openvpn/siphash_reference.c
@@ -99,7 +99,7 @@
  * out: pointer to output data (write-only), outlen bytes must be allocated
  *  outlen: length of the output in bytes, must be 8 or 16
  */
-int
+void
 siphash_reference(const void *in, const size_t inlen, const void *k, uint8_t *out,
                   const size_t outlen)
 {
@@ -206,7 +206,7 @@
 
     if (outlen == 8)
     {
-        return 0;
+        return;
     }
 
     v1 ^= 0xdd;
@@ -219,6 +219,4 @@
 
     b = v0 ^ v1 ^ v2 ^ v3;
     U64TO8_LE(out + 8, b);
-
-    return 0;
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
