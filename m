Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A011EC5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/PXbfm7sf9LgJCh0VBTPWzSU3yV5uWrA9xSHOijwn6o=; b=NAu8tv8ATEeMXB04tUpR6mdKOs
	d42hkapZKHQr9FnexyQcvUVAGQjkg+09ABaXX6tt0hKmjvzFcteEAli3hCsaq7o0vVHL8GNHgkh/4
	5xoIn08DrVNSgQ24e7VjoH9mKM48ZhylxD5GxdRX/DtsQ4ImSFI/5KAh5ecBQ7Eq8bcI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wumKH-0007Os-EM;
	Fri, 14 Aug 2026 07:27:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wumKE-0007Oj-E7
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sW/IYPXJDvprDxSNSyHcD1aFwLo0VZLwmY8S6RNGf1w=; b=b5RsyBwBsM6XLfzprYoFMc+i45
 UzHv249vUyyOLs0rFrEizoMw5vjS6aoYJAP/kj1hRtgiSquYbklQ2rR+fww3Ipbn48al1xSR0wv9F
 VOljHRxgVfLAnXN+rLDzCLQB9hxq30N+mABTfkdqO/XuPtavnTL1lD3gD1VExUxtOgN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sW/IYPXJDvprDxSNSyHcD1aFwLo0VZLwmY8S6RNGf1w=; b=B
 NaOHSfy5ab5QRWcEduxAuSwypQpyaO7tYzRogg14UuKEycggj2RqPtsirbhb9/SdCETlEYbr80Syn
 JqexbpZHdV0ZsQmSjOlgAdcVD1EhoSSpYsBSaAxXssQdkP8WRgRwt5KnyOI+2kQStUKUy7M/w+vrE
 sinYSJIr0HE30tDU=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wumKH-0002t5-Bo for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:27:34 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-481412f1828so211345f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786692447; x=1787297247; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sW/IYPXJDvprDxSNSyHcD1aFwLo0VZLwmY8S6RNGf1w=;
 b=Q8hHtyXcQNeRDLJc7CaVS92zWiFRyP/lSH5mu3L+QZR4iHhlC0x091v8Nc3Q1UfDoI
 14VIp351hVH11pDC/M56mJ/hJ9Nx3iMZc2Q7m6O99NxZYjrKcdfa12Fe3IOFEy210rN8
 nQNh1DJBJwabAmJduUbk6w0dYNYo11Br6OoF9a/+W8BzoP+lPbnmWaDinIBurlejlngg
 hvN11mrljkh1zR5VwQGhSfToWRqf4XL4HNM/KzO1pKQrZBmt9Z5Oulumy0cSnQxcgg4x
 UywGf9vqKwIyzbzW3VgvRq8d0YeQyEEFA7N5AIGYBRJs9mSdLQ0sQ7y2c2Kxrjf0Q+OT
 MRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786692447; x=1787297247;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sW/IYPXJDvprDxSNSyHcD1aFwLo0VZLwmY8S6RNGf1w=;
 b=rJ6ynXooOp6Ag42BzCGpMIhgGRfSgtnmAxMIWbwW5c1AxRwd99UdTkUXvnP/V62rJq
 7wzPgyTWBhgdyaag/Wh8IsoT4GGp5ELnx5/SRt/S91zgclzdFoF8+Gv0CkldQCJ498o7
 PI8A68Syd9lkaVvPnh+aPu1HYl6nwRVJwxTghTKupsO2UNbGRkrh8zV9qKJh7hGV7vcA
 Cj4QvWATz1MoveEXZcgCOKfzCS3khIIs81dwwVCNKg19XegxDSDU8cP03+IDyp40V5AS
 sLh1hHP45okh+G22NZCSMSnJHH/7PC45XAkhSVF+5Pjvtv1BqWZDGPEcXh6e2XdP9Ejn
 6SEA==
X-Gm-Message-State: AOJu0YyKPU175v2KJuvaIrGBWcxjIMoopBZAefV+K/H37HB/uQhROEgM
 4ko4pKjK8czXSnTCfJrut7UzEP3h70qbcUqQpU+pfcS7TeJFIgPS3btV4NUpDSWiqftF6p6Nxh+
 HISZyDOJKBUruiKAchsvXMQlxgLsKRLYgDNdNNBv0HfjBkNUe1abQY1g07XE0o9qOpS/zxuNd1F
 GUmT4JTg==
X-Gm-Gg: AR+sD13UcAh1fMl9Bb2CrJaLz6VV6szdMXr216b9I/a1ZgugI7rBN2D7odcEGVonuV4
 cniCP9c1Lvi7gX4HDA+OW7SGGRAbNdjMr8atXP8fGzPGcin+UH6Yjs5ltKb+mClotptA0hn0Tu3
 JlvQgrwxtujHEyRUzoMUXCTXPxl+dXux9xW2gHemmYginsw5NrdrF1vDJb2LLMeWxPpBxhObGZl
 cts34Du8HxQHCotaWVSl96PIhHnb8wek5uDtPDU0VwhNkQviz6dWr2aslJX2arQ8tRYpvlFfN3J
 GABXUMG8Mmx3Ax0XhsXlxFe9J2mKRvPYbUv7Ah81Snv1USu+WQB1UgIa31TzL50njMCnbHJ8UN0
 qAfrZENtt22NWj8tCFuxVljEPLYfg0gipvXKddzP5PR/z9AnlOrzGcwOdSGrL60Sv6DcnrFwyJz
 C7eMe/SfFm2+rvBmHxAS/E/goEXNkJc/0Atb//l69Kqd9WLqPEaWW3vAtNhFqq/LRy2JKPCoHvV
 3ZdUwDQNKKtmPo7jWLNpPfQvkVHe/ph4Zu3I0r6Yc6j6+bmosDUpqmSJFyZGZjPR0ESM4bh6opx
 3rzSpR6/0MxgrAPWNw3aGzkv+EaU3ybNRBOqxcE51xuJD5vQ1so=
X-Received: by 2002:adf:e008:0:10b0:47f:8112:f793 with SMTP id
 ffacd0b85a97d-48160713d31mr3724754f8f.13.1786692447177; 
 Fri, 14 Aug 2026 00:27:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f21df13sm4900722f8f.15.2026.08.14.00.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 00:27:26 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 07:27:23 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie44556f5ece28b54cc657fa86261b827efb42467
X-Gerrit-Change-Number: 1779
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1779?usp=email>
X-Gerrit-Commit: a98cb76220351211b40ce21efd0fd68bb48d7e8b
In-Reply-To: <gerrit.1783961511000.Ie44556f5ece28b54cc657fa86261b827efb42467@gerrit.openvpn.net>
References: <gerrit.1783961511000.Ie44556f5ece28b54cc657fa86261b827efb42467@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkllNDQ1NTZmNWVjZTI4YjU0Y2M2NTdmYTg2MjYxYjgyN2VmYjQyNDY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <58e3a1e003500accd29cec7770bd0e575d999cc6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wumKH-0002t5-Bo
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8097346778902078755=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8097346778902078755==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="79xyNux4dz0="; charset=UTF-8

--79xyNux4dz0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1779?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: win32-util=2Eh: Fix includes
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

win32-util=2Eh: Fix includes=


This file includes various headers but then doesn't
use anything from the=
m=2E It does not include the header
(buffer=2Eh) it actually uses=2E

Chang=
e-Id: Ie44556f5ece28b54cc657fa86261b827efb42467
Signed-off-by: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1779
Message=
-Id: <20260813180927=2E3263-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38331=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/win3=
2-util=2Eh
1 file changed, 1 insertion(+), 5 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/79/1779/2

diff --git a=
/src/openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh
index 4849ea9=2E=
=2Efb83762 100644
--- a/src/openvpn/win32-util=2Eh
+++ b/src/openvpn/win32-=
util=2Eh
@@ -24,11 +24,7 @@
 #ifndef OPENVPN_WIN32_UTIL_H
 #define OPENVPN_=
WIN32_UTIL_H
 
-#include <winioctl=2Eh>
-
-#include "mtu=2Eh"
-#include "op=
envpn-msg=2Eh"
-#include "argv=2Eh"
+#include "buffer=2Eh"
 
 /* Convert a =
string from UTF-8 to UCS-2 */
 WCHAR *wide_string(const char *utf8, struct =
gc_arena *gc);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1779?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie=
44556f5ece28b54cc657fa86261b827efb42467
Gerrit-Change-Number: 1779
Gerrit-P=
atchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>

--79xyNux4dz0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1779?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">win32-util=2Eh: Fix incl=
udes<br><br>This file includes various headers but then doesn&#39;t<br>use =
anything from them=2E It does not include the header<br>(buffer=2Eh) it act=
ually uses=2E<br><br>Change-Id: Ie44556f5ece28b54cc657fa86261b827efb42467<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked=
-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1779<br>Message-Id: &lt;20260813180927=2E=
3263-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg38331=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/win32-=
util=2Eh<br>1 file changed, 1 insertion(+), 5 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/79/1779/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/win32-util=2Eh b/src/openvpn/wi=
n32-util=2Eh</span><br><span>index 4849ea9=2E=2Efb83762 100644</span><br><s=
pan>--- a/src/openvpn/win32-util=2Eh</span><br><span>+++ b/src/openvpn/win3=
2-util=2Eh</span><br><span>@@ -24,11 +24,7 @@</span><br><span> #ifndef OPEN=
VPN_WIN32_UTIL_H</span><br><span> #define OPENVPN_WIN32_UTIL_H</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;win=
ioctl=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;mtu=2Eh&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;openvpn=
-msg=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#includ=
e &quot;argv=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;buffer=2Eh&quot;</span><br><span> </span><br><span> /* Co=
nvert a string from UTF-8 to UCS-2 */</span><br><span> WCHAR *wide_string(c=
onst char *utf8, struct gc_arena *gc);</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1779?us=
p=3Demail">change 1779</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1779?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ie44556f5ece28b54cc657fa86261b827efb42467 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1779 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--79xyNux4dz0=--


--===============8097346778902078755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8097346778902078755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8097346778902078755==--

