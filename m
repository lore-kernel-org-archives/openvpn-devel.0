Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B1CC5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xg/aPS0Vp3Ux7/B6YRFsQxrbH1mBWxD+kyYamJr/TtU=; b=mkwmxKv1BKE8PiKR/uaN4HO4U/
	P4IUclAQHPWjhcDyXKBAVTHlESwlMFHwodGQldoedXmmkqrQRt1YHKdzNYaj+PLfWNrgi0DH2R0zI
	VkGH/Pm2P7niKZU37g34BgRUU0mTz9t8y0F1+/uDGSQNAhk+qDWFyW1Bm0iJ01rS/N+k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzCC9-0002Vz-BW;
	Wed, 26 Aug 2026 11:53:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzCC6-0002Cr-Mj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:53:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=T49Ucamiovr/+UFJVX9PjwHRhIDfywr+BccEKKV3BHk=; b=DCvYR8Hrmr05k9s50HG2xaAvR+
 jsloMrrGL6w2KlVuSmkUl5eOFyjrwR5v1byBZA3XUtVRfXMwa0gX/SO8g56w0VOqpfe23Kw2Ortgk
 PEVohyln3z2uQ5/7xH/aA5m4aUSU3feIaHU52rNHjXI6VMQue+E3v9MwzmiKSdURqnLI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=T49Ucamiovr/+UFJVX9PjwHRhIDfywr+BccEKKV3BHk=; b=O
 hXVGr2LxnKRlX4//sgK9dWaUol3z02snPGp+Slf0QnGwfiPtJII3yoI2apt/6Qyw8d6pUGsrMObpD
 uZ4mAVAaDfjVpJrEBpJgLtYMeBRVRg1/aVX28hRI5/PNp2Szvj0H0+V5yC4Nj0nsk0jMpXE4ilaHn
 jsxP9sWo47J6YlFc=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzCBZ-0001N4-LL for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:52:54 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c2022323c37so108316066b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787745167; x=1788349967; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T49Ucamiovr/+UFJVX9PjwHRhIDfywr+BccEKKV3BHk=;
 b=INL854B31q84rMqBOKorezf6mG45JR6g5kc7jlREiF6JDW2PYNH/sahic85gQM8osn
 7oNo3+dgI7oTBiVABX35UmfbcoPpFkb7WAkB4YlLHtlIAG7mbwJVm+SQbtqck24LXC0m
 aGFcIWd7Yb33tS0Q1E9fklY5obuQwX79yPDxiWzrzEJgnNj5Bn18hAvXEH561ZeFfpyK
 AynkotMXjdpJEIiphU4g71j45LyyTT6STKEPkYpHtwGNPc2B6NlOCNud387FD44WW+DP
 jAHLjWIdD91BiXvMk4TWwvcr2UVSKVRzugPoxTN+yIFpAPchjDZ9sdOwbsMaz1qurig3
 EtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787745167; x=1788349967;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T49Ucamiovr/+UFJVX9PjwHRhIDfywr+BccEKKV3BHk=;
 b=BTXyKXyQh53HQjSzBDZqdU6N+3RoLwGv6gel2Mgcp6sLV872r6AS2Eqxc7DlJyqQWi
 nuasm6cNLzOCXgVidfcrxFLvaCyQt2EpM/fKDG8wwJHEOyLzyqAeDQWnBaDKfa9B6WJs
 ZC2ySoHtd+tfnYl/G6CODOcz9HgEJo4Kd0udUpAA4iqEa+8PGK8nx1v28w2wFgzZRSbe
 mWSS5yrGq4b+V4MdYjWsxzsz2N+c1NZH6Sua40lwWDENqXvdEamXMD3DBV08Eq6Y+Xei
 Z5lIf4i4VtYl59283HfN94Y2ZG7YbTPNlKMK8x3hIYlJdVLXNOCBHNzZG1J6B6OkMAv0
 7qxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjvEmJh4M/yhhOW8eXtNIwwsxbQAlyXeeQ4+FejTm43le42/Gpcdt/rp9ovuBRDuyhPEhLulMOe8/DjofR@lists.sourceforge.net
X-Gm-Message-State: AFuF++mElXaw+GrviH4GsF7tJ+Khk0FpisPUfeKZ97HBxZ7J0i+4Fq5v
 9gV8/QcF7+D2BxfDKRkwnS41jkfjp6KCKn1M0BKAsJL04UJzEu1QQc6jVQtyVv1QScYTyLken/X
 TsaKTQTP40+s4Xq/oL9m9WZanRMlvNIIT0oynAEgRirrfYHXX8RRMqmAHPql7ojquWSky
X-Gm-Gg: AR+sD13wjfDOZNMPnqyx7cYoQJn7nPaXiCG0qPD3ttt4lZjPG2+T/TR/hpXJFub0yaF
 io7kfy/3/UNm79TVo/xn63ps6HZhkyjXqVU61N0J/nh+9EFDuocOzihcHF4wrz5Ab2IKpIC8/1R
 MaUZYHfJCa/5ZWHSbaQn0x2WRaMpNOkUE5LY4oTH4OcTZBC/e4LOj/0W6+cdqL+dcKni9kb5/dv
 n8nxLAqDj2UqX51QtN3LZCic9PdruatdZVvb81yjo6PDje3HM82w0abEXcBpUNqSb9M4C0gwNr1
 7urQXeVJK0acIaUqm2d8bxSWa5UzKK1FJ6bg0L4BGRvAUV5PLFOcCRdCwkBPhQTbK9f862k3NP9
 9WlfSA+kSoIvN3OEn9IziaHY/93vMfuMa+YrgbckUeRMgkI9/wj2nHRP6DsJ/dThAABVLPbRcvc
 28uv+GtqSg28OmuMqeuk5yn7cjGe4M8qkiHDKJsaMbbjKw85DmKg1hTholDFQrmfFjxizFZVCvq
 DVAHz27pE4Wj3h7yvKGuvKcq438NlbdUY7X6l+EzCGz5IIFyGMcCTeQoYHuRL9pO/13kxczu6ul
 diO524sHB6yPrr/70nzCSdoZvNECQzw2GmXRmu0A1RlF8u5pgxg=
X-Received: by 2002:a17:907:7249:b0:c21:792:8257 with SMTP id
 a640c23a62f3a-c250bc37bb2mr739097766b.15.1787745166736; 
 Wed, 26 Aug 2026 04:52:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b3cf9sm348406466b.50.2026.08.26.04.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:52:46 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 11:52:44 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15
X-Gerrit-Change-Number: 1259
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1259?usp=email>
X-Gerrit-Commit: 4ccfed975151a7bb0601eefcdac5e847c514cf24
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 11:52:44 +0000
In-Reply-To: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
References: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU5OTM5OTE3MDAwLkk0MWI5Zjc2ODYxODBmMjU0OWJkNDk4NGNiYmY2NjA1OWYwYmEyYjE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b9c04bf1281fa5a7e86539be3a0c5c36363dc4f5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzCBZ-0001N4-LL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: Fix conversion
 warnings
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4682478516878284114=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4682478516878284114==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="icKCWwJEKXE="; charset=UTF-8

--icKCWwJEKXE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, razvanc=2E

flichte=
nheld has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail )

Change subject: init: Fix =
conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 20:

(1 comment)

Commit Message:

http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1259/comment/1038b607_e2084492?usp=3Demail :
PS19, Lin=
e 10:  - Return type of get_random is long, but we ensure that value
> Yes,=
 you're missing how old this commit is =F0=9F=98=8A [=E2=80=A6]
Done



-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I41b9f7686180f2549bd4984c=
bbf66059f0ba2b15
Gerrit-Change-Number: 1259
Gerrit-PatchSet: 20
Gerrit-Owne=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@gree=
nie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: =
razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Atte=
ntion: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Wed, 26 Aug 202=
6 11:52:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-R=
eply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-In-Reply-To: razvan=
c <razvanc@mailbox=2Eorg>

--icKCWwJEKXE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos, razvanc=2E </p>
<p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259?usp=3Demail">View Change</a></p><=
p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1259/=
comment/1038b607_e2084492?usp=3Demail">Patch Set #19, Line 10:</a> <code st=
yle=3D"font-family:monospace,monospace"> - Return type of get_random is lon=
g, but we ensure that value</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">Yes, you&#39;re missing h=
ow old this commit is =F0=9F=98=8A [=E2=80=A6]</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1259?usp=3Demail">change 1259</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1259?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2=
b15 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1259 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Aug 2026 11:52:44 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none=
"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>

</body></html>
--icKCWwJEKXE=--


--===============4682478516878284114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4682478516878284114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4682478516878284114==--

