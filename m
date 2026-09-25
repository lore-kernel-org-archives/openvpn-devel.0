Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE658C98318
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r/8mIqGKyeBKDVofeziFQKmg2aRzzRUgkklYRgy6FOM=; b=EtMscj5zZw/u7N0oO+yK+pVAwk
	qkp6N1Podq+3wmkUeUlkihDr8cnGfRsaesOYofbmFiUzZYO0EfLjff30WUWH5kZGUP1TwI7JvA6YN
	0ad9zxnTw1zUvAM27FBK3ICfAV8MBXhedFed2mpChSJbT8zH3eyx1QhgWZQPNMVg66Rs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9vsJ-0008Hp-0C;
	Fri, 25 Sep 2026 02:41:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9vsH-0008Hi-GB
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 02:41:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=84lfy0tXYBRnJt0KvRydigN+mV38cuiYNa0p0PWmkj8=; b=Dx2YHH9/ZCkyilglQXDJbtp4PH
 xTfI0QuEAgwXlFcmD5oQVqO8UzHd1VmvDyIvoo7mF+nf+nehqDu1gDZUUYL1VNnRU1DY0i5MFl52T
 QVNmAOBMyxCjpgDIEbpMRvA0qWSqCSu8ouzryo+pEJPJ/+eK+/hvAmgeZANC1L5KkZ/E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=84lfy0tXYBRnJt0KvRydigN+mV38cuiYNa0p0PWmkj8=; b=m
 QwepllIM8Vdl3c9iKW5Rl1/lGuaRadu2MqnfNmoFflRjkqvfWSq4q0v1WdoZnAe2jpq7Ervib/0P3
 INzlQ0BHSVtumL9sV3W+89XZXHoHngyKWUFXc+Yf2E2r5d+M4P+WjrksRaw92UAQBI3795DIs79+C
 1cZi3SQ+EDtDT0qw=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9vsD-0001Cb-Ej for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 02:41:18 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so2249595e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 19:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790304071; x=1790908871; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=84lfy0tXYBRnJt0KvRydigN+mV38cuiYNa0p0PWmkj8=;
 b=TZzez1GnprRk/wu0VyfbRLUihrEoa2avidCYFh4Q4UwD/uvnNgujVb8R1Ybpj6oMg7
 WqW90iHKjub4wOfooJsv2whTiv8H8m1IisuO69R9VSMwi47m2rv861HOIJgizLLH3K0G
 EBF4fyOBekQucG6XqvTQZWTBXzABfJzvdZak2Ec4leq1NJnVWR/Gof/krkdYy0ehtAUB
 CqwLDjA7QfwBRiHCGAoZ5szJAueXoJA634FvfTEfNqDAQtWaLfFd6MeJlpnsfI1Zhg1N
 /h6oocFoChyNVtlQWazts1qv9vcWyyNFebb/tXrPwEnbnnxCoZvhmlLmAXpwLnH05v8x
 FEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790304071; x=1790908871;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=84lfy0tXYBRnJt0KvRydigN+mV38cuiYNa0p0PWmkj8=;
 b=AJIu0w7DENwkQF4vWezyPx4DaDmmyH8casT2QC3wiMZHpPGuGVMv1qgrcYPFxPQxuM
 rD7zWGx33isRcGuWIJ8xg6kn9FzLATCpFRQSBA5zoV7ARgsfsgkwoKSNpmT5JH4sMdF8
 k4u6GANegU4qqKhHquXoC1d/s0tMEL8WlH9X3Ruqa3fTbXNH69PxqWArnhtuVEzN8rtz
 UmnHS1OmfS82zS2pIDcEZ6b8NpzRtM4VVIkZDiRTmju5wPN3LHBFI4xJ/hsqxIBnulzd
 q8oumZOw5PWqs2EKCaCJbGvaC7o2e+wQmHVXZOU/lvlzp2W6mPYRUo9vE7k6lSbRFxA1
 s6Ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3aDENKpVfA5bxfFjzltjNz3jqkM/o30j+/KGYy2P5/zgfZu2X11Sf+qoFWS0UaR1G4m6/SJHc3E6V2FnH@lists.sourceforge.net
X-Gm-Message-State: AFuF++lO5ys40DiWxbHO6HwPvOL/lAweVZKkUOr7BVVOpG4Ni3vo8z1z
 r7AxwMKb786tns3x6kDw2e9CcZS0Fr4RWbnWxikj8LJIVhbnCcLI5TmHJ80CSyx4ftfTIRzcqRk
 j58X4qXc+ajv4fOtbPXDPHkb+XnNmfRNwUrGown3mhnNvKZIf0nhaqwvpb1LbEFT6TNPl
X-Gm-Gg: AYBFou2+8hxcZZ7ciPUT+CBD/rsJtTGHTRU1blFiWtX/mqeQjGKpvtc7YgQRKboup1o
 gqMvbqV/PdeYRWuox/lphgBUja+0QbRvpNvneHXm5CYQll9LXkcqBlYe9MUPnHtC0vC3oqswiPo
 gUSODzdUwwmrYfL/td3GhiJGZPbE/+C2b8jK9a33npyFJug8p1OgNtIHWNHOrI9/IF/etTC6ylz
 ZhqzzOo6QjuXNbw9VoepGG/s/g6UJXE6o/eTM7vRTmAuNzaoFz2mYDaG5zLwpc4T1yPYAhkUwOP
 qEs3ZAJkV1rla+xqUwh7PuwMzIn8AjtY0jLXBuJasBhcwOVN6Y/0i6F8wvijb4OoC4YYD8OF13v
 MOqRDd9Mzp6f8kQw3BnR3mVEubOCse7E05GfcGOhZHIbEdfDyDplMBMaCNqTQx81ZzfRPnQGmLq
 ZCmETTlpX33fQuWyoKcmTJ1N9M095oZBKiaqD0EpNhx0xAc1M0tPJJt32r+LJjpPIq0p+Qa3eOG
 Kwy1yKc1Ebzw9Lwd/3ImVmY2gjF9M8JSlwN0YYCQz22zJy11ePD3YvEkFw2g75Kkp/ohHr9w6ny
 qSQHC1eGLFjCJvtIfvZZqKSbiyJO/G6iwlbdjLXUdciZot3rtk3B0VFc/2aa
X-Received: by 2002:a05:600c:a013:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49fe66f1ac3mr65867825e9.16.1790304070861; 
 Thu, 24 Sep 2026 19:41:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30c43asm3506071f8f.3.2026.09.24.19.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 19:41:10 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 02:41:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6
X-Gerrit-Change-Number: 1948
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1948?usp=email>
X-Gerrit-Commit: 9d30ccd17c7f0ae71488d9929531e0834018ec38
In-Reply-To: <gerrit.1790212215000.I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6@gerrit.openvpn.net>
References: <gerrit.1790212215000.I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkkwNDk3NGFjZjY0ZjU0YjIxMmJiNWYyY2RhYThhNzQ1ZmMzZGNmNWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9c91fe3c7c78a6e644dfdedc00dda3592404299a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9vsD-0001Cb-Ej
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: doc: document
 net_gateway_ipv6 for --route-ipv6
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3112271209331297388=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3112271209331297388==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9RmoMeYH5cc="; charset=UTF-8

--9RmoMeYH5cc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

chugly has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1948?usp=3Demail )

Change subject: doc: document net_gateway_ipv6 for=
 --route-ipv6
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Abandoned

Folded into I9e45c0e=2E
-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1948?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: abandon
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6
Gerrit-Change-Num=
ber: 1948
Gerrit-PatchSet: 1
Gerrit-Owner: chugly <charlie=2Evigue@openvpn=
=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--9RmoMeYH5cc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>chugly <strong>ab=
andoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1948?usp=3Demail">View Change</a></p><div style=3D"white-sp=
ace:pre-wrap">Abandoned

Folded into I9e45c0e=2E</div><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1948?usp=3Demail">change =
1948</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1948?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: abandon </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1948 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: chugly &lt;charl=
ie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--9RmoMeYH5cc=--


--===============3112271209331297388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3112271209331297388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3112271209331297388==--

