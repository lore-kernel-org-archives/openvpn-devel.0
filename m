Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50772C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M32CoLvj/YnhLh6eGATt3aFHLDFO0+pNQ8TU1B+NK8s=; b=IhFW+hjMqbBBHeO/SM3SCtvW78
	ngakCOh6d+M79f2XrZldS7oXVd7TvR9+RDBSZsAo2rePv9/EVDurRddVtb8J+K4PClCfYP61FhRWO
	ZvsjGGgMls2cWE0fq8Wr9nfErRX8/bU00EMTLK6AAcv+BmrGMRWtLtXibmuoZAMEJpRc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weCr3-0001ao-OY;
	Mon, 29 Jun 2026 14:20:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weCqn-0001aT-It
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 14:20:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jMzPHZV8ZIxPGV3FHwNemgIVJnmdPppnnMNl79ZZWgo=; b=jrN8GPHEfF5Pt3V0jR/NFUnjGM
 h5qFkDilkXecVCaIHVaAAq9X7ZJG6OYi/xtDnbsGr3qfx3cnZLC/mgKbd2xeSzWRpd95JEhO51fSv
 wDQ0rQV8ALN/JcaXeNUWtkw7FkN8qLf14d+l7PjlxMDoHXCT6yh/fWwbl3ij6o9GU2LE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jMzPHZV8ZIxPGV3FHwNemgIVJnmdPppnnMNl79ZZWgo=; b=e
 0rxXJuAgAv05oFl3b++uMbdWsS6Q0jR06TKMtYWHJ90XchSaJE7PYb4WcQrMX5f/kn92GBiwUfVh0
 sj87Lo1d0jFS0mRWJ00wHdO/E5ZaA7sJlMStRmbTt/od2gDAyylDkokCjJLw3t3V8kmtQl9avv+f0
 J3gMEDfGCmMQggrU=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weCqi-0003CS-0x for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 14:20:38 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493b786d6c0so576455e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782742830; x=1783347630; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jMzPHZV8ZIxPGV3FHwNemgIVJnmdPppnnMNl79ZZWgo=;
 b=EeEFfYyaTfaok70nKokXHQ+DDJYxdMyxtLclWfXt5QIvVWAJzBS3Rwkqu9yKNM8J8k
 9b9h29rKg8XSrItep1JISGL5B/5F+3tMc7e7Y/bQLqzJOVOE7dSN3XjOl4czjLBWPUCl
 sCWzYvCKglulNj5zgZIF+NotPm1i52+P/7I9z2Mtnks2QJtSYYPgRJ/sfWh+i8r7zyE3
 9jwgxehlBxhnd5tzuu2kGvaq+EecwhaIqny9uXrGBeo9udzkAa7lrMxJEf+9Cb8DdBiC
 MqIsuS0AkrG9kTmGkPEIzw8xIB7zxSlqhhxlU3o87fscThLfAH4GS0UU52FnbqljlnBI
 NJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742830; x=1783347630;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jMzPHZV8ZIxPGV3FHwNemgIVJnmdPppnnMNl79ZZWgo=;
 b=iDqQfDr54yE9aXgt8hyf1L0t6Qm6hqSPOYSkCOFu1Kl48XV0d/w2iyx9suljvOQxOm
 60OWN5DIJWDVpEmQcjmDFyPN6hda6qTHXFXRzvpbkEzr3pTyjLI6tUDQExKLQhAmOa6Z
 uPmN27Y5MbhX9inDRnJ5qgmGvJ4U4g4po4XcDVBL3UpEMkZ3BlOwjIsXvlL76gLkFfz2
 XD6ReWLK51NdmIEYySPL7e0Kk3ovDwEO2kMFqY0cq3laqu43PURqTCS+UyeEqz+SbIza
 8QzxXQIwCNQdqoTqfkqGM9WcPOTBk6xCeWYlF8eyYqy1keOfGtpbOngs9Ckz/g0H5bn+
 PxSA==
X-Gm-Message-State: AOJu0Yx9pIDD6fay0t8gUsaKWe3nw+cNs1zwS5lsmJjg/qHdrOL0gRhc
 Ds0RO9/lIemRx6zf6/FBGcvYmmVmzjieHd0BKjHYK53JApVH5FuB0hKBY3RAns6m3DrpjzPvdx5
 6vBXACIv1lXK0GaoEMN4ZkIA1N0TPT7ul4Y4LMS7PUGNi9dguuRVALFM+lNVPCjWqgWm4it2o3N
 b/dfspVw==
X-Gm-Gg: AfdE7cnwIQW6Oo0g/Gd+9aufS3Tjb+n/TlBlxxNXDRQnCQdcP06PB/uLAeKeKCKBtyu
 KMJsFOb2aPJrBG36XeBwVgHfG1fwazbJPqbDM3yxJCKf72AQH/sttzAuNWtkGsAY+B41KooC69D
 Qk/s8SJ8At/F3nRQsDGVdiGm4Q5pkGuwq43iRTQ6XjiahYTDtytw1zIengv3c+oyaz2w8uxmhoT
 cCWdoybq3i9Y4LG+ouM/G/+hmvWC+GLk8XivkNa7wppjGXb6d7meLJ5cmYzrhr5GNCcwnzVYgct
 Bl+Qqd2ot+ErxB9mzZpQ/ZMd1cke6zCkzKtFTEiy7g4I7Y46ZKmOiYxKKRebDQmcSQM7qI6DG/V
 WDJbo6lNtk/eaNyiPgzmOi07Ove5hcSRWIp0k/7SXNXWh5J1C1jM2Htu4QO1quyRGbno1ez5mYE
 2hmpMNljBAF6HbDbkGiV5+CpwRdzRWq+7apomr30IOZnPSkMtBMELWZl/JVkkehpoRNWPn8n8Nq
 IupCalQsvudd65SSGM0MfE1rlwfvQFSy+QNgFQXgoULb2JCNfe4JGixj0+2Sg+vY0WQ40uwd7gl
 FMg=
X-Received: by 2002:a05:600c:860b:b0:493:b66a:69b2 with SMTP id
 5b1f17b1804b1-493b66a6a04mr23316535e9.15.1782742829827; 
 Mon, 29 Jun 2026 07:20:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4939a8279f3sm160105955e9.10.2026.06.29.07.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:20:28 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 14:20:26 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
X-Gerrit-Change-Number: 1754
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1754?usp=email>
X-Gerrit-Commit: 438ec4d558136e24dad22269dc2421e55c47dafb
X-Gerrit-Comment-Date: Mon, 29 Jun 2026 14:20:26 +0000
In-Reply-To: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
References: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQwMzE3MDAwLkljYmNmNGM3OWQ1NzdkOWNmMDg5YTkyMzc4YmU5MjUzYjFlOTQ4MjVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <166ab46975f2af9b99b91e323ec89b5a680f5c99-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weCqi-0003CS-0x
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: GHA:
 Cherry-pick changes from master to keep working
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6973856120919723728=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6973856120919723728==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lWNfSUBBmaU="; charset=UTF-8

--lWNfSUBBmaU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1754?usp=3Demail )

Change subject: GHA: Cherry-pick changes f=
rom master to keep working
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: rel=
ease/2=2E6
Gerrit-Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
Gerr=
it-Change-Number: 1754
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon,=
 29 Jun 2026 14:20:26 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--lWNfSUBBmaU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 1:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail">change 1754</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: r=
elease/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icbcf4c7=
9d577d9cf089a92378be9253b1e94825d </div>
<div style=3D"display:none"> Gerri=
t-Change-Number: 1754 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Mon, 29 Jun 2026 14:20:26 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--lWNfSUBBmaU=--


--===============6973856120919723728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6973856120919723728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6973856120919723728==--

