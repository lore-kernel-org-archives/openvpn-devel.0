Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE09CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=jW0Cvj8I3BR0hw+Ip35Ad6G+jGPJvRy+1niztCjOOTg=; b=ApvPZLYir//OhO
	QpV2rAd+e4c77j/UvVRKmj/jHiVBXWk0OqPvcIlrJPD3zPpS0byeit8bxsro0Sm4BdtriW1Wq9ed/
	7zqB2nDWNg1viNWaPt09F0w7u2QcYQiJj9ltOAdWTt5I0dpPEp2byCMCsiqFZT2qHSWRCHC2zBBS/
	ofs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7Z6-0001Uw-Lw;
	Sat, 17 Oct 2026 16:47:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI7Z4-0001Ug-UM
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k12k8kstaSvsXGVA4S8lrCXhAFzWJYOJdBrKqsqEtDU=; b=CYRc4H9D8sESF+pyQ7W4EAfZTD
 noLgnckKuBlqcAO2An1B6eM9NSEF0eDZHBZlw6D1MiT4JI7kJApyYoJz8AzavDLFP0aXCUiEZ4meY
 PwiXbh+hcE4MhA5MiPXEKZKF3FVehFj4DFjBy2PPtkL7XGHA3z3FoBL9QK2KeG4bHfSY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k12k8kstaSvsXGVA4S8lrCXhAFzWJYOJdBrKqsqEtDU=; b=e
 cT7qwQHZ+5RTjdOnOIREgxwMjDJIOTWzun2kcoA+aXn4ELtzs9KQfKhITkq+GQrhNVWb0JeJnbVtP
 14Qovj/0mdRru6RG9aaGsSw6K/9lUlfbvZiYKA2c+1nWUD6uECYIb3Zpvgvi62eEYW0XhCPdr16lZ
 DC1oYQV3YYusl4bo=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI7Z5-00068v-1b for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:23 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso636661f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792255636; x=1792860436; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k12k8kstaSvsXGVA4S8lrCXhAFzWJYOJdBrKqsqEtDU=;
 b=WTW/FOZo75pv8fmTzVJ7pfvQ3y5SOTU1tE+389bOKMsvwYKa049fSvQXCHiPpFdIDn
 /u0j5/JIlgEp3br/1yZCQDZySIkepBRe9Y8WiY91oiGUdoyCq1jsS97VglqBC/zFsB+x
 Vsz1RBteR8460qarfyjsLQfAtxHW/lIZgiDojrPKr3GA7YBw0bXacYeRZioQU5I/w7hh
 gWx2jPxDTZpfKLgc+RswYlrwo2H7inpy5XrjHaxikKcWUKr2m5QuqE0AODQ3JsDyIIwP
 J1ll3HF2zvZcidUVcRcJcf1H4EvgnaomVNgUNBsCBe95PsJ3vdCSDDm/yhDijTgkW4ox
 X+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792255636; x=1792860436;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k12k8kstaSvsXGVA4S8lrCXhAFzWJYOJdBrKqsqEtDU=;
 b=TmSShhedoXUXfQnT+MUvZHvavCamed4Ju2ItdybVb5ZFHH2qQ5yrBcttSEWno25g17
 msnPJxLUjRrMexaQZRRpIsAkWKkFe2picE/kxzVHvqA7It5oVWzZDj8Y0fmJ7y710ul8
 9k8HdBbCLjwkNWEWPIHd8YVxNPd9ng72rLnQvcTPmFdIYVgmmS+TITPtU0Ka8s5ggwL5
 IFNnZ1P6r/4VJp239DW24ObwT+FnMuatHFe61ZGep9IbrXmnIjYWUYoNBYQbfS5rQq2X
 1jOMJGfEsDqrc72nh/1JWpWq7g8hVvDM+KLSI/uLM++Vu4iUFTCBo5E3A7AW1rVVChiZ
 AiHw==
X-Gm-Message-State: AFq9FYJSwhav1Jo22bw3vwRkWqKRnN8ncNRYhOEJlychGaIFC4h6xuN7
 fuX6aoBXeVxgU68gGdyxgGLWe4fBuLvBqd4Or5YEUcJfFIYnicuOnAqkXbofG35uK38pOSpg5Yt
 frfkkHuYDj+qab++l19D746lvROGK6FEtSXcBdUHHNNafJveYmmizQFCLkzrPMS4f20E/SXTZUl
 aJuCxc/g==
X-Gm-Gg: AYBFou1YSYpaVs53RptlkBQqGSwO7+CeRAy1osre7T+ebC8+musYLBNZakHduFAmJsr
 gbzkXBWHqCUlttd8bM14gEaCAgdCZ5C6JpYg63esZ4WrR1VtgjqbYC+aTiaRFBUqpohbS89zdYv
 wk9ye3ssV2TRNYD52CxIOXIOXZ7nJOMpArGgWG3XxquT7x/GMPD8w+UGF/F/I2jlM75yB6M6pSy
 L03R7Baq+ol6+ugz26V9RYDOVNWsjP2GEa9DCHQIHo+oaPFr/GynBrtTrifuxxtDS62iZLn6uSS
 IZB32/lhdU+orONXmDlmvYD0tiNXL8ppYGI/uwzH/QgRnMdmqMiYsypEFBdGCYyjgVXc9cr5Xo3
 hgH08WN5OlfsdSP2ZAndbIyOAUsKuQAf3qud72gO84rG7phzu5vUyMS0TO3G4iAWy+bPdUJCawQ
 L85Bc5OFj8LuozWw5GV+SLdArnrOFrtMpW1/Ti+8NiEPi8ACiOg+rRyPPNx0FX0wX3ZovAVE+jR
 SHmUHtRl9Qs4viwbPGWjOPO7lyeTY3n1RGKrnFpTbkIWzIuzL4kE4HQMlwPur9VGFGVDGG5xL39
 scGMxmIpB7o9UrpzS9ECMZg7wMywPfs3qhwA8pK04XugKF6SAPI6y07Jdaz2
X-Received: by 2002:a05:6000:29d2:b0:48d:ff71:dd97 with SMTP id
 ffacd0b85a97d-48e07975c0emr3585342f8f.7.1792255636358; 
 Sat, 17 Oct 2026 09:47:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c4fc4sm10704900f8f.15.2026.10.17.09.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 09:47:15 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 16:47:15 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1
X-Gerrit-Change-Number: 2006
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2006?usp=email>
X-Gerrit-Commit: 57d2a152f6e2206e41471deb040580e6f27fe1d3
References: <gerrit.1792255622000.I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkk3YzU0YWJhNWNlNzcxZmM0YTEwZTRlZmRlN2QxNDcyMWNiY2Q3YmMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d9f49be062b88e5572a91d91607012efcbbd78d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI7Z5-00068v-1b
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1850873538860249600=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1850873538860249600==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d6oAlOZ1r5A="; charset=UTF-8

--d6oAlOZ1r5A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2006?usp=3Demail

to review the following change=2E
=


Change subject: crypto_openssl: Avoid conversion warning in hmac_ctx_size=
 (1=2E1=2E1 variant)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

crypto_openssl: Avoid conversion warning in hmac_ctx_size (1=2E1=2E=
1 variant)

We already have a similar conversion in hmac_ctx_size 3=2E0
var=
iant=2E

Change-Id: I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1
Signed-off-by=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/crypto_open=
ssl=2Ec
1 file changed, 1 insertion(+), 10 deletions(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/06/2006/1

diff --git a/=
src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index 29c5f=
a6=2E=2Ee6abd8f 100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openv=
pn/crypto_openssl=2Ec
@@ -1172,21 +1172,12 @@
     HMAC_CTX_reset(ctx);
 }
=
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push=

-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 hmac_ctx_si=
ze(HMAC_CTX *ctx)
 {
-    return HMAC_size(ctx);
+    return (int)HMAC_size=
(ctx);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagn=
ostic pop
-#endif
-
 void
 hmac_ctx_reset(HMAC_CTX *ctx)
 {

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I7c54aba5ce771fc4a10e4efde7d1472=
1cbcd7bc1
Gerrit-Change-Number: 2006
Gerrit-PatchSet: 1
Gerrit-Owner: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--d6oAlOZ1r5A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">crypto_openssl: Avoid conversion warning in hmac_ctx_size =
(1=2E1=2E1 variant)<br><br>We already have a similar conversion in hmac_ctx=
_size 3=2E0<br>variant=2E<br><br>Change-Id: I7c54aba5ce771fc4a10e4efde7d147=
21cbcd7bc1<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt;<br>---<br>M src/openvpn/crypto_openssl=2Ec<br>1 file changed, 1 inserti=
on(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/06/2006/1</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span=
>index 29c5fa6=2E=2Ee6abd8f 100644</span><br><span>--- a/src/openvpn/crypto=
_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br=
><span>@@ -1172,21 +1172,12 @@</span><br><span>     HMAC_CTX_reset(ctx);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &qu=
ot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> int</span><br><span> hmac_ctx_size(HMAC_CTX *ctx)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return HMAC_size(ctx)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int)HM=
AC_size(ctx);</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic p=
op</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><=
span> hmac_ctx_reset(HMAC_CTX *ctx)</span><br><span> {</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006?us=
p=3Demail">change 2006</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2006?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2006 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--d6oAlOZ1r5A=--


--===============1850873538860249600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1850873538860249600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1850873538860249600==--

