Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5E1C44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EwWTAcGGhGEczz79FD0h6NpgMAt/ZHWmSMQsP9DQee4=; b=HJx3U6Uki3evCHdVQAmIIwMuUK
	wbrHVymXrthFh8HE8Ybdbkuh3AQq8gH1EmAjOvVNuGrujsuBIZo14UGLeOkhNlMX/kIg0BI2crfX/
	3Qes4LdtlymYKlItkFE3cL2waJjsJN/V1d5Ur+L3AduT+nXXemxZk/+38DtHtELGQXnw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1Ju-0005Db-Li;
	Wed, 15 Jul 2026 15:14:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1Jt-0005DU-73
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:14:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jDC12PiMKsAAqDwgb7AgeYZBXsEnokSMMLRWUIiOhNo=; b=dq2PHuE0X1ieEOudVy2RbLVKLQ
 Y2FY6QMKSey/oqTs2Cs6b8tcwP9O13vzNpEoAQzpAV8iiZh5qxoLeaOJ74DRWwRhPEKo7t/mVqKli
 snnXzNprXu3B6c9i81dfk/arBlW86cZgx3/1eg2YNBJ95JYbzJfw/S1lDvhhCK93tNSI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jDC12PiMKsAAqDwgb7AgeYZBXsEnokSMMLRWUIiOhNo=; b=d
 G2PnTiR6GLkhEtHszD+u0h5golXWMdiKAZLHtJKWDfVidlsRrHAmodIYBE+kMqSCm2MJdI+upBH4k
 FP7UixoWjyekuBXTEUOuLQKGkN+T8nao8P4XHVoj9d7iqIr1OQG1QL1kyjHy7mPHSJXDIqRkpW+ot
 3xbjDCVD9LxtjFo8=;
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1Jr-0007Zx-KC for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:14:45 +0000
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-69c7ab350e9so5863702a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784128472; x=1784733272; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jDC12PiMKsAAqDwgb7AgeYZBXsEnokSMMLRWUIiOhNo=;
 b=GUm3vSdxHIu5CIiD5qzHxTJ6Hu8WZrj0KOAxjWs7EWqxTsqBYblUiSMCx2gvMcYf6O
 QEVs0z3rtePMx1xP+7DbT4eRzeJn4/f2wStDyhk6CxbFXXy7w8uhvlEBFuX7/8zT/q9g
 FLlkFsCt9kW06emvmZZpcoXj4yLFEMBzDIdbOtYsNxii96JjR4nxySelgi1H+TieZmpI
 Xn98zRpxQmUBOZoqtSdwz+mwEnYbub/PzfXBAGmtrRfpSFWbmL3p4XjFggd9c5ocichQ
 yWeWWRXta0Igi/rO/aDh1jA2o6BP19QH+9kH/xP5xM7LA7wobojzEr5hogUt3nJUDK49
 cbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128472; x=1784733272;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jDC12PiMKsAAqDwgb7AgeYZBXsEnokSMMLRWUIiOhNo=;
 b=oUwxEQ0fsqNIbPL2JousTg/rnWfDOR3ybpKY343ZKfC2T6ak3y37VmUCOL6YqAzLmk
 JP8tddwvt19niYl2nH3fv/N84nhgkXaIescwW0e3KkWkEOc5cHdOxVAnVI1CI654Hx1i
 bDy2d79fcN/eeU7juqejdSApUnK8qh0B/GpNWiwTXioXfmDI2GPnPfm6SuaTP+qj6Fep
 5g/GpML650jySaZLiguwNXdPK0yJb/FZpQlvK0VYq9qaA0CNonAeOkUsUomwdA7NgKFy
 NOUVBu/T+XyftOatKotyDkFaBFnG8prPWmqWiKd4JZiq14L8+tjEBhUZJCJXBvn9IRpR
 as4A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIpFYWr8nCDt3vMjOZ0Vs/hdvWj3eP6EfiDB6MbZirCIxS++dtIsMruzpMLPpC7pY933sfavNjtcxXlw6x@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy6NAo9mWSQsL/NxS3cJHFQgqdF5qzBhG9oNMTdqEGpd37zKWlI
 8TVZmmHgz+IdJPhv7Z2mZdF6mRaJWSHb5hmY+Ec3B553PZ44SEvGeKJ58bdpsXzup1Cm/B8fCTf
 0hsMoO+vwILU/UABqH9urNJcrxJvqHLbI1EvlkWTEd2ZiSc2yfDtGKshisQ5ShV3vbbdkLX4uJK
 iWP2XAVw==
X-Gm-Gg: AfdE7cnzdjPuitPFC4iMZX2660W5yFl1fleekk1esPS4LvMtF2wVwLNLHE+fqG6Vtv4
 GfsgV4Ruji26E6GdUr44A97amtmCBDhii/zOERhwNQ9cSqQ7n7hx0CNlSv5t1DK8+vTsAL2XeMv
 xuNlK+Bo5U4Xk3uLBXzqGsiaxBzVsA1EtZQrfMKq+T8ycn/POPY4Vn5Z5GHBbp3UFGyuGprl6Sf
 M/Sgxju/Zk+Z3M7uJIlg09O5DmUByIQrKQ5OThGjAgZkwKo6Nh1IpLObG+I7wueFTq4YMWKzOji
 DRA05HnOCsJJ9cCY6cFVmGUgbEAI6vw5VckdS/35y2SAQAC2+EHuK2ipWJzSjXdirfrIfNo6cSk
 F8NxeyrtHbw2jBfKf6iAB0Rz9DbXj7AarB3Dei4V8CvLgntyxJgwMY8wfQ9fRNRVklH8zA1Ts5I
 WKCkPzcPuOltCRZrQJSZSnC1BPMfUfQa0Ggqkyln6/ZnnqVMDzP1In4uGJFBdqIsYS1Ou2MjPI7
 R8U40TlO5oPpntl87H0gkM2h0qVmAq65nwh7X/bdMQ8Ps5BFnoLlt0DgLo/1yzA8AVV3fv7o3Ma
 Y24=
X-Received: by 2002:a5d:5f09:0:b0:47f:4e46:e9e8 with SMTP id
 ffacd0b85a97d-47f4fcc846emr3334583f8f.6.1784121857837; 
 Wed, 15 Jul 2026 06:24:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c25b2sm16856479f8f.30.2026.07.15.06.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:24:16 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 13:24:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I37793543cd026aa4917129710c085c808e648c60
X-Gerrit-Change-Number: 1788
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1788?usp=email>
X-Gerrit-Commit: b3bccccb423e1bfdcdba57216e633444a41146eb
In-Reply-To: <gerrit.1784067448000.I37793543cd026aa4917129710c085c808e648c60@gerrit.openvpn.net>
References: <gerrit.1784067448000.I37793543cd026aa4917129710c085c808e648c60@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkkzNzc5MzU0M2NkMDI2YWE0OTE3MTI5NzEwYzA4NWM4MDhlNjQ4YzYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d80751414b6fb8121538e4cc6c6990cf0ed7fbd3-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1Jr-0007Zx-KC
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tests: cover
 subnet_pool6_by_tag
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2678916092401883580=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2678916092401883580==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SMKZGgKyd28="; charset=UTF-8

--SMKZGgKyd28=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ordex has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1788?usp=3Demail )

Change subject: tests: cover subnet_pool6_by_tag
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Abandoned
--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1788?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: abandon
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I37793543cd026aa49171297=
10c085c808e648c60
Gerrit-Change-Number: 1788
Gerrit-PatchSet: 2
Gerrit-Owne=
r: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Em=
uc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--SMKZGgKyd28=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>ordex <strong>aba=
ndoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1788?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap">Abandoned</div><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1788?usp=3Demail">change 1788</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1788?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: abandon </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I37793543cd026aa4917129710c=
085c808e648c60 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 17=
88 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--SMKZGgKyd28=--


--===============2678916092401883580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2678916092401883580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2678916092401883580==--

