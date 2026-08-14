Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A916BC5CFCF
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XJJYoo3/SV1ByNOa3ed6UB5jw2k2fgOZxrUTbqIECDw=; b=mceXSlCyyrH/LY/JqcUVCs35ih
	o3wGw/YbcNYO2zeu7MKiITKrtqX4oJ0O8MTzdy/gFwQrC5DXlWIBZOxYgjt/yi8m6KDeg6pnXtd1T
	dv7BvCzgIQ21gEFpxIRWf/bnAs/2W0vVvmgIM2cNfFyiC78uw/u7vqW+I0O+xYAP+x/4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wumKJ-0003Nv-22;
	Fri, 14 Aug 2026 07:27:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wumKF-0003No-C9
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=I2NM0pRMbnzDGuseeTD+4jxilun23nMKs6GU++lmaSI=; b=LVtB4o81nTZnwM/4nu104eqb1x
 JelRlhXIfhSrT9HTLrbvuacGlR6DEmf1SjjxW7Gaax36vW2JCdn+JNgvg6OqjGS8TPJaDMYxiCGxx
 SNwMW7dKvc0UQTRQBqrnqIrdHqFNPJ7dr7/eBBDyBH6HkvQCcfdFBcOqq1mj2Rcx8olM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I2NM0pRMbnzDGuseeTD+4jxilun23nMKs6GU++lmaSI=; b=B
 z7CdBh/dCNUJ+l7BzxNzMys8XzpAR86egACJ08Ojr7f1BhDn1iHPENtfcV/+08SbIxqy7XV7qbDGU
 b1LRtynCwc552AHA4xVtAiYnzs4CrkSKIX4UPEZKEZFg0naftfTPIC2xbrzU63hH7yVF0uhXVmqjN
 EScTg1+mVarktZl0=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wumKI-0002t8-8x for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:27:35 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso3096085e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786692448; x=1787297248; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I2NM0pRMbnzDGuseeTD+4jxilun23nMKs6GU++lmaSI=;
 b=gPXgG/Gfg6k6c/NdumzUlqjtB1cPWUoKQt+ifQZc8fKwXx8I508n8hZhRXS/6YxL6s
 iW72SAP1jHMXMylD0XPDGFQjrnE29qiXwbIP0hQDlZpEG7lYC4aHdcoTcYlDVOYCUtjk
 hW5cI7kQygeP7PQ61D0f2OM6mgJnTcKjuWGNbe4HZfdOUf/p7LceuO49DJ7q2qcTU1YQ
 CAEnkEJFfEHe20U4f4eQet1gbroQY0KoU4xy/2jVOR6/QkghJDKh5IUhmUPSizabHtlq
 XRdI1/8E0i40wMLL1XTKfRRmaTFpYvd55RG7+/KzRiCXXwXXe+rRfrMGGArhexOcdBZL
 3kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786692448; x=1787297248;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I2NM0pRMbnzDGuseeTD+4jxilun23nMKs6GU++lmaSI=;
 b=ltLBLS+mdx2L9Iorw64HykAAHxL6zq+DvjNExRmfirMsxUADNhi9/pgYl3KUpDa151
 FdVdabiKZ9ZXQI95MAm7NyYXboukE8EP2/hUIvIKu6i2GchSqYa5XSOe3xwTVx3TyvW0
 ka0r76y94LbVrfka36hVkd+dTuexURKL6EBB+CzBw1BruN3zkaEZrYwa0KfHq9p+baHH
 9Y+baJZ+e5pER7Q8wjqc4wJhZ2Rgg9L7+gnHx7sVv0dF53LBogRJHE1OzcZqEYqbXXg9
 J2HBtDqoYreoehWfTZqXHg4KlQFkwBBfp3+7uzlSelaT8UXqqE3tfQ7uH6xGXFv/F/+2
 KUUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RquVCSxCEJUFcL9WsmHzaS+VM42TPP2vFMpaUhihaGwHRqeula/qWbuEglVeYk7IiDYjd3QG665jxXjhGt3@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxzhw0TZ/FVP7xsF0YRGyFAiymWhNhP5w9+YBgYNzbujHtGlLl7
 Z3R5KcxbEFnnStOrPJ++JSJrlYYG6n0W97IAYAXbmMLcNbDfFsiNgRd0GJlOSSeuD1xhWNb/XdT
 iTdRUJ6xDsF4i7osyweFBAXZwBvDbuQ/Jz90O8QfPiFQPHlPzrYO2H+lazv2Kn2iTpP3z
X-Gm-Gg: AR+sD13n+xGDR1Bihot2YVvj095iBtXGx7r5yF4Nn4ichGR7k99U2wyvxbCTeBbG96T
 gBW39T6oYF3A+71HqhcB+HAmgCaxYREOAQWiLZvAPOwwh6/LLA7ejPtcbS+zaJJmU0gThlPx7tJ
 E/ImHYYYL05KRUhJvR3Q55QnU85do9P2LfAE1JaypvBexNFEvvdSUPypgjzHOBE+Z1TndIxTuym
 jNhB9Wp4BF2g2mHfe7zXxHTyhugcnJ0C7XHsCpatf1hXeXKPaGrZCxmlQls+Mmb2atHdHzuOqAn
 pI58JPe4970J6NUKxmt3R0A67JrXlqFReeVuh0gO75ZaQkhmBSQnh8xI/3GGcFvhKV4jL92yVxl
 ImPBudEBvco0CHzpFLW6GnZcChySapQUfBjD/qkp9gT5e3hXiHVaGbCLXt3WwuFeB8BZQ7Y0ro0
 FMhf/rj7bNV6uEHMDgBi8XYzlUdA2VAxmIFVp5iGgn38kryPevq6kUkKAIT56cAtZ1p4hAS6XZ9
 gOdZ6EGdlHfSSf5ohOoKt5GiE6YQojeBggRz1RzNfmWasMUHKwpPRgXPYoBfBBU0yDZjTMFOmLu
 20RUnw4glhO/EkH3wA9vgAyHwsEyQDDo/5OerviNDQC9yrPvPVg=
X-Received: by 2002:a05:600c:3e15:b0:495:6b55:f938 with SMTP id
 5b1f17b1804b1-4998797328cmr51291775e9.10.1786692448039; 
 Fri, 14 Aug 2026 00:27:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988adfb67sm30301915e9.3.2026.08.14.00.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 00:27:27 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 07:27:27 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie44556f5ece28b54cc657fa86261b827efb42467
X-Gerrit-Change-Number: 1779
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1779?usp=email>
X-Gerrit-Commit: a98cb76220351211b40ce21efd0fd68bb48d7e8b
In-Reply-To: <gerrit.1783961511000.Ie44556f5ece28b54cc657fa86261b827efb42467@gerrit.openvpn.net>
References: <gerrit.1783961511000.Ie44556f5ece28b54cc657fa86261b827efb42467@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkllNDQ1NTZmNWVjZTI4YjU0Y2M2NTdmYTg2MjYxYjgyN2VmYjQyNDY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <58e3a1e003500accd29cec7770bd0e575d999cc6-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wumKI-0002t8-8x
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: win32-util.h: Fix
 includes
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5309903180060742505=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5309903180060742505==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jwPFv7nw0Mo="; charset=UTF-8

--jwPFv7nw0Mo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1779?usp=3Demail )

Change subject: win32-util=2Eh: Fix includes
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

win32-util=2Eh: Fix=
 includes

This file includes various headers but then doesn't
use anything=
 from them=2E It does not include the header
(buffer=2Eh) it actually uses=
=2E

Change-Id: Ie44556f5ece28b54cc657fa86261b827efb42467
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/177=
9
Message-Id: <20260813180927=2E3263-1-gert@greenie=2Emuc=2Ede>
URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38331=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/win32-util=2Eh
1 file changed, 1 insertion(+), 5 deletions(-)




diff=
 --git a/src/openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh
index 4849=
ea9=2E=2Efb83762 100644
--- a/src/openvpn/win32-util=2Eh
+++ b/src/openvpn/=
win32-util=2Eh
@@ -24,11 +24,7 @@
 #ifndef OPENVPN_WIN32_UTIL_H
 #define OP=
ENVPN_WIN32_UTIL_H
 
-#include <winioctl=2Eh>
-
-#include "mtu=2Eh"
-#inclu=
de "openvpn-msg=2Eh"
-#include "argv=2Eh"
+#include "buffer=2Eh"
 
 /* Conv=
ert a string from UTF-8 to UCS-2 */
 WCHAR *wide_string(const char *utf8, s=
truct gc_arena *gc);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1779?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
e44556f5ece28b54cc657fa86261b827efb42467
Gerrit-Change-Number: 1779
Gerrit-=
PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--jwPFv7nw0Mo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1779?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">win32-util=2Eh: Fix includes<br><br>This f=
ile includes various headers but then doesn&#39;t<br>use anything from them=
=2E It does not include the header<br>(buffer=2Eh) it actually uses=2E<br><=
br>Change-Id: Ie44556f5ece28b54cc657fa86261b827efb42467<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1779<br>Message-Id: &lt;20260813180927=2E3263-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg38331=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/win32-util=2Eh<br>1 file=
 changed, 1 insertion(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh</span><br><span>index 4=
849ea9=2E=2Efb83762 100644</span><br><span>--- a/src/openvpn/win32-util=2Eh=
</span><br><span>+++ b/src/openvpn/win32-util=2Eh</span><br><span>@@ -24,11=
 +24,7 @@</span><br><span> #ifndef OPENVPN_WIN32_UTIL_H</span><br><span> #d=
efine OPENVPN_WIN32_UTIL_H</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#include &lt;winioctl=2Eh&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#include &quot;mtu=2Eh&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &quot;openvpn-msg=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#include &quot;argv=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;<=
/span><br><span> </span><br><span> /* Convert a string from UTF-8 to UCS-2 =
*/</span><br><span> WCHAR *wide_string(const char *utf8, struct gc_arena *g=
c);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1779?usp=3Demail">change 1779</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1779?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerri=
t-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: maste=
r </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie44556f5ece28b54cc=
657fa86261b827efb42467 </div>
<div style=3D"display:none"> Gerrit-Change-Nu=
mber: 1779 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--jwPFv7nw0Mo=--


--===============5309903180060742505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5309903180060742505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5309903180060742505==--

