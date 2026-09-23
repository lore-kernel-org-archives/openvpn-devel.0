Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE36C982FA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d/qOxV7C4PyuH+hmMngaWlx6yiP+IZYV6wRKeLLu3i8=; b=C7HYa0VC375ZdCOl42ZIRTv2RQ
	S1YtUXjnwf9PUXPeikyB6nf9B9CgKq0blu/fXKCCN9GhvrxNWT2JEhRxRZGWjieP78b9e2gz+3ZaY
	sSSisRhyjbFSspInteqUy/ItG9U5CipldloGYXm+/I9DliJXdmlCGEZ8CY2N9umKIqTc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9MzM-0007Kq-U6;
	Wed, 23 Sep 2026 13:26:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9MzL-0007Kb-D1
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:26:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GscOKeLKkaRwb/khrHR9/wojkhMQCGKwoNy88lJJatM=; b=Uyh9QxR1RnfwwjHongkzpD+3Gi
 LJrGVa6YsqI85oEwXupcnG7LFED1Xzwa1RVl2LKMe5S0HKmRJhSZSa+rPoS2cXN0ZcNHzC823/7Kp
 NcYk6ZfOq0Ud8u0WWx1nQrASyxtdhF8YRQb20cdvLDbImI5GhqyF0Ixxt2iWgDRjERTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GscOKeLKkaRwb/khrHR9/wojkhMQCGKwoNy88lJJatM=; b=B
 hQKhVTJe3eZfol80zyFkMvpPrRMg3FTMoktOGZxDSBHmJKGOac7TyURdFuL1qXImug8Rx1BBjZRDj
 Bkv15nHtM69msYcx/LcFyCQj5OLGU1ogNJfg8nJq7gjSQFoOg4ro21MbuSa91PZbh0HDFqgIQzSbO
 IGZPGDp2suLDeWB4=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9MzK-0002Bh-PJ for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:26:20 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so6245915e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790169972; x=1790774772; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GscOKeLKkaRwb/khrHR9/wojkhMQCGKwoNy88lJJatM=;
 b=G5weMV+8dX/YDQ/FirfKeYPlo+So3pJcHyoOiYquvshUycy4fcD7qfnzbc2cc9ljSt
 B2Q2D8ovEfE5XxXWlVWFVEIOzZIBOiav0BbzIKfrvsIQ9G+Ydv/MhzGQ+2KZyhz37GUn
 TG+AwOtQJXCHUN9+vgr/+T1vTrr8puTEQ72Z9lKx56+md/WN+CuQ7cBg090scmyLD3YO
 1ZLscWZz1CEIIEWvBn9Lrqz0QFQFdkdfohsT1+mxOg2MOoyfsKSIhYoVzggzpxDkqkQl
 2oJkLb2hLfW6N12ridtXGkPeHS5pGSAG31PwHTVDswT6duHTX6pw702L396uqiUiDd/T
 YDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169972; x=1790774772;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GscOKeLKkaRwb/khrHR9/wojkhMQCGKwoNy88lJJatM=;
 b=LRBQMA2RoUnam4aCE8+msllTOayJxHvpTuLjEVqwmn8GIG3OGjEwaCDRYItTp17BT6
 nEBKE052OXLctKrTIu2TRnUjnh5z5Fu0IuLBz3T3Di8290o4i3u/Zpcz66B1fDfY5rd9
 VL2fVwtl6QuWi0l/SaPzB49AdxgVidZYPcOOXmVAhgtGRWFVCFL2W27HUOVnmxVi0Ruh
 ZDb/CMA6yLFgOcVxUFaibcFhlxgptsxGnL0aBq2ezRf7IVMq8cSKUDtlCgUkd0xI4gO8
 0VZR7jV94jfhR5HRzwWbPjRhIaomJJrO+U1nZoPXRnULrijCE8l1Lph2fcTq2di4TKC4
 XVGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvtzo/W/wejklgVd6XtiSQuqWfBJWR3skNjFEFu4qCdbP2ZGwMV2OwxOtUWOi0t3DnCNAv0UQmgEjjG2tg@lists.sourceforge.net
X-Gm-Message-State: AFuF++kWu5q+v28Dt0SFqKWoR5nolI76qIEnfWrGHifh9H1UtDTdGVIG
 seFz3Peq8BTaJ5EwsOBWyjmKGrcVcZE2SIRxSAMNtIJts4hgKafp5p7rXwgiUG20RmfLBzpqrUW
 LccH+X2gRHWWOTG+Hvjvt1pJ0/m/1vHHOwnJz4RBNit/YIk1KVygExLRhw587DShG/xjStkUOVf
 lITmPfyQ==
X-Gm-Gg: AYBFou38HgVDuvpFJFAEJraWfKdRu7DpfHyVvmawINPHl82EQMk6L7LK14RGHA+aY2R
 JLn0iiCI7bHY5rxpnWurh8v9yuxx8txDxv8fcI+ZuP3nkpUfGEx80POvpBv8Wcog2KxoZTy1gsz
 D5iK+SAWRQx7Jl1+kL43iiGBsPBZskuL8na0NUC8RbSxdM/JxZHdaWcpSKp40iJuZKkOcEsP8J/
 8f4gAIh8+6QNVbKodsInz7ZysTdz5T6hZyDefavCcos/WVkrRboRaKSOWk2YFq/QWv78hVBxzmE
 gV802JOEsf84FdSRAXYkLVz/i1skHIu+KJUnXggb/GuZyRb0sFAYUXVS5cxLMqKMZWYA/59O7n1
 7wPkWw1KWFba2l3oAaWmZvKjUJUScTESYdN5liDlT57zsRdxPzLei0P6Bpkzv5PeiXglHG7JirR
 2xVOc3LmtPOPQW78bYP0sRkcy+Z1/X7w4ozcZIMAYXgMxt6DMLHpOOUhtOwDkVwmWX1k0nq5E86
 9egO2Aj5o51d0D7LQ1l9v/6E3b4sDcMiCrRE33TTyHtIKmoTWJWmx2VNbZ3JjZMsrx3Hxu4MR+t
 0OylSXffXQcZ+U6CFkAjQvi1X5sfJLdSOFRLhcKVxxx3HafT9OugW13bR3L5
X-Received: by 2002:a05:600c:4f86:b0:49d:1f10:8b9f with SMTP id
 5b1f17b1804b1-49fdee0b02dmr32474035e9.7.1790169972051; 
 Wed, 23 Sep 2026 06:26:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1a3b46sm73734385e9.11.2026.09.23.06.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:26:11 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 13:26:11 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If276bd4c5d07fcd26f6749f514f0257eab73249f
X-Gerrit-Change-Number: 1945
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1945?usp=email>
X-Gerrit-Commit: 0c12762e6b250a967c154a2a127909e2bd9d3394
In-Reply-To: <gerrit.1790167275000.If276bd4c5d07fcd26f6749f514f0257eab73249f@gerrit.openvpn.net>
References: <gerrit.1790167275000.If276bd4c5d07fcd26f6749f514f0257eab73249f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMTY3Mjc1MDAwLklmMjc2YmQ0YzVkMDdmY2QyNmY2NzQ5ZjUxNGYwMjU3ZWFiNzMyNDlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3e05fdf2a8dad101dd526756d5489bc7122f7dd-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9MzK-0002Bh-PJ
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: proxy:
 Work-around spurious warning on mingw builds
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
Content-Type: multipart/mixed; boundary="===============5453895253201498637=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5453895253201498637==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EvT8tS5/4a8="; charset=UTF-8

--EvT8tS5/4a8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1945?usp=3Demail )

Change subject: proxy: Work-around spurious warning=
 on mingw builds
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

proxy: Work-around spurious warning on mingw builds

mingw in Ubuntu 2=
6=2E04 has issues with checking snprintf
format strings against original MS=
 implementation even
though it uses the GCC implementation=2E

Apply work-a=
round that is good enough for code that is
already gone in master=2E

Chang=
e-Id: If276bd4c5d07fcd26f6749f514f0257eab73249f
Signed-off-by: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1945
Messag=
e-Id: <20260923130801=2E16802-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39441=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
proxy=2Ec
1 file changed, 3 insertions(+), 1 deletion(-)




diff --git a/s=
rc/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index 7101d9f=2E=2E857bf03 100=
644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -767,7 +767,=
9 @@
 
                 char get[80];
                 CLEAR(buf2);
-      =
          snprintf(get, sizeof(get), "%%*s NTLM %%%zus", sizeof(buf2) - 1);=

+                /* mingw checks calls to the builtin snprintf() with the
=
+                 * ms_printf archetype, which does not know the 'z' modifi=
er */
+                snprintf(get, sizeof(get), "%%*s NTLM %%%us", (unsig=
ned int)(sizeof(buf2) - 1));
                 nparms =3D sscanf(buf, get, b=
uf2);
 
                 /* check for "Proxy-Authenticate: NTLM TlRM=2E=2E=
=2E" */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1945?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ger=
rit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: If276bd=
4c5d07fcd26f6749f514f0257eab73249f
Gerrit-Change-Number: 1945
Gerrit-PatchS=
et: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>

--EvT8tS5/4a8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1945?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">proxy: Work-around spurious warning on min=
gw builds<br><br>mingw in Ubuntu 26=2E04 has issues with checking snprintf<=
br>format strings against original MS implementation even<br>though it uses=
 the GCC implementation=2E<br><br>Apply work-around that is good enough for=
 code that is<br>already gone in master=2E<br><br>Change-Id: If276bd4c5d07f=
cd26f6749f514f0257eab73249f<br>Signed-off-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1945<br>Me=
ssage-Id: &lt;20260923130801=2E16802-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g39441=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M src/openvpn/proxy=2Ec<br>1 file changed, 3 insertions(+), 1 d=
eletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/proxy=2Ec b/src/openvp=
n/proxy=2Ec</span><br><span>index 7101d9f=2E=2E857bf03 100644</span><br><sp=
an>--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec<=
/span><br><span>@@ -767,7 +767,9 @@</span><br><span> </span><br><span>     =
            char get[80];</span><br><span>                 CLEAR(buf2);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                snprintf(=
get, sizeof(get), &quot;%%*s NTLM %%%zus&quot;, sizeof(buf2) - 1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                /* mingw che=
cks calls to the builtin snprintf() with the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                 * ms_printf archetype, which does=
 not know the &#39;z&#39; modifier */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                snprintf(get, sizeof(get), &quot;%%*s NTL=
M %%%us&quot;, (unsigned int)(sizeof(buf2) - 1));</span><br><span>         =
        nparms =3D sscanf(buf, get, buf2);</span><br><span> </span><br><spa=
n>                 /* check for &quot;Proxy-Authenticate: NTLM TlRM=2E=2E=
=2E&quot; */</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1945?usp=3Demail">change 1945</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1945?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=
=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: If276bd4c5d07fcd=
26f6749f514f0257eab73249f </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1945 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>

</body></html>
--EvT8tS5/4a8=--


--===============5453895253201498637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5453895253201498637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5453895253201498637==--

