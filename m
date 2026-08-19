Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4AAC5DF88
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=TjLK6YOG0z44EdiXZgWtVQbS5oIXhpn9Ib1imT3Mczs=; b=XUXlsZekvYWf4+
	7pj9tpXznqj0FuIb37otYPw4F+JX5DCpnACEcy9IDOXsu5VCf0btL6pDP+VFrJCNZxENIXlHJiSMl
	fXASHf95/NFRaTzitxcjn8Jz8Aphhca7+Si5ra9HoFJgp2RYmO75K9sIpVyC7KzFjFpwp1ukzARLR
	exw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wweh9-0001C0-KW;
	Wed, 19 Aug 2026 11:43:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wweh8-0001Bp-E6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:42:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rSHFOiRKsEgA0LczDRfXjpa3TtvmkHjZuSvO9E8YLtM=; b=LEjit2sUnYokKu1SX1w9Ye2f4D
 LJt5zxnTS+4vXojh7tYqVDuDzH7d/5xJKpHCab+reJPuWY7wu3S+K8iCnmGBKmAapz1Bw+lFiqJPP
 qM/zV0hNH8zPcDLwEY0+cbwW8R7paAolgdoflpAx9g029BAqy1tnnQyb3Ur8oDB3ciiM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rSHFOiRKsEgA0LczDRfXjpa3TtvmkHjZuSvO9E8YLtM=; b=V
 Gws+y0eDAPxd4tgDwlCQS/wxOHIuKeXE2EN64L+YJcG2VslcssRRBqGUWntAhmyQ0A/xQ0PuMmhED
 Q9qEJ3AlJYX0jhdVl3msqb6+8gjbAiMVYBHmaYjz6VqVtGd0q8aavwqvSOi8dFyra+cp3Rw/zuddK
 VX9+L2DTNp7A78Vk=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwehB-0006zn-1U for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:42:58 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so744747f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787139771; x=1787744571; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rSHFOiRKsEgA0LczDRfXjpa3TtvmkHjZuSvO9E8YLtM=;
 b=XGtOa+ruZ4NfNER9o7yrgom4mVd5vJhkkpCWIMhdiOiJNQbAU76wUQ8QabIkixNYeb
 7YNQBP8r8mMj3itEOhWdeXKdi0HlA5sgdtxV2lPKZxBsXWRmS4sPTBBhd1w6+k/pya7c
 GlwI213l6C+M9dK5EF70XE412Q5lZY2+NTEyGZGi1OmahByehSbfiOGzMrA9kGRcvqN8
 nPnE5KUC0GmNkK7HZR1qNkEc9QLIVMIqtCGFTW0HQxyA3eAsEx3MSI9gpRR5tpVp6aXx
 Ru+EA6QKi49x0AS+X6DyLSiA+6vI+/yK+im4X1j22jHEh/xukybgDyhu0DyyY8Y/4Xhz
 sZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787139771; x=1787744571;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rSHFOiRKsEgA0LczDRfXjpa3TtvmkHjZuSvO9E8YLtM=;
 b=tSTLSUlJ7QNbNo6TfJqnowcx1fGx/GcsekISzDMaW/VF9azPBHy1ManUfmW8cjVup0
 DEZKHP6EVH7GQp7PJvVAvXVf2C2iVsJaPJNE2uoHOUFT2yuBEvv+YFBO4tx9tJolExy1
 C3Uy3/qR/m5IEFfTeLb2paCUeWNOIiyUSGdHlX0TDNQwLB+aNgjIPYa7EqlABukl91kx
 pfdEZVL/lPgzDXUJ8gQGGEbLT8ly6iPdqOC/GNkLbmjuQXb6b9TTf1n6mIVIU+ShzLhS
 SWYV5VMjtGVMQUpZvTpUum53vrEusYJelZ96EOh0YMvnur4mqS7eCn8LeLfhImsQ5v+o
 C8BQ==
X-Gm-Message-State: AOJu0YzCqJvlczpZABFDUH6PEBgsRqfrgdtxh2fqltiuwwsyPYtA6oqU
 GnvR+mT5eDXYnKh/yYXfN9kvvxqwSAvIIXpCJe2qc9JXJ8E5J1lLmZy5WlPOLTb0TI3Qvz83uPl
 zC0Y6GUiOM29KyLBhNEIgA6Tz4YTt5W3U9NJaSRBx9pXu3ddWz08gGBBkvHYz/T5faseD
X-Gm-Gg: AR+sD11DKFoUHymVcF2PYn6TB/QBCCImHC4S3NaAOxcbBtWZPHFVJYZ0rFWl1TgzXO1
 Mqf/Sbu3/395fasGkIAcXgFJOEbwj3upCMgKXAwVxWO4hdRTlPJbMFgCjbV9i3mqgO2lA1X7XX8
 91x4CVQQAqDWTk7QAvdRJ4hzt1tNG6W8pI0B3i+dM3AWxJHYozrDiTLqRP4bQu093j7htL2unS4
 hENPQ5nJ/6uyGlmdqDYYZ34/cEp2ZXq5rvZeqiOm4TKB73eYVTXtQWcRoOx4YaEoCn+87S2++FC
 63CaPoQsirOlmUV+TSeUPDULWcmEEHTWOuvoFKzTz8FD8lVNNhwfz2A/GcwiejIGvgTb+nojNvN
 Bv0rRj4fP6JS3kI41Uuz04/CR7jJ2ma5IJreoJ6upqynlASc7qm1+rSj6CCHGnDiIMxht8dyGDs
 NGxhcmrxYQlT9snQFr8psJLacLXQ7Hm66cpc+q3OytFdghz5zpuTARwKKPIbudkbqBe80wJiNvB
 mE1A3AoS+RSjaLu1k2ss3gxKcchTa/veAhMl4XBRxQxJMaHwtYduUPQIwtXivWAz+SsqTtyOOF7
 /+d7XA/JnQTY+rQQQK9zGyCG6T3HTPWSUM3BFnPTfGo1fB3dINE=
X-Received: by 2002:a05:600c:34c6:b0:499:88b0:1726 with SMTP id
 5b1f17b1804b1-499aa14af18mr76512125e9.2.1787139770654; 
 Wed, 19 Aug 2026 04:42:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa11fd3asm49584395e9.8.2026.08.19.04.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 04:42:49 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 11:42:49 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
X-Gerrit-Change-Number: 1847
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1847?usp=email>
X-Gerrit-Commit: 532f87b9cc89ae14ead0d9cd9884792e704f9a49
References: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTM5NzU5MDAwLkkxMGI5MTJiYWQzYmIwYjk3ZTJiNDdlYWUyMGQyZGQ3ZmZiMGM2ODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b9303f1d4ba13269ac2a2d85eee874099045dbe0-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwehB-0006zn-1U
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 gen-release-tarballs.sh: Fix some shell issues
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
Content-Type: multipart/mixed; boundary="===============2291772184072808524=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2291772184072808524==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U/EeTqzVgQk="; charset=UTF-8

--U/EeTqzVgQk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1847?usp=3Demail

to review the following change=2E


Chang=
e subject: gen-release-tarballs=2Esh: Fix some shell issues
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

gen-release-tarballs=2Esh: F=
ix some shell issues

- Force bash, this script uses {gz,xz} style globs wh=
ich
  are a bashism=2E
- Change a `` with nested "" to $()=2E The current c=
ode
  is correct but shfmt would do this conversion wrong,
  so do it manua=
lly now=2E

Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Signed-off=
-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M dev-tools/gen-releas=
e-tarballs=2Esh
1 file changed, 2 insertions(+), 2 deletions(-)



  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/1847/1

diff =
--git a/dev-tools/gen-release-tarballs=2Esh b/dev-tools/gen-release-tarball=
s=2Esh
index 6071b57=2E=2E83bdc9e 100755
--- a/dev-tools/gen-release-tarbal=
ls=2Esh
+++ b/dev-tools/gen-release-tarballs=2Esh
@@ -1,4 +1,4 @@
-#!/bin/s=
h
+#!/bin/bash
 # gen-release-tarballs=2Esh  -  Generates release tarballs =
with signatures
 #
 # Copyright (C) 2017-2026 - David Sommerseth <davids@op=
envpn=2Enet>
@@ -70,7 +70,7 @@
 {
     local wildcard=3D"$1"
 
-    res=3D"=
`find =2E -maxdepth 1 -type f -name \"$wildcard\" | head -n1 | cut -d/ -f2-=
`"
+    res=3D"$(find =2E -maxdepth 1 -type f -name "$wildcard" | head -n1 =
| cut -d/ -f2-)"
     if [ $? -ne 0 ]; then
         echo "-- 'find' failed=
=2E"
         exit 5

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1847?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Gerrit-Change-Number: 1847
Gerr=
it-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>

--U/EeTqzVgQk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">gen-release-tarballs=2Esh: Fix some shell issues<br><br>- Force bash, =
this script uses {gz,xz} style globs which<br>  are a bashism=2E<br>- Chang=
e a `` with nested &quot;&quot; to $()=2E The current code<br>  is correct =
but shfmt would do this conversion wrong,<br>  so do it manually now=2E<br>=
<br>Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/gen=
-release-tarballs=2Esh<br>1 file changed, 2 insertions(+), 2 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/47/1847/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/dev-tools/gen-release-tarbal=
ls=2Esh b/dev-tools/gen-release-tarballs=2Esh</span><br><span>index 6071b57=
=2E=2E83bdc9e 100755</span><br><span>--- a/dev-tools/gen-release-tarballs=
=2Esh</span><br><span>+++ b/dev-tools/gen-release-tarballs=2Esh</span><br><=
span>@@ -1,4 +1,4 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
!/bin/sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/bash=
</span><br><span> # gen-release-tarballs=2Esh  -  Generates release tarball=
s with signatures</span><br><span> #</span><br><span> # Copyright (C) 2017-=
2026 - David Sommerseth &lt;davids@openvpn=2Enet&gt;</span><br><span>@@ -70=
,7 +70,7 @@</span><br><span> {</span><br><span>     local wildcard=3D&quot;=
$1&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    res=3D&quot;`find =2E -maxdepth 1 -type f -name \&quot;$wildcard\&=
quot; | head -n1 | cut -d/ -f2-`&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    res=3D&quot;$(find =2E -maxdepth 1 -type f -name &qu=
ot;$wildcard&quot; | head -n1 | cut -d/ -f2-)&quot;</span><br><span>     if=
 [ $? -ne 0 ]; then</span><br><span>         echo &quot;-- &#39;find&#39; f=
ailed=2E&quot;</span><br><span>         exit 5</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1847?usp=3Demail">change 1847</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1847?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newch=
ange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879 </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1847 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--U/EeTqzVgQk=--


--===============2291772184072808524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2291772184072808524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2291772184072808524==--

