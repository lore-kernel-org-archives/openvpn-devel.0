Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5F1CD98F2
	for <openvpn-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ga1SIXLihOF3HsAXXsnzrdl9kquQBkt5h3OIe0ofOL4=; b=MVH0KdOH3ebsGt7kksl0zeboPT
	XyPTtArjyuBdES/IMoldDSUPJXnUfurUcSsvWOseiC6TZGWujegucjJmuvZBXX4tZbEPOjYYFitrD
	WzoitaRZPeK+UOBeTBvTgWICoxeg15NYACReEIvL1Q2NrcfTfzcsz6REwueom0GGgFlk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wa8Fc-0007lc-17;
	Thu, 18 Jun 2026 08:37:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wa8Fa-0007lW-U5
 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:37:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IfjotKAUSuKLt76AG0EnpiBrz4JWTnpmY8lzMXIaI7g=; b=chMmb02Div50YyS45JybYqYbF4
 +IECuowe7QPcuVvKjo20XlkpJHvx+7IwmF4wwMNwBuAZIXH4RmMwOtsmQyZ3P4xCSe9zSaruv0FKu
 KlXJIjU02PH+AxDmGn6eSFfS4/1ZP9AbfziJ/+HX9B/6X0SJZNMSriDoPOon5ZSJKjDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IfjotKAUSuKLt76AG0EnpiBrz4JWTnpmY8lzMXIaI7g=; b=W
 igVUYlTSrI9BcExkZMo7q/3O8f1uxG34lI6OlwJe0g9IVYiEcBGicuiK7wFId5nHsck0HFKyjAdSb
 WEL6VCw1K5WDrEgfO5L7pYvMweo9LFI89jbPx7fH0EcAmWUlE+j4VYoacIQDGd5JEop83PWRjamoT
 BSfVZ2Th4kR4Md7Q=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wa8FZ-0005NH-Rl for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 08:37:27 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso6348555e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 18 Jun 2026 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781771840; x=1782376640; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IfjotKAUSuKLt76AG0EnpiBrz4JWTnpmY8lzMXIaI7g=;
 b=EhwbxMjrvgLtFGlCx8FFlk5Be0ikaI+MibQr8KVEWooKuB+3KIN2cNqG/mUsROD4mi
 s5B5MXELSp6MQE39QKpyx4tGAzZ9jNHo0VRrQREl67uRSpjd9HwWTrDW5trzSum0ZvRN
 RX0hOCIbUVava/IHiT582P9Nf/zQ+FM1s2xpLVVuuHNMud57ijkdHpPnjEqeA8zIlUel
 B1Uy0VSvtofSKCVBNr6nXbraYp4OIMGxuLmo79JwkAm5VM/pmkzgKRFGQKtwRSXeJyBF
 Jg8AGhHrYSWRyTidGYIcMy9sGursIZjOM0RKdCchh0WdxlzfcjGylKEiFDQ4391JArOo
 +uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781771840; x=1782376640;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IfjotKAUSuKLt76AG0EnpiBrz4JWTnpmY8lzMXIaI7g=;
 b=bA6kPKfUqzGTfggK93TVai2Gr5JB7HO3SnRYl060vCxp2KUpZBB5b7X6weU44oH0nj
 jRN2WoxDHmKwbHLj2eyoV4MuzCnGXXVi2ZhiS1waaP+fH1VYJTK0BTxyP0MaOtSYzie+
 IBM4djMbR8lkgM+xrHOfwgn99y7J0tMK3pfQUaGl255cuKK5w+ffxaDs9lFstRLqSwNN
 mP7Vg7I070qgAocsGoXLHdd975aPGbBo1ggsexxCcXID9wpD9C/VKNdK1M6oT09MZZer
 /2Rz711//NfDLuEQrkIGPcRlAvL3p9CWMfHN2Q9tMOI9evIj0ni80ZGS7s/c7stL43f7
 AxOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Q5PzYru+mhUCeEFRXWuTyyyZAPwuIhyr1hcRX8Lwd136gNul4eoLOoUtb/JV2ZgjwXq1rBAVBZcHi8EuA@lists.sourceforge.net
X-Gm-Message-State: AOJu0YymAotu0qFIU6NXn/G7BQAGujkrbWcu531rkJV3NJxAccLULGFt
 5Pwt1Iz8MYD4TCivSzX0tff6ZVGWBs+lp+xYy2GT+ui/UAxACpK2Fj7xaglIKoxgtBlTrM/P7BZ
 TRHL0e+/CBPxIb7D3sgFazoB9d/lRAJ+9LCDPwP55YwXj+QL0OUSZkswwRZaSfS63n3TC
X-Gm-Gg: Acq92OHXCAQ4C803vWngZUZrwPM7+6jKKSdOiyS+YtufHRfUhkhHctbd3NgwzAgBxkx
 UrqFCX2Pk52wI6DpBP6M9nbZgO6y70YknmSRg1M0wUGkhUIDvn0MHxrrccUEiD2EPrqUyvdSrzM
 eKNwF86yNRPU2XwWA7ObDxBX+D0d3mdakUhVJgvR61zdbsMbGneGisMIlXnWp8QwnuBp1mWbGf5
 AbFM8apixtqci01EISU8Gq3+KWBTKNS9RyYZ4jGpWKd5su66l8sK80k77neLrA61dMfdJHmvSR9
 BSa0VWMkDEZgw4/JXX50dWLH9IAEV3A9xiipAp9+9Hep6rTZAl5NUap36DGLHximeaXP2ohlaI2
 6dpLn04WjacPyLgBWhraPrB2uxAS1DPPMnQLXYakwkR32pcWT2VwmOKFI89g1L2kW6AZcORWl0t
 veJ+sGS7kFDmurzDVu28lULGL0N8qesoA3Dzc/XvWot+JcOXSPgpv6e+HcTL9yWqzXiAXMlc3Dx
 cVwWnrU/UVcdw57pBk7mZki7QwFTwc2RpvdyGZf7C95eSqK21GF0I69O1p9pWFY9/aH49gcGokJ
 6IdQ5Ql8wy5BPg==
X-Received: by 2002:a05:600c:4e11:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-492381f13ebmr46713245e9.15.1781771839701; 
 Thu, 18 Jun 2026 01:37:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a159d06sm33916745e9.0.2026.06.18.01.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 01:37:19 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 18 Jun 2026 08:37:19 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
X-Gerrit-Change-Number: 1712
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1712?usp=email>
X-Gerrit-Commit: 154e8a520b3bd639fb137c1ba73ce8a80818d08d
In-Reply-To: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
References: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE0NTMzMDAwLkk3ZWMzMThjODZhZjk5NDI4NGQxYzYyNzJlM2JiZTJiMWVkZTE2MGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bb7fe0c5b1b344917d42863332c49b54d5641407-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wa8FZ-0005NH-Rl
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>, d12fk <heiko@openvpn.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4241703535258987659=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4241703535258987659==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LKg0kvklSog="; charset=UTF-8

--LKg0kvklSog=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1712?usp=3Demail )

Change subject: dns: Fix memory leak in dns_server_=
addr_parse
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

d=
ns: Fix memory leak in dns_server_addr_parse

When the DNS server's address=
 count is already full (exceeds the
limit of 8), the function returned earl=
y without freeing the
successfully resolved addrinfo struct=2E Fix this by =
checking the
limit before executing the DNS lookup=2E

Github: OpenVPN/open=
vpn#1055
Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
Signed-off-by=
: saddamr3e <saddamr3e@gmail=2Ecom>
Acked-by: Heiko Hund <heiko@openvpn=2En=
et>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712
Message-Id:=
 <20260618061835=2E16448-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37209=2Ehtml
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/dns=2Ec=

1 file changed, 3 insertions(+), 3 deletions(-)




diff --git a/src/openv=
pn/dns=2Ec b/src/openvpn/dns=2Ec
index 954ed52=2E=2E1465cdf 100644
--- a/sr=
c/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -114,13 +114,13 @@
         =
addr =3D addrcopy;
     }
 
-    struct addrinfo *ai =3D NULL;
-    if (ope=
nvpn_getaddrinfo(0, addr, NULL, 0, NULL, af, &ai) !=3D 0)
+    if (server->=
addr_count >=3D SIZE(server->addr))
     {
         return false;
     }
 
=
-    if (server->addr_count >=3D SIZE(server->addr))
+    struct addrinfo *=
ai =3D NULL;
+    if (openvpn_getaddrinfo(0, addr, NULL, 0, NULL, af, &ai) =
!=3D 0)
     {
         return false;
     }

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
Gerrit-Cha=
nge-Number: 1712
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>

--LKg0kvklSog=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1712?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dns: Fix memory leak in dns_server_addr_pa=
rse<br><br>When the DNS server&#39;s address count is already full (exceeds=
 the<br>limit of 8), the function returned early without freeing the<br>suc=
cessfully resolved addrinfo struct=2E Fix this by checking the<br>limit bef=
ore executing the DNS lookup=2E<br><br>Github: OpenVPN/openvpn#1055<br>Chan=
ge-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd<br>Signed-off-by: saddamr3=
e &lt;saddamr3e@gmail=2Ecom&gt;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=
=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712<b=
r>Message-Id: &lt;20260618061835=2E16448-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg37209=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/dns=2Ec<br>1 file changed, 3 insertions(+), 3=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/dns=2Ec b/src/openv=
pn/dns=2Ec</span><br><span>index 954ed52=2E=2E1465cdf 100644</span><br><spa=
n>--- a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span=
><br><span>@@ -114,13 +114,13 @@</span><br><span>         addr =3D addrcopy=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct addrinfo *ai =3D NULL;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (openvpn_getaddrinfo(0, addr, NULL,=
 0, NULL, af, &amp;ai) !=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (server-&gt;addr_count &gt;=3D SIZE(server-&gt;addr))</sp=
an><br><span>     {</span><br><span>         return false;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (server-&gt;addr_count &gt;=3D SIZE(server-&gt;addr))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *ai =3D NUL=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (openvpn_g=
etaddrinfo(0, addr, NULL, 0, NULL, af, &amp;ai) !=3D 0)</span><br><span>   =
  {</span><br><span>         return false;</span><br><span>     }</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1712?usp=3Demail">change 1712</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I7ec318c86af994284d1c6272e3bbe2=
b1ede160fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1712 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"=
display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </di=
v>

</body></html>
--LKg0kvklSog=--


--===============4241703535258987659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4241703535258987659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4241703535258987659==--

