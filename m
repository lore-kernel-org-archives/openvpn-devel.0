Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BD1C5AC67
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S5vEKa21gg0yyGHcNRuxhsLbHw9mNkIR5DhK9cbzzck=; b=YN46K9qNkYICgfiPnRnwhnYh7h
	cRNGkIB8PyAFJI3dCi7N98uPqMZck64gAsaSldA4G+nknv02IEdd7K9M7pd41P8IlZPjIOjN82TgJ
	RxFgZXFWaVKx5oBhkqS9VaFnvbAvIZDugdgcrjqtK0//ueqw/afUUJh29W1reDMTT6Rc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsan6-0003wE-Ed;
	Sat, 08 Aug 2026 06:44:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsan4-0003w6-Ns
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 06:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XsPwhv4mBwyF0PIiQyKClzkHLTFvL+N9Xozlf5HdzJg=; b=JLTi0C1q94VFWI30nWe/eyjFfB
 6rXebzPjMajNvrzpOwqhxj9esDlTCbVcVfEp6f3H74kbd+rzrQk95i8q4cypTXZFiG3iId5wzTaWi
 SdEkmb0nEEXm3HT7HsFNzDsFTn2kXHrnmncNi6+yoeZ7aV71VQNHIS2vOB6bWWLA1SYE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XsPwhv4mBwyF0PIiQyKClzkHLTFvL+N9Xozlf5HdzJg=; b=E
 XTLkw3KzOqK2Oydmsn3jJrcO2mHE1pngSxX58qGdYj/ZQHJTJeSbRJ/JB8oqIg8vxyRM5NYKpesxV
 lzgHnTaI73R6pb0b7vx/lwCc9PA70x1VslDavNlWck197uTKsteoREuDnHn3/1osZg5FDmhrEfU8l
 NhFa2JWOeryQU7qo=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsan5-0000nt-JO for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 06:44:19 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso2548385e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 23:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786171449; x=1786776249; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XsPwhv4mBwyF0PIiQyKClzkHLTFvL+N9Xozlf5HdzJg=;
 b=GuX1lUWNeUdGQ5fjMkQ01ORooQxreg2lJWlB7WyPD00Ry6uuvnQ14o+PsnseI5uKDC
 VE+DSXZm+XpDK/MGuTf50waKiUUMe/BR3gvjebXR81vLDSd/o5wSdQdDedmlWdQNDVDt
 B4JjDUgFvSkKfOqP/C0O5tOHj5b13IEnYEQ5+xEjV2vcg4XigPSGjMdomTsZqB+CdrCi
 9Q5ckByzFhrlKeuKL4Jih5oK0Oxdp0O2KHg4TurHvcJyqicaCZ3nPRdKxaV1UPAWyonj
 WJxadAIH6qT+q9TuADqLEHlHOGOp9TtNsNDM3yn0ZGiWjLK9R6AB2uOxGA71YUL9APCV
 zd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786171449; x=1786776249;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XsPwhv4mBwyF0PIiQyKClzkHLTFvL+N9Xozlf5HdzJg=;
 b=LftPsPtvS7x2SRx3W4Q3lbIhz9FA/Xj2aSw1ycFswBKaoRp25UPLRnSwG+4A8H1mys
 6L8wkJW+rZOunChV9XfDrvyJxv2h4nlZlB1U7ZuW+daO5OsH/TLTmRRIiJYYNhs7Sh6w
 aD0DR/RbrG767rM04o/CP2jwCFRYz0Lqy1Tn2gVSiStgRGsWZJy2bby5LuYkjUJgtuJU
 DsrHvKMp47B2KPCCJsB+SOHLvHigP+CYWD2HC6wuq7LKhUpJbDWsefKHWGn58vWD9cWy
 t9wQ/1y/PCYz4L7rrD75EmITVoGJWosHHxPv1ZEPAmO1LhwcxPpFmswAx0bcOepbievh
 2dcg==
X-Gm-Message-State: AOJu0YzGaltCq1ULENQu+HBee3b/9cMBy7A+qtCgMx4umi3ym4TCVaz7
 2gFAl+DjOJ2BROoIm5ayNJcrdcFY82CvN8JeOSaoJ1to1NDr71k+o96Wb2i8MLHtfC8Z5jCrO9h
 Lt9D6SrKjjS3X+NJCpk3gxS2D+jjy8Dw7QGtg0CpFp0ZXp0K1pDAt/SD0cOCUXNk6XdPk
X-Gm-Gg: AR+sD10AtAv13DvrPv1oq+dJiYGhXtTM0uGQTRgLCLItAhrDnIZ43JAm31jqzmRYp60
 z/ENrTZkROqZCXt0bIGrxwrjtCWHlwoINytg1rGFn8cZcfPoBCqnuQPp2BBzo4tto2mpuC+k1qk
 LnvO0XJ9P7dIxq0MqoYAoJVbaCTmnmTZvj7ZRLdQC53LeDVKj84KUxmLIu/OUG3AhNkTrebz1iG
 /m52rzRb5wHx1P3QOF3hAQSy2lAbPxT9vC3t3kAIqBQYaI+Vi28iLZdkktPLrEq3cCtFNnrPh8k
 7B7istL6USBetTtjrC5qlko0zxQCcXIXubQhpnvH7fXv3kTzLjFaIc9fwuDMArG2Bw9xdYm2hGp
 BFeacfDuPO+F8TyXfPNKRZBmeKNWwrCniZTZoitVFVAobyhyu2v7noASr0jHLWOI7eT9nBlyQ/e
 HQHQt25yc4no+hTROO9mFRNKKduOIxOgiAiE2gMGKOWKAvsZZPMW09ecv9l07TqCBvNY7LTchwV
 pEixNmBxaj+nyj6566z8XPbTnmixT5UdabpD7KaWef34a58149DKZPhTEpEyruzaqG6xuSdK8hs
 6jDBhMl3A+z6MLiiA7Rca+2/aYfFzqxT1kohkNLGs7uJIOMQQCE=
X-Received: by 2002:a05:600c:4f82:b0:495:4cb8:42b9 with SMTP id
 5b1f17b1804b1-4994e7112a3mr324691875e9.4.1786171449064; 
 Fri, 07 Aug 2026 23:44:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c7b2b68sm112114835e9.4.2026.08.07.23.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 23:44:08 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 06:44:04 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 31
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: f129a7807408b1cb2975e47e99f594c587ba4576
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5d427ddbde81b99c3684076369221171ffeeb9bb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsan5-0000nt-JO
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Use OpenSSL's
 SIPHASH implementation to double check our implementation
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8597826722018939715=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8597826722018939715==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rZMT/kBboLw="; charset=UTF-8

--rZMT/kBboLw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#31) to the change originally created b=
y plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail )=


The following approvals got outdated and were removed:
Code-Review+2 by f=
lichtenheld


Change subject: Use OpenSSL's SIPHASH implementation to doubl=
e check our implementation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Use OpenSSL's SIPHASH implementation to double check our impl=
ementation

OpenSSL library is currently slower than the reference implemen=
tation
(about 1=2E5x to 2x depending of the compiler)=2E

The OpenSSL API f=
or using the SIPHASH MAC is different enough from using
normal HMAC or Dige=
st that we already implement that combining them into
one API does not make=
 sense=2E

SIPHASH is only available on OpenSSL 3=2E1 and later=2E We still=
 check for
support on 3=2E0 and later as the whole API to allow using the S=
IPHASH alrady
exists in OpenSSL 3=2E0=2E Some of the later OpenSSL 3=2E0=2E=
x might get support
for it=2E Theoretically, a provider can be loaded in Op=
enSSL 3=2E0 that
implements SIPHASH=2E

With OpenSSL's implementation being=
 slower, we currently only use it to
check that our reference implementatio=
n and the OpenSSL implementation
yield the same result in unit tests

Chang=
e-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Signed-off-by: Arne Schwabe=
 <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31
Message-Id: <202=
60806153230=2E65971-1-frank@lichtenheld=2Ecom>
URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38180=2Ehtml
Signed-of=
f-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M src/o=
penvpn/Makefile=2Eam
M src/openvpn/siphash=2Eh
M src/openvpn/siphash_refere=
nce=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn=
/siphash_openssl=2Ec
A tests/unit_tests/openvpn/siphash_openssl=2Eh
M tests=
/unit_tests/openvpn/test_crypto=2Ec
8 files changed, 305 insertions(+), 8 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/31/31/31

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 74c0=
80e=2E=2E3ff2734 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -5=
72,6 +572,8 @@
     src/openvpn/shaper=2Eh
     src/openvpn/sig=2Ec
     sr=
c/openvpn/sig=2Eh
+    src/openvpn/siphash=2Eh
+    src/openvpn/siphash_ref=
erence=2Ec
     src/openvpn/socket=2Ec
     src/openvpn/socket=2Eh
     src=
/openvpn/socket_util=2Ec
@@ -784,6 +786,7 @@
         )
 
     target_sourc=
es(test_crypto PRIVATE
+        tests/unit_tests/openvpn/siphash_openssl=2E=
c
         src/openvpn/crypto_mbedtls=2Ec
         src/openvpn/crypto_opens=
sl=2Ec
         src/openvpn/crypto_epoch=2Ec
@@ -792,6 +795,7 @@
         s=
rc/openvpn/packet_id=2Ec
         src/openvpn/mtu=2Ec
         src/openvpn/=
mss=2Ec
+        src/openvpn/siphash_reference=2Ec
         )
 
     target=
_sources(test_ssl PRIVATE
diff --git a/src/openvpn/Makefile=2Eam b/src/open=
vpn/Makefile=2Eam
index ff8cc54=2E=2E1f77384 100644
--- a/src/openvpn/Makef=
ile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,6 +128,7 @@
 	session_id=
=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	sig=2Ec sig=2Eh \
+	sipha=
sh_reference=2Ec siphash=2Eh \
 	socket=2Ec socket=2Eh \
 	socket_util=2Ec =
socket_util=2Eh \
 	socks=2Ec socks=2Eh \
diff --git a/src/openvpn/siphash=
=2Eh b/src/openvpn/siphash=2Eh
index ef61110=2E=2Ebddddc3 100644
--- a/src/=
openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -18,12 +18,26 @@
 #ifn=
def SIPHASH_H
 #define SIPHASH_H
 
-#include <inttypes=2Eh>
+#include <stdi=
nt=2Eh>
+#include <stdio=2Eh>
+#include <stdbool=2Eh>
 
 /* siphash always =
uses 128-bit keys */
 #define SIPHASH_KEY_SIZE 16
 
-int siphash(const void=
 *in, size_t inlen, const void *k, uint8_t *out,
-            size_t outlen=
);
+/**
+ * Calculates SIPHASH using the reference implementation
+ */
+int=

+siphash_reference(const void *in, size_t inlen, const void *k,
+         =
         uint8_t *out, size_t outlen);
 
-#endif
+
+static inline int
+siph=
ash(const void *in, size_t inlen, const void *k,
+        uint8_t *out, siz=
e_t outlen)
+{
+    return siphash_reference(in, inlen, k, out, outlen);
+}=

+
+#endif /* ifndef SIPHASH_H */
\ No newline at end of file
diff --git a/=
src/openvpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec
index=
 b21a86e=2E=2Ead19a51 100644
--- a/src/openvpn/siphash_reference=2Ec
+++ b/=
src/openvpn/siphash_reference=2Ec
@@ -100,8 +100,8 @@
  *  outlen: length o=
f the output in bytes, must be 8 or 16
  */
 int
-siphash(const void *in, c=
onst size_t inlen, const void *k, uint8_t *out,
-        const size_t outle=
n)
+siphash_reference(const void *in, const size_t inlen, const void *k, ui=
nt8_t *out,
+                  const size_t outlen)
 {
     const unsigned =
char *ni =3D (const unsigned char *)in;
     const unsigned char *kk =3D (c=
onst unsigned char *)k;
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam=
 b/tests/unit_tests/openvpn/Makefile=2Eam
index 4a76269=2E=2E9174ed0 100644=

--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvp=
n/Makefile=2Eam
@@ -73,6 +73,7 @@
 crypto_testdriver_LDFLAGS =3D @TEST_LDFL=
AGS@
 crypto_testdriver_SOURCES =3D test_crypto=2Ec \
 	mock_msg=2Ec mock_m=
sg=2Eh test_common=2Eh \
+	siphash_openssl=2Ec siphash_openssl=2Eh \
 	$(to=
p_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \=

 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
@@ -84,7 +85,8 @@
 	$(top=
_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/mtu=2Ec \
 =
	$(top_srcdir)/src/openvpn/win32-util=2Ec \
-	$(top_srcdir)/src/openvpn/mss=
=2Ec
+	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/openvpn/siph=
ash_reference=2Ec
 
 dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvp=
n -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
 dhcp_testdrive=
r_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
diff --git a/tests=
/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siphash_=
openssl=2Ec
new file mode 100644
index 0000000=2E=2Ec301f2d
--- /dev/null
+=
++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec
@@ -0,0 +1,144 @@
+/*
+ *=
  OpenVPN -- An application to securely tunnel IP networks
+ *             =
over a single TCP/UDP port, with support for SSL/TLS-based
+ *             =
session authentication and key exchange,
+ *             packet encryption,=
 packet authentication, and
+ *             packet compression=2E
+ *
+ *  =
Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C=
) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *  This program is free soft=
ware; you can redistribute it and/or modify
+ *  it under the terms of the =
GNU General Public License version 2
+ *  as published by the Free Software=
 Foundation=2E
+ *
+ *  This program is distributed in the hope that it wil=
l be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warran=
ty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
=
+ *  GNU General Public License for more details=2E
+ *
+ *  You should hav=
e received a copy of the GNU General Public License along
+ *  with this pr=
ogram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HA=
VE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "siphash=2Eh"
+
+#if=
def ENABLE_CRYPTO_OPENSSL
+#include <openssl/opensslv=2Eh>
+#endif
+
+/* Op=
enSSL siphash is currently 2-3 times slower than the reference
+ * implemen=
tation, so we only use it for unit testing that our implementation
+ * and =
OpenSSL agree */
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUM=
BER >=3D 0x30000000L
+#include <openssl/evp=2Eh>
+#include "crypto_openssl=
=2Eh"
+#include "crypto_backend=2Eh"
+#include "buffer=2Eh"
+
+struct sipha=
sh_context
+{
+    EVP_MAC *mac;
+    EVP_MAC_CTX *ctx;
+    size_t size;
+=
    OSSL_PARAM params[3];
+};
+
+/*
+ *  Computes a SipHash value
+ * in: p=
ointer to input data (read-only)
+ *  inlen: input data length in bytes (an=
y size_t value)
+ * k: pointer to the key data (read-only), must be 16 byte=
s
+ * out: pointer to output data (write-only), outlen bytes must be alloca=
ted
+ *  outlen: length of the output in bytes, must be 8 or 16
+ */
+int
+=
siphash_openssl(void *sip_context, const void *in, const size_t inlen,
+   =
             const void *k, uint8_t *out, const size_t outlen)
+{
+    stru=
ct siphash_context *sip =3D sip_context;
+
+
+    sip->params[1] =3D OSSL_P=
ARAM_construct_octet_string("key", (void *)k,
+                            =
                           SIPHASH_KEY_SIZE);
+    if (!EVP_MAC_init(sip->c=
tx, NULL, 0, sip->params))
+    {
+        crypto_msg(M_FATAL, "EVP_MAC_ini=
t failed");
+    }
+    EVP_MAC_update(sip->ctx, in, inlen);
+
+    size_t =
outl =3D 0;
+    EVP_MAC_final(sip->ctx, out, &outl, outlen);
+    return 0=
;
+}
+
+void *
+siphash_openssl_init(size_t hash_size)
+{
+    struct sipha=
sh_context *sip;
+    ALLOC_OBJ(sip, struct siphash_context);
+
+    sip->m=
ac =3D EVP_MAC_fetch(NULL, "SIPHASH", NULL);
+    if (!sip->mac)
+    {
+  =
      /* Our OpenSSL library does not support SIPHASH */
+        return si=
p;
+    }
+    sip->ctx =3D EVP_MAC_CTX_new(sip->mac);
+
+    /* OpenSSL wi=
ll truly hold a pointer to an int in that parameter */
+    sip->size =3D h=
ash_size;
+    sip->params[0] =3D OSSL_PARAM_construct_size_t("size", &sip-=
>size);
+    /* params[1] will hold the key that changes which each invocat=
ion */
+    sip->params[2] =3D OSSL_PARAM_construct_end();
+    return sip;=

+}
+
+bool
+siphash_openssl_available(void *sip_context)
+{
+    struct si=
phash_context *sip =3D sip_context;
+
+    return (bool)(sip->mac);
+}
+
+v=
oid
+siphash_openssl_uninit(void *sip_context)
+{
+    struct siphash_conte=
xt *sip =3D sip_context;
+    EVP_MAC_CTX_free(sip->ctx);
+    EVP_MAC_free=
(sip->mac);
+    free(sip_context);
+}
+#else
+/* Do avoid a lot more ifdef=
s in the test we put dummy functions here */
+int
+siphash_openssl(void *si=
p_context, const void *in, const size_t inlen,
+                const void =
*k, uint8_t *out, const size_t outlen)
+{
+    return -1;
+}
+
+bool
+sipha=
sh_openssl_available(void *sip_context)
+{
+    return false;
+}
+
+void *
=
+siphash_openssl_init(size_t hash_size)
+{
+    return NULL;
+}
+
+void
+si=
phash_openssl_uninit(void *sip_context)
+{
+}
+
+
+#endif /* if defined(ENA=
BLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D 0x30000000L */
diff --gi=
t a/tests/unit_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn=
/siphash_openssl=2Eh
new file mode 100644
index 0000000=2E=2E0f1d329
--- /d=
ev/null
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh
@@ -0,0 +1,64 @@=

+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *     =
        over a single TCP/UDP port, with support for SSL/TLS-based
+ *     =
        session authentication and key exchange,
+ *             packet enc=
ryption, packet authentication, and
+ *             packet compression=2E
+=
 *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  =
This program is free software; you can redistribute it and/or modify
+ *  i=
t under the terms of the GNU General Public License version 2
+ *  as publi=
shed by the Free Software Foundation=2E
+ *
+ *  This program is distribute=
d in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; withou=
t even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTIC=
ULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+ */
+#ifndef SIPHASH_OPENSSL_H
+#define SIPHASH_OPENSSL_H
+
+#in=
clude <stdint=2Eh>
+#include <stdio=2Eh>
+#include <stdbool=2Eh>
+
+
+/* Pr=
ototypes for an implementation of SIPHASH in a crypto library */
+/**
+ *
+=
 * @param hash_size the size of the output hash size
+ * @return initialise=
d context for siphash
+ */
+void *
+siphash_openssl_init(size_t hash_size);=

+
+
+/**
+ * Calculates SIPHASH using the crypto library function=2E
+ */
=
+int
+siphash_openssl(void *sip_context, const void *in, size_t inlen,
+   =
             const void *k, uint8_t *out, size_t outlen);
+
+/**
+ * Free t=
he siphash context used for the crypto library
+ * @param sip_context
+ */
=
+void
+siphash_openssl_uninit(void *sip_context);
+
+/**
+ * Returns if the=
 crypto library is available (and should be used)
+ *
+ * This returns if t=
here is a crypto library version of Siphash24 is
+ * available and should b=
e used (OpenSSL 3/4 version is quite slow, so
+ * we prefer the reference i=
mplementation)
+ *
+ */
+bool
+siphash_openssl_available(void *sip_context)=
;
+#endif /* ifndef SIPHASH_OPENSSL_H */
\ No newline at end of file
diff -=
-git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/=
test_crypto=2Ec
index cb4eaa2=2E=2E77cf295 100644
--- a/tests/unit_tests/op=
envpn/test_crypto=2Ec
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec
@@ -31=
,12 +31,15 @@
 #include <stdarg=2Eh>
 #include <string=2Eh>
 #include <setj=
mp=2Eh>
+#include <inttypes=2Eh>
 #include <cmocka=2Eh>
 
 #include "crypto=
=2Eh"
 #include "crypto_epoch=2Eh"
 #include "options=2Eh"
 #include "ssl_b=
ackend=2Eh"
+#include "siphash=2Eh"
+#include "siphash_openssl=2Eh"
 
 #inc=
lude "mss=2Eh"
 #include "test_common=2Eh"
@@ -923,6 +926,69 @@
     assert=
_memory_equal(key_parameters=2Ehmac, exp_impl_iv, sizeof(exp_impl_iv));
 }
=
 
+/* Use a define here since some c compilers don't like array initialisat=
ion
+ * with an integer */
+#define UT_SIPHASH_HASH_SIZE 16
+
+static const=
 char *ut_message =3D "Look behind you, a Three-Headed Monkey!";
+static co=
nst uint8_t ut_key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x=
66 };
+const uint8_t expected_hash[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, =
0x95, 0xb2, 0x6d, 0x5c, 0x4e, 0xfa,
+                                      =
                0x20, 0x47, 0x65, 0x7e, 0xdd, 0xcd, 0x62, 0x51 };
+
+static=
 void
+test_siphash(void **state)
+{
+    uint8_t out[UT_SIPHASH_HASH_SIZE]=
 =3D { 0 };
+    siphash_reference(ut_message, strlen(ut_message), ut_key, =
out, UT_SIPHASH_HASH_SIZE);
+    assert_memory_equal(out, expected_hash, UT=
_SIPHASH_HASH_SIZE);
+}
+
+static void
+test_siphash_openssl(void **state)
=
+{
+    void *sipctx =3D siphash_openssl_init(UT_SIPHASH_HASH_SIZE);
+
+   =
 if (!siphash_openssl_available(sipctx))
+    {
+        siphash_openssl_un=
init(sipctx);
+        skip();
+    }
+
+    uint8_t out[UT_SIPHASH_HASH_SI=
ZE] =3D { 0 };
+
+    siphash_openssl(sipctx, ut_message, strlen(ut_message=
), ut_key, out,
+                    UT_SIPHASH_HASH_SIZE);
+    assert_mem=
ory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);
+
+    /* check that c=
alling the function twice is safe */
+    siphash_openssl(sipctx, ut_messag=
e, strlen(ut_message), ut_key, out,
+                    UT_SIPHASH_HASH_SI=
ZE);
+    assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);
+
=
+    /* Test a few random strings and ensure that our implementation behave=
 the
+     * same */
+    for (int i =3D 0; i < 1000; i++)
+    {
+        =
size_t len =3D random() % 1000u;
+        uint8_t buf[1024] =3D { 0 };
+   =
     uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+
+        assert_true(rand_b=
ytes(buf, (int)len));
+        assert_true(rand_bytes(key, sizeof(key)));
+=

+
+        siphash_openssl(sipctx, buf, len, key, out, UT_SIPHASH_HASH_SIZ=
E);
+
+        uint8_t outref[UT_SIPHASH_HASH_SIZE] =3D { 0 };
+        sip=
hash_reference(buf, len, key, outref, UT_SIPHASH_HASH_SIZE);
+
+        ass=
ert_memory_equal(out, outref, UT_SIPHASH_HASH_SIZE);
+    }
+
+    siphash_=
openssl_uninit(sipctx);
+}
+
+
 int
 main(void)
 {
@@ -960,7 +1026,9 @@
   =
      cmocka_unit_test_prestate_setup_teardown(crypto_test_epoch_edge,
    =
                                              crypto_test_epoch_setup,
    =
                                              crypto_test_epoch_teardown, &=
prestate_num13),
-        cmocka_unit_test(epoch_test_derive_data_key)
+   =
     cmocka_unit_test(epoch_test_derive_data_key),
+        cmocka_unit_tes=
t(test_siphash),
+        cmocka_unit_test(test_siphash_openssl)
     };
 
=
     return cmocka_run_group_tests_name("crypto tests", tests, NULL, NULL);=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27caa1a3aab0d=
1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: 31
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--rZMT/kBboLw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #31</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Dema=
il">View Change</a></p><p>The following approvals got outdated and were rem=
oved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">Use OpenSSL&#39;s SIPH=
ASH implementation to double check our implementation<br><br>OpenSSL librar=
y is currently slower than the reference implementation<br>(about 1=2E5x to=
 2x depending of the compiler)=2E<br><br>The OpenSSL API for using the SIPH=
ASH MAC is different enough from using<br>normal HMAC or Digest that we alr=
eady implement that combining them into<br>one API does not make sense=2E<b=
r><br>SIPHASH is only available on OpenSSL 3=2E1 and later=2E We still chec=
k for<br>support on 3=2E0 and later as the whole API to allow using the SIP=
HASH alrady<br>exists in OpenSSL 3=2E0=2E Some of the later OpenSSL 3=2E0=
=2Ex might get support<br>for it=2E Theoretically, a provider can be loaded=
 in OpenSSL 3=2E0 that<br>implements SIPHASH=2E<br><br>With OpenSSL&#39;s i=
mplementation being slower, we currently only use it to<br>check that our r=
eference implementation and the OpenSSL implementation<br>yield the same re=
sult in unit tests<br><br>Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7=
aa0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/31<br>Message-Id: &lt;20260806153230=2E659=
71-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg38180=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>=
M src/openvpn/Makefile=2Eam<br>M src/openvpn/siphash=2Eh<br>M src/openvpn/s=
iphash_reference=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests=
/unit_tests/openvpn/siphash_openssl=2Ec<br>A tests/unit_tests/openvpn/sipha=
sh_openssl=2Eh<br>M tests/unit_tests/openvpn/test_crypto=2Ec<br>8 files cha=
nged, 305 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/31/31</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 74c08=
0e=2E=2E3ff2734 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><sp=
an>+++ b/CMakeLists=2Etxt</span><br><span>@@ -572,6 +572,8 @@</span><br><sp=
an>     src/openvpn/shaper=2Eh</span><br><span>     src/openvpn/sig=2Ec</sp=
an><br><span>     src/openvpn/sig=2Eh</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    src/openvpn/siphash=2Eh</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    src/openvpn/siphash_reference=2Ec</span><br><=
span>     src/openvpn/socket=2Ec</span><br><span>     src/openvpn/socket=2E=
h</span><br><span>     src/openvpn/socket_util=2Ec</span><br><span>@@ -784,=
6 +786,7 @@</span><br><span>         )</span><br><span> </span><br><span>  =
   target_sources(test_crypto PRIVATE</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        tests/unit_tests/openvpn/siphash_openssl=2Ec</spa=
n><br><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><span>       =
  src/openvpn/crypto_openssl=2Ec</span><br><span>         src/openvpn/crypt=
o_epoch=2Ec</span><br><span>@@ -792,6 +795,7 @@</span><br><span>         sr=
c/openvpn/packet_id=2Ec</span><br><span>         src/openvpn/mtu=2Ec</span>=
<br><span>         src/openvpn/mss=2Ec</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        src/openvpn/siphash_reference=2Ec</span><br><spa=
n>         )</span><br><span> </span><br><span>     target_sources(test_ssl=
 PRIVATE</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openv=
pn/Makefile=2Eam</span><br><span>index ff8cc54=2E=2E1f77384 100644</span><b=
r><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/M=
akefile=2Eam</span><br><span>@@ -128,6 +128,7 @@</span><br><span> 	session_=
id=2Ec session_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span><br=
><span> 	sig=2Ec sig=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	siphash_reference=2Ec siphash=2Eh \</span><br><span> 	socket=2Ec so=
cket=2Eh \</span><br><span> 	socket_util=2Ec socket_util=2Eh \</span><br><s=
pan> 	socks=2Ec socks=2Eh \</span><br><span>diff --git a/src/openvpn/siphas=
h=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index ef61110=2E=2Ebddddc3 =
100644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><span>+++ b/=
src/openvpn/siphash=2Eh</span><br><span>@@ -18,12 +18,26 @@</span><br><span=
> #ifndef SIPHASH_H</span><br><span> #define SIPHASH_H</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;inttypes=2E=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;s=
tdint=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &lt;stdbool=2Eh&gt;</span><br><span> </span><br><span> /* siphash=
 always uses 128-bit keys */</span><br><span> #define SIPHASH_KEY_SIZE 16</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int s=
iphash(const void *in, size_t inlen, const void *k, uint8_t *out,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            size_t outlen);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Calculates SIPHASH using the referen=
ce implementation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+siphash_reference(const void *in, =
size_t inlen, const void *k,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                  uint8_t *out, size_t outlen);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static inline int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+siphash(const void *in, size_t inlen, const void *k,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t *out, s=
ize_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return siphash_refer=
ence(in, inlen, k, out, outlen);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef SIPHASH=
_H */</span><br><span>\ No newline at end of file</span><br><span>diff --gi=
t a/src/openvpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec</=
span><br><span>index b21a86e=2E=2Ead19a51 100644</span><br><span>--- a/src/=
openvpn/siphash_reference=2Ec</span><br><span>+++ b/src/openvpn/siphash_ref=
erence=2Ec</span><br><span>@@ -100,8 +100,8 @@</span><br><span>  *  outlen:=
 length of the output in bytes, must be 8 or 16</span><br><span>  */</span>=
<br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-siphash=
(const void *in, const size_t inlen, const void *k, uint8_t *out,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        const size_t outlen)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_reference(cons=
t void *in, const size_t inlen, const void *k, uint8_t *out,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                  const size_t out=
len)</span><br><span> {</span><br><span>     const unsigned char *ni =3D (c=
onst unsigned char *)in;</span><br><span>     const unsigned char *kk =3D (=
const unsigned char *)k;</span><br><span>diff --git a/tests/unit_tests/open=
vpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>=
index 4a76269=2E=2E9174ed0 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>@@ -73,6 +73,7 @@</span><br><span> crypto_testdriver_=
LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> crypto_testdriver_SOURCES =3D t=
est_crypto=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2E=
h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	siphash_openssl=
=2Ec siphash_openssl=2Eh \</span><br><span> 	$(top_srcdir)/src/openvpn/buff=
er=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><span>@@ =
-84,7 +85,8 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</=
span><br><span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/mss=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/mss=2Ec \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openv=
pn/siphash_reference=2Ec</span><br><span> </span><br><span> dhcp_testdriver=
_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_C=
FLAGS@ -DDHCP_UNIT_TEST</span><br><span> dhcp_testdriver_LDFLAGS =3D @TEST_=
LDFLAGS@ -L$(top_srcdir)/src/openvpn</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siphash_open=
ssl=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2Ec301f2d</span><br><span>--- /dev/null</span><br><span>+++ b/tests/uni=
t_tests/openvpn/siphash_openssl=2Ec</span><br><span>@@ -0,0 +1,144 @@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single TCP/UDP port, with support for SSL/TLS-based</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessio=
n authentication and key exchange,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet encryption, packet authentication, and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pack=
et compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;arne@r=
fc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is =
free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifdef ENABLE_CRYPTO_OPENSSL</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;openssl/opensslv=2Eh&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* OpenSSL siphash is currently 2-3 times slower than the reference</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * implementation, so w=
e only use it for unit testing that our implementation</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * and OpenSSL agree */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OPENSSL) &=
amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/evp=2Eh&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto_openss=
l=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;crypto_backend=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+struct siphash_context</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MA=
C *mac;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_=
CTX *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t=
 size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL_PARA=
M params[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Computes a SipHash value</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * in: pointer to input data (read-only)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  inlen: input data length=
 in bytes (any size_t value)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * k: pointer to the key data (read-only), must be 16 bytes</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * out: pointer to output =
data (write-only), outlen bytes must be allocated</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  outlen: length of the output in bytes, mu=
st be 8 or 16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+siphash_openssl(void *sip_context, con=
st void *in, const size_t inlen,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                const void *k, uint8_t *out, const size_t outl=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_context *sip =
=3D sip_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;params[1] =3D OSSL_PARAM_cons=
truct_octet_string(&quot;key&quot;, (void *)k,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                                =
       SIPHASH_KEY_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!EVP_MAC_init(sip-&gt;ctx, NULL, 0, sip-&gt;params))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(M_FATAL, &quot;EVP_MAC=
_init failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_u=
pdate(sip-&gt;ctx, in, inlen);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size=
_t outl =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    E=
VP_MAC_final(sip-&gt;ctx, out, &amp;outl, outlen);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_init(size=
_t hash_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_conte=
xt *sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_O=
BJ(sip, struct siphash_context);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    si=
p-&gt;mac =3D EVP_MAC_fetch(NULL, &quot;SIPHASH&quot;, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!sip-&gt;mac)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* Our OpenSSL library does not suppo=
rt SIPHASH */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;ctx =3D =
EVP_MAC_CTX_new(sip-&gt;mac);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Op=
enSSL will truly hold a pointer to an int in that parameter */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;size =3D hash_size;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sip-&gt;params[0=
] =3D OSSL_PARAM_construct_size_t(&quot;size&quot;, &amp;sip-&gt;size);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* params[1] will h=
old the key that changes which each invocation */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    sip-&gt;params[2] =3D OSSL_PARAM_construc=
t_end();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
sip;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+siphash_openssl_available(void *sip_context)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct siphash_context *sip =3D sip_context;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return (bool)(sip-&gt;mac);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openss=
l_uninit(void *sip_context)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 siphash_context *sip =3D sip_context;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    EVP_MAC_CTX_free(sip-&gt;ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    EVP_MAC_free(sip-&gt;mac);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    free(sip_context);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Do avoid a lot more ifdefs in the test we put dummy func=
tions here */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl(void *=
sip_context, const void *in, const size_t inlen,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                const void *k, uint8_t *out, c=
onst size_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
siphash_openssl_available(void *sip_context)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+siphash_openssl_init(size_t hash_size)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_uninit(v=
oid *sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBE=
R &gt;=3D 0x30000000L */</span><br><span>diff --git a/tests/unit_tests/open=
vpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn/siphash_openssl=2Eh</spa=
n><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E0f1d329=
</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openv=
pn/siphash_openssl=2Eh</span><br><span>@@ -0,0 +1,64 @@</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP netw=
orks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
over a single TCP/UDP port, with support for SSL/TLS-based</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticatio=
n and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet encryption, packet authentication, and</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenV=
PN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms o=
f the GNU General Public License version 2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in th=
e hope that it will be useful,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty =
of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILI=
TY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more deta=
ils=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a=
 copy of the GNU General Public License along</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef SIPHASH_OPENSSL_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define SIPHASH_OPENSSL_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt=
;stdint=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;stdbool=2Eh&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* Prototypes for an imple=
mentation of SIPHASH in a crypto library */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 hash_size the size of the output hash size</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return initialised context for siphash</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+siphash_openssl_init(size_t hash_size);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Calculates SI=
PHASH using the crypto library function=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_o=
penssl(void *sip_context, const void *in, size_t inlen,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                const void *k, uint8_t =
*out, size_t outlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Free the siphash context used =
for the crypto library</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param sip_context</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_uninit(voi=
d *sip_context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Returns if the crypto library is av=
ailable (and should be used)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This =
returns if there is a crypto library version of Siphash24 is</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * available and should be used (O=
penSSL 3/4 version is quite slow, so</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * we prefer the reference implementation)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_=
openssl_available(void *sip_context);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif /* ifndef SIPHASH_OPENSSL_H */</span><br><span>\ N=
o newline at end of file</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><s=
pan>index cb4eaa2=2E=2E77cf295 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_crypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_crypto=2Ec</span><br><span>@@ -31,12 +31,15 @@</span><br><span> #include=
 &lt;stdarg=2Eh&gt;</span><br><span> #include &lt;string=2Eh&gt;</span><br>=
<span> #include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;inttypes=2Eh&gt;</span><br><span> #include &lt;=
cmocka=2Eh&gt;</span><br><span> </span><br><span> #include &quot;crypto=2Eh=
&quot;</span><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><sp=
an> #include &quot;options=2Eh&quot;</span><br><span> #include &quot;ssl_ba=
ckend=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;siphash_openssl=2Eh&quot;</span><br><span> </span><=
br><span> #include &quot;mss=2Eh&quot;</span><br><span> #include &quot;test=
_common=2Eh&quot;</span><br><span>@@ -923,6 +926,69 @@</span><br><span>    =
 assert_memory_equal(key_parameters=2Ehmac, exp_impl_iv, sizeof(exp_impl_iv=
));</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Use a define here since some c compilers don&#39;t =
like array initialisation</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * with an integer */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define UT_SIPHASH_HASH_SIZE 16</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static const char *ut_message =3D &quot;Look behind you, a Three-Headed Mo=
nkey!&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
const uint8_t ut_key[SIPHASH_KEY_SIZE] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, =
0x66 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const uint8_=
t expected_hash[UT_SIPHASH_HASH_SIZE] =3D { 0x3e, 0xea, 0x95, 0xb2, 0x6d, 0=
x5c, 0x4e, 0xfa,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                                   0x20, 0x47, 0x65, 0x7e, =
0xdd, 0xcd, 0x62, 0x51 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_siphash(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint8_t out[UT_SIPHASH_HASH_=
SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 siphash_reference(ut_message, strlen(ut_message), ut_key, out, UT_SIPHASH_=
HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_s=
iphash_openssl(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void =
*sipctx =3D siphash_openssl_init(UT_SIPHASH_HASH_SIZE);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!siphash_openssl_available(sipctx))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        siphash_openssl_uninit(sipctx);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        skip();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint8_t out[UT_SIPHASH_HASH_SIZE] =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    siphash_openssl(sipctx, ut_message, strlen(ut_messa=
ge), ut_key, out,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_memory_equal(out, expected_hash, UT_SIPHASH=
_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check that calling =
the function twice is safe */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    siphash_openssl(sipctx, ut_message, strlen(ut_message), ut_ke=
y, out,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Test a few random strings and=
 ensure that our implementation behave the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * same */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (int i =3D 0; i &lt; 1000; i++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        size_t len =3D random() % 1000u;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t buf[1024] =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8=
_t key[SIPHASH_KEY_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     assert_true(rand_bytes(buf, (int)len));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        assert_true(rand_bytes(key, sizeof(key)));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        siphash_openssl(sipctx, buf, len, key, out, UT_SI=
PHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t outre=
f[UT_SIPHASH_HASH_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        siphash_reference(buf, len, key, outref, UT_SIPHASH_=
HASH_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_memory_equal=
(out, outref, UT_SIPHASH_HASH_SIZE);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_open=
ssl_uninit(sipctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span=
> main(void)</span><br><span> {</span><br><span>@@ -960,7 +1026,9 @@</span>=
<br><span>         cmocka_unit_test_prestate_setup_teardown(crypto_test_epo=
ch_edge,</span><br><span>                                                  =
crypto_test_epoch_setup,</span><br><span>                                  =
                crypto_test_epoch_teardown, &amp;prestate_num13),</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(epoch_=
test_derive_data_key)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(epoch_test_derive_data_key),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_siphash),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test(test_siphash_openssl)</span><br><span>     };</span><br><span> </span=
><br><span>     return cmocka_run_group_tests_name(&quot;crypto tests&quot;=
, tests, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail">change 3=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0=
9aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 31 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 31 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--rZMT/kBboLw=--


--===============8597826722018939715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8597826722018939715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8597826722018939715==--

