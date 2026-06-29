Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B315C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9RUHfPOMNuMZcixzMHEQgYbhYjJPNyF+L5i4/+SjM8=; b=PEEG2TmSLWYE/tlALvvAyXV3+j
	Pwt/xDvBx+l2wTNocbA09yIMdh2ze78VEaRvjBnf/Am9Nc8SA0gA+tEFHdpKQ/+nTadnxCu5qLt/b
	t644xUJzH3rBJHvc488h7w6FZVSW2tFDDSFDNoAAbxZEtafktgpZUa3tqh3NzYoOBg5Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we7Y1-0006Rt-Dz;
	Mon, 29 Jun 2026 08:40:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we7Xk-0006Oy-PN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 08:40:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VVLstGRTAYFfwAfydK2j+p/ugqrIaQXO/RbNAr+NOJ8=; b=Xt+WKZHBg0rUdiGLDjRRUXU0PQ
 vPAZqsRG+195U4YdThElqxpAdCWhV8xbKbI7DMqzWwgqTZytBC4l4mLZc28tJEURH5fCN0ge0BeJa
 6/CwdzySnikFJQAVr98KpWzNMlXH1Q6FhVQ9IozI+vMQtOf8THr2L6cd3hFdwGETU32Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VVLstGRTAYFfwAfydK2j+p/ugqrIaQXO/RbNAr+NOJ8=; b=k
 3GO1DJGEUcBMc8JK8Y/N8Sag+tgJnG7QP9pedrom+Z8gMvU4lOvtn3OFoJUAd3w38gIQKa2BezvU5
 75WXW4W8Llg24+r8rMrPnh2pjQxBRUiMk5Ia7ScU4EoYEV8CfKD7kst+zVtq07zhicOVcyojyTdZ9
 nesbkATUTA4NJc28=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we7Xa-0004yl-KS for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 08:40:32 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so3510915e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 01:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782722419; x=1783327219; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VVLstGRTAYFfwAfydK2j+p/ugqrIaQXO/RbNAr+NOJ8=;
 b=DRmO+rkFbqPicuODt/8hufYL7GJXXTfaeQyPY6I3dCX75iPs917j2/WuuV60VbX2SK
 CRHIfMzJtoWh114ZuO+aTiMXpeHtuUrnJ1Ms+34H9ZRfoguZsv1V2AAcURDDYdFuBsBW
 sedP1sDTaorvi6781gDviBXhz/w4EfDys45LF/M12qfHR2zpeu2N6JJDrAM7dnzDWd7h
 79uN2t4AFAguygGaS0cvej7jciLoSxNbtzCPZkdLHANk1AgrKqEgvp1V/fsHol7U+bhJ
 u02UAFcJDO50sV8ikV19Il0fxXJ0g/izhoUbm0xVUJMFlu82OezgZfa+7EnuR/UftWLr
 L7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722419; x=1783327219;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VVLstGRTAYFfwAfydK2j+p/ugqrIaQXO/RbNAr+NOJ8=;
 b=L78dKSnXxQWJRo7FK4SiOjHRYGv7kV0w5TKwSC8MNo6jTKDAlWPefATsy/EbzUppm4
 dyWZQIg+rovoC5HOxn5MApMUJA8BKMGhBWQ4Vssb56mfstJo3g9mQQUS41TrnQKwaiXV
 nJ7HDYo5z25gO1Fw5whYQd8wQZyvXm5mhYuRiTvvCLn07RtOcIlX8B010hnBS+HIGih/
 AYmnBYYDfJHfjOzW0sJugr5RpmbCFM79e3FTtripEKaOd5NZPBcbx15mwE+jpW0FDNGE
 4k57DEbry1b+zhgqQdMCJl/1A4SnQ05P3i6IuzomoPPZU8BzIo5yp7s4A3yohfz1YB88
 01/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrrh224fttvlpwwUlBHiV7k7rZb5RhYUX1Amf5F0p4i6sVRIdU8hIGuGlpcJf5nXq7s7DnTpQM4OsLJND0l@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzs8j6jykA/dYOaEzF3XFSB//GcRxTpy9BeyyVRbYh0D372wshj
 h3IUb6gBdRa4kbnOyjBekLscW8kY5td87PqzVkAq6Fq1Dgy4V0KPjxWC3P9DvZeVY7WiOVCisBI
 60ijaIRANoP/eVhWggCasqKSBEeXbu3pFXsQ7wGLN10b8GY9yu7Uu5F+crbdx/Qq2LNmy
X-Gm-Gg: AfdE7cku03V5EUnc2gj6nc3fQ52OsHIxP314fgrQMt1AhQD6zqMYEon6WxmYe7ih6sv
 5HNbr9vonEuAFi3MC7dqjckpgZ622P6mfy1uTSeMO8QnrjUalsyAzqO21eVeYgtGJ867B0cOfUD
 rxW/LpyTzsqd6wzDKu24FrujzJMXwVy1gxOzQRJX+b37QM8bhxY5VWltt2RdVuW4vnTPaEPfI0G
 mSM3c1aJfB/WEayDCYOHZO576kbK66MFzE1gY+yKWilKvzFqGW9xTHrEzxCaae9ppLQ7vkgCH29
 mT1YkNu1NhyNNnuWpZ+tIe/2Ti+CM6TGr+ffstPBMHB/GVJwddCM3jvH2rXu1LnUZDuQBmOVhbN
 vxdj0L67Gx7lqN58dUrQfHOC5XNPv+956mVvuWW1TyonEdw/bqk5Zushq/6fQgABM/h9NlNF2w0
 wx44VCKPFARlmXqEfywLKrzYYa/BwRjRQUyWcL7+MODpxEPV/Z/qoooB6hfTQhuq2pJOeuS2y0W
 DQOavMpjNhbPPhAesNvwu1FArEwntehM2vKuZdq0xcScO8Olm8O4/5Ds9SIbIHcu8vExMFBhjBJ
 UWRW4uMDK6720A==
X-Received: by 2002:a05:6000:2509:b0:473:66e2:37d4 with SMTP id
 ffacd0b85a97d-47366e23aa0mr5052841f8f.27.1782722419373; 
 Mon, 29 Jun 2026 01:40:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4726b76e6f8sm17247910f8f.13.2026.06.29.01.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:40:18 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 08:40:17 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
X-Gerrit-Change-Number: 1736
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1736?usp=email>
X-Gerrit-Commit: e0ba79507431a8c970b721cd1413d32c64c15415
X-Gerrit-Comment-Date: Mon, 29 Jun 2026 08:40:17 +0000
In-Reply-To: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
References: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTU2MDk5MDAwLkliN2Y5YzljZTVlZDc3ODE5MDQ0NWNjNGNmYWE4ZjNjZDVkMTExMGJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ace09c35eed4dce2225eded54eb162b066df34df-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we7Xa-0004yl-KS
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win32: fix plugin
 trusted-dir check prefix bypass
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8029680107295642370=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8029680107295642370==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="I4//NuNALFY="; charset=UTF-8

--I4//NuNALFY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

cron2 has posted comments o=
n this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?=
usp=3Demail )

Change subject: win32: fix plugin trusted-dir check prefix b=
ypass
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1:

(1 comment)

File tests/unit_tests/openvpn/test_misc=2Ec:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1736/comment/d7d50c28_3bb0579b?usp=3Demai=
l :
PS1, Line 492: 
this upsets clang-format, alas - if you move towards an=
 empty opening brace (`=2E=2E=2E =3D {`), clang-formwat wants the rest with=
 4 character indents, like for a normal function body=2E

I could fix that =
on the fly, but since Arne has other comments, please do this as well=2E


=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib7f9c9ce5ed7781904=
45cc4cfaa8f3cd5d1110bc
Gerrit-Change-Number: 1736
Gerrit-PatchSet: 1
Gerrit=
-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: sti=
pa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Mon, 29 Jun 2026 08:40:17 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--I4//NuNALFY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1736?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File tests/unit_tests/openvpn/test_misc=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1736/comment/d7d50c28_3bb0579b?usp=3Demail">Patch Set #1, Line 492:</=
a> <code style=3D"font-family:monospace,monospace"></code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">this upsets =
clang-format, alas - if you move towards an empty opening brace (`=2E=2E=2E=
 =3D {`), clang-formwat wants the rest with 4 character indents, like for a=
 normal function body=2E</p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">I could fix that on the fly, but since Arne ha=
s other comments, please do this as well=2E</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1736?usp=3De=
mail">change 1736</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1736?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1736 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Mon, 29 Jun 2026 08:40:17 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>

</body></html>
--I4//NuNALFY=--


--===============8029680107295642370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8029680107295642370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8029680107295642370==--

