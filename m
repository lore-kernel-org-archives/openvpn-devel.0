Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB60C98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CkLG+BN90zFEBPbNhF4A5Jf7vItcy41dg/aYMseIUZ4=; b=muaX24DVnIysONuQEj4nrjP1rt
	vScLUJhjAePTPDlpqdvHg6eDrnl+y8CH0hP2XWgjWo2vU7IfR6aLYPgx+t/ericedvpljmFep1GxR
	J3y8EnNJiL5MXiv7pOFsNWIjg85e0HJnvUY09LTpmZwDRcvfVQjGW3SjH1kcSJCpJwa0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA6MW-0006yo-6M;
	Fri, 25 Sep 2026 13:53:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA6MU-0006yh-Q8
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:53:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pverbJ41UvUuzwD2fP267643TJtcNwWFTE+1vbWWZmg=; b=WRpfePIHvbQ0QaiuHnMhdg6lav
 RbQBpKSF+zS7Jj7RQ5jdQGHO5nKEGCmM8LIzUDpW4AY5SXP9TW7e5WLuAdDGckmL6JYxIf4KZnE2B
 qDynuBCgS/xsFr59z+VpJFXqFo84ZZHxU8RE/TesM0a7iwUP4ReukwAiWLuUWkssSKTw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pverbJ41UvUuzwD2fP267643TJtcNwWFTE+1vbWWZmg=; b=k
 cdJQuPk1sIFADWg/GaWY2bbr/qNHn98G20mPp7BcslwOpA0hkQWZkYBGraeddEpalWytwBeklY4/S
 F6NYVBUCDEEefRYMW/z+xJBQQ494lSe7OCo4kuZNczQt+Zx5R+te+gTgvqqN5GOvrbwZGr/XXLYH8
 OvoFtHo9Cyx7tfMc=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA6MU-0006fm-8G for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:53:14 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so5519505e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790344388; x=1790949188; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pverbJ41UvUuzwD2fP267643TJtcNwWFTE+1vbWWZmg=;
 b=OHCqXWC5w0qMO2SqZkFTNit39KCrTaVY3jqCAKDGnNhfVxhBoeZ84Os8h0Az4puUsB
 RCdL1PwQeNFs6sWHvrlcCUc3cL/57iD2XmQGWF1pOBF2aIRU1X4OEsSK9PdOGFtGylU1
 a/lzNDW2AlQWev63DiBRuk+H6df/z/J5ztCpQGM4QVjukbrqcbCEMP1tao2/hM7i7vvT
 0VyX2XoZxMi7WnsX3Jxh2jpy+9V/b2qkzefXR+qlrbaVyzz/lmSlqKzrpOYTCre47+pd
 xS9T/fPbtrPKjPYLllNx0/Jcj5/cw3MOOuQUkLGwbtfT093rZssf+deGntvfHmJaL6/H
 wLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790344388; x=1790949188;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pverbJ41UvUuzwD2fP267643TJtcNwWFTE+1vbWWZmg=;
 b=fu4/yqbs0VFO57u/qPxbDYN6PHPSFGWL21M1JPSWnsjMBs6DexYLbHFlGBJ5Y1QZl+
 cX1xMKNqoPygY9VXbCNPOOgODJm15vel1Cww7Djo8ueCzma8AhjGTMyTLs03JcGSmM93
 JTudQD/3zlaqdL3OSQi9c8kFMmArzRXCSqqxPnG955ezpGNLKdUxx6Ltj2fKX/FGXnoB
 3WULArdnofghex3e9JAM0VGRcr0U/VGuf+24XtzxCYZEEG3g+uH4r9SBzIytt2amdDDc
 kCJ5uXO6ZBK6wh6us6292eXcBl+iZwxh/JgacrsANni3NDw09e3oseWnslxTqiC/kyFT
 2dPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwluyqCvvMz2SOl2y/7YKfM6q7cb8E9sRtXBRUsoVP1Oa7dJqH49HgStBFRU2ae5+U5bRNkaVA2wAI0Wvym@lists.sourceforge.net
X-Gm-Message-State: AFuF++mxmYI9q7T0O1CfxSZHGfihByyPlmz8BsjPx5U63UHzLaAsRdEK
 R2lEPi76gHeeaR3mJJnVvgk9O6GvNyZ55Osnl1WEdVT+30K++HkM4JjWBigJ8mV37agIMpeQ+bO
 DP8iwiaIElD4Mi700mKYyRC6D4TWt4B0/UC5Y+sNA9mHpKZy1TzwIEpqhapjrSlmPOzl9
X-Gm-Gg: AYBFou0lAAYC0x/hLs6xLz27OSOjjcBdeqiSN1JuhKjp6Gu85CzRQbG2xEsyKCVUzqF
 zwcKWO8viznv7smC2boW3XNM3LvKrhd2LF6idN8ONBIepDnBCYdJthhi/VnSEUc/DCmg2vpmwjQ
 Tc7FxOjuMg8CExbZV2bVVtRqve4zkXfyesFmoUDIfpYeVxGqaUVLqf15YUiIzWmyqruw3cnqluH
 6hkKil4zCH99xN3lsru8PqEQzv9tYCXP1/JIBKtbTDFvzOecNojdZstaJOKyqEvKLSbuI8P8DM7
 WKN/ktOw6fV51nI6Qag4ZMp1uUttZvTxsk13neeSpZ1Fy7y9qAcFuD/AtkYnIOREatlSaXpu+WB
 IFcsKzuHg/VJ2YG9QcQLlaNzZQ6AN5ST+tPj9Cf3FBF0fJu5cLJC7hszM9h0kXdhjvHxLV2+5li
 w3wbSSUUTU8fW/WGv7FhjTiO+YPP07IMdLQkabzJ3kafB0NDgRsVhGZNwSHbxqemw8DLczg7Rnr
 vEzyDV7AIa8i7p/XuShIu8q9l4T8V12QRlz5enuP2Ht1fE0GREobT5Kf1EsVsPg0o37KXupWkz0
 3bZj/MWx0MZtGu6FzXav0pbjgmL1FYiRhEYY9llqSlB3h/e/il7bLXRihM77KzOXofPPTKM=
X-Received: by 2002:a05:600c:348a:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-49fe6705942mr96545645e9.30.1790344387505; 
 Fri, 25 Sep 2026 06:53:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff065873csm61436465e9.2.2026.09.25.06.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:53:07 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 13:53:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7f3b95cacdf359536e827f176f2b81da4b00f22f
X-Gerrit-Change-Number: 1434
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1434?usp=email>
X-Gerrit-Commit: 52ac9ec05a0153c3ab80e8c3a8b428b380a55276
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 13:53:05 +0000
In-Reply-To: <gerrit.1765448957000.I7f3b95cacdf359536e827f176f2b81da4b00f22f@gerrit.openvpn.net>
References: <gerrit.1765448957000.I7f3b95cacdf359536e827f176f2b81da4b00f22f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY1NDQ4OTU3MDAwLkk3ZjNiOTVjYWNkZjM1OTUzNmU4MjdmMTc2ZjJiODFkYTRiMDBmMjJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <39305646e2cfe81e6a6f2bca27e0f7914e323ee2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA6MU-0006fm-8G
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: parse
 stats in PEER_DEL notification if available
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8890503083739375616=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8890503083739375616==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tWVAXpVctEQ="; charset=UTF-8

--tWVAXpVctEQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

ralf_lici has posted co=
mments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1434?usp=3Demail )

Change subject: dco_linux: parse stats in PEER_D=
EL notification if available
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Set Ready For Review


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1434?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I7f3b95cacdf359536e827f176f2b81da4b00f22f
Gerrit-Chang=
e-Number: 1434
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 25 Sep 2026=
 13:53:05 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--tWVAXpVctEQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ralf_lici has posted comments on=
 this change by ralf_lici=2E</p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Set Ready For Review</p><p><a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1434?usp=3Demail">View Change</a></p>=
<ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1434?usp=3Demail">change 1434=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1434?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7f3b=
95cacdf359536e827f176f2b81da4b00f22f </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1434 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Fri, 25 Sep 2026 13:53:05 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: No </div>

</body></html>
--tWVAXpVctEQ=--


--===============8890503083739375616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8890503083739375616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8890503083739375616==--

