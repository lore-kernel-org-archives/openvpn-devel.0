Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4343CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J7iSYyPYFVeIpBc/AB7xnKdh5rx/F3QJCADI25G3S7M=; b=d0E1drKeyd3RUhZoVVV/B0vmUK
	QNa4WKpbUbkYVy/EP77P5yNEI4u3Mp3u51VSfbr9ok3coDf0Lntk3e7KkC5cmZkUoIK1RdzWMFliB
	qTJgfgy5z9CJmU3REdMx5/M765USCkb+9SyXoMhPA6oKwFQlIegV6/qZzB8hfQyNWcvU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbejD-0001LW-39;
	Mon, 22 Jun 2026 13:30:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbejB-0001LJ-Rm
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:30:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Ok5kZsa0p5oDF+5JN5pEaJd2ZMwb4teomYGb1zYWIyg=; b=iFEN1XJ6KUUywIFxgLQ4ZiT+Id
 aOBTuR3P5kh35p59mUQCqMbJaBunZbX/CHk77sGw7gIM30BBAIZ4LYK2y/zu+MOMRQAlixe44MdBz
 0L2DmKqqcKLHJ8uyR0joTabbQCUFRLFeDyNH930BU6qXIal5kyBYx6dsI0VuWZ7g/SoY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ok5kZsa0p5oDF+5JN5pEaJd2ZMwb4teomYGb1zYWIyg=; b=f
 D6pVKe23irVaNoQupExvphugmLRqjgopaIHTNLsUG8Y/a+nwpdUGDempm5d7bzaWa/f/TDVRMLvQv
 j0kfPOqzZTRlWCpOjgwG0d3q9cdiKRFmPI9tEsLjEMJp/waEmCk08/6KGLjWVrf2653LCXXPgwng4
 AEhPPtz3krzRn5YY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbej9-0000x0-GM for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:30:18 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4923fb1f095so31963405e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782135009; x=1782739809; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ok5kZsa0p5oDF+5JN5pEaJd2ZMwb4teomYGb1zYWIyg=;
 b=gGHXqLoPh2GUPMXx4KvHRkeDqCdQpTdal/G6w2+nznwkmi+SkOStif2xoQfTdfKNEo
 BnipBaaFbtwX6mWsoETEn5mG21OfENKOoH10ylYWJLYNNAhtcEIH+JPsYFZD/LpBKNQS
 DnoMUG6KWdVMLvLqgoXdOmle6RdJGngwOeWZ6SHCpbc3B00CGeeBnUL0Js8DQXYx4JgL
 nQKpsqYR4QTJZtA2wuQLwK8KDWzx/FrY79CKSRe2y73Fb3F7/5mhSryacgD76UyVQLhj
 PvvYx0mtxygY8CTvjJBQL2qiOHPswgUtAOlgqUcdUWxuBkCOiFkLfxrvoadcgnWTiV6U
 DUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782135009; x=1782739809;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ok5kZsa0p5oDF+5JN5pEaJd2ZMwb4teomYGb1zYWIyg=;
 b=lIG/yCw7Yg1/maN7JfC7UhRWlZOIfl108fnNl948MM63q+YmEfn1v6DWRBrocZkxlA
 2Or8O1nbw0HgsGb9Geki2Lc1/lPISWacCBCDcSmf1Z5BRLkTUK8ogLWdGFOP7QO20ID6
 OUR0QwRbnzAiF5OyPRwobKOG/HUgQLnDO5AtseXPaPkAsetU/IeirW2AhPav2s2oNar8
 hq4iU0lTSGmujGRXv8vxmOqNq96R5PxkaMplwVIyq/+T7MHokcFGmdf70VxGjlpgc4J+
 wIJicw+JU+YkBHlv43X+VIBtwyrTHTXhyplUQFog4UDw2sh51D2Fh16E4/pWbhbaLzIG
 9LlQ==
X-Gm-Message-State: AOJu0Yy7rue6Ba7Gnbr3JZRcdiAFiF/xkiIeBx1oqnzchFy9Z7J4DRH1
 WuqJRNr659OiG5TJj2xecs/ZGmYczPAvItJgxs0pkh+kbt5I1qbTw+DLesJb1V0mo5IIl3hS8BM
 DZUPD/JpQK942lbnFRkFajW8/TkUZloz30cWKEYFXDe3VEbxoXnYuxdvAeQp1lAKxnEn6xcYSqs
 Mz5jx7Nw==
X-Gm-Gg: AfdE7cl1oj+E7v+JC5Rr9nISQRewmZ42kq8fi/lzSh0srpiitlC8Hy5CsbJGm4KsoGu
 Q5cieOYMEgXnEp3HawXXrzGcAfUUrLP2YD/1OW7FusB//8SZ8HhEbdVfjqTYZgihpW9jbPwkJfq
 hSBGPKMu6chl267dhW/Dt44wMWt343D5pkVLNec+ukKVx1Y1bG2cfyPyeDTeQTvORsRYnGVXju4
 38SLSNqVNmo4yP4pe+UYHmkPgf0K/SjDvsNL+hFFjbnJQ/DdTXkWorsVnl/OBHLp58G/MGbdSyB
 5dJ4hXbjIDPNedES7dNfKKcUMOxHWlG/51HVyMLKak9eyu/NKbMnhKzwHx8cmRDngvf4JXLCTlA
 JGtfYfQb/D9Ig7cOslSjbMgMF6ZO/nuD1BSv6yUgKd1db2+/Uh+4yEKNIxFiPjih2S+BRwQLyQ9
 Ly6FaY86Ryi7bZXfooZUD7PJ6mA684u1Bdtbg/Y0wGvYzKdgOi7rUPTls1ghqH0Q3Etv4+Wuav7
 gabSwZBEXHoYUcOrRo5kUL5O6PdZm7aA2pdS6rJWyPcd4rD+63cKyz1Wig7GSsyj9UXFBtRXP5D
 LEeuY5qfsw4U5g==
X-Received: by 2002:a05:600c:5290:b0:490:bcf6:469f with SMTP id
 5b1f17b1804b1-49242189b1cmr222640545e9.0.1782135008018; 
 Mon, 22 Jun 2026 06:30:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923914fsm222521975e9.6.2026.06.22.06.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:30:07 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:30:06 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
X-Gerrit-Change-Number: 1634
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1634?usp=email>
X-Gerrit-Commit: 33bd7335b992afb622a221bfc707cb2b197c4609
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 13:30:06 +0000
In-Reply-To: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
References: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzY4MDAzMDAwLkkwNzM3Yjc2OWU3OGU2ZDI3MWVjODc0Y2FkYjlmYmQ4MWJmZWZkZWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <91900fbac9f002ac233adbab384524556d262c25-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbej9-0000x0-GM
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Only announce
 support push updates/IV_NCP when actually supporting it
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5169265184310138749=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5169265184310138749==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8R2Xzovbj4A="; charset=UTF-8

--8R2Xzovbj4A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1634?usp=3Demail )

Change subject: Only announce support push up=
dates/IV_NCP when actually supporting it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1


-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefd=
ec1
Gerrit-Change-Number: 1634
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Mon, 22 Jun 2026 13:30:06 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--8R2Xzovbj4A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1634?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail">change 1634</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0737b769e78e6d271=
ec874cadb9fbd81bfefdec1 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1634 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Mon, 22 Jun 2026 13:30:06 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--8R2Xzovbj4A=--


--===============5169265184310138749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5169265184310138749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5169265184310138749==--

