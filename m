Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D06CC6B39
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=GcfUSqTqd2VnIY4q83gKvI/TbqLZnBOahygwRh5oNm0=; b=m/gDJU2S6z/4m9
	3Ym8h2zSLpQwCDFvM/KpX66go+Y6rM6WCYCL7bZDJa1MSyfQGRIJgUCW78uKk2aBHonenpj+q5UaS
	euYGutj501YPd5eYe60oIrb1fla6SI7zOnDTkGiKgsew1GkZkLqTC3N3NprkiKx5TXNCUUn7i9J26
	Zfc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHNcS-0005xD-1U;
	Thu, 15 Oct 2026 15:43:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHNcQ-0005x5-U8
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7kxWEk+Wk/VyphKEvGRAv5AQZBNE6cE/Ow337gu3yys=; b=AFqf0pEyEL/ep9f4PcpgJgOGf3
 MvkRh4inp5ldtIjKwRzJfb3lgSGKxdMYSpYiCDwqr8sV1rSs32wKG5FiiDkPkS8bTl26mEZ7vEKNS
 qDGseTyEEQYdEG9MTfOLIfz5mDiwPKJimxraZm+XBQL+tp0Jr5eG0sAvnQLYCUGw+2Es=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7kxWEk+Wk/VyphKEvGRAv5AQZBNE6cE/Ow337gu3yys=; b=A
 +woAiP/29KDkQlbPWymFznigUOF2REY4Gvi7V1nTFHEZEpeoVw0LVVdaPnN/F25xfZz55AxKNTDxS
 aKoSw/tF0mm0X4JyD7gq0WsRYRaWI6ciEl2++PvdygVaMjvGTDMtzh0vY+3tVy3XWJH9yqkjbfKmD
 kbdHmg0uZ2hx/hcg=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHNcN-0004Eh-2H for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:43:44 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so3268855f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792079016; x=1792683816; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7kxWEk+Wk/VyphKEvGRAv5AQZBNE6cE/Ow337gu3yys=;
 b=eCiEfhdHmrcwjnvXjFigcRabfpX0bhfwkyWRb3J9OT+INNEvuNLK0HXGnEKeebX24+
 rQKx2Zv/90rlewUMG7deD72/rYuu39l9FQaPCcxkLPuhdCG5CMJANTloWTo9+fKutxSL
 5xvbhodyJYbe/45DR9igdAqXRD0GGmNX/sl2P9iWQRAqz+oV074TE+PKfaGvwUYcdw/H
 EyKSf3klMvtkF9DTzNDEqAgJFhn7RobvPol7vcqQqIVBgAQthL3pwVLejwwgZyk72Uf5
 nkEehpBilytpXiLfbfnaRIRggczy3/Y/EaDkeM5T9iR5Y4sT6XplI2XjAmscMA4374+Q
 w7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792079016; x=1792683816;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7kxWEk+Wk/VyphKEvGRAv5AQZBNE6cE/Ow337gu3yys=;
 b=iq8WzBSdsMXycKN63Kx25vvLI/9cp6wgajsGjwHeZnC4SOhdycxfMpTrndQy5cajvf
 1hIPoL5thOmWjz6MmFhy3JPomDVblzS+fB/CLIT7SMQmgLixBG5ws5OXXPmpBwkpg6Fv
 eeORRPCEK1YZ8MS/hoHktLoVhpHSEBshE95+wunOZ1yuoNzVJdvNQhAW76ooB202WBKi
 Z9XY3CtXmFm05semj9cVZgom0P9f/qbr+ujKy6HYZgyiPWvB1HkJlucdYy/ZB14wbLqb
 aPGrNDHu1zWIF0wJBgsKLhisi6pi01Akh4am//9Ds5VAGMBBYnoXkqkr1MLKtyCIPPr1
 vK0Q==
X-Gm-Message-State: AFq9FYJn6cKRDAqaOTBphkmfGWT7dgK2U7lF8L2rC3Ox516t5iV6B4MK
 i4FFj9UUh0yDc67odPfMMJZPua1+XfI/QdphhZIccAfLXLLBcdOX3JKGYtMT7EMTayuWKDN0pci
 p8lOaUu6Pc9Gf4xUXrJ1rdG2W2C3xneyB5rP9OsKGliPty/7rFX8HTnt83W1VggnX+1t2J0z2sL
 qWch3uDA==
X-Gm-Gg: AYBFou2i2QLFm+BPHNVNOSTrRTVqZCmy+owhsg8gXW51EkdYVj2VuYi5q4PFpbMW+wm
 Xq0vzqrwDopcLEq+3/wLIVgDydIddlBx5mbaZqLZDzm5hbEZ5xVYEMLBulk4Vzn8Ga8vDO88DW9
 6v8+fKoTlDNLQ0A/OOHGZGP1Z9zOa6N9Q/ndjXj4NuoIbRpecFpwT1wTHqS8QDt2tWi8FrY5NrH
 ahu2TrYzvvUHlP3smMSIQyOhYu5D36OXjvquKp8idMPnyY7wRfLXmYX4Fr6pxFtokFiiXxt6Lrb
 ctzeUNNrsFrL/yr/7tsMrN+Q1s65jdZaMMIZ4iIvYoUrocTXMtEdIJ1yEpdjglxB83tm/P64inq
 PkHhE2ZpDvJWegGqOaijIvpWcQ2sylZz5fpWvxjBqrODYfQwsHtzkMuO8n4tcJUvx6FzA59j/pS
 Hh+s05eWdFpJLMaDWXyaUPozcmc5V6+K5y8lMKwhrImuPQBjAessXSMvINkzM4P9DJSLn25qRs/
 iN47XbbzSoFWoXgdawyKN2q6/gX82KY6OkAawCz9mmxpMTsNavuPAYLfynCAw5xlEDLUxu9f3sr
 OPxw45MiJ9y3aBqZhxmwEKu3jlq1JKA3nJ35J7iwf07RroTfCyUIqPVzQvBR
X-Received: by 2002:a05:6000:490a:b0:48c:490a:336b with SMTP id
 ffacd0b85a97d-48dba7bea0bmr37813483f8f.5.1792079016245; 
 Thu, 15 Oct 2026 08:43:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd733fsm19544791f8f.58.2026.10.15.08.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:43:35 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 15:43:35 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9a3598382ecf928aa81f027b55352175ad93165c
X-Gerrit-Change-Number: 2000
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2000?usp=email>
X-Gerrit-Commit: cc22f6e3b9b3bf812184f359bd2890ed2a31097d
References: <gerrit.1792079013000.I9a3598382ecf928aa81f027b55352175ad93165c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDc5MDEzMDAwLkk5YTM1OTgzODJlY2Y5MjhhYTgxZjAyN2I1NTM1MjE3NWFkOTMxNjVjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a8e5fc452cb001090cc55d6b92dbab6750fdbbf9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHNcN-0004Eh-2H
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: repair const
 mismatch in siphash_openssl_available() prototype
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2453615537265412384=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2453615537265412384==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sYEswi2RCiA="; charset=UTF-8

--sYEswi2RCiA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2000?usp=3Demail

to review the following change=2E
=


Change subject: repair const mismatch in siphash_openssl_available() prot=
otype
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

repair =
const mismatch in siphash_openssl_available() prototype

commit 571caa34e2f=
 added the "const" to the function declaration but
for whatever reason the =
necessary change in the prototype was lost, so
"make check" failsed to comp=
ile the siphash parts of crypto_testdriver=2E

Fix=2E

Change-Id: I9a359838=
2ecf928aa81f027b55352175ad93165c
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M tests/unit_tests/openvpn/siphash_openssl=2Eh
1 file chan=
ged, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/00/2000/1

diff --git a/tests/unit_tests/open=
vpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn/siphash_openssl=2Eh
inde=
x 49c6a9d=2E=2Ea44457e 100644
--- a/tests/unit_tests/openvpn/siphash_openss=
l=2Eh
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh
@@ -60,5 +60,5 @@
=
  *
  */
 bool
-siphash_openssl_available(void *sip_context);
+siphash_open=
ssl_available(const void *sip_context);
 #endif /* ifndef SIPHASH_OPENSSL_H=
 */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9a3598382ecf=
928aa81f027b55352175ad93165c
Gerrit-Change-Number: 2000
Gerrit-PatchSet: 1
=
Gerrit-Owner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>

--sYEswi2RCiA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering would like Arne =
Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">repair const mismatch in siphash_openssl_available() prototype<=
br><br>commit 571caa34e2f added the &quot;const&quot; to the function decla=
ration but<br>for whatever reason the necessary change in the prototype was=
 lost, so<br>&quot;make check&quot; failsed to compile the siphash parts of=
 crypto_testdriver=2E<br><br>Fix=2E<br><br>Change-Id: I9a3598382ecf928aa81f=
027b55352175ad93165c<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M tests/unit_tests/openvpn/siphash_openssl=2Eh<br>1 fil=
e changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/00/2000/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tes=
ts/openvpn/siphash_openssl=2Eh</span><br><span>index 49c6a9d=2E=2Ea44457e 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/siphash_openssl=2Eh</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br>=
<span>@@ -60,5 +60,5 @@</span><br><span>  *</span><br><span>  */</span><br>=
<span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-siphash_op=
enssl_available(void *sip_context);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+siphash_openssl_available(const void *sip_context);</span><=
br><span> #endif /* ifndef SIPHASH_OPENSSL_H */</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Dema=
il">change 2000</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2000?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I9a3598382ecf928aa81f027b55352175ad93165c </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2000 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></=
html>
--sYEswi2RCiA=--


--===============2453615537265412384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2453615537265412384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2453615537265412384==--

