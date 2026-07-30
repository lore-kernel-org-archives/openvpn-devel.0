Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F45FC55160
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9/1mhEuKTRKvbDuDZKrhlEKnkAHvwIVCfWn8xnU/XfY=; b=HUdbXD9SUkDGHyZEruUHXMkZb1
	sJIrFO3fg0nnfg0VrEKHk/1AVWz63RdQyhi6b6zpILLEZTUJQEEuAg2dKAmk0Nxu6aLjYdrZNjwJ8
	g8E8/oXjMNJjD1Aliqd28d+4ntGXYUhrvHq0nbZZjjjGMxzLg+lyIi9vIgd3xaMWeB00=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpP92-000182-Lw;
	Thu, 30 Jul 2026 11:41:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpP92-00017v-0z
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 11:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=aZm8TlH+ZfZdUdBpmbfCmFEuTcM057OQMFSU+Wk5xjk=; b=XF6UTWk6U2S+voJT21BMz0xE7q
 FbZ4uAyGy+PLqmknj72e2JxG26e79vJkAjg5lY3aWZ0w+g987PKnwfYDgpCqnTmNLrR/2fVKToG/b
 ooWEIBtEv1z4OnTvgHljBoOjpcKxhlm2FX+6uQ2U5I5Ub22Y8TsLrSKUB+w+UptMjUr8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aZm8TlH+ZfZdUdBpmbfCmFEuTcM057OQMFSU+Wk5xjk=; b=e
 02iGT9D/W2VjPajw+o46xNMmh8icVbyKjKOWGM/tTyaOF5MZ8bFjtK+AudjheCLKM2q1sxiUIqxFa
 2C1qqMc61G04gzPwp35txVDdpLJVjsSMgb/uMOZXRl/kT3j8jKNUXdCX7wXNtQVuyjY8fauz/gwJ7
 z3vPGtidKwcYtVz4=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpP8z-0007yI-90 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 11:41:47 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so16265315e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 04:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785411699; x=1786016499; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aZm8TlH+ZfZdUdBpmbfCmFEuTcM057OQMFSU+Wk5xjk=;
 b=e4E3xsL/C3EzXEr0EN3uQasMRJsVnsZ+1Hw0E8/WD+H4UQoOjvKI/sJ2ylwk7Yv8J0
 0Lc3HWmGD05zLxEDg+p/cOstFTYeqJ59wLJYdqiU61RzlmiF5naRybElSGEzI9P+940l
 waw3HRPR0mYgSa7fEysUAS5Pt98BYcSjNO87nXa8X1TvjTka6TSZ0ma1vFa+0GQaSt27
 Dgky4dGKckguXD9y0K+lhH6xxtVaOlZFWvtODO/FERgon5FiUaeWqDWHuh9xkUsbleMW
 UvYCN1zOJa76A37xQtg+v3eB0HBXLzhhDqFgQPltMx2Ab7lDKsvpTAfERbHH2EulTQ93
 7yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785411699; x=1786016499;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aZm8TlH+ZfZdUdBpmbfCmFEuTcM057OQMFSU+Wk5xjk=;
 b=SmfZtrSTgzAYi1bi+VE08woKE1Nk1ilqUCgoaEluJFD5To3eaPANnPA3AVT5JZUKz+
 ikVfBZzihpssu8Lu36bRlibQ2WFuVbgnRDB5GZ042gyMQjuoT1LaJ5hFCqGntcCdlIU5
 1WVEOdCC68pZtD7s9PuDGRfT75VdwCWGQn45tC5EwQwkuP0UsCx3KuFgPPIt5jhDrKLH
 YSRuQkOI8dOzSqf9xmapS97950gqTuyZKJkAr5HXBdSshgW4KdNexiR++uCmbgaCH+Px
 rF7Z7XPz7wDOX1t2W1+MfWIE9PZbxILK4qRPsWsQTAkRqfVvSkWhe56qvCfLD5u4X9pd
 NbEA==
X-Gm-Message-State: AOJu0YxPbI8xgA54WOUi/b5g5S0GsvNESM7uUd1dpT2gyzw50Jt9Y0Rx
 JpsJDBCdp18LZnkHmJHjzQTfihG0dXH2r9NEv6DD4BKvMAkjFB4DzW84Yi3OBGUmabxaKv4NvXs
 e4xG+DXq0/O0P78l7kfAIt8H68Bpc/Lnf9PtGYBISO9dLyHSErHSze3/KWqHyUwrSAMBojFrm/G
 ckoQyzQg==
X-Gm-Gg: AR+sD11QSvinAENtsPm8RDw+YUItVuDrqOsGthSOgNp5KcL05bhHKj2ARqNFKc4ITRB
 ep49gAtIvYD5QU/xorwA+ftVW1tNda2y2BF8B5vs6eLO/hvE696LNyqzTLs79V7tgkL4DuhjIU+
 NPTUbAx9W6koYKdCc43shjPc9e922ulHqQV7tCQADBTAvzukjijeE3D/Gv/NqbFw6zZcPWFtVqM
 6Ct6GaINvD8GWBpQG2YTA2SBgAtDstEh35U1hFPAJ6+P+DfIhEcNH8vkTSTUvSPfmtobyrpc397
 4ZUozZ4ftBmPaoTeSCT3VSDL/qywTAU59kvvK5mZnWtdeLP4InCsIlFZ7y4Vj/lQjgEs3bdP5xm
 C+De6uswmvjDiLI6wRW8KocnrQaDRLqiK4kwDc2WoddGUCxraV2lal+SiKTv7VjD2AI3tP0Hi4S
 EK2wu7D+CUZe90e2nPPph1KnYADfPOvHtkK8fSuEoXOVDHZFhHu1UQ13fi/WLNmoqwta/Qr0PwG
 4o9JhhIvZYbTsMeHuDhMnrwr9uZ99E+Q7epx246atLKWCVhalp/M4qHqTklS68wgNGBfHKlacXF
 nYO5b15KdHTImrtGlPoyRJUWrU4Ol/9xzLwLNh0iEJ6FCvAp4+Q=
X-Received: by 2002:a05:600c:1f92:b0:495:5d5b:7533 with SMTP id
 5b1f17b1804b1-49800e93ddamr29909525e9.13.1785411698519; 
 Thu, 30 Jul 2026 04:41:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49800f0ebfasm51439215e9.2.2026.07.30.04.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:41:37 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 11:41:35 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: 7dc15b674dcc756a7211f0832ffdedfc6265ffee
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ed053e13e70eb1916de70017baa5d5549278e468-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpP8z-0007yI-90
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add aws-lc siphash
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2179811984817406290=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2179811984817406290==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PE7Ejgf8dHQ="; charset=UTF-8

--PE7Ejgf8dHQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1572?usp=3Demail

to look at the new patch set (#2=
2)=2E

The following approvals got outdated and were removed:
Code-Review-1=
 by flichtenheld


Change subject: Add aws-lc siphash implementation
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add aws-lc siphash =
implementation

AWS-LC has a siphash implementation that is just a simple f=
unction call
that also performs the same/better than the reference implemen=
tation that
it looks to be based on=2E AWS-lc variant seems to have come fr=
om boringssl
according to the Google copyright=2E

The return type of the s=
iphash related function has been also removed as
neither the reference nor =
the aws-lc implementation can fail=2E Only the
OpenSSL based implementation=
 needed a return type=2E

Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101=
af6
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/siph=
ash=2Eh
M src/openvpn/siphash_reference=2Ec
2 files changed, 42 insertions(=
+), 7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/72/1572/22

diff --git a/src/openvpn/siphash=2Eh b/src/openvpn=
/siphash=2Eh
index bddddc3=2E=2E3c0f560 100644
--- a/src/openvpn/siphash=2E=
h
+++ b/src/openvpn/siphash=2Eh
@@ -18,26 +18,63 @@
 #ifndef SIPHASH_H
 #de=
fine SIPHASH_H
 
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
 #i=
nclude <stdint=2Eh>
 #include <stdio=2Eh>
 #include <stdbool=2Eh>
 
+/* We =
need to include this to check for the OPENSSL_IS_AWSLC macro */
+#ifdef ENA=
BLE_CRYPTO_OPENSSL
+#include <openssl/opensslv=2Eh>
+#endif
+
 /* siphash a=
lways uses 128-bit keys */
 #define SIPHASH_KEY_SIZE 16
 
 /**
  * Calculat=
es SIPHASH using the reference implementation
  */
-int
+void
 siphash_refe=
rence(const void *in, size_t inlen, const void *k,
                   uint8=
_t *out, size_t outlen);
 
 
-static inline int
+#if defined(OPENSSL_IS_AWS=
LC)
+#define USE_CRYPOTOLIB_SIPHASH
+#include <openssl/siphash=2Eh>
+#inclu=
de <string=2Eh>
+#include "error=2Eh"
+/**
+ *  Computes a SipHash value
+ =
* @param   in      pointer to input data (read-only)
+ * @param   inlen   i=
nput data length in bytes (any size_t value)
+ * @param   k       pointer t=
o the key data (read-only), must be 16 bytes
+ * @param   out     pointer t=
o output data (write-only), outlen bytes must be allocated
+ * @param   out=
len  length of the output in bytes, must be 8
+ */
+static inline void
+sip=
hash_cryptolib(const void *in, const size_t inlen,
+                  const=
 void *k, uint8_t *out, const size_t outlen)
+{
+    ASSERT(outlen =3D=3D s=
izeof(uint64_t));
+    uint64_t sipout =3D SIPHASH_24(k, in, inlen);
+
+   =
 memcpy(out, &sipout, sizeof(uint64_t));
+}
+#endif
+
+static inline void
 =
siphash(const void *in, size_t inlen, const void *k,
         uint8_t *out,=
 size_t outlen)
 {
+#if defined(USE_CRYPOTOLIB_SIPHASH)
+    return siphash=
_cryptolib(in, inlen, k, out, outlen);
+#else
     return siphash_reference=
(in, inlen, k, out, outlen);
+#endif
 }
 
-#endif /* ifndef SIPHASH_H */
\ =
No newline at end of file
+#endif /* ifndef SIPHASH_H */
diff --git a/src/o=
penvpn/siphash_reference=2Ec b/src/openvpn/siphash_reference=2Ec
index ad19=
a51=2E=2E5f0adb9 100644
--- a/src/openvpn/siphash_reference=2Ec
+++ b/src/o=
penvpn/siphash_reference=2Ec
@@ -99,7 +99,7 @@
  * out: pointer to output d=
ata (write-only), outlen bytes must be allocated
  *  outlen: length of the=
 output in bytes, must be 8 or 16
  */
-int
+void
 siphash_reference(const =
void *in, const size_t inlen, const void *k, uint8_t *out,
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
@@ -=
219,6 +219,4 @@
 
     b =3D v0 ^ v1 ^ v2 ^ v3;
     U64TO8_LE(out + 8, b);=

-
-    return 0;
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1572?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Gerrit-Change-Number: 1572
Ge=
rrit-PatchSet: 22
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld =
<frank@lichtenheld=2Ecom>

--PE7Ejgf8dHQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #22</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1572?usp=3Demail">View Change</a></p><p>The followin=
g approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Add aws-lc siphash implementation<br><br>AWS-LC has a siphas=
h implementation that is just a simple function call<br>that also performs =
the same/better than the reference implementation that<br>it looks to be ba=
sed on=2E AWS-lc variant seems to have come from boringssl<br>according to =
the Google copyright=2E<br><br>The return type of the siphash related funct=
ion has been also removed as<br>neither the reference nor the aws-lc implem=
entation can fail=2E Only the<br>OpenSSL based implementation needed a retu=
rn type=2E<br><br>Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6<br>S=
igned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openv=
pn/siphash=2Eh<br>M src/openvpn/siphash_reference=2Ec<br>2 files changed, 4=
2 insertions(+), 7 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/72/1572/22</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><span>ind=
ex bddddc3=2E=2E3c0f560 100644</span><br><span>--- a/src/openvpn/siphash=2E=
h</span><br><span>+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ -18,26 +=
18,63 @@</span><br><span> #ifndef SIPHASH_H</span><br><span> #define SIPHAS=
H_H</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> #include &lt;stdint=2Eh&gt;</span><br><span> #include &=
lt;stdio=2Eh&gt;</span><br><span> #include &lt;stdbool=2Eh&gt;</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* We need to =
include this to check for the OPENSSL_IS_AWSLC macro */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTO_OPENSSL</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/opensslv=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* sip=
hash always uses 128-bit keys */</span><br><span> #define SIPHASH_KEY_SIZE =
16</span><br><span> </span><br><span> /**</span><br><span>  * Calculates SI=
PHASH using the reference implementation</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span> siphash_reference(const void =
*in, size_t inlen, const void *k,</span><br><span>                   uint8_=
t *out, size_t outlen);</span><br><span> </span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(OPENSSL_IS_AWSLC)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define USE_CRYPOTOLIB_SIPHAS=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;opens=
sl/siphash=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  Computes a SipHash value</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param   in      pointer to input data (read-only)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param   inlen   input data=
 length in bytes (any size_t value)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param   k       pointer to the key data (read-only), mu=
st be 16 bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram   out     pointer to output data (write-only), outlen bytes must be al=
located</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param   =
outlen  length of the output in bytes, must be 8</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static inline void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+siphash_cryptolib(const void *in, const size_t inlen,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                  const void =
*k, uint8_t *out, const size_t outlen)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(outlen =3D=3D sizeof(uint64_t));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint64_t sipout =3D SIPHASH_24(k, in, inlen);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    memcpy(out, &amp;sipout, sizeof(uin=
t64_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline void</span><br><span> siphash(const void *in, =
size_t inlen, const void *k,</span><br><span>         uint8_t *out, size_t =
outlen)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(USE_CRYPOTOLIB_SIPHASH)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return siphash_cryptolib(in, inlen, k, out, outl=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br=
><span>     return siphash_reference(in, inlen, k, out, outlen);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* ifndef SIPHASH_H */</span><br><span>\ No newline at end of file</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef SIPHASH_H */=
</span><br><span>diff --git a/src/openvpn/siphash_reference=2Ec b/src/openv=
pn/siphash_reference=2Ec</span><br><span>index ad19a51=2E=2E5f0adb9 100644<=
/span><br><span>--- a/src/openvpn/siphash_reference=2Ec</span><br><span>+++=
 b/src/openvpn/siphash_reference=2Ec</span><br><span>@@ -99,7 +99,7 @@</spa=
n><br><span>  * out: pointer to output data (write-only), outlen bytes must=
 be allocated</span><br><span>  *  outlen: length of the output in bytes, m=
ust be 8 or 16</span><br><span>  */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span> siphash_reference(const void *in, const size_t inlen, c=
onst void *k, uint8_t *out,</span><br><span>                   const size_t=
 outlen)</span><br><span> {</span><br><span>@@ -206,7 +206,7 @@</span><br><=
span> </span><br><span>     if (outlen =3D=3D 8)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><=
span>     }</span><br><span> </span><br><span>     v1 ^=3D 0xdd;</span><br>=
<span>@@ -219,6 +219,4 @@</span><br><span> </span><br><span>     b =3D v0 ^=
 v1 ^ v2 ^ v3;</span><br><span>     U64TO8_LE(out + 8, b);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return 0;</span><br><span> }</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1572?usp=3Demail">change 1572</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1572?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1572 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 22 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>

</body></html>
--PE7Ejgf8dHQ=--


--===============2179811984817406290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2179811984817406290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2179811984817406290==--

