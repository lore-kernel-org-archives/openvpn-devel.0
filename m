Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803CFC5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q95tTfgvCbG/eaWFrzthDGAbQ3A3p21jlpdePshlpgk=; b=bKugDulvhalknzaI0TA2KB4zEK
	pCM57L9nK8JXjdUurxy0dm7BcCkH8gxswO0QNI661gV/VbVnQE7M4CGVWRCtb1Zm0ZA3Rc7aTGuCe
	4W5wSedpRK8v1jRbZKajd2vjjaeu/7TN4/vhkzMcCKBrx3JdmcNSOkNTcU+kB4mEn3nM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuZTF-0000mp-AQ;
	Thu, 13 Aug 2026 17:43:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuZSw-0000mX-RR
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:43:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lYLUvVhHuZMFmf980FmFfbPK+L8XcukDk4vcvNeSe3E=; b=S0zSkoU2x9mZt6ZT0e34Xoy/bJ
 8Ae9nwVamAXf5CHvQvuchTcThHwlRm7YVAts3FWh5eAo4ZA0+zCpIZzlVSPcSDbxPsB7vxut2v9nf
 H/u+e2IvO262Ra0vyo4S+ao3++1yDYsIbt8BqIpnvJm8jYu5ZRlm8jj4KtpPZ1ESIByg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lYLUvVhHuZMFmf980FmFfbPK+L8XcukDk4vcvNeSe3E=; b=S
 sDHPKpx23mOjrhkXkID1DKAXDBlHefHxdttGYPmNwgKPfPHOJC8OWMUHn93FMzp7hwdQxjVxDA//I
 ob16nu8gGJZlc61vSR5LM30+Rpp7LuTozrOnwAORgnYIZOyTpFeooYWN2qq8oQTlEQMm03/iCTQ1c
 4Rk/3iMA3KKX4xg4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuZSr-0006XU-Nj for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:43:40 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso1437635e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786643011; x=1787247811; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lYLUvVhHuZMFmf980FmFfbPK+L8XcukDk4vcvNeSe3E=;
 b=IA52rUip8xAo5VOpDtc103KopFo5dO8qwjOI3WPpdRM553/PJUFYpPDed0HGSXB61n
 MQOE1caXD7rrLbORK4pBsbU7RIJqFaxiWHyST4vcuXH5219ho5v3b/eg5/cLZ956RK2A
 1e4CBMM6wpWCRs7YKjP45StFD7IKBH1/39NaSGzMUblo7aO224qbFcZMlN9X2t0/Lhwx
 69qoxx0u9Sif0Afc6kEKuoha5C+z3nssZl+NBke49JrF+HzIfkf7DUOIeGahw9STnWuy
 9gvSuqeL4+DTCvTKG9rJRUZq7cUsu7cHdQQyqjl90pFE9C11bFweYoKokLT/s/h7Q67v
 048Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786643011; x=1787247811;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lYLUvVhHuZMFmf980FmFfbPK+L8XcukDk4vcvNeSe3E=;
 b=AMROfaRJja/li9G54ylJWL2ws8AdYskZpbTOxqIYOn14Gi8uXshVClQzh9G4yP6mTG
 wTtRagPnCjdc0TR+Z9fEt2JTuxqKCcUopxGy6ehJE6MTBTNNsrJj5DF0IOpl1vLopy6l
 ySer3oYPWnW0PxXaoOERSj9LSr9z6w9ybAW5gnM7arLjD7gGRhTKVIPALjUkKHUDdrIu
 MXsW5tndjWSGRbpPEcYHCey2uR76+iAdr9/21q7U9F12SFSTyNtwHsgRNFxzSLC9ag9P
 bsz/749vjuGcQYpA3ra51gyP03EaIVHkspihQGKQcvd0YgyLS7yVzjuFXlmQlcT7/uo+
 yXDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAanSc+L0ywaP8VvBC1yxSUyX0GN/mIPsUlQLOJXL3VF2JrcguQ32YNp2uaZwxXzOnCFPIYbYNX3GpbvJ5@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyarJ22RJiYZeKwIZXCNPH5HM3rdk8IuamtwRsj+MFIBLS+D22y
 Xayoe2xuz7LHelPkyTMAkrvpbgHKwshX+7Hkn3J9qDP8SbHcVbGcolzifk7V6WrcBqKco6QQDRP
 eI99Yr5aPUIazcfkINbpchZjQq6SyAzrDxr07wii9OwG1Kg+ITw/ZVHmxossKcjc5oprB
X-Gm-Gg: AR+sD10kh+TTPPwZmL8Uxu2Ryu3xE1x1UIvaFLqmqxg7HSgRnme26EgEGNbZAwaG9Uv
 7BAzuKJcTh5tm3QDPb8wd5tNU7eaTYJUdAYBiRum29ri63BMxwzRchoLsA8DHDtQPEwIM4Qb9VH
 FcFZC1qunk2pIb2mdVlf6o7zqrnsloYSfDMQw91hXApIjgzLGYUHJz0BUOcBpqVB1RsS0gLJxJs
 HjNIdcq/IIGSFy2gcmSbCd/jGwUX15geNbFp99qjKnpwrmXnmJgSwdIcqrYofryHuzMStBmXJnd
 94SwYr5iiuP/lPMJ1c9/nNsygv0POH1TG/brCXGov+FDtYvcoInsiZCGYJNCc1+IKO7SCR/2V8F
 3BQiucJDHCKb8Ulj0C0y0Ltob0E9wntErAEuEG91CXWL+hp/02nBz1yfqUVV2g8wFqcbbq8DZQV
 Qux+kRwtS0rBqycyg08Bmxd6R73rft/b7pYTDhp5Y3me9cR/rviKVhbX7+fyrk1UM9gz3euNRmf
 eARCO1xRO+33JI1FwL/0BeyaTqtKucBDtll697/rbUe8bPRbeAxyk3hRi7w7gD3ZvmUDoQy8WCw
 lOoe7BExj46vlNpA1OEePMoADMI3C/Rs7ASvBo/JmgqcSfK4DFc=
X-Received: by 2002:a05:600c:4e14:b0:499:7e2b:8e5 with SMTP id
 5b1f17b1804b1-4998793ffe7mr2772995e9.5.1786643010988; 
 Thu, 13 Aug 2026 10:43:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d1e74sm8148675e9.3.2026.08.13.10.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:43:30 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 17:43:29 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie44556f5ece28b54cc657fa86261b827efb42467
X-Gerrit-Change-Number: 1779
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1779?usp=email>
X-Gerrit-Commit: 443f4ad5c5f9b5665df10ec64bf11e3d630f2440
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 17:43:29 +0000
In-Reply-To: <gerrit.1783961511000.Ie44556f5ece28b54cc657fa86261b827efb42467@gerrit.openvpn.net>
References: <gerrit.1783961511000.Ie44556f5ece28b54cc657fa86261b827efb42467@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkllNDQ1NTZmNWVjZTI4YjU0Y2M2NTdmYTg2MjYxYjgyN2VmYjQyNDY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <358775351921d6e1889bfe7e606ae4588adc403b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuZSr-0006XU-Nj
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: win32-util.h: Fix
 includes
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5191370757686728421=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5191370757686728421==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aJUTbCYD45c="; charset=UTF-8

--aJUTbCYD45c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1779?usp=3Demail )

Change subject: win32-util=2Eh: F=
ix includes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1779?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: Ie44556f5ece28b54cc657fa86261b827efb42467
Gerrit-Change-Number: 1779=

Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razv=
anc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment=
-Date: Thu, 13 Aug 2026 17:43:29 +0000
Gerrit-HasComments: No
Gerrit-Has-La=
bels: Yes

--aJUTbCYD45c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1779?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1779?usp=3Demail">change 1779=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1779?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie445=
56f5ece28b54cc657fa86261b827efb42467 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1779 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 13 Aug 2026 17:=
43:29 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--aJUTbCYD45c=--


--===============5191370757686728421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5191370757686728421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5191370757686728421==--

