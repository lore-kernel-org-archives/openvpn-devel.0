Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E78C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36yNVj+8QjsWcNHD8g4zlu8p/V49joF6sTqLnhzEse4=; b=jIRkYKgRybuC/Ld9JkHgh4PqEq
	jE4KBGFGYU5NyapdxspE6yfktAfi6TT6LPijGVCk0EEvQAe7wWASCHZSKqcYxNQMtB/UeO9rJik4c
	kb4zzqBcF/AUIxF1RpVYKq6WVGDQOJ1Vj1k9hY/OKtAC3Ev4mdIwUtIT2Imb7E2fDgxc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvxzb-0004Kk-RO;
	Mon, 17 Aug 2026 14:07:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvxzL-0004KE-9m
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:06:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PK9Wbg4IhDBaGJKbpf/bmr6NwThJ23vQIu/HN0tuyts=; b=QS0C4bYh/DrtdnZXYQr5iZi9XM
 7Z23Wv3K1BwRYWjd1nVgUJ2D/McggIoc0sJms/Bfipyg5XliL1KlC7OsBTHFTT5RaSQEynaXTE5wS
 Aq7Szm6dAtx/abedEwi8PNIVEfK4d81TcyYrCjEWc8NMo6tIDGASSA0zGkr6gkurN0y8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PK9Wbg4IhDBaGJKbpf/bmr6NwThJ23vQIu/HN0tuyts=; b=a
 WybchFZAWPYEawu6xvVQor+AiuSdu7cKe7p93tqRrY4xE7vPqxf3sH3tAey74CFv6uEVLtRc7vcMb
 0tfGR4C8p/BLcNGKHcD5rwqwiRyw03iHWzkDoHmP085olcY54wtAF37D77Bg0rdqJ26nRvi0TiQRP
 xy88S74zoQVGeg/0=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvxzD-0002dq-1p for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:06:48 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso24162265e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786975600; x=1787580400; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PK9Wbg4IhDBaGJKbpf/bmr6NwThJ23vQIu/HN0tuyts=;
 b=HLhDYIAywFrZyfweQv+ZrqlVRYULudiH7QH7LieuyPcpupaFAD+Y+yXO61lARqjrPH
 0xFTdRGyINourbf51T0gTTZYFZJ643jLl4QpFAhyWz8KdPe/GBq7sLqd80TMNMOQ2l7r
 a1xxSdvxnMSyo7DNFJy3c2xmGjestzxD1bbUQN9uacQOg7xxp1NOFIs5tkbnE1SyChft
 quITj2abk/oEWspDGepZAhNV6KtVKeHJMrbBxAfmZHE5hhHfculFZp+viQ88/HH2LCUb
 D+P7yQZqwhCjU/sgL5Ez+JON4P9w+HUMw/znZtoC72StG3dKyQfz7cB30B8oaGwD/3LJ
 o9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786975600; x=1787580400;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PK9Wbg4IhDBaGJKbpf/bmr6NwThJ23vQIu/HN0tuyts=;
 b=Pg6RQMeeij7MhFYnvdsC0l8GdGuW8bCyqEbkEWexyUFlT+msxreMBhA6LZKqGE5w51
 FLB3Exx2LLV2j5yGDBktvsMT0O7vQK7GQPMDQeE4MLa9Eh+0SS2HupbZVMJ6r4IJVAgD
 +Ui36ljLFgCn0qHgr9hDIM+l4pIUXRUuKAx1cq1WNUGdRCoyLxNrAGgqhro7SXDmgdZS
 ToOv6rBj2RD2r2RTBmHUSFvbFbup3LzGGC6r8ue7m/7HbV0aOeSsygvUxhM0GIJRe9tS
 cHiCx8YAtaU6LGhN6BvNRlNedSFUQJRMrB43DxIpKfwTq0XTmbwQQsVdC3a4AI2t84Rq
 hocQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roq1imTx9/Rq/Ln++I2HRX7yp6O8TKeaoZFinTysml2Vj9E90Mlktw6XyIajnHJBGMTQW7RsHbToUHYkRBt@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy4iLspjEONRYrf6lHKWlYp7M2FrxSu5hEXG3IstLCJSDHC+xuv
 s8u5qdNqWVHB5k9KogYtALvv0bRoIvmwJaQFdufn2YRiHDWQJ/CgA9m+3wTqzZSGdE+986aCZQ6
 9YfOPQdA/gatqPYNdYC38GMdztC4+3A/8fD+5n9L62KM6ervVxdDjdJRDWX9pMqg01/YF
X-Gm-Gg: AR+sD12+RttM/XIcrXkWQob3xu6Og/gZaE17MlDo3cGU6OXFodRUZPRLbzusK0DLTiI
 EyOCkJH06PeN3DOHmzqIGnTX3gtw4678J6/1rS73rg/9fyYKJlAMDduspiXnsm6YYo8CF5To4A7
 B/vkUB577AlAfy2aaVgVa1RZMpTS+41Gp9TU5/0KLPY1fZSQH4Ei/2QCbLR8EtGYzQXQ6Cl3lAJ
 NybhzQZ4w3rdwZ+PvWEk3XALB5QaGEzOMww3iAL2mmexMDfrkt67IteMLD9P6MP7J+/HuZQAInY
 DQhAthp7tLiptJmYXv/Gvh2lwN9Nqk5LVlU2tYRIUnzr5eE64Wy1sZbc4hy+sck8KJ8lOsSVGNo
 OVo2tSG1NIRrivsxN81B/ZWVOYqWjk5mX0qAa8+Iy303eLr64HVcH1AUfjPdcelchTwojRNY20+
 p4ZSHX14BDW/OKjaeGji6+WnxQh+vofVt91kwEVwh+qk6fLtXijFGiPLm4j1JUi2zDhXvJhnhej
 c0C0Pj9Fj/7sxYNF+e8QTzHIL7Q/rB/VagCoWgLOLA6jbYUudvh7DoW/klwQpImALrxVigecMpN
 TGz59EG8nyyGQEcgT2Vi1sXmQkMSl/c6CoTnO4FEVK00Yq8oBwz9a0NX
X-Received: by 2002:a05:600c:5299:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-4998d7aeb77mr310543505e9.2.1786975600451; 
 Mon, 17 Aug 2026 07:06:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d078517sm41690035e9.5.2026.08.17.07.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:06:40 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 14:06:38 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: d1aa12f7c12ec03bdcaf0659d5ccbbcb198d7081
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 14:06:38 +0000
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3279d4784b62c52e993a6e1657f0d8e8b8d7bab3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvxzD-0002dq-1p
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Reduce number of
 future epoch keys from 16 to 4
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1440183197637451136=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1440183197637451136==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s9PItrGr5Ug="; charset=UTF-8

--s9PItrGr5Ug=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

plaisthos has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1844?usp=3Demail )

Change subject: Reduce number of future epoch keys=
 from 16 to 4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 3:

(1 comment)

Patchset:

PS2: 
> The comment still says GB =
(not GiB): [=E2=80=A6]
No I forgot to change this=2E



-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197=

Gerrit-Change-Number: 1844
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attentio=
n: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon, 17 Aug 2026 14=
:06:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply=
-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: razvanc <r=
azvanc@mailbox=2Eorg>

--s9PItrGr5Ug=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1844?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #2:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">The comment still says GB (not =
GiB): [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">No I forgot to change this=2E</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1844?usp=3Demail">change 1844</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1844?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e=
197 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1844 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ra=
zvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 14:06:38 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comm=
ent-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eo=
rg&gt; </div>

</body></html>
--s9PItrGr5Ug=--


--===============1440183197637451136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1440183197637451136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1440183197637451136==--

