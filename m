Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D20CDB481
	for <openvpn-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GFSTdMrmujRV6/Gb2euoX9lSJm06oBWosBK2gJI5a/A=; b=AOuxSmyXkNDtaUzlY34C8WP2l2
	aIdXfMF+WiIAGU81jPMnZ33oM+4kVEdLhPeY6Z7ojyM6NiGI+aqWVmuVGcpUsY7clLZaSc1bY3tup
	uSnPYyOwU6LBvlayEE5TerOxN2QJhprqh2q5T8lyi8F9W40yXnVEHnr7uMibp12Ikv80=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcOfJ-0003oR-5A;
	Wed, 24 Jun 2026 14:33:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcOfH-0003oJ-Kt
 for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 14:33:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VwU1qMXZOu6Dlj7wXvsZGPaJ8QaqaR1ucy+3lNfPoEY=; b=izdMJFT+h5+fwOHIXlsuJj8pnY
 SQrQpW4lZMVGn61g/CoM5XNOpqsCS43BFt8vEWVDQ7WB58/sKE/VSredPdQUJVfhpLK5LXONG6kFK
 OVs4WRXF4f2ej/UP8DVNYXdeYs7hL6ofVPE65rG9h//OfZVnoAbPoditdvwLLj/qO2vY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VwU1qMXZOu6Dlj7wXvsZGPaJ8QaqaR1ucy+3lNfPoEY=; b=f
 myOJAduIhooDwHBrEI95v0jR7dneS24RLk8DAUrJX0lc5YCUHlVgTKQY8Pw9IVS3L4oajqAXfJYKT
 6d2UC3GZaOnXCi+ntskiYk1pw+Oowjcwi3vCWs9J4x3aeqnh/G85cS8rSgZGfw3RPEutRn0pEROuY
 ESEcnPh+rlQYR/4E=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcOfD-0008Tm-TX for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 14:33:20 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso12238795e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 24 Jun 2026 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782311590; x=1782916390; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VwU1qMXZOu6Dlj7wXvsZGPaJ8QaqaR1ucy+3lNfPoEY=;
 b=HATA/Sseeic/RMxSfWRdyQr50AMUfat5jH27sZil2XXyfF8EZegkdwh2vtwu0BYzNi
 elE6tXoHv+suw0w2lgHMqxTalC8LYVDGJ2XFmmaw8Ts/OdX9kpGk1jUD2TNDak7WpL9L
 w5UWRhogyUjP4ogAzkMnl7I9uOUVijT7ifPpcZEa73y1tTnrRXyn/TebqMzY4aKSzbcc
 Lgf+rsM7l9jfQuzwi+RSeutdSCRuJNyJusNs7q6qPzSbwObx6Fe0JPKXoSQePAHBsHow
 twSnMh0YB9ue1QF1VPtMCcUXTi9ZvoQZ5yyrCdcM6LhLikBGy7mDIPDjepfp3iOEAPNu
 Fmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782311590; x=1782916390;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VwU1qMXZOu6Dlj7wXvsZGPaJ8QaqaR1ucy+3lNfPoEY=;
 b=jNHS3WXRLwHUYzHFaKg/ELO5QEH1K+XOIjuBFRnK65jfv3j+a3SXYtB/Xz4elU8DDu
 FtyPx/7t5MphYDD111MDwhoYOt4srHElZTA//D8Lyo4W5bgwIQwAm0MUKq7n+qWbbIyH
 4H8TONpoKFGHW/q+AbcPRDfaVJBKnQFVlgDj9C8zVffzzAoVUDm9V7DdiT8j2y+K0ZiO
 iZMqjd4hNe6ptv772fciLbmKmm4gQWkxMYSSuh7pHBGBpUsY8qxLDDesqcOHoge7WYr1
 p6D+wkkovnLK/jKq0UsS8boq8/ypwG6RdG/Hgf0F72/f/Ko29KZ0CyCZ/6K/Z2D0aXF+
 l1GA==
X-Gm-Message-State: AOJu0YwrFRG2HmXrFDcHdPCdN8ZIfmwK4vcW/yzKuQuDY3XEEkv/svZ7
 +uotx7puITnZDGpHjhTLg0a9e73m64QfgouIwMTGU5YiC9XDcZk6JxRbM22rTuXmapMOTe5IOrH
 azApZd8Wc4xTsptj6RI006kc+GUcQUbbGqVLj/EhRarzh4JwwxPNrHUC37bef9CNN+f1yqDvKhp
 BdMgp9Cg==
X-Gm-Gg: AfdE7cloZiSeNNLbwyewh1NowhNYx21gvF8MyMyvfRHSVbm8Pjn+Bol5GUlyXOc3Kjr
 bVUQZejjf3XQx6L0/HZl63zAm2jEHrQTAepb07p/7JwtSwDpSGaxUwd0Bwy4KtVCoH0yFdh9jnz
 4OmJhsAbkWx3wJJ2LxIeNt7ryP+CUXATV6To+NwD4IIusZTMQneKZHmNVOakc0SRKJiKnMy9DzL
 rEWj6d6QYvq8r5WQ23yh/obNvwt67HszORgqTFCOWsIt3nY/S7TnSqIbs2/qW9ZdeGyz6EmnW+w
 /PBZehWFhpfHtH6FO8RiBNSKDn0hpCYWEk/R6yzl5WHQ5lP6GD1AWUQ5VdJIVy2+PdlWZleKUNs
 FFLH81BP/TbUJOz1BNEA3dfhrzZZlB0sw7xkR6ORvRgeIoYvYaZfLoVQZpvBxmNmOQnTMdXWf/Q
 fI8KL0vslF9YcSBXCMcF1FLCQyySknrcezYVGbareS8G2M7AlAUrakmAyOfgV/7nt8x3+6s9wdX
 3TIcR5kuS7fKuehPm0iWE2i7ifWYSCWY4+uqjnSzkJuazQ7TreKcQVKeeuL8FcsJ5MF57NaOKYr
 gAY=
X-Received: by 2002:a05:600c:4e51:b0:490:e60b:6860 with SMTP id
 5b1f17b1804b1-4926084aaabmr49724305e9.7.1782311588632; 
 Wed, 24 Jun 2026 07:33:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fc47720sm808298495e9.0.2026.06.24.07.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:33:08 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 24 Jun 2026 14:33:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: 572f2d5cb4d3fd97f70dd0ce9282b9c21eea0a88
X-Gerrit-Comment-Date: Wed, 24 Jun 2026 14:33:07 +0000
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <87e257bed1edcd62c9f42d717519a96fabb040c6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcOfD-0008Tm-TX
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add check that
 username is identical to multi float
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
Content-Type: multipart/mixed; boundary="===============2676485311379279658=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2676485311379279658==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AwNBIcuMGho="; charset=UTF-8

--AwNBIcuMGho=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1724?usp=3Demail )

Change subject: Add check that username is id=
entical to multi float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2: Code-Review-2

(1 comment)

File src/openvpn/multi=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724/comment/f2512af4_7b71=
576a?usp=3Demail :
PS2, Line 3149:         }
goto done missing?



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie552084638320b3bace76be2f589=
013f12af3c46
Gerrit-Change-Number: 1724
Gerrit-PatchSet: 2
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
omment-Date: Wed, 24 Jun 2026 14:33:07 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: Yes

--AwNBIcuMGho=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1724?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724/=
comment/f2512af4_7b71576a?usp=3Demail">Patch Set #2, Line 3149:</a> <code s=
tyle=3D"font-family:monospace,monospace">        }</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">goto done mis=
sing?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1724?usp=3Demail">change 1724</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie552084638320b3bace76=
be2f589013f12af3c46 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1724 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed,=
 24 Jun 2026 14:33:07 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </d=
iv>

</body></html>
--AwNBIcuMGho=--


--===============2676485311379279658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2676485311379279658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2676485311379279658==--

