Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEE6CA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c+4KuZc6ELWqFPF7kO+W49sC2a9o9vCD5jP/aXZY06g=; b=NTHBcBgo9yvhWTI5WsHt89c4dy
	XHLxsKiANsY/JKF6qEJNpZW6WbQYceESJYg1ZdSYh4v6ZgzfMH4Ptc93PGalURUUPapZGwtnEzDfq
	wMjs68UD2djzUoRWZ5/M0M5F7JYJy2OaQS5gq6b7pP6aLFFzB1OgfR+CiTYI8GBzfBUo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xB9dm-0003ei-Bw;
	Mon, 28 Sep 2026 11:35:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xB9dl-0003ec-Hs
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 11:35:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4ikdDgBjAIiaKDHuwDT7u4u91+XJ6N+elPazHbKaWpM=; b=JNitIRNONR6FgpkU55F7mbuFsc
 jc0sR3ZxuRtA7uyhFuaPZnZnsu++o9V/AXiCkuqXvcD7YbZE+xg6jYlgf80p7EGjma7J6hs4SLC6n
 kpYoRthXI9kT3/8MkDBE3CyikmGecwSPLKkgoy5d/QGHjjgqJI0WU5oWUX0h439DX6Ts=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4ikdDgBjAIiaKDHuwDT7u4u91+XJ6N+elPazHbKaWpM=; b=k
 dkRAm2DYuN3ux7AGw1e2vpDGEdstOseCXmumCDU2PrZQsQPpG4yc7bDloJc34dftUwcBk9bzoxgWb
 FXXVdTsAeZuv7ZUqRlB86qyUEjpnVLh0wihzEdYujhEe5Vmh+MYCUcJfs5rrBIY2ZseoRGbd3lQk4
 X3sycAj2zoAB1SLs=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB9dh-0000M0-Bp for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 11:35:23 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48439feca17so2218869f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790595315; x=1791200115; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4ikdDgBjAIiaKDHuwDT7u4u91+XJ6N+elPazHbKaWpM=;
 b=WttOUjWNsw7kdwX+HFLaQgnzWFEpbvPyyHrpL9wZn6oo2YoMaFNaggP1crGHam5sjP
 hTcdT2m6G3iAqjopyFu+DPJMzzr3lOp1SQX2ILWQnhdFkVmmS3mShPUNYHi2oJgIIQtB
 q17L5NXwah5SCpbEUpSbpEmoAHefV3fMZkkiQ+fkQMVJHrCIc91z+yyVVIoU2+QFxAXs
 RZv6KYwIPosVpSwV/qh0m/8mk+xvNO3FecIOEVIPRg8FKQ024tl6wF8dkVbj4rPx0eD9
 ciylf0qL0L58ubPE083JsVV53VRHgHoIjgqDthXeR/2I6OX/vhQ4o7PztXMkUkU9DkKr
 a0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790595315; x=1791200115;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4ikdDgBjAIiaKDHuwDT7u4u91+XJ6N+elPazHbKaWpM=;
 b=Ww2f3wDJS6N9FTiNOzCOAI2vK70/MqdrUtOOLOA9pgPr0l2zU9r7AZ0qKemdr2ddBR
 R+uddPSGqzT5/bRwrzOfQ9Ilyoov3pUHJCYUpeFpsS7PvAkyGL/GWJ6NsEHmE53xwGRq
 Q//kn0m6E34ohXUlkWksD6UvPFPpJVA9mJgnznGuNWP9HQyFgsLDztfksYUjLh2ZWk/z
 PXxfTAWLAapmdD+2bDlm6OhoWXfreu9IXC7uoR5CcVXc3Br3QkmggkN+WvGR3n64paeM
 bUF1IsjzFYqchQdk4skdtwW2uydiPiqArUD6fG/flzwVdkqF/Cnxg7A3DgfvsYXYlkCn
 mGaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcUsoDLIxDHCDcR9wvwt+ef5i5doUISF7pjxNPVlQlx/DQH7dqZHYtAlBxY6wOK8icACzKYCk6r2LWFJsr@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJOgs1osQFfNKvQEuSqdayp4wPMDQ4nGlTxIUsqHG7yGWJbbqTI
 gqEKtxC5zRmTiU+zMSFXlHbw30PHWk2SWa67n6QFAKyJvXDBm/+wOhU5E6/ANbRrLBur/n8OZGI
 8ocu27BqvMAyzwa3LqsNuw9vI699m8DDZ877pLqknCZSMhnR09IUWsYDK/slFPs81m2Tt
X-Gm-Gg: AYBFou1zEBsktRWy+WVUo2viEhZnSu6fCl2j9RzUpxZX6OUoBmb3KEjsJR3WwROn0/2
 rlLAY4dbsIRbFWHi46Kds09dT/yuGyNT1rLHxaIv5b7pKMDyoPWeCR5LxR4iEnud/HExMGg2Oa7
 eCHNZh76US0v61sWIoWBS7cTgFj+AH5ogqeZdV1XQnrx2mw5aT0ZLtUp+muh1b/n7inJE93Yc/B
 UeWB2uTX/SNo9vdApVAtr2gEWJ4BOWw55XqkqWgNHJ4ICK80qYk/wGdcS96erLrQAIFUYM2mgDK
 mb60OWZzVuL8Zv0TgGwBnt/m8WnR9SvigLH03mdxy/vPSKrKY2MS06dTCLfdZPENomjvZujp//k
 azwwEjTUE018TPtZGpx3a4FC1+JqE0BKfp26/gtMobKPHO3zQxs8kmGq/nk931bVZDLbW3tskXs
 jI8E14C6nseZy2AgZt1GNb7FHRSjsRPxDInsRJ+XS1P4ViMKWqla0ZogGJZi5yKQ9OOc9jCglS6
 mzJWpNa2vnubfsWuZwvKpLQSD+PnTP1VZ6tWwsOefduSZDKnRggyXNXuB1t+rVZbCoIrdZ3kY8x
 HBsrpMuFKoJyIKvNf9pr+tjAgeZoNXEUUtSIRTO/2+yYenEziNEWX6F1Awop
X-Received: by 2002:a5d:5e83:0:b0:488:84bf:eedf with SMTP id
 ffacd0b85a97d-48884bff147mr11630176f8f.48.1790595314688; 
 Mon, 28 Sep 2026 04:35:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a640df9sm26101948f8f.24.2026.09.28.04.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 04:35:14 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 11:35:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: 569eaffaf9d78054eb750d1f32982ae90fd2a75d
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 11:35:10 +0000
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <acd5229477e1b0afeb1e5d1ba348d3f7af22dd34-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xB9dh-0000M0-Bp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: remove iroute
 at client exit time instead of delayed exit
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3200710165422491467=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3200710165422491467==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LFYBciDFOqg="; charset=UTF-8

--LFYBciDFOqg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos=2E

ra=
zvanc has posted comments on this change by ordex=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1683?usp=3Demail )

Change subject: dco: remove irout=
e at client exit time instead of delayed exit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 7: Code-Review+2


-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba1=
0bcf8c44f
Gerrit-Change-Number: 1683
Gerrit-PatchSet: 7
Gerrit-Owner: ordex=
 <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: ordex <antonio@mandelbit=2E=
com>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 28 Se=
p 2026 11:35:10 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--LFYBciDFOqg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos=2E </p>
<p>razvanc has=
 posted comments on this change by ordex=2E</p><p>Patch set 7:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">change 1683</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ba723d1=
2d433e6e020588b7b0c3ba10bcf8c44f </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1683 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Mon, 28 Sep 2026 11:35:10 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: Yes </div>

</body></html>
--LFYBciDFOqg=--


--===============3200710165422491467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3200710165422491467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3200710165422491467==--

