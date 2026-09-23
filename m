Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E58C982FA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h+FrCC8GssE9SLiH0i1uNbKg4c5EnNaB4iw18wpkmW0=; b=LHRfdl+R0qKXFwgm1XNsXq+iZK
	+pyRKCmu9MxKT64zKhHVw4jJsmYutdtl/t/P5XBjFi9MBbyaBhhNpIYokfFVi9YxXLHroqwMsRYGH
	GbhmFRgdQDkglpNXnkLsNOc5N9QT04jQeLaF3PoyrRiFQHLuL+yL8BiiU4rdHt+G+XGs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9J5A-0000KR-6C;
	Wed, 23 Sep 2026 09:16:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9J4q-0000Jg-U9
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:15:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GJp08W0D0R72VKU6QXI9fXx9heZJ3YIvUnUM89CbGWk=; b=BQhouIYOrsuFmbFXKRsWx98419
 H17N/QMXGKtOl3DLL8JWBLFBqLBsOobUag7q6mKgEeizQtZ88ix3gfx6HQtDNoYZH8RW2+Oed/xV8
 J4S+mreQTALgYP3iekOzMZnI08lHknqI7Ae228DM3moHmsCKfD1cSR0FywqIfjiz5FtQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GJp08W0D0R72VKU6QXI9fXx9heZJ3YIvUnUM89CbGWk=; b=Y
 +pUYLcUNMr1XxAtKZb9fpo0u1r6W3xvZStxWPcW2pul5kQRiO67DoRO8nG9JnEmc80ULwN1s9Cj/L
 5DwFzgHa84g2dHq8nY1zMitW/+92C9wNVlnJpmeEKgVQ2uDj/byNjxVLgvXDTCqMc9nFCrTX3rOAa
 DdiPg1BKmgvy/N0g=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9J4c-0004Qc-9e for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:15:32 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so4208435e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790154924; x=1790759724; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GJp08W0D0R72VKU6QXI9fXx9heZJ3YIvUnUM89CbGWk=;
 b=SdivEn/oGpPTEW+5eHxaUhsyU6MppZFNsFspHSA7IluDsWxINLx+arNj4OJaXe84OA
 TFY6MLWNvxKX3L1bd+9pkxjTYRu64cqKeGCQ7g900t7el+TciklS7uvUpC7kwH3vBBRO
 E3mfh/TDE2jd/OD/EOKwC9mYosEGgFzm77zjbmjCuNnUdR3tHYlrG3LNpRfpQodr1dSs
 qIyfPOiG4P/fpdmsmglaIDJfowY6QhhM9znqply3cwkqhut0xR21iBaqWoB8e0PAGW+y
 50c207gTQO2P9i6D1HRV0C1eAyPK9Cdrfz9cZUKCuh5w5u25YBREu0j7b+OovlDFMWLL
 i63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790154924; x=1790759724;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GJp08W0D0R72VKU6QXI9fXx9heZJ3YIvUnUM89CbGWk=;
 b=emZ28BWm0zoKy4wuJAGZJUtJI/xhQCFAgeE0XBDuAK8Zz3FqMhSwh3nhIy/Nt4Prob
 6pIFzAbdhEOoYV7vMrhq5I7X5VY1NxpCr3TN3ku40sAM3tRkijyLy7En5Y6aNZLJ6cqJ
 GlpezuVf8UsoG3BVwIURpeR9/Pz1HFo2xD6y1UmUiPtASG8TP4Voat8hP51/lPZTkIYV
 13LLOxW3Pr9dW4xV+bmNN8QMN15UAP5N6qIsNBW07vc5JzHOb1n/cfuq4z8PmlmbPVnb
 t6OSJmFzIo8th64GGa2apn0ef2c87gQgvsLmC9/Zs3Pj4Z3YaudYCKuL6TMPqw/ywW7n
 jUmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLFd39E2Dsi9O7dNyiXfSKThS72lp3ZLZ5/7fxJRFtXZD5X30jT6z1r2bi8auolWO7bThnIEpeltki7UiB@lists.sourceforge.net
X-Gm-Message-State: AFuF++kLSQ6UozaNFIWT0AcbxKdRMHQRkq+iRH4p0jTgi7TTyyBGmmX3
 +z8bVcPhgprg1ccgSvTxhbVUvpQ1i9/QNHsIcR7dziPdU4GtEAGqTwJ7xrR+NbN7EWWfq6jvLrF
 Nr7c7hnUO20AF5KFQ75zy/qGnLULX5/OdfO5g+1NpLKXkvGUL66jaMLrB8qBkF3rFw0vU
X-Gm-Gg: AYBFou1kmwxSNlvJAGoy3ZBK0DhimSutBEw0u5aURB3/chx3pLbrn8DrHtmlK/3Vz2p
 lt+eSdsz8YahB0TMfrFY++NvtiCQxsI/K/XfNFFERbo2lUSbbSm7d72IJ+cuD+Kr+dldAWyfGi3
 r44ySPJ5BYIsvKOivgDeBye9hl9ERaV/N9ulFpbVp8hEApfpyayLB/D82XkhDzjVYsyS5IX5gvp
 XSuLbeS52U4xiP5LT9+4Z3h4xf8gJp1dOEGejjjFGxbBLQQ0Og8mfFseVmdQNvMPprtZIk99Hqx
 vE/aFUOvSYP2cWiigza1edG6kjXpFvbLpWB7SZiguOea5HnXBfr2KUg8JrPuCg0qaDkoTxynVC8
 DNJCGqmQMJez8TXrIOPeThUkTgEKP5RYGECJBg99ZzlWmkbFyiuk2EBnWmNM+pHB6CbKdAAwGLq
 ISeYEOOk4iJQpGCpw+py6AZbMzkw/fSo9+0wdE11zJXP5if4/v2Kosbry/LprJ7i1igy+txYvW8
 5gk09SJgAuCh6gDLhRf5JVPuk7AS3KXMzE3yEfq70Korrx+5ad1jrw03MOYkD9d+bAcczejOtxD
 WX4U+hyGCqSIHMA8QCqh3VS5O+N29NYQwf5/cGzszDheZgY/tnhSqpVszGPg
X-Received: by 2002:a05:600c:3ba4:b0:49f:ce72:dfe7 with SMTP id
 5b1f17b1804b1-49fdf253077mr30844695e9.35.1790154923129; 
 Wed, 23 Sep 2026 02:15:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488684863fbsm4891910f8f.11.2026.09.23.02.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 02:15:22 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 09:15:20 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
X-Gerrit-Change-Number: 1759
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1759?usp=email>
X-Gerrit-Commit: 2c7c0a581349f44304b7c9da44a1d80682022b77
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 09:15:20 +0000
In-Reply-To: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
References: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLkk1Y2MxMDBkZDdkYzgxMGQ3ZDFlNmYyOWJiNTc1ODQ5MDVmYmNmNGEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ef692443985b44f1dc8c59937b00a5ef7cd4407-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9J4c-0004Qc-9e
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Send
 tls-crypt-v2 SERVER_PROBE from the client
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1949091417108270883=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1949091417108270883==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IOQrJrenth4="; charset=UTF-8

--IOQrJrenth4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1759?usp=3Demail )

Change subject: oob: Send tls-crypt-v2 SERVER=
_PROBE from the client
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 27: Code-Review+1

(1 comment)

File src/openvpn/oob_=
client=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759/comment/a640eaf=
4_76d7d3a6?usp=3Demail :
PS27, Line 108:      * copied any global key into =
ce=2E Loaded again per-connection later=2E */
nit: I find this comment quit=
e compressed now, and understanding it requires knowing the initialization =
order and what "mapped" means here=2E I would either make it a little more =
explicit or remove it=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1759?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
Gerrit-Change-Number: 1759
=
Gerrit-PatchSet: 27
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ra=
lf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attentio=
n: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 23 Sep =
2026 09:15:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--IOQrJrenth4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>ralf_lici has posted comm=
ents on this change by stipa=2E</p><p>Patch set 27:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1759?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/oob_client=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759=
/comment/a640eaf4_76d7d3a6?usp=3Demail">Patch Set #27, Line 108:</a> <code =
style=3D"font-family:monospace,monospace">     * copied any global key into=
 ce=2E Loaded again per-connection later=2E */</code></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">nit: I find this =
comment quite compressed now, and understanding it requires knowing the ini=
tialization order and what &quot;mapped&quot; means here=2E I would either =
make it a little more explicit or remove it=2E</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=
=3Demail">change 1759</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1759?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1759 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 27 </div>
<div style=3D"display:none"> Gerrit-Owner=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Sep 2026 =
09:15:20 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body><=
/html>
--IOQrJrenth4=--


--===============1949091417108270883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1949091417108270883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1949091417108270883==--

