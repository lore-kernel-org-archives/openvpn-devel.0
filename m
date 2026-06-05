Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAF6CD8C81
	for <openvpn-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1RgB+JMYvx6yyUGYkgko0JACknerFlFuvF84xqm9gDg=; b=DTgCVd5hKypbUUrn2w8JhaIHF+
	wgWsblxKtP47xtk8nNhnIHTMDttuENNGjw4swb7OBWraSBegRKF2k03GDw+s3SJJTZqH6bag5lkwy
	LrAKyDujCK2POmVLWGqfye2gxIjBA21obR3sjpjK+n7b3fkwL4NmmQDJNIXdX3UnHWYY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wVVN4-0005HT-AJ;
	Fri, 05 Jun 2026 14:18:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wVVMv-0005H7-6k
 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 14:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WQ7ZPCMoBJVF01okjDfgJaS7idyUJnzvaeoafJig9fM=; b=ZLKtRJ6oOsDeFWRMsWw66DbNSq
 RUsvRqx1n7bXGwSbTWQ4AODVfyvhdNfWWAmUE/B1pqdeAV13gSqfrxx6WSd/0U+KkWde6hJO0tUgB
 JI2E/0CVRSgwGGVUlP8UZsKeZdksvOEvu80qlZ4EttKtIcRJWHjdK7oINNcEQUdr8jAI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WQ7ZPCMoBJVF01okjDfgJaS7idyUJnzvaeoafJig9fM=; b=g
 XMt4neleY5hiJ9ZMzPBC1TME9zNn758smeBjU82GeHjRx6kzfcJImTlp53xnGVs8TjscU8ldUPyw7
 UM6PuFGEb7qgsimovRch9h1r56uoNrcKPhFtpeK8v978j6TBGw2RsGpz8r1uCNnOvWbrtz0HxgGRC
 v09vg5rrU4ojk1oc=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wVVMt-0007nw-9h for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 14:17:52 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490af320e2aso23164315e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 05 Jun 2026 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780669060; x=1781273860; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WQ7ZPCMoBJVF01okjDfgJaS7idyUJnzvaeoafJig9fM=;
 b=M7e0um6HZTy2cLs+2H/5QJ/zNrCURMNX1PRRKW4c7WsuTQSjuk9sMDTGt4K8hwT85o
 KNqtJRg6CRnm+vSkcWkQKaBj1q09hgFb/1RiVlRobe2PUzFpii3v8f2YCN6grXgrZ3KR
 RhZhypZdEOzsfu4KXAZVabUHVXEUaFAvIUZCmUTJ8qmhi/UkI659jK7XmrEmocz+xmy5
 RAve0ug0ZQUcnWYZYB6vVJTPB1HwyhHkpSldpAigaWWZooXTj7Eoa42xHMob/yCV6esE
 K6QRwWkx3/GZL1d/r49oYyk0p/aboj8s1PT2DxA9AcwGkMp8Q9Ff6kjM2EG+HYENj2/q
 RUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780669060; x=1781273860;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQ7ZPCMoBJVF01okjDfgJaS7idyUJnzvaeoafJig9fM=;
 b=dFM5E+ynTsk7MOXSb+wZuNBW2qDddhtjZW+f1hhDyTlQWpWOrbWjoR7L6Ldknorvx0
 q9f9Y8C/SyjupfiIy1noj+KWb+fXiUZN51c6xMAbSQFVxdCueZMTmoRNDessMkOA1jOs
 9+pHkT1aL5rer3MbRlxb/r/4/eknpviM1M1hg3BU/gscOjpZIhpcYJSoK2kj5RvG0bYj
 gB59pzocYWljDZwD3JTskTT7leqxE/OaKHhZBeLj1vjXsYfojBaVxqj+bSSbXdmQcJ+b
 7LcItJRRpH8BGwfZGYFx+H5tzspQrHor7RKMaThq+ljw4QCbMJ9+sxE+oN2N5OFzkobO
 m3mw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+R54LubAtFC9e/Y2NYA5Hgr0Q9fDD8wwWh8n5tcnsHFy9TQmIR+hm7oD4dcIh1uoMdj7LIFm9hfCVmHG7@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzspXJMm2jqT6SyzSJnSoW6A0/Udg70E6V53SZnkd7xJ8ZZOLY8
 f2j0zx01Spw3cQEJRNj2ZB7K2QucZ3MP5qzhyw/iOy3MJ2VshyZ//q/h9ZE17WyLhaeKUrnDMEZ
 TVCSFlT0/fQvt23zr0slxsvm2wrlUp3jPhlkRpWtvpY2FgN+3brAXhRurrxPqtr/xXKko
X-Gm-Gg: Acq92OF5SYug3XAYXL2yFZgTYvL0c7gl22cgC+3WHk7Kc3YEahyoLCbzwPeiMKV7HX/
 +fcf8R+wgNnMFZB0vis2v5opRO0+qRwKPaJ6Iifu9xECwyE+L2F8spUdbbXv+mdMQgJFwthIRAA
 NGyJOgPTPEs7DUhHiwS6P9eqV+bcicmX0lgaZ0tktfbyE/3Od430S78b3D33xbpe2jXmYf9wxTZ
 GKj9IY4fcywXTGtF053jXDIWzYVRcLP/aZuBXwSx3w92KUa+mbhJ18NiKjfVCLl+gmEKmzSzv6z
 kt0mVfcpn6VtQA5SpQ3wGLxMglHOGeYB23VyOsSUr8QzpOU1IMSP5k9sB5dFtBTamr7Lteo6VgC
 jDKOBs84WPU2reCaWreJFcCQXvPEb5uoRxr/vjsxj12Z002JieUAkkh+GwJww7OpBCJbpeSE5ek
 UjOYh8GAmr/bpBJP0wycE7Blc0bBmzzbwjkETyiwb8kdd2MFxZuqpr4mby2odk7M6mGEymidnct
 4wF2/nuDVOPa7B4y12IW0ZfIP+dVAJWUhoJ04mksyV1Aw7IDGY9joESUgK0ukDfz7G6Tx2ya68+
 O7bXY/67gpmzqjw9i+4hbmxd
X-Received: by 2002:a05:600c:c493:b0:490:ae52:499c with SMTP id
 5b1f17b1804b1-490c25f1ab6mr66909125e9.21.1780669060107; 
 Fri, 05 Jun 2026 07:17:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc39def5sm152017285e9.5.2026.06.05.07.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 07:17:39 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 5 Jun 2026 14:17:36 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2ce954aa5b74002be5e38d53783435736625bb2f
X-Gerrit-Change-Number: 1706
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1706?usp=email>
X-Gerrit-Commit: 85c28b13f51ba2d226daacf7e6f9d5dda3cddd07
X-Gerrit-Comment-Date: Fri, 5 Jun 2026 14:17:36 +0000
In-Reply-To: <gerrit.1780404721000.I2ce954aa5b74002be5e38d53783435736625bb2f@gerrit.openvpn.net>
References: <gerrit.1780404721000.I2ce954aa5b74002be5e38d53783435736625bb2f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwNDA0NzIxMDAwLkkyY2U5NTRhYTViNzQwMDJiZTVlMzhkNTM3ODM0MzU3MzY2MjViYjJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3b1b34d49146956450e696eaf1b097b13e88a32-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wVVMt-0007nw-9h
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: assert
 buffer length before reading prepended sockaddr family
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8272502585297506403=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8272502585297506403==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zlE9Dspcz0g="; charset=UTF-8

--zlE9Dspcz0g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

cron2 has posted=
 comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1706?usp=3Demail )

Change subject: socket: assert buffer length befo=
re reading prepended sockaddr family
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1706?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I2ce954aa5b74002be5e38d53783435736625bb2f=

Gerrit-Change-Number: 1706
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipak=
ov@gmail=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-=
Comment-Date: Fri, 05 Jun 2026 14:17:36 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: Yes

--zlE9Dspcz0g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1706?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1706?usp=3Demail">change 1706</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1706?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2ce954aa=
5b74002be5e38d53783435736625bb2f </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1706 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Fri, 05 Jun 2026 14:17:36 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--zlE9Dspcz0g=--


--===============8272502585297506403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8272502585297506403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8272502585297506403==--

