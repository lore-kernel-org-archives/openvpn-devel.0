Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8791CC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=08fhiE5PwYQjbqcGgCAMrQRjB6Bic7eY5Bb20j3DDyQ=; b=Rvx7jMkUKBP51+vTGZnQNJgwzZ
	U9CTAo+jlV2uYgrm5yaEbkQDligA2I5YAj89lcg4qShPN9N4prxzkYmKf2qD7oDyS3+mRtj6kcgE4
	usThgwqcpZ1aWYDpqWpb1xzG2I/MrvkoPGwLekDUkEiBsFtnTrcxsT/EbS+bGlO3k8jM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weA5Y-0004YF-QQ;
	Mon, 29 Jun 2026 11:23:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weA5Y-0004Y9-91
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 11:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=m9tg2Y5JxrJWs2rkFj/6geyZpakv9MjBPdDKI8BCbn4=; b=JhibCRj5cSU0NUhFZT2RWZ3GNC
 3Pt+FS2RllnJKufuyJGTa3uTq+A5v/sLLKz7tPqVGFxgHDzSYKSMSF0Jq2lo98TRUeB2Rp7d8LGQO
 02CzDQ7/JpnYTCdpGObxmz3F8UmN9UZvDOycFxmulWvLq8GIVPxJUcmsksxP+BwyQKas=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=m9tg2Y5JxrJWs2rkFj/6geyZpakv9MjBPdDKI8BCbn4=; b=D
 NXhPzGshQAbyQBq16uuoyTuj6L5ryYnuEZ4gl4SddY6MNPA0gdiOmRiQSknDvKMRSwjCOF6fLgVS1
 WPM2LU50bWLMznZ/QXh+TnE5Z6h9mr2zmLvurUYMw5KidHn7TnOSiSgInmLASflopfPVIvAULkP6G
 ZQEV2iqBjnfhTim8=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weA5T-0007KB-H6 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 11:23:41 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso41208635e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782732213; x=1783337013; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m9tg2Y5JxrJWs2rkFj/6geyZpakv9MjBPdDKI8BCbn4=;
 b=bk8co5KjfKcQXIl/lm450gsGUIgUxJXVxi/VKRBbvKxHM+bPpa1QO8FSRxfNROsbwT
 VKVdCTAdytyBuYjVLTOSHtA33d9padthiV7G1LHOBuV7RqFlLTWqLCe6xQgLc2sve9im
 ZttM2YvI9fSHtMrf67sFMDvecAcItoynzLxn8p4BV/WM73t33nYl7hn3qnPOKW5pa/5Q
 nVf84mKT63BpI2ntvW2Oej1H8jmFV8PfBJxFtJJ/OT9JrObKvbnOdvrpzne126+y78Pv
 jD2Lc5o3yd3xdJXOrwZw+FQV4t41L3yiAtLQSODOQyMuCWyBskOMDAaA3HOt5Oh2aB5j
 mpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782732213; x=1783337013;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m9tg2Y5JxrJWs2rkFj/6geyZpakv9MjBPdDKI8BCbn4=;
 b=eGOIEprBnQ4N0bNQm302/ay+Rs+zkKwwIVQACrWYQcb6ygbifo4PBR8qohFBfDqMW7
 m+8sLFl1d+SdlzA4uwl5cOsyCmLbUW7FS7s2RrtxOnx+yG4U8vGbSmG9wdmsEni1SLe2
 zgWTFH+yyriaPmyjI6fonjcjtByoaE+qRNgOZqVzkOiqDEXmWwyTyPGXNT5L+CFCF3Pw
 zrz/txvw1sYuYcnxKB5FWLbucZ0HYk5OgMvzzC3s51GV30EW3lKrtzZeT4iinbLo8Aub
 1aQsXXCiAGE0MgrKpF+Nax14afJ0/IwGaKK7MzT10S97d82ka/6MCAIqgBsU/2AWp5+w
 vR1Q==
X-Gm-Message-State: AOJu0YzzRT9iqsL6/L1GT6fbgQIowN3gbJv6PT+a5RP30QqAtiGU8BNQ
 Ke3yyj02s+q2qsE+dNh9E7QUYFKIduKmqjfd6ttEu5dKugGgvqM8dVCsI5hpmuGYX7yCi29t79x
 PL697EnfkF1vo2n1H+gCFjpCD2gn3/soIfEBinD+7W10N36SnP/wAmFeSjMYonxyvwa43w/xUZ0
 mWaSZNZg==
X-Gm-Gg: AfdE7cndJ+KL8gZk4VTqM2u/joqEUdWXe1elOfhdmBI1UADepTS+buaUKLJruQ82MsB
 bOQar6XQP0Ssc9jdFYVegRFKSmft5tjSnqFx5vOhAP1GnN1OCjWDEWuCgjPA+Z6sV1zmuAZceTj
 bUPuj87wdWYCkcj+wDjW2CLD7De7+Cp7J8tJcpJBaw7c5DeKAlNwWfTRiXwNlGaAypYmHe696HN
 h7QR30jCJU7n0x7OQ7l56LggikOymPGX1eiABvixtlaNX/vMbHMpPzcRh6bXhSRuzkyaGeOvh1H
 i4d3C6kMlXDbfZ/NuwQXALS7ggZHwVLi44aJABRCmDiFmtzmWYpEUH6WrySzx7FDSEO56b2/xws
 g9p1z1fXTKlRHh1ZfP642iWwLbu/1Ld7IyoNSqJbT5kQTVgjPN9gM3koP5SFSM5qEk25b2SFsWE
 FJKMq1xZPh1kTJE7LgSTFBpqWy/DPWf7w/dJEip38wAbkb9Wtike0wvtUwQyt7507p/DJoa2EDY
 YkyBD6qOuFqZaNQfyZ23+8lTzPKR/YMWp3TiYXV+TXHSjUIPDMbTVNWOB85R5zEwTwZ66BfvNVS
 QpE=
X-Received: by 2002:a05:600c:8109:b0:490:bad9:de43 with SMTP id
 5b1f17b1804b1-492667ca5fbmr249358175e9.0.1782732213286; 
 Mon, 29 Jun 2026 04:23:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b2766da1sm42405865e9.15.2026.06.29.04.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 04:23:32 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 11:23:31 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
X-Gerrit-Change-Number: 1740
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1740?usp=email>
X-Gerrit-Commit: 4c1d09e3bb0b5db506178a6d091fc08dc8a456ee
X-Gerrit-Comment-Date: Mon, 29 Jun 2026 11:23:31 +0000
In-Reply-To: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNjc3ZjQzZmMzZWIwMDUyZjhlODBkOWE3ZjA5OGQzNGFkMDNkZmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <80a8bcf7cb604287291ffca6fc64ea8ff1d126cd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weA5T-0007KB-H6
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Add
 buf_read_u64() and buf_write_u64()
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
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4017001033484504133=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4017001033484504133==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OjnQiGitZ2I="; charset=UTF-8

--OjnQiGitZ2I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
740?usp=3Demail )

Change subject: buffer: Add buf_read_u64() and buf_write=
_u64()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review-1

(1 comment)

Patchset:

PS1: 
We have htonll that =
we use everywhere else=2E  I think you should also that here=2E



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f09=
8d34ad03dfe1
Gerrit-Change-Number: 1740
Gerrit-PatchSet: 1
Gerrit-Owner: st=
ipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Mon, =
29 Jun 2026 11:23:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--OjnQiGitZ2I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>Patch set 1:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1740?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">We have htonll that we use everywhere else=
=2E  I think you should also that here=2E</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Dema=
il">change 1740</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
740?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1740 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa=
 &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &l=
t;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Mon, 29 Jun 2026 11:23:31 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: Yes </div>

</body></html>
--OjnQiGitZ2I=--


--===============4017001033484504133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4017001033484504133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4017001033484504133==--

