Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E98AC44507
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=MRHpGvYZtuCDNTToDwnUPO0NKqsD5x0vBj4hZ8aM0nY=; b=Hv7ssrtrLLE7xC
	AnMd44S/XWQ+9PjYMURbmQeZEAGViUfLI2mr7NMrIVhZ9BbSYB7qyMshdH4RZ7rPM9vvM8OPaR/3u
	9Q4/Du1QYkekHk49QIYF0ZIbtch8/6E2rldMvFME01T3CWERfUG1P3cMqsbpnlxdg0Jt9YIyjfg4y
	Rb8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjJtA-00064c-T1;
	Mon, 13 Jul 2026 16:52:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjJt3-00064S-Dm
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 16:52:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+I0XRAE7SVbNIBfmX1+pMCWakAiOcfjnIDiSyICQxFE=; b=cN+WHzsA9q+xN8btGXtStX7pNc
 4/w3bt/o9zT/XggVt1EzP7k38VAykJXILwW9gVUHrcXDxTKzyaWSiofUan5nsjwGmsWY64+s9gfu6
 CWfv35lbDwwW1XApEbji08YcoBU59KTGCqZu5P38gRDHHtfGNaUJP/h8Nr4mIGMaYcv0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+I0XRAE7SVbNIBfmX1+pMCWakAiOcfjnIDiSyICQxFE=; b=R
 Ljpr9siy1lp42sAqNBvo9Kfg/sAebTa3NESlDq8RXcK1b/Go/PomO9vGSbhIGvSKjOofJRFiSAYpJ
 to79h2zI3rfsh0YRZeTR8CqME3uELZy7Y4JeEMsEXRbkmw5Wg7F3Sjr0cpWkRj78GkM0RcBtGnMgu
 Z52PuQQZUtAgyF+E=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjJsx-0007Mg-Ur for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 16:52:06 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so1832993f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783961517; x=1784566317; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+I0XRAE7SVbNIBfmX1+pMCWakAiOcfjnIDiSyICQxFE=;
 b=BsZQhfhDYKTNkm2FoclMb/p9rJ9VDbOl3Xt9+JZ1xMTEEbUQpeHHgepY+Sf2DHU3G4
 Kci4YOgLA5yAUunfSL/nRLyFT3RlQlEkeO16f75frz7enwyY2yaop3riqA9rxkOT1Gv6
 YGBGTPBEdwKzZS23sIDwwBVygJGtR+wrf/4Bibpf2/QaGG6F503SuJ2v6npdKGWbfhrg
 NFuSwCAUgzEEZKk3uVP0zKEIhQd7jdJIZukxfBltubsTjPMInOmuidaS7eBG804o8gnc
 dUa6Y3Z7GZEy35rpIP7Xur6U/wH8sZFTwBSVzNmF8kIAKGYEpZK3Xm/gv79Gq/PVNrvB
 8HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783961517; x=1784566317;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+I0XRAE7SVbNIBfmX1+pMCWakAiOcfjnIDiSyICQxFE=;
 b=rs+DB9alBAlCgmrphfWyl0x94p9jYTmLVPI6Xq+fUg/zRAWPhUcKB+DpprJMklsBXM
 YX2TmX3uTBG0tmMuO+D6KUQOT5y6fe4qceXR1bG/DO/rJcAtdb+jNPtCKcO1E3d916r8
 IHSzrNGmmEKLBfxuruZZQVLt1CCTsFuEf/c6IENblR9cm1QyH+URJpIEqXDJZ3WEXsOE
 KErEoJxYVav0G7uWD1g1ioFMZnx07nrDvqlBhSspf+tXKvGmTGIpHMYmCdg3tTVGK1QY
 qk5eQsxYlVVa/adH9LGmzMTXeW4V762mzCT009FDaaGKnyWkKRblh3Ghftf5is9B8RA3
 HRnA==
X-Gm-Message-State: AOJu0YwsG73a788zW8/3O/TatJuXqDZsyNwd5CGgdBGsNBoORgU5VtRz
 yoL8eMi/4VlvvsE/ag40fnMzYaRUjXQzR2KBdFVKxNz9RWfoMjfzyUcP6PhwmwP2x+vJ8e/b4YP
 4lKylX9J5etz4SK08PyhlTz/Af1O1J5k/1ijB4ixQsGxXw5x2aYNqCd11SsG5ZPaGHMiiTiJE/5
 0nhAbs5g==
X-Gm-Gg: AfdE7clS+wHV4N0IzOhb/iOmCGVQbcoYF5e86W2BSZkJltDh5A/RY8AsH0ElL0CHW/1
 3UJ7CgTvo9Xj31fClrYE41VNL+LWdOBsQ8R1UH7BSgDdHG1XUXptrQybhcC4sJL9LmZl8+5NQ2d
 A+QpvV1HpJE19bkivwYqEiuzy/JEv/VQLx/GW69cMUCkuYIT9Ubh84NdlhCuzj4z2U5y9Djbpqp
 BxgeeVYLtUT4XdZm3A5YHgEM8+lE//A96GJp+Y59gnoZP1nWhABhjhMGsQA1MDFDThfBqGT9MtL
 X15P7UBFKSE5BtYFzrSipgmYdNBvygoze8Qeplwv/OO1sEz4c/9F3WWBAk0/4rm2elhzPUi846m
 qb0NJtai4LWp5mZHaCCeH+/iim7kuRZ6XzsLqlyCeeYAXPCzHc6eUX2kEngbsyUnbKLnQwCz2Js
 pMOkYBK50J6JHXHj4zMsMEeP384fB0X4Dwl7wxOzHo3v9q09i5c+725P2e7e/UqTOhcQ2jzWN7a
 4IiDwsjgz+NET/PCS4YMLajxyDZgAl8ZCZvRsSUJ4PsGzwkC1aN76PCulidQJ6AwPromtJp1sPK
 lh0=
X-Received: by 2002:a5d:5e06:0:b0:477:6da:1b8f with SMTP id
 ffacd0b85a97d-47f2dcc6db9mr10798811f8f.34.1783961517205; 
 Mon, 13 Jul 2026 09:51:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464b7f84sm645652f8f.27.2026.07.13.09.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:51:56 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 13 Jul 2026 16:51:55 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie44556f5ece28b54cc657fa86261b827efb42467
X-Gerrit-Change-Number: 1779
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1779?usp=email>
X-Gerrit-Commit: 443f4ad5c5f9b5665df10ec64bf11e3d630f2440
References: <gerrit.1783961511000.Ie44556f5ece28b54cc657fa86261b827efb42467@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkllNDQ1NTZmNWVjZTI4YjU0Y2M2NTdmYTg2MjYxYjgyN2VmYjQyNDY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21461ed0e27fe9f9a3649645e183a066533cd3c3-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjJsx-0007Mg-Ur
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6453831434267593051=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6453831434267593051==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q9FaHhyTSHA="; charset=UTF-8

--q9FaHhyTSHA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1779?usp=3Demail

to review the following change=2E


Chang=
e subject: win32-util=2Eh: Fix includes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

win32-util=2Eh: Fix includes

This file includ=
es various headers but then doesn't
use anything from them=2E It does not i=
nclude the header
(buffer=2Eh) it actually uses=2E

Change-Id: Ie44556f5ece=
28b54cc657fa86261b827efb42467
Signed-off-by: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
---
M src/openvpn/win32-util=2Eh
1 file changed, 1 insertion(=
+), 5 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/79/1779/1

diff --git a/src/openvpn/win32-util=2Eh b/src/open=
vpn/win32-util=2Eh
index 4849ea9=2E=2Efb83762 100644
--- a/src/openvpn/win3=
2-util=2Eh
+++ b/src/openvpn/win32-util=2Eh
@@ -24,11 +24,7 @@
 #ifndef OPE=
NVPN_WIN32_UTIL_H
 #define OPENVPN_WIN32_UTIL_H
 
-#include <winioctl=2Eh>
=
-
-#include "mtu=2Eh"
-#include "openvpn-msg=2Eh"
-#include "argv=2Eh"
+#in=
clude "buffer=2Eh"
 
 /* Convert a string from UTF-8 to UCS-2 */
 WCHAR *wi=
de_string(const char *utf8, struct gc_arena *gc);

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1779?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ie44556f5ece28b54cc657fa86261b827efb42467
Ge=
rrit-Change-Number: 1779
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--q9FaHhyTSHA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1779?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">win32-util=2Eh: Fix includes<br><br>This file includes various headers=
 but then doesn&#39;t<br>use anything from them=2E It does not include the =
header<br>(buffer=2Eh) it actually uses=2E<br><br>Change-Id: Ie44556f5ece28=
b54cc657fa86261b827efb42467<br>Signed-off-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/win32-util=2Eh<br>1 file chang=
ed, 1 insertion(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/79/1779/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh</span><br><=
span>index 4849ea9=2E=2Efb83762 100644</span><br><span>--- a/src/openvpn/wi=
n32-util=2Eh</span><br><span>+++ b/src/openvpn/win32-util=2Eh</span><br><sp=
an>@@ -24,11 +24,7 @@</span><br><span> #ifndef OPENVPN_WIN32_UTIL_H</span><=
br><span> #define OPENVPN_WIN32_UTIL_H</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#include &lt;winioctl=2Eh&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#include &quot;mtu=2Eh&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#include &quot;openvpn-msg=2Eh&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;argv=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=
=2Eh&quot;</span><br><span> </span><br><span> /* Convert a string from UTF-=
8 to UCS-2 */</span><br><span> WCHAR *wide_string(const char *utf8, struct =
gc_arena *gc);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1779?usp=3Demail">change 1779=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1779?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie4=
4556f5ece28b54cc657fa86261b827efb42467 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 1779 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--q9FaHhyTSHA=--


--===============6453831434267593051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6453831434267593051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6453831434267593051==--

