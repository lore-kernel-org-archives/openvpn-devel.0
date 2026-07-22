Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340BAC44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=auZUOy78wDScOPYzmNTFrcbKgh6hOyy/UM0pepwiU9M=; b=DyYlCo6DcFTE6Ku8G8arJDdOED
	gtz2zJsJMbV1cpQjif/Sxtx7Jw7pB3vjc0dU95DzvYCIC8YT6cw3ApXBF0ReFwAza8F45/KxdoMGN
	rJhy7Stczdd6DiDHicYFpwPsToZeh92HrK8scLXMhaUQD0sxf3fL/tVZKkYRm3KqoCak=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmXpK-0006HX-2I;
	Wed, 22 Jul 2026 14:21:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmXpI-0006HP-Ng
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 14:21:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=R+ZXAvAfrez0XICq/E5Ycl10M42VoKhQMPpyx1kCLCo=; b=A6pMh7VR2XuQIuv+bmZsqTw/4h
 X980dMDGQ932sQF4Smm6MfAjEusjBBL3PPusvRjHsO9pdg08HIiiBLMzqUM8e767kwWmpNoRspflu
 DRHJIl88MhIe4/io8FREukDNU11ighyFmBszDROjVVU+msErVr/YrvM4blhgNCoAVo68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=R+ZXAvAfrez0XICq/E5Ycl10M42VoKhQMPpyx1kCLCo=; b=P
 mRScN4oP1X9vmZ3UM3i4o6xS64Ne7RqTspc3YDDETN6eg5uDiXfEzW5lYpLGvjsEhfAtQQ5BqOhYP
 50XS0a4VRp8EQipTPueSQi2ZeXDcSunsKH7LxphUu75AP3/o8KBvHt7wTd1kqW7DY1IRv6ObGIX5w
 1OdC11VILHuK5zeg=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmXpD-0001Xw-M6 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 14:21:34 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso24757015e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784730080; x=1785334880; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=R+ZXAvAfrez0XICq/E5Ycl10M42VoKhQMPpyx1kCLCo=;
 b=Z8XFLjrCqhH9UTbdlKGfWN1SI8Czyt8026bBfuiYIGwQF33F2jQeo9FRUqafbfm3V5
 U2QbPfojjmh+7SDgm543pElx1JqfZKZ6gItq6Iadk+YlEQi93rcCCxYz307aAqDJr4YV
 wN9yiGjtBYz5d3f6LNjKLjK9+bMLdgOS/tHsB892a6Yadlv3aZLwmK5+VWNF66KtGAt1
 SuP4SJgpFoY2WkPNWDzmYrKQvLXM+vPr+v038yfoFVqPZf06CeoGvESFkKWCx/zjoAEu
 Rb2VXgcUlmK1WVnYzMpOvgkWCQFX1MM9kl+kvut04z3jXZ5Rq2ytxVctdcbOWZlZqc+S
 nPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730080; x=1785334880;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R+ZXAvAfrez0XICq/E5Ycl10M42VoKhQMPpyx1kCLCo=;
 b=nxi3kVz5ce3sUDjmVS5m2CBY3LbmOQ7+I19TNi1Pn/DgABsCvV3Obcz8/SneS7kP53
 F0GOSnluwXI9mf2WMfanpvZkr+St+dyq7z4PFdC4UAC0DZN5Ad3OVzpL0v8ZG/vgBnTV
 r3DknuWmTY2TK1wjN/I+06Mj6r0RIrZG8Z7bxZNtQKWctxr/W4QyrY9/ZLWdZV+03Pnf
 i6ZUDTb7F0gsh9RVgLlqw1RzMpxZvmXpUSGd7xFQd/bFp/0P8ARgNW3il1915pqIz0yU
 d9oc8Ibko2J39xTiSRtDudy4YIiSEov4YBaOLaIbacYsqPD1ikdUUVMaEDMCS8Nu6OXb
 DASg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpz1kwKL3MZQNgyv073vmiXkYinKugCHTOgEQplJ4k6vZFeLyGPOJIQt2e2zkFuIIlrMK86RZc0Oylfmhwb@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxUKTKBjzTQYVaks5gK809INg1lWwOD8STHk/EVNhMrRfeeTIKA
 K2H0Bo/QyLZasXbUCIyKuxGQFr3D8JSgb7e+jFa/9NdvECp9/7920FRtRGQZIl3QS0RmhnYeIoX
 PF8vOYTzqptKaPLa6P3Hj4pA+/ZdX6MJREl/+1P7URt/Lg1seJEoeypp+D+gzASdTGYSkCV9NeV
 7GC2imwA==
X-Gm-Gg: AR+sD13f/dIXf4HvqCAeSM2w5lLGMyjbIPquMIBTE9kQkY5RscgMmxem4OFmdgIQ3Av
 ihS5WURBeKy/7akdL6Z4tUiBWzvXoTkTZ+zAtCWOk/CEYCi/s5wMqC+3Gwmab7ZzOq0Fgwn2aWM
 H+AmojeSUPF543GTiCnkaP46ioD41h6dpgsxym21scOqdnFZ7j87Pzs/o1oxDn/WGofS39rj6OR
 kjMK51gtFWZrAFVepXUhW9WT5kYvBA76di82Tuanh6Ck59R2rhJbpBQzyRZ8es40V1qcSWVgy6r
 z4+Y6KsSlnlBF75puv47FYR1Bq9fLUdCT7fOnwlXZzwP+tgH3leDaxN4+RE2iDe13nGN+qz9PAX
 auN5WrhhNcBK4ZjNkM4n6CLLBPRE68XeeWP+Ilm8zoTtrKNT9nJA0evw0moUDPR0+mHlyAVcWNs
 AB5j8SrHF/SSw6hjH0WQWm9xQKQiriCRaHxG1zEiDhgUl0ht1O8p6eFLAF6ZZ9I7sPbAfbQNX/T
 pciPiAh19utPCSDKsQwvTFBr8oSDnMv7LiiqAh/QD2Iu60OYXlvyD36j7nr/TSUYrXF
X-Received: by 2002:a05:600c:3589:b0:495:641a:fffe with SMTP id
 5b1f17b1804b1-495641b01acmr125635685e9.39.1784730079950; 
 Wed, 22 Jul 2026 07:21:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c9d99sm156188385e9.12.2026.07.22.07.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:21:19 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 14:21:18 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
X-Gerrit-Change-Number: 1634
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1634?usp=email>
X-Gerrit-Commit: a2901aa47740548f95755da585d8bb26f97ba8ca
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 14:21:18 +0000
In-Reply-To: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
References: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzY4MDAzMDAwLkkwNzM3Yjc2OWU3OGU2ZDI3MWVjODc0Y2FkYjlmYmQ4MWJmZWZkZWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea5abdbbd6396c9f37736b0a4ee4070b73023d5f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmXpD-0001Xw-M6
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0984433046863178655=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0984433046863178655==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jm3xrDsOl7M="; charset=UTF-8

--jm3xrDsOl7M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld=2E

plaisthos has=
 posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1634?usp=3Demail )

Change subject: Only announce suppor=
t push updates/IV_NCP when actually supporting it
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 8:

(1 comment)

File src/=
openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634/comment/00=
2ad1c5_acd8decc?usp=3Demail :
PS7, Line 1997:         {
> Done
But I have a=
 follow up patch that actually allows the p2p NCP to work in server mode=2E=
 You still need a fixed ip for the clinet in the server config to make it a=
ctually work but there is that =F0=9F=98=8A



-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Gerrit=
-Change-Number: 1634
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <gert@green=
ie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Wed, 22 Jul 2026 14:21:18 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>

--jm3xrDsOl7M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld=2E </p>
<p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail">View Change</a></p><p>1 co=
mment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
634/comment/002ad1c5_acd8decc?usp=3Demail">Patch Set #7, Line 1997:</a> <co=
de style=3D"font-family:monospace,monospace">        {</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Done</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">But I have a follow up patch that actually allows t=
he p2p NCP to work in server mode=2E You still need a fixed ip for the clin=
et in the server config to make it actually work but there is that =F0=9F=
=98=8A</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1634?usp=3Demail">change 1634</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I0737b769e78e6d271ec87=
4cadb9fbd81bfefdec1 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1634 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@=
greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 14:21:18 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In=
-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&g=
t; </div>

</body></html>
--jm3xrDsOl7M=--


--===============0984433046863178655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0984433046863178655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0984433046863178655==--

