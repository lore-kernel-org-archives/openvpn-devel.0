Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7F0C5516E
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7EmzKBj4I+5NjfY/yx59ZRdueQPT6AV7lSIdablOGY=; b=ANuSvw40iTod3a4iJpNqgtVzOQ
	kjyAj52myiFlTOnu0MDyHY0VeeKdcIBV6Y0xc/6u061fxib8JOlC670hlSu8D93JuREN4fLsNvSrn
	RM+ptvzxyEsm7jm9ddRUm+//17IfSSFF1Sr3AplBlFiveVp793M1wen+4oB9nfEoP7w8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpVLe-0005pU-TI;
	Thu, 30 Jul 2026 18:19:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpVLe-0005pO-0f
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:19:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=aPalzdkiFry6fioYWANbpWduTrZt62FspE2+yCPYUoQ=; b=mV39HTU+51fRrJ7U3+iWc7+1SG
 M7EBmPtmmVOBDq3p0JnxNWTpZOR1wjzP0FyavzZFE6qZ+55LVLMhkNhDy7bww3JbN820j/6dFOQYw
 /hAdrVczSFKf8JGVf+o8zuXebFF1OkzyNWeDCOgYr2v+vGDlzCN5GsWPd84rBR/kjuh0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aPalzdkiFry6fioYWANbpWduTrZt62FspE2+yCPYUoQ=; b=S
 9Az2SqkqgExLti2UlUIQoAYJpVi0T+wI/2tiCSdWbfUr+fMafNCnptL5QqtLC2cVPXCTFHy0dqufS
 QpHjvnZDzy+W5oYOcnDvKTfa3ovtylN9QGdtofdaArH6QLfcU/kREdzYhA8w7uykUOM7QXOzd8FDR
 qzy6Pl/t6pbEyi4E=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpVLd-0003MQ-Hj for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:19:14 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso24145f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785435547; x=1786040347; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aPalzdkiFry6fioYWANbpWduTrZt62FspE2+yCPYUoQ=;
 b=aAxHyvf0jwnlQNCJxQSztfUfmtEODN9UJgjNG+drlZfZeXCgkthlmpCS1SUaWxGCN6
 PRgxegxF7zYCU9DstGYc9b/DH93WjT0hUYaoXiF7+ErT2ZiCSAa44J70VQRc7+ydeqU3
 MVsnpw4e0POhx254BM0SXpKbpkqrU+cwsDza12ZRlWcv2TivPUkmxYEfTzj7SmvVhYZz
 90YQTR/+zwHpW0pGnf35q0pIwtavEt0x0m3QI42E/51XBuYTVtoHF02dFH4nuxsOhbWZ
 aV3CKy2dvP8l/ATAy/dPIoH6UIk03Rnpg8qurSpwxmM0f5MYRi9VB2raBRhHxY1CSTwe
 BG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785435547; x=1786040347;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aPalzdkiFry6fioYWANbpWduTrZt62FspE2+yCPYUoQ=;
 b=MrWKZ+t/Mibr2uAhW3i2BfVtG8NUJ4ANZ1Y4VOROu6SHgjZ73NhrNaGDtODIUkRq5w
 DEBxKRkM7lGNOesf7UlmfJf8i4VzNOwliRXPhaR1bsnC6vP61+5yzy62dbAvKEld8sfF
 jL9JMVmVQe52of7GzbWcott//Q8hm2Vig0MJuWnzJKwpx/vNLopW1sRJnjSUjUqUYiqv
 WnFUmhLuIic8MO67PB8dVzXghVb++cL77/CyYMYtTfrT3IlLx0/CtqsM7KtUIeAy/dYe
 0LJj+Rt0qTJn+4X4B2rxo6/YcvhAv+e1ISW2smtLal1I6/cnBiFktDVuReJrIpoWmbTj
 ELaQ==
X-Gm-Message-State: AOJu0Ywch3IP5h6a6m5FB4Xjm0svOnNrAIrtK482GAjRVwj5BaKRCcST
 8fhHGo5Gx6N2B82RaguMRy83YERMAVIwuF6CD1ojqnkznukbDlUOGwblaya/rAXGuhRwAqj2PuF
 55EQjfh4xxQMY+unu0GkGhKVpLOlrNDQb6W91KzQeaHssUzUQpUm6Bexdq+HwvkioCRszX063w9
 4YtpEOZQ==
X-Gm-Gg: AR+sD12CDrElq2ZecERnKH/RwNQ0hzwDiLXQGM252nWnnC+Do73F0LPHLKGlRUIGPYd
 06hRdlPySFhUXCXZAmkK9TzvBeaohbDEbUgDXC/VRzdEylDLlLATfsjhSXAYG1pN4YdEl6U6l05
 mAR+2DHS0IDE+w8cPxV61Jy4DOYTf+VD/9imqOmEoTXphs7IjY65qCwCr1UykVDNhTr0HjjvcOr
 dV86Wghjl9hegB4ULmJA5tT7lYJgbQkpA5UXMdyQzPj94G3g8nRBNvPigsXGxRKbQqf7h/eBGnZ
 ULkcV3kpUS1a2ffMPUbm1/rJAVNHqi8R19WnmLR3r1uEHX72mK/A3j5eKgfaKNxHe9NSgfoFkht
 ujzuhtP1NBvvZPaRgzxpjF1Tm3T2qGh2BL4IUYOXRYMF3ZRk+p9iuxXz3E3gghZi5qs4U/A+YC7
 YrxhktxHSaKkJ9vH6AS2iaY0eW0I6bzTeo8ZyMCOtmIcNPRX3ylrOL2PLFt4cHkSfuEf6JzyrqR
 RFuTefOBAGxAnXLvUU9Z+rAnQObkdrRtBTA6u/nlHW5QiB4HmEpZvyhXP/CAzV3h9xULc85anNd
 9zjRi0vzDok/Bbzym/v95uZW/3+fsR0UaPuUJ7zsV2EsUr7xuvQ=
X-Received: by 2002:a05:600c:4ec7:b0:495:6934:414c with SMTP id
 5b1f17b1804b1-49804c531bamr23002615e9.19.1785435546862; 
 Thu, 30 Jul 2026 11:19:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980108c349sm80082975e9.0.2026.07.30.11.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:19:06 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 18:19:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 76f8f0f6ef32cf8a07f6bfead7733b2742e20f07
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 18:19:05 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <470647f226bfffff4287d27a32874cd78d0c1f60-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpVLd-0003MQ-Hj
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 be a fixed sized array
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
Content-Type: multipart/mixed; boundary="===============7142888395365688369=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7142888395365688369==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AWgUS7C1XAQ="; charset=UTF-8

--AWgUS7C1XAQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a be a fixe=
d sized array
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 21: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1571?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Gerrit-Change-Number: =
1571
Gerrit-PatchSet: 21
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 30 Jul 2026 18:1=
9:05 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--AWgUS7C1XAQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 21:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><ul style=3D=
"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047=
b7db03fcde821899839324d </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1571 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Thu, 30 Jul 2026 18:19:05 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--AWgUS7C1XAQ=--


--===============7142888395365688369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7142888395365688369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7142888395365688369==--

