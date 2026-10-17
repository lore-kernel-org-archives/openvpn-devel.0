Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FD5CCF2CA
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4J6LPm6UPRkEolUjZkJPsJnY/NmM4foteNhrYCLoDWM=; b=XnelRUtSwbwrrv
	/3IM/3g9qxT7nztCuxDr7FMNeYKArrkpT4tPpU9oHKw9qon4th2VOOKsX7Fb6oT05qBbaE9H6padu
	kxpd5Fq6W1tE+p9s5CRAZ/MdtEKgeEt2JH1wwxZ/9Dtv+EIq3bfhRvJ68SvQk3mGlhiFqSOB+32DS
	sNo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7Z9-00081M-2V;
	Sat, 17 Oct 2026 16:47:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI7Z7-000810-5O
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xX65dSNsmjDVWeeLYkAgq/xbtsD7GrK7p8tUQ+6IiyY=; b=MT4j6/6xcAgYKoCj29KN3x+nKf
 7obrBHzX6cJsnSs8K7eI2q9Jfb8y4zESAmFrHpXfUUxakjP14WVJpz6cegAR6T5/KNQV+auPDPWt6
 urzmwQ0uu5ILpB5GsIs/rX6wejh6QAIkqWz6RNWuXJ85zjbClAENB7/KLsSfzuxmJXpY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xX65dSNsmjDVWeeLYkAgq/xbtsD7GrK7p8tUQ+6IiyY=; b=L
 4pabyzFBILtiM3jUj3sLUGDkFEpip1WJ9dUR48SCcV3IfE45i3Z4/5vOeTstxTArbJMgUU8Khw6vc
 hompOUQ6VuTFh0MC4WjMQCt/Rjw5tNWa0gLhRpVwwF7XvP/yfh5hUMqsNaqU7Tb45ms5DnqA3hZZP
 zsNBxk1cpz2yxnfw=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI7Z6-00068x-EY for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:25 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso12051415e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792255638; x=1792860438; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xX65dSNsmjDVWeeLYkAgq/xbtsD7GrK7p8tUQ+6IiyY=;
 b=AYX36hNWcC9f9wp6l2Lhtbz7Pzbh14ad/UKsnSXuvafudI6Qbwu+pO1eoOuII20bHh
 YWPdI32U7B/RS96ykv2SWCZVEvIWnRG45z4/sRW8Il3WDBfo9G7i/KJ3mUTSzsNCTSK6
 nOQ1clpwz0AoOymgpv3FaARWc1RtIKz/rKGR0oASdMsGL5ZAIXzi1K0aP0rMoPSgxHTA
 oz9oNNoLcDd1N9Yzw98rrtKLOX7J1oXJdcDeKS4BEyNH4ICmmTXP4bYVe03c5awF7au5
 9W6Mi9rExlEqn8Lq2yelqgvzV9a6/yhsWIx6azBQUoHUgH6KeUJmPCkXShAFSyrLrA0g
 JCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792255638; x=1792860438;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xX65dSNsmjDVWeeLYkAgq/xbtsD7GrK7p8tUQ+6IiyY=;
 b=Y1ucB+3Xnf6KZqy1vXe8EbimhB2Vsg3Dovl2h7oRstKqBGoENCQidh24cZaNKrlUli
 xTql6jIeyf7wEFR9jb8uvqOS1CppOFE1LMcYLUgrGDfUr+KZjC/9cB911BA01Qy7lRmC
 +6jcz7i20Te4HzqCRHho0g73BTo0q+WeTr0Abd7H8dRWYKN8dwfvjhwneSrh6GGkxDg1
 Z/sUs2M2RxjsvBMmJJ9/zDzPBjr8mxIqmc94jExVdLkCvLeasMi+cVY3GyeZGQsVChS1
 qUs67p1mvxXpEF11+2X3GTuQkwQiw7GyOpUf8xisd7dPjb0JotkEmzkI79TIXM2dTrvr
 hyuA==
X-Gm-Message-State: AFq9FYIYCsLMZxoq0D8LMW56rKAXGpZIMT2F2O3lakbvDUp1ACWsM4bu
 KsTgKUC05LZFgXdQpxp41BbsRBYx+0gR/wsK0RupM+wrFT+xZLDvdX3bSYdz+bm7VZN5QuTpAuC
 3GxOqwX8fv8vxXsya7HgwPJKWPlhkc3OIoi4bwIUYGSlDsLTX8qLPhdPh8cXE8kU0xoVs
X-Gm-Gg: AYBFou3l84Ud9+6WenpIBQhR73cLCRII/TyWEEZwbvVkpuEaOYux3UAUXxHVr1GYC/m
 /Ss5OyBTrGDqJX6mxt7CjFAJybVC1IN7++Fuw+Yp6Nn6t7Q3xb+8p3n+2+qt5bJSlCaX96yinZ/
 CZVcCHdzoLlHk5yJ/aZ6aJtKWxP4e0FJa0XTSkyquDK2IbwlCU5foXz8pnHYd7daVZugUuuMaT6
 BXHElP38n1mJqBMpkxf8HLV2grqgwsMXcR8JtUdWsPUIjMT/G3djX8SOKQFCxK3gG6J8eCgf+2S
 qMYXfDSoB2wSV/V83T+mSg3LyN2ooMzo4I1Wf4LOVAaMiFAvPBZz4hS2mlgHNTXz3cWme/zP6wp
 lfqOldv4JdjFdTBbzXgcFwO0lq51JK1EDnR3U9IWTe8MHS/b+k7QDZbdayejYHy9uo6D49S9UCU
 /FotSoXnI550ywRT+YOxhcqYsRBG1e1buxe28qpb90jADaMJ1zbpU8erBTq+CWZSfTk+KFevOcY
 YxrRrOLwpVR9QgnkZxPugIbfYRJLf798TLmuSq0cVdUOP3Y4ziGVpbJtk3C1DJBGvRHfi/EIR4F
 okAm5nyMAayMYPnS6wf5RJO7isOKmPMoCo6Dcb387y2RWe/+g4/QWY2aeXZF
X-Received: by 2002:a05:600c:468e:b0:49f:ffa2:1c72 with SMTP id
 5b1f17b1804b1-4a1d7605110mr65938225e9.11.1792255637613; 
 Sat, 17 Oct 2026 09:47:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a81587sm279435565e9.1.2026.10.17.09.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 09:47:16 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 16:47:16 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iae70a03c2bcc502f62133abcbfd1c92528e65d69
X-Gerrit-Change-Number: 2007
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2007?usp=email>
X-Gerrit-Commit: 553c977228962fae2adc092785bcbfef4d9e8438
References: <gerrit.1792255622000.Iae70a03c2bcc502f62133abcbfd1c92528e65d69@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLklhZTcwYTAzYzJiY2M1MDJmNjIxMzNhYmNiZmQxYzkyNTI4ZTY1ZDY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <32eae781fe807c151e2772f02d2b857479b7d2b1-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI7Z6-00068x-EY
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify_mbedtls:
 Avoid conversion warning in x509_get_fingerprint
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
Content-Type: multipart/mixed; boundary="===============5802362383231159323=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5802362383231159323==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yz+0vEdLf3g="; charset=UTF-8

--yz+0vEdLf3g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2007?usp=3Demail

to review the following change=2E
=


Change subject: ssl_verify_mbedtls: Avoid conversion warning in x509_get_=
fingerprint
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

s=
sl_verify_mbedtls: Avoid conversion warning in x509_get_fingerprint

We alr=
eady convert mbedtls_md_get_size to int in other
places, so just use that h=
ere was well=2E

Change-Id: Iae70a03c2bcc502f62133abcbfd1c92528e65d69
Signe=
d-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/ssl=
_verify_mbedtls=2Ec
1 file changed, 1 insertion(+), 10 deletions(-)



  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/07/2007/1

d=
iff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbe=
dtls=2Ec
index b9a36a6=2E=2E6680ccc 100644
--- a/src/openvpn/ssl_verify_mbe=
dtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -542,25 +542,16 @@
   =
  return FAILURE;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragm=
a GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endi=
f
-
 static struct buffer
 x509_get_fingerprint(const mbedtls_md_info_t *md=
_info, mbedtls_x509_crt *cert, struct gc_arena *gc)
 {
     const size_t md=
_size =3D mbedtls_md_get_size(md_info);
     struct buffer fingerprint =3D =
alloc_buf_gc(md_size, gc);
     mbedtls_md(md_info, cert->raw=2Ep, cert->ra=
w=2Elen, BPTR(&fingerprint));
-    ASSERT(buf_inc_len(&fingerprint, md_size=
));
+    ASSERT(buf_inc_len(&fingerprint, (int)md_size));
     return finge=
rprint;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diag=
nostic pop
-#endif
-
 struct buffer
 x509_get_sha1_fingerprint(mbedtls_x509=
_crt *cert, struct gc_arena *gc)
 {

-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2007?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: Iae70a03c2bcc502f62133abcbfd1c92528e65d69
Gerrit-Change-=
Number: 2007
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--yz+0vEdLf3g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">ssl_verify_mbedtls: Avoid conversion warning in x509_get_f=
ingerprint<br><br>We already convert mbedtls_md_get_size to int in other<br=
>places, so just use that here was well=2E<br><br>Change-Id: Iae70a03c2bcc5=
02f62133abcbfd1c92528e65d69<br>Signed-off-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>1 fi=
le changed, 1 insertion(+), 10 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/07/2007/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verif=
y_mbedtls=2Ec</span><br><span>index b9a36a6=2E=2E6680ccc 100644</span><br><=
span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -542,25 +542,16 @@</span><br=
><span>     return FAILURE;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static struct buffer</span><br><span> x5=
09_get_fingerprint(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *cert=
, struct gc_arena *gc)</span><br><span> {</span><br><span>     const size_t=
 md_size =3D mbedtls_md_get_size(md_info);</span><br><span>     struct buff=
er fingerprint =3D alloc_buf_gc(md_size, gc);</span><br><span>     mbedtls_=
md(md_info, cert-&gt;raw=2Ep, cert-&gt;raw=2Elen, BPTR(&amp;fingerprint));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_inc_len=
(&amp;fingerprint, md_size));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(buf_inc_len(&amp;fingerprint, (int)md_size));</span><b=
r><span>     return fingerprint;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> struct buffer</span><br><span> x509_get_sha1_fingerprint(mbedtls_x509_cr=
t *cert, struct gc_arena *gc)</span><br><span> {</span><br></pre><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2007?usp=3Dem=
ail">change 2007</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2007?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Iae70a03c2bcc502f62133abcbfd1c92528e65d69 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2007 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bo=
dy></html>
--yz+0vEdLf3g=--


--===============5802362383231159323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5802362383231159323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5802362383231159323==--

