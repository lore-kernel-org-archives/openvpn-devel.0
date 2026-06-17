Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFD4CD98F2
	for <openvpn-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=EFpO/Gj+ppgJG4Ue5rvSbPdP9dp7qoChMb6FYstQhX8=; b=hmNTar2ksvk5VH
	ylDbgv6B8poxSMqi1zqF/rRQZErCNDNDTuuxIUVzt46v5gT6q0jnIX304p59X8wrdlkWWPi9vunhq
	Uu8Ogqnggygs2aFxEwwDv6nw3ufNlrul7AAPcqZGXBcxx64pcQ2GEUA9l5/rA4K9TjqnvDB4EkYrd
	e+s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZtLX-0006R3-3U;
	Wed, 17 Jun 2026 16:42:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZtLV-0006Qp-L2
 for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 16:42:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zM1ysZUqUa7nol6DyArR0RY+N53h6r1jTc5uSJjUS6g=; b=FBtduVd3MvJO42BalT5nwfX+6t
 bRb26qjT6v7EA4Vf3rgfEJI/mrZXtdrjAy7r9oWjzdD1VV7PbrxfiuuwKaUs3L+ub/vHmSpYNlWyu
 kk+MYaz2AOwM6uEAko0gT3u/IDlhx7Ql+b2nvsAT1eLkFCOTH6ivlJfONI+zB/BTRw9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zM1ysZUqUa7nol6DyArR0RY+N53h6r1jTc5uSJjUS6g=; b=M
 6g9DZMvEJ3S1HRHDy1yKA3tIJruildR+O1pD19cwRGJD1vVZeKyMAbx7WOPT/a/WmmO2Ilb4y2aWo
 m9bU+VsiKf7iNJmSVcZAmWHxeEvu0tYsu0acAeWWepOXu+850FNRa5PCeL9SqjfzCGUEJB7YbRfAD
 CI6fEijWcej1GUQk=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZtLT-0006pg-Ry for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 16:42:34 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-460166910e6so13021f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781714541; x=1782319341; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zM1ysZUqUa7nol6DyArR0RY+N53h6r1jTc5uSJjUS6g=;
 b=UKSXM0pRm4xQl5+piETcq4PX1tFmaepQxeJazjl7DY7ShL75ZirIagATfSYouJs4eo
 peI0GoXK8nsfmFC5g929jqTdAG7N1XDqjCIwaTDe68l1GgBYU/KbKqkoJI3NgCvLXKXr
 nCQZfRSw719sriud2MCE9rwnVmGqvGUDXfJhGMk12d7lbGEnHcbPZX4OMpPIqA+LZWAT
 WScBr+jzJe/cAgaR5GDt3B1kjsw1rxs+1Ccle/SGQ7AVg9zRahQZawqFHAsDZTPIMhFW
 6uSJCvVvLsYs7PsFF+XgwBiJ0VTcTHy2YdgVtA6mBUa206IePpq9j/ws+XlOOVCZwzRS
 LmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781714541; x=1782319341;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zM1ysZUqUa7nol6DyArR0RY+N53h6r1jTc5uSJjUS6g=;
 b=W3o2oN/d2N6wKXWcc+2PK+wtFSjHM92O5jyip2QcR+HRNDyxRDtXtMtjg5v+FdSxN3
 4KymNHY0T9JjSb6r2i6zC1ghdJy3aV/Yn5dR2hMJhENKk0lWARYvkPJbIZAEd21zY2B+
 Mh46DNnuhw8KWCYANW6TBa1E/imkK8Zz0sqoETY1QoM6Vr0rdRC6tZaivhG3kgzAkcWm
 uZXfJgVlgNdXeOWi8AxT8nA6zaf4Ugvpbti124ej1uCOLYc7g2Z+PSewCZZl2Ha/Sgjz
 Ig9a1yyu4OvWLl4t+EfkQL6ArqJEfTcR9JwTjlgxkk89uqW8hBS5mlE5QUIynKEjuik8
 rUBA==
X-Gm-Message-State: AOJu0YwEGfTartVlDkNX/sVEqJ0l4YW647tcaHXo5XF8TyA7pdraafZK
 UJG2aPmUAHqGIAvUAzl/KFA1QoJEkXsBkY1rsdEQ9AULh6q3aNAfc74orJy9N72JD/i/OKIkMyH
 /7YUL3EQhkws8IpXFa9MGi/ziGb7q93VUZ585InZFUMbp8X6GdhE8cc7d8tY3MMnUaAi+7C1Dgt
 APL9mORQ==
X-Gm-Gg: AfdE7cldaPqU3xbYXu2iVM2y/hmrklUOULZfSWpS1iPDu98fFjx9mPdsCg3KunhADo3
 VBufmmYmLfP8Yds1MkUUExVseCqTWLv5pffpGhd9tuO/Xi/WJ0b1lRBXOkGiXTgTiAjBXnrQ7uE
 3+COA7L/84bNc83oCsGT3vOOP+MVQoJNn/S/41/o1ish6jPiY0QsjFVOfMcUox+yVWpDq5vHWJB
 tno7Ne489TyoRdH4KwLi6OsX4hJZzTWlQrG+/b5OEF6ZOmxNwETTE2BinfQDt/kmnU3rawXuqsM
 SM/8EF9tQ49kcqrfTBITOZGuzMopNPZKP2oBUEiJyGLptrQAfoECqAaGmlsUNFUWGxVyv2Q7Ltu
 dI3J6YSVWazw5i9EPtX+KUV26MZGOOrgH6eLXQAuqzR3GddDUerz/C5eYFzinhLpvkj/DbIlXlN
 Fr1SbmqAknV+lN0GkYUuhxVg4sTmf+DcRJacVWmzANdEfYw6lYAuVPl2ylAfUzV16T+yNAwJnum
 YK18/KDj6nnEZqvM3hJ0gisyR/Czy5mdmhE2auN2e84VyHv7STCgBHkgv82y/LF2pqlcsb4SWhA
 tx4=
X-Received: by 2002:a05:6000:1889:b0:45e:f31a:7ae6 with SMTP id
 ffacd0b85a97d-46238f97e32mr8549715f8f.30.1781714538164; 
 Wed, 17 Jun 2026 09:42:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26434dsm56897101f8f.1.2026.06.17.09.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 09:42:17 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 17 Jun 2026 16:42:17 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
X-Gerrit-Change-Number: 1712
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1712?usp=email>
X-Gerrit-Commit: 3b190ad7489b2e3bb753c9965f36b22a03e6d2ee
References: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE0NTMzMDAwLkk3ZWMzMThjODZhZjk5NDI4NGQxYzYyNzJlM2JiZTJiMWVkZTE2MGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <54a410ed6b7630e33198eedc11604d603300e26c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZtLT-0006pg-Ry
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
Content-Type: multipart/mixed; boundary="===============0529473505194026129=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0529473505194026129==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2pOCa3ZLL1s="; charset=UTF-8

--2pOCa3ZLL1s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1712?usp=3Demail

to review the following change=2E


Chang=
e subject: dns: Fix memory leak in dns_server_addr_parse
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dns: Fix memory leak in dns_ser=
ver_addr_parse

When the DNS server's address count is already full (exceed=
s the
limit of 8), the function returned early without freeing the
successf=
ully resolved addrinfo struct=2E Fix this by checking the
limit before exec=
uting the DNS lookup=2E

Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160=
fd
Signed-off-by: saddamr3e <saddamr3e@gmail=2Ecom>
---
M src/openvpn/dns=
=2Ec
1 file changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/12/1712/1

diff --git a/src=
/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index 954ed52=2E=2E1465cdf 100644
--=
- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -114,13 +114,13 @@
   =
      addr =3D addrcopy;
     }
 
-    struct addrinfo *ai =3D NULL;
-    i=
f (openvpn_getaddrinfo(0, addr, NULL, 0, NULL, af, &ai) !=3D 0)
+    if (se=
rver->addr_count >=3D SIZE(server->addr))
     {
         return false;
   =
  }
 
-    if (server->addr_count >=3D SIZE(server->addr))
+    struct addr=
info *ai =3D NULL;
+    if (openvpn_getaddrinfo(0, addr, NULL, 0, NULL, af,=
 &ai) !=3D 0)
     {
         return false;
     }

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
G=
errit-Change-Number: 1712
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@gree=
nie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--2pOCa3ZLL1s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1712?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dn=
s: Fix memory leak in dns_server_addr_parse<br><br>When the DNS server&#39;=
s address count is already full (exceeds the<br>limit of 8), the function r=
eturned early without freeing the<br>successfully resolved addrinfo struct=
=2E Fix this by checking the<br>limit before executing the DNS lookup=2E<br=
><br>Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd<br>Signed-off-by:=
 saddamr3e &lt;saddamr3e@gmail=2Ecom&gt;<br>---<br>M src/openvpn/dns=2Ec<br=
>1 file changed, 3 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/12/1712/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</span><br><=
span>index 954ed52=2E=2E1465cdf 100644</span><br><span>--- a/src/openvpn/dn=
s=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ -114,13 =
+114,13 @@</span><br><span>         addr =3D addrcopy;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct addrinfo *ai =3D NULL;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (openvpn_getaddrinfo(0, addr, NULL, 0, NULL, af, &amp;ai)=
 !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ser=
ver-&gt;addr_count &gt;=3D SIZE(server-&gt;addr))</span><br><span>     {</s=
pan><br><span>         return false;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (server-&gt;=
addr_count &gt;=3D SIZE(server-&gt;addr))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct addrinfo *ai =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (openvpn_getaddrinfo(0, addr, NU=
LL, 0, NULL, af, &amp;ai) !=3D 0)</span><br><span>     {</span><br><span>  =
       return false;</span><br><span>     }</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
12?usp=3Demail">change 1712</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1712?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1712 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--2pOCa3ZLL1s=--


--===============0529473505194026129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0529473505194026129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0529473505194026129==--

