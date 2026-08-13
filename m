Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813B5C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tFfg7rVxag3cd15evEUeVJ2ikhhtzLMmDohGcaq7/Bc=; b=BnP0kie64HIuWftFOaA00dXndU
	sLiYLPm7Qb6O4ASwBA3GBJXfbCxofXFjUPv1f8HVXqPEN44zbVkTws1X/s+WNclUMOvmVb35Txq1b
	qETAIf9whnVGR6ANcJ4fSfsn5WFYMeqfEUl1gb+JJatDkOJY3bb+oeQu5Ovvkfwh1P6g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuRkR-00065i-6E;
	Thu, 13 Aug 2026 09:29:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuRkQ-00065a-5v
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 09:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yvh2+KglQJxROQyswu8a7T8GANUBBbQebzv4qdyQrTo=; b=ixQrYIGoCeGGuDEFuvbqiQkn02
 Vs+5Q9sKLnTOFd1R3zsQQ4YZKAhI9eHUAxtUtwf24kyqCwoEqwkGzqtzTL55eM8kyJzBQoV6lwBhw
 fCOaPHRjyjqndzu6jH4ARVRloDy2aKxWcDOT7lL13VAXmuOv7+Q38A2k+NEi3rIVmkV8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yvh2+KglQJxROQyswu8a7T8GANUBBbQebzv4qdyQrTo=; b=T
 7aC2KdowxUynzg5Gi/VCryBJU7uVSr3efg0nadZM17TbxYV3gjnqJ1Wo46ou6KoKHMUNbmGXb+I3m
 bio4KIH2QHLoSb8kINWPt2InTSyjDgXN3z87c5sPRR46q8gxHvfJsIrgvHJX3j2Q6FwlhGERJpGtB
 jy8Bx6BNhOdBeC8A=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuRkP-00058L-2M for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 09:29:11 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so14220345e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786613343; x=1787218143; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yvh2+KglQJxROQyswu8a7T8GANUBBbQebzv4qdyQrTo=;
 b=Vziz7Gk+YPEw9RUrv8TZVEa7LaqV4Y0c2I0fiCqdckEL9/e4kV2mMZ2pLQ8G+EqfZg
 tVSKdpBYjI7Dx1rcbgvSS8dptKD0snHk00v3tE8fkVgrbTGAlcmwSu5IrKACEgz1H/95
 r0PjeY1rR3y+kAOEqxTbaF8jXSEEmRlChztY4kMHZPXePMlURueGr0uxH/LrFLqY4B2b
 at/Z5llJ+qNqdHiqCGxspiPhSr7vgYli/c7TlcyG4PA1nTDc3EeIbi4brh6k+6PZWW+t
 uCIyS8aXxmRBq9lu/6C39LvBRZuY/jc0DbxkGqyc/CphxVdJ71/5mG5fsENkZ491qTub
 7Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786613343; x=1787218143;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yvh2+KglQJxROQyswu8a7T8GANUBBbQebzv4qdyQrTo=;
 b=mZkorwOEiYbk4Dz5grB4tT9w0XnTpF4jCw87ohT1nBYJT+Br/CgShXQ7QciOmAKWrm
 MD3vNS6L/gA1MH7mqgYe/6vXaycfwECYrWL+qBcZEpW9GAugz+MAUGR9PcgpB9zTCEWH
 H+70SxraqPizHJ7c5YeOUCoTtZbSNPpiGEMa9ybRFFE75QH+DM7tlEC/b4fUb7dFdFjE
 Y3PxK6KqgAqfa/tMWPT7mh+VS5AqookbjK6tSGLxcM3xZaQX7JEvifPsZhtbu/ng07z/
 FOD44YJQlFavYLAjb8p4MRjYvyNWaagDGHs2guS5NIJIsMMRz11vZuHC3NqShxLEBjmT
 AiOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrilGDgr6JRPzkphk/mlW3Wxn1EyUCLujBtV7lRhNWfsOnigz1PcG98U7tx30GJC/xiCGwrBULV1AQy4eXB@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw6Iuq1oLyfPieJnxdU5pwNQD5fZaT1XcwOwThvla7nZuUJxF8O
 9d7UxXDW9l3ktVPYx43R2JcrtiodMmrPuyjWHktBS8ZFvP1CZqPipypnseoecP69xf7zGiDCel+
 XFdaUcsng+EkoFN39pye7NsMIKMlMfu0hGWAllyAEBIB8fW43LQP5c3tw9Xi8/EqDA2KrsgBd5V
 wDAItXew==
X-Gm-Gg: AR+sD11kVJVb3BSkiJweza4Z56l8gMLjoIl+s5qyE/i/3tZNkt2yJkAkLWCJ2ezhhR4
 xzkxJADWifV2PCSUPe7KZTWTa8mUxgxme2stf4XWJAcN2yFezOoGJOxV37mRM4AyHe5qHuEnhTl
 eJMCmaoohSdHB/PYyRKWZv1uFtY7zLmAwdZaQYjcqF7y2veZHkKxkOctqss5bTkuAsNlJ7VMibO
 a+tQJ6ApqsKZHjE0nfFydvMI6AL/+0j/jEm7MY/Me99YMuhR9UTYI9CQpc2RwoO4comiHPSIxpv
 cG3vZHjcrXTODWCwVBkauHn4/OBN89+rQy9BaiaPNvSGe6ohKnDEYGxV4aAuwXJTAlQHqmsCbc4
 tRX162mwWDBn9yHNzj99bhnNRxnkP/RDjrl66AfP1VaUx4BiZ7Qu3xfhPVdzqujqjUVK4LBibn7
 pieNARhQP6VYKAjdyh9yO/KZkzwIL5VEdUulPj4H1UpnHwVQlPmJifDZ6uO4GQ02KgTGNvbDKeg
 oU6qhkupWLXU1iqpoRz89kX5LFDB+TqmYtEvJwI4Cr605hFgEmtRff8ZMs6fZM4LYMTGcUyraRa
 tVkZbP0DXzc1ixuTyTwQ61PJ+hQw0uRX/3KpJhICcNJJimsKHzlAfcccpX33vQ==
X-Received: by 2002:a05:600c:4ed2:b0:496:c9cd:e7ab with SMTP id
 5b1f17b1804b1-499821616c1mr40744845e9.5.1786613342796; 
 Thu, 13 Aug 2026 02:29:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a56981csm4854754f8f.10.2026.08.13.02.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 02:29:02 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 09:29:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If458a3362e03630ce699bd122e957169601657a5
X-Gerrit-Change-Number: 1833
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1833?usp=email>
X-Gerrit-Commit: 1a3b086e44f9eae781d82779dfbcc2952c9e5207
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 09:29:00 +0000
In-Reply-To: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
References: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NzYyMTY5MDAwLklmNDU4YTMzNjJlMDM2MzBjZTY5OWJkMTIyZTk1NzE2OTYwMTY1N2E1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6ba5445fc64fcb4ed1ea834fd95240e617f59c8d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuRkP-00058L-2M
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Replace
 ASSERT(rand_bytes(...)) with prng_bytes
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0077715589477387962=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0077715589477387962==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="INvG9jBcGG0="; charset=UTF-8

--INvG9jBcGG0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1833?usp=3Demail )

Change subject: Replace ASSERT(rand_bytes(=2E=2E=2E)=
) with prng_bytes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1: Code-Review-1

(1 comment)

Patchset:

PS1: 
In general,=
 I think this is a good change=2E  It's incomplete, though, "git grep" says=
=2E=2E=2E after applying, I still have two occurances

```
src/openvpn/cryp=
to=2Ec:    ASSERT(rand_bytes(output, len));
src/openvpn/ssl_pkt=2Ec:    ASS=
ERT(rand_bytes(key, sizeof(key)));
```

so I think it makes sense to change=
 those two as well?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1833?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 If458a3362e03630ce699bd122e957169601657a5
Gerrit-Change-Number: 1833
Gerri=
t-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Comment-Date: Thu, 13 Aug 2026 09:29:00 +0000
Gerrit-HasComments: Yes
Ge=
rrit-Has-Labels: Yes

--INvG9jBcGG0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1833?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833?tab=3Dcomments&amp=
;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">In general, I think this is a good cha=
nge=2E  It&#39;s incomplete, though, &quot;git grep&quot; says=2E=2E=2E aft=
er applying, I still have two occurances</p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">```<br>src/openvpn/crypto=2Ec:=
    ASSERT(rand_bytes(output, len));<br>src/openvpn/ssl_pkt=2Ec:    ASSERT(=
rand_bytes(key, sizeof(key)));<br>```</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">so I think it makes sense to chan=
ge those two as well?</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail">change 1833</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If458a336=
2e03630ce699bd122e957169601657a5 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1833 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: c=
ron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Thu, 13 Aug 2026 09:29:00 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--INvG9jBcGG0=--


--===============0077715589477387962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0077715589477387962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0077715589477387962==--

