Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4F606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HoozliGZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BfSlbQIy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DCN21uqM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=F26/qlml
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yZKucxynk5Ycp6Eaihwh1uR1LxSPUNFrHtEPtEWxVMk=; b=HoozliGZcYaxPv7FGsF7dujWEF
	br9aVwNU0pXa8m+hQIinGCj26aMl0OyX5zncjdLuouOSDThHKd6hGpVv078JkfhTeilhMQ5OpTTA2
	VsdSzDTEKttcRqNMez2UCxUgju+fq0O+YFj5xqupaImV6sX+2BQu6mwJehsa2rWfCl9g=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWYle-0000000006s-37X2;
	Thu, 26 Nov 2026 12:40:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWYld-0000000005w-3ZZH
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 12:40:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IiLmloZ4fc81WOTFVlBXlCl2k4/Ra2fZnv1jb2DM22s=; b=BfSlbQIynvjBtW+9s+MiX6c/rh
 5hPLw0+p0JRJtgoBbNMWeWBiX6IdS0TqmsuZ36pm1TNXi7wfiQDq56Hz8MyfnEvNTDMfPNlPdxsA1
 Np0bRDQIaNW+vWUNKQjuAbguqaqwNbvF8fw15iBaHn427n4stEx7mgGxdeig2sJCnEHQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IiLmloZ4fc81WOTFVlBXlCl2k4/Ra2fZnv1jb2DM22s=; b=DCN21uqMhqeL5CecXwnFaMXhzp
 CfIBXLmG+1Fci+76yazM2ePpKIvki/jEsoxKk5OvNuFd/vQGMc++Spss53y6vXuhL4cQ/G5X7sGGE
 cI91guKM4ynzCoEvrdE3kAYCsYirDwLq3V1LGc/kDF+HRich3VJocNf79DAC0OZ/Ecs0=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWYlc-000000007HF-0H1Q for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 12:40:01 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so44741715e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 04:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795696793; x=1796301593; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IiLmloZ4fc81WOTFVlBXlCl2k4/Ra2fZnv1jb2DM22s=;
 b=F26/qlmlzejqO+qoqK8O62EoCMhXrik1W+jBuo6y/QCfZE0frV5DCvUXVPedJ2U/d0
 ynnRSEPRKt0F/gH07ZEJbR+BSN6nvg0ZnfOBnEXLAfDStr2J92PqC/kWWuUy6JiciRKt
 kOnWQNEtvsMwReXwkdSJfAOj4HjIKHjiCCgtdxweOwZHyxSwyGujS/HQ6MrHzqNWIjF0
 3J0iZphikIsQHzbIKiwJx+qhjRpiIHep+NvWBRZkk8IHrmW8bFjhlWzlPvo5L8VqYm0p
 +DJjPfxE2q64US7WpFKXkZwCIRKbvbJfyaMYwxWen3KbTyuV+9GOTzQU7KE2AF76fwI0
 oabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795696793; x=1796301593;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IiLmloZ4fc81WOTFVlBXlCl2k4/Ra2fZnv1jb2DM22s=;
 b=QjYNw+CDht9MjzpXgUwqr7elPgVInP91I/oUcTvP8mgemqvFTZ7EwKSryuLAJO0Rff
 6VehJTzbu8TwpkQa8EnU1iocz/JWVNYjLNVlNPDNPz71jeVqNvZxVd8RAnwtne6hp4sC
 F9DME+b1iLyGTDiYcpk860uYKE3N7OG3mEIlnULOw7/UDds7vlo1Y51IBxPfigdsBPoR
 iPwS3CTZaQXdR3DbQYYCL0GZ5x+a6dmBDonGq7P3bOXzRL79ZQMLKSFCq+aEmngTKs+2
 h+7Vx6RQN18a6pX1HW82EQMgPIDv5zCth6V3s8E3vg/by80fnfFTRfxSWMZnp/A/yfnY
 HZEg==
X-Forwarded-Encrypted: i=1;
 AL+hErHtiNtUVsg9ja6FWg8fTDDAIGSEaedQE11zC0j1efACp6yPlHRQvy2Pqen24JmXrSA6nhGjij3FhvJ+beKT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z//4q/g6hJCDTRgBoBlbd2Axc9cVuOAt5gUhCGS69xPszcD5s4H
 XYBNePROa9wd4AHvbmsyucZIZEpIAxC+kkdXf7nc+y/3YKZS/2XTf/CcOsCHMcAbzdP+jUOCYE3
 30YiDjkWVQgkwQCBxbg1Xiy+ZWt+YIxK7DuHemV3G9sI76wmPjYoAzY8KJWy/YnB/k4Pt
X-Gm-Gg: AZFdTZeqfFZKq16QObJy8i7WuV39V3E/qU0D4H5DiG8ReIar3DsH/googN7XgWeohr8
 KVeLqv/Cb0Ady9nITauf96YWk1jFPO/Xclk1fBt2iNnShNFrUy4wl/RuoVSNv0a4Nl6/mAH1oTu
 Dlrr6c3wS3saYQ2vA4ZRTeMbvK1BKGzJ89dM7N5N15L8j42ZpdovOMu/UdrxOTImxVpL5GqHE0P
 ywyeFYKRe+5yvZM0zeiP/ACI3a8dQga6DXGWwGjst/Z6wg3EQTYd+Q9oNnY5DwfQ2fcN6HAUJgC
 bPFHVquNMw4qMqpiQxDRGmYrUfBtTdw6UaW/JS52CAcuCEZ8Z7H791s3S3cJeolwdg5AW/XisyL
 Je/PZZZjqOIdV1+ckxCZbnLb6PD/JmaKs+uQM6xCAYz0OcHzHxs52spw4mVYk4EUsDmZW86uN8e
 IKsylPCajR2Q0v/0D94CBM1aKnEXD1ATsveDLmOdzDT1bNVS05yf2lyCbPxyifLrXryKari08es
 4IU6qrFZzKscdTcAUU1WTYmQJtSz7TTMu7J86b8OUDGug5XfEcVirSP7sI6IQltZaHpGehzH32d
 d7xy5zTkS/vZZHua1Pn9e1p7LU2opmLmH94ueMuwSpDuW0CEjS8jKoNJYdOoATSGWskvPmrToE/
 5JDKnnr5asz+R/6DM2LLvYXn8fPcQiJAFjg9VBMlKS9iqQLxAH5W6AujfzoeIOTeEJa52S0t8lm
 crI9Jsu+9mn1tRhw0=
X-Received: by 2002:a05:600c:1911:b0:4a2:150f:1607 with SMTP id
 5b1f17b1804b1-4bb8880a584mr428476975e9.13.1795696793278; 
 Thu, 26 Nov 2026 04:39:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm626226765e9.2.2026.11.26.04.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 04:39:52 -0800 (PST)
X-Google-Original-From: "Yuriy Darnobyt (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 12:39:51 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I01458ac46a5948fccec4afa9fc358a36e67055b5
X-Gerrit-Change-Number: 2331
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2331?usp=email>
X-Gerrit-Commit: bc8290ed11515a0ebeac55a82d270debab89e591
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 12:39:51 +0000
In-Reply-To: <gerrit.1795449639000.I01458ac46a5948fccec4afa9fc358a36e67055b5@gerrit.openvpn.net>
References: <gerrit.1795449639000.I01458ac46a5948fccec4afa9fc358a36e67055b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQ5NjM5MDAwLkkwMTQ1OGFjNDZhNTk0OGZjY2VjNGFmYTlmYzM1OGEzNmU2NzA1NWI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eb7b1c1e5943e45165d4bbc61132358f48dc1b9f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWYlc-000000007HF-0H1Q
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add buildbot
 configuration script
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Yuriy Darnobyt \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: yura.uddr@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, ralf@mandelbit.com
Cc: "Yuriy Darnobyt \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4850573390701112299=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4850573390701112299==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IcWBBvTgAaA="; charset=UTF-8

--IcWBBvTgAaA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

Y=
uriy Darnobyt has posted comments on this change by Frank Lichtenheld=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2331?usp=3Demail )

Change subje=
ct: Add buildbot configuration script
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)

File =
=2Ebuildbot/buildbot_props=2Esh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2331/comment/a1eae4e9_2398e9ef?usp=3Demail :
PS1, Line 37:     if [ -n "b=
ranch_pkg_config_path" ]; then
I assume we want $branch_pkg_config_path var=
iable here?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2331?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0145=
8ac46a5948fccec4afa9fc358a36e67055b5
Gerrit-Change-Number: 2331
Gerrit-Patc=
hSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Yuriy Da=
rnobyt <yura=2Euddr@gmail=2Ecom>
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 26 Nov 2=
026 12:39:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--IcWBBvTgAaA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Yuriy Darn=
obyt has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch=
 set 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 =
2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2331?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File =2Ebuildbot/buildbot_props=2E=
sh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2331/comment/a1eae4e9_2398e9ef?usp=3Demai=
l">Patch Set #1, Line 37:</a> <code style=3D"font-family:monospace,monospac=
e">    if [ -n &quot;branch_pkg_config_path&quot; ]; then</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I assu=
me we want $branch_pkg_config_path variable here?</p></li></ul></li></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2331?=
usp=3Demail">change 2331</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2331?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I01458ac46a5948fccec4afa9fc358a36e67055b5 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2331 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Yuriy Darno=
byt &lt;yura=2Euddr@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Nov 2026 12:39:51 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--IcWBBvTgAaA=--


--===============4850573390701112299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4850573390701112299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4850573390701112299==--

