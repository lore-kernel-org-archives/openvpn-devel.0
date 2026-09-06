Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D53C79F8C
	for <openvpn-devel@archiver.kernel.org>; Sun,  6 Sep 2026 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A3pvK32p0wCg4pI3M9QBDUTGiHjzM0pToOOGDMykbak=; b=LwvGRpAk/ikJMPmTsQLuYvQ5Y+
	P1kz/1xzhbQOOaoLCAsctrnTsLmYBXG7J6MX/kin/y8UDxp12qWQE1oB4KgX84/vn84KXl0HIZZ5D
	nm/maMoztpmERNKAyfOdhmS39dZmuhheeqDhHNPQpQajF5NIK+rQEGcxmnrZV7mEd0CY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3HXh-0008EH-R9;
	Sun, 06 Sep 2026 18:24:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3HXg-0008E8-3p
 for openvpn-devel@lists.sourceforge.net;
 Sun, 06 Sep 2026 18:24:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KTdRTZd7JPz/41XoKr1bG/hSlZZ/kcxFSNIVc7JekuY=; b=jeByvG/jlqnNsGW2ZSWitBSSvv
 HIDW4dDdHCyj51y4dY1SyUzMz4A9lIVt1+eQD0WMiOAbnGkvhnFeRAlOhXiBaO/RbBgz67NSz6oVo
 ZEVbTATlW/Nhp4OmucW8i+khn5+z1ereTCW4J81BmxUB7FUYsG57faLxjYZstdUkiNcU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KTdRTZd7JPz/41XoKr1bG/hSlZZ/kcxFSNIVc7JekuY=; b=V
 Gg5lLci38lFMUPNkU3cZKwMiYYl1y1BJIacyigRkNoddvM9HTGyaf2ABIKykhqQVXSFgmISYoimQg
 0C7RxwNUOip3nO+tv+9KBv6+1tAALztNQR81YITu2vD3b2V3q1ikEljyXh0m45IPuQlXyo3CMmJt8
 Nmhd/mJi0UHwobSU=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3HXb-0006Q9-Vm for openvpn-devel@lists.sourceforge.net;
 Sun, 06 Sep 2026 18:24:33 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4859245e493so937534f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 06 Sep 2026 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788719065; x=1789323865; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KTdRTZd7JPz/41XoKr1bG/hSlZZ/kcxFSNIVc7JekuY=;
 b=FtUQoQ2mMkmZ+RBrCCcUOUxX47T0shd+MCFOhrC0B1Tw8/j8WhJrT8wk2HVU848Bsn
 bxik3XiqX4VQs42PlbCCxVVfTpibYwANKNDyYnPerM5+YDXIioqMxsRolhemBE6JtSBt
 1exPJclOmahh1gNZr2tm/fXhbAwTZGwfVLnf4SH96BmiwaBgSgznHmxWjV8xNHYM9vGF
 c7OI0pejV8KHn7d5o5GiZnC4Y9n3TQ90I4yvXJfLDhWqpsVhmH48JmkqaZyFHDmzeEXr
 R9N7NHPzJvJjaA+0JE2VNaCz5DMIdW3817ydaAANHbUWJ6i0/z1TkCNLSRIq4QFIRLr5
 n16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788719065; x=1789323865;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KTdRTZd7JPz/41XoKr1bG/hSlZZ/kcxFSNIVc7JekuY=;
 b=ixbBRhv2/chm4J040gpWzmNAuCPbISsRHMM0kLV/2WvzCDidG/8g3LVkWZ3aZbRVKL
 EmTuGqEHR2U0U3/VT+cSiQeCQhECfHcuGRITMxeiwNh2SXR+WhijncRuJjg18mOWSls6
 KqnqZs0ZA/FAUz3VauS1QUW9uwZH7rgO6bgB6gfig96z2JE1LiQA2hO7TKhvlszQHf3V
 MZ0pU5bFEKcMoaKWlQK+ts/dcQn4iRxTFSCMxBIx0i0BQ27VYttIPDkLlyKQgmZb9slb
 8TGLpjA3A5tnn7tjAH4NHVI9YidmgH2K4fot3Q3UqoEsDrLmfaUlQKwAlRRvYDTdM5wE
 AL0w==
X-Forwarded-Encrypted: i=1;
 AKwUvByup7INI8y8O+f+oUeFYwDs2QoJhg2EWOeQ+jW2eQ6bqG1kq8/sRHbwOWe0qraFxaHY7zkz02PFXI2C3QUJ@lists.sourceforge.net
X-Gm-Message-State: AFuF++k6eFRS3UqnmIMQBxP2PDUV/L6YzbJuQolIutdGKzP0EN8c0ZI9
 KYZCEPjABsNGliBTUwdK7UoEY/j71IdYZCT/NLfyS++VyBxhhNMgCdKTgD/vj3smZk/LMSfIHEc
 cAJV3uxVE12HvM5rAAuzuhF6euM9tb8hzjGrfafsS4whGojw+qPksIaZDZ18Ci5jUZpuE
X-Gm-Gg: AYBFou2ONVoyqUDytZrlVd+I7Cuo9KmnfLIPdH3IpwJ20IwUNnqz4mLUrI6rcJCYidr
 Is7/Ys0K3HpEfreucxuxThbXOLswRS0gnXJIFIU4h7lCM8oUf+RKe6Vf/LSAvZWNt5y18fK3IHj
 fuDcyki2zsWJ3d5gE7HQmlrK8wL86TWl9ckCp+TwnPe2WOgIKsvkvPjfwkBJe+qUyxk3HKFQoJZ
 ZXoFNZKvSLWjhnx4fz23rnw4NlaWDtVrANzeCEGBdhtueoHM6xU7+BAWjLVfS831RVhar2Ekcr9
 ayrUOUyrua14FBrOM8xy9T9SsNupF/B5T/CSMOFLrsYczTQNrzByoYB+LCNxnp/DGw5jDonQET+
 XOa4uMhxce0uhEx3Toqd8f7eiBJbL+MBsQSec4hSUGVL2H5A6YRETu2hbu4dE07L4PN2YStap2+
 UkiUGd6NtHMug/lPJoWQETMq2sOhGr0W0yfpsmeT7Z1onNoSsbDVGR7GC1PGILzWZ1Sgwhn59CF
 6ZKBJunMQDle6u7+dWKDpFR+PnCDqEJ05VOdn5DikRCmxNhllnPLDzONk5PnLfQHapP3k8Ow8Cr
 7HBud6ixVEVKNED8ulSx+JzPq3K2uHGwgB+/LvXx69DGyTlunGvDxXlDBfqIhw==
X-Received: by 2002:a05:600c:3b01:b0:49c:fa21:e73b with SMTP id
 5b1f17b1804b1-49cfa21e86cmr150889625e9.17.1788719064933; 
 Sun, 06 Sep 2026 11:24:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d0656e7bbsm147591735e9.10.2026.09.06.11.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 11:24:24 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 6 Sep 2026 18:24:23 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
X-Gerrit-Change-Number: 1898
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1898?usp=email>
X-Gerrit-Commit: eda13e5920b005cb50abb11bf776bb8e7cc32fe7
X-Gerrit-Comment-Date: Sun, 6 Sep 2026 18:24:23 +0000
In-Reply-To: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
References: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NTE5NjgzMDAwLkljMzM0NTE4MDQ4ZDZjYTU3YTUwNDI1N2UyMTA0NjdmOWM0NTFkMjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bacdf7314dfbfa8384534ab3c65d3435e4aac2cd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3HXb-0006Q9-Vm
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Check for null-bytes
 in certificate subjects
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4595756570537503555=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4595756570537503555==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SWBwIYapEZY="; charset=UTF-8

--SWBwIYapEZY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

cron2 has posted =
comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1898?usp=3Demail )

Change subject: Check for null-bytes in certificate=
 subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1:

(1 comment)

Patchset:

PS1: 
> I don't understand how this h=
appens=2E [=E2=80=A6]
wrong `assert()` used=2E=2E=2E this looks like the st=
andard libc assert() which gets compiled to a noop -> "variable not used"

=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic334518048d6ca57a5=
04257e210467f9c451d268
Gerrit-Change-Number: 1898
Gerrit-PatchSet: 1
Gerrit=
-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: syzzer <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comme=
nt-Date: Sun, 06 Sep 2026 18:24:23 +0000
Gerrit-HasComments: Yes
Gerrit-Has=
-Labels: No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>
Comment-In=
-Reply-To: MaxF <max@max-fillinger=2Enet>

--SWBwIYapEZY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I don&#39;t understand =
how this happens=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">wrong `assert()` used=2E=
=2E=2E this looks like the standard libc assert() which gets compiled to a =
noop -&gt; &quot;variable not used&quot;</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demai=
l">change 1898</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
98?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: Ic334518048d6ca57a504257e210467f9c451d268 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1898 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &=
lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@karger=
=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;=
openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 06=
 Sep 2026 18:24:23 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@greenie=2E=
muc=2Ede&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF =
&lt;max@max-fillinger=2Enet&gt; </div>

</body></html>
--SWBwIYapEZY=--


--===============4595756570537503555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4595756570537503555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4595756570537503555==--

