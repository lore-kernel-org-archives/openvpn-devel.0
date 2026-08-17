Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C98C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9wWseo3GAnDdM65EBMqRtE+fI7BBIekLQCf45zSBwY=; b=kYDsu4YBPdnk0la6EuHaljAAPr
	/eM+Qlsp9rpotKN935UjagJgmcamxWFgHs8L3LDMtUxeI8F6PgbTnIqs7ZWhXOFIBmib+FjX/V8rc
	R/SojFm6vYamb+Qg3DMdtDiM241BrgIKiHaGeNpXbK7NNYqI8yEkFHHJ/QH4ubQa7EIQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvy21-0002yV-29;
	Mon, 17 Aug 2026 14:09:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvy20-0002yI-1X
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:09:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VqLzojQuPDLj+BWVV6uoB1FUtwjjWAMOl8+BVU759w8=; b=c+jyr9Nnh9XHt0I6vm8iHDqVXl
 e2/BRDa0Mmk66diLptOr8irzXWB0SEXcguOw95e1NGBouEFtFq4yPHHeLkxhFNeLlk+e5tJZPThyI
 HwjnCowQ34ewxyIJYQVolWAwdj4H69niK18WITKyl2u3pLFKu0DHzoPIuhF4BJjZr7u4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VqLzojQuPDLj+BWVV6uoB1FUtwjjWAMOl8+BVU759w8=; b=Q
 LRMmgw+7m4GwPoGlKX1gJf8qifAnjltqjhlc2ZuidQ2P3ta3kkwZoSrfc389cHlQ+VTARuxYg4yzL
 8o9J5RfjXHOHT7ALzej9F1cE//qfDK0ddFZWnt9Gw9p2ljPsmnPisOnHEeYFXWR+iW6tALG2c+cst
 9M5rB3PsLYYJB4wA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvy23-0007mj-Po for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:09:40 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so18026355e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 07:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786975774; x=1787580574; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VqLzojQuPDLj+BWVV6uoB1FUtwjjWAMOl8+BVU759w8=;
 b=TwXgubJvMnorUP/JB7i0GUNbsZaLnMB2LDmCCYwm4Z8YI2OpLILtzKKy5AO/YpU22m
 TOOn0mXlfxfEyjAht0DQzplmdZubAde5bPD2W7Eo0jv4sU/OBYkMzpCUuhsS2xu4nw3/
 SwRewXG6tqQ+6cUCuYsX2qbSS+yK+zsbuKquh3+LTvonrL9egHdmaxTcO1Iw3g1N0iVx
 bBysJdLG+0ZiK3et83LRun7/tROevtNOC7cHNaCTfpxup+RY+aEIXymVKGV3g6A+Pg3E
 vaNOFvyX51ujw0OTAWNpbm4t9xR4DMVNKRhHsZERbWnH041lfi8kQhjGmH+yB5fpNaNh
 6yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786975774; x=1787580574;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VqLzojQuPDLj+BWVV6uoB1FUtwjjWAMOl8+BVU759w8=;
 b=BuVGuMQvzgTyzmKYK1m6PBh2R7jsB6SYHkGBTz6ikEywMiX0x1YSGOkbxwEA3A2PJs
 JhYOBmnmwQVAMVhq9Ak8Y5WhcOEbmKh7uV5HrP6fI8MDUdbeMV2mNyakUNc0owAQf4dW
 F8Ju+qvwMmbTp4F6KmWvTdMW5jvhpkHN3HU5EzqA8RqfUNKkvBDISE5zKFmBc7GMeOMR
 F7bPRAtGDoSXo2iN8gYU3hMd0KKah9+Bhdz+zHfznhhRgX+OZTV3nZ+9ifDA9ZTCKuaN
 yUakkwY4oiG+0uxEC8IPhVT6RSZ6jJT9xks+MEiL9R6jvMS51SwG1xr39K+EUVDAjaLI
 EBfw==
X-Gm-Message-State: AOJu0Yyv1UlKW/80fddejkwg3EIYmOTCfPUy8ZFzyr5hcHkrupWje6zR
 Ch8V3Ym8DYxw7qhUwSSzl1sIAf4Sg+wCSWsZLaU8DWmtlQhb6+pgHJtbt2v8imn++nPlEAZmh1i
 H+qUl3Yni8OoDsePdNA/7dHzMMNI4X9hqCeaMRUIKBqsisd2VI1fNv2ptRRGTnbfmbBeK
X-Gm-Gg: AR+sD12lB93EpeChiRnOIVMM7bF6LOs8ZorTXcBdHe1fKuvbgYtj5OUFqADMpJPkM2w
 yLEyCrYlwex9TOq53wcJ9l9qST7DSd1PjvO/4/KjNR3RWkuWWQfDilAwXuvmcimRoH5nzUOzcZy
 liHZ35EqNda/0wQvyo7OGkX0k/lAIVaD2GX+j+VNH6V+rXDhIY8niwtKzdY9d4sS1wM0ulHs+aE
 R0hOR/0ufc0El5wbnxtlsoHJcm8VVCrMP6Wx1DnTOUgt/5iKZ0PCY2zj3Wt54sNFik0/CvhoPxK
 qayuFVZqw0Qs717BbgI4Pw92z66yEZmC9tiNpRMjRAfWlf9r1vbmmvQR5znk92KNEsCkyiWyN1f
 lOXJHsl/tXmGrUN5mbxVbRpOoEocPP+iZQXd1hQu0ges3pjvaAQkXaHPmsCABSTJ859KC9UfC84
 pWcNGcSjLf1hO4hMye0UpijxY3diHH2bNUg4yRnbnmxtUhc1neghxXvAgDEfHtNPnGLCjk0rK9K
 kynfaR9/s8UOr43hlHDRGFBweZjbT9izcSnUiQpvPjAymFy1NUn+aiYSCFyCMDLwTjDZB36TEGD
 OSIVVuzVWZy61Ug3fvRxs8BRuqDttKQpA1PA8MA8v4HO0OXcSn5Q6pkfoXTPY74=
X-Received: by 2002:a05:600c:1988:b0:496:c93d:e2f with SMTP id
 5b1f17b1804b1-4998798dc17mr376187375e9.15.1786975773650; 
 Mon, 17 Aug 2026 07:09:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0fb872sm58775085e9.9.2026.08.17.07.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:09:32 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 14:09:31 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: 4951d0100d7a0e149a07ac37daf5cccef2fa8241
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 14:09:31 +0000
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce6c4d7f76b872a06e18cab93aba7b15f7eba1ef-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvy23-0007mj-Po
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Reduce number of
 future epoch keys from 16 to 4
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
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6419500517521647224=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6419500517521647224==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="29t6eCN1yWc="; charset=UTF-8

--29t6eCN1yWc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1844?usp=3Demail )

Change subject: Reduce number of future epoch keys=
 from 16 to 4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 4: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1844?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
Gerrit-Change-Number: =
1844
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 17 Aug 2026 14:09:31 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--29t6eCN1yWc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 4:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1844?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail">change 1844</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id3c6681b29026c292=
0a62a0ea570fd098649e197 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1844 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 17=
 Aug 2026 14:09:31 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--29t6eCN1yWc=--


--===============6419500517521647224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6419500517521647224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6419500517521647224==--

