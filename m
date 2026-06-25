Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2DECDB479
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=MHnsFQrUHwF0mJRUsJ0nVSuoee4np500IsvgdUuYZRs=; b=XHPpt2LLB9No+Q
	iKH9pcREK/1c5aJeCunfV6lmu8otYTLa/ZOO8BfkvF6PwM/c3K0ND5iAUDK8j+zcbjLVcmp+UUtBj
	PIW/5WbOUSzITe2w0r7ROuV/g+lDOYpc/gdswUEK/9K4VMfGGB0tWYRHPK5A1jFxRr9j/NxZUtMcl
	zDU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcjBy-0002hS-4f;
	Thu, 25 Jun 2026 12:28:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcjBv-0002hL-Uj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 12:28:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D+u4kwRPF8iM0pPhhTGLBvtVr5tgfI5XsXcPY3BATI4=; b=izpAL+gJUtu0zrjhxSb8YotWTE
 wF4Zw2+Zs+f7UAeElV1qaqGbvAqoEuGehTMPAGDEBYCjBvU06OenJfnc6iRo0GScKdOzmOXJpWn51
 DuGeN55hX1oVGQjogMcqYwTnCWPLt+JfkHRdp7GNxT/W9tII9aXYzdwpZAPvJqu+s5tc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D+u4kwRPF8iM0pPhhTGLBvtVr5tgfI5XsXcPY3BATI4=; b=U
 qTa9TUWv/sVFQRb569f4a59bi+MSt+zoY1+bLlgX0/wuySWqMyyycg5p6SYUawS66Mrzzu34edUeB
 e2u63gUrmoymAJ/P96NivDy8H2WJDiAiKtE5uzCLUP56SQRoKj/k9QhGu7SXYXVT8EVPm0Laf/0Le
 +Vq9BnCmP/jKqK2w=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcjBr-0006O5-Cz for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 12:28:21 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so21466765e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 05:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782390488; x=1782995288; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+u4kwRPF8iM0pPhhTGLBvtVr5tgfI5XsXcPY3BATI4=;
 b=QpL+naarIA+STuHnzv6/+MazRRa+BvWbINoVf6qO9piThW+TIqY7ZW5y1IUZt5k5sC
 z1ApwQWgOnUdbJabP3+9fZPbjoyb1+f/Ltu2RPyuwpDSuyOroR90F+Ow0gj0jnWlL5Ki
 3LPNXhlKJaHYistQxPNB5X6XnjC4/y+zYpnasjWl5zNajR4gCD9PjLOAZhVj+DC1lv0S
 XblOYX0OwmFjk2fTn/BvSv/9qbX5NXWbcr2g9S3hMcEeZLAUkf9HBQBZbstttQiHzkLG
 S/ZLN7nuqx4/jaVeuzFhdis37UpPSVzAwt+EV8lsiab3EcXM+bexqBnBzTqICvgSX1cF
 CiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782390488; x=1782995288;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D+u4kwRPF8iM0pPhhTGLBvtVr5tgfI5XsXcPY3BATI4=;
 b=sM/P/tPN1Vi/xm6bnsNlbZsL/A0HS4gwys5LM0bD5yBOAUzVVlH2DIKxvV0iLj1p1f
 nRLMMT4YdSS99/OsIzljx1cMVYjATJmNBZIbPvzCrhKDo6QWJQvOvb3AqL6p1lDbFeBE
 COgGebuOqUpd5FeiDVX9k9iML3dqAYt3mFFNAGDHMO5Zg0D4+GStwjRl4fYv1RkIOtnh
 tx3jeZbmJSZBt/PPP2XxwcDMCd+EBa7eyA9gKsjZIvYka16+QxffnNBQCxnI65u8Gy5Y
 QU3aGKACF942t0Xu/Kq8kD8BYf/wHD7dcMpudYaSzlfskXNJ0PwCr7OvYoMENYZdzEa1
 IdEw==
X-Gm-Message-State: AOJu0YxJwmkjWTW6x9gK7YDEmMDS2MDTmMQgAgLnMmQOzzXtEyUJgGwJ
 OsIJh2vxQXKDI+tOiKYa5e23/EKzpdED1gd3ikywNGn5yHbgo+zp06kC07ZfWVdkOsma4kgMnfk
 a+N+vbHexodCXhfH9ZeaQW/iF4z1Vpx93/djRcoCiM0aaF7s6GPPbDpqah8EHicsDp0+JRRIzYu
 mNUDdgjA==
X-Gm-Gg: AfdE7cmy7qEAoWd+PglhdLKUWOmoJLpHpmSWKotBL+tYP0hQ1O03YAJHtC1GFu8V3vS
 v7VJz5LOMXWodmgwiaiLs0l3YE7VL2O5EggYxpzEe1xQIja5BmRmMtF6Cdj9Hm4k9VPMIlc3W1M
 YS2P868jV4JVPfGtrj3q2yDlKmIL0NwQ4iK/j7mZx+gnbblN1F4ej48TNtRcFAXGOZjNY1/gK6m
 EfCT+rynDV4haG+LnFHbhEPIQx8IanuTvjGpfPPUXLGquMzyIVwHw/zXyA4G0yETJ42B1Ml8abW
 iJfji0R4sIv94GO0DBh99aMYKQaePX0hsYrLMEhYWJqKnX/w94SmVXGcc6MUhjylN+zNtPe/+Yf
 LZERb1d8wRP77FtHPcpCS3XZG+XbZ/IgAKgn5gy/weKIhkCipEifPMyI4j+fxwn6uPV6ouohLtC
 dEBBUHK0gIvz5Sum1QPYBxS8YxCjWy/vPSOYRyekUzI8Qv/I4/vDkfxS+Rmd6dPJedMMV3sxkfR
 JIkt7aBU9d4XcXcXGVLyAwCtxOdzCVJ9clwbRmG48Y9j2pGsPl4aEqEQkOlZ6BcJTmc9WSXIROE
 7SI=
X-Received: by 2002:a05:600c:c0d2:20b0:492:5855:1548 with SMTP id
 5b1f17b1804b1-492668933b1mr25873355e9.27.1782390487425; 
 Thu, 25 Jun 2026 05:28:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492660e9eecsm52876845e9.10.2026.06.25.05.28.06
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 05:28:07 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 12:28:06 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517
X-Gerrit-Change-Number: 1731
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1731?usp=email>
X-Gerrit-Commit: 62e3dd04c20c2c5e0ddfee0599ad6bf0fef9d502
References: <gerrit.1782390484000.I96d3698601bb5aac3a0d7ac6ac5b5dd23c975517@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMzkwNDg0MDAwLkk5NmQzNjk4NjAxYmI1YWFjM2EwZDdhYzZhYzViNWRkMjNjOTc1NTE3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5a4c8eb6966826b2caa722ffce280c3da0aea9a7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcjBr-0006O5-Cz
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Silence warning
 with gcc 15 and O0/01
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7938943143653724631=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7938943143653724631==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u3Dx3lyNOWs="; charset=UTF-8

--u3Dx3lyNOWs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1731?usp=3Demail )


Change subject: Silence warning wit=
h gcc 15 and O0/01
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Silence warning with gcc 15 and O0/01

When compiling with low opti=
misation level gcc complains

   route=2Ec:1783:44: error: conversion from =
=E2=80=98int=E2=80=99 to =E2=80=98uint8_t=E2=80=99 {aka =E2=80=98unsigned c=
har=E2=80=99} may change value [-Werror=3Dconversion]
    1783 |           =
  r6->network=2Es6_addr[byte--] &=3D (0xff << bits_to_clear);

With higher =
it apparently detects that this is cannot be and does not
trigger the warni=
ng=2E Explicitly cast to uint8_t to silence this warning

Change-Id: I96d36=
98601bb5aac3a0d7ac6ac5b5dd23c975517
Signed-off-by: Arne Schwabe <arne@rfc25=
49=2Eorg>
---
M src/openvpn/route=2Ec
1 file changed, 1 insertion(+), 1 del=
etion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/31/1731/1

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
i=
ndex 81ce867=2E=2E8ea745d 100644
--- a/src/openvpn/route=2Ec
+++ b/src/open=
vpn/route=2Ec
@@ -1780,7 +1780,7 @@
         }
         else
         {
-  =
          r6->network=2Es6_addr[byte--] &=3D (0xff << bits_to_clear);
+    =
        r6->network=2Es6_addr[byte--] &=3D (uint8_t)(0xff << bits_to_clear)=
;
             bits_to_clear =3D 0;
         }
     }

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1731?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c97551=
7
Gerrit-Change-Number: 1731
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--u3Dx3lyNOWs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1731?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Silence warning with gcc 15 and O0/01<br><br>When compiling with l=
ow optimisation level gcc complains<br><br>   route=2Ec:1783:44: error: con=
version from =E2=80=98int=E2=80=99 to =E2=80=98uint8_t=E2=80=99 {aka =E2=80=
=98unsigned char=E2=80=99} may change value [-Werror=3Dconversion]<br>    1=
783 |             r6-&gt;network=2Es6_addr[byte--] &amp;=3D (0xff &lt;&lt; =
bits_to_clear);<br><br>With higher it apparently detects that this is canno=
t be and does not<br>trigger the warning=2E Explicitly cast to uint8_t to s=
ilence this warning<br><br>Change-Id: I96d3698601bb5aac3a0d7ac6ac5b5dd23c97=
5517<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M =
src/openvpn/route=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/31/1731/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/ope=
nvpn/route=2Ec</span><br><span>index 81ce867=2E=2E8ea745d 100644</span><br>=
<span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=
=2Ec</span><br><span>@@ -1780,7 +1780,7 @@</span><br><span>         }</span=
><br><span>         else</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            r6-&gt;network=2Es6_addr[byte--=
] &amp;=3D (0xff &lt;&lt; bits_to_clear);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            r6-&gt;network=2Es6_addr[byte--] &amp;=3D=
 (uint8_t)(0xff &lt;&lt; bits_to_clear);</span><br><span>             bits_=
to_clear =3D 0;</span><br><span>         }</span><br><span>     }</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1731?usp=3Demail">change 1731</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1731?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I96d3698601bb5aac3a0d7ac6ac5=
b5dd23c975517 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 173=
1 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--u3Dx3lyNOWs=--


--===============7938943143653724631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7938943143653724631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7938943143653724631==--

