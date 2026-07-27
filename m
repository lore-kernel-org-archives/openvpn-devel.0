Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8F6C53209
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c2EUPCtKw0WASrmf66XbRDTBuoMh6hG+GG3RfHnz2y4=; b=fdX9HBfP5xQZ6FX3ABJIFYZaaw
	O2uaWTPn3NaKmRHa3ZU3lEMQAoLpc0pLUPJx1d1UmlxuAG+nJt56l5J8OVsF1KxdH7DCIObHWMTsm
	/YwzFD1tLZvzXCWDc/4MxRANxaAkfIsAFbGJZm77vQPLTaak8m2AG/gENz6AF4xaF1GE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woKqx-0007sT-I0;
	Mon, 27 Jul 2026 12:54:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woKqn-0007rQ-03
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:54:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cRo/brfCSluzQ4EHIgPk/JdhchREBQUfT6Ao4vbI5wg=; b=bLNiHUuxIiaUBcUAx81Yz2IDP6
 sUc86Yd9Xz7qESoEZIXWL874dyPpzZGOT0S7pu80Ca37vVMSOc4Gp1wS3kT4wni2fmajHCJYE2dRg
 p1/0RykbsZA1oCP8qdHXzfu9iapF2ZSXFsq9hGVHcDHyvzJZcsuQGxrz/XPn9u9DGL0o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cRo/brfCSluzQ4EHIgPk/JdhchREBQUfT6Ao4vbI5wg=; b=O
 KbTaucqf9Z6D9KPZUAzBo9XXnGa+0LHxxSdcxkw1OIdcCpI8+/47v1wXewd+fJP5mdU81Ys61Zrya
 0kw3TDEe/N6Mg6gtXvuAaI5KiQ0b9PskQgRxkXS2x3XMhq2sIwqyKb4l1vLsyCqGL8aNJpRLKh4z1
 DD40EGdhlXtYlKYQ=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woKql-0005Ul-RO for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:54:33 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so12815155e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 05:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785156865; x=1785761665; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cRo/brfCSluzQ4EHIgPk/JdhchREBQUfT6Ao4vbI5wg=;
 b=fb5GoLZgdqF8CslQ02rGlTIQHF7hxaEdYTPlWC+2LQqqPLL5L0MHKCknguQFBAVp5Z
 FGA825n105l2VnoMrTkgrRgRts3QWgx2gKXqHNvoFevBjhnVo1NFHLNq6tkYqxocOk/9
 njiJbKdsMC8BXBgxquDbYqidTqGVhxeMJ72Pk68DFZr9L5CItKV5qMWJHO4egAsvwFxy
 EuaTQGw7FZPBJCWKTWfQjuiH9bP/Q2+QLPKZPeyc7WSMaovHaxPKdef5moiyy4FcjL2N
 n09If+mu9tDVJjgPvOCTsDvf5EkkL48BZDryLPD8uHWEaowWBm/N83f3geAeLnJdv+yv
 JKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785156865; x=1785761665;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cRo/brfCSluzQ4EHIgPk/JdhchREBQUfT6Ao4vbI5wg=;
 b=k+ux5lrsUKbxyQhQFuYoNc+eKQ/tDBD33HTWwXX0c58XlcCdoHbtIEf2LJURNrxAHy
 KodX2+IIzaPkp8jV8VAPd08QpJOSJKs9fjrwVxkSqJNRsKg6yVgliN4FYXorsf5Vjgb5
 ygKMTjp5uuo9xdoJmZEqANxQMtvCnaK6KT1JoHRQLoQJs/dl/ZeXOhaIEUv92mgPJObs
 esNJ3yG6RF+pmTBV7XBU349g36u+A0F4Hkwqvu87oYX5980LwOsCdxJOpZXAUuKzWyfw
 xagH0TWQvK1Lu0JaIU6NETDBAVO6OLT3iKsIlnA62uaDEVA6vo3fiFcYgqTWnFbrp1AY
 nw0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+3GfFUL38VPESJSGXu4Jf13axDDl4vStGqnxzD5lCjdB2h0E+f92UNk6qszS+Ndu389d3mD3HaScmsj1o@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxe1AbMsZPZzQIZzqKVVQ6DGGV0ENfIvtEAJoD7JoryO5jUHBnW
 bw6/Aa1wuHtAnqCFO+vyCDoW19Y7c+6YWUfO78JH5+STeAhfxqwODAtyqyQL8GhG5ohGuKkSKfT
 XjGge9ZhSQBa1jkQTkoXCw4rrIJX24DWy79zidma5MO4J7kBU/IQYooq6nNAOw+Y0L1CXhzpVio
 Hzk/R6CA==
X-Gm-Gg: AR+sD12eYqWL7yXMSTBFviD5EihKOpOAcX43Lt6lme12AWjJf7ZY+750VXJMgGCcJ4r
 vFjWtEKe1qYLrJbcsWFBtAWM00AnO2N3ck5OijtwBqGcw51RFUQVyLXpNfz1cuy66E0bTOkWn07
 R0Wb/0gYXJsvqMtWrWpAjBEEmALt//zpTLWORv3AsxEFYQlbApT87t+tGPcD0GT4JV9uGWpLvDN
 j4zrmKASLZ2x2wphYp5tTPPcWUC16YkKupqhWuEYPdCRwN/U7hLVytCKqP/CuV+0eoqnhnwEO1Z
 y/OOEFKdAshRgfN0b4oXrTkPMxa7u6+KQ695O+jE66mVX5bH4tPQ8BJolsRBOXX3xn0UceSWnE1
 Pyasxyhk2bM3H/v/Zm+BCEgJ8+1ZI25dQwb4kYsV6NehjPxS1Ey1TTMOvcDFiiLKq0jJTjmbkAQ
 X2gLQGOmtdZdeEoW7RfL0Mi5C7EC/cewaIhY37weSzAPsuS9YxBzzvmIsfuhpCAlkG5yRpuOSpX
 wpMVEtFmCtFDtbGcIggMV83udMtNBiKLyenDxGGRWWtAKnC4mJB5Wmx197GgAFYMazy
X-Received: by 2002:a05:600c:4295:b0:495:7990:a1d0 with SMTP id
 5b1f17b1804b1-496b571a0c6mr68937415e9.19.1785156865175; 
 Mon, 27 Jul 2026 05:54:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4ee1d31sm240336785e9.5.2026.07.27.05.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 05:54:24 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 12:54:21 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: bd364225ca43bff02e48a74bc08220ff250e1bc1
X-Gerrit-Comment-Date: Mon, 27 Jul 2026 12:54:21 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <968d15e081fc24cfcaf5699f3f4457264eacb29f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woKql-0005Ul-RO
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Use OpenSSL's
 SIPHASH implementation to double check our implementation
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
Content-Type: multipart/mixed; boundary="===============7420625902188950636=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7420625902188950636==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eBb9pcJI9G4="; charset=UTF-8

--eBb9pcJI9G4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/31?usp=3Demail )

Change subject: Use OpenSSL's SIPHASH implement=
ation to double check our implementation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 28:

(1 comment)

Patchset:

PS20: =

> Let's discuss this carefully=2E [=E2=80=A6]
I changed the commit to only=
 double our implement (or AWS LC) and also removed the whole context stuff =
from the previous patch and replaced with a fixed sized array=2E



-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d=
54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: 28
Gerrit-Owner: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Co=
mment-Date: Mon, 27 Jul 2026 12:54:21 +0000
Gerrit-HasComments: Yes
Gerrit-=
Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--eBb9pcJI9G4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>1 comment:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #20:</a> </p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Let&#39;s discuss this careful=
ly=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">I changed the commit to only double our =
implement (or AWS LC) and also removed the whole context stuff from the pre=
vious patch and replaced with a fixed sized array=2E</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?=
usp=3Demail">change 31</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/31?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 31 </div>
<div style=3D"display:no=
ne"> Gerrit-PatchSet: 28 </div>
<div style=3D"display:none"> Gerrit-Owner: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Mon, 27 Jul 2026 12:54:21 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Commen=
t-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body>=
</html>
--eBb9pcJI9G4=--


--===============7420625902188950636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7420625902188950636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7420625902188950636==--

