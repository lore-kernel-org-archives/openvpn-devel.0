Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DABECD8CAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UNGTB99GwafW9u9ssr/PICou9ZcO8KPuayKkufj3arU=; b=ESMGzTtmw35sKGB+dl/rHfK4J/
	bATm8b6P2kJXvimySLPq19ta7uikVrlhjj6JqSuWnO2a7PhzQ78VaMCZ3W5TKx9DPgcrL3KIJYX0t
	9wxZNS/IVz+mGuO4j2xbnLsQz01sWCUUnXcUbv4FgqCNbldqwOAbvC1oAc1CvI1dRJWM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWy4F-0006Z1-Au;
	Tue, 09 Jun 2026 15:08:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWy3l-0006Xj-0E
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OCowVU6EOGYvlOmmJQOju6nTnUo//q3fGxO8QWfab4M=; b=SgyyGLttmP5sRQi5kEDt1Dn20F
 03qJznxzJ2/ySyVW3Efp1lL9u6F2H10oX+HboUFDYP4yPea7NMuzOR6cYhz8rTQqU0ejJPACmW1Wu
 3F8jFKMmKfqgvHEW76Uums7ypbGvhuys49UdAPKZG8felXtlG7EUpwpwnrY5h51Dyz8Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OCowVU6EOGYvlOmmJQOju6nTnUo//q3fGxO8QWfab4M=; b=n
 NBd5+rSr0rk7I2Ij9Z2eWJbISToFMdyRCSdR0d7GAaEOHHaA8j30aluHU27bCXDG1qK8DAXGCZ+Hr
 86QJ+Es25w0PFKoP0DLYohQZzMZrEqEl9ocJUgpHTJYb1DULRB/KZAUGkBlB+A0wiGOP7pZWZH7tS
 gTwblNunbTOqZ/Vw=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWy3i-0001VX-Na for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:08:08 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so63231375e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781017676; x=1781622476; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OCowVU6EOGYvlOmmJQOju6nTnUo//q3fGxO8QWfab4M=;
 b=L4rtmHefelAm+6mPvC2ASRgUvZjs7Rq+poRE+U9yP3XgjdnSrYzfw/8/pZs2YMLzpz
 9oxoDtpVvMnIu0BVgA0JKS8fQ71yiW1ElhPN1z5tuRLiuhRMEDZ8LmOQ3YBPAJ7Afo+p
 ZqJUSTzSGVH2rf5LwNeAMf7dFRzYpk61u5LkyTqxQ/M3PM8PVQDbULRWU1jbMKeaomXl
 BtMqekVy2mVCD6GpHDpmA5z9Wf1F/9bwouDVeCKLhfAwZgGhPyExWymsIB0md+a/Be9P
 Q4+BVS1iUeQoX6pkZn2bEPW9X91racEVkgoIvfjrsBHQNRWU381fD6JpNNwdsl0CanYO
 agLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017676; x=1781622476;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OCowVU6EOGYvlOmmJQOju6nTnUo//q3fGxO8QWfab4M=;
 b=YsYLuXeBlAkL7Lt8swOpZxHyX44XZUFXMBaaaR5TDvA/F5SVnqHGRwtgX4FPh9wTcf
 VmO9IxAcga+5CEkVsuemTNwwKupoNnd4mh6jCSWsirD6oEouY6SJO67bFSjV1U8dW+uE
 U98yCeHVG2SAZGauBAzFS9i7tldsjycZWAcjRlPLXhuYQJOQGvo48FIF81kzFPU3jLKW
 WbwOnjNVYyI9MHJxYhRav4DXFYUjBzSbMteolRJ0YpD4t7yM5F32//rvskPk/cO7kn2z
 yPWUVaoBk4iTivgxW8DZUQnjOKgg2wBB7VOBWPdGEi+ceZ51EmpgaNh8RoAm1R9tdFPm
 IFnw==
X-Gm-Message-State: AOJu0Yzj4+kjzhLGZneFaZ77bsW9nYSpambnLQlXWoPuZzTZKk323L/i
 rr2fGjpQVYk3nP/4pPmKp6ljJGIxduP7Rg/7s9uTldjc/4k5L1VzJq8pedy3LejwEImr7TetWL4
 DMwjj6WBccsUxpbBSctiPbh2uEyyKFSxrEa0MCUEyTSPqAMVvu1wNbLt50Jp22YBOAZVk+tfev4
 NBQEfs+Q==
X-Gm-Gg: Acq92OG7vVC9KdWnpMlYAz89msfHz92gmDlM9kJMIWKY8NYVFQ2kHB37T87Gp3rMU1b
 wUum6v4ZQKBYH2VVSIjydXdMnCYJlGaITcK/a5jPGcCdSN7B7YNmLqBwSu0BvC1+/lXeth+iKDj
 VJFtbtuaz5Urg/lk8jq7ZFQoNbZMk1XQRx3VAiREN7lAgKRUqPlrED7ofGHL9mWjvX+3sYnjQmU
 bWeHdz0OcfjPuAJRduvTYm2/3LvL34wzzLnaaei+xyu+/pduYVg+tzXljjVCpAGxCz1q+0fz300
 DaSiunJO9E3wP5Is/23IwQe0An8TGnDIXjAOp/Kc1uyEylqdMNFBbGWjLHgrEAsnyhdCGY1Mhm0
 ztQeCfsxghRTuzpVQt9971iWr6BYMnUz/j1tH5MuW/JBPzZKcnlPrAffwJ3s9DXrbN8uBb8YCmw
 jvuklonqgE48lkgE5THcZsHfVG3mvCaTAv72YmMC8r1p1hXegYWWk91aHbjl7A/AuE4LWtYdqGo
 TMuXExnnRJyP5CYLKUWZFVE6jEb6lHU7ktnPGXbKV0KTUfqAf5stsTP63CsSCZq632O13CQEC/i
 3l8r1P+fDhf8+Glmx+UA/5K17zMy1gNx81I=
X-Received: by 2002:a05:600c:674f:b0:490:52c0:744c with SMTP id
 5b1f17b1804b1-490c25e2dc6mr319957535e9.20.1781017675525; 
 Tue, 09 Jun 2026 08:07:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3cc0f8sm483369155e9.8.2026.06.09.08.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:07:55 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 15:07:54 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8a17d452e9e5690a5507d17129286142df6c88f1
X-Gerrit-Change-Number: 1711
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1711?usp=email>
X-Gerrit-Commit: de327d6ba42e622c7e7721f0e1491a9b5700031e
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 15:07:54 +0000
In-Reply-To: <gerrit.1781017122000.I8a17d452e9e5690a5507d17129286142df6c88f1@gerrit.openvpn.net>
References: <gerrit.1781017122000.I8a17d452e9e5690a5507d17129286142df6c88f1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkk4YTE3ZDQ1MmU5ZTU2OTBhNTUwN2QxNzEyOTI4NjE0MmRmNmM4OGYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2c1868941cecd76bff57a71668398d8d1dcc1b01-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWy3i-0001VX-Na
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Switch to
 using VS 2026
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
Content-Type: multipart/mixed; boundary="===============2653952445988289224=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2653952445988289224==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fBmVhqI1OQ4="; charset=UTF-8

--fBmVhqI1OQ4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1711?usp=3Demail )

Change subject: GHA: Switch to using VS 20=
26
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1711?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8=
a17d452e9e5690a5507d17129286142df6c88f1
Gerrit-Change-Number: 1711
Gerrit-P=
atchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 09 Jun 2026 15:07:54 +0000
Ger=
rit-HasComments: No
Gerrit-Has-Labels: Yes

--fBmVhqI1OQ4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 1:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1711?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1711?usp=3Demail">change 1711</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1711?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a17d452e9e569=
0a5507d17129286142df6c88f1 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1711 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Tue, 09 Jun 2026 15:07:54 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--fBmVhqI1OQ4=--


--===============2653952445988289224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2653952445988289224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2653952445988289224==--

