Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355FFC5AC67
	for <openvpn-devel@archiver.kernel.org>; Tue, 11 Aug 2026 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=NjnTb1v4+C0l7U266sM1Q39OlHGyxmnU2NlFC1tfpuQ=; b=NMOof8NGew071Z
	6JlDWUvatBJ4Sk9zVzFplQ2ffCVSQ5fgYAnk4m1rO/rD3QUqvjwELOErA4OcOuaqistyXf0ivuV/v
	DaUfZMl+LVvaYVQV//bT6B5KZViD+H3dI4cprW50pcmlH9atW9TnPbUwFAqim14Kch23U1dNyzRwm
	63g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtisD-0000pm-6X;
	Tue, 11 Aug 2026 09:34:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtisB-0000pf-5k
 for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 09:34:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L2p1eNhSYP2gjM06QmFxDgmUue3Ksr5TgPfqcSaZyP8=; b=DWIERNGdTY3a7fG6EPHaRsZRyu
 5bNF2T+KjZ8QaatyKlrI/DCAjr96Y18LZYilX2rCYS0cSYu848mpXvgnWGtIHx1r4ZOOjHo6NwcMf
 S1Ib960A2K0jv0IDyo2y8xIZlUCOtBYCydBYgDR9f62IBdy/9Hwyzivco7ce8YjKoK1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=L2p1eNhSYP2gjM06QmFxDgmUue3Ksr5TgPfqcSaZyP8=; b=D
 g5diP15T9CVa3RAtCA5Mgzc7+eDDn7aA3s9X1cgQhnqhNmJ+FqJJX6E5OF9B/HN9H/NYWAgtBEt8w
 0IfTIVnZYrDUhtYCdWovdBKJkmQxrZnW33TtLcxh7pPEh/9aLhwYe9rr1algTGE0zAgbIzXdOXG0x
 kRaoV5Cz0rkW4ZwU=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtisD-0004L5-A4 for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 09:34:15 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso21072095e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786440847; x=1787045647; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L2p1eNhSYP2gjM06QmFxDgmUue3Ksr5TgPfqcSaZyP8=;
 b=OhALS/yGQFN9c7G4oUACerzqXzfrdsvJn/+F/IzfUn3hha3Mkb/1uyPXmGqBtAoWKH
 q9UttQSO3rN5sex012U9DjFos9pvoIz7FL2cJ8IRFoz1ZjgXTpaQT/PqpnFqILZ1d/K3
 XlckocjxKNj4JLBn0rt4DJFr3s/fbd4ksGsv73x4AMQScHAj8P4IgstyxUG7Ow4Vm7+P
 wg0BJbCqmNtgBkYi1XEV/PfU+fmKD8srJvPh74VEW+IxhPoct8VnBw5RfKt4hzMQhDwb
 kYtqufRTk2kelg35SGojGqST9UUi9w0vnznWfvvnxuDJSAwZIkEpDezC5GHxnHO/cjV9
 71HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786440847; x=1787045647;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L2p1eNhSYP2gjM06QmFxDgmUue3Ksr5TgPfqcSaZyP8=;
 b=BEQ/gcbSn0qR8V5aqpeGl7Ziz7NoALDpOxXB6MHOXmwP9RYuzl0mNGd6k8TLeM0dop
 1t+D9NLIVEKmzPucsHWwPA1+yeC0p49jfxIMz9DkOtDXMv7v8zxeEHEszHJ+GtRfWhsW
 gJkcRJ7bFyXEnnIG8NA+g7qhhRrvQHsngGvuWQbD+kTDrPyutRfsOM7FQ2FUlJFDDFUZ
 +SAICL8B8n4LEfuy7xEY3IsMogKOqpxN+dmee9THvxMT2w6L9XPDGxWZWJH/8sEqGFqw
 YBirNV3/ITLYryfPRr+d0ywT+kc95VKQPGFRZTILeWVBKbmfVY1uP6ec7zS9ysItXcSy
 L4TA==
X-Gm-Message-State: AOJu0YxcZpXwYruZpZrQvjr1cmMd5F3vS/f8QKXukzMY1hVXcBtBqP2/
 tuKeeBeAGmvPxwwR2xCH1VvWdMbbwBhGg89c2zjDFCCeiNj0q9YpmjpVMqQXq2SHYvqjV5z+Apc
 dAkA02guSQwxbB9OsU3xtvblAa8cWj1llC2YSJPQ4McWHAO7yUraw/688ybMWfA5gOT2yp5vmv2
 Q2nmJ3KA==
X-Gm-Gg: AR+sD12MMaTiNCPMZqTEtgPvNYP+K+oHnksjebSezqfjpPpUzUa7pmhSITBI9Fb23qo
 uoYBslm/CZCNVAa65WVzMOegechvJz6chaCGPVbCTPXc9FpoyvOZqgT4AY+/BrLdF6/GPsHHVUb
 +Cgyu+3ufF3bGR/EPNopc51RQP37E9nskvf4hdrLPYylf1Biw9bEisTSquTf9bWtP2GQHVVG1p/
 2bLqJlTV6mK7e9GVAaI2mbWUwXvujJllqyjz4tAjzUOk5MVXQoQEVy8oB+vhNcItWkMGYbXdpxd
 xsXVI9m2G2KDG4EC39plKR9ZA0jlSy54kOOHvN8xFqb5X1aRrqLAF3RcuMiErnWjYqPMFytXZzJ
 gu4MlGG/W5pjQfRS8p/ppQf0f5NMyRMv7tibCLdI8rzvuMOhSfgDbt3C/MMkcozilnL3VzHu6js
 0sW3CSGktyNZbzymjTN6dZFCIL5AkavA+CRneMGoA++yBUY2nI35wDOcjiJmAW4Ir9k7FrzykYV
 W0jE0yApPaHsIHTwZfmzPwHJecEnHASkW2MhbXA2ofn9Nd8Qzaf0Rh9zV3OVD1aMkl8VZydsSay
 JMo7QWHYd2/y0YfTwNPyD6nDnrLd76Wzzs5C2qffIE+827L5OHoZ+k+sFUzbZg==
X-Received: by 2002:a05:600c:1990:b0:499:78b3:7b34 with SMTP id
 5b1f17b1804b1-49978b37c3amr22165115e9.2.1786440847015; 
 Tue, 11 Aug 2026 02:34:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997415e45dsm56647845e9.14.2026.08.11.02.34.05
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 02:34:05 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 11 Aug 2026 09:34:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f
X-Gerrit-Change-Number: 1840
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1840?usp=email>
X-Gerrit-Commit: f893e6e68b48f09a37edb9ffe0c89c519051017e
References: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NDQwODQwMDAwLkkxOTEzYTZlNjRiN2NlMjJiNjZkMjAzNGRmMmEyZmFjMzNmNjBlYTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <287f493137fdd4036294a205c8b2e642d0094323-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtisD-0004L5-A4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: OpenSSL: avoid
 resetting the HMAC key on every packet
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0915033730648837363=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0915033730648837363==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/AvDKC+MOR4="; charset=UTF-8

--/AvDKC+MOR4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1840?usp=3Demail )


Change subject: OpenSSL: avoid rese=
tting the HMAC key on every packet
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

OpenSSL: avoid resetting the HMAC key on every packe=
t

OpenSSL 3=2E0=2E3 and newer can reinitialize an EVP_MAC HMAC
context wit=
h its existing key when EVP_MAC_init is called without
parameters=2E Use th=
at path instead of supplying the digest and key
again on every OpenVPN HMAC=
 reset=2E

Retain the old parameter-based reset for OpenSSL 3=2E0=2E0 throu=
gh
3=2E0=2E2, where parameterless EVP_MAC reinitialization did not reset
th=
e underlying HMAC implementation=2E

Change-Id: I1913a6e64b7ce22b66d2034df2=
a2fac33f60ea9f
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/o=
penvpn/crypto_openssl=2Ec
1 file changed, 9 insertions(+), 5 deletions(-)

=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/40/184=
0/1

diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_opens=
sl=2Ec
index 1191f20=2E=2E2019280 100644
--- a/src/openvpn/crypto_openssl=
=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -1209,7 +1209,7 @@
 
     HMAC=
_Final(ctx, dst, &in_hmac_len);
 }
-#else  /* if OPENSSL_VERSION_NUMBER < 0=
x30000000L */
+#else /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 hmac_ct=
x_t *
 hmac_ctx_new(void)
 {
@@ -1275,10 +1275,14 @@
 void
 hmac_ctx_reset(=
hmac_ctx_t *ctx)
 {
-    /* The OpenSSL MAC API lacks a reset method and pa=
ssing NULL as params
-     * does not reset it either, so use the params ar=
ray to reinitialise it the
-     * same way as before */
-    if (!EVP_MAC_=
init(ctx->ctx, NULL, 0, ctx->params))
+    /* OpenSSL 3=2E0=2E3 fixed EVP_M=
AC reinitialization with an existing key=2E
+     * Older versions need the=
 parameters, including the key, to reset=2E */
+#if OPENSSL_VERSION_NUMBER =
>=3D 0x30000030L
+    const OSSL_PARAM *params =3D NULL;
+#else
+    const =
OSSL_PARAM *params =3D ctx->params;
+#endif
+    if (!EVP_MAC_init(ctx->ctx=
, NULL, 0, params))
     {
         crypto_msg(M_FATAL, "EVP_MAC_init faile=
d");
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
840?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newcha=
nge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1913a6=
e64b7ce22b66d2034df2a2fac33f60ea9f
Gerrit-Change-Number: 1840
Gerrit-PatchS=
et: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--/AvDKC+MOR4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">OpenSSL: avoid resetting the HMAC key on every packet<br><br>OpenS=
SL 3=2E0=2E3 and newer can reinitialize an EVP_MAC HMAC<br>context with its=
 existing key when EVP_MAC_init is called without<br>parameters=2E Use that=
 path instead of supplying the digest and key<br>again on every OpenVPN HMA=
C reset=2E<br><br>Retain the old parameter-based reset for OpenSSL 3=2E0=2E=
0 through<br>3=2E0=2E2, where parameterless EVP_MAC reinitialization did no=
t reset<br>the underlying HMAC implementation=2E<br><br>Change-Id: I1913a6e=
64b7ce22b66d2034df2a2fac33f60ea9f<br>Signed-off-by: Arne Schwabe &lt;arne@r=
fc2549=2Eorg&gt;<br>---<br>M src/openvpn/crypto_openssl=2Ec<br>1 file chang=
ed, 9 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/40/1840/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</s=
pan><br><span>index 1191f20=2E=2E2019280 100644</span><br><span>--- a/src/o=
penvpn/crypto_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=
=2Ec</span><br><span>@@ -1209,7 +1209,7 @@</span><br><span> </span><br><spa=
n>     HMAC_Final(ctx, dst, &amp;in_hmac_len);</span><br><span> }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if OPENSSL_VERSION_NU=
MBER &lt; 0x30000000L */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#else /* if OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><span=
> hmac_ctx_t *</span><br><span> hmac_ctx_new(void)</span><br><span> {</span=
><br><span>@@ -1275,10 +1275,14 @@</span><br><span> void</span><br><span> h=
mac_ctx_reset(hmac_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* The OpenSSL MAC API lacks a reset method=
 and passing NULL as params</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     * does not reset it either, so use the params array to reinitial=
ise it the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * same=
 way as before */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!EVP_MAC_init(ctx-&gt;ctx, NULL, 0, ctx-&gt;params))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* OpenSSL 3=2E0=2E3 fixed EVP_MAC=
 reinitialization with an existing key=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * Older versions need the parameters, including =
the key, to reset=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000030L</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const OSSL_PARAM *params =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const OSSL_PARAM *params =3D ctx-&g=
t;params;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!EVP_MAC_init(c=
tx-&gt;ctx, NULL, 0, params))</span><br><span>     {</span><br><span>      =
   crypto_msg(M_FATAL, &quot;EVP_MAC_init failed&quot;);</span><br><span>  =
   }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail">change 1840</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1913a6e64b7ce2=
2b66d2034df2a2fac33f60ea9f </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1840 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--/AvDKC+MOR4=--


--===============0915033730648837363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0915033730648837363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0915033730648837363==--

