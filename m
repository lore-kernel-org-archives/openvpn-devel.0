Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BA2C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YXMug7Dcr+6fe1cNj8OXRndCpdPI9UWGEHabLbCF4w4=; b=SXmqwBad9rLZ12abY6ey3rDPVM
	G51pIKJiFhb2hv9nEBNJADSbLhE8AfNFu1HLpjUKAxVAbBXL8VmRdvVkSbEobGxDGv5MNgOicahaG
	yzqnzONsN0OBm9KeTs+16Q/XfOwrc/9+T1WcG3Rao5GC/i2cgoMgv3MgaHQQCi7PZOr8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYXY-0003NN-Lj;
	Thu, 13 Aug 2026 16:44:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuYXX-0003NH-0w
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:44:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=aXxaPMlIcP6xkd2MpvUdyy3v5iAROq1uuEO8YIsxWHM=; b=b1IgdXJrS0JYrr7/ld7wq8dwr/
 OuAZ4+d//jYn5ZvOKOil2O/r/ZJl6DDMB/QcGsPauFCD4KYZgNaOrgDiQbxl1pqS0orw4XByZ2NAV
 JU7aQYWwmmeOmK9/z2eI0vG7wZ73yFisTiFk5lgadVYO0wtHb/5eWseyQaghNNT4qDNc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aXxaPMlIcP6xkd2MpvUdyy3v5iAROq1uuEO8YIsxWHM=; b=L
 zmjkDyR/yyMYIIqA54STXC8yRIEwPAxUsf5v4Mf5LU7d3PzN344QDLbKS/rxBJl0/moeP0BGsctrJ
 evtVg2eg0adh7kqMxn328N2tPCC9fv5Izf80lRf0csRCVQUomLVC8Ly2qPAt9yQ7MglBtdt92qxO1
 MDxpZxdlnqh2Bb+k=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuYXR-0004c2-4b for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:44:20 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so1127545e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786639451; x=1787244251; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aXxaPMlIcP6xkd2MpvUdyy3v5iAROq1uuEO8YIsxWHM=;
 b=U/arW2Vlr+V2aAejSqXL0YxotHIZcCUAu3oFPL3t5xmT+QCPZVSXk4YbUU+Fi2SiFU
 rIBUOEI3zHWQrRsZR9xijzWC/GpOry2tMu6HEXKEdm4gAma1vlmkdlAjEfaig0jo3rVL
 ZYGkp2u3IEisQ2i0aC+ObdtDOkmq6VT8rsgzqYH44vANs8hHCrTOtbW406hNAlhhtupt
 NTdtJbhNkSD9thvkn7/6GKSb3ONBU3D7sPYSBGUnhxevKv5MR6A/oXnGbRg1k7RRPdTS
 F0itAj+FbcH0eGXB1bbOLYWMNgptyAJWUuyhhoyb+aPjwR5x326P0ld/r7JI9OrccSAg
 ff7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786639451; x=1787244251;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aXxaPMlIcP6xkd2MpvUdyy3v5iAROq1uuEO8YIsxWHM=;
 b=XMrImcq/PXAHL/ZhM+NHiwlsJ6IUy/hag2bnDEhPgRd++cNBV3y0OEYndVwhgC1kUN
 LYTiJw5+y+0J5KHIlEBgKi0fge5Su3HSwPS5cEVuGZwCJwmKp1oRcw4zpCYDEGD3HF5b
 w4Jxfi9+bwZEzuTP5XAyMEWV30WP/m3ssHmJXMu8ia37JQHQg+rdKKIqcyQQ99MltLxp
 HEHcmypJIapX7Ib7jrz17anohsi1tyRmfmQUdjebJJj7mcPyTXH74XTbOKSS1OvbcAFM
 XdlEqMxSf5tMyUdP9Ct69M5VHlUECgfhPqhmASQloS5R9VOIoF1bCEqXFrneODMX92BG
 IJMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqidyAJyLl1fFmMqO6kHZTNBNs0GeppPV16h0Nrlu0aSbrN9oSbfA7OvjAAvRY1/te2AZM6CaS4M23ck814@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx9HdjUTtOf99wlVH5SRu6CzzIcWlq8sZ/WCMMIsxf0lDqNUEEY
 0B/2iy8Fqv30+HMb1pM/jR96U7uwqxzOy6ai5TrwPCa1Ze7WgVsHOjBtBGjNUiXdfPsNmbtqGXB
 wgoCjdwlx7G6tnfpm0xnTbLbs749yW8vjeX8sCOdvqRBG9CKmB5OMZqrvXWdpxwzhIKxX
X-Gm-Gg: AR+sD10tYsHn/1OqgSsD3DOKxCFXf1nr4G3PN7STeIeX9h5vjaw3SlpkBhGrCdAWnjG
 grT94TrkgeLydnzFBLNL5x0l3TeP83m0JWdCADAnGqk5VBFI3pFYHCQttN3WmvNRM6AHTmRHg19
 7HdLkWdbnk8xFi/vWDzsvcJZYvvUznckTAsxo4wJmRwWJv6b3oJz/l20NiHVUrGxaeWF1cWl5ne
 9nCidMALjsC4/YnL7ExIGii49EHutLuWnqhQTEIlsbWpdRJcHVvf84WHgUj5ZUsZ2oxmYQ4VpbT
 Pdk7z6jqXdwoLZWC9lACcQhJHDrgA9q3JihPVebfhoIkx5+2N+n8xg9vwD2HKY/mQ5L0t2O4Upt
 pI+mt5vfp1kwcCocEaPwzFt2plimAnrVkTOGM+A/65uamb5nnhMKaCkqkVDBrQ81O4r+Qb/H1Bj
 UQfnlV/vQTna60aZLu+a8uCXvWmHz5qqd3h4YVUhu00iaiGFd9ac7MJEGJSC5VbM7UhrpqinXbp
 QL6BAk/c81O7TQCkVEFPuc4R5C7ZFEDaB3CUEZivkmzTGmKfbH1Byp/H9V+PbdcmMW2ASIXV/RA
 sA1GKkW20gk0VxMAJajZvC3TkNts04V1Fa8WOHiueI9tF/GdTpE=
X-Received: by 2002:a05:600c:4c96:b0:495:6bc9:62b0 with SMTP id
 5b1f17b1804b1-499821e1e19mr62119975e9.17.1786639450553; 
 Thu, 13 Aug 2026 09:44:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499821217acsm63548795e9.2.2026.08.13.09.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:44:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 16:44:09 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f
X-Gerrit-Change-Number: 1840
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1840?usp=email>
X-Gerrit-Commit: 3568e9d8cca78be9577cb7220d9bb9419894d207
In-Reply-To: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
References: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NDQwODQwMDAwLkkxOTEzYTZlNjRiN2NlMjJiNjZkMjAzNGRmMmEyZmFjMzNmNjBlYTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <581e50823bafcbc9141deec48cf59368854b1021-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuYXR-0004c2-4b
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8423010207262974344=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8423010207262974344==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UTvf+QlNuOU="; charset=UTF-8

--UTvf+QlNuOU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has submitted thi=
s change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail )
=

Change subject: OpenSSL: avoid resetting the HMAC key on every packet
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

OpenSSL: avoid r=
esetting the HMAC key on every packet

OpenSSL 3=2E0=2E3 and newer can rein=
itialize an EVP_MAC HMAC
context with its existing key when EVP_MAC_init is=
 called without
parameters=2E Use that path instead of supplying the digest=
 and key
again on every OpenVPN HMAC reset=2E

Retain the old parameter-bas=
ed reset for OpenSSL 3=2E0=2E0 through
3=2E0=2E2, where parameterless EVP_M=
AC reinitialization did not reset
the underlying HMAC implementation=2E

Gi=
thub: closes OpenVPN/openvpn#1088

Change-Id: I1913a6e64b7ce22b66d2034df2a2=
fac33f60ea9f
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840
M=
essage-Id: <20260813163239=2E26557-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38313=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/crypto_openssl=2Ec
1 file changed, 9 insertions(+), 5 deletions(-)



=

diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=
=2Ec
index 1191f20=2E=2E2019280 100644
--- a/src/openvpn/crypto_openssl=2Ec=

+++ b/src/openvpn/crypto_openssl=2Ec
@@ -1209,7 +1209,7 @@
 
     HMAC_Fin=
al(ctx, dst, &in_hmac_len);
 }
-#else  /* if OPENSSL_VERSION_NUMBER < 0x300=
00000L */
+#else /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 hmac_ctx_t =
*
 hmac_ctx_new(void)
 {
@@ -1275,10 +1275,14 @@
 void
 hmac_ctx_reset(hmac=
_ctx_t *ctx)
 {
-    /* The OpenSSL MAC API lacks a reset method and passin=
g NULL as params
-     * does not reset it either, so use the params array =
to reinitialise it the
-     * same way as before */
-    if (!EVP_MAC_init=
(ctx->ctx, NULL, 0, ctx->params))
+    /* OpenSSL 3=2E0=2E3 fixed EVP_MAC r=
einitialization with an existing key=2E
+     * Older versions need the par=
ameters, including the key, to reset=2E */
+#if OPENSSL_VERSION_NUMBER >=3D=
 0x30000030L
+    const OSSL_PARAM *params =3D NULL;
+#else
+    const OSSL=
_PARAM *params =3D ctx->params;
+#endif
+    if (!EVP_MAC_init(ctx->ctx, NU=
LL, 0, params))
     {
         crypto_msg(M_FATAL, "EVP_MAC_init failed");=

     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1913a6e64b7ce=
22b66d2034df2a2fac33f60ea9f
Gerrit-Change-Number: 1840
Gerrit-PatchSet: 2
G=
errit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--UTvf+QlNuOU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 <strong>submitted</strong>=
 this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1840?usp=3Demail">View Change</a></p><div style=3D"white-space:pre-wrap"></=
div><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">OpenSSL: avoid resetting the HMAC key on every packet<br>=
<br>OpenSSL 3=2E0=2E3 and newer can reinitialize an EVP_MAC HMAC<br>context=
 with its existing key when EVP_MAC_init is called without<br>parameters=2E=
 Use that path instead of supplying the digest and key<br>again on every Op=
enVPN HMAC reset=2E<br><br>Retain the old parameter-based reset for OpenSSL=
 3=2E0=2E0 through<br>3=2E0=2E2, where parameterless EVP_MAC reinitializati=
on did not reset<br>the underlying HMAC implementation=2E<br><br>Github: cl=
oses OpenVPN/openvpn#1088<br><br>Change-Id: I1913a6e64b7ce22b66d2034df2a2fa=
c33f60ea9f<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Ack=
ed-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Razvan =
Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1840<br>Message-Id: &lt;20260813163239=2E26557-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg38313=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/crypto_openssl=2E=
c<br>1 file changed, 9 insertions(+), 5 deletions(-)<br><br></pre>
<pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</sp=
an><br><span>index 1191f20=2E=2E2019280 100644</span><br><span>--- a/src/op=
envpn/crypto_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=
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
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1913a6e64b7ce22b6=
6d2034df2a2fac33f60ea9f </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1840 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--UTvf+QlNuOU=--


--===============8423010207262974344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8423010207262974344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8423010207262974344==--

