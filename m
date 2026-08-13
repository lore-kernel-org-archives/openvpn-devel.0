Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F87C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7uHd/gD2cAQjTcWrFb9pezaJ2r/2lhCDf4m4U7kGji8=; b=LtCElx69s64OT9fOVZfZQDvDzO
	RAIYsmne7W6n4VLrIcLL2l1O45zc1Jnh8iV+n8B67iQPr7RbLVvDfY5MHbgxrS/vyO2cYGccxGPa+
	WSa/TM4jlr7Y+ZcP2X6MzlhzpXhOcLE5YlO6QlvH+NXhcuwTbhIay1uSW3+YSUXgYmfQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYXT-0003Wd-8H;
	Thu, 13 Aug 2026 16:44:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuYXR-0003WW-Vr
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:44:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NcImEfbSmv7dW6ElJlBwzOPF91vJugp3tjRTxpRppR8=; b=iIaRod0PXw4udVHSJQMzuPCN4i
 j/J03MMxrFi5NRze9WlvbYbHGJDc4HxFjrkIlKJdI6dhXttVXBbDz8ooI2rZ2dqvs39rQjaaKQz3M
 43sCgWsHA7GU0L0w1JDbtfsmuTv9NPb3Jrfm6o/Z1ke+3wSK8Fif0D54Dnp8ewzG2zQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NcImEfbSmv7dW6ElJlBwzOPF91vJugp3tjRTxpRppR8=; b=b
 kDJQpvdGATxfCYUdOfp4cec8v7/2wgVlXhhljL9LBo8eTmRY2VKtWOytJDM7+CHVZJkwJ0Ce+f9cE
 UW9NIq1mm9D98wA5H4qPYGFTtf5XUHbbxW0fd3SFKYEZEraN1JcKDRN2EbmngUmYWWDxwovErkiZv
 d+QQf+Xw1kIAs74g=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuYXQ-0004bz-H9 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:44:17 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4956242332dso1248485e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786639450; x=1787244250; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NcImEfbSmv7dW6ElJlBwzOPF91vJugp3tjRTxpRppR8=;
 b=g3PzKACBjxo9Arqfz+SXpTfOkZczMUEo+4E1pva26KDnyXfM+WtMuhdU88/sx/6qyb
 Ee/CtmuvSP5RjVusqVm90eNnvOHr9oIiSqgGX5aBepp0/ifIYQKqvp4bFp+mVPL7YrSA
 kYelmxCS4oYmF4OH61EQOOf7odg8A63kWzt4erCYpdca5P+CVxqibM0wLi8ufWVXhXhd
 1vG38bSR+tVr2+iQflXeu97BQgRJp9+kPUno6sDcvoOEjYaIaeUnPJopFbxf40At9MRo
 tqlQjq2V4dAWzSVzAO/hJkFLXcmHQ/+NhEvPl6BuJWWuLE1mSmxBEymevluCPtnofwoY
 PFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786639450; x=1787244250;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NcImEfbSmv7dW6ElJlBwzOPF91vJugp3tjRTxpRppR8=;
 b=LeDmthkptlipa/rIGiQ1tpQ4E7+kRZWulIsq6Ek55jxL7QBR9StMJY53VPVI7DlYYb
 UI4Ygv3/2TVtT2qHZ5duU/royBWMoaaKyHnBYc4mCLR4QJA/OJ25royI/kR/FUVruOzy
 t1m5bFf79Bdpooc6XEwQcRzotRwW47LLqR4eis4N5yIUzIvgsToShlS3hFlEu9fLZ87m
 YlZLU5uxzDvKcI8nu8e+4EeBWJ1g6oFYcgirP0r9Xp4yOCIVczf5CfHGBu3EtQYQd/Lq
 4NWhFTkstn1ziKNn3fKYndbebKTPgWnZXXoomIG/BlfJ6/mBpYv9clSTInKyQSOXbtmf
 ceHg==
X-Gm-Message-State: AOJu0YyktqOt6X3aYCtSf5D0v1p8S3dmR1vnJ+XCC8g3Ar8D/gdKKd57
 G0wEoD8RWh9wmQidn3bZVibTxwInlby6TMnkAuulgMoNnEDqBD6QWBeaXZpzyrnUbgrDcHLq4/f
 jQy3LKA9RZJeM0Sirw5ZgbUqd+mOM5OQ9kgMPbFwfxNMvLy0ak8oxOUEP4V961Rc5axVA
X-Gm-Gg: AR+sD1222waWOTXMr9IotKJFiTJ3LiOfdYZxEY9WB0hy+ppjj3DznO+FxfSwvqj/PhF
 2t9utVd0k8iEJA61bCrgxtFEkmji8tljwq8x/OdeB6p7YYSzqZ84/dFr1CBRq77GRBnDJlCkCUl
 /5MN4A/HJW6KllL0NoZykndEjV9hjDxz3t+LQzJDQieLVqI6tmfnwvCwwtu/MLX1+ruHbkdar6G
 4y0mh/uW0viIN8gXcJpv0hhQvvsYkEVo6h9Uq3XUGwe//Kyj8ILpj3WCVl7cQTztK6rGpq2OH4H
 4SbKRdqPmsaAJOkSxgRf4LTXZXgcQRMYsXjhB+NKbtlRUIR7bRhPd6jVTGm1ib1yQqXsssfOZZH
 Qy/UUNkQ/Zg8ZKVDSf2eSrT30mRHVncBBPWvdWMB6z8fdBZG1WcaH16uVzo0pVJq+SvaBKqNmh1
 xUCekzf4/WPvp71CeTq1cHFSD8aJXBAUFhZ4sSVaGCTzTmtiHSmydee1x5/PqzI6ia3lXkz9FSZ
 vToC5eSZEjxHdt2cRmnmJwgVXVZmU3HwAi9YLGmTz1OjB7hUHSucmg0ELPzW/4+wNKFRVVE/5zw
 8wljfB+VzSk0/6fAxLFDwmNT6VoQP9HnXSnH4CvmQbBvg/qqPpQp85ECcj4Eng==
X-Received: by 2002:a05:600c:a00d:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-499821a1e0emr98662535e9.5.1786639449793; 
 Thu, 13 Aug 2026 09:44:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d1e74sm3061695e9.3.2026.08.13.09.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:44:09 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 16:44:08 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f
X-Gerrit-Change-Number: 1840
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1840?usp=email>
X-Gerrit-Commit: 3568e9d8cca78be9577cb7220d9bb9419894d207
In-Reply-To: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
References: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NDQwODQwMDAwLkkxOTEzYTZlNjRiN2NlMjJiNjZkMjAzNGRmMmEyZmFjMzNmNjBlYTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <581e50823bafcbc9141deec48cf59368854b1021-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuYXQ-0004bz-H9
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
Content-Type: multipart/mixed; boundary="===============7240492964626236729=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7240492964626236729==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U6DDUBD94gY="; charset=UTF-8

--U6DDUBD94gY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has uploaded a ne=
w patch set (#2) to the change originally created by plaisthos=2E ( http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail )

The following approv=
als got outdated and were removed:
Code-Review+2 by plaisthos, Code-Review+=
2 by razvanc


Change subject: OpenSSL: avoid resetting the HMAC key on eve=
ry packet
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

O=
penSSL: avoid resetting the HMAC key on every packet

OpenSSL 3=2E0=2E3 and=
 newer can reinitialize an EVP_MAC HMAC
context with its existing key when =
EVP_MAC_init is called without
parameters=2E Use that path instead of suppl=
ying the digest and key
again on every OpenVPN HMAC reset=2E

Retain the ol=
d parameter-based reset for OpenSSL 3=2E0=2E0 through
3=2E0=2E2, where para=
meterless EVP_MAC reinitialization did not reset
the underlying HMAC implem=
entation=2E

Github: closes OpenVPN/openvpn#1088

Change-Id: I1913a6e64b7ce=
22b66d2034df2a2fac33f60ea9f
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg=
>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Razvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1840
Message-Id: <20260813163239=2E26557-1-gert@greenie=2Emuc=2Ede=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38313=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/crypto_openssl=2Ec
1 file changed, 9 insertions(+), 5 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/40/1840/2

diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/=
crypto_openssl=2Ec
index 1191f20=2E=2E2019280 100644
--- a/src/openvpn/cryp=
to_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -1209,7 +1209,7 @@
 =

     HMAC_Final(ctx, dst, &in_hmac_len);
 }
-#else  /* if OPENSSL_VERSION_=
NUMBER < 0x30000000L */
+#else /* if OPENSSL_VERSION_NUMBER < 0x30000000L *=
/
 hmac_ctx_t *
 hmac_ctx_new(void)
 {
@@ -1275,10 +1275,14 @@
 void
 hmac_=
ctx_reset(hmac_ctx_t *ctx)
 {
-    /* The OpenSSL MAC API lacks a reset met=
hod and passing NULL as params
-     * does not reset it either, so use the=
 params array to reinitialise it the
-     * same way as before */
-    if =
(!EVP_MAC_init(ctx->ctx, NULL, 0, ctx->params))
+    /* OpenSSL 3=2E0=2E3 f=
ixed EVP_MAC reinitialization with an existing key=2E
+     * Older version=
s need the parameters, including the key, to reset=2E */
+#if OPENSSL_VERSI=
ON_NUMBER >=3D 0x30000030L
+    const OSSL_PARAM *params =3D NULL;
+#else
+=
    const OSSL_PARAM *params =3D ctx->params;
+#endif
+    if (!EVP_MAC_ini=
t(ctx->ctx, NULL, 0, params))
     {
         crypto_msg(M_FATAL, "EVP_MAC_=
init failed");
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1840?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f
Gerrit-Change-Number: 1840
G=
errit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvan=
c <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--U6DDUBD94gY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 <strong>uploaded patch set=
 #2</strong> to the change originally created by plaisthos=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+2 by plaisthos, Code-Review+2 by razvanc</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">OpenSSL: avoi=
d resetting the HMAC key on every packet<br><br>OpenSSL 3=2E0=2E3 and newer=
 can reinitialize an EVP_MAC HMAC<br>context with its existing key when EVP=
_MAC_init is called without<br>parameters=2E Use that path instead of suppl=
ying the digest and key<br>again on every OpenVPN HMAC reset=2E<br><br>Reta=
in the old parameter-based reset for OpenSSL 3=2E0=2E0 through<br>3=2E0=2E2=
, where parameterless EVP_MAC reinitialization did not reset<br>the underly=
ing HMAC implementation=2E<br><br>Github: closes OpenVPN/openvpn#1088<br><b=
r>Change-Id: I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840<br>M=
essage-Id: &lt;20260813163239=2E26557-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg38313=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M src/openvpn/crypto_openssl=2Ec<br>1 file changed, 9 insertio=
ns(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/40/1840/2</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>=
index 1191f20=2E=2E2019280 100644</span><br><span>--- a/src/openvpn/crypto_=
openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br>=
<span>@@ -1209,7 +1209,7 @@</span><br><span> </span><br><span>     HMAC_Fin=
al(ctx, dst, &amp;in_hmac_len);</span><br><span> }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#else  /* if OPENSSL_VERSION_NUMBER &lt; 0x300=
00000L */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* i=
f OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><span> hmac_ctx_t *<=
/span><br><span> hmac_ctx_new(void)</span><br><span> {</span><br><span>@@ -=
1275,10 +1275,14 @@</span><br><span> void</span><br><span> hmac_ctx_reset(h=
mac_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* The OpenSSL MAC API lacks a reset method and passing NU=
LL as params</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * do=
es not reset it either, so use the params array to reinitialise it the</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     * same way as before =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!EVP_MAC_in=
it(ctx-&gt;ctx, NULL, 0, ctx-&gt;params))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* OpenSSL 3=2E0=2E3 fixed EVP_MAC reinitializati=
on with an existing key=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * Older versions need the parameters, including the key, to res=
et=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL=
_VERSION_NUMBER &gt;=3D 0x30000030L</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const OSSL_PARAM *params =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const OSSL_PARAM *params =3D ctx-&gt;params;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!EVP_MAC_init(ctx-&gt;ctx, NUL=
L, 0, params))</span><br><span>     {</span><br><span>         crypto_msg(M=
_FATAL, &quot;EVP_MAC_init failed&quot;);</span><br><span>     }</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1840?usp=3Demail">change 1840</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I1913a6e64b7ce22b66d2034df=
2a2fac33f60ea9f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
840 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--U6DDUBD94gY=--


--===============7240492964626236729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7240492964626236729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7240492964626236729==--

