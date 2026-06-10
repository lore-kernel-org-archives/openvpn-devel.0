Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54D0CD98C6
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cX9Eyc0U0iK8BGnn1QL9piUc7ZcDhufSpmWvawjb+bc=; b=mosRWx5vBswPHHhARFxIefv3eT
	xXcZCnx65f9yXchLrU0v+vFEN+Ma1paXgm6DoqEdTsjiV53yG3i7o+lI2HD/6qrbFQUvBiqazTsBb
	YlXQyOS9tXyo37qA9ma/IpVLEYaaib+VqaqRW0n9dYVrTJfCixNt6eQmS/CPkRh6iuyk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXMSU-0004S4-Mu;
	Wed, 10 Jun 2026 17:11:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXMSS-0004Ry-EZ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:11:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9YkUSnM8k1GCOQHfyz2z1wYxld8lQXuxpP3sTSg6NUg=; b=g3u8A7X9r/GMozf/75eRLZ3WvB
 CAJbgJvrhYoBtXuP9S5cXZXbHUgmy3UEKjueKkTzQ2pLbkgtxWL1VqmYCmeo61g60oU79e/yzaRu/
 +niCytk8/Nq8/0NKfK7iEgpqB0WHNpZCwiKQINgFbuwgOscuFI1qlLuOu+F4RNkJ5KGA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9YkUSnM8k1GCOQHfyz2z1wYxld8lQXuxpP3sTSg6NUg=; b=L
 3ZFiSpkf9u6diwasSRoyHxaqi5clX/PLt25g2ttPRIyF7wvGqs+OkSv/S0eXFE/Zo5b/UjDFieqOq
 kHI8CGJF7YGS4jBSdSH6tV10HRsgw/hpUEbNINPqpI6G5Qj0W0o9RF1Jsg8m93WvR2a2N2z/K923o
 F2USYiWB7Lj5CiVk=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXMSO-00078Q-5t for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:11:15 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso54802575e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781111460; x=1781716260; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9YkUSnM8k1GCOQHfyz2z1wYxld8lQXuxpP3sTSg6NUg=;
 b=c56c3xVFRifjo4jdc2L3lJoBtj7ZulXmcFJD+GeV7k7VGI81ozW/mJ6LKabc0oKM7/
 onsHSsST8FDLdp15OWL1IjixoKMgRJ6PZmurqHhx9AMwmJsagCKKZJHWlY3Ft6inodag
 CckjKNfmgWCrAQVONksNjXJx3s9SebCYgTfSl5XIq8I+qqanPV+neGYZh/JMLusTNktb
 NYr3IVe/qHY+5ZWh0T4lm6xw4lequTNj+4GmQIvV2SeOD5+p+04mAozwK5TDo+pFfRTu
 Fbw24KkzxtRtONoE5lfE9hybwbsXqWKpjLZEXiQoyWHBqpP2d8Nfcksnr9I0XcwWqi0a
 fvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111460; x=1781716260;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9YkUSnM8k1GCOQHfyz2z1wYxld8lQXuxpP3sTSg6NUg=;
 b=lQunI4yTyl99INDREU2ScSzDBw1I4huNs2xObT8xNHJgb2H7oPAyOtMxzl+oq3XMey
 yRezsMhLD++aNV13Nj1LWOLanFsi9cWlIjQod6hKr5c+G2hM6CtS85Y9MsYm8ormdo5i
 GanTAvsZLqRxKVS0LtHrtNJ4U74QwCSKlVCf9zwaaqPbdQTOvqqkxC4hYg8xPu/Fdbyc
 QsUoG9lUTWLt/zWjSM910UToT+ZSXUFzNKq/nuUYjLuO124YL/BaAtL4ZQRrEFlmCnJm
 fzffXB87jOuGVFbTVTTJa52zKOD8kGaF5kCn7GRvVBg294IKCT30a7gdK8GtWp5vQErk
 C1kg==
X-Gm-Message-State: AOJu0YztXCcUnUBtMAo+hTOhI5buv+tuutKSZUBfmwqmE8q70ivQL8FG
 MsBd9b0RkPf2cyxuMzR6SJNYiJJIUJcawpF5M+8h+s5Y/TVA921ncE939v0qeLoNAS/W/urfT3H
 qIqRxrP69tkYpQznxMyJ1Zdeq+exMiT08eMH3v+WuMklaRPMM1cxRBBx+lqfQfpidJeXy7cRJbN
 t0Jjm1ZA==
X-Gm-Gg: Acq92OE6GZltPJW+LxLT5oohgYx9Py3CBT1Rd+xxM7weoqf59MWYdM9CsPLrNW2Tjlb
 nxSchw9IHTcfgwrHDYZnlIkauwFluVaG7Ej4fhaa1F/C561sB5CLDWzhh3n3Ibb2PCKF3IMWZMM
 I5bh94VvyRiepspQF5ev3rohOdP+fqrBySoR3VGTnxY+bUXMvWS/xYcg1Id2Zybte1cqbveYTXR
 HY21SaYpoz7XwSGV7SCbgctveuxqGqyMIouuGURgwwFAF+1lWJ6CuQZWe3D+UzUnqvOUv+e+XTL
 0tnpU+LwxW9HGd62QWl2yBQhB2G3IQylmYsoPcJiOEekPmBiAkIqET5K0e5+NeFy5PNwVStYHOG
 657NMcOlq4EeHLlgg2jc2A8QXY5mQ4WNG2ku5VTPoVmHGIZZt9LxWanRRwDHvjXFROZnbkAa5UD
 cYaMYqat4SprHPqwKdct0KRjIL39NMAjJ6TjJ1jr7BA3o/xzVRUxh/W8mGq+9UCStdWoqV84Se8
 BHfeGQ3SMjmbwhRUbp9Jwo0HK+EpQkUAZpoNKBa0s3gSJnyyENnGUhp117jqS6O0QSjWZD/clDa
 g6KgdTuMWgm+wHuZsHiA4oLk
X-Received: by 2002:a05:600c:8183:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-490c25c6625mr366721615e9.25.1781111460195; 
 Wed, 10 Jun 2026 10:11:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2acf896sm2179225e9.6.2026.06.10.10.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:10:59 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 17:10:58 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I668b96afae9dda5692c46db14634b3b8c03056e5
X-Gerrit-Change-Number: 1709
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1709?usp=email>
X-Gerrit-Commit: e02ca9a487ba04c5f2da28421795e74b9b5b71e0
In-Reply-To: <gerrit.1781017122000.I668b96afae9dda5692c46db14634b3b8c03056e5@gerrit.openvpn.net>
References: <gerrit.1781017122000.I668b96afae9dda5692c46db14634b3b8c03056e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkk2NjhiOTZhZmFlOWRkYTU2OTJjNDZkYjE0NjM0YjNiOGMwMzA1NmU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7f1d66a6cce24e9c48a5ea3ffb7a2ab836441e28-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXMSO-00078Q-5t
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5538619919678317029=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5538619919678317029==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R6SBITK4daM="; charset=UTF-8

--R6SBITK4daM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: renovate: Fix typo in regex manager
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

renovate: Fix typo =
in regex manager

Broken since commit 8485518dce6b7ebeda6295fcdf3bc7476b7b9=
117
("GHA: Factor out building SSL libs to a reusable workflow")

Change-Id=
: I668b96afae9dda5692c46db14634b3b8c03056e5
Signed-off-by: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709
Message-Id=
: <20260609152045=2E27384-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37137=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M renovate=2Ejson
1 =
file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/09/1709/2

diff --git a/renovate=2Ejs=
on b/renovate=2Ejson
index 3bd0917=2E=2E5b6e0d0 100644
--- a/renovate=2Ejso=
n
+++ b/renovate=2Ejson
@@ -40,7 +40,7 @@
                 "/^\\=2Egithub/w=
orkflows/=2E+\\=2Eya?ml$/"
             ],
             "matchStrings": [
-=
                "versioning=3D(?<versioning>=2E*?)\\n\\s*ghrepo:\\s*(?<depN=
ame>=2E*?)\\n\\s*gitrepo:\\s*(?<currentValue>=2E*?)\\n"
+                "v=
ersioning=3D(?<versioning>=2E*?)\\n\\s*ghrepo:\\s*(?<depName>=2E*?)\\n\\s*g=
itref:\\s*(?<currentValue>=2E*?)\\n"
             ],
             "datasour=
ceTemplate": "github-tags"
         }

-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1709?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I668b96afae9dda5692c46db14634b3b8c03056e5
Gerrit-Chang=
e-Number: 1709
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--R6SBITK4daM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">renovate: Fix typo in =
regex manager<br><br>Broken since commit 8485518dce6b7ebeda6295fcdf3bc7476b=
7b9117<br>(&quot;GHA: Factor out building SSL libs to a reusable workflow&q=
uot;)<br><br>Change-Id: I668b96afae9dda5692c46db14634b3b8c03056e5<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1709<br>Message-Id: &lt;20260609152045=2E27384=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg37137=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M renovate=2Ejson<br>1 f=
ile changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/09/1709/2</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/renovate=2Ejson b/renovate=2Ejson</span><br><span>index 3bd=
0917=2E=2E5b6e0d0 100644</span><br><span>--- a/renovate=2Ejson</span><br><s=
pan>+++ b/renovate=2Ejson</span><br><span>@@ -40,7 +40,7 @@</span><br><span=
>                 &quot;/^\\=2Egithub/workflows/=2E+\\=2Eya?ml$/&quot;</spa=
n><br><span>             ],</span><br><span>             &quot;matchStrings=
&quot;: [</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    &quot;versioning=3D(?&lt;versioning&gt;=2E*?)\\n\\s*ghrepo:\\s*(?&lt;de=
pName&gt;=2E*?)\\n\\s*gitrepo:\\s*(?&lt;currentValue&gt;=2E*?)\\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;v=
ersioning=3D(?&lt;versioning&gt;=2E*?)\\n\\s*ghrepo:\\s*(?&lt;depName&gt;=
=2E*?)\\n\\s*gitref:\\s*(?&lt;currentValue&gt;=2E*?)\\n&quot;</span><br><sp=
an>             ],</span><br><span>             &quot;datasourceTemplate&qu=
ot;: &quot;github-tags&quot;</span><br><span>         }</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1709?usp=3Demail">change 1709</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1709?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I668b96afae9dda5692c46db14634b3b8c0=
3056e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1709 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--R6SBITK4daM=--


--===============5538619919678317029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5538619919678317029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5538619919678317029==--

