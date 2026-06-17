Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E556CD98E2
	for <openvpn-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B2ByHIsUGElyfAtao3TVfJHGER7973S4bWThP7h35wA=; b=YbCIabKKRwuqqVLWr2gm9P4kgv
	Zc9gokswovnrUMrOiKFG8E/jRBAFnYLtZal+JcmIeNwGDRBBmmzaA4cGLg/gsMQn9N1qIcdjfjKTN
	D140YQ+cSBDsdCxjDH8hP7naQZymyvtevtWfhNl83Sj1xpLVfOOCXJVjJAhvJO3uO+4w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZtMn-0000cJ-3i;
	Wed, 17 Jun 2026 16:43:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZtMl-0000cB-0n
 for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 16:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=a2sKvc6sHLZwyuFcLdTgIIMdl2709ZHhwKXD9hY2tFw=; b=XyMnEqDETasjnuniDC4Z/SsCRB
 ZkJMgYbWFg532ITvxF2cKnHD+L010RLHXmlqHl5veh7lMFPcRR9HxTIx11FQvLmnxszEZ3ZCEp3cO
 sRLbzBOgPNgVgWh47Wx49SZf/WMb+xpaqTRxpNaOX4rS63N2t8kHHEER+zq3dJ8NlZaU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=a2sKvc6sHLZwyuFcLdTgIIMdl2709ZHhwKXD9hY2tFw=; b=Z
 j6sCT8Gck10+nIUi6nGiXOWrF58EuwDqeM3Gz8aY2b7pzE8sw8QpKv/z/ESekXDS12X4rTsLDLdQq
 1hSN14P49U+zPpdvFijKh/PoDczRibi1cTXANxEFdDEamOz+fRn29yzS7NPpGgTLD7ScOFmPgsQf5
 O6miGla3iXQmn1K4=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZtMg-0006yd-KT for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 16:43:48 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490c1915793so49604215e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781714620; x=1782319420; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a2sKvc6sHLZwyuFcLdTgIIMdl2709ZHhwKXD9hY2tFw=;
 b=R5+sUTrn81btKkrihvssP6SVUZR+uEkIfDvAhuH7n4eVvOpa6iMzbkkhr83jfD4b7a
 rkBCG+TEOI/nkzGnFzq2hAPMO3kveCJMXGQP82iNkx4392pznj2BHOfTKrb9aCYY8WmR
 5ra6Z0o9XEXTvkm+V8WFxDgb9s2Lle1CbfnMztt8t0DHXVJr8aDyaCp2tYnYtDul1hCR
 6KMG+jl2Evqg3dRzfGBxZpadKLI/HbHQo7fW3g7hroUKGckrBa94RI11xvNtEgP1obX1
 bwKPW3emgIpM/UFBornD0OkCAANzR2gWrTz4pLIvWiiyebdpSTp79Yg8xThRBPAsj+aS
 5YtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781714620; x=1782319420;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a2sKvc6sHLZwyuFcLdTgIIMdl2709ZHhwKXD9hY2tFw=;
 b=YMG2YHVVRjDLRb/ASP7koBPo/vL8VFBFMGDdpiqt0I9hmhAAXh/aWcYxA010IPCf9c
 NkfiVqQ6WFHdXpQ9uHlxiGygkGZ5cGUuEkH7yALaM7qyYb2OCmJSU97RjGbCyzUtFquq
 UQWHgsxAM/VIxDU8OdKI2K0n2O9bvzHCgYJSWatG+42uwq1fgLu7hbQlua+KM56rrG53
 LPqvKVCDse1qZLqztn3SMwWxVStStLonps6nH3Pbb8tBj5Y6sTSMjbLckfwbY0P6Guo7
 4rB2jCuKM4y79vdYAk79z/dYj2OoXRmz+F3rM+mq8d5dl5B9CXjIcssoR1+9fRne/MYo
 Iqrw==
X-Gm-Message-State: AOJu0YxKB3jXE48ZT70Xm8vRzGxPswqBdYETIgxcGAdWlCOUuFuPxFr4
 p6Ky8/CvtpXKd8N1ICuD5fI3uAP7hJyzGR3ZrDx6dCl3nK2C4PxgnD3sDdepMC3nxFRpl09FBtf
 jXQp0w1hCrQMRWIR8tHLbz6DBfJeTfx+RS84QtKYK8fNPVdiChhpdMkWPLh+nrkdpt7Bf
X-Gm-Gg: Acq92OGCZU99ZPImuCKF/Ip7wcBk2cCAR/y50fxFueRdNJdZerSlZjOpdZVAitcUEA8
 237zKNy0wYb9ZKTvkUuUIjbeF7lFnY0/olz62fE+HCyjpOuvvjD9ljSNeF/1D7xTqgZmMmQRECi
 HldpbULFMe3c1fMN4tKqQDX/uSSgWAmz3OqXJpNIysyUCvKNoeErdPYGwH/2sNTqK4wimTze4p5
 46xUJy+FN8vOJwInWiimr2HUf+aHLxnfMOj0nrul+3bxBI1kWu0lu6RzST5yXRKwQPuMRvvPWqG
 IJumal9sd3b3SEL80srjW+a69fMdDU6XdWCt6wRZfoZ9CnS9+OBeDF6uRhRpqW1dNMtQmqnQ7u5
 dPWQEnBkItTbwPkQtOW14tk/xuWdgp0eeZVPD+CEi/2ZuigdWduJqF+C/RlVJQRp5n0s1fMYAuk
 +VrVjQUarPeomAISLuDkYfDY50lAoe+6m/SRSepUEur52JJ8R188hzFoipGVLs8i8qCyJ7c+XW2
 +dsTR1qxFu2mvUcBaCiDXJJiuGj+Xlpdp3XMlbCmDsk/kg+O47LEUJBjIafuK08d0hRx49Z5IW9
 HaY=
X-Received: by 2002:a05:600d:644d:20b0:490:9ea0:c11f with SMTP id
 5b1f17b1804b1-49234100b3bmr53451255e9.5.1781714620376; 
 Wed, 17 Jun 2026 09:43:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4601esm190175495e9.1.2026.06.17.09.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 09:43:39 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 17 Jun 2026 16:43:38 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
X-Gerrit-Change-Number: 1712
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1712?usp=email>
X-Gerrit-Commit: 98434caa86b9fbee586d14b65c82cf0274661155
In-Reply-To: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
References: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE0NTMzMDAwLkk3ZWMzMThjODZhZjk5NDI4NGQxYzYyNzJlM2JiZTJiMWVkZTE2MGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <42ad9586b5061c3e58cfb73c11077f6d726d6185-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZtMg-0006yd-KT
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: Fix memory
 leak in dns_server_addr_parse
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1171282697846689596=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1171282697846689596==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YRvdn+7X73k="; charset=UTF-8

--YRvdn+7X73k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1712?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: dns: Fix memory leak in dns_server_addr_parse
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dns: Fix memory leak in d=
ns_server_addr_parse

When the DNS server's address count is already full (=
exceeds the
limit of 8), the function returned early without freeing the
su=
ccessfully resolved addrinfo struct=2E Fix this by checking the
limit befor=
e executing the DNS lookup=2E

Github: OpenVPN/openvpn#1055
Change-Id: I7ec=
318c86af994284d1c6272e3bbe2b1ede160fd
Signed-off-by: saddamr3e <saddamr3e@g=
mail=2Ecom>
---
M src/openvpn/dns=2Ec
1 file changed, 3 insertions(+), 3 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/12/1712/2

diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
inde=
x 954ed52=2E=2E1465cdf 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/d=
ns=2Ec
@@ -114,13 +114,13 @@
         addr =3D addrcopy;
     }
 
-    stru=
ct addrinfo *ai =3D NULL;
-    if (openvpn_getaddrinfo(0, addr, NULL, 0, NU=
LL, af, &ai) !=3D 0)
+    if (server->addr_count >=3D SIZE(server->addr))
 =
    {
         return false;
     }
 
-    if (server->addr_count >=3D SIZE=
(server->addr))
+    struct addrinfo *ai =3D NULL;
+    if (openvpn_getaddr=
info(0, addr, NULL, 0, NULL, af, &ai) !=3D 0)
     {
         return false;=

     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7ec318c8=
6af994284d1c6272e3bbe2b1ede160fd
Gerrit-Change-Number: 1712
Gerrit-PatchSet=
: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2E=
org>

--YRvdn+7X73k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1712?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">dns: Fix =
memory leak in dns_server_addr_parse<br><br>When the DNS server&#39;s addre=
ss count is already full (exceeds the<br>limit of 8), the function returned=
 early without freeing the<br>successfully resolved addrinfo struct=2E Fix =
this by checking the<br>limit before executing the DNS lookup=2E<br><br>Git=
hub: OpenVPN/openvpn#1055<br>Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ed=
e160fd<br>Signed-off-by: saddamr3e &lt;saddamr3e@gmail=2Ecom&gt;<br>---<br>=
M src/openvpn/dns=2Ec<br>1 file changed, 3 insertions(+), 3 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/12/1712/2</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dns=2Ec b/src/ope=
nvpn/dns=2Ec</span><br><span>index 954ed52=2E=2E1465cdf 100644</span><br><s=
pan>--- a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</sp=
an><br><span>@@ -114,13 +114,13 @@</span><br><span>         addr =3D addrco=
py;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct addrinfo *ai =3D NULL;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (openvpn_getaddrinfo(0, addr, NUL=
L, 0, NULL, af, &amp;ai) !=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (server-&gt;addr_count &gt;=3D SIZE(server-&gt;addr))</=
span><br><span>     {</span><br><span>         return false;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (server-&gt;addr_count &gt;=3D SIZE(server-&gt;addr))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *ai =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (openvpn=
_getaddrinfo(0, addr, NULL, 0, NULL, af, &amp;ai) !=3D 0)</span><br><span> =
    {</span><br><span>         return false;</span><br><span>     }</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1712?usp=3Demail">change 1712</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I7ec318c86af994284d1c627=
2e3bbe2b1ede160fd </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1712 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--YRvdn+7X73k=--


--===============1171282697846689596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1171282697846689596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1171282697846689596==--

