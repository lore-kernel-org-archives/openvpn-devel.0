Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01588CD4F24
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N8u1ZVDYG/mdHX36CzF8dagDp/Ihl8L3FU7cUJEW3Kk=; b=fDr9ABoFuHBJkp4ECc//jfEprB
	fvOoYkTPRk1nEroerPkfcfb82xn7Foel/ySCu8LdAafr1gxMdH7IDogPfPpOc29W8emS1QGi7iAEh
	74sXomWsrnnC/bmiQGJLUit8/ZR07ofkGj0P5eP4tw8kbrwgSjGRT12+GS1nmQtRHxgk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMp1e-0004cQ-MF;
	Tue, 12 May 2026 15:28:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wMp1d-0004cJ-93
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 15:28:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dyJ/U4l8elGGhgzzB5hPiZbLPV7C7SU/6G0YTpQrZvw=; b=Q1QmKueauudB3oooNLz+PM9Kl0
 B/KJ0ENLNA0OFgfKUKXVzwSHTsuYM0yi3mRrVqd5utgda99c/wp6D9CsH9FumWpILP9eXL/F4M2ul
 /pFDmEdLHFQIozZ5XvgxNFF57GEFwjG5Zh4n3f5dBCtwBO60QCxtnDlt153EFf+/45m0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dyJ/U4l8elGGhgzzB5hPiZbLPV7C7SU/6G0YTpQrZvw=; b=Z
 NmAhorPjTYFqmwSVx0aCKdAfB1ZTj3IsPGoKogLzCyJFfBoBOUxgrZl3hYypsWDXgfmV81cuUzdh3
 yV/6Uo1aJNJWXjSrVgCIOKwmlCrbNqZCeoZccz3gV3E0cgBMs8R7FJAVsmOhI/lgC6fPRAXfEfGlM
 nIrCquysyo2Zen2o=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wMp1a-0001jT-5n for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 15:28:01 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso64209825e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 12 May 2026 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778599672; x=1779204472; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dyJ/U4l8elGGhgzzB5hPiZbLPV7C7SU/6G0YTpQrZvw=;
 b=Qhk6rKY3p3UAMQ7vE5SFrBSoOe1oIYrKN+ruhqR61MQrvCo32aWtSnsmBByVPMbaiI
 RBQFZ3OlyzXWbQLri6wW//CT+5ZDhCJnLzsZPQHLoEOnnY9CDmg9DgXBC2rHbF5gpjUU
 szmGT9HSEgsJR6Oof811Z5JyGNNCJhh06xRuGLBepPpDInJOe8Muyopr3UGOrQG6zoba
 zFYcyqQrdQef4DGXIKOKXYzau2BWIYnnZ6UGXm6KEh1qrwsyUMGkv7RtR0yxwrevlX0C
 fAFxlKPaGVo+sGJW9utfl1HePToY3lZIAxQ2gca2wu9fQw3NvoosEHitcjINaUVHdX+v
 PF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778599672; x=1779204472;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dyJ/U4l8elGGhgzzB5hPiZbLPV7C7SU/6G0YTpQrZvw=;
 b=K1CYqVgC1le8aMS81A/UZ0sPoU1ASIEcmF3LrRj9tFuULX7Z51szmt/E3WyQVaijra
 EoqldW7sjEPldr6wHDTxoiRFDZqARfBhP1YdXEvjBlbrYFygYUU3ylKHEHxd5E1gdfA7
 6GsukmQ25cqpI9NqWn4nMrQL4eVirZL3w8uXUoEc1UwR1s6fY/gDLX0oY6mcdMc87rCY
 Q2Yk2OrTnAMOy/a3gdVmrWH3OPyLxI4ZoWiwGKnTEgeoh87YOh4wtcg/B4S6GlYyZ4MU
 tEiOtu5hc2H/DqsTfTfApWZ56uv/FcW4o87GkC49umFJ4bNbLeEqCXEWirMvntyFXk+0
 jomQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ99wQTI93gz1af6KlgkpEb3SAGPrOPNJvoNQMfwB5rRzVMPbPcNqOrHasGFjKxWOVU1Jr/iwUt/K0ifGerS@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywe39W7yEAr1sqRfjlSx/oVhOCa3EtjqJGSXcDGygHaLjR9STWS
 4s1PQThE65cYpIJpvTPS/vw45rzjVD5n+efyJT5iGkjLWXWW6fQXO3D+xVgNeKFAKQJaPXxyZ7N
 l61l4vx+RUnaMD4eSVfJxGZLYzuIghH5MB58lv8Kmk+YgBkeezofqCkis9YGrZojzmRkPXCiGCs
 3aKuOgMA==
X-Gm-Gg: Acq92OEUgNiRoYrXiBaxg5hBpdiKzwgyRr0xI0DCigu/Ni2ysS+4/pmRJMxYA/y79pt
 UmCDdFYjLo993egvuJZpMM24A2NRDKb2RwbvLyHcBEeNvD7S+N4dQw67lZXfZkzmpnCqjWaijyA
 17vlN39MhHaUHmn+TNPUzhU66vOa3wZ+DYs2S1Pdq092bas4FqaTBhH2H+/DwLaGV5nbsUImq5q
 DYNlQa06I1HpP1Mi5vsiRFy/tITX5sCnQXymF5lPeG9DtdRZNpqWs8Vyuw/s0bvHoK0QEpisZHr
 xC5rO+fJZSr+F1hure/OsxGm0z+DS3WEEJB9uXsOk7p90IwDQCgw6ZSctbeuSKYbbd5kaWam19C
 LobF2NEICPdAss91E45TZsd7kMgGbX+CvfvpoVxSATIy0z77ofD6HEQWr6adWlCiHfo3HJ2jIQt
 gY/1q1HSiqVdnfv7r6ipdHP6vtgqOd6nR/ugSom6DF0iahKw9aF4Hr6sHplxhToxMvSQ5cY5+yv
 3cEkO3h7IkS5dolj6NvtFF5Tsjbv+lm3EOIhWB/BRNCBaFvnblx0bwzF0VGF9wyStDb3J23de1r
 oIa4CsW6higP5A==
X-Received: by 2002:a05:600c:46d2:b0:48d:50a:6ef4 with SMTP id
 5b1f17b1804b1-48e8e210753mr59476665e9.11.1778599671878; 
 Tue, 12 May 2026 08:27:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d351bcsm4050005e9.13.2026.05.12.08.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:27:51 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 12 May 2026 15:27:50 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
X-Gerrit-Change-Number: 1675
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1675?usp=email>
X-Gerrit-Commit: 940954440470a6439e9fdad2c08a7dea68510111
X-Gerrit-Comment-Date: Tue, 12 May 2026 15:27:50 +0000
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkliZTdiM2MxNzE3NmM5N2ExY2JiNGQ5Y2M4NzczNWIwNWU2MmM0ZjQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb77adf890cad3b12befba1216462ea4b4794aa7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wMp1a-0001jT-5n
Subject: [Openvpn-devel] [M] Change in openvpn[master]: lladdr: Clean up code
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4406171637774517035=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4406171637774517035==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J8YzodSXx1E="; charset=UTF-8

--J8YzodSXx1E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1675?usp=3Demail )

Change subject: lladdr: Clean up co=
de
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 3:

(1 comment)

File src/openvpn/lladdr=2Ec:

http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1675/comment/d122e12c_36579c0f?usp=3Demail :
PS3, Line 38:  =
   argv_printf(&argv, "%s %s ether %s", IFCONFIG_PATH, ifname, lladdr);
ah,=
 here's the culprit=2E=2E=2E it defines `IFCONFIG_LLADDR_CMD` and then unco=
nditionally puts `ether` on the command line ;-)



-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
Ger=
rit-Change-Number: 1675
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Tue, 12 May 2026 15:27:50 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No

--J8YzodSXx1E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/lladdr=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1675/comment/d122e12c_36579c0f?usp=3Demail">Patch Set #3, Line 38:</a=
> <code style=3D"font-family:monospace,monospace">    argv_printf(&amp;argv=
, &quot;%s %s ether %s&quot;, IFCONFIG_PATH, ifname, lladdr);</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">ah=
, here&#39;s the culprit=2E=2E=2E it defines `IFCONFIG_LLADDR_CMD` and then=
 unconditionally puts `ether` on the command line ;-)</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
75?usp=3Demail">change 1675</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1675?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1675 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-=
Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-D=
ate: Tue, 12 May 2026 15:27:50 +0000 </div>
<div style=3D"display:none"> Ge=
rrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels=
: No </div>

</body></html>
--J8YzodSXx1E=--


--===============4406171637774517035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4406171637774517035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4406171637774517035==--

