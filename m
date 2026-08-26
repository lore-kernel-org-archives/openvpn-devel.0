Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB04C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GUjDpqcpyNhdcUvb8H8f9Pc6qd3d1u52VxFybDuu1IA=; b=SG4u1XdnlLg8hKUiE6Q8PKvRE5
	W+uZd1mt5GE2JREki3XZkB1TeKSFm7+oxXsTJcG2z02abqtkyAQrYpJHKp6H9m1ZC0SiCBmOLp+Ae
	pukSc1QAMsFdVYzxdGR4eRq/X1pr04QSTwF2xUL6Sf8fuvlObFywYYa6DFYiyiClflSQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz6bs-0000m3-1g;
	Wed, 26 Aug 2026 05:55:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz6bq-0000lw-S7
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 05:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CySrYMKQARD1odP2cuCxMuFUKN1+qTbdUrmFwClcReo=; b=ZNGBsbN7MUkbVs7GtmdMd+Fja5
 /Jp2SUgwzEyd3O1ZWCyY/DQoFqyTSvnUkWx8ltzPpq5Cznwa/951Efv3+tCIEtNYkzPQXuajtWpJs
 k8BeKi+LvusE/Ov/7LzWe5y+A4kUi+Xn5YerUFxNAJWsP4k3PW4TpS0Wh99KzdO4PC0o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CySrYMKQARD1odP2cuCxMuFUKN1+qTbdUrmFwClcReo=; b=Y
 K1o4xsuzWLNJZzvtB+ZKoG+tEyYS6OCD+iO501n4w4bWWGBKRb/wQ5uIP8QoWcY+y0emXFaHvy69s
 ttjULG5+Ct42hQVUs2ysDvRgYdh0JjyZIEOjyCTao7fJLyyXEVZPyFOlPw3FqqNo9qZUECoDMYKdU
 5m5jBcGjZGo7OUpo=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz6bn-0006SY-MV for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 05:55:36 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c160420289bso65933266b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 22:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787723729; x=1788328529; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CySrYMKQARD1odP2cuCxMuFUKN1+qTbdUrmFwClcReo=;
 b=WZmNRVVYWvEezE/K43YWH3ZULmmTP5Mt/0RaQz7BNoMoHAX6HDzq9NgaR4saujdFMU
 ZWy+8hhq9A+EURq84PFseoIGCOGTYriKLMsNgl4bzh57IUnQRbrEyVN9QuTkOlKNmsTH
 0TyJIpYEd1x5P3TdbPLYsJ4+L+7T09eFiE3TWJwTkfK1y9tLxmSMAJ3sr+M5lWJscUf5
 J9oim8CRzQm1TBeRmnCwLSyeRh+6X49AOEDII6of74j/h8RkdY2DpmHfKrtp7MOL97PC
 +fVYvyxO105uWeiIJ/8jh5R5TdznkqQdO5xk9R7jgvzuLDx+SCMk6TdVq7BHkbI+01FP
 ewkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787723729; x=1788328529;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CySrYMKQARD1odP2cuCxMuFUKN1+qTbdUrmFwClcReo=;
 b=lotlUqgqh80g4VCAT7VjscTl5P3uNbycCUrIz/Cs5wex40uvNKZxUeg307pQ5Uvupv
 bKmpr5bIhQ+4eD6vHafmqnZL814oeNVlLC18gIYPo3DOfOMKGizlnzdko154gwm6vZG7
 RQQj8rv68WMRDoK1FZekUrdBo6oif2aUQ+TwAPYFmXSiIcaKmqjEWsER5OVRPtMonCcT
 4qlmfpXeTaaq579/nABFgF3MxBZLDZO8Ql8/gKVeYL8iXfadr6fBrVeaMUc/NqovF1FJ
 Qnt7QYIUJCwDu1K+MV/I4bsl/sxIkDFC7e2teCuvySrArIW9A1GR0CXxqcZDjYy/1H1F
 Z7XQ==
X-Gm-Message-State: AFuF++l5RBK4w+2Uyp2ZgDBYGdqrVZPMLHPdiW8jOO1mUBttR9OKCrYQ
 BcbyAw+nXwK5LPqPpTews6fFqFEJI/o451/hgZ38tKME5nKxVz0K1Gv9NlOqctbYM+9ZQJbqOkf
 ZAPirSW0UhsVPnZGLSiE9dzhoEoSQhplY/+Sv8nr4gmiC80Cl4fI+88N3LmiP7iBv3cR+
X-Gm-Gg: AR+sD11b/Emj7b48DSRseg9YEfO3+AY3c+UFoubcydj6hkJXcWp0blcT9ob53pZ9vdM
 pwqcP4FfvCTmUZyb5XG9IlGUt0s4vdiCn55anoFQOVXd+MBA0UUNWtuxOArEnvM625RXnpKG2v1
 YA8ALISKz6xQ2eiODnsjZZdi+V2iP6K+4/22FePS+wi9Spe+uHjNUx3l46t5JtFpSN87smI8pbB
 a96EHTE49nh70Nz1XierAAjTRolKM8VAteHpUdHqYGEPTFguSSEzSU/IVnOEbkULc3xkl1UzQsR
 8BkNIFelRM3AWF7AiEaXA7S4KtfHXbeue/0JjFxemvdHptiylCeEaZYD06LD6KzA/vxEnrGfeBo
 megSZmZ1pgRcA6/okYb/7blfUcfUzDKDvtNyOjG2Bc+hajtJGo0DGVBRHKiBvlJWrYw/ZcpD3H8
 KGOpQCeFmrIn6LQVdoyWW1Rtbn1ZT48jq6fFw1eY37wqTY9/gd7UU5bVPaNFabqMQPh7MmWU8ET
 8iz/b5RmIF8qeIDx/bLaiNH6T0hmcZcM0i06sRHE0SCCeCh7KM1lOmzoUc974DGsWYDPDb70jtB
 yaC0G+YOgoxL4nUUjIEsSFsFiYwCIvZGBA+LQ7B91nhWGs/fli4=
X-Received: by 2002:a17:907:9288:b0:c24:b11a:470f with SMTP id
 a640c23a62f3a-c250b9bff8dmr491590066b.0.1787723728803; 
 Tue, 25 Aug 2026 22:55:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ab65sm307328666b.37.2026.08.25.22.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:55:28 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 05:55:26 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 08cb2cfb4ab730666449ca39581a1abf4224d568
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 05:55:26 +0000
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e66d88212cdd0adf4188d424870988aa8b0f4355-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz6bn-0006SY-MV
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add helper method to
 read an integer from a buffer
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6818200323202231613=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6818200323202231613==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AfCHU/kvyos="; charset=UTF-8

--AfCHU/kvyos=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1855?usp=3Demail )

Change subject: Add helper method to read an integ=
er from a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 5:

(4 comments)

Patchset:

PS5: 
I am not sure we need `b=
uffer_read_int()` at all, for two reasons:

1=2E We already have `buf_read_=
u64()` and other helpers in buffer=2Eh=2E
2=2E In acc=2Ec where this is use=
d there are already alternatives used (`atoi_constrained()`) for the other =
length field=2E

`extract_field()` may be useful, so keeping just that (and=
 updating the commit description) might be something we want=2E


File src/=
openvpn/buffer=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment=
/37092562_8bf7e365?usp=3Demail :
PS5, Line 2261:  * returned string is allo=
cated in the gc_arena=2E If the seperator character
Typo: "separator"=2E


=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/ad4c297a_e74b286e?us=
p=3Demail :
PS5, Line 2264:  * The buffer is also forward to the point afte=
r the seperator character=2E
Typo: "forwarded to"=2E


File src/openvpn/buf=
fer=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/dc7779ab_c=
5202ab6?usp=3Demail :
PS5, Line 1400:         if (c >=3D '0' && c <=3D '9')=

We have `char_class(c, CC_DIGIT)`, would that fit this purpose?



-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570a=
b5628bfcdeea
Gerrit-Change-Number: 1855
Gerrit-PatchSet: 5
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: =
Wed, 26 Aug 2026 05:55:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
No

--AfCHU/kvyos=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><p>4 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #5:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I am not sure we need `buffer_read_int()`=
 at all, for two reasons:</p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">1=2E We already have `buf_read_u64()` and oth=
er helpers in buffer=2Eh=2E<br>2=2E In acc=2Ec where this is used there are=
 already alternatives used (`atoi_constrained()`) for the other length fiel=
d=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">`extract_field()` may be useful, so keeping just that (and updatin=
g the commit description) might be something we want=2E</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/buffer=2Eh:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1855/comment/37092562_8bf7e365?usp=3Demail">Patch Set=
 #5, Line 2261:</a> <code style=3D"font-family:monospace,monospace"> * retu=
rned string is allocated in the gc_arena=2E If the seperator character</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Typo: &quot;separator&quot;=2E</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/ad4c297a_e74b286e?usp=3Demail">Pa=
tch Set #5, Line 2264:</a> <code style=3D"font-family:monospace,monospace">=
 * The buffer is also forward to the point after the seperator character=2E=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Typo: &quot;forwarded to&quot;=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/buffer=2Ec:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1855/comment/dc7779ab_c5202ab6?usp=3Demail">Patch Set #5, Lin=
e 1400:</a> <code style=3D"font-family:monospace,monospace">        if (c &=
gt;=3D &#39;0&#39; &amp;&amp; c &lt;=3D &#39;9&#39;)</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">We have `ch=
ar_class(c, CC_DIGIT)`, would that fit this purpose?</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
5?usp=3Demail">change 1855</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1855?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1855 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-O=
wner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Wed, 26 Aug 2026 05:55:26 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: No </div>

</body></html>
--AfCHU/kvyos=--


--===============6818200323202231613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6818200323202231613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6818200323202231613==--

