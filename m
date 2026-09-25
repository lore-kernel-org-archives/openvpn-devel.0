Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1801CC98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AeNLE4r8BOMVfRy9K8l0JOcslwmgbcnGRSaleGbQJ9o=; b=HzpPTbXbDfqcdVc2GwVp9Ia8DA
	U5SY3CZP6S9/keqrfm9BTIGDJsj+FKNTj+ImPLx5ftHEcYpagICQDud79SzTaeRM/wBN3qns93zzL
	0ww+tC0OSEBOB8eG//J33g36oZ4t7NYvtCDzCkX75cu3lm3nBybiKloLzgCTCFY8y5NE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA7ln-0003jE-Kk;
	Fri, 25 Sep 2026 15:23:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA7ll-0003j6-Qm
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 15:23:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gQQH+dSDrgKrt44K+q1hzXLxn0UWdf53i4fgLloUc+M=; b=Ma2zyIpqQYE8ofvBpna26o+VB6
 Y/nSdBP6e9oJ6GNo1Bh4WdNi4GvFuHfxr3ewpbUo04PXfCPMCHfTjZ2v8bmjJY538ashFk+1tMcnk
 TqkmD35DTS3mLwhRhN6BXdYnUwnlrIEUuMm5TRyT28zzlWAZtpb9Km0/X2vI0cbTWT28=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gQQH+dSDrgKrt44K+q1hzXLxn0UWdf53i4fgLloUc+M=; b=h
 /A+5Nqwk/NFZUpm2hcxKBIIgsItipp/7z1+fYBQ2c8KLRI3Jc6wU9ln7lpio+pyY4wuYQnOPiGfGY
 3NOPI1ZTICDnh1w7Udyoqe1ZvJX3xNxPSe+jEXSp5a78kk71EWAlQpvXAini82agh42go0pwF/jTB
 AHdppeMrbgfAKfzw=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA7li-0001mE-Fy for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 15:23:23 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49fe8bf173aso5829265e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790349796; x=1790954596; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gQQH+dSDrgKrt44K+q1hzXLxn0UWdf53i4fgLloUc+M=;
 b=DHaTnUZA6rnV0/ZNQR2f6sBLd0iP04WDB4EEJGPYH6LuB9guPhLv5SMhcKmlfSqmps
 B90/WoRY8N7c/O/6Hcelf5aVN3WDG3yjT20M57rfHrOcBi+Ef++3fCciwSJ2X6pqxffz
 vfkbxJxe6uH5m72+wiiG48vb3iG3xE2mwgWexghUzHPIhNEKS67Rl9bJLO4WOM+p5I9R
 34yHDBrcndIev4B2Gplf1vZN5KPsWU6kA325LyjzBAC/WbFlxxG20N1sfiTx1oRxPK9m
 duKF+GFw1116y72LUHuy0p8seSzdTeK98oGFF2hvJSZdog0fqu7LETyYaJDbumXy5o10
 GODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790349796; x=1790954596;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gQQH+dSDrgKrt44K+q1hzXLxn0UWdf53i4fgLloUc+M=;
 b=wh3Fh6d84bgdmAttjq2IPXNCXsJrSXR8x+AgZvvmsNBrFVxNB4l10UHk4uxdZZegl5
 /UATaYXO+HJdUi6gSKe+y2p5uPuxJMx6alE+7nGmRdFEp8yh8rmxYhcxZuR3ev5B0RBE
 RFK8MJndya1Tf2EYbyXVGvi2nNsSfdMliAaZtU/HS48tRBAA1Ak+Ixw7V9ovUTP08r86
 igWccri+hK1jQcXTiFNmOp5bNh0f4kCPWGeHR+muDHt2Q+oL0VQERHTNe/dK5CArKsQk
 3raaTkwhMlKuxA2YMYXMAVEhvVNatGWdmst+vtacHhWGq2nvqM98ej4zRF68pamm4i30
 sFHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzw1uaRezzhL9L6Vs2hrQ+e2dAzGnmjWGAR2GwVV9RyHRKcYE8CJ+Nb2jSe1mGaDmpZ0gfBZIQ2WhezkDRQ@lists.sourceforge.net
X-Gm-Message-State: AFuF++lqzEvKo2r18U1TYQLcaBRj+J9rLxsSYkNbPpS2qMxbWRFJL4UB
 Toh6cZhKv4ifNRgA95xNP8Gi38wqkljk6qKbZB0NvVQZ7uqQuAJaudFeX1tuMrFzyZklFsyNRVD
 xRMf/tCDpCIAulEeWQMlQnFz2BOrFHwwRGZXDuH6QR/3jYacoLn3XwKyjwG+zqNlksW0L89+Ml9
 drkZutBQ==
X-Gm-Gg: AYBFou2MB2y5hpfkgsuE79UJcPqmsVy6jQDn+0MW6m3GWQr1M7OoTeIcDdz6ntnU3k3
 7tURDoGoBSJJOGs3R9IW5AxjxRCzfIVpjHx9bejY782SQBY1kPn094BXJw9MjIUJn6EyGsmmKyN
 qL5AsGik7xJ4DOeXDpuJEoE0gNf4+qiaGyDnsxFGdteV+HKym0SnjuPTdTyKwOYYUJ0j/BeKaeZ
 +IiDjX2UayfINc1JyzOE/qNJClvqDBCC0/l5F26kHKPGFkQRuUa1lmmD6kBAcK77pOLDgHBodUT
 JDwo4GYAqjG73CIEeFnf7M+GZt0jpJpSSxDaXKuvssbb1H1p9k9JOeDGMncQQTfEHFB5iGZhx8R
 o1q0dW5+iXbVckt1SlDQkqA7J0QVcCjZhCxFOpY9cWoPefMXX0YcR7itWTj2r5vIeF/zU86UQF6
 Mjc8RCOfF6POiYiOj0TgmRJMuX7xh9TFeiIW5hsS9zJYhRA5lTRWipIDUYvHUUh4OCvWkMSBVQb
 g+FmxF96K/VhYrswTK+PB1piEATa+wKtxKtjFIPI7spIZ/p0csNnTAFm2OkZXtH/jq2e8GWs3W+
 cnIwqbX0QgToeirreiMEvcUNn8yiUaFd5yK3aUK6M3SVEnwd0KyNB45ak7CIzYM7wD4A6VM=
X-Received: by 2002:a05:600c:1548:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-49fe66c3010mr105017855e9.7.1790349795762; 
 Fri, 25 Sep 2026 08:23:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe667ae2fsm155118475e9.13.2026.09.25.08.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:23:15 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 15:23:13 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: ffa8097cbd669f623a93dd9b368ffb776ae60d2e
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 15:23:13 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <be2b01d9d0282929e08edac701520b5c85bc5dc4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA7li-0001mE-Fy
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
 ralf@mandelbit.com, frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3079447430842527855=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3079447430842527855==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EPHqyJ2pkIE="; charset=UTF-8

--EPHqyJ2pkIE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ralf_lici, stipa=2E

pl=
aisthos has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add contro=
l message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 17: Code-Review-1

(1 comment)

Pat=
chset:

PS17: 
We already have TLV parser/write that parses/write TLV with =
a compatible format for TLV_TYPE_EARLY_NEG_FLAGS=2E 

While I know this cod=
e is not as sophisticated as the one used for the new TLV, the old TLV is t=
he same format and we should use only have one parser infrastructue instead=
 of two=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1741?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302=
ac57c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSe=
t: 17
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ral=
f_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Eco=
m>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-=
Date: Fri, 25 Sep 2026 15:23:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: Yes

--EPHqyJ2pkIE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ralf_lici, stipa=2E </p>
<p>plaisthos h=
as posted comments on this change by stipa=2E</p><p>Patch set 17:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #17:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">We already have TLV parser/=
write that parses/write TLV with a compatible format for TLV_TYPE_EARLY_NEG=
_FLAGS=2E </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">While I know this code is not as sophisticated as the one us=
ed for the new TLV, the old TLV is the same format and we should use only h=
ave one parser infrastructue instead of two=2E</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail">change 1741</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &=
lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipa=
kov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Fri, 25 Sep 2026 15:23:13 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--EPHqyJ2pkIE=--


--===============3079447430842527855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3079447430842527855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3079447430842527855==--

