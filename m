Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BC2C9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qkcp6RnYZ+unOdAakQoE2nFs5Bh+3soo2lSiL8FA/pU=; b=EAfQU7lenLSjcMiGZvcH78KaJk
	voJhPGEFAOwAS/N9VZCjese2vc6l/cz5i7bc4wBWDfhkWAo+hLDELTG4gZ5YGLkAfbWKhD/nU9L6Z
	YSKpJ6md3R4gSlnFH+74ZFsywn1PVYuOCJSKiXyd/eFmAi0TGMy0eiCC02fwI6u/kqBA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9Tnq-0001GQ-Dc;
	Wed, 23 Sep 2026 20:42:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9TnX-0001EZ-Ve
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 20:42:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xi3DmSfpResJdgT3cAYVgG2ETHh9pI/bIMZgiXHXYKY=; b=HoD4vB9dWh+9kHlPgdxgbc6vuo
 mz5YHMQU0mZISZWRC1q6rdTTlRJofNf3SrbHUy9vrViO4/FZ/ujqjv68yuXEy651u4aIpRpgq4vom
 teg7L6BQ4Ba/5sqKI6GoL5eZG/osBtXnRTsx1vngfKn4WNS1x3DlXWcSwu+1Wc2OD0Lw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xi3DmSfpResJdgT3cAYVgG2ETHh9pI/bIMZgiXHXYKY=; b=i
 RUgHnB+W4qCtuQgJsu6gAZSBVPyaiXl9+g9Qm55ocICJ2kWITnlFM7vinclm4mqa4l86swyLHuOyq
 dOT6qhmYRePK42ODIq3HKQSEFeQkTyPp7f4JHcE8KfN2schIbp6KreMYGjRAWP9ZSBQDtRDLbBgTY
 bL18RJsTYMZsc6So=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9TnQ-0001iT-31 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 20:42:29 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e66390995so8694745e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790196141; x=1790800941; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xi3DmSfpResJdgT3cAYVgG2ETHh9pI/bIMZgiXHXYKY=;
 b=MC0esVMfQRmAls+Itb9aXhHWaU15lCSg6/qllzb+nTOJqbGWxJE/3euxOkIsUNRU8J
 DMbrleWbL31JASxrSwDnYHY8Lxg7H+JItoy0QtaW4djupyP/KG5coY2nSAQcHWuMzI7Q
 rbJ1wjfS8OLT/7+iL2WsVMnI3Hz4fISHCvve86eQ6Ar1Ybk2jeLJ+dtVcfLhsWBnDsh8
 A1MyZbiDRDziUABjSdzV8pKJvbs2/gm59Kf06xy0CKhSgqpXwhUERmpUsb1TOCF6vJbu
 Voj1Vs5il4P1pC2slpchEe7UKKZLLSn2EmNhSYJlwxBb12b7CVMtsOpNHYNX8J99mgQl
 rcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196141; x=1790800941;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xi3DmSfpResJdgT3cAYVgG2ETHh9pI/bIMZgiXHXYKY=;
 b=EG18ZrzEt2mW/FpKs4pPLmDZWdUYeFgjvSakDc9LkOzYIBHpSa2efYKXPP1CCq+32I
 R3gav1H3NCj+ewAlOTvkhEUHWh7MbDt3hKRMeu+jTX7pcnnGJ6jTR7EbtwVFUolwAmM1
 uaKNg52ktXRSGwjnRkxgo8ItCPHMKg0hO4uuFPUasvggcz+rzTX2W/uaiEDlM+83ervN
 xWtqLUEKyyFz1f8YERU6vlIAHxR3depZk/wVY1OV4zhFT7/X5cAT73wVRiirjD02/+kg
 iRIXrJ5uoBdvQE0MEVyh2YAV3TW84C8zukK6+TTQSZZUOkTg7asz4npfc619+KtgQH6P
 ppmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2ZhD/2f53odaNt4Jmz9SnufNs5dbcr8z+jTfGiwCsCSKW+JGRVAz4o1M9Loz1G88TvtnuGhVkX88q4oXO@lists.sourceforge.net
X-Gm-Message-State: AFuF++kTVGKiMFn+pJorFgKVTkAWqvvuQbzO33c8/Ojqb/Pv3TLvPGqW
 czpZ96FG1bt4x61fSRog8plOM/BNLTaLviSy5GB5XbCRL8viurQp04Bq+paIEZ7tN6bfp9uenhF
 tCDz7jKa6l/BcSZ5DBEHVYLoPe2Cimf0NNhUdv9w/dBaV3kWaJhXFAtR3qP2vsYGNsoy6
X-Gm-Gg: AYBFou1B7DusLjpBli6iy81Zo3KTwiJzGhwXMpAoWyy1n+Sa9Sw2qbaKskBfDuX9U6W
 66k06fjtf24YmV0t/HqSOpCTWhOOhemw2mCXXhMIcWBx9CZ1zLmThkur/SYtTqB697LJShxoA5r
 prFU5e6/163p7/R8gSqvfD6f1UyK+5lPrGcJk8hJ764vaudq46kX1x20O7giIfvoPFEHq7olahM
 haA0gq1i5Ua4kZjnAxR2Sqq5RNe5F4pdbhzsGIGOfjzGchwO4/kLyN3ISxk1nVFvYsAn/9fuzVA
 rJDeG8aLP8FSBSpV3KG3vHd0s07lLqMnE6XuS6FsE2a+X0PzvBtRB2fYaV9xuFDDKnrkSjv6QId
 ha83RBdeHI13rbtjzugWRCCWc3je6taeMBhIkoBP3k9X56jgpzv475rW/LiIhEXAnVw8iIlr9Q9
 5TE/+22RRqeI/I5+y/Fml4EE2B131QydnflWOJaOp6ld9PAJH1MNYHpSafvbr/0HM13NwhlzCFR
 WTSX3Ji0iHBdRFxcv8RC9Q3BDsA+o/Mmm2ClnuRw71xEvCMfm5TclBZbV0hNZxReZEZXrnAh6yc
 DGl4BVt3Su9wSikbch7FYiyiehjIHhtXCFZpj4CfqkFwHgHknHar20WOrGg6
X-Received: by 2002:a05:600c:3514:b0:49d:2536:402e with SMTP id
 5b1f17b1804b1-49fe670657cmr5038975e9.30.1790196141427; 
 Wed, 23 Sep 2026 13:42:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4271sm20733915e9.5.2026.09.23.13.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:42:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 20:42:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
X-Gerrit-Change-Number: 890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/890?usp=email>
X-Gerrit-Commit: e064870a823d64266e703fb724cb088f366f593f
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 20:42:18 +0000
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzM5MzYxMjA0MDAwLkkyMmU0YjczZTc0NGM3NjVhNDNiZGIyOWY2ZTE4ODEzZDEwM2VhNzU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e67ca2a256f70985c17ad08b5cea2c09650c3ef5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9TnQ-0001iT-31
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Always use a
 0.0.0.0/0 default on Android instead of def1
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0250048442497634912=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0250048442497634912==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qedSRrLlro4="; charset=UTF-8

--qedSRrLlro4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, razvanc=2E

=
cron2 has posted comments on this change by plaisthos=2E ( http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/890?usp=3Demail )

Change subject: Always use a 0=
=2E0=2E0=2E0/0 default on Android instead of def1
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Patchset:=


PS3: 
> I've tried to follow what this does for a while, and I'm not conv=
inced the change doesn't have unint [=E2=80=A6]
Android doesn't actually in=
stall routes, and remove routes=2E  It passes the route list to the VPN API=
 which then does magic stuff with "ip rule" policies=2E  The default gatewa=
y address is a magic marker ("\x7f dgw")=2E

This is one of the patches tha=
t is used in plaisthos' VPN App, so "it is known that it works" and the que=
stion is more "do we want it in the upstream code base" (and I didn't move =
on it because there was discussion on whether we wanted to restructure the =
whole redirect-gateway thing anyway, on all platforms, making `def1` the on=
ly available approach)



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/890?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I22e4b73e744c765a43bdb29f6e18813d103ea757
Gerrit-Change-Number: 890
Gerr=
it-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Comment-Date: Wed, 23 Sep 2026 20:42:18 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2E=
org>

--qedSRrLlro4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, razvanc=2E </p>
<p>cron2 has=
 posted comments on this change by plaisthos=2E</p><p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail">View Change</a></p><p>1 co=
mment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?tab=3Dcomment=
s&amp;usp=3Demail">Patch Set #3:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I&#39;ve tried to foll=
ow what this does for a while, and I&#39;m not convinced the change doesn&#=
39;t have unint [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Android doesn&#39;t actually i=
nstall routes, and remove routes=2E  It passes the route list to the VPN AP=
I which then does magic stuff with &quot;ip rule&quot; policies=2E  The def=
ault gateway address is a magic marker (&quot;\x7f dgw&quot;)=2E</p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This i=
s one of the patches that is used in plaisthos&#39; VPN App, so &quot;it is=
 known that it works&quot; and the question is more &quot;do we want it in =
the upstream code base&quot; (and I didn&#39;t move on it because there was=
 discussion on whether we wanted to restructure the whole redirect-gateway =
thing anyway, on all platforms, making `def1` the only available approach)<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/890?usp=3Demail">change 890</a>=2E To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d10=
3ea757 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 890 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Sep 2026 20:=
42:18 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D=
"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>

</body></html>
--qedSRrLlro4=--


--===============0250048442497634912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0250048442497634912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0250048442497634912==--

