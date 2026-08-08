Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6845AC5AC67
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iH+U/BPA7xIqB8hm+wvnupWHrn/7phCjZSdwiHJaKpU=; b=Ugsl/0ddRypiwJDvpS9nm6X08R
	NoBex5W0Nhsh5qEz0MwmgK9Lk/KP6jE1uIeSxrFlTLQr/eSzWzmnnRzV2bI2I7RuGcPW1iZ4KNQLP
	GH5gHY22ct+LiN2q+aVHOTkKaHwYtRcS60TfljRJcSgWbl9iAwjDsWxN/ijs25K6CAG4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsb19-0004E7-Ed;
	Sat, 08 Aug 2026 06:58:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsb18-0004Dz-EE
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 06:58:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xGYz+YB5i+bF3qzmqovTIUQDQlvchSkzLMyA7Z9avvo=; b=A1W3J31rdZAQBACcnttOZWDnFE
 gY4vSenKIWwajv1Uhl6XIqG3s3+v3S+dYqnNScfZ1uuSUASXWy3HocKjYnXlsTYCPX5tUYP7jeOVY
 12REnjLj9wLLqum2OeEJMGce7vlRkcsx/aLBubuZdPeKJtNCaEvTDVpkDdEiNNLwf0bs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xGYz+YB5i+bF3qzmqovTIUQDQlvchSkzLMyA7Z9avvo=; b=l
 hwO0fHz1GPqLRQao/WWDR9pSWY7XgKhCOpPUqaZX8AAJJO1nqMPKKzfnUhXgYAk0tS8iZBb55Wzo7
 d0pJaCUpuUmHBdLpR+isCk0iMjVAQNGNUtpluO9tBRvtxRaFELoqH3I3xl807C/ldVAIC3ayMTdFk
 wwa1MggYD0g4yS24=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsb1B-0002Da-4f for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 06:58:51 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso2559655e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786172323; x=1786777123; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xGYz+YB5i+bF3qzmqovTIUQDQlvchSkzLMyA7Z9avvo=;
 b=c8MmA7PmxlSVQYFtguM8alzWL1MpDAgpZKxd9ewUelCkZt6jnR9EySjoLNOvVZnhSC
 Cnu8uG8Og1ThqGRIJ5dpjOmpfaMdgU+mteaB6vOZsiOXBiJAiKMMmtRDZMyMxjdaQkbH
 5AGv3laLz49Yjc1GNvCFpRCeZpR25Ly+CZQjMpTDAv8feNPdy0pba8oCUADBrofs1ey8
 fimQMniSlXqDBsu8JJeU8dZxB78f1wjEYoseY3m8AQKErxl57sCO8mWKRnfRUMgm/z3q
 1YflX/SS+xqqG24O0XrjAv2Vgg42bbyJQ18nhlUOsoqAeKM+F606ER4YfbA+cV7YpVav
 l5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786172323; x=1786777123;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xGYz+YB5i+bF3qzmqovTIUQDQlvchSkzLMyA7Z9avvo=;
 b=HW5opI5klr5REfnxfBs2jk/CDOjtMd2Ar7l94VxEywZpQetG6MDGdPWhTWiamknjyL
 y1BCiYNiR6b24R2O2hDPLc2UoC9Cu5c/wYi3GtQXFI5wzWMuzswrAdCutjxoKgVJnFwm
 giJeAqyhuT5iBzguO0mfOB/Ef8/SOvbF3nvAd5CueUCybtEjO9DnfG6ZuPTUrcXVAhRF
 vt94Wb0eg34HzXytXMHfCG7ZYdYtsrQbdRdCKtuv+5iogsf6kw92G2qL5/MxNWquv2KY
 ShIZJA5q25MKSCgeSLOHA0fEUySVZwmYFqzbvUvmBsU42PNBT9U3O7D+pBW9t5ip3MFV
 frcw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5u3JecD3So/yPnnbpnxb0rZS3lJmSq5xDCqVtX4Nx6dKH9SMA85GJBnljRn0h6erwMlNw6bZE49KqPM1E@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx/m2zRRaCWXIWMhOG1HX1P2z/qce2+GVcywDwiMq7oq9WtAudc
 hrlxvpC8UpJ5SR/Woe8MfJITrkMc8l5vLjV4f+sZvIOAgBPOrJzcoQLnQ/qO1ML70nL1cvLsF+R
 od6ocVq1s6kyZFAYziKDffygux/ACJeI7cVB/v7ohOx7sFbS0DPL0hVUrxKA0DybXoKkhmnk8oz
 tKtYgYWQ==
X-Gm-Gg: AR+sD12MtMO34RvejBm/kespHEDNmSphmRAi7kNJ57hRBzJXVObeOzpRSTNiAp4UUfq
 ss2OrnouVmYXh5/0BJZ7TUQcFjSf7l5qwpu+y/9kYt0d7D7tvHIGimF8WCBishc9cZiyM5PeMza
 L5fE6U+iFaWqYaj7MBAcQvH0chXSAek1faJHCn5/9VJhIrh0lj0/LknMyIvjCGaZ2GVhOQuCkmZ
 oPS0VnJarTliNaEnf4BITjxVtSyExXw1z/Y2pX/ZEhwhPSR93r0fnKxCTboK1tIEXn9dLrjq99C
 7+cKmhT+2NvclTtz7u4sSfLOdphUxrxqB6Dry6N+ywr5XbiNVXpjJa45eS9yIDHDEubmp7c3nDU
 1o3HZyXugCa/XetwRW7fS81F9d9G6DI2EwWGZpgbUe0yyyF0gYFSJC1ftr2HHQzInX8nnU+NJ9N
 OGNHX3w2BHxGzok1m3TZYj7awbtpXkoWbkj8EwfZr/erKJaX1qx6Cjfe7MFKTbPZdsHwjaABy3M
 sxB9Vkm2jOjEfZzMnCaroAM0U4o9WJrjupYBDSLo2lSxhVsMZPxkj3ZhGAEYb8mZJhXd2ACBtlB
 2H1WOECGcawAmTDJVr8871s+bp/byRKt3oAOUrsj9yHzZGqM/IQ=
X-Received: by 2002:a05:600c:3589:b0:499:49f2:bb86 with SMTP id
 5b1f17b1804b1-4996196098cmr66950875e9.6.1786172322939; 
 Fri, 07 Aug 2026 23:58:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002145679sm11956590f8f.3.2026.08.07.23.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 23:58:42 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 06:58:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: a194bb5633388956ecad9e0f2b57f1c2d5384065
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <126f5b090c9190bdcc2d47b98c62a5496d2de720-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsb1B-0002Da-4f
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add aws-lc siphash
 implementation
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
Content-Type: multipart/mixed; boundary="===============2597125625716020266=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2597125625716020266==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6bf+r0+lAYE="; charset=UTF-8

--6bf+r0+lAYE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1572?usp=3Demail )

Change subject: Add aws-lc siphash implementation
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add aws-lc si=
phash implementation

AWS-LC has a siphash implementation that is just a si=
mple function call
that also performs the same/better than the reference im=
plementation that
it looks to be based on=2E AWS-lc variant seems to have c=
ome from boringssl
according to the Google copyright=2E

The return type of=
 the siphash related function has been also removed as
neither the referenc=
e nor the aws-lc implementation can fail=2E Only the
OpenSSL based implemen=
tation needed a return type=2E

Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c=
7b9101af6
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1572
Message-Id: <20260806153251=2E66170-1-frank@lichten=
held=2Ecom>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esou=
rceforge=2Enet/msg38181=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2E=
muc=2Ede>
---
M src/openvpn/siphash=2Eh
M src/openvpn/siphash_reference=2Ec=

2 files changed, 43 insertions(+), 8 deletions(-)




diff --git a/src/ope=
nvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
index bddddc3=2E=2Eade7762 10064=
4
--- a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -18,26 +18=
,63 @@
 #ifndef SIPHASH_H
 #define SIPHASH_H
 
+#ifdef HAVE_CONFIG_H
+#incl=
ude "config=2Eh"
+#endif
+
 #include <stdint=2Eh>
 #include <stdio=2Eh>
 #i=
nclude <stdbool=2Eh>
 
+/* We need to include this to check for the OPENSSL=
_IS_AWSLC macro */
+#ifdef ENABLE_CRYPTO_OPENSSL
+#include <openssl/openssl=
v=2Eh>
+#endif
+
 /* siphash always uses 128-bit keys */
 #define SIPHASH_K=
EY_SIZE 16
 
 /**
  * Calculates SIPHASH using the reference implementation=

  */
-int
+void
 siphash_reference(const void *in, size_t inlen, const voi=
d *k,
                   uint8_t *out, size_t outlen);
 
 
-static inline i=
nt
+#if defined(OPENSSL_IS_AWSLC)
+#define USE_CRYPOTOLIB_SIPHASH
+#include=
 <openssl/siphash=2Eh>
+#include <string=2Eh>
+#include "error=2Eh"
+/**
+ =
*  Computes a SipHash value
+ * @param   in      pointer to input data (rea=
d-only)
+ * @param   inlen   input data length in bytes (any size_t value)
=
+ * @param   k       pointer to the key data (read-only), must be 16 bytes
=
+ * @param   out     pointer to output data (write-only), outlen bytes must=
 be allocated
+ * @param   outlen  length of the output in bytes, must be 8=

+ */
+static inline void
+siphash_cryptolib(const void *in, const size_t i=
nlen,
+                  const void *k, uint8_t *out, const size_t outlen)
=
+{
+    ASSERT(outlen =3D=3D sizeof(uint64_t));
+    uint64_t sipout =3D SI=
PHASH_24(k, in, inlen);
+
+    memcpy(out, &sipout, sizeof(uint64_t));
+}
+=
#endif
+
+static inline void
 siphash(const void *in, size_t inlen, const v=
oid *k,
         uint8_t *out, size_t outlen)
 {
-    return siphash_refere=
nce(in, inlen, k, out, outlen);
+#if defined(USE_CRYPOTOLIB_SIPHASH)
+    s=
iphash_cryptolib(in, inlen, k, out, outlen);
+#else
+    siphash_reference(=
in, inlen, k, out, outlen);
+#endif
 }
 
-#endif /* ifndef SIPHASH_H */
\ N=
o newline at end of file
+#endif /* ifndef SIPHASH_H */
diff --git a/src/op=
envpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec
index ad19a=
51=2E=2E5f0adb9 100644
--- a/src/openvpn/siphash_reference=2Ec
+++ b/src/op=
envpn/siphash_reference=2Ec
@@ -99,7 +99,7 @@
  * out: pointer to output da=
ta (write-only), outlen bytes must be allocated
  *  outlen: length of the =
output in bytes, must be 8 or 16
  */
-int
+void
 siphash_reference(const v=
oid *in, const size_t inlen, const void *k, uint8_t *out,
                 =
  const size_t outlen)
 {
@@ -206,7 +206,7 @@
 
     if (outlen =3D=3D 8)
 =
    {
-        return 0;
+        return;
     }
 
     v1 ^=3D 0xdd;
@@ -2=
19,6 +219,4 @@
 
     b =3D v0 ^ v1 ^ v2 ^ v3;
     U64TO8_LE(out + 8, b);
=
-
-    return 0;
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1572?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0=
5e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Gerrit-Change-Number: 1572
Gerrit-P=
atchSet: 25
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--6bf+r0+lAYE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1572?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Add aws-lc siphash implementation<br><br>A=
WS-LC has a siphash implementation that is just a simple function call<br>t=
hat also performs the same/better than the reference implementation that<br=
>it looks to be based on=2E AWS-lc variant seems to have come from boringss=
l<br>according to the Google copyright=2E<br><br>The return type of the sip=
hash related function has been also removed as<br>neither the reference nor=
 the aws-lc implementation can fail=2E Only the<br>OpenSSL based implementa=
tion needed a return type=2E<br><br>Change-Id: I05e20f8c82494e4abf96fe1e3a7=
3e1c7b9101af6<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>=
Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572<br>Message-Id: &lt;20260806=
153251=2E66170-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38181=2Ehtml<br>Signe=
d-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/open=
vpn/siphash=2Eh<br>M src/openvpn/siphash_reference=2Ec<br>2 files changed, =
43 insertions(+), 8 deletions(-)<br><br></pre>
<pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index bddddc3=2E=2Ead=
e7762 100644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><span>=
+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ -18,26 +18,63 @@</span><br=
><span> #ifndef SIPHASH_H</span><br><span> #define SIPHASH_H</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONF=
IG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #include &lt;stdint=2Eh&gt;</span><br><span> #include &lt;stdio=2Eh&gt;</=
span><br><span> #include &lt;stdbool=2Eh&gt;</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* We need to include this to ch=
eck for the OPENSSL_IS_AWSLC macro */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef ENABLE_CRYPTO_OPENSSL</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;openssl/opensslv=2Eh&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* siphash always uses =
128-bit keys */</span><br><span> #define SIPHASH_KEY_SIZE 16</span><br><spa=
n> </span><br><span> /**</span><br><span>  * Calculates SIPHASH using the r=
eference implementation</span><br><span>  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span> siphash_reference(const void *in, size_t inlen=
, const void *k,</span><br><span>                   uint8_t *out, size_t ou=
tlen);</span><br><span> </span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(OPENSSL_IS_AWSLC)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define USE_CRYPOTOLIB_SIPHASH</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/siphash=2Eh&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;strin=
g=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Computes a =
SipHash value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram   in      pointer to input data (read-only)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param   inlen   input data length in bytes =
(any size_t value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param   k       pointer to the key data (read-only), must be 16 bytes</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param   out     po=
inter to output data (write-only), outlen bytes must be allocated</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param   outlen  length of=
 the output in bytes, must be 8</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic inline void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sipha=
sh_cryptolib(const void *in, const size_t inlen,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                  const void *k, uint8_t *out,=
 const size_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(outle=
n =3D=3D sizeof(uint64_t));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint64_t sipout =3D SIPHASH_24(k, in, inlen);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    memcpy(out, &amp;sipout, sizeof(uint64_t));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic inline void</span><br><span> siphash(const void *in, size_t inlen, cons=
t void *k,</span><br><span>         uint8_t *out, size_t outlen)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return si=
phash_reference(in, inlen, k, out, outlen);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(USE_CRYPOTOLIB_SIPHASH)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    siphash_cryptolib(in, inlen, k,=
 out, outlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_referen=
ce(in, inlen, k, out, outlen);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef SIPHASH_H */</span><br><s=
pan>\ No newline at end of file</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* ifndef SIPHASH_H */</span><br><span>diff --git a/src/=
openvpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec</span><br=
><span>index ad19a51=2E=2E5f0adb9 100644</span><br><span>--- a/src/openvpn/=
siphash_reference=2Ec</span><br><span>+++ b/src/openvpn/siphash_reference=
=2Ec</span><br><span>@@ -99,7 +99,7 @@</span><br><span>  * out: pointer to =
output data (write-only), outlen bytes must be allocated</span><br><span>  =
*  outlen: length of the output in bytes, must be 8 or 16</span><br><span> =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> siphash_refe=
rence(const void *in, const size_t inlen, const void *k, uint8_t *out,</spa=
n><br><span>                   const size_t outlen)</span><br><span> {</spa=
n><br><span>@@ -206,7 +206,7 @@</span><br><span> </span><br><span>     if (=
outlen =3D=3D 8)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return;</span><br><span>     }</span><br><span> </s=
pan><br><span>     v1 ^=3D 0xdd;</span><br><span>@@ -219,6 +219,4 @@</span>=
<br><span> </span><br><span>     b =3D v0 ^ v1 ^ v2 ^ v3;</span><br><span> =
    U64TO8_LE(out + 8, b);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</s=
pan><br><span> }</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail">change 1572=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I05e20=
f8c82494e4abf96fe1e3a73e1c7b9101af6 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1572 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 25 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>

</body></html>
--6bf+r0+lAYE=--


--===============2597125625716020266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2597125625716020266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2597125625716020266==--

