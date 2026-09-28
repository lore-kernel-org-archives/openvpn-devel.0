Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D899CA5FA1
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0S+1X4hdHjwlN18aZtr7T6nvuQ7Iec8C1e6mH0mBMc=; b=IdsDs99aAhs8RgoURLobAzGB1g
	Nm1qusE5n5aN7Dc2w0nQ1kdpR1/Q0QX7i6WN4cnMIb34qF2SF2g3itWPBjQ/72vq/R9DSsIYrcXKa
	v9krID1awVrERLDRt9nqaJ5czDsHSOowbQlK0w1AyzgmJq0iEFZ1uaPChJkLO+9U8I3A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBDbL-00036v-Tx;
	Mon, 28 Sep 2026 15:49:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBDbL-00036o-9z
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:49:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=e9lv3kNGoDrVCgBR2D/HfcxekrERgVVTNU0ISOt++cc=; b=ckgXEV2MpjxXyEqysaJgunzsE1
 Ou/HoGmp46Cg2WsDOsZKcfvh8AAK1/xZ/DOOLWyXwDHpZJbppQwAN82X+XtfH/QTmw7kYFCKDZcKI
 ubW1yXBTS8FF3e48oCYZY8u5UpyOMne23FEKu15d0Jdfn2aU9I8MirN7ekFyuiuCY9QI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e9lv3kNGoDrVCgBR2D/HfcxekrERgVVTNU0ISOt++cc=; b=P
 lIaUFQDXNubAQU6pSnCYHvhJaYnaAU77GEJnSUzBI50M1IdDoURDtcoYVIzFhTUmeksqKNEEiCNKO
 dazzrRJDtvvClIgq7HIrjT8OywZ6F9v47HDB8JGFGUhLxLOTjDrgL8N7f+EWxHjFu93+d2qq4Fkhs
 gMvmrUTA3dZLEFxE=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBDbK-0005ys-Mn for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:49:11 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffe281cb1so12432625e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790610544; x=1791215344; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e9lv3kNGoDrVCgBR2D/HfcxekrERgVVTNU0ISOt++cc=;
 b=hQA0zWfunZvltFWm5C4cpX21LvtNpJjJx/LNoyrRhcNSnwqHqbL1GqusRbAwp35h2o
 7k7jsd6+eUMmZm4FoFb2mnCCpXSYrXfPJ44XooFmxNP15e43vhOiqCj3NNT8KHSNrz6G
 XwXqMw1Sy1g59kWmtsIOeZraGL8zoiEhdtKw3RAW5+d94YbhejSRawFYs9Kh5wpPlMdm
 HlLYz5+5XDda8nBEwa4xQd4dmsuuRJTpHXTzORsiaogB+3tuyyVsSCk98Tt3RouMNnbE
 4L65jxc0m9F92uJmpCs3ZUHJjDETtvDvObCXsSLmWsIP16T8EQ+0NIQmztVji36MEUgj
 78Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610544; x=1791215344;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e9lv3kNGoDrVCgBR2D/HfcxekrERgVVTNU0ISOt++cc=;
 b=JqMLsai0MRqWuMmZAlVwVKVmmydKQ8MhRwRxTZfvlmk1Cp2JDqkF/Mtl254dJYbTHc
 lDq8ld0NIaZ2YMP75L9Pn9X/AVLvi6d2IwdE0C1pqZj0Uf15P3bG9Q7B/s8DFblX8u2n
 eoJd0xsGY4KCs8hGfpHjn+mafV40bbeiVPLeo2DfNTnSKVJAZscm+VrTLPHPwtvjtfn6
 HF4w5Lg6Yewq9hG7k/A2zcmRPSTqoK8k/tBxmZVjS/Txc8S9Hx52oG6ntJJcgP3ll6Kq
 B+cn7hHg0l62g0EipbPHxmriX0YwWApyfZ8cAiVZT6P9EURWwQspFT5TiMGKlFjP5osP
 WbiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxz2m80LUR4ubXqNAbxXrRHoOWSvXnaj8v/OpR1eg/Hrg9miCiM4uxURh5lXvAg98utJAA88S5ZXmnSLWMd@lists.sourceforge.net
X-Gm-Message-State: AFuF++lX6/PxZ4h0eQ9VPXcz/7rFs2bCJ8OqVJafGiSzEKwNsdM28Iq+
 VamVhUKa7jAhsDL/PnLtBzH9fR1uYqkPElo8yfZEJTJaSpKqI7BBwEpSCwNPz+88derlaJby9zd
 5v3aohQVd7YngO3sTW8V+n0vFnzv1P66fkmQ1CqaRCWA1aoxqS5mvG9PQHvh/EN0oqb1P
X-Gm-Gg: AYBFou2qBk/7+GyxsIgnif78hAxqOi0EUtNDjsUGDQTEjUensYKX4Sxa7SeUjHhdn8y
 8YS3SiCnvW3N5LS7crNskh48+nJOMDPgqlBV3hcQeDoOPELq7OAVfBhTPUSaFSJfb+s701+mcra
 jBC8NUvGg3v0QHg1SYAXbIdyqZpYgy/jaCn2v6P/J76zME/fCqEAkvLFgW60E7HW+JLG63fkuXf
 wh1TuWaQMQg7EgkLJtHMRJpdp8ziJktBPTdawWeLMxnxM8WT4kuEVIdVvUWWMeAyDLS4oExnsYx
 F8EyAZGOY1eMr3gO+TnMvCIjgpcwxMzh0t+gtHi1/RLIykiK4mLJIwGILYAJuAnfPxhFQ0qcAnJ
 g6yQMEC5YyNdL3IyjSRa65I9MT8eRhOUzYLw50NlchlCqft/8P9IGvbbMtfMSkQD7M5tNKSZu0j
 4A7nhwZQGAcwvnwG/J+MVl+zxDntjdIXxkKeyz+NRJEBHCvxCSBprvZMI2lxWQf7tgsgmei0R8d
 lBUfQeTlpaNM5u/vmB1sdlQ4N86LuEzJbaPEhWbQwT2ukzBPhp8KFi5pTzX+y1Xi8rD1ZB05Ut+
 wbjBCJCv5LwijPfH0stf/+2UKCRNYL9dnSzkop2FQmUqRxi+UXdPWjPhU1Yi
X-Received: by 2002:a05:600c:609a:b0:49c:dca2:ac47 with SMTP id
 5b1f17b1804b1-49ff06b2db4mr188318985e9.2.1790610543920; 
 Mon, 28 Sep 2026 08:49:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fef60cc72sm185580125e9.3.2026.09.28.08.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:49:03 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 15:49:01 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I39b3b31983a2d6348fd66266448f8d13e53a422c
X-Gerrit-Change-Number: 1959
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1959?usp=email>
X-Gerrit-Commit: 3b15daff6b7dee077609649785b7ad9187d9d851
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 15:49:01 +0000
In-Reply-To: <gerrit.1790610390000.I39b3b31983a2d6348fd66266448f8d13e53a422c@gerrit.openvpn.net>
References: <gerrit.1790610390000.I39b3b31983a2d6348fd66266448f8d13e53a422c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkkzOWIzYjMxOTgzYTJkNjM0OGZkNjYyNjY0NDhmOGQxM2U1M2E0MjJjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <837d9ef5f86f97fd2b8e4d6a869e4ed595773666-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBDbK-0005ys-Mn
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnmscia: Fix
 some ugly code formatting
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6856199788704702937=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6856199788704702937==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4ddOUmK3sTQ="; charset=UTF-8

--4ddOUmK3sTQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1959?usp=3Demail )

Change subject: openvpnmscia: Fix=
 some ugly code formatting
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I39b3b31983a2d6348fd66266448f8d13e53a422c
Gerrit-Chan=
ge-Number: 1959
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Comment-Date: Mon, 28 Sep 2026 15:49:01 +0000
Gerrit-HasComments: No
=
Gerrit-Has-Labels: Yes

--4ddOUmK3sTQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>razvanc has posted=
 comments on this change by flichtenheld=2E</p><p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3Demail">change 1959</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1959?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39b3b319=
83a2d6348fd66266448f8d13e53a422c </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1959 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Mon, 28 Sep 2026 15:49:01 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--4ddOUmK3sTQ=--


--===============6856199788704702937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6856199788704702937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6856199788704702937==--

