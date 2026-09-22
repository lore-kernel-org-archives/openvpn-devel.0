Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A7EC982FE
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UjJLGpEFvi4gdiBD0qFmd4Y+CurZLRNFPn/A8ci86Wg=; b=SdqZPXgBr7yElByq0xZJ8uq6to
	Nxm7bXfZvYWdzSnJzPoOy0NIpKiFbb61KSdHQQ419azIIMagvXwaIATRbinm253kpMAkf+8z+sRKc
	H0dvZcV0l3GawHBuxtdDQAEVC4GsEET6PXvLWM7BX/Q/uYxHTndaCgnSj3bQ9/Mcl1t8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91WC-000323-4Q;
	Tue, 22 Sep 2026 14:30:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <drew@linuxkids.com>) id 1x91WA-00031v-Gw
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:30:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=octz7T5lr/Zu8b8f/b46E9fy3nyXMxkGosRd7FG4Osk=; b=X5YPEJw2qbBkaxgiBoy4spDIm/
 /dli5SgExbDo+1T2opOCKYe0oJEP7fRUOPgQ1A6Ogzkwe8KOgyZh9akgno189vWYGmfGxZorljzQf
 jIHX3V1hGh1gQer6Uky5Fi5SyJQtw/Az6VFjIckH7t6BoMXH0Lgm+31RcN9hEtkOnpFU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=octz7T5lr/Zu8b8f/b46E9fy3nyXMxkGosRd7FG4Osk=; b=FGv+65HKlUhAWPdnr8rrZ67h5t
 6Rw7MYLb8osQURZBzwzgHhTSD/KvwaGTWjWg+Yuupak0BR+A2VHEff4HSfH6/ClcHkGmMLUhmvI8u
 nF01+ld0sptS0JLsPtabt6nmpWr+VcrrPGhkb3hw+Xewcp/mSOUtMhvtPFaxghJZpKRY=;
Received: from mail-qk2-f12.google.com ([74.125.230.204])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x91W9-0002cc-FG for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:30:47 +0000
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-52fb76bcb1eso8091941cf.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 07:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxkids-com.20251104.gappssmtp.com; s=20251104; t=1790087439; x=1790692239;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=octz7T5lr/Zu8b8f/b46E9fy3nyXMxkGosRd7FG4Osk=;
 b=n9N4zEngm4A1HZx9+6YctMVAYJGhcKAE40a7KuD4zEN6gWNUE718wrJY5SWU2UJFPq
 ywwHX/cXsrukW36RCgixduifnnimSo8oKUawROPDlG9LvdVoWZqeirItL2amlDumwIlP
 ELGVS7dPW/Z9w6VXnA1gSZjXaxsbhxH9ViTyqwkNVsavANwVwiofRL58u3CVE4YMMgIx
 Y9WD1Rvkez+yxI4PqNxAzNNdEuv9PyzoXdA28ZG4R2TVT685RuAT0DASBSvp5QiH2GqM
 WqbjUUoO4AV9Wnip/mSx6vq7piVDnu30s1PRIE1idP9XP7Er1e1u4ACFY8Y4KtHW8RQW
 F3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790087439; x=1790692239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=octz7T5lr/Zu8b8f/b46E9fy3nyXMxkGosRd7FG4Osk=;
 b=wAgQrm9uUSfzszPAixFkcEjRjKUNmXi3kmZdbiUsnLr/Oaok3G2kdMGmzG/H9pw1dG
 T7Jn87Ail7DJXBS6Kgg8ZP5+V35dcVwPhIDn5b0S+5asY/lxJ9pLEyODuHrnesMVqwH+
 UP3mB3MX6mSXcIW8QRlRutQITClsJQOHMZCDX4E+z2iqC9VUCE0CtXSO0zp598ZUSwfS
 3qFC+ph14lMYX2Ft334RsFTnUJjQu40Gh6mkKANh0phcAnIumPZbT7DneFxYe0BLfGAE
 6WOAspj+kgHsxgvpQm4CdK180dg1jdmHbfkjDVM6Y+oYjYlxLNMkJ3BASGALF9C9hRcB
 KOvA==
X-Gm-Message-State: AFuF++lRACFBhlE868KY41ePdMPOU5iIS2vg2jAKpsZUrkCsU8E8tMA3
 O+wMbLIWT9JQdrMtMCTJNfUw3qXbliv9HGSgOmkvSNSZavcCK/frEG+Y0DPV8f5Wy0e9yrBMCZ/
 8ObkBKHs8
X-Gm-Gg: AYBFou2ELtuUe0XnUM03shyBgTTy7aaGNXlYM3ZlSuyebNfotl3ELVt+p6eIyUwF8XI
 Onr7KQL3zq930OLLO4VG41MlrGkcM5Y3nY4qO6JzAFeDkCSYqGgfNbijhqIUhW9vZQz/b4xZj73
 r9X/oB41j9oa/2aHdyaTejfnK20eHQsYPeDy1UmWEXTUQCzB8MlPQOai49o9kezoz4aPUwfKbG6
 ya1Srm9NLzlzh/Zm1WE4aYPj1xtLorDyb968VzWhUOo40a/iPtV1nZeE2GjU8y3GhkDjP7DFwvs
 iDyFOkcfq+zRFh+ZfPRtsyrFFPRUGGKH5/P3ZaM1VAM8DOQ2scgHSLWfYtNIFDU9s/zdbBp3CKT
 4xs2SvkB+lgJ83n0R998kKathAS7Q4zlx38q5v8uND7Q5PzJ0FBW1WpzxNa9CnqniJ5JyuVb3Bo
 WMAK8bmA46qLGQBPci6ig24iLV56teDtXYJT/HfijqrmnTBnmwpmGD4McjKIp5SFT/KM9inc0uO
 /Iuq6H5xFn9q+E21rHAEQ1SqqkJQTpU9vJh+xLcUNqpjI21vXkg073vK5YwfRgzR3XN4Nxtfw==
X-Received: by 2002:a53:ac9b:0:b0:672:99e0:ebce with SMTP id
 956f58d0204a3-67299e0ee21mr3124476d50.102.1790085924719; 
 Tue, 22 Sep 2026 07:05:24 -0700 (PDT)
Received: from MN-277C755CCA3B.localdomain (71-208-239-209.ftmy.qwest.net.
 [71.208.239.209]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d166300asm230404d50.3.2026.09.22.07.05.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 07:05:23 -0700 (PDT)
From: Drew Blokzyl <drew@linuxkids.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 22 Sep 2026 10:05:19 -0400
Message-ID: <20260922140520.71500-2-drew@linuxkids.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922140520.71500-1-drew@linuxkids.com>
References: <20260922140520.71500-1-drew@linuxkids.com>
MIME-Version: 1.0
X-Headers-End: 1x91W9-0002cc-FG
Subject: [Openvpn-devel] [PATCH 1/2] Drop the OpenSSL errors a failed
 cipher/digest lookup leaves behind
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

cipher_get() looks a cipher up with EVP_CIPHER_fetch() and hands the
result, possibly NULL, to callers that only care whether it exists:
cipher_valid_reason(), cipher_kt_mode_cbc/ofb_cfb/aead(),
cipher_kt_block_size(), cipher_kt_insecure(). A failed fetch is a normal
outcome for them, but under OpenSSL 3 it also pushes an
EVP_R_UNSUPPORTED error ("digital envelope routines::unsupported,
Algorithm (none : 0)") onto the thread's error queue, and nobody pops it.

The common way to get there is not exotic. A server that does not set
--cipher gets the legacy default BF-CBC, which is not in --data-ciphers,
so do_init_crypto_tls() initialises the pre-negotiation key_type with
cipher "none". Every new client instance then runs init_instance() ->
do_init_crypto_tls() -> cipher_kt_mode_ofb_cfb("none"), and the frame
and OCC calculations (calculate_crypto_overhead(), frame_calculate_*())
walk the same key_type, each fetching "none" and failing.
cipher_kt_block_size() adds a second case for AEAD ciphers whose CBC
sibling does not exist (CHACHA20-POLY1305 -> "CHACHA20-CBC").
md_valid() has the same shape for digests.

The stale entry then misleads code that classifies an unrelated failure
with ERR_peek_error(), which returns the OLDEST queued entry. The visible
symptom is backend_tls_ctx_reload_crl() logging "CRL: cannot read CRL
from file" on the first handshake after the CRL file changes although
the CRL loaded fine (GitHub #1103). Traced with gdb on OpenVPN 2.7.0 and
master with OpenSSL 3.5.5: the single entry on the queue at reload entry
is the cipher_kt_mode_ofb_cfb("none") fetch from do_init_crypto_tls()
of that same client instance.

Bracket the probing fetches with ERR_set_mark()/ERR_pop_to_mark() so a
failed lookup leaves the queue as it found it; the return value already
carries the answer these callers want. wolfSSL's compatibility layer has
no error marks, so openssl_compat.h maps them to ERR_clear_error() there.

With this change the error queue is empty at multi_create_instance() and
at backend_tls_ctx_reload_crl() entry for UDP, TCP and CHACHA20-POLY1305
clients, and the spurious warning is gone: three CRL replacements, three
handshakes, zero warnings (unpatched: three of three).

Signed-off-by: Drew Blokzyl <drew@linuxkids.com>
---
 src/openvpn/crypto_openssl.c | 16 +++++++++++++++-
 src/openvpn/openssl_compat.h | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 29c5fa68..575db985 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -569,7 +569,17 @@ cipher_get(const char *ciphername)
     ASSERT(ciphername);
 
     ciphername = translate_cipher_name_from_openvpn(ciphername);
-    return EVP_CIPHER_fetch(NULL, ciphername, NULL);
+
+    /* A failed fetch leaves an EVP "unsupported" error on the thread's
+     * error queue. Callers legitimately probe names OpenSSL does not know
+     * ("none" for the not-yet-negotiated key_type, the CBC sibling of an
+     * AEAD cipher, user supplied names) and only look at the return value,
+     * so drop whatever the fetch raised instead of leaving it for an
+     * unrelated ERR_peek_error() to misinterpret later. */
+    ERR_set_mark();
+    evp_cipher_type *cipher = EVP_CIPHER_fetch(NULL, ciphername, NULL);
+    ERR_pop_to_mark();
+    return cipher;
 }
 
 bool
@@ -692,7 +702,9 @@ cipher_kt_block_size(const char *ciphername)
 
     strcpy(mode_str, "-CBC");
 
+    ERR_set_mark();
     cbc_cipher = EVP_CIPHER_fetch(NULL, translate_cipher_name_from_openvpn(name), NULL);
+    ERR_pop_to_mark();
     if (cbc_cipher)
     {
         block_size = EVP_CIPHER_block_size(cbc_cipher);
@@ -1001,7 +1013,9 @@ md_get(const char *digest)
 bool
 md_valid(const char *digest)
 {
+    ERR_set_mark();
     evp_md_type *md = EVP_MD_fetch(NULL, digest, NULL);
+    ERR_pop_to_mark();
     bool valid = (md != NULL);
     EVP_MD_free(md);
     return valid;
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 098bdd56..3029f7ac 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -47,6 +47,24 @@
 
 /* Define the type of error. This is something that is less
  * intrusive than casts everywhere */
+#if defined(ENABLE_CRYPTO_WOLFSSL)
+/* wolfSSL's OpenSSL compatibility layer has no error queue marks. The
+ * callers use them to drop what a failed lookup raised, so fall back to
+ * clearing the queue. */
+static inline int
+ERR_set_mark(void)
+{
+    return 1;
+}
+
+static inline int
+ERR_pop_to_mark(void)
+{
+    ERR_clear_error();
+    return 1;
+}
+#endif /* defined(ENABLE_CRYPTO_WOLFSSL) */
+
 #if defined(OPENSSL_IS_AWSLC)
 typedef uint32_t openssl_err_t;
 typedef size_t openssl_stack_size_t;
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
