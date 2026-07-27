Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2E9C531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rd0X/+AWIeZSaukDxrFEsQHCuDXo0q/gEr27z/ccGU0=; b=kGMYtJq7wTATS0MFTV2EGq5D1Y
	5dzNAYBzWP26+yoMcmWN9Nz1iuxGt47RDXSDwbBQJDDDXK58pf5YUYjjNVA1iC4QCgq6ts6yTnjFt
	7vPtRM3SVPhH1qDvQ9nGSCw55VADqUvRtemR8wE+ymW9Gsw0lMBqnEddu4lvEn3GLiqI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woLxa-0005Zb-Dt;
	Mon, 27 Jul 2026 14:05:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woLxR-0005ZQ-Ux
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:05:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lgtyBPKYJiZeiCEJRat0JEMGnPk1GC6wsgmd6/Lt6L8=; b=lpsU4Y8ArbDuiBFRRyEqyLvrjy
 a2TS/hhf5HDyUU9LnmM2wk5RZApT9WhMBIJeZ9jC9QIOXfPddygo2p6vvGJphXvpwwo4jHY3yLe58
 T94CGKcBuk1x3pY8NBhO57SDTRygCGoYl42I7X3hOIA1OyXJQpB39Bun0bssqXF8lezg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lgtyBPKYJiZeiCEJRat0JEMGnPk1GC6wsgmd6/Lt6L8=; b=m
 6dZk1heHUpwagWsYe2LKvvUgszZdPRP+hQfW2UZhK8XcXJGV2uQciWnN3DtxEe6jhMhl/lYXOEqGu
 yTOIK5wHJB/cykzarvuxE5VByaYGpTuN5MjqwB9ZimOEo/wAc6+dvdUPQ3ftnuluKl5gd0KrIvdV+
 6NIeyl0XXgTz4D7s=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woLxU-0000fo-PF for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:05:30 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47640541585so1727371f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 07:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785161123; x=1785765923; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lgtyBPKYJiZeiCEJRat0JEMGnPk1GC6wsgmd6/Lt6L8=;
 b=UzIpI10xgvcSG1SgRmavbET9cpXRzIe/VFNJCOqcYQTeUqvSbRkeM+fxHV1Ryf6NFt
 1Bw71q9rHHRrIZ96bcEG6rDgDph3uMvFCgmM8AUuVjnFiHDI0cfeNxWQuDRANNysPO+P
 SveAbJfEWXUzhh8o9tN3mxXo0C2+I2X3n1qtYeCztgHX5rHyvo77Q9ZQWbu84diIcZVc
 FDiESaLGGsOv9VLjKiXD7tZwfiGHo913XKerFooWsEVjKLfRjKmb1mU1s3DgEVc5DQ+G
 TEVQ9vMEhUsalyo0baVApyYdruEpI0mbPAGyYBTK/F2czp5t0W+kfWmrty2nb3g38Sjm
 tB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785161123; x=1785765923;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lgtyBPKYJiZeiCEJRat0JEMGnPk1GC6wsgmd6/Lt6L8=;
 b=H3IW9Pp8TgTcGiw8aYoztmN4fLbDz7siQJqa90R7iQiNd4oRIEBwPFDRD+7YijOcZj
 zqeO7RbGYWrGodKZOShxjZYWTG7gTBZI8N4dPyTz2S9iwZfK7EU220gsCLIIR8Eswji2
 h8aU4Nk70Q1lhNYsgKk+M1wfjqutwPB67ZhV0mUI/U4cy6/Zy9SexcRdQK1SjGFQ+CvB
 6pOauwc1fktiLRmnZr1l2TfQgF8k27GOfoe6BQ3ZCl8uxCJSTaAKDUiNgqCqtVzclFRm
 hYqDVZbNVVrceQtQu/DywV8PoBDaJDF1Ckikh6cG5QQPkanS/D8DfTuLGBmNsHaElC3v
 3OCg==
X-Gm-Message-State: AOJu0YwsHZ9HII2pOFTF82tGEI0HGX6MyjgvtdSINx5oSi1mil70lifw
 dmtzHcpNWsTfEWIv3hw8y9lng7Hy3/t93JqgdHs71JYKG+t6IqDCdsDKVj/Lsi3RUTgtYrXw3Pk
 ZgGKFXjmKrC+IPDHe6vxskoAUc6ZLH/FJsIlQSoCoQqCPb6kjRlGCg//lfBSqhLSnd7DLrVWKDE
 0QrB3Igg==
X-Gm-Gg: AR+sD137C382rupr9tXjRzro9oDGYIah9xSZFhc55qOgY2LvNT/s/37Y4GWx7Zdv+YO
 KEo3RGsiL4V7gaTw1e0PL9B/5IYFxc56eF4PebajW70L3ZaIvqI1vC2q9Ax7Gs5rptO0gfh8zZk
 OBWFDWKIzqQFihaFwqPmeWo5vSnCDy7YzYMzqTu0Te01+mRjwFbSaEngWhU1QbaC6MXaFNENohO
 a93QG4BNgSs8xnPyFgk53XTDKrdAjRRBxhDRioI3D2HdPIwVWxZ4+RHNEFbSRuZmtikX5Js2vg1
 ZWwC5HW0TfaA5/TUiVsSe8eVuypaXTa17Nkw39AuyalQCGkc+mn2ehGj1yvbXGXh0lhlE1LmpNj
 YzoxKURHkfYiVCB8DxLqG/BrMMGhs/tkllKiuJPRXC7zXjM6XyMTgM6OghQUTQ634D/oA664DEQ
 ktlUPhJu9XpE7ZNqh0Ex+e+UDeWJLD9J/6dBJ8h3zd2TAmjOxLPejE09p6U3Nt2cV7ao+SQDFYo
 ytBnz9X68vsX6qdN2nU09fT4G1W2gbMc/3lRze65pfuJaUEUQWOALsMvYHJF8f1I2VH
X-Received: by 2002:a05:6000:1861:b0:47f:48cb:ea5b with SMTP id
 ffacd0b85a97d-47f9febd20bmr10698134f8f.43.1785161122322; 
 Mon, 27 Jul 2026 07:05:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c532d4sm48235822f8f.22.2026.07.27.07.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 07:05:21 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 14:05:18 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: f225b8088e3f1528e265249674dda2449e83ad3e
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <af3e4ea07175009b07356e7476123db45b875897-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woLxU-0000fo-PF
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
Content-Type: multipart/mixed; boundary="===============4125543110079565210=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4125543110079565210==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3dguKjN1wW0="; charset=UTF-8

--3dguKjN1wW0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail

to look at the new pa=
tch set (#21)=2E


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

Change-Id: I05e20f8c8249=
4e4abf96fe1e3a73e1c7b9101af6
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eor=
g>
---
M src/openvpn/siphash=2Eh
1 file changed, 30 insertions(+), 1 deleti=
on(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
72/1572/21

diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
=
index bddddc3=2E=2Ed90ae99 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/o=
penvpn/siphash=2Eh
@@ -33,11 +33,40 @@
                   uint8_t *out, siz=
e_t outlen);
 
 
+#if defined(OPENSSL_IS_AWSLC)
+#define USE_CRYPOTOLIB_SIP=
HASH
+#include <openssl/siphash=2Eh>
+#include <string=2Eh>
+#include "erro=
r=2Eh"
+/**
+ *  Computes a SipHash value
+ * @param   in: pointer to input=
 data (read-only)
+ * @param   inlen: input data length in bytes (any size_=
t value)
+ * @param   k: pointer to the key data (read-only), must be 16 by=
tes
+ * @param   out: pointer to output data (write-only), outlen bytes mus=
t be allocated
+ * @param   outlen: length of the output in bytes, must be =
8
+ */
+static inline int
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
+   =
 return 0;
+}
+#endif
+
 static inline int
 siphash(const void *in, size_t =
inlen, const void *k,
         uint8_t *out, size_t outlen)
 {
+#if defined=
(USE_CRYPOTOLIB_SIPHASH)
+    return siphash_cryptolib(in, inlen, k, out, o=
utlen);
+#else
     return siphash_reference(in, inlen, k, out, outlen);
+#=
endif
 }
 
-#endif /* ifndef SIPHASH_H */
\ No newline at end of file
+#end=
if /* ifndef SIPHASH_H */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1572?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Gerrit-Change-Number: 15=
72
Gerrit-PatchSet: 21
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>

--3dguKjN1wW0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #21</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add aws-lc siphash implementation<br><br>AWS-LC has a siphash imp=
lementation that is just a simple function call<br>that also performs the s=
ame/better than the reference implementation that<br>it looks to be based o=
n=2E AWS-lc variant seems to have come from boringssl<br>according to the G=
oogle copyright=2E<br><br>Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101=
af6<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M s=
rc/openvpn/siphash=2Eh<br>1 file changed, 30 insertions(+), 1 deletion(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/72/1572/21</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/siphash=2Eh b/s=
rc/openvpn/siphash=2Eh</span><br><span>index bddddc3=2E=2Ed90ae99 100644</s=
pan><br><span>--- a/src/openvpn/siphash=2Eh</span><br><span>+++ b/src/openv=
pn/siphash=2Eh</span><br><span>@@ -33,11 +33,40 @@</span><br><span>        =
           uint8_t *out, size_t outlen);</span><br><span> </span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(OPENSS=
L_IS_AWSLC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
USE_CRYPOTOLIB_SIPHASH</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;openssl/siphash=2Eh&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  Computes a SipHash value</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param   in: pointer to input data (re=
ad-only)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  =
 inlen: input data length in bytes (any size_t value)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param   k: pointer to the key data (r=
ead-only), must be 16 bytes</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param   out: pointer to output data (write-only), outlen bytes =
must be allocated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param   outlen: length of the output in bytes, must be 8</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static inline int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+siphash_cryptolib(const void *in, const size_t inlen,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  co=
nst void *k, uint8_t *out, const size_t outlen)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(outlen =3D=3D sizeof(uint64_t));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint64_t sipout =3D SIPHASH_24(k, in,=
 inlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(out, &amp;sipout, s=
izeof(uint64_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inline int</sp=
an><br><span> siphash(const void *in, size_t inlen, const void *k,</span><b=
r><span>         uint8_t *out, size_t outlen)</span><br><span> {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(USE_CRYPOTOLIB_SIP=
HASH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sip=
hash_cryptolib(in, inlen, k, out, outlen);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#else</span><br><span>     return siphash_reference(=
in, inlen, k, out, outlen);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef SIPHASH_H */</span><br><sp=
an>\ No newline at end of file</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* ifndef SIPHASH_H */</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?=
usp=3Demail">change 1572</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1572?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1572 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerri=
t-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--3dguKjN1wW0=--


--===============4125543110079565210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4125543110079565210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4125543110079565210==--

