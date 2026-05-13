Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0D6CD4851
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 09:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kUC24P1SQZmUUrtbACjmN8Y32ehrHe1lZD+cVqTPpwI=; b=lbPhQVTs6N//GUvWHrsngSdXyc
	PVsqx0vbaN0Nf0yaXBjsQxVNpRLOQD9JyGp1al3t8iTgZDMvgM6/EmimmNY6UUifu59S176NtWRM4
	TPCc0bII4Mhwbujxu/bwlehZkAum2Si0EzQC6Ji4888o62AOrs9CP5/yj4tJZ6pMPM0E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN5hK-0008Hu-LD;
	Wed, 13 May 2026 09:16:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wN5gx-0008H1-3e
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:15:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iAlMDJhg3lJbeoGmSBmOGJ5i2DE3R7s06dIMi+Dxheg=; b=PIRFKCcvkQVkJ5CFmqnm58gCnE
 wUi7qLVM9Wldy7G/RobDqMvw12KX4UVAgOF0JQDrOcY//5hoXoIDvNAIFdSI898Jh9wY/1HJzkz0M
 3nbvoytsSjzcD0RkC7Le6eZNOJ6TTMTSp4tpmC9lLaEJN+YCcEnhLBqbL3Fi+cHhgnWA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iAlMDJhg3lJbeoGmSBmOGJ5i2DE3R7s06dIMi+Dxheg=; b=h
 sX9w2wLCnNRE4ufhMFC3aiHFPNvlcryAhLvY6YOkZSFQY4KwlVPdSNGleD640wFOJoiLPj2rs8NuB
 zFhrooXl+6rsPP8sLFxb9iZiNUisonfZq4AmBrR23CHJa9aU7EHdA4FOGWvR/kx0DVLpvSyVGhbPE
 sFNhZbASomOyaXOM=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wN5gg-0003hd-IR for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:15:34 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so64575395e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 13 May 2026 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778663724; x=1779268524; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iAlMDJhg3lJbeoGmSBmOGJ5i2DE3R7s06dIMi+Dxheg=;
 b=Q1HdV/VNyFjzWpnBkhYVEqCCCf9rnRRltfEt+B/zwPPvEXVg5Z+el4OQOolVhZ6FFN
 8sVxfAqlfE+OiI909dVlcg7/twyEW4kCFUaUhSXZBS5+yW9PtIopECNqvaqsLn+Xn7dH
 khoDSWEO10pRx35XCAu5AzsK1bFqbkhiKHwWJl/EF1nuOXJiHEd6bw3yzeIDWiJTLu5h
 gUR0xPpsocO4H5+e6I+VT5Hg7gXSvQlPjVJa1l2nZyiPeAY0fDnENsjT3BRzCTwh+kQG
 NOHMcl7WUNE2qB/cscDmWa4XkotQRefMz4+NXYBW0KvVXT76jTPRNerwRuoSP1RbRzhf
 b86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778663724; x=1779268524;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iAlMDJhg3lJbeoGmSBmOGJ5i2DE3R7s06dIMi+Dxheg=;
 b=IkWaAGlGrvI09bduxarFVvMubKU5hmBxuxsIbVun0S1+H2CUoyNZXQjHnFKRkPAjjF
 LAddY5nq/RfV6D33G538/jEexTIE6DZZPVOTYM2r0p0/RSpBJBSr8D0o7XS4Qb+V9ztz
 x54CllPLOQS3DvjYAcVWnF1Q7SalCd7foIoyy4nDCwDM0r0TISOxnJWamIYgbpvKZVYg
 nyFX1BrM7yJPyI/1zUGYJnCJRB0HsCNtPVOPrcIB/2qKOtoB9FXEWLQAt3lPD9/Oo0af
 4MvGBHbqp2T9y0KO+j0YXfssrzO0SK6OcIkZWD7VF+t9XermoP7mj86Bt/Y9Tb1hjcTX
 M9Yg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NScNEycGUyWWeLqqVfFIZ/vxugEpaKsD5Ipp4LQWpsIBcVLZO8hDw47KkHVD4Qulb8tvlJOwEnvRv9OGZ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyvYnNNa11TibPvWlSNDqNYya+WCe9RkYChP+/CTv80O7IUh76k
 WsIMrXJOYgXsYZsUiTV8gGYTFU3XXmeewAe5KIuMLiJcOkzD09suPt+vjNR/rAkspYqug8PfKyS
 +SlFUnpMkjWqiHlEisN1ULOOMZwKda3XoD6qUL0tLMGE7VULNT/BqslOQ00dKaLTtP9JJ
X-Gm-Gg: Acq92OFUwh+BB2FY8m7byN9Se+MjDDxHc6K6zOBwmU6rmY2tKL/nTsuQaQ3baYb+TSw
 VIpaqxZYYoTvWqa6X5YN5BmDgypp9BLYqcqU79ciWnCIHSS8YR/HmDCf4tRdaWGZP3fk/VwcADG
 XCMXXF+FKzJ6JvEGnVW8OWFYsfxxY4I8sxEbVvMEWMwXC6jprSU7PO9XJT7G8HpXEG5lihSGQsh
 ntoK9qMBNRYr9tAQ8Y4e88bYsaAM8DofdeP1LAgy67RuGSMWtBJGwBbRAjEO36izxHHHT/JZCFI
 SmnyFbc80V4hsNV6jEwtcNYIaC9saXJ8a1IxWO6ZrvxoKY6xX7BRmr4UNFUjouqYl+0PMeR0hYv
 +sz5XRgqnCMFzO+0EmiOjdLo5N9ihDOuyeZY9BDIGnvTWGna98ekPFHDRLgdTdpXkg503UP9M1U
 E3livvMcTizr9Il6WJKJz20Rc7uFlA4EIyGdHXkE6a6m3YP6ImqoeKp2vU/vI6LRQxHp62yydCf
 XGk9JN1YV4PFLTCTi0fsRulYQpBTi3hzLPDeSZBtGFtcv/ciF8NCb2/g04Ihk7vh4dy1thA5Fju
 7g8k86OYDxglCowzc4gxYvhh
X-Received: by 2002:a05:600c:3107:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48fc9a07765mr32431965e9.5.1778663724293; 
 Wed, 13 May 2026 02:15:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f3e174fsm58087125e9.3.2026.05.13.02.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 02:15:22 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 13 May 2026 09:15:21 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2
X-Gerrit-Change-Number: 1676
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1676?usp=email>
X-Gerrit-Commit: b887872524d6fc481c23bfac20c3f5d117547eba
In-Reply-To: <gerrit.1778239616000.I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2@gerrit.openvpn.net>
References: <gerrit.1778239616000.I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkkwOWViYmY2ZjM1NTVkZDY4Y2U4ZDc1YmZhODQ0ZWNhYzUxOGEwY2YyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a00412c9269e472733eb0640876502732d8d1381-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wN5gg-0003hd-IR
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: pool: Fix a
 potential NULL pointer de-reference in test code
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4276164383485831484=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4276164383485831484==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yPeKyjDPhok="; charset=UTF-8

--yPeKyjDPhok=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1676?usp=3Demail )

Change subject: pool: Fix a potential NULL pointer =
de-reference in test code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

pool: Fix a potential NULL pointer de-reference in test code
=

Identified by cppcheck=2E Probably has been a long time
since that code ha=
s been compiled, though=2E

Change-Id: I09ebbf6f3555dd68ce8d75bfa844ecac518=
a0cf2
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1676
Message-Id: <20260508153156=2E13575-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg36865=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/pool=2Ec
1 file changed, 2 insertions(+), 2 =
deletions(-)




diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
i=
ndex 15004c0=2E=2Eff74e7c 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openv=
pn/pool=2Ec
@@ -757,7 +757,7 @@
             break;
         }
         msg=
(M_INFO | M_NOPREFIX, "IFCONFIG_POOL TEST pass 1: l=3D%s r=3D%s cn=3D%s",
-=
            print_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc)=
, cn);
+            print_in_addr_t(local, 0, &gc), print_in_addr_t(remote,=
 0, &gc), cn ? cn : "[NULL]");
         array[i] =3D h;
     }
 
@@ -793,7 =
+793,7 @@
             break;
         }
         msg(M_INFO | M_NOPREFIX, =
"IFCONFIG_POOL TEST pass 3: l=3D%s r=3D%s cn=3D%s",
-            print_in_a=
ddr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc), cn);
+            pr=
int_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc), cn ? cn : "[=
NULL]");
         array[i] =3D h;
     }
 

-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1676?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2
Gerrit-Chang=
e-Number: 1676
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>

--yPeKyjDPhok=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1676?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">pool: Fix a potential NULL pointer de-refe=
rence in test code<br><br>Identified by cppcheck=2E Probably has been a lon=
g time<br>since that code has been compiled, though=2E<br><br>Change-Id: I0=
9ebbf6f3555dd68ce8d75bfa844ecac518a0cf2<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
676<br>Message-Id: &lt;20260508153156=2E13575-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg36865=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/pool=2Ec<br>1 file changed, 2 insertions=
(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/pool=2Ec b/sr=
c/openvpn/pool=2Ec</span><br><span>index 15004c0=2E=2Eff74e7c 100644</span>=
<br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/openvpn/pool=
=2Ec</span><br><span>@@ -757,7 +757,7 @@</span><br><span>             break=
;</span><br><span>         }</span><br><span>         msg(M_INFO | M_NOPREF=
IX, &quot;IFCONFIG_POOL TEST pass 1: l=3D%s r=3D%s cn=3D%s&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            print_in_addr_t(loc=
al, 0, &amp;gc), print_in_addr_t(remote, 0, &amp;gc), cn);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            print_in_addr_t(local, 0=
, &amp;gc), print_in_addr_t(remote, 0, &amp;gc), cn ? cn : &quot;[NULL]&quo=
t;);</span><br><span>         array[i] =3D h;</span><br><span>     }</span>=
<br><span> </span><br><span>@@ -793,7 +793,7 @@</span><br><span>           =
  break;</span><br><span>         }</span><br><span>         msg(M_INFO | M=
_NOPREFIX, &quot;IFCONFIG_POOL TEST pass 3: l=3D%s r=3D%s cn=3D%s&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            print_in_add=
r_t(local, 0, &amp;gc), print_in_addr_t(remote, 0, &amp;gc), cn);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            print_in_addr_t(l=
ocal, 0, &amp;gc), print_in_addr_t(remote, 0, &amp;gc), cn ? cn : &quot;[NU=
LL]&quot;);</span><br><span>         array[i] =3D h;</span><br><span>     }=
</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1676?usp=3Demail">change 16=
76</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1676?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0=
9ebbf6f3555dd68ce8d75bfa844ecac518a0cf2 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1676 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--yPeKyjDPhok=--


--===============4276164383485831484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4276164383485831484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4276164383485831484==--

