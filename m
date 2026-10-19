Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235BECCF2DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33fBQUfBHEvMoiFhTJy+p0Lxcazu+jTP6j7mhpf1FQY=; b=eeW5qCityayg1psCNNzjjyisVa
	W3clSOjDRviow+waxpGcSJxYIUT2GqprIWKiAQdav411seCIBRg9j7gwJ2M7hC6x/4PZhthaezFB+
	Z1ESduNnu7Y68DS7XocrSfZr/aR7OgWlaoelKWqIH3YEJpG2UagrIid5cLaQ2bJXytBg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xImzL-0004EN-Mc;
	Mon, 19 Oct 2026 13:01:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xImzJ-0004EG-KW
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:01:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QHCEWjCdJVFv4LxGkUZiW8Myt1Eda+54RGloRdxhS7g=; b=MjtdTCnWz+P2CfXFnGQ7VL+GEZ
 WCXQ6GRU+AWU9p/bNmAogotlCU1ImFQfDmSnqdL3ni9GqfgElQ8J5rfzQjZZ0j8UYS6bL73afq9GS
 1ZzZROflmeiCfoxV3PSjsucEgR9ly4Y0KO2BeMvGSgcTClGHZUsstzrVLSJ+khfFREXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QHCEWjCdJVFv4LxGkUZiW8Myt1Eda+54RGloRdxhS7g=; b=Z
 w40lxnbctqnPCU+OHd6gff4qK/r2S54brVy8j57o7jStbO1WVcdqe4QDIPLjDIWS2s6TpmkvKDsUf
 SxZSoSgHTJkx4pPskwlR3CJwT7eiI4xvTVfvYhTvsDxdu7w8EGOw75g1N4l7m2Zo5mV1bBRn9BdfJ
 21TmlAOuUx4g9Pjo=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xImzH-00026Z-NY for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:01:14 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so10941625e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792414865; x=1793019665; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QHCEWjCdJVFv4LxGkUZiW8Myt1Eda+54RGloRdxhS7g=;
 b=FDMGPYhojjAf0/Wd/MiRyY+qXv3Uxt/0Vbs/wqiWJdqzd8GV8VK0iXE+AF6tX5SxU8
 uETWlHHad5Md3QorL0uDKxEe0TD2y8sHMy/WtXuyK4X7+K/KR/iNc7VF7HnWftUVDF8k
 Xqfvg0pHlTmJ2HNKJHCC7eTgzTnie8+mDHnFQ+WdD3dWxlwOtAs4S2d3FQ+93B9kkQTs
 OiU+lZlHD351bH5HL2pOnaA8Czx4OBCAWbQcsZCCk8lU6VS+o+PyEFHyGcnn+x2XyyLS
 pIWkV7Fxx9G14kV32moRQmp1wj8fj7LRHXxwnAu/e+gLfAmyn5gSAmyn/1N40m2frfCa
 BsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414865; x=1793019665;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QHCEWjCdJVFv4LxGkUZiW8Myt1Eda+54RGloRdxhS7g=;
 b=LXYlCfPX8LKomrKtDpw0hBh1oWQDWOMrR1CNWP4dMs3lpwS6wAYeAViDZ8ye4VjGC1
 LX25aJ4KEDowmLzN6lQHDvjiiA4pbKcUjM1K8eVmWOAdZTYyponDZTvfMrQbaoarg1qt
 TZlS3MxWtTvyvUp5Yst/MF8Hvrt8b/gaF3DfZorIIyEK9cG1yugzIKfEQ/7Q9Svjs1uh
 JbzhIBN1iglNcIawewLymZVVXvUenkmhQ+YF6gQmFWiWyYN+OvzrzoBAWi/HjASXowep
 VTG/x/n+5WrLQrup/v5eWEIoGBF7LV7UHHEnRhRiUI/HORCct7HK29kkhSEnPyl4nHO5
 BRjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZNHgUZ9/XOFusQ0RT2Id9b+6zIeTNoFbKkDQc1Ux4mjdCI+mTg2oH1qWPh1erYNzs/fDy3TC16kgWpRQT@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJjVee5ZwW/Sya2Yf9g0QMR8NGrhhRQblLqSkRFK0J9uTmEv2Mu
 9Eof2F5xmTKTrTANgJvwP2BM0SyLEG/g2oCOuGJIW56MBC6JRjqDWCD7waemG/G/8zC6HQ3mYs7
 F/DzUaizElEXOQvQ18xYg7dCRwRqExa82rXWiZ5ilN4cw/36pKIuplbi0elDettnsK4Ml
X-Gm-Gg: AYBFou3pbhWJuWQQN/gvJGrngcjIpUJd4z3EZWKzl5pygpNDtozFa9Tx6zrLaYivGO6
 s0f1yHQRsNpidVWICgBJ+LA2u/7OksgpSiNwD5/PqLCXNdrxBFXmXKb+aE/KOewq/bBFjy6qOCy
 fgUhS0fPxvqLzPKsxqgPjec77XoVGswwza5UUM7sAvYttPwmzcuHUuRcSNddRF3kvtTBfYFebC8
 3DIuejddYkAwkmN9gRETjlmxkbaAj72dfXM4p5cP5GSmIY65pjMeJGkAsJrk47icLxGKNN0MYJh
 XKeaPn9+OeMiznP+CixicSWxocrTXQYjnBER7sLjnWQomwNOzOLMq0R5tTmZmNVymySTAZX2vcC
 I3SE7rOLjR88d3YnyNTKh4Qbf47dpc3iag1BS9TgQHfedbEOp5bv31JJvj0imtsnDgvpbgXTd9D
 3tanU0eDIl5JvaGtPdgAlBEy08GME0GEHeTTQ1myKhVp87O1Q/gtr6OEr2+bQv7f5y0z1SvQj8s
 RxZbeLe2Xht7+1o7ftfpNAH2nTZdexjqku5sC7WDt6Fr7qpNc+hoy0iMPLrDSH+//52uk+4HhR/
 +H7hutdxNSm0JCFRPg9AZpkmJiq6LQtg6GpBTCWoIISFzg8bCa7hiOpdP8J2
X-Received: by 2002:a05:600c:6289:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4a1dadf98d1mr142453575e9.23.1792414864944; 
 Mon, 19 Oct 2026 06:01:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ccc15aa1sm269504535e9.14.2026.10.19.06.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:01:04 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 13:01:01 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1
X-Gerrit-Change-Number: 2006
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2006?usp=email>
X-Gerrit-Commit: 47ac47f50bd439606ad5f28299627c969f1bade2
In-Reply-To: <gerrit.1792255622000.I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1@gerrit.openvpn.net>
References: <gerrit.1792255622000.I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkk3YzU0YWJhNWNlNzcxZmM0YTEwZTRlZmRlN2QxNDcyMWNiY2Q3YmMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c22823b255c0f765fbeee666fc9407f9cfbad4c4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xImzH-00026Z-NY
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto_openssl:
 Avoid conversion warning in hmac_ctx_size (1.1.1 vari...
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3514425577563956396=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3514425577563956396==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/yybMecdIJU="; charset=UTF-8

--/yybMecdIJU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2006?usp=3Demail )

Change subject: crypto_openssl: Avoid conve=
rsion warning in hmac_ctx_size (1=2E1=2E1 variant)
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

crypto_openssl: Avoid conversion warn=
ing in hmac_ctx_size (1=2E1=2E1 variant)

We already have a similar convers=
ion in hmac_ctx_size 3=2E0
variant=2E

Change-Id: I7c54aba5ce771fc4a10e4efd=
e7d14721cbcd7bc1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <=
gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2006
Message-Id: <20261018154358=2E23797-1-gert@greenie=2Emuc=2Ede>
UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg40019=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
M src/openvpn/crypto_openssl=2Ec
1 file changed, 1 insertion(+), 10 deletio=
ns(-)




diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_=
openssl=2Ec
index 29c5fa6=2E=2Ee6abd8f 100644
--- a/src/openvpn/crypto_open=
ssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -1172,21 +1172,12 @@
     H=
MAC_CTX_reset(ctx);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pra=
gma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#en=
dif
-
 int
 hmac_ctx_size(HMAC_CTX *ctx)
 {
-    return HMAC_size(ctx);
+  =
  return (int)HMAC_size(ctx);
 }
 
-#if defined(__GNUC__) || defined(__clan=
g__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 hmac_ctx_reset(HMAC_CTX *=
ctx)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7c54aba5ce7=
71fc4a10e4efde7d14721cbcd7bc1
Gerrit-Change-Number: 2006
Gerrit-PatchSet: 2=

Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--/yybMecdIJU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2006?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">crypto_openssl: Avoid conversion w=
arning in hmac_ctx_size (1=2E1=2E1 variant)<br><br>We already have a simila=
r conversion in hmac_ctx_size 3=2E0<br>variant=2E<br><br>Change-Id: I7c54ab=
a5ce771fc4a10e4efde7d14721cbcd7bc1<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006<br>Message-Id: &l=
t;20261018154358=2E23797-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40019=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/crypto_openssl=2Ec<br>1 file changed, 1 insertion(+), 10 del=
etions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_openssl=2Ec b/sr=
c/openvpn/crypto_openssl=2Ec</span><br><span>index 29c5fa6=2E=2Ee6abd8f 100=
644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</span><br><span>++=
+ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -1172,21 +1172,12 @@<=
/span><br><span>     HMAC_CTX_reset(ctx);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> hmac_ct=
x_size(HMAC_CTX *ctx)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return HMAC_size(ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return (int)HMAC_size(ctx);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> void</span><br><span> hmac_ctx_reset(HMAC_CTX *=
ctx)</span><br><span> {</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006?usp=3Demail">change 2006</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c54aba5ce77=
1fc4a10e4efde7d14721cbcd7bc1 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2006 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body><=
/html>
--/yybMecdIJU=--


--===============3514425577563956396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3514425577563956396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3514425577563956396==--

