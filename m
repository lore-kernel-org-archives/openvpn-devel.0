Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB6606A335
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GO2bxenA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d5yK6kvx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LHVW3PfB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ORqS5CZ0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LQQp1i8f/9YZk225QdDPcvj9TDSujCB9RVNto4IzqzU=; b=GO2bxenAuV4/Muvp7B5/YHokK9
	+CWc21HnUjHctGpAjgDo5CH8Z/0m44PLUSC8m8n0uMuix54jTOgElN8j9Qd8Rh46GsLV4boy0JvGv
	nYMXw+lmChozGjxdFfXnavLc/1x1oGpqi+420mfOcGzZ0Q3fH63AUeOM1bsqtCsSqe7I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWwes-000000005tW-0qlg;
	Fri, 27 Nov 2026 14:10:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWwer-000000005tK-00Gu
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:10:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tNAP0EqLCPGj87BYVgbrRJgrCLdeodAHRo35w/SgyuY=; b=d5yK6kvx96OzN/acnf1j93G+JR
 h5jmxhEvM45YMVjmvw8fVnX9s9BFo1MWz5xexZ2og010QahXbNa98rcPWoQqX2rZJos/OD4ZYKjo7
 wBad34ZAuxj34egXJUkX0V/XKcjHgru9OPG5S7J1ZHXyJQLN3ODCEhnOVbfXHoqVTmRE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tNAP0EqLCPGj87BYVgbrRJgrCLdeodAHRo35w/SgyuY=; b=LHVW3PfBaHXt0AUTXdKopCr4VU
 a4G/92tMm/yg/0+/ck9v98LBkb1UdpDco+Ur/Y7lM0wIsY1Eoh1MfnYRWX9AxdmZHTAZwa3yn7M6U
 yctYBvLXuPC8XCUZzm3ThhojvyzNHrM/xUguwVTk/GiO6IGuWwgcyMWYicqPs7S+dWMs=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWwem-000000005iy-2v5u for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:10:36 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so83475795e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 06:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795788626; x=1796393426; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tNAP0EqLCPGj87BYVgbrRJgrCLdeodAHRo35w/SgyuY=;
 b=ORqS5CZ0EtiXgBQTyNR62SSvuJHPX+yU9dlBckGr95wtBfgpkqU1fdCSeZZWC/en7w
 2c7cRQg4uE11W6iGrGQtHyhI77h9zGoNZ6myvozKprPIRLKJ+xxfOrJ2ISgVpkE1hojr
 NDZFAMbX85zCPEQx3NryX1u0e9DFAPyiTJLWYZqfQnnxapeSR3jmJT9/X9eB0t7sPtu7
 eLnN0bTsRII5Iw7ctn6Y8HgohEpX+A8r6JckwMSB1G4mFC/eiZo4+zWoIjASa89Q6Zbl
 alAoUeu3hHsJGyGjG6qenedblUf8YDe7QODCiGGGlEzipixj8vpZ84zUifWxRfQLmd+K
 7g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795788626; x=1796393426;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tNAP0EqLCPGj87BYVgbrRJgrCLdeodAHRo35w/SgyuY=;
 b=RHqC4gEaHzCZQHZWmR1GQy7waQOv7hVqoH3vvSNf50ZPcevglnB6AjlOLvaWx9OtnQ
 VmszwOSHSrSQn0kbHo0Tz7wUykdBLVnwtjWxUZNt0+gq/6tDRhW1fbH8eGSxM95MgHae
 pnkrJaoCg1y5dsTHufi4uTmU+VSDF0+VZKyHkKwWJqb8gFwwrEgYbHHw5+ihUOioFYG7
 Mj7AdoGDYvyiaP2wI9kys7CirwyWttHpPIUh+JH76MX3n+8/HNfNnK2+WwvtaknznTre
 VBKSx10ylpqhIrzKjbDqUHsIQjQunEju/4ZalpCNw52JpVMx0ndvcVQfv/sk5Tn3o2lv
 otcA==
X-Forwarded-Encrypted: i=1;
 AL+hErFbazWNDN5Mn8gzpa11pLG6Z7/Q78tT5isxNQ7cwKNXWv14E1UaDVoWAFi6/R4jY6/R+BDUiLhvqdNmIbJf@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8IJKDW1O/W7e8VyYy8o21AU9vh+IoHP+ZOavZrt5g2mDQtnH2W
 NxkAbXOfZh/gSicUGhWKh9FPD1HQkgfLlz1zodl/pMrqNy1sMty9yPoD/DY3a1744dlMVEYUZC2
 Mbimj9M/IOB/ad7O5Z1bOluM7EhbKK49uyBIq6iO3FGKbhDCwNyzaLWpCJNS6Cw5OppCYoFBXAG
 eamXOgSw==
X-Gm-Gg: AZFdTZfoLjoy4hqIlG8zWu0kQDy6gZ5Q3jKfyfQYPk1FDkoiPm+CnrXhGG9jFsKPMsB
 HP7gR/lLJdRJZqOWIPg5/h18TKoB9yMTSYDyLm7h9YcjeYMzIpx6Rrayyvv4vHJRcSurDECK+tt
 Hb8tirbt+BGGK6Kv/uaQg1m2J66s+Z8g32ixOIbS74Q8huDfNdR1zcXizwXZ1u4nt0otP5Ijxiu
 BjK9UF2C8d1LsPOmC+k2LuAgo83EsDzHzaUxSlbt+b2MQe4r+TnDnLGKzTFq6gWYdWHUaqPtO4o
 ggjPnDuHT7aqLugDn/I9o3hbKyXV2ept1vNmded7pGaG5Z1DkTaADbPCOR4uuV1fzWaiC//0+Oa
 ccud8xjEc9NEjS3EXxEWSTwqgZ/U5CqALCrj8/SbVeRFimiRIgHOdHtuUY7FgCRZoOdoZqiYkMr
 i/9ahp/yqcgtwQpuYNFeVRbvjNfLP4g1tUodq70UEI2CiXmWCnxafhWLEFxb46SCSlu6FcZn5Ey
 DdC0T3xmfMi5jskKJajb8h/nRZ/d6aM7t+CYNIkFmEwV7iy3hPctPRAkDERGpKOgopdxl2I4Enl
 cOSlkzpHN90IKV6NSrqPhDk75vm/JSoM8X4CvSY8uc72jSCIw3CvqcRdYd0HIDxW7pxKSLTkL5N
 dVqB7v2GntemmR607o8k3Kv5Rh2MGgP/bRGWhn0X+kbbDlmNJBO6fqT0ay0zOfIos9BPpf/k5WE
 Q2nU91wSEv3nWCrzU=
X-Received: by 2002:a05:600c:1d09:b0:4bb:73d5:ab33 with SMTP id
 5b1f17b1804b1-4bb88816acemr538674195e9.22.1795788625898; 
 Fri, 27 Nov 2026 06:10:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906640a2sm399789115e9.0.2026.11.27.06.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:10:25 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 14:10:24 +0000
To: Aravind O R <aravindor@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: 28db47113dd19df5188c5f995d49c648e2c54c0a
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 14:10:24 +0000
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9f49ac744831d10deb43e46166b49108b1f068c0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWwem-000000005iy-2v5u
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: add
 compiler and linker hardening flags
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, aravindor@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2459847422702768142=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2459847422702768142==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yAiFDsW4vyM="; charset=UTF-8

--yAiFDsW4vyM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Aravind O R, Arne Schwabe=2E

Frank L=
ichtenheld has posted comments on this change by Aravind O R=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail )

Change subject: confi=
gure: add compiler and linker hardening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(2 comments=
)

Patchset:

PS2: 
Now a real failure


File configure=2Eac:

https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2213/comment/83822546_b265d9de?usp=3Demail :=

PS2, Line 1364: 			ACL_CHECK_ADD_HARDENING_FLAG([cflags], [-mbranch-protec=
tion=3Dstandard])
Fails to build on FreeBSD 15 with the following error

`c=
c: error: unsupported option '-mbranch-protection=3D' for target 'x86_64-un=
known-freebsd15=2E1'`

See https://sourceforge=2Enet/p/openvpn/mailman/open=
vpn-builds/thread/mailman=2E63181=2E1795787432=2E1621=2Eopenvpn-builds%40li=
sts=2Esourceforge=2Enet/#msg59439983



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
Gerrit-Chan=
ge-Number: 2213
Gerrit-PatchSet: 2
Gerrit-Owner: Aravind O R <aravindor@gma=
il=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Aravind O =
R <aravindor@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Comment-Date: Fri, 27 Nov 2026 14:10:24 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: Yes

--yAiFDsW4vyM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Aravind O R, Arne Schwabe=2E </p>
<p>Frank Lichtenhel=
d has posted comments on this change by Aravind O R=2E</p><p>Patch set 2:<s=
pan style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padd=
ing: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View Change</=
a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/22=
13?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Now a real failur=
e</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File configure=
=2Eac:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213/comment/83822546_b265d9de?usp=3De=
mail">Patch Set #2, Line 1364:</a> <code style=3D"font-family:monospace,mon=
ospace">			ACL_CHECK_ADD_HARDENING_FLAG([cflags], [-mbranch-protection=3Dst=
andard])</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Fails to build on FreeBSD 15 with the following error</=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">`cc: error: unsupported option &#39;-mbranch-protection=3D&#39; for targ=
et &#39;x86_64-unknown-freebsd15=2E1&#39;`</p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">See https://sourceforge=2Ene=
t/p/openvpn/mailman/openvpn-builds/thread/mailman=2E63181=2E1795787432=2E16=
21=2Eopenvpn-builds%40lists=2Esourceforge=2Enet/#msg59439983</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2213?usp=3Demail">change 2213</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2213?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2213 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Aravind O R &lt;aravindor@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Aravind O R &lt;aravind=
or@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 14:10:24 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--yAiFDsW4vyM=--


--===============2459847422702768142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2459847422702768142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2459847422702768142==--

