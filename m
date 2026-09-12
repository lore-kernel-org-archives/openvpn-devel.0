Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB1AC88E45
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6CEO0GeoReHG3WPH/H8QToDwfD/1HjUCwHFC+mT4L0=; b=Lv95m8/xlwCdBeVmSK85kdmO1l
	GTUbAFg3dIShgjuQUylhQ2PplUud44CbOqqu08atFmEzp+fsF4D0Ase+cDrQUf7gnYUD/fR7eEBAW
	AHVgO/0rUWpXGOvUa+EQjvTdlL+0g85V3bbhn2nGTofvmRzXczFfhNJAcXkTrWWfHfj8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5I0E-0006FI-8b;
	Sat, 12 Sep 2026 07:18:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5I0A-0006FA-9c
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 07:18:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eCSGrkw+t+RByjpgXNHHzTxwWWjfOlj/A02CGeofkhY=; b=T4uoP94Z/VQRJJh2NOfSET5T9J
 ZDtn46AqPZGGDcOFEettsrH84UGCUd85ue1yMdFfXYcm9EZo39Kc8PBxbWXLpz1ED5uPn4xPc+MJL
 PGmoODmQ6m5ABhW1uuOLcGzuCHNrPQD2TB1hVzBs3PH/i+3bp4WW9CNHN5/rO9yM23mo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eCSGrkw+t+RByjpgXNHHzTxwWWjfOlj/A02CGeofkhY=; b=i
 uHu7B/j0KqTSql2Utkn1ozh43tLixZhoPKe2/W8qkdQwyMEGwV0Z4eoc8NfhoJu18a3FAHNZcR405
 HC/mOnuUtOWrVR7ORjKeE1I/Bd8ylXW5rU9PPXssIcrdoi3xkdlzlqNOxFv1WELed/Ezx0KtzbTcr
 Np110z25zex8VQpk=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5I07-0005wE-1l for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 07:18:15 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4858bc96fabso202964f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789197488; x=1789802288; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eCSGrkw+t+RByjpgXNHHzTxwWWjfOlj/A02CGeofkhY=;
 b=IjfM7hW2u1E51++JFTZ/C0GfhWeITqLi58PNJAmmV/10cKz02eUm5InEwgSIad5K+L
 wIC9tLO5vELpCbpM7qBParUvFmX++CoCIjelioXkFSUFinMQsoKvLsx64inZgZdjYZwC
 9XEt70jmADEQ24ABcI/CKqZpi4zVi5mk3By4P4MpV8xu29AzKUAeV4XKJvfq23sfuvMl
 lO1xZLNZ/ZVFQaqm7l7wxvqJa4gTzXvmatdfpYY7TaneATqeLg0vw99jA0dwzgro/OJV
 3QJey6TApSSm1xXnSS0GqJd+WbvrMODGX1QXTAwB+xwMzGhJpV/VelZp6nktPSmv4HFE
 KAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789197488; x=1789802288;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eCSGrkw+t+RByjpgXNHHzTxwWWjfOlj/A02CGeofkhY=;
 b=fnYf17XF4lAOH2w3BtgW1j4Ihpph0y3VlgxhyFoGbEJcJzRUsb04zTqlGvEuwWzovL
 71f9RwL7VSywtjJ09QNl23GgJzcUkzrHj4JPcG21CouhyHS4oWl2Amx0XGG4RQU0iU2o
 bYHgZIRbWWz7gWvgGXxTpWD5XwXizaGNmhSrD08loLqxwOUIDa2LyYQ4dj4xlx18gFae
 HqCAzFT7gO2vk8M7QxWpVFxB9LZvl2E3AuT8l78gRx5Ykr42soZ6IuTjUtwq8HWDhPvA
 Kk/6RGp6ewS/TbrZYrTNXUGfEpEXumVB0it98haZ9h3TNlUa2yze/jLkkTMgCh0T+Bh+
 /kEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNnhQYnfPJ9aD8MISsLSBC812+AQUxGtwLKrLQMhhM1DZaEbcnc37SdfLV81/A9etGe+FJR7rjA13S6bUZ@lists.sourceforge.net
X-Gm-Message-State: AFuF++lWWNHTNYxWc3AzLhZbYsGlC5v2TZ27991u3PpO7Ur1oLhAoe7a
 KF+n/24kOuajULs4DtILk817rVWAndkDvbDyFr6epVlorypfQBwTlWxIJHpxJWOp77EKcdBhT0Q
 RbAxNq6VdRhXaoCyRYlI87qkxoCZKPv66eMgD4MzdUrY0toxLcK8GqwlKkBppXmqqcyae7QvYNc
 OXa1jm3Q==
X-Gm-Gg: AYBFou143WbenkPdq+Xlo0pBbx7Hq8IMnsm5vY+IlKrF8bJjplqQCZpaYPOBp2BIIDG
 +JajzSUdNiFftwxmkjALVXLPFByvqE/qEISj3rjh15r0GEG7j0MjffkWeEX9/sCMNxCBNBtyu4x
 5+MNro71NCiwNQ7JsGva1aE4mjxo6S/gQcR0R27VvPLcEnr5ZOF12fx9mEzX7wqba2T4+HedV+E
 aABTg4tI1CjZfvveoUxrI3ZLHLJQgKoPIq3oOfhFPuC1fC03bwfO5Yb/Os4G1ev8fy9JvOqElxH
 8byAU0HlHN6E722STSTFWWiKnWUWJlsbVAtN5wZVMEb3MEdy/ynu0dmCYpbz3jBJCmySW2SJehn
 ix2O+MfWlIQeT4IgdtS90pRMaN39H8Np5MGbQV6mKnGGyHl9fSB6WQ5e6DQYg+ShJnekLZxpAJb
 RECLMsTOWlqQzKgV/FAXMSiUGxal6pa8dTo83/GWD8Xpx0yv4UcGr8lbNBq4VODXjErDRVGcLgd
 r1+wqqck1N5ETz9XjMLlYrvXlBaoZ4gw39WcVgQT4fs2rdh9Cip5wOQ73NYZX+F56ogKOHM+prM
 V0FhrZqUKltdOaXdHSueR3pS3CGSSoq4QyijImYc5ZXr388I6W1DhsnsaxRISA==
X-Received: by 2002:a05:6000:40c8:b0:485:8a46:7060 with SMTP id
 ffacd0b85a97d-486f6d641bemr1878479f8f.50.1789197488323; 
 Sat, 12 Sep 2026 00:18:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb359f38sm10229877f8f.30.2026.09.12.00.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 00:18:07 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 07:18:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 41de9be8c936523b1b7ac9316f611686469deba0
X-Gerrit-Comment-Date: Sat, 12 Sep 2026 07:18:05 +0000
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <372f591007fdf79c49f0da0771d00721bcd5d9f1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5I07-0005wE-1l
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6730347274368359092=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6730347274368359092==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KtrS/gvGAc4="; charset=UTF-8

--KtrS/gvGAc4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1747?usp=3Demail )

Change subject: oob: Add --server-probe to or=
der client remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 21:

(2 comments)

File src/openvpn/oob_client=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/cc9d8393_06a4=
f2bb?usp=3Demail :
PS19, Line 213:         pc->sd[i] =3D create_socket_udp_=
configured((sa_family_t)families[i], o->sockflags, &sbs,
> `oob_probe_socke=
ts_open` creates sockets for every address family needed by the resolved pr=
obe targe [=E2=80=A6]
Good catch, this was a regression from sockets refact=
oring=2E create_socket_udp_configured now takes an "optional" flag, which s=
kips unsupported AFs, so IPv6-incapable host still probes over IPv4 as befo=
re=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/3f177cd1_232=
fda0c?usp=3Demail :
PS19, Line 464:             && !oob_probe_same_bind(l->=
array[0], ce, &c->options))
> This is not really a blocker but I'm wonderin=
g why bind settings are compared against `l->array[0]`  [=E2=80=A6]
Changed=
 as you suggested=2E Added oob_probe_eligible() which picks the first direc=
t UDP remote as the template and only other eligible remotes are compared a=
gainst it, so a TCP or SOCKS first entry no longer disables probing=2E Also=
 improved logging and man page in that regard=2E



-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Ger=
rit-Change-Number: 1747
Gerrit-PatchSet: 21
Gerrit-Owner: stipa <lstipakov@=
gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit=
-Comment-Date: Sat, 12 Sep 2026 07:18:05 +0000
Gerrit-HasComments: Yes
Gerr=
it-Has-Labels: No
Comment-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>

--KtrS/gvGAc4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>2 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/oob_client=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1747/comment/cc9d8393_06a4f2bb?usp=3Demail">Patch Set #19, Line 213=
:</a> <code style=3D"font-family:monospace,monospace">        pc-&gt;sd[i] =
=3D create_socket_udp_configured((sa_family_t)families[i], o-&gt;sockflags,=
 &amp;sbs,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">`oob_probe_sockets_open` creates sockets f=
or every address family needed by the resolved probe targe [=E2=80=A6]</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Good catch, this was a regression from sockets refactoring=2E =
create_socket_udp_configured now takes an &quot;optional&quot; flag, which =
skips unsupported AFs, so IPv6-incapable host still probes over IPv4 as bef=
ore=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/174=
7/comment/3f177cd1_232fda0c?usp=3Demail">Patch Set #19, Line 464:</a> <code=
 style=3D"font-family:monospace,monospace">            &amp;&amp; !oob_prob=
e_same_bind(l-&gt;array[0], ce, &amp;c-&gt;options))</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
This is not really a blocker but I&#39;m wondering why bind settings are co=
mpared against `l-&gt;array[0]`  [=E2=80=A6]</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Changed as yo=
u suggested=2E Added oob_probe_eligible() which picks the first direct UDP =
remote as the template and only other eligible remotes are compared against=
 it, so a TCP or SOCKS first entry no longer disables probing=2E Also impro=
ved logging and man page in that regard=2E</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Dem=
ail">change 1747</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1747?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1747 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 12 Sep 2026 =
07:18:05 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ecom&=
gt; </div>

</body></html>
--KtrS/gvGAc4=--


--===============6730347274368359092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6730347274368359092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6730347274368359092==--

