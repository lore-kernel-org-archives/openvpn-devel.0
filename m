Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86973CD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sV3wU7yZAXmAv9+Xl/ycgbtR3As/uwhj9x31L2lVixk=; b=LWO2mwfo0GweBOjpImX3p3M3mt
	EwE+WY2j61mFXtVuVHBgmz/5yKs78SZ71gKtUfeY5/J8Z7JQXTo1kx8azmo3gKh7SmELchkLW/ox8
	5e/1zfvDVlcHReAbQ0ZyJNIZrJXBZWXLXafZymX6mFjWq9LI0fX3jJu+IBHkFC2jnp7o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWy37-0006dS-4Z;
	Tue, 09 Jun 2026 15:07:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWy35-0006dJ-Ew
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wa8W6ZtjHI4JLbC3NNRkNMaPSOPbN+RK2+zMm+8OK7c=; b=iKPSBn4WtF6pG44/8AttFzLSdU
 /sIcdch9PFj5tRz84ADC4EpmjipIjDOCCueYFxebGEldXS4535vVB3+1qW12oouA+E+8YqXXiDIEM
 ke+0MB+ejx3HuIa4Yv6o7RjWll/rmEdPYJtUNzRDXfEMh8RNAk7i+iD/gWEnzQ5v8G38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wa8W6ZtjHI4JLbC3NNRkNMaPSOPbN+RK2+zMm+8OK7c=; b=R
 HliZ/qsrVZAJs8bJmpKo3bLVzQ5T5tdHS2I2xPfgcw0F0vmctz6w/r+oFUZC2SR/ARzErqhm37Cpp
 LrDjWfYz9mK9/O11Z/J149JZrtRZ5rxATB24QvtHrYoYV5ruwUxQDW1WdvhakZcqWFqMa1Gz0FOdy
 esEVt9DmqMkgLvbw=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWy31-0001Nk-1S for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:07:24 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45ee6d32402so3193932f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781017635; x=1781622435; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wa8W6ZtjHI4JLbC3NNRkNMaPSOPbN+RK2+zMm+8OK7c=;
 b=EA7eU9tJ0LKG2lZUUaEHWtkuys1hNlpO02CX5RuCdGMnDlR7bJygnPq4KDbzz0Y/xw
 M6t9UgF7OBz7ZF5E00PCMDlM6vzBkcpEKpeHsPO9Y16bM/y1CzzW1hLQ6L0Ev63VTK2F
 VpdxqTSJzQkSxU/LN/wxd6+wR/3poG17XqabaRbI5Sp/Z26aztM1kRlzGQAn+aQlhf22
 NaF7JOn8sMDq5Hi0lqn8ol38aWsVR/kjc6ENe4fzFbSo4ppKzkbkB9FvMGyAjGojJL2g
 IDAkE9hFgh0bnco+VEA0ZdJA5j0A5E/P4nqkhziMd68W0DZQFxw6t4o/b1aDOz5Vyvgr
 nCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017635; x=1781622435;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wa8W6ZtjHI4JLbC3NNRkNMaPSOPbN+RK2+zMm+8OK7c=;
 b=DBcMVTFK8AUq1rMmGHjiXsGfjVm0PvznQAlW5/b9rqC4TUrwfpatSSH/vuI0pkoGtP
 bLeoqBPdhWbSiVjty/UGhRcZwke1FoitVRVZWRGWkjjDBxD5JU1M0ce8mPaIus1v9YmG
 vOEv3spSDgrHN0GxyM8l2a85cNDWZ2fsdfbsIVw7AoaQiEugYVPT76ZnyVNzJaMqQZHd
 lU9qwFOpjDHoQOw8SoOPhuGj5q5t0gRN8yzIVU5te0wITG2IQNMXSsq56DNRBf/wbYQ4
 3NEHRuVrWIma+3eVm4hbXLeeuHaOXRx3l+LBTWKCOmzIOgFT9xoawLzYReW6SXyQF6V0
 xOfg==
X-Gm-Message-State: AOJu0Yz+cQ95kCZT0COYBOcBgiRJyo76oW9+xvOYcWy71v7HZJVdFCx0
 T3uZO8kS2s7ZWBKEy546GUWfg6Els3+H6L3npVc76ka1Fo6nEq1PONvERkC3q794ABtbhA6rmeh
 7d2ZfRFW6mrgREjBGFk9p4a+3Su7Az7UBMPkjziXRgA8n3LXmbYL8KmivGwhS9XTkXD7QRi7zya
 JNkEKc1A==
X-Gm-Gg: Acq92OFlmLy97hdr7WDGn4kxuS6GdsB16zDPWf+3vPmeh8e/kcT1lfFgflBUg3YaqyZ
 flZQA7pzjU6olJMPs59ocGqWdCU4OyxUPuwrIjo3cjA+S9UYADVhlL9CVXDXb5N2rKHTn7+vWrV
 Vy/xzehgH0bdwXi0gW0MxrWhfx9F8i8Jsct/a2b5YchY9drD79zLdKIcJnD0vP+Zwsq0daQ2Sld
 LoUHNX42XswcnxE/9DmEUncFzSajfWy9dfr8+xKeWU7X79wDfdTuwYidz8Q53kRQHQgJLkJURxh
 N25yap2YAXdlPKOfMgaJ8Rz2SOCyLcReFX+diLsC5W+cCBakh9rIJZae4UYA1Y+PYwNzUG7qJNs
 QTnF0D/8SNlVzM6r7gdpsY/DtVssHb4u9ozuZ32xeY582GnefO4Ff5VtcyWXJILl/KmUq96QBUt
 zvXHkf0R8ynN8PtQesQrzE4LcjXvU9lf6faDpZjSDiRXPBx3KfIgwUXqL8ErB113tFtuXXpdCOM
 N2wd0KVzohI+3tUB+ap9rSo/jpmfEEbTNWmQ3dKjMd27z+FvpRtX9sJGUKl8hX1T5oZuOidRBx4
 gKJK6NkwWKyFrzG+i1T/GlLd
X-Received: by 2002:adf:e608:0:b0:44a:2cb3:b633 with SMTP id
 ffacd0b85a97d-460304fae53mr23762091f8f.12.1781017635073; 
 Tue, 09 Jun 2026 08:07:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcb13sm63559040f8f.2.2026.06.09.08.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:07:14 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 15:07:13 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I668b96afae9dda5692c46db14634b3b8c03056e5
X-Gerrit-Change-Number: 1709
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1709?usp=email>
X-Gerrit-Commit: 1bf7e92ed09e06e587a10c474ec760775a16947e
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 15:07:13 +0000
In-Reply-To: <gerrit.1781017122000.I668b96afae9dda5692c46db14634b3b8c03056e5@gerrit.openvpn.net>
References: <gerrit.1781017122000.I668b96afae9dda5692c46db14634b3b8c03056e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkk2NjhiOTZhZmFlOWRkYTU2OTJjNDZkYjE0NjM0YjNiOGMwMzA1NmU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18bf9be4970839d8a44342f94ba3c82783a1a8ec-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWy31-0001Nk-1S
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: renovate: Fix typo
 in regex manager
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
Content-Type: multipart/mixed; boundary="===============0621004686062453857=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0621004686062453857==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b8B6gqZMH4g="; charset=UTF-8

--b8B6gqZMH4g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1709?usp=3Demail )

Change subject: renovate: Fix typo in rege=
x manager
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1709?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I668b96afae9dda5692c46db14634b3b8c03056e5
Gerrit-Change-Number: 1709=

Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 09 Jun 2026 15:07:13 =
+0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--b8B6gqZMH4g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 1:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1709?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709?usp=3Demail">change 1709</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I668b96afae9dda=
5692c46db14634b3b8c03056e5 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1709 </div>
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
e: Tue, 09 Jun 2026 15:07:13 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--b8B6gqZMH4g=--


--===============0621004686062453857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0621004686062453857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0621004686062453857==--

