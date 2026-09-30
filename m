Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9247CA5FC5
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HJgbSbRqDoGlThO4h7xy834L/shLwQ8vPLqlCs4gAwc=; b=A+me44AnC4KITbd3ovQwh+Equx
	0jBrKmZjteJKCkzwPZ9bSWS2NhLPTOV4WWwmIGZXfigjgod8Di7pqQjoX04VqoEEyPREokFTZ/rYA
	Mipq2gXPd7GHXXrvcbiPS8VWvPQMhMwjtoE3OYV1OeC6/JUXW5UzPzBJN8wuKt1k0NVU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBwYT-00076E-JV;
	Wed, 30 Sep 2026 15:49:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBwYR-0006yq-KN
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 15:49:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NKhZSPfIHjTShIAIF3MCjP6k8ll1keioI9U6y7Tq1dI=; b=cgOqfykN9XoNte2MnMQqYTdRdg
 LdBhrDVh5WirAuJQaZJ7Q/cQ9bZawgKgofqnAAVfnutOcmCl7WkTCH4HkqOv9pWIDBLb/4XR7UQfy
 cN+SVz6fyAaCnHrWnjVUm8GAcfcqgMEwMISYm/hdCm09mXeOtBf0QuqEDXOlpguYz3Uc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NKhZSPfIHjTShIAIF3MCjP6k8ll1keioI9U6y7Tq1dI=; b=S
 FxLkgmQxj3RpFYr2YsJL4ChTAQrOH90cVsMm8z1SDAjnZE0ZJNJqRxe5pKzWBx1bSStCyPqpCSb8A
 3F7QY2LrLJZeG2ApiVGR6mDF7YPzgKKoAyu2v2Zaqhs0YiTRbCE3Ozbj7H035+jOsWVo8QOXUlKhM
 EcttfX08SVqG7g54=;
Received: from mail-ej2-f43.google.com ([74.125.228.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBwYK-0008Js-Rq for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 15:49:09 +0000
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2a8b9acbc6so852631966b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790783338; x=1791388138; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NKhZSPfIHjTShIAIF3MCjP6k8ll1keioI9U6y7Tq1dI=;
 b=OQd+ihAyRfGG0xxHKiLNHNRbb5fPlsMQOPIwI6sB+5Z5P8JNcP3rOJVCMeVpw1tOxH
 3/hBGbYwJJyWU1oX2qspwZCFtgkraGMuiDBCr/KVSXgIP22r87F08gYGQOMGR+tEMsMp
 ad8Tw1sdJJTBqLBq1upzJgqyOty7k5hp+JqlR/NCRIYe+rduwAd6gCPlBOcsqlrjL3Eb
 5JKNVdLD2LdyOZ/fF17XqrePdJMV10Y+sZhWhmEc64rWvIEmEXh/EBCn3bkAfxfLjuX/
 ZhLyuYs/AkKBmyYdIMv3bILcAgsvCUWwoJUoL50XjO8D1rWGDXOKJ1607k97vWUBOpLn
 DYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790783338; x=1791388138;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NKhZSPfIHjTShIAIF3MCjP6k8ll1keioI9U6y7Tq1dI=;
 b=XIuZ32hhkwvpOffy2BtVPpG/sVnAyIZZrNW336L0E3z2YbDjBeWW++tVF7TMhfpf8C
 iQeDzkCF0v8LZq3jLbknFBgX4VRPzY7VD47As5AMCjmd0atxeItVuMmGDYmn3MG0iIhi
 AVu97zGCGZ+i6USnrZfThHF27EYdVU05I8XwlIh07ALqJdTywzaWUhQO52hJSDD7VpcN
 kLWZb97Zr1giAFlCSIaA+Vebz1Ce2dqKvAZsk5By/CEAGucI3YASVXU1lo5f9KlzJARc
 Ujjyf6U2JRb9IkH0LZ/nGAywAMfE3ARCmaOVJXeNYzlDduTaLu2xi6OPLBEuZhDaMCLA
 BpVA==
X-Gm-Message-State: AFq9FYIXtFKL/fnGpSAevzF8WvwmArTSZUGPmZAtN5Wpu2TwhumI+ryG
 smPJ2WchBvKPoxweQunSfI2G4H3UX30OQtubBYRQEYHxmR6A5naVhGafsQxj5M9v9JFMtiq8Cxs
 yMD8b1dSoUBTbmkzm6HwhyM4KnX+Q865qG8NenvbSPk/dAZNEBdoP9o5FwqNbA3fGvAc1
X-Gm-Gg: AYBFou27M9wFsNBWabDqQyHWDqcySYwWBZ3koi8ZDMZ1RUSn2ANKoceuXfb0ST7WscV
 ryjPUt+AxZrgspd5ZBbBN4D2i7G2h0nTOT1rP/bJslvfs5Y1Y+jz71fo9prerYWD2SwbFwXON/5
 /yNSfPytYh3GFZJ2ZjpZXt4hGF7J+uLNOPfPufs9GW2sDjFkgWqayc4pfjbPs73cBC18/pRQVwH
 3t0pKGT/U7G5ycJxv9zZKvMbW60g40VEtSfSgz0U3UrhTbBA4uaPNjz45L0ZTeXRVKxFMSrZxFN
 /EfXwf8W5t5qzyONfAUnomvlswXeutEQKRYrcrb3B1HYktvHT8oApcoeCEJRR6YOTO98Ur54/DU
 X80vAbEXs0UmTAxmc3a7eghLaZjwlv/MwLMQG2xq41ipCk96qopx6nsE4hD/wBRKkhsSzqRj66j
 rHhesZbk2pKFmWEbpUSVJ/aCB3oubDLLgL6s6+k+BXfajKnZHXA2AwcaeOxMIebo8M6NwWhUT8r
 V2/dXtidBaonXjhlJsm7mQnsXSdhbiL6w6Div8IdJN8LD4zoc/aJExwmcHudpIw9jynC7TGaady
 0s8VWXegEcoJk3wwnQ8Kce4Dg5wWZDuBhSJCckrPPseyw6LVVC+1yph797mq
X-Received: by 2002:a17:907:94c1:b0:c25:c7a9:7b8a with SMTP id
 a640c23a62f3a-c2e23cae540mr166130566b.12.1790783337468; 
 Wed, 30 Sep 2026 08:48:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e31a3b972sm31695166b.1.2026.09.30.08.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:48:56 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 15:48:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I09b055f15e35614eab112ff69166c6985f8770da
X-Gerrit-Change-Number: 1967
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1967?usp=email>
X-Gerrit-Commit: ed4d1c9aad6bc56ee758f897f105292a3a4815b6
X-Gerrit-Comment-Date: Wed, 30 Sep 2026 15:48:54 +0000
In-Reply-To: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
References: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzgwMTYyMDAwLkkwOWIwNTVmMTVlMzU2MTRlYWIxMTJmZjY5MTY2YzY5ODVmODc3MGRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <97f825a9676b1110becd01f3a3dcc570bd34d399-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBwYK-0008Js-Rq
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Assume termios.h is
 available on all non Windows platforms
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
Content-Type: multipart/mixed; boundary="===============9219460338489227973=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9219460338489227973==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MsitgwvaNWI="; charset=UTF-8

--MsitgwvaNWI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1967?usp=3Demail )

Change subject: Assume termios=2Eh is availab=
le on all non Windows platforms
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I09b055f15e35614eab112ff69166c6985f8770da
Gerri=
t-Change-Number: 1967
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, =
30 Sep 2026 15:48:54 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--MsitgwvaNWI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld has posted comments=
 on this change by plaisthos=2E</p><p>Patch set 2:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1967?usp=3Demail">View Change</a></p><ul style=3D"list-=
style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail">change 1967</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I09b055f15e35614eab112=
ff69166c6985f8770da </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1967 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed,=
 30 Sep 2026 15:48:54 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </di=
v>

</body></html>
--MsitgwvaNWI=--


--===============9219460338489227973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9219460338489227973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9219460338489227973==--

