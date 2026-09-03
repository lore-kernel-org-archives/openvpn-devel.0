Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D65C624A4
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qp6lGM4flM3DIRcHLpowwjYqcmWrtcw5FGFxis+QhcA=; b=aLJ+l37nP90xaWmp5MbSxJPRd+
	+HXbC2PRAL5YuOi/CSVIxAJs7udXE1fm7O8q6Oq4j/Sj0Gg6x+0oUBOuyPjvcq2MRvT8t+AQfmlDk
	GSw9jTLV+zYRv/0p+XzaXiz5w8PlnzzB+bl1XM1CH2RCT2rfiqIvKWLLd24NiJCTdjXg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x289L-0000D4-11;
	Thu, 03 Sep 2026 14:10:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x289C-0000Cs-Rx
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 14:10:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Vse/5Lkdh9CDH4Ws94gMZXPVfASdP+wfayOyS0jNDd0=; b=ckCg4st6RDV91wJdVPeS4Fcrei
 5k+vAXkW62gSzH5HlwenvCP5e+K9PBe+/TeILh2V9gafXuwnKQM2A6yQ2V/kNx1perW3HsB5O3KU/
 NJlblhjzT45dUtfYQIsws8vY7OKzEaOdTMuG1wY5Ubz5Wn37PDmT/YO6th00llI8cT5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Vse/5Lkdh9CDH4Ws94gMZXPVfASdP+wfayOyS0jNDd0=; b=E
 7OKlh8YG1d5d/ylGxDsTx1h01cPmKzfdD4CmBkWlRiqUnrKdcUVylhmIYrSMRxaP4kVToNikPodqT
 uAvyITGI2x6EenFOVfIeoCo8xZpqUxLwvT0iVKSv0KBZt1BIZ6UmwKvI3cTd1842UsAC3/Rar0Rt1
 2qzjYsDhkYrTVULs=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2899-0005jb-Ic for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 14:10:35 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4956869750eso17084325e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788444625; x=1789049425; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vse/5Lkdh9CDH4Ws94gMZXPVfASdP+wfayOyS0jNDd0=;
 b=G7+6AsS9FU8TuNdAUMNbOxOyrvi6p2kbgPOLxYZ0/hTfj/JFeSx7S7V0Xge9j9jic5
 D0DH9/s5P2MnzJRLUJEVqe/k4klMGLVkPeNCaBMhHnpG5U2vkTDQUYOnUQTDHfPfLEBy
 XmYua29XgATuNNvmB1+vE1/o3TTZgM4sDboPCaH3qE/r7OoOKlcuc4zCHV/6driWr1B5
 NyIA7PNfggmXLYsh+1HYFO9jco7CqZz1D1HSe0U7vHzB6j0XMTg9U+MeWd5UsFcrx/44
 4DgoEcYyDoXpl/VDoAZYk8rZK+CEfJ8c7GlR8tBVRDYUouWxlTihBZTyuvXOM9FJ6RQI
 S4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788444625; x=1789049425;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vse/5Lkdh9CDH4Ws94gMZXPVfASdP+wfayOyS0jNDd0=;
 b=TTYogwP/n7Y4VnGnjC44O0OO0HA39zVgncciUdPkL/AKJKX+1u7vhnm/89Fiuq5SzX
 ci54W8eui/8ocm2s/cpZkNZfEMyoHB33SJfwGbwnWlyyh7tl/ebjwpp2Ai8UDXG2A9o2
 6vm2t718x7UuTiFr4AalLjfSmaGOFpL2yE7YfKoCmdcPYmNUX9r9/HakSMHlImJdH3vh
 Fr0IINI1sHtTHz4jecvfD4bWA1PtP85t1EZxVnKpmpRnol5TqRl5uO6Ru2Ef9Vtg+6sD
 DyBpE/FmsqTjqXBYWrf3qik/bkxEj0KIGs7yMJF/JjTievXm18caewnCO8Sg9fsNiP8W
 85Uw==
X-Forwarded-Encrypted: i=1;
 AKwUvByCPKmx4DIbbJwgavzXSfjvrldkXge664pp6kytxMe6e4uXcZSVhY3egY4wvGS4fcZ2R4bxElLjUIwIhbxY@lists.sourceforge.net
X-Gm-Message-State: AFuF++mmb3xY69nhE6m0Y0rdO3PuwBD6Puf2ABdMA5peLvVSU828X7F4
 lo8gSGkFKugHB7wvXP1bI5ZZUcyPdjtoAZEG4o7YqTLUWirMUNi44ZTwxaeCTlicomdGI+MaRzh
 0p6eIAsLzwEbNKlxcuqyUQRxEm7Fw3zkN+nuATrSUTlM8YDkEuvaLMF34QZz5lJB5oqGY
X-Gm-Gg: AYBFou2gtUG1XkLOORjp0iEvl8KY9VC5WpPZPwpNl1lb413Byp5O+MmPLovHpyPk31Z
 V1amLJlsOxsSr+jXKxICTzshta3RDiejfu9VKzHm1MWNfaydzaV+YrcLKM6boL/YxD37XqynEPg
 QdV+n+lWPDPq+IfaIgQ00qJuWGMdVyRHPrBcCyZuS/dZxgnXarG5xJEMLm2GlZ9pksu0sY4XwDe
 aMK627tRmV5fGB3kZUTmx2y8qf9+1UTPQLlPBxLUAG1qpUq7cA73c7HqkNC/B8nnHTfDK8wbrXb
 Zudo2+/iUK6JXbBaOYbPHK5ykYlsbtMXpsCShA67XNOIGgflmY0UYk+dJ87CK76d9eR5488RM/w
 /ibV/HXtPZWzR00fbfu0geMj03OWtEBgv9mBsXXNTiyIunMDbavMFKJurvEHCj9moR11yjqZOD2
 IpjWww9OMQYX3HBtVWPFdh3hbtQZ+HqYPqx83brMy6uL/VCmMCjW6B59wMoU3jE1wT6LKkzHkfK
 VuV4KuiZWwX4TjtNZXyfynqKvWyLeFSlS4oNz9RehG2EB25OPoOOnypB3MVitBlfNNUX4WXgtJr
 TpYTqx1ZEHp43fuwDxqdiwxUMQ6oIF/E+3qYprux0BQO7OeuwYSFe2flu4sI2A==
X-Received: by 2002:a05:600c:474a:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49ce55ecebemr180052925e9.2.1788444624798; 
 Thu, 03 Sep 2026 07:10:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5533ffbsm98331985e9.3.2026.09.03.07.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:10:24 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 14:10:23 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 2902b94906e9b21e9288d9e43b24a3c6b5775e17
X-Gerrit-Comment-Date: Thu, 3 Sep 2026 14:10:23 +0000
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2776685b6a6c9333b2cd27b5d895cc2fd7087cdc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2899-0005jb-Ic
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support pre-existing
 Linux DCO interfaces
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0575324418057711685=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0575324418057711685==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yMmxALimtkI="; charset=UTF-8

--yMmxALimtkI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

ordex has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1734?usp=3Demail )

Change subject: Support pre-existing Linu=
x DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1:

(1 comment)

File src/openvpn/dco_linux=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1734/comment/7e75250d_200e5607?usp=3Demail=
 :
PS1, Line 520:         int mode_ret =3D net_iface_ovpn_mode(ctx, dev, &m=
ode);
how about moving the (re)definition of `enum ovpn_mode` (and its ifla=
 friends) to networking_sitnl=2Eh and make this new function use it, instea=
d of uint8_t?

As discussed on IRC, IFLA attributes are a networking thing,=
 rather than truly DCO specific (although it all overlaps)=2E



-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246=
f48d0bc81
Gerrit-Change-Number: 1734
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_=
lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom=
>
Gerrit-Comment-Date: Thu, 03 Sep 2026 14:10:23 +0000
Gerrit-HasComments: =
Yes
Gerrit-Has-Labels: No

--yMmxALimtkI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1734/comment/7e75250d_200e5607?usp=3Demail">Patch Set #1, Line 520:</=
a> <code style=3D"font-family:monospace,monospace">        int mode_ret =3D=
 net_iface_ovpn_mode(ctx, dev, &amp;mode);</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">how about moving the =
(re)definition of `enum ovpn_mode` (and its ifla friends) to networking_sit=
nl=2Eh and make this new function use it, instead of uint8_t?</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">As disc=
ussed on IRC, IFLA attributes are a networking thing, rather than truly DCO=
 specific (although it all overlaps)=2E</p></li></ul></li></ul><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail=
">change 1734</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/173=
4?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1734 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_li=
ci &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;anto=
nio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Thu, 03 Sep 2026 14:10:23 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--yMmxALimtkI=--


--===============0575324418057711685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0575324418057711685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0575324418057711685==--

