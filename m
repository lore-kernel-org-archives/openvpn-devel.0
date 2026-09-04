Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A7EC79F80
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9gzDh3ZOdY+diNaxF0MZZZubCaGFK0PFcR086pnraEo=; b=FKAnXuIwbcdSAiuOAGuQCiTohA
	/VR9EMBJBUkdBwHrQiuIyW2IqmTD/Gak6Uk2M9riCQIeLjc7niaDDUNgOX3OE6ZzUBV2w53dcPBiy
	Eep/gded/SwFohmVnEeRnuwMO7OjH4CT6mmOz7dxsAMcqDE2Xwo/uxn7wwQR+73dSVkQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2Qbz-0007qd-P5;
	Fri, 04 Sep 2026 09:53:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2Qby-0007qX-Sx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 09:53:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Jrk0nqUKbIlJil+VSPeuTTaIMNXTZPlCQiQSoiq0DvY=; b=m+K/VykrK/rK/JNV609FCgZcI2
 BxfSOZ+zQnLhvvEXrG/arOwX4RWgqAKemV4+DmPV07Vs6ayRAmPkddckCSSkrbuc4f0eQUlu3KvDk
 RqmLRH3Y5cMJnLrEUTE+3AIr1y1SY15arUVUyEJpoOOK9PwPg5osZfwaYxQm1YXLMh/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Jrk0nqUKbIlJil+VSPeuTTaIMNXTZPlCQiQSoiq0DvY=; b=f
 rkDiwrPWmYDgeXSSNBTcukTZe+mKDM3+x8Ny6eOpvl+6VIkdhd+4M8QSJnlpIaIx30FIHcP41cIQK
 Iv/5OtBBULEXccO/TPzqqwnsbOvxygkznMRpnL5y2hDQG12JM4bgEYTudufiaDn3TlMPlC7gXMjTz
 Gg8TY9YAvzti935I=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2Qby-00005T-8y for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 09:53:30 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so476021f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 04 Sep 2026 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788515604; x=1789120404; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Jrk0nqUKbIlJil+VSPeuTTaIMNXTZPlCQiQSoiq0DvY=;
 b=dV8NgoI4ybebBpo8fnKDwZRo0M9/b5vWeU9msfEcxoMeFI9N2qv3BVERSB8RTtIVt+
 mBF3fsA2LRTxjwMX6G+SZSmToK0TU2uKWn5tRC8s5HaBfBtdtZ2fTu4ZKuWshtQswhqL
 PGDcMTbYhVtCg7mVX7xsak2hpgQbQJ8BW9dV5MwcKf2sZAtxyCS28+sj8kxymz++Zset
 S7EMACfZOu4tfgfMwIK3NCwh7T1qJq0XuDZzDUq72yVavEan8HZst6qx/u+cHaAc2CiQ
 N+EL+jz80oPw3EZV9Rq43Y3kqFfovSIGZIwC+U9x7PD0JxCBG9TkSLNYUd80UnAykG/9
 T5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788515604; x=1789120404;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Jrk0nqUKbIlJil+VSPeuTTaIMNXTZPlCQiQSoiq0DvY=;
 b=fsmIYK7PpkaflaURxQd1cKiCwQ9MP1HFK3S5Gw+GXHsRovyvsM/huvd/OKR042fJKw
 CVTvLB2GNNtcW47nCjPDL3shzfzLpC6ak8B2s3CzYPKOrI6O/HSNqILZGQyuR+5AmRca
 8PulaZSC5pR9xwAmwISH+Ug2CT0PFTfTpIbPnN9GlARnCvLY/Uyjk/Y6H0hsI48F824G
 WN7/gjaF6bE01LFxIU7mpvxRL7+7lJuTyMSoL9/Z5/jG9hNnq3AU92hJ+E5MMJpzAtrn
 EK991eZ/sxQPdqE0SlKClSev48NlbsmVtRdbSeOOkDeBvMMZZZilGylwP3Yhc599uZgu
 MyrA==
X-Forwarded-Encrypted: i=1;
 AKwUvByGhsSLT0xPGpvVxFmItCEyg1TKjunXIxQ0qa/vJ6ZYXyv4GxHNtRkikSIIPZd1/NUs56CByPAM+RIGJMl2@lists.sourceforge.net
X-Gm-Message-State: AFuF++lNzvUSB8CqANzBQPfq7pULj298p1EtG9RglrLXbVLhcJT1u5z+
 U1A8nvZopAOHShQN6fJ2G/hieQjUQdiVl0akjXJbZ2RPCsL8VDaDRVR8l4yW1sLb6vRL8fabVXu
 e70DXolWEQaEVKuM75syfvj9nXtALMM98HiR76PN23E20cYMT+uOcvol2kgwK7e6H9IsQ
X-Gm-Gg: AYBFou1OyGiGia8Ylx/Fncp6eMw5dziIpDmp/jeyjQtjcYjjqVa3JLD4BlmrLiQWdBm
 sQN6d39q6r8RiJV1p5KMf+lBgjBSVbTSQX9p+87uH6j5e9NPrnhVjqcUeuAaXYav1lSCDFF/ls2
 S4Ifho0183jgi9UD48MXQ4sJnrVehW6v4ciQnzmS1SP4qkn3DOHg3jKpTBoDDk5//J8C5hmaoSM
 A4MuZnl/Ip7SPdIgFhEMrDQvursg7qJtJxvcq4ysdV+XpVhG/Zm6S8ZWa+ddS9EC+ck4lf0ROP5
 vGnKML2/ri3mmbgt4OPx7mMVZn74+R4vNzxh/Ufdeup3QzyDoasNwYgEBy/o3ZxykbWXqS/ihyX
 bxcJRSJrtT4AdEBsoNTsvYK561quAROh25H7GbeoHws0Du4Pw9GOXz2HrnTIHiGVR9oZhnrYImT
 T5Md8MFa+Y7vbKxv3HPLiVOKOFzMwwmLPFJDQJmsd/5VyheS8WVDacqT7exP6944TDIVCR8qErx
 JXYcDSUjiUYxZxWoIzpugU3LLuLYsbJAiKiplMluqbHLS3IlYam4ealoOAim82bljJhoYwnajrQ
 G5Asj9YZCTrYAhii70SyDxpBLaPoYDN9OfDFQ4Q74I49dBSA7v6HxuW2ZyEPt17M
X-Received: by 2002:a05:600c:19cf:b0:499:726a:a017 with SMTP id
 5b1f17b1804b1-49cf7fe601bmr43161125e9.1.1788515603531; 
 Fri, 04 Sep 2026 02:53:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm381583435e9.0.2026.09.04.02.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 02:53:22 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 4 Sep 2026 09:53:21 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 5c8c4bf4b9c7a4ab34c99e6b899c0d939dc6e479
X-Gerrit-Comment-Date: Fri, 4 Sep 2026 09:53:21 +0000
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a75c948e1bbfa2be7408271f44896c3d228929bf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2Qby-00005T-8y
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
Content-Type: multipart/mixed; boundary="===============8827008630244125807=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8827008630244125807==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r+seFffSmyM="; charset=UTF-8

--r+seFffSmyM=
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


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1734?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
Gerrit-Change-Number=
: 1734
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Ge=
rrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date:=
 Fri, 04 Sep 2026 09:53:21 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: =
Yes

--r+seFffSmyM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>Patch set 2:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View Change</a></p><u=
l style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">change 1734</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I72302=
403bddee4b0b0ee2441ae9e246f48d0bc81 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1734 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: orde=
x &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Fri, 04 Sep 2026 09:53:21 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--r+seFffSmyM=--


--===============8827008630244125807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8827008630244125807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8827008630244125807==--

