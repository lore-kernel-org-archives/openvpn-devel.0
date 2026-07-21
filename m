Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D57C44529
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T3Huz9jGaB4DYG0hxk2HfCCFsD050e7Pbhszt7umx8Q=; b=QzctR56Yn6JZJpG9uPaT9t8H7y
	jAsgN6zwGSbqmLK7hCrp0QB/Oz8kRLWnPm4vBv5gDDwzs8dL3kErG+E9Ku75WJ/3mzmtzp/egeNvM
	uCU0n4JvD9CyEwaOydW7migB8wblOYcTgzhk58TOg0xCvRN2XHUocOl2BEFf2SqO8vD8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm8mS-0008N9-QY;
	Tue, 21 Jul 2026 11:36:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm8mR-0008N1-Ku
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 11:36:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HwYZptsAGAorvJEJBFVs61eWPRtT+2Z+xWFh1ptQ+ws=; b=VfQa3sXFNLnFW+x5zaxiGCbKwg
 FSjyP9D0aa/VlglPaDfMaQQCSAAZDwYYjMS08tYCElnQxDcOMRvAC+/mc1fidexeVLWtVWCe0ayLt
 HS86Wdx23LX8gUJdHcdq5x6IQP7DIQpTgd+x91D2nS4efIv141ZPZP+skSa0m8shdqG0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HwYZptsAGAorvJEJBFVs61eWPRtT+2Z+xWFh1ptQ+ws=; b=V
 6Uik9XBsDQ0WxyGrjjF2vxfmxnr6VaslmvE8UkSL1T3+5+EaZbliD8dkTBrjQAsytm77md8axPStv
 iGFtoXt4SxcwqVkzjKiIST7ERBjF6VEmEjgUOtJhpQVVN+rBOOMJLb3UKM1WrLyFcA8inVkJtoQ4u
 UV3pmXu5gpemBHwE=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm8mN-0007eF-OR for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 11:36:57 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so48470865e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784633809; x=1785238609; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HwYZptsAGAorvJEJBFVs61eWPRtT+2Z+xWFh1ptQ+ws=;
 b=UMcjZ7PqWK4Jg8oENt+I9du2OEpBQ/mhLBKDY0A+WawEJnxmcurQ8W/6M2RG6ICeWq
 rxSSAN+m55RQ+D5xuGipyupv64j3Ur8LQsKcQsoizTNZRtTaNP80ksJUTVCwKhK8Rbtu
 Jq3uGgzLXXseI0ilyLMTlAjuDGvcw4WsIihMRM2zxUxjm6KXQFkS3BfnlR8N77Sm3r1h
 GmzgDMH5/JcnnUX5euq0fEThKDKjWMeot4NN5hwId5Cx39zVdXHvWZ/O739+oFL0CvKJ
 8gx/ObMW4VOZgGShoh0u8dix8Oc8EK7uKjJgfvle2cxLEmFNbaKf6/lnc8kgt42L3O41
 iIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784633809; x=1785238609;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HwYZptsAGAorvJEJBFVs61eWPRtT+2Z+xWFh1ptQ+ws=;
 b=BPnfQHGonImPeOWMr6WAbaI5ywbVtSTQ4rQeT1SsdP66SgA9FqKy8mbEfb6TTxLzjq
 bMuwOzc+I0MYXcMGpazBqAbJHRQBBrhPPc+c94h5N7kTzAF6y1rxkj2JzyKaJjeeyAqU
 XgBX/PJWhnO7j6vlG3egEgT5jA/2683ZyTR+fR7T01axX397ExRYfJwBXnxoa9oQuFSD
 zFr0UZRI2H7FosITdrxkBgn3L6kRgx/uN+NOO2u4nto7jBbmQUxQb8sl+cJNY5t9RKBC
 OpLbp+atrKHRiwmByeME8GomPiSIu0BBzOJlYieUiJclyD3g80f3u3Ckma0B9LU77979
 dFDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqd4UE3aDmwdP7R0nAaN4hdk6TYskyAtTg9RkmklSHpI1JJjZJZgvz+X5QapbqXNx3ShN7wtviVT2Q2zqVG@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz6WO9LtvQ+W5tXOYSIx9SP3RyFVlE1FbkDGJdvTbK3ZkdbtUGj
 0fD8euCsPfUJKCmrSCFnwyWKVxPCW3asmqEqW2iWaBTQ09pp4RW2tPOOWGQ/0qfx/WtnPRr/2I8
 g77zGKMfrGscHvjnOQ9EBC6tTEeL2A7u3QJnwOwg+aQVs4+8MEfvHzUKv9Azrv+KFfqMHqup/nA
 NK5Uu6OQ==
X-Gm-Gg: AfdE7ckSGQSil8h7umQZ75BO2tsZVUA5zPFNGT/kSw/YAK9KJBxxVqWBx5fIazRmGpT
 WfRjVzF1YLiu47aB3hKorXuZ1NkKizwP4GEvRDHO3AA8WZIyQwaI8ABIhN9aK/Zx/+G5qMqHVFz
 O+1r8qKhBf0DBy9jOEYVMqXcL/dZsHOb1vomGVIjvDowLizIRuJoVRE+7oUsZlCO8+oXuCvZc/r
 jD5zrX3Ic6RegxufYW75v315zeKXqyDRxAp20HrskCvPJrDLBlpskjqY8TWBJO6bjNRNq3d7rVS
 jhtC8nYYJ2NDZ8AxMb808CvFjHfvUsArHp1VNE1w4fEPgSTeT4e9nlAteMxORRessnQ2igjl8+K
 wNAY7D5tHGIYotTLLZ69aCsM5Wj7Yxlqyi21gwJpnPqGmMzIKkBONG6iY7hw7l1uDsVO02UuZ8o
 /OWqmnx9Mjb/eKPxz189TT25vm+bcZOAaDQYLVv0zeWW9DdMGiovlXNwfbu30Rz09mW1rMGg+Yr
 UH9ShW/VoYTgr2prhyr208bzXEryoJIE38Su41UXbVea6p6PTgOmG8h1dGlGEbKtkAOk6jb+GAU
 eOM=
X-Received: by 2002:a05:600c:1389:b0:495:5dcc:52ae with SMTP id
 5b1f17b1804b1-4955dcc5372mr95333705e9.3.1784633809033; 
 Tue, 21 Jul 2026 04:36:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565304aefsm58865565e9.0.2026.07.21.04.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:36:48 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 11:36:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
X-Gerrit-Change-Number: 1797
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1797?usp=email>
X-Gerrit-Commit: ee7b3d5be874f61f2863b7a8698f82e4ca3bab25
X-Gerrit-Comment-Date: Tue, 21 Jul 2026 11:36:45 +0000
In-Reply-To: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTg2MDY2MDAwLkk0MzRhNTM3M2Y3N2IwZjc1NzBhNmEyYWFmZTBlYWY5NzBlMmVhYmU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d965df86502d714a2d3a52caef559e2fd60ceb95-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm8mN-0007eF-OR
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Enable TCP_NODELAY
 by default and push it to clients
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6344249684934233116=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6344249684934233116==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EaxqdudPPq0="; charset=UTF-8

--EaxqdudPPq0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

cron2 has posted=
 comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1797?usp=3Demail )

Change subject: Enable TCP_NODELAY by default and=
 push it to clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3: Code-Review+1

(1 comment)

Patchset:

PS3: 
this wor=
ks for me



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
797?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I434a5373=
f77b0f7570a6a2aafe0eaf970e2eabe7
Gerrit-Change-Number: 1797
Gerrit-PatchSet=
: 3
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ord=
ex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, 21 Jul 2026 11:36:45=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--EaxqdudPPq0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">this works for me</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1797?usp=3Demail">change 1797</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1797?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2ea=
be7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1797 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;anto=
nio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Tue, 21 Jul 2026 11:36:45 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: Yes </div>

</body></html>
--EaxqdudPPq0=--


--===============6344249684934233116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6344249684934233116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6344249684934233116==--

