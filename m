Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F00CD4F24
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lLh7VBOe7y6fArWZjifcMHo9YSW1uKCF524e+MJbDxg=; b=Wq9SfOR5UK5qBP62+b1HvteLAU
	KraOCrPoKayhaZezCC0bCxM/a3koE2gnlMiI9ql+Rzvy2vTO/cSexvsL/QL62L6349EWpNxkTH3Dk
	hOWCI+wkYJJOCGzowqjSxAH/wTZIDrwETcYG2iqmI9YZlsBg0cVQahZ50vmyx1icHNvg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMnVy-0002Ob-OX;
	Tue, 12 May 2026 13:51:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wMnVw-0002OQ-La
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 13:51:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=i08sooq9U5RYNAM+b8AtC9kv8E9HdcLBzVs2rrvgy+o=; b=EV049PLVNWBQCAQ3GZwkz4nj7J
 QkkqXZXio3OHnw/fiDHrfU3N+fYbKUnII4g/YtfRK5lyFj6MxI4WKwcG9qDho063d/F8I9fFQEhR9
 EEPcoItCUmkmzh4ZGV8yNopifjEJnKVzK8cDZ2zgUROZwkxP5UTg25nDm3C5Fn/EaGck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=i08sooq9U5RYNAM+b8AtC9kv8E9HdcLBzVs2rrvgy+o=; b=T
 SNG1CHNhJG2rTiM4rL/CV7eLmfx9q0b7BVysTERYnf40VwnaZcePyrHbihRxAzv4+VkXjCfhCcIJ3
 lFCj496X5a6f+h35fDVJ9+m/MsdGIaMTicqYGifd4jldioxlfz1a/1WGP98pCQqW+bEta+biPeacl
 TS8GgGPD48D9sBu4=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wMnVu-0003Eu-I3 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 13:51:12 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-452169ae568so4205302f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 12 May 2026 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778593859; x=1779198659; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i08sooq9U5RYNAM+b8AtC9kv8E9HdcLBzVs2rrvgy+o=;
 b=eqAwYE0T77fJv1ti/ml3BUWjCQs9bQcJhY65s2DTgngWvX2cal8sHr2EnXAc9VV9xg
 CO9oUu/rsMUpZICGRjvx5o/PZ0UXh+rYXEfFq7TI82CcmiaD0GECUKD2lQZtLr6T2u2b
 MgrZhevUfN5PyItaEnebwE3D6vUlwgZSyfqtdF7rxt+MK2qQbTPEQNmnXrxW8bK2lfNQ
 K1Di6g+RkAn23wFQqitLraytbgeOEXcXEk9S+zy2dv0w34Y4m5rlJLyhXNUulLeWz8HC
 1bfXrjoCACW6oPmB10XTxoKaU84ZZ5hHAhcSEwLcxj+z7X6wCGNCRGdT1canEiyTN+tY
 wSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778593859; x=1779198659;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i08sooq9U5RYNAM+b8AtC9kv8E9HdcLBzVs2rrvgy+o=;
 b=by5VYLBVEJWsC0vk3V0MOtiXWdGDewEzn65llgYyps24dFhDDcPv9wW4ygTc7OtnBg
 d4/6SpmxzMXbSg9PleGpEsQp/Qyc1uqTTdYPZw925Ep53pRee1U/rxGfwnYxXVh4LH2U
 o1SGOfJQpf6IW4nNLP3+Nia4Ft6Uj++e3VNarjCuuQ8xFy7wk83xR1IevgJPCXwtDLy3
 O+N2ipxGhcY/XXRR44Fq/sYfC59zuuT9d93vK+MoWy4UkJA6K45IpbaEbG9kbxSETMZ6
 WN5MbK1k/1LjvFM9cEnGHcpiw5oLu+Tt00RDzodtRjGloDSTiIr/1myZ2mh/j3V33fBH
 /LMg==
X-Gm-Message-State: AOJu0YyJ9PlSV4aAgQV/V9fteG4Q2+uorl58i+xzWlJL+SRumeGQEG4H
 TQR0UGnm6Js0wRMYt0kUaSmIPkdjvdzd0sGWGV+Nzw6PHCxS3/+qD87tgo/S6NjS5maejd+uXFE
 EXNgRQdENuKKHv6hpzBwGDyHqFSscIbOzSCFCjeZoqJsvjPVxcZ050Hrrdd9LHcf8EKpI
X-Gm-Gg: Acq92OHq4v2YWrmdO0GF5/DozOGr0CI5zjPnUIscLWFIxbRX2C+AihucZCY28e2cOXn
 xFxCXqw1Urzpyj/njecZ3tOjkhm4L31eOUgFprVIA08jD6yOcAYm83uo0nYF2irMY1l2sOiYYeO
 QQbK4tFP3totQxYdBhRh4lulElNzyRXEP3SAwE05DzoOY215JePz72UWqol/+kT3Ej8RDP7kUwk
 qyBjl3nITvIp/sxtFKCIV9RrbhA0DRb0/Hmx9w8QsCn3mBzhT+eEvgWObwOcZL7vEF4Hj9qcIko
 6Mydq6WDv+QCMBGrBs71ZDI3WQ0q4MGcfL4WcNLHa0CLutc77Dk0n9DM5K3/xETqLxNvdsd5YXV
 AIt+BXBRpf+ICQnzLjPdD/70OxL+CM+sNOCUhfVNzrfr4kb7mdGu3RKwfS9XTReAdbfZArabGQh
 7MKrTPqBEZzTpFmQaEWVsY3DIahAcwYZ82kZFKAz2tJIkShTTOXZsNlds9AquTSwFaUfgZ+0aPd
 TkYeM3EzNg3lMrvvnyRBjHx3uhpjts+AnPRDpvEn1wIJDbsffT0tYI0BkF7KOGGhtBtVLYDmLWg
 2z/dEi6MzF50G5zleD15eBeo
X-Received: by 2002:a05:6000:188e:b0:45a:dd99:96c8 with SMTP id
 ffacd0b85a97d-45add9996f7mr5515541f8f.41.1778593859350; 
 Tue, 12 May 2026 06:50:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45492271510sm39333235f8f.37.2026.05.12.06.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 06:50:58 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 12 May 2026 13:50:56 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5c9b54dca0a14688a3bb7798cb086f5bde7311b8
X-Gerrit-Change-Number: 1668
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1668?usp=email>
X-Gerrit-Commit: 9beebd0a80663550b187c6e2f54d8b2f6bfaaf25
In-Reply-To: <gerrit.1778102459000.I5c9b54dca0a14688a3bb7798cb086f5bde7311b8@gerrit.openvpn.net>
References: <gerrit.1778102459000.I5c9b54dca0a14688a3bb7798cb086f5bde7311b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MTAyNDU5MDAwLkk1YzliNTRkY2EwYTE0Njg4YTNiYjc3OThjYjA4NmY1YmRlNzMxMWI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d8338887be90a753eceb33f448a38f6ed413d105-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wMnVu-0003Eu-I3
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: Clarify
 operator precedence in a & b ? c : d
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3924908717871585450=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3924908717871585450==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c1Bua6PO7VM="; charset=UTF-8

--c1Bua6PO7VM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1668?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: route: Clarify operator precedence in a & b ? c =
: d
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: =
Clarify operator precedence in a & b ? c : d

As suggested by cppcheck=2E

=
Change-Id: I5c9b54dca0a14688a3bb7798cb086f5bde7311b8
Signed-off-by: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1668
Me=
ssage-Id: <20260511200645=2E24711-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36880=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvp=
n/route=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1668/4

diff --git=
 a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 3b18f74=2E=2E81ce867=
 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -2884,7 =
+2884,7 @@
                             =2Eprefix=2Eipv4=2Es_addr =3D htonl=
(r->network),
                             =2Egateway=2Eipv4=2Es_addr =3D h=
tonl(r->gateway),
                             =2Eiface =3D { =2Eindex =3D =
if_index, =2Ename =3D "" },
-                            =2Emetric =3D (r->=
flags & RT_METRIC_DEFINED ? r->metric : -1) };
+                           =
 =2Emetric =3D (r->flags & RT_METRIC_DEFINED) ? r->metric : -1 };
 
     ne=
tmask_to_netbits(r->network, r->netmask, &msg=2Eprefix_len);
     if (msg=
=2Eprefix_len =3D=3D -1)
@@ -2986,7 +2986,7 @@
                            =
 =2Eprefix_len =3D r->netbits,
                             =2Egateway=2Eip=
v6 =3D r->gateway,
                             =2Eiface =3D { =2Eindex =3D=
 tt->adapter_index, =2Ename =3D "" },
-                            =2Emetri=
c =3D ((r->flags & RT_METRIC_DEFINED) ? r->metric : -1) };
+               =
             =2Emetric =3D (r->flags & RT_METRIC_DEFINED) ? r->metric : -1 =
};
 
     if (r->adapter_index) /* vpn server special route */
     {

-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1668?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5c9b54dca0a14688a3bb7=
798cb086f5bde7311b8
Gerrit-Change-Number: 1668
Gerrit-PatchSet: 4
Gerrit-Ow=
ner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@gr=
eenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--c1Bua6PO7VM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1668?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">route: Clarify operator pr=
ecedence in a &amp; b ? c : d<br><br>As suggested by cppcheck=2E<br><br>Cha=
nge-Id: I5c9b54dca0a14688a3bb7798cb086f5bde7311b8<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1668<br>Message-Id: &lt;20260511200645=2E24711-1-gert@greenie=2Emu=
c=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg36880=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file changed, 2=
 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1668/4</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 3=
b18f74=2E=2E81ce867 100644</span><br><span>--- a/src/openvpn/route=2Ec</spa=
n><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -2884,7 +2884,7 =
@@</span><br><span>                             =2Eprefix=2Eipv4=2Es_addr =
=3D htonl(r-&gt;network),</span><br><span>                             =2Eg=
ateway=2Eipv4=2Es_addr =3D htonl(r-&gt;gateway),</span><br><span>          =
                   =2Eiface =3D { =2Eindex =3D if_index, =2Ename =3D &quot;=
&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                =2Emetric =3D (r-&gt;flags &amp; RT_METRIC_DEFINED ? r-&gt;=
metric : -1) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                        =2Emetric =3D (r-&gt;flags &amp; RT_METRIC_DEFINED)=
 ? r-&gt;metric : -1 };</span><br><span> </span><br><span>     netmask_to_n=
etbits(r-&gt;network, r-&gt;netmask, &amp;msg=2Eprefix_len);</span><br><spa=
n>     if (msg=2Eprefix_len =3D=3D -1)</span><br><span>@@ -2986,7 +2986,7 @=
@</span><br><span>                             =2Eprefix_len =3D r-&gt;netb=
its,</span><br><span>                             =2Egateway=2Eipv6 =3D r-&=
gt;gateway,</span><br><span>                             =2Eiface =3D { =2E=
index =3D tt-&gt;adapter_index, =2Ename =3D &quot;&quot; },</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                            =2Emetric=
 =3D ((r-&gt;flags &amp; RT_METRIC_DEFINED) ? r-&gt;metric : -1) };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
 =2Emetric =3D (r-&gt;flags &amp; RT_METRIC_DEFINED) ? r-&gt;metric : -1 };=
</span><br><span> </span><br><span>     if (r-&gt;adapter_index) /* vpn ser=
ver special route */</span><br><span>     {</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
68?usp=3Demail">change 1668</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1668?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I5c9b54dca0a14688a3bb7798cb086f5bde7311b8 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1668 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> G=
errit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--c1Bua6PO7VM=--


--===============3924908717871585450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3924908717871585450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3924908717871585450==--

