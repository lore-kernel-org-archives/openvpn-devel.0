Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDFDCA5FA5
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k+K6rv/2pIyyhlX8hAjzA0I5lchM2H5fYCSVW4Q7peE=; b=k3GmJIK//RYYVMQ40uts3J3Lsz
	RVW9F5jA37NsQql94NYWevOIdzXfbPng3xIlGkOGfvLAM4WmcWko0EKwaFxgaQt4cNQA3TBCV00XQ
	WcO+viMbmGvshs2zFAqIX0hTrw1pRJgqJxcMzjMpI9Q+hoBVOTrj8UZc+AKQzFUsXCMQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBVbc-0000wu-R6;
	Tue, 29 Sep 2026 11:02:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBVbb-0000wn-Lj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 11:02:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=a1Uo5zzfJy/SJspSfsXgLyMkWcfX58qJViovUR7MtZA=; b=KjflBVqshPMy1y7KsxNqsN3zwu
 uf2xzN93sYs04QKKAEDc/svQhchFZRdTWq/AED+riQemsgVjhdVxvggWm9Ln7wXqQwiN0ruZsFonX
 EfmxaP6S9mnB70r+g/HWU3yYLwI+WLI5cS3ZVZZFIL9N1FFvHfWEJKHmJi7TbtF1yizA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=a1Uo5zzfJy/SJspSfsXgLyMkWcfX58qJViovUR7MtZA=; b=F
 /98+EzT7St2l0Osxn0iG15EerRJZlUZL+0jb2m0IHLrN44QyUP7HiwddsPmUzXFFMjIh0X5jekiKT
 r7pfzfsh08rgqOQU+htpRnSG4M63HY1KkVIDS45Ig9xnF3IZAKSBviS0Qoc4cqRDjHivHmgblIOj0
 w+jgUQV6Co19Nfew=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBVbZ-0006eQ-MF for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 11:02:39 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f89so2508516f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790679751; x=1791284551; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a1Uo5zzfJy/SJspSfsXgLyMkWcfX58qJViovUR7MtZA=;
 b=Yc3FvsmiBAruhTV6tr9LBUo9salcakVxwbKF0Qr8nmWGNo1GqSeazaMIRuCjh37U42
 yQ6kby/lG1g5aNjqRJo+UQOMcoy+83oauYZNuikmejgOwaJHjC6bS+LU5dyNcNemPq2l
 v/ZD+earZYelES4YjcrF5lAZP+Jx8iSBlWgjBQgTwkDKGbILMxb7Oq9HnEOuhZA+1aER
 9SqTh3aV4/LY8TdHqn8UPmXJw2ylcRWXVXU1WzABPs2aju5ILliX4nkDywvy4WbAZrO3
 DyFMejwT+yE7MOfluHmpQpVXV8jYYafd9oNDywLcpW+75BO9EbG60Wrpb5hablNId2OM
 S0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790679751; x=1791284551;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=a1Uo5zzfJy/SJspSfsXgLyMkWcfX58qJViovUR7MtZA=;
 b=zpX9jPq/qK4QmWtpcrnJaLT6PQ4wNGMr742nB376dahKescDnLIPRACTVB50ritSce
 S8pMv/ZJapE0qib2Ms/oqht0TGw/AL4Z5WJiEUEM8G+gZqHH9xoHNLyEKwuWkZ5GvJEu
 hIaJYgApQmoDLqeUeNSODpoC/O8UQ/gnrXqgn8fc5jxBrcf5PQez3qRg/jwHO3aJ2FO/
 kSA8hseEL58nU6hID/dqWTYQmCQqqr/K2+QgklZe5aUCJzzHbJzZczgYVPV8vwSuV/GI
 KRRcMVYvCKzgTH1+wx7/7Ngc6u7U4XRDSoUyUrpyAgdiqV96tm4TNOngVAj1hFU1l1u2
 4dZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxyDFKooyohgQOL7eKGhAeJ0bO36D6l9KqONa7bCwEKtYw9SlA0dMXXRF3vKLOn5VePcXC92JA/atzFLY3@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJiWF6DZHM2VLEhxV7FITeaGPOOis2bFuSmNSw8JZZUxPvvd+DU
 LHjvfvT1BD7bzp7ScVM+QNVx72R+LlA+x3XFh9IWSGu8A01mWBBseqxND+A3F18Os/SdT7cGkRN
 R3H3Bm+qCldaEbjbvx3HW0Fv4DlWChN+j0ao+4rXQmdGHcjXx1XwKDNHpaGtMcHBFa9kR
X-Gm-Gg: AYBFou29t9VKTm+vpk9DoUDJMG/4GGFWs5aFy9OfkdKeY6022ALc02S5b+HjZFGcVAy
 r9ripFDgKOgHEF2mctaIW3fO4kpXEarKhNJNKOp/Coq7QuG6mmVuTwJ1L0kyGUHI5Hbv9EdnArg
 SHJW8qRAABeZiRkyTyWVcsgllByUHsbhZ7CYDQJUNdcbnklKsVGh+5GITtmtBwSp+e4gCERIspc
 CyGJ0BJCuoK31c4BVeS7jpaU90BLkKFKdPg6YpkcZHbnr6IdYKovGErTUbb0W1yraE8/GXHGoqJ
 3EIA3W7F6EvGvy0J9LUe7zTLvNagVwwDQQIkavy4bbskBLjaZ5SN3TJ/IUQ3FC7E8Yrtj7hXS5b
 MAaZLJiHPJkZVwgaN90q9t3nVo9+pSwA0oUZzMKABU+MlwQ+nuys5UWHf64BrELgVXVOMCIAVaA
 wBT828QI+KHA03c8sR9DF5rudlORCFT4x/5PUdgqB0LX3TwUxQXtgdE/znio5jQ9V1wn4pxiXOq
 xvewtwWCN59hulMohzneFMD5wle2akE69jxhcJwxkHSQQM6RAbBYeFXFk6DwL8XOulGLwpdsVNC
 s9grZfjxtE7/Duf6M2xcV/aKeYEnxa2l0j28JNWRpR9er20+cOwacaxVbaQn
X-Received: by 2002:a05:6000:2206:b0:488:5d3e:bf47 with SMTP id
 ffacd0b85a97d-4887db2d092mr20669467f8f.33.1790679750901; 
 Tue, 29 Sep 2026 04:02:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af502fedasm2927863f8f.7.2026.09.29.04.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 04:02:30 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 11:02:27 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 7f48516ea1d96c7a8545cbdb1292def401ac411e
X-Gerrit-Comment-Date: Tue, 29 Sep 2026 11:02:27 +0000
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <71b076d38cb5e322b0d7266f8444a913fdebddfd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBVbZ-0006eQ-MF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Build against
 Windows 10 API and remove some backwards compatility code
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7108830610971579954=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7108830610971579954==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kcoUv+EOANU="; charset=UTF-8

--kcoUv+EOANU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1955?usp=3Demail )

Change subject: Build against Windows 10 A=
PI and remove some backwards compatility code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File CMakeLi=
sts=2Etxt:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955/comment/959479ae=
_e78ba2a1?usp=3Demail :
PS2, Line 257:     check_symbol_exists(DiInstallDev=
ice newdev=2Eh HAVE_DIINSTALLDEVICE)
This is actually wrong=2E Forgot to se=
t `CMAKE_REQUIRED_LIBRARIES`



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1955?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
Gerrit-Change-Number: =
1955
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Tue, 29 Sep 2026 11:02:27 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No

--kcoUv+EOANU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld has posted comments=
 on this change by flichtenheld=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1955?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955/comment/959=
479ae_e78ba2a1?usp=3Demail">Patch Set #2, Line 257:</a> <code style=3D"font=
-family:monospace,monospace">    check_symbol_exists(DiInstallDevice newdev=
=2Eh HAVE_DIINSTALLDEVICE)</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">This is actually wrong=2E Forgot to s=
et `CMAKE_REQUIRED_LIBRARIES`</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">change 1=
955</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
44d7171c7e4f8497bf8b902380df92a58bf8a79a </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1955 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Tue, 29 Sep 2026 11:02:27 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: No </div>

</body></html>
--kcoUv+EOANU=--


--===============7108830610971579954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7108830610971579954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7108830610971579954==--

