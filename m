Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85131CD98CE
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d5J3n8743EjGEU1MGpqx3bbfFOhkQoyvIEGI2rzhWCk=; b=Qu1NKFWMzgPHzIsfKX+cTK6NT2
	CSgrxiDNvGhP2ZaCVOXXyRMAbRLoa3Hxb59sURcsO+1G9TRbFGgppzuYqvj62S64rZ/vkv1E1btF2
	DcxbDQfJzrk0/NSd/dy4JBS0s56rOKEoXMKYYUOlqtELot7SphquajlG814lUnLWU37I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXzgT-0003vG-4K;
	Fri, 12 Jun 2026 11:04:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXzgR-0003v9-9i
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:04:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0HOft8j8oAmpmabpuzOs8JfJ2iaYlIK0bbOgVgV2Sys=; b=L7xwdCWofxl7/WCf2JgD05RkYw
 Hzzxxnjmunqq1jwUHJgRaT2iWQXAYgK0cb/NtQ43e/qWn9UcAe9QNhdGJRWz2xQQsBW9uOfIFg+Ce
 iIcFZUPqCby7bUD2MaMSDfXWLGVnrjjavDzPpEzqTAPrZmt11nDESDBVvl7xTmOL5rMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0HOft8j8oAmpmabpuzOs8JfJ2iaYlIK0bbOgVgV2Sys=; b=T
 B/SA1Oe1qyXfyN/GjiObzLx4/auAlkVDXSBZi/d/LlOleroQCI74Sh6KotZhjte4rWdmBn1loH7Wl
 tnpOIt3bJXYTxSyTOvL2yxdBu0gp3c+93hzzprNLNvIucnqBXBi6rfLbIs47ndlDma6jA6gRsGfZa
 LURsZNgtkbolFkFI=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXzgQ-0007tC-Bf for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:04:19 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so7549375e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781262247; x=1781867047; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0HOft8j8oAmpmabpuzOs8JfJ2iaYlIK0bbOgVgV2Sys=;
 b=ByzPkRiy6teqSQObiXlIyo5+JVI9QedpzVcq+jtVoHl/aXF8wtS67hh3RYRSc73uMC
 tBqbeg2Lk4oWVOnf5iyEj+Ao2D1WvZGmCk+HW0QETUZAvgRL+2U+AKg8swvpxSZRhSmI
 dwIXLK+70uK6IhMrvWzOQd47jovdB40Jg+ufb5wU3a201Ovv7mARp0dP7dV/4li6FJN4
 OdtLHXZiFhV/4M+arX19HDQOawvqrAsHA46erGJ4vcq9qDeXeNySbcGRXt+fKUKuaeBu
 ws2YuuYlF02fjWIM1zu1NNJAqv0Zbynbeu4iWG57RRvjxmjZkNcqhEu3LopHDia2r+Br
 2Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781262247; x=1781867047;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0HOft8j8oAmpmabpuzOs8JfJ2iaYlIK0bbOgVgV2Sys=;
 b=MYWAcrGZfMwkUNJLim1N++Kw96yiApgyylZjsq1KNCBg8FwCyns0S1oQrpUUhZtNvj
 P4gmcmHapzeU2MIEhhFPrIVI8bnKbtaql6QCjzhiGYNtClaFme0aglX9TQgd7MMzhMqt
 L28yGMteQlyLWEFWmJHT4fdKb1LXbHD0hN+atE2V8TH/TvyBhC9k7RbcMJUcbWTShRfa
 MG4j+z19QnwjjW1PCpCIXKuTniAHzKwF9YlbXvjKmJVai0xNQKTxh/A9pfODPQsw1zWg
 1jAFQUEea7gUVI210FpbuWjaKE+6aIXOC9xCTbQXRA4mWmYlGf1YpHWQedssdhAChu84
 um4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TE7qsoDuwXJk5uzPXTr25y71oXSEchavHdw1JkYor4Y5bPtzQm1VJ56XLX1l9kBOfcJcyuG0jefNCxEiE@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw650XLLv6WwZQR02bkTEG+yrKmKJeFlBb27M0IeFIiGE7vwAki
 lSMlbLJRrEFy9C7jvWZntTLJzI5DnAOo44Fqp5Zk3FxZuvYW9uea7oFH3R8zP7bn+yMZsCatEZw
 CBFEo3M2g/xHEzb2FfrSCi/fAT4Nppn61AZyiHjvlwSy3a7u2arTaMMLlxQUy99DSwK14
X-Gm-Gg: Acq92OHdCuFPuZRh9spxiCj2fsaNrnQwF3d+mFYYwfevZqBIhZDcynvE5J1dq+soA/T
 fdVOlryARoLMy6nMfuhChO+RKM1RbLkDHjmKab5usWN0vMkUwtcYfuUQSPJmHnlZxD3mmnUkuMB
 PpTKvWnRRkLZF5wMOW0CVmeprhkTEwCFMXuaSyvk8dnftNrwTBnx+L9UvObR2ElWqhVw6UM1Rbf
 l7+9oKPDCngaY/X8JctbZyyNyrqgDUqS0uWwRQutLd2I44xFkiFpaxQOuphfqXvrFkxKZHdTy/N
 qD5M50kjqsCNdH77X1RYgKFXRg8pTfXCoE2k7/0PgkscxiHPqMtdNCR+L5Vnc9Xt7MbHmvuyD5x
 8hZD850MJaghopyxChl0A/9dKvujJ80L4cXJ+VS+62x8p+FLKK5koONPxYjvHj7Ve3h3DPG4THb
 1x/nRG6NgO3qMPApfcnrkdBrOOP5/F2Hrl+A5CBGuFgT9muW/D/N9fRMw6uSlhx9EeMk+HFxumy
 +6IjDIv2UXmj6c5F6Clt6rLFx/yJ6r2k+PInpsC8SchPNP3vOTGVnEmlVyl2Dhjioh6JvU2eXkf
 oMAoTlfRzcKI4Q==
X-Received: by 2002:a05:600c:a47:b0:490:b7e6:bd1d with SMTP id
 5b1f17b1804b1-490ec4ee79fmr30381245e9.16.1781262246695; 
 Fri, 12 Jun 2026 04:04:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f309sm5291200f8f.14.2026.06.12.04.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 04:04:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 11:04:04 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
X-Gerrit-Change-Number: 1433
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1433?usp=email>
X-Gerrit-Commit: ba93e1d9bb2bed939515c0b1b64d57654c3ad14e
X-Gerrit-Comment-Date: Fri, 12 Jun 2026 11:04:04 +0000
In-Reply-To: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
References: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY1MzgzODQxMDAwLkkxZDRlMDIzM2NmMWNiMDk3MjVkYmQyY2FhMTIxYWNkYmY2MmYwNDUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f2c40ae958b32ab6a1b299a93c42b34ec43229e0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXzgQ-0007tC-Bf
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbuf: Fix conversion
 warnings in mbuf and related code
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1524400991887445730=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1524400991887445730==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lkP9m60dwG8="; charset=UTF-8

--lkP9m60dwG8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1433?usp=3Demail )

Change subject: mbuf: Fix conversio=
n warnings in mbuf and related code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 6: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
Ge=
rrit-Change-Number: 1433
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Fri, 12 Jun 2026 11:04:04 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--lkP9m60dwG8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 6:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail">change 1433=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d4e=
0233cf1cb09725dbd2caa121acdbf62f0452 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1433 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 12 Jun 2026 11:=
04:04 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--lkP9m60dwG8=--


--===============1524400991887445730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1524400991887445730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1524400991887445730==--

