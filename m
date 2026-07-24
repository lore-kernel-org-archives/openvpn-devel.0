Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10949C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cdatPhsixrhOo2gqs0L21E3Yun92jN0hqDPu5DwKdE=; b=SPIbD1EipIu/HvyjzGp9hXqA05
	cR6fRqxlcDqe6/7UTMqMlsW/e9NBDlUFe2vjXapUn3p6eg+q9Ll6lDg2cy1/IsuNAXOMnVFmFRhqh
	pP6HGU75ohFK6FG3c3OEW6wQ4TXNxV7rkdlvKsY2v+Gk7W66b9/uvdzAs1tg/+qkzv/0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnK8c-0005wM-96;
	Fri, 24 Jul 2026 17:56:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnK8a-0005wF-DC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 17:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=z3l9tI/glzd4IpAXjKPYaezmAcZ6DnrVx3FGfjezNk0=; b=HqZHJmoDs+PU7QMhV/+m4YYmp9
 S9PqDMVW7r2BrzXZyJtVaQwXVkfXKh+CSvkLX/z5fHjSNYJ/LEOzZC2zW/d+jY951hIYIghjBEtc4
 GKdm5cH/OH5TjVhl1tjHeTLleOFeARGB75irGS8TvPxoKSMjQ/WwWpxrHoWO81x/laS8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z3l9tI/glzd4IpAXjKPYaezmAcZ6DnrVx3FGfjezNk0=; b=m
 LEcUSuo5NQ4BnNtO6KKiJ5Tvy74aFVbPCn3R222fs1wjHseeuiArhuXkDzAY+PKu7GsBgipMxuAaL
 wWBQ2AGN8QPcXCeVA3nwC1sf8X0ks7XPSIBp9r7sAVXiuv5leSB+VdyNO5l54HU8kXkrL0KeT9kXv
 XGuTQ8mP1RfmO2Ew=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnK8X-0005J2-4g for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 17:56:41 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49557167508so7147195e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 10:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784915794; x=1785520594; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z3l9tI/glzd4IpAXjKPYaezmAcZ6DnrVx3FGfjezNk0=;
 b=CQx7k+xoaBfWU0wKSK431rgR4evyktIHWWJWccSylCfMzGLJ5HxP9ICmLU0rANctqp
 eR/RiLAl9MSNlcggm+iwhQPrzCb9ON9PCjSGd0Aq/YDLDkods6WVDvHONWqBSErvz/eT
 t/3Gx0jYD6Mk2yIBCJ0q0KpOyBFsd9capAf2wLgYJBq8M8VAb9Zlpk1FuGuNmgLfcg0o
 S8w5B1gcJfgoPAhOxbSPAZUedngNshoIGKFImIjpXBs+j5Ge281ejkz0oAGNQZHHFqJM
 dyca5CgzBF/RVdBmAFo5flgqz+sb9Sx5J8NnoJSakutcyMetA7NiTf/F3el1JbbSFXdB
 LJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784915794; x=1785520594;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z3l9tI/glzd4IpAXjKPYaezmAcZ6DnrVx3FGfjezNk0=;
 b=OEf17qEf2UP1r1DbyHFykGWBVfb3PpwOBYt0wap7frrQilkt48Sx3Vip7pSX5q3XSs
 rLyFW01M+jDgmIQukXsxnnUGLz+oPfTaruUwowRTEqX+R+pVDuORRj75bjZvK73bp+ud
 QkjqL1JSH5Twj7SZsEqY2YO3h7aANtV2UYMmCMsqY8PFT6GR74q9TgfTmVSgaRRhksPM
 2GbFauoV9n5A/lCL8y7KCpqTyMWN1BIIDlUDPNvwtFfTWk7SRfVJtusr7yHLouskYJiq
 j/86KTSysy85EkxhG7Z6IJzwV6I69XrMHkX+o5jyxX1t3nylCYiwZQzPzXrwLwAxIuX0
 GjBg==
X-Gm-Message-State: AOJu0Yz3qJ2ASVhHNJTd1/s5HWZVnNZIIOtP0xZQ0nonKFTb/C7Qj0ZU
 4KhzkY4J9rXVYugLSWLA/ikOKW/3ImlzfoDfa8tlfOFmcowfk1Pvwzn4Zl+RWGhbG+8BElFQcoi
 /thJo0gvNIcXA+9T3Swjsni1u1JOFrr9IOFFtdZ7ul7P+UIQfY1wwnJzCFEK+sCwpGViZI1Vph3
 7iy3s/Vw==
X-Gm-Gg: AR+sD115kEyxhrVkxZJpTicUlnET773q7HCeJk2omQ1IXD70HMywKt7cPAKgqsU+RkU
 ehq/L1MqSrcJZZAgwUr9ZDakTMcWBiT6BXiFegk6ocYp1nYTj/cZZTHNymwMlZ4FtuqecwFqqD7
 RVF9fzSk1pEvJ9CMzEn4wEYV0oMVflNx5mvSjAn49tINF4olOW49eEFjRzr/DkpHDx+wR4EK22r
 09Go2hv0DzXfnpaQ3vaTNPto6TKOCcB7kpwLLgva6TeJYjsNO9hvUaSexf7jrsqu7mOmL1wkVLw
 NLQ1TNz92Z4nqx/9Nz6WX7n4GHIwkBZyE3TyTRKr9eOpji+VauBY+bxt4hWAoPrJb5qePoWEb61
 b6JdnAI7xQSZkjM0oRNom8BrHNr0Ft4fuqGRN0HMdbS/VGaIjWszF39JpVqp47EgNZvGUmlVkA0
 Fa5w5RMoqDQS8aPRdOhTzigmM9ynOwi6WUJWLNqmoNFrNXnz1UKlhqLj9V56IxoW6gwoA2HpCrg
 P7CLQuSXx8wTAd0lVKi68YSCYFoQCGzupUYFqlscL8Q1IR7hSNRLMA8QHRvoThAtfr5
X-Received: by 2002:a05:600c:4fcd:b0:492:4a50:41fe with SMTP id
 5b1f17b1804b1-49573cfc9b6mr130267795e9.22.1784915794398; 
 Fri, 24 Jul 2026 10:56:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b480fafasm10301435e9.0.2026.07.24.10.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 10:56:34 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 17:56:32 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I33e55d88d561393ebfbc73a995f700056e19a436
X-Gerrit-Change-Number: 1628
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1628?usp=email>
X-Gerrit-Commit: a55090551b9dca2e6a88e81893204ec66df9f1ba
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 17:56:32 +0000
In-Reply-To: <gerrit.1776267299000.I33e55d88d561393ebfbc73a995f700056e19a436@gerrit.openvpn.net>
References: <gerrit.1776267299000.I33e55d88d561393ebfbc73a995f700056e19a436@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2MjY3Mjk5MDAwLkkzM2U1NWQ4OGQ1NjEzOTNlYmZiYzczYTk5NWY3MDAwNTZlMTlhNDM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <93853369579f56ff60aeea5ac10eab96f0b4a1a2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnK8X-0005J2-4g
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: sitnl: use
 RTM_SETLINK for updating existing interfaces
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
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1730382149016069752=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1730382149016069752==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zA5Adjx1X9M="; charset=UTF-8

--zA5Adjx1X9M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan=2E

plaisthos has posted co=
mments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1628?usp=3Demail )

Change subject: sitnl: use RTM_SETLINK for updat=
ing existing interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1628?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I33e55d88d561393ebfbc73a995f700056e19a436
Gerrit-Chang=
e-Number: 1628
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@mandel=
bit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 24 Jul 20=
26 17:56:32 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--zA5Adjx1X9M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1628?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1628?usp=3Demail">change 1628</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1628?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33e55d88d561393eb=
fbc73a995f700056e19a436 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1628 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fr=
i, 24 Jul 2026 17:56:32 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </=
div>

</body></html>
--zA5Adjx1X9M=--


--===============1730382149016069752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1730382149016069752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1730382149016069752==--

