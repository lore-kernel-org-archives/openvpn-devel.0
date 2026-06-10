Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A037CD8C90
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HWQdjpurCUImhKkEMJ/VMfhDKI0/u4fjZlEF2dluYRc=; b=O0tRcuVQfLyIEQJrpTdnw90TEo
	5rdhobnYI/m99VHczH1N76Ehv5tgEmja0yONGlpuqPrIuS4I6N/CxQuMgrw2ukV5PwhTERoSfWeNn
	jEEWPY25VcGbeHWJ5LT2FyvWHqXMB2N4T90YF00xXMFu572N8YU4ib8VvbICoEv/Du7Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXMSS-0003V6-9s;
	Wed, 10 Jun 2026 17:11:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXMSP-0003Uy-DR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ANT2cfijwgiM0LYOLC0W381IxUMiwH3GPTQ6qLCdyes=; b=MhFZyN2nb4aj80b1TWHTYEuIPM
 D1noOGQMUN4/2ECI+/4QlAGIoL5j8ioYoZmsEQT3JSiGrKaKGKFEB6ypgBwNj55A+i5wplLY12ZEv
 BX2GzC2aXmK60sgeqS9rfunsMfSZY2VYDfAYzte2iXX2Sd9U8RAkVdxaIE01hsP3J3Uc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ANT2cfijwgiM0LYOLC0W381IxUMiwH3GPTQ6qLCdyes=; b=E
 mecCHKCHvMsO3sXxK9IpKIHUpd+pR5hQYjy4Fsg7Ri24z5A0zTMcu8GhA5O4qpXDf3H1IamNgnarS
 jdQADqdzjuu2XqTC+FA+cHzf2mmgpNL8x/PHAS9h/RugBpUkDyXrPBJEFgRHRD71QvoCkbWwz0tTq
 XDAXYhT0vBYxSJIU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXMSO-00078U-5x for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:11:14 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so43949385e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781111461; x=1781716261; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ANT2cfijwgiM0LYOLC0W381IxUMiwH3GPTQ6qLCdyes=;
 b=MAcdP14e6iCVzmpupDNQaLYAi+8LTteW/XUcz0Zx8jnMUrC7L3pkhyejPz9HnQJIMP
 UITMYrQtpC1EsMsWSc2e1NtzvHDB2ektSN83Fcil8K9Vg5EIGLbTI4u3cEyH1hQcde/0
 ttTGknIoCVOF2ZiW7Ecg0hXJ7mT+PV1SxKAuaKnq/FwG/g5hRZY/xg0n090eHpbJ/iMh
 6ZbTHU800KeohnNX4SuGCo2e4vPUl8qcIVgLsmazZW1xVv0RGTF3KVcHz2JWh+I3baG6
 LOGFhUgvrReqvm7im4oBZ3Z+xFKgXzGE3mgAkMhEQsaMGXhje5p0MZd3YIS5w/N9TvH6
 lamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111461; x=1781716261;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ANT2cfijwgiM0LYOLC0W381IxUMiwH3GPTQ6qLCdyes=;
 b=Na31TUhqbMSbjl5h6xX6lLYd8lmW588wUebhxOs89UYp/IWP3aXsCiWYRGhE0C+dxY
 gOSi4U51JViqUZrALVKilh1WYtXQmtC9aLYClheCunaYH5ZC+rdMd6z6Qezm1ldx6QbD
 ZlJXdG82+hKtcs+bxU0jlUvBMhdKvr6vZ4j/Yn87XSVK4vF+8hmfGEkwwx6a3X0/1dn1
 BBXR4mYXrorNGMKj+WjsE+d+R82tX3Ko/j3ELWj0rR7KaHjIv4WfHL54hUj2o1rbPVhe
 VFFrujbc0+f6afmC+8oFtLOZnrT7XpjCKUpdOW85erh0UBHca4brSEODF4eaLuHWejv0
 URmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mUNppDXTK1xFo8CwrQabSfGRfLoJo8BYdzY8j2l1cSNJt/4HJM8/5Qf7oer2L7EPWVpSh3d1vn1zajv+X@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyLZapXbdA5LTDeqJBerSwjp4bVrKaSLm87ba5aF+Mmqzr57dgy
 Se6C4pFsBBUCx3Y4tG+aox9f9X2tof0lqsV+uG4gfoBpU12ZHSbckFExOetgVYw5D1TTGLlx5jx
 q1OrP2DY39tKtDEOgAPKYbCBEQkMkCaolZXoJVvOGQXdblHjNzXP2mmGcwfPtkKlhP/mG
X-Gm-Gg: Acq92OFtoShBVqsgcfdkFL04ZctjS/tuofqZ+atqunmhsOLd+R6Mpbgxfi2AP8BdfcI
 ZEYb95fQDtgWjIY+ZBV6Tz9VLIc4uwIgU/s6iAqePfSni3Ttp0DJhdvdN17ZIECoQ4YLLWObpGS
 orZI7eGiOI49Ae+nb+/23JYxK9HIy7431uNYAPpf4JM0nm3oACIH7/JhrK6anj2jBBt9jjYZajx
 YldMG6dFKY5lRe4uU6L3LKO3LIRMSKP03/Nu61R/gzfQwqcH0CNfaEfi1OHaAsAgu1ZAJ5GcWuN
 eX4LpEV8/Ty95G2IvaLjvlATx+jM68pu+8JrC74yiWT/xOYRE4YEPcWYPPN49dIs9zrNsQ3z6SB
 KtVR5fSdkfrnm7ozH8w3cdJrL/IlPiEMeiCQqJRUzNJVzKoRBmCwELikdRfJ3V7exB2XIMy/LGC
 Tr/jE1mFnrii6cEE5h3mCgHbFjlXcqzvqpFtKSTnhApEDP+j8BoNOgVM94uP9/hr8xVvf9kXPbe
 FBQHBThPC7B7tURVPTeiQsrfR0c1KIpSv0vxGDfC36hKD4hVMiu2RdLEEbde2Y9S0EnZi6CZZZx
 JSwT0W8G2HdxpVhrLFvwn5Aq
X-Received: by 2002:a05:600c:c16e:b0:490:b8c0:d470 with SMTP id
 5b1f17b1804b1-490c2622d03mr434371355e9.19.1781111460950; 
 Wed, 10 Jun 2026 10:11:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2855f30sm3358725e9.7.2026.06.10.10.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:11:00 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 17:11:00 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I668b96afae9dda5692c46db14634b3b8c03056e5
X-Gerrit-Change-Number: 1709
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1709?usp=email>
X-Gerrit-Commit: e02ca9a487ba04c5f2da28421795e74b9b5b71e0
In-Reply-To: <gerrit.1781017122000.I668b96afae9dda5692c46db14634b3b8c03056e5@gerrit.openvpn.net>
References: <gerrit.1781017122000.I668b96afae9dda5692c46db14634b3b8c03056e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkk2NjhiOTZhZmFlOWRkYTU2OTJjNDZkYjE0NjM0YjNiOGMwMzA1NmU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7f1d66a6cce24e9c48a5ea3ffb7a2ab836441e28-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXMSO-00078U-5x
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8413100736441004806=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8413100736441004806==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xg1SFGDxyfE="; charset=UTF-8

--xg1SFGDxyfE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1709?usp=3Demail )

Change subject: renovate: Fix typo in regex manager=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

renovate: =
Fix typo in regex manager

Broken since commit 8485518dce6b7ebeda6295fcdf3b=
c7476b7b9117
("GHA: Factor out building SSL libs to a reusable workflow")

=
Change-Id: I668b96afae9dda5692c46db14634b3b8c03056e5
Signed-off-by: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709
M=
essage-Id: <20260609152045=2E27384-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37137=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M renovat=
e=2Ejson
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/ren=
ovate=2Ejson b/renovate=2Ejson
index 3bd0917=2E=2E5b6e0d0 100644
--- a/reno=
vate=2Ejson
+++ b/renovate=2Ejson
@@ -40,7 +40,7 @@
                 "/^\\=
=2Egithub/workflows/=2E+\\=2Eya?ml$/"
             ],
             "matchSt=
rings": [
-                "versioning=3D(?<versioning>=2E*?)\\n\\s*ghrepo:=
\\s*(?<depName>=2E*?)\\n\\s*gitrepo:\\s*(?<currentValue>=2E*?)\\n"
+       =
         "versioning=3D(?<versioning>=2E*?)\\n\\s*ghrepo:\\s*(?<depName>=2E=
*?)\\n\\s*gitref:\\s*(?<currentValue>=2E*?)\\n"
             ],
           =
  "datasourceTemplate": "github-tags"
         }

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I668b96afae9dda5692c46db14634b3b8c03056e5
Gerrit=
-Change-Number: 1709
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--xg1SFGDxyfE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1709?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">renovate: Fix typo in regex manager<br><br=
>Broken since commit 8485518dce6b7ebeda6295fcdf3bc7476b7b9117<br>(&quot;GHA=
: Factor out building SSL libs to a reusable workflow&quot;)<br><br>Change-=
Id: I668b96afae9dda5692c46db14634b3b8c03056e5<br>Signed-off-by: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1709<br>Message-Id: &lt;20260609152045=2E27384-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg37137=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M renovate=2Ejson<br>1 file changed, 1 insert=
ion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/renovate=2Ejson b/renov=
ate=2Ejson</span><br><span>index 3bd0917=2E=2E5b6e0d0 100644</span><br><spa=
n>--- a/renovate=2Ejson</span><br><span>+++ b/renovate=2Ejson</span><br><sp=
an>@@ -40,7 +40,7 @@</span><br><span>                 &quot;/^\\=2Egithub/w=
orkflows/=2E+\\=2Eya?ml$/&quot;</span><br><span>             ],</span><br><=
span>             &quot;matchStrings&quot;: [</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                &quot;versioning=3D(?&lt;versioning=
&gt;=2E*?)\\n\\s*ghrepo:\\s*(?&lt;depName&gt;=2E*?)\\n\\s*gitrepo:\\s*(?&lt=
;currentValue&gt;=2E*?)\\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                &quot;versioning=3D(?&lt;versioning&gt;=2E*?)\=
\n\\s*ghrepo:\\s*(?&lt;depName&gt;=2E*?)\\n\\s*gitref:\\s*(?&lt;currentValu=
e&gt;=2E*?)\\n&quot;</span><br><span>             ],</span><br><span>      =
       &quot;datasourceTemplate&quot;: &quot;github-tags&quot;</span><br><s=
pan>         }</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709?usp=3Demail">change 1709=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I668b9=
6afae9dda5692c46db14634b3b8c03056e5 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1709 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>

</body></html>
--xg1SFGDxyfE=--


--===============8413100736441004806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8413100736441004806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8413100736441004806==--

