Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E9CCD8C92
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VT8rzfbhUl8X0ElcHmVDJzFDw1A1gFt06gvgqQV9Jac=; b=ILLpORaLDgz6o6qWLKm3NvalFr
	QfTFeFQ19M6GQscjLMHgvPLDmP9yRcGOdmISw4EEjKhWYoS0pDWIjzr16RMeIvrKZrehD4jwUyeg1
	RlYlVfQG1oCpWwTakk/1ZK++pe7FC03yieI5udQFR8wzLGW7LBavikpkAy+aik26uX4s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWaQj-0008UM-IY;
	Mon, 08 Jun 2026 13:54:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWaQV-0008T0-SS
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:54:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=h2SBwILrZbcThMf+cHUgPS1QIW2w+s2tpIHLee0mpTI=; b=P//aObK/MwC9YzpiL+8q/gsTHj
 d1Yp5YxEDCYQrcT8iygqqrnKzstyMEuLLPmTx09JYNQiFbNFfMlYBv4ogc95KbpkFnC5ye2mq8mNP
 TCRa3dk0Wofiq33hZPccnmBrPe55bcqfX3+XcfFeBVWY3Oj4suNlPG720o9c2WIqxKOc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h2SBwILrZbcThMf+cHUgPS1QIW2w+s2tpIHLee0mpTI=; b=U
 rm47f6VnTsVnwK7XsBc+KMooAV/JtZNUWnOzIToDzlCHgxKzoJteJFKNHWlKintfmfC3UzLN/N3i8
 1x1tBRtzdtk8hyKRIhsEnGg+zcwSH5H3a/QJe5wKSiaQQIGfLSMH4mYVNzxJHMNrtZmlWs8vRoLdr
 2e4y+/PUrksyGLQs=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWaQR-0007P8-RN for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:54:01 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45ef82204c6so2286040f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 06:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780926834; x=1781531634; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h2SBwILrZbcThMf+cHUgPS1QIW2w+s2tpIHLee0mpTI=;
 b=QbE6VwJHktekPqO1SQmvHuAWQaj0ucLOGKqDm0xu8dhzenAFDQAeLjP+ywZnWJkiKS
 cNv+PdpvIQ5OpZw5/SXbosA2dp7wCtf5CUgAk+yI9E2G1A5fb/8OFXxsYLRFg1wH+G2K
 cM6iI3qQZ6UubTW8bRabwSI5l2tNTgyfIusS7QHv0WuMNAo97J2XxZgo13Pp3CHYDnlt
 01h+bpSry0JHLlYhUF00KqJ+pogNL+yovcRVk1ZI/ISoMKoCKzCDwEnvu3w8IiIR8M39
 NaUf/+Rk1/uYI895K/fhYcwyeKe+nRH9xEBiBxJ5hr/CFZNt9hcxMXRUWBS5j/lxPWei
 cCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926834; x=1781531634;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h2SBwILrZbcThMf+cHUgPS1QIW2w+s2tpIHLee0mpTI=;
 b=GGnCKLyjiB3Q37LgCXdIbp7/xjU6Ivk7k/DWXDiGjU1XNxaJjPmBLHTn/uMi5n9uAv
 WPibjx30bX5C77DQuExLD3LCFI7NXf5FFkhw6YEOqmWQGWncrN1POt7Ze7HgaAeE4UP8
 ZcrOlBRPNloII8/zU4h484idvpHmY3K6JWYjVuVO0wBezBPXO6QV/FRYPlnlMTm8dfTI
 it3zGJ9B16I16aJUMlrFghFvm8RaRfzG3pEAJztxhMr5CywUBpK2khI1K+6uue4kkFue
 fXlFtV+twO2nKo6ZAJFtCOCPGmOQajGvfDY07jajKDKa68cGSuASulDu+bIOS2Ky/ueM
 KL2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ88uKjrSYvAQXSUcSXwICrjTg3tfLjpw6mS/miH7xDV5JuJWjPT+hzDzMiVR34gNkx+Id/ouZi1lfJvxu4D@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzPQLf1TAaru90Z2n0VpvgbRM4WpSyYRs6Tu3BPp+6H2CTaheJV
 B04KXXW0yBC1bb74kToaJX0uhU5vVni5yrM+uytyjuGeGW7pSywz5snmC2zub64yg5hs9zvpbtn
 VAwJZ7PfsFKuCOaaCQoUW8qOiGwEBLo/yVl1rYTnCXM+0Ol3ZEiH5QyE+cCVoTBweHF2t
X-Gm-Gg: Acq92OGxotizyHiDoJs3AgclUW328A0NPfQoEYpl2bsjaCZGjIGUkx4d2GB9oF7Am0K
 RWN1CEcIrdPdeYilcilG+stNWvWUDWakJixMmSRV6T2NjwFXYbBUhV4xXBMeflw0YWu1yWt4Vff
 7oLmKXZEEJsvrqcdxa8BjqnmddnvLG3nCaMwhhm5LDc1Xe9VfU9wPMRTJoY9Ccbfpin85MnkwUI
 dDY62OJqTd1mJnBkuws9/mKoDi8z6MT+/7vZ/jmbgRWraYhGWTApm1LI2j+qy5Oeu0Z3qf4aWFk
 J8+Rv9Fmbf98xJoHOWAswPgwjzTRZCfQldmPCNu/D5z26+1YgyGChei8RGvRJEs+xyYGzbSJDc5
 YFBSp7O1tkPMRB/8rpetPciNaI6dvzkna1BxAF6mJTeicdRpnluG+mkcR6mOTOD8HGb8iFop6ht
 3VXyKUbUQ5r1uz1peVKt+hILRYnIwqA1vnX3ZZjX7brSUBPM2yE9s+MvS25k2X3FTBIfy20p5Vx
 z7d/vtoaCTvQKhhh5pgcJUiNt/oqj3jvUT/bDQBEr1dDx2cQJuYH6XSRkqnfhcrZJrJWn+tn2cG
 FCO0czgvcxSwmtKa6VTpBgeOULPVt120cYY=
X-Received: by 2002:a05:6000:41d5:b0:460:3210:b6eb with SMTP id
 ffacd0b85a97d-4603210b7b5mr25461166f8f.43.1780926833536; 
 Mon, 08 Jun 2026 06:53:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcad5sm57830105f8f.5.2026.06.08.06.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:53:52 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 13:53:51 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da
X-Gerrit-Change-Number: 1703
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1703?usp=email>
X-Gerrit-Commit: c0912e077fe19033a61d0fab245fccbe7c75f07f
X-Gerrit-Comment-Date: Mon, 8 Jun 2026 13:53:51 +0000
In-Reply-To: <gerrit.1779797980000.I115a17a2c61c65f48aea41d94150f34ea31f82da@gerrit.openvpn.net>
References: <gerrit.1779797980000.I115a17a2c61c65f48aea41d94150f34ea31f82da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5Nzk3OTgwMDAwLkkxMTVhMTdhMmM2MWM2NWY0OGFlYTQxZDk0MTUwZjM0ZWEzMWY4MmRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d865f449af39dc7eb9e73ab54575ffda7d0f150e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWaQR-0007P8-RN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add support for user
 defined L3 master devices
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1809464312725969050=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1809464312725969050==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+MBl3ijxEWE="; charset=UTF-8

--+MBl3ijxEWE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos=2E

flichtenheld=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1703?usp=3Demail )

Change subject: Add support for us=
er defined L3 master devices
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-2

(1 comment)

File doc/man-sec=
tions/vpn-network-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1703/comment/63e84a08_0cf3cef8?usp=3Demail :
PS1, Line 307: --l3mdev name
=
this needs an explanation on how it is different to --bind-dev which seems =
to claim to offer the same feature but implemented differently?



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150=
f34ea31f82da
Gerrit-Change-Number: 1703
Gerrit-PatchSet: 1
Gerrit-Owner: it=
s_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan =
<gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 08 Jun 2026 13:53:51 =
+0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--+MBl3ijxEWE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos=2E </p>
<p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File doc/man-sections/vpn-network-options=2Erst:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1703/comment/63e84a08_0cf3cef8?usp=3Demail">Pa=
tch Set #1, Line 307:</a> <code style=3D"font-family:monospace,monospace">-=
-l3mdev name</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">this needs an explanation on how it is different to=
 --bind-dev which seems to claim to offer the same feature but implemented =
differently?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail">change 1703</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I115a17a2c61c65f48=
aea41d94150f34ea31f82da </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1703 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Jun 2026 13:53:51 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div =
style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--+MBl3ijxEWE=--


--===============1809464312725969050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1809464312725969050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1809464312725969050==--

