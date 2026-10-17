Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D041ACCF2C1
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 17:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=itk44t44aVtpyY4TTbJ+g2BVqHEDtfGA3tDAeGePVhg=; b=YpF3imPNRbleaM
	6QtGuXQGg16QFdoBRnasTRu+Y/ectL3iGShK8suJqm0WU7C385vBq2JcVPYGTYCsCp7FWFpEEUipp
	1cGpKm0kuZx3uk+Hp4kVk0nxl5weCSHhQUZVhJzDP0nSR4bwFgjva4xezVv39iKymVN+8Q0GDe59N
	Tl0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7nF-0003dW-OU;
	Sat, 17 Oct 2026 17:01:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI7nE-0003dQ-5V
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 17:01:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hZn7Wnf2t1imYawg+jcjhSzZEldrRmBf6+bT8w6JeJk=; b=hzgSXIGJMveFCA2WHYk6ynEuKS
 IIvp+bInQQdvrq8EfiVG6xtEUkgy1ceDgY0rZCNcj/vS1GfAymVmueJulaXsJGc7PG3ASUclnEJVT
 cJCdRv/CoDbqJutxRZXll8kq3FG22NZBVfdAUfhmUpvzAVjYWKxWu87jO0iA1w77ge4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hZn7Wnf2t1imYawg+jcjhSzZEldrRmBf6+bT8w6JeJk=; b=m
 PjVlF4oU9kTdHHEk9uDs2QLUG9TATt5qKtwi+nvmXswoqlv7103pSM2Jdt7+5mIoBt3FkwpNu8Boz
 8xh1ZGp9/3kr+9B0x6IBJaXOTH9zNxh5F7vPJeKLjIyc6092tFH0TH6HJV70jJMaNkVkKrlshohw6
 rIBOGFIfvD8xjJEk=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI7nA-0007KT-02 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 17:01:57 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso238442f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792256509; x=1792861309; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hZn7Wnf2t1imYawg+jcjhSzZEldrRmBf6+bT8w6JeJk=;
 b=a3twKSd2au9IOuN70HV9osGHNG7AHA2BCWSbzv5tNpSU4muDJMXHh5RmqaAxwEAcjn
 eZMUclQoOEV0Gci4tUOqBQBKXvMlA3jpv6rEO8nkXl0IaDLWPSQKnQ9rXNh55vJEqmRz
 sTkHKJstHeks6NMmQeYHa3FFohxjLEgPcbxlk7mgiOq1Qj25EW3DpdwcfpT+k10Q7BHs
 w12cHnUgqlzA3i3x4ApIJRmE8djSVkX8TdXF07ovLhELnq+WILoi5NrWP+Cbp8vsk5pP
 WMnls89g5Cu5cUbIw+QBa7aq7RRQERFhT3HHHLXaM47CBdv8py9uy7i0ISCMU15XK1Q2
 7p7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792256509; x=1792861309;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hZn7Wnf2t1imYawg+jcjhSzZEldrRmBf6+bT8w6JeJk=;
 b=zUM5JiinXxttlKdwk1VqsIUYexBcKwf9xJMNTwIl4QJAAWI2inSLOel3WyUFjAe/aQ
 flelUM3SsCKXu4oPPw67bnvt5mZY71nX54AIWhMe3D85r32LTurpSeSehdmLeUACyo/k
 yWJO/bpJui4swmbmqrzU7O+YEqRRj1JNRgeapydxxDjoLgC0d232ZanXBNABCQ8PIFKR
 7L8q+numv4bOtHxk02RECOsdaGfFdfvnnX6Q799oTNY5Fs7xwliAECRgA4wTALzkKT+W
 fqfDv8q/h+T8LHnNITVrMR57XtO07ks3qGAfL8DwXQQLITPyPBbb0FSYDlD6yWdSiroP
 5ECg==
X-Gm-Message-State: AFq9FYJa2BB3hnxmoRkz+HMv3kQqWjvFYf+ToY8XWZnn2occrvVJDstF
 bfHe6NNWUnDfN8cqMNTUHWExqVz7ae8lvsicG7mpBnrrjoJe8q2qUkMfhniQVkzvlqXDY3gfsp1
 4bZrNfXUGQC1R6sGxqwA4unRa0h50sLbRymbMMGNrFreofnClp2pZ5XsTTJIz6H5P/y0L9vi1bD
 igiJSeHg==
X-Gm-Gg: AYBFou35IGviCeywTBAU/TqpS0gB4PnFZxbviZLFD98hAR1GEtwdFV3+kWHwYXINqpb
 0v4a1NA6WXp51Vx6kd6OzqTlsWmUAXq26/S+ykAaDKgwJUSO7CCj27oLekjqA1laej7x8aESz1o
 NA28xl+0PhOatahkpwqHuTgTwybKLBbdyH3yftgMWE4AEmTkH7diLiOrRf6HRcjFbbOg4Q7nxDV
 iVs2Bq6TiCh7INwFQMjICCJ+dM0oYqgJ1jZy/AnWk6cYv5rUUtU+2HoZtrohcLjxClDf0bQaRSg
 QjdRaeHVg1txLrbVvSI0j8NjPuiiN8IT4xHJktqS/acryfNRCEnZXm6G5iQrNige91sfoaDn8D/
 lEfwfnGsTK3VXYzGuMfWehn8SGagMWVSze9KB7RGI2vZdw+ruA40o94y/xJR+nSmabpRMCIUCS2
 g0entH2r0uw1NvmIR5T2JOd0ccJ5c34WJa6xJ777UB8DJxtj6Db0As/f2CXWpjxWHxPxfCkcU5x
 z1kVH5Dzyaqqu6qlTPrdHERoy5uQ1+GiRBW+blBcBw5yaaZkpDfR+bBc+o6S10h0qj8dfHoRBpM
 PMh44GoeDaStGXDCX6ub4c5nEHpI9Jl2DSzbzdkw/5VE3+UXGO0eip33Jta1YbCHRqKl+0c=
X-Received: by 2002:adf:e292:0:b0:487:463:92d3 with SMTP id
 ffacd0b85a97d-48e07fb2db1mr4154828f8f.20.1792256509204; 
 Sat, 17 Oct 2026 10:01:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4f8cfesm10564394f8f.37.2026.10.17.10.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 10:01:48 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 17:01:48 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2f1d25198792c71e9b3a53c505d5c5648da606ed
X-Gerrit-Change-Number: 2008
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2008?usp=email>
X-Gerrit-Commit: 68650c6e11cea8f30a5294af18225a82f3d550f2
References: <gerrit.1792256506000.I2f1d25198792c71e9b3a53c505d5c5648da606ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU2NTA2MDAwLkkyZjFkMjUxOTg3OTJjNzFlOWIzYTUzYzUwNWQ1YzU2NDhkYTYwNmVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bc833e14845555e8edf5353a3732e407100df792-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI7nA-0007KT-02
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpn-msg.h:
 remove deprecated_msg_register_ring_buffers
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
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1367008471574518019=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1367008471574518019==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Rk1HWentd8A="; charset=UTF-8

--Rk1HWentd8A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2008?usp=3Demail

to review the following change=2E
=


Change subject: openvpn-msg=2Eh: remove deprecated_msg_register_ring_buff=
ers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpn=
-msg=2Eh: remove deprecated_msg_register_ring_buffers

The message type was=
 only kept as a placeholder after Wintun support
was removed in 2=2E7 to ke=
ep the numbering of the following message types
stable=2E Openvpn and the i=
nteractive service are always shipped and
updated together, so there is no =
need to keep the protocol numbering
compatible across versions=2E

Change-I=
d: I2f1d25198792c71e9b3a53c505d5c5648da606ed
Signed-off-by: Heiko Hund <hei=
ko@ist=2Eeigentlich=2Enet>
---
M include/openvpn-msg=2Eh
1 file changed, 0 =
insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/08/2008/1

diff --git a/include/openvpn-msg=2Eh b/i=
nclude/openvpn-msg=2Eh
index ca3267e8=2E=2E1be8008 100644
--- a/include/ope=
nvpn-msg=2Eh
+++ b/include/openvpn-msg=2Eh
@@ -44,7 +44,6 @@
     msg_del_w=
fp_block,
     msg_register_dns,
     msg_enable_dhcp,
-    deprecated_msg_=
register_ring_buffers,
     msg_set_mtu,
     msg_add_wins_cfg,
     msg_de=
l_wins_cfg,

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2008?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newc=
hange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2f1d=
25198792c71e9b3a53c505d5c5648da606ed
Gerrit-Change-Number: 2008
Gerrit-Patc=
hSet: 1
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>

--Rk1HWentd8A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2008?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpn-msg=2Eh: remove deprecated_msg_register_ring_buffers<br><=
br>The message type was only kept as a placeholder after Wintun support<br>=
was removed in 2=2E7 to keep the numbering of the following message types<b=
r>stable=2E Openvpn and the interactive service are always shipped and<br>u=
pdated together, so there is no need to keep the protocol numbering<br>comp=
atible across versions=2E<br><br>Change-Id: I2f1d25198792c71e9b3a53c505d5c5=
648da606ed<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt=
;<br>---<br>M include/openvpn-msg=2Eh<br>1 file changed, 0 insertions(+), 1=
 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/08/2008/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/include/openvp=
n-msg=2Eh b/include/openvpn-msg=2Eh</span><br><span>index ca3267e8=2E=2E1be=
8008 100644</span><br><span>--- a/include/openvpn-msg=2Eh</span><br><span>+=
++ b/include/openvpn-msg=2Eh</span><br><span>@@ -44,7 +44,6 @@</span><br><s=
pan>     msg_del_wfp_block,</span><br><span>     msg_register_dns,</span><b=
r><span>     msg_enable_dhcp,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    deprecated_msg_register_ring_buffers,</span><br><span>     msg_=
set_mtu,</span><br><span>     msg_add_wins_cfg,</span><br><span>     msg_de=
l_wins_cfg,</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2008?usp=3Demail">change 2008</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2008?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2f1d25198792c71e9b3=
a53c505d5c5648da606ed </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2008 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>

</body></html>
--Rk1HWentd8A=--


--===============1367008471574518019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1367008471574518019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1367008471574518019==--

