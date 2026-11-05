Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B98606A31B
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Se6HRim2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NhS0JwEf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lXP1Q84q;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OxO8M7cN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8EPDChKLFhOk52gJhYk/BMnXCgI1bR2syaBA9rO5Obg=; b=Se6HRim2ZeieGIhANveXTWCjts
	yEoNY3yO8kt8TFtaxJJ9nEGjfb2P3LjtiJiFbcASlm47dEOYv1d9whPPcHDP/Kcq9nrJFiyyQyanf
	tDwMRRahCJVyxanHz0BzNblO9nVinrIV3hVMmy1uan9RfoAcPilbMYou5YQQGUjp/Qy8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP0sK-000000006s1-0cIT;
	Thu, 05 Nov 2026 17:03:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP0sI-000000006rt-2Nar
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:03:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8HSMOcGZ8ke40DTqnfzvl9fUMFZLd/LxLw3muQx0A+I=; b=NhS0JwEfv1pRXNIh4zfHBpqQps
 dW7tIJLwIr3+WAALRRSrEcjNnTkFb61kNQutk3llzQbHBRCv9/b4anh9KuYHQrRUpiaFG7zzb/Mmk
 Wx/9+9uee4nr5lxKwJlzbm5WBaa7ixCmqaSWV+N4W90rCGT+QEgzS1GYJtz5qot7nnMU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8HSMOcGZ8ke40DTqnfzvl9fUMFZLd/LxLw3muQx0A+I=; b=lXP1Q84qH0xTYEL+eGcvG/xcWq
 4qoxYot8v2ezu24v9Uj/QGw13AGl/dNoMjtu87zeDmRmOUSdymVk3scWa+FHKmJO7FSktkthlPxCV
 8Oe7MYqIAM7Sy8b/oePkXkWhof9M12/LUvB7VtC2Vfw1KT4yG3GZx3o84r1VKSkB4A2k=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP0sG-000000002AE-3ocP for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:03:42 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so655749f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793898214; x=1794503014; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8HSMOcGZ8ke40DTqnfzvl9fUMFZLd/LxLw3muQx0A+I=;
 b=OxO8M7cNhM/m4uHA4BQkqHyOlu56PufApUec1sjFEwcuWpGbmXyMP6A+7cdYwHSukT
 531/MQflz5yj/CK6Kg6C/7QduE0FaXe3AcDKO2HVPFqDevADv5Fen+ZRHOI2qMwKngXv
 Ds3/B8lWQFDMNjs+9P/MTgrMAUOsro+2raIvQKkSoImkfHiD2ySNbEH4zy8BTAKbxaj5
 1suvJptQf6tb2AkkHjXXXW4tWTCz+LjcSvx4P4gxUcSC2WXyRJwJ05/IcktM/Mn5/9JQ
 3tB/v3YPt5APjXGMjl5a+fxZd9vZFhUskpKKcOhBVmgfvTflSrsg2DVfudvg750vMr8C
 O6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793898214; x=1794503014;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8HSMOcGZ8ke40DTqnfzvl9fUMFZLd/LxLw3muQx0A+I=;
 b=yFQOMo2ijg91QlnSCE+NDkiyuIgG7EKPXfHwUf824mm2QOBMNQZHZ55OVZvnsFKoKJ
 TOZv5CuN/RkXtjz/R+qXMjNFHUkaqk4JfKjBhPDWG5YDIz1duxMkjgv17yg8wPMXqkJe
 SOOPew+9f2q9XCV3YmAGE+/i+k7nBL04w1wDqwTUzO+P+mFfIODipEUzajoPF7d1CPeQ
 LQD8cvdQUUOYorJL4/uePDaNigphIinHElEDTS1HWclQx0a7QQkCcOYOl5dQugh0mgUT
 aWUFmoS5Ygrw3esa6PY07LMtkRjv24aN2kIn6ure8dVSbrDGB3u28t2XVJAqbvWcIZ2C
 2Dmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz38syFzzABx4S/93rTe4AIzUgZ9ksHzkA6PNssXR7EivhCUCm6xPgIDBgyDPkRVIlItdcyg9+afsbO2HP6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/EqSRfqRpFKQ13h2cbmDaZX7VPwQV3UGZPdQQ3933lc56U0buT
 kTM761JxHr39eMiexBWQBnVO+FhAW/UX1xJDrzfK2KgJkzoXUopEdDxfrUUPEqbN/7EcJU/vYEy
 hkir0gQ4YFqUiaShhfOcRXVx25MbL/eczMuu4JvocXVcZJNl6qM+PW88IwMSvuwHayaSe
X-Gm-Gg: AYBFou2unbL66IR3DItFnlZRcVgst4H8su5DHo3DvzgpwniajstaIhlrzoly8uIA/vT
 dL7fiIBopmRpYYt85c/vhPQVSiriotcQQ5Daa/rolFN8PHYMWnifJMitXPor8xr2QfMrT8D6/hw
 wok2cPawLUBi0adlBAhMayMBOq+GWK5kUcEdwdT8eto75e1p8ZH0xR644IVYGWXVh2YTaAqcGpN
 3cevz/CQd8ImFLvZ3hISFb/9yx6etptTg4NGpGutdReSb5oZq31fV/Es/RQunLTkb8r9T2kFu1J
 4PZWd3GYmQ9qo7VpzSSSC6Xxf5Xq2yVfxkVBLyZaRLRpdYEl/+Tpy31TObgASXPbxhiyUyFutnC
 pJqc6s5RNwr4RX7su62sBAMxveK6mqCJdHq4Uw6GIrV5U6PqjkoF04X2KLeY+l1TewdtiuCwm/p
 hMWqfBPc00JQa+2HvPDrqWKAZ31T3eglM5xujYTdFiEJx9/fXoQG2jQdzYFA9qEjd+RrKL93o3X
 o0I9RCITr/wHWju545iEA8bzcH4r+ZnxfPXaNqUx5bAI7SR+OBlyiUc07msFR+EZRnMV8g6R+yA
 WazWWyxDPfR5QI6z25lK7cuPJjd7HQPrQvOWbbcU/WJGmqOkm1NZsVJAa1BVEopvk4kQsSC8ZHK
 7DpAG69De7cFXSYacVrsZkNdJvUWQICSphrRyuA2lr6OM4g0WXOGPT6UArI23wyk3SqMqMJ0jxy
 1uM2T51//xbVQ/FIpSU6AIsuOlpF820GuADh0=
X-Received: by 2002:a05:600c:3b04:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4b55d8cfdbbmr55591075e9.12.1793898213565; 
 Thu, 05 Nov 2026 09:03:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b57373f7f1sm89266965e9.15.2026.11.05.09.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:03:32 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 17:03:32 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic4243377c96a3b460d69050386cddcb30535de27
X-Gerrit-Change-Number: 2078
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2078?usp=email>
X-Gerrit-Commit: 09fd5ac8e4f679a58b02ed2f883ebf4a4d7205a7
In-Reply-To: <gerrit.1793580377000.Ic4243377c96a3b460d69050386cddcb30535de27@gerrit.openvpn.net>
References: <gerrit.1793580377000.Ic4243377c96a3b460d69050386cddcb30535de27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNTgwMzc3MDAwLkljNDI0MzM3N2M5NmEzYjQ2MGQ2OTA1MDM4NmNkZGNiMzA1MzVkZTI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36c720a995e1ab7cedf5fb2e883df9a7c53abbf3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP0sG-000000002AE-3ocP
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: Wipe the
 struct key_parameters copies after use
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6303934451362535432=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6303934451362535432==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XDFrt5OMs6k="; charset=UTF-8

--XDFrt5OMs6k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2078?usp=3Demail )

Change subject: crypto: Wipe the struct key=
_parameters copies after use
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

crypto: Wipe the struct key_parameters copies after use

i=
nit_key_ctx_bi() and tls_crypt_v2_init_server_key() convert the key
into a =
struct key_parameters on the stack and return without clearing
it=2E init_k=
ey_ctx_bi() sets up the data channel keys (when epoch keys
are not used), t=
ls-auth, tls-crypt and static keys, so the cipher and
HMAC keys stay on the=
 stack after every key setup=2E
epoch_init_send_key() and epoch_init_recv_k=
ey() already clear their
struct key_parameters after use; do the same in th=
ese two places=2E

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: Ic42=
43377c96a3b460d69050386cddcb30535de27
Signed-off-by: Hansaem Wi <hansaemw@g=
mail=2Ecom>
Acked-by: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078
Message-Id: <20261105093736=2E1=
1814-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg40749=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/crypto=2Ec
M src/openvpn/tl=
s_crypt=2Ec
2 files changed, 4 insertions(+), 0 deletions(-)




diff --git=
 a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 2d91c60=2E=2Ef5e59=
04 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -107=
5,6 +1075,9 @@
     init_key_bi_ctx_send(&ctx->encrypt, &send_key, kt, name=
);
     init_key_bi_ctx_recv(&ctx->decrypt, &recv_key, kt, name);
     ctx-=
>initialized =3D true;
+
+    secure_memzero(&send_key, sizeof(send_key));
=
+    secure_memzero(&recv_key, sizeof(recv_key));
 }
 
 void
diff --git a/s=
rc/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 99e2411=2E=2Ed66=
b96d 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec=

@@ -356,6 +356,7 @@
 
     init_key_ctx(key_ctx, &srv_key_params, &kt, enc=
rypt, "tls-crypt-v2 server key");
     secure_memzero(&srv_key, sizeof(srv_=
key));
+    secure_memzero(&srv_key_params, sizeof(srv_key_params));
 }
 
 =
static bool

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2078?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merg=
ed
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic424337=
7c96a3b460d69050386cddcb30535de27
Gerrit-Change-Number: 2078
Gerrit-PatchSe=
t: 2
Gerrit-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Steffan Karger <steff=
an@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--XDFrt5OMs6k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2078?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">crypto: Wipe the struct key_parame=
ters copies after use<br><br>init_key_ctx_bi() and tls_crypt_v2_init_server=
_key() convert the key<br>into a struct key_parameters on the stack and ret=
urn without clearing<br>it=2E init_key_ctx_bi() sets up the data channel ke=
ys (when epoch keys<br>are not used), tls-auth, tls-crypt and static keys, =
so the cipher and<br>HMAC keys stay on the stack after every key setup=2E<b=
r>epoch_init_send_key() and epoch_init_recv_key() already clear their<br>st=
ruct key_parameters after use; do the same in these two places=2E<br><br>As=
sisted-by: Claude Code:claude-opus-5-5<br>Change-Id: Ic4243377c96a3b460d690=
50386cddcb30535de27<br>Signed-off-by: Hansaem Wi &lt;hansaemw@gmail=2Ecom&g=
t;<br>Acked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078<br>Message-Id: &lt;202611050=
93736=2E11814-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40749=2Ehtml<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openv=
pn/crypto=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>2 files changed, 4 insertio=
ns(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto=2Ec =
b/src/openvpn/crypto=2Ec</span><br><span>index 2d91c60=2E=2Ef5e5904 100644<=
/span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/open=
vpn/crypto=2Ec</span><br><span>@@ -1075,6 +1075,9 @@</span><br><span>     i=
nit_key_bi_ctx_send(&amp;ctx-&gt;encrypt, &amp;send_key, kt, name);</span><=
br><span>     init_key_bi_ctx_recv(&amp;ctx-&gt;decrypt, &amp;recv_key, kt,=
 name);</span><br><span>     ctx-&gt;initialized =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    secure_memzero(&amp;send_key, sizeof(send_key));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&am=
p;recv_key, sizeof(recv_key));</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src=
/openvpn/tls_crypt=2Ec</span><br><span>index 99e2411=2E=2Ed66b96d 100644</s=
pan><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/ope=
nvpn/tls_crypt=2Ec</span><br><span>@@ -356,6 +356,7 @@</span><br><span> </s=
pan><br><span>     init_key_ctx(key_ctx, &amp;srv_key_params, &amp;kt, encr=
ypt, &quot;tls-crypt-v2 server key&quot;);</span><br><span>     secure_memz=
ero(&amp;srv_key, sizeof(srv_key));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    secure_memzero(&amp;srv_key_params, sizeof(srv_key_para=
ms));</span><br><span> }</span><br><span> </span><br><span> static bool</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2078?usp=3Demail">change 2078</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2078?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ic4243377c96a3b460d69050386cddcb30535d=
e27 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2078 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan K=
arger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--XDFrt5OMs6k=--


--===============6303934451362535432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6303934451362535432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6303934451362535432==--

