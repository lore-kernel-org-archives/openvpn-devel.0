Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B986C55ABA
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gX4B+w1RGBKFalWNEWHaCbJvi1CayiaD5u71n+RULKA=; b=LYrlwV0+RtPYJB1TvfbxdhTMAi
	J75xhb7z0TWG7FJkWzSlKs/roWGNcbhpTWE5qJrEqVE/mc15cHn6U9JtByOPXRNdFsdaJloC+uZh7
	cgjqW2qUis2xnvz9RIVG+I/4RPLVH52L9zcUswLZ9zl+t6btI9s05OZ/iI9wHe6wNILM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrcJV-0002hc-Fp;
	Wed, 05 Aug 2026 14:09:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrcJU-0002hW-Fu
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ylscO5dxN2E6dBZ4sXrzgnRFmMgQRwIDw/PLBG6hSw0=; b=BesuyOl5XoN6CcJ+rKPgU9xfIb
 2VBNkveV1Xe8o5WEX5FO9HIc5O1YT8mChmSifjSEfVf0l8AzIXJoVoUzC31c4jG0129ZIIWITw44s
 3ZdYJTTLpdDUOXXcODo3FaFvyNeCDZFecsbKPgaB5Lx/G9L98FAClGMteXlMdhJg2XnA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ylscO5dxN2E6dBZ4sXrzgnRFmMgQRwIDw/PLBG6hSw0=; b=I
 v24ehp7iv4qlNMgE/eTqKOSFEM6sSm4A3rqwkKtIUmc3kbb3d1cUyM2I4/AurfcqZtOEZ7fT1SAXi
 9hi1TJuMgO6s14qg87ppqIJ0gcSoWCSGXhECJzNTQUfvcDgFPtjWVO0/TKSG76JwLOf4xILCJyOFv
 RQefSxmFnJb4zlk4=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrcJW-0000JB-6p for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:09:44 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4955158f26aso6490525e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785938976; x=1786543776; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ylscO5dxN2E6dBZ4sXrzgnRFmMgQRwIDw/PLBG6hSw0=;
 b=XZDQ8DvoipQamfsY2tSyDTARMvxPn6iDu85J1r2bYBhfQcxSMFJTUCMnRNwz8GvoFn
 sDDPyEEZB/dpaMwApQEXqmCEBs224sNNd+r8j9sMgBPELG4dPSPNe6ZxawRApPvZx24f
 ipiESrKBkNFMxD9V8YqVcWbnYRDSthyXu9mJS7+jQUUtTpIxZXCpATy7h0t3v2XXxNrO
 SWG5mU2DjcFSDWgQNHrOBBandy+MFmDqvbnJPmk9PSOLE4qhHvgqd8vToCgZh8W14Ugc
 KCIxQis1m83QaMMXQHyz7W7crRE9Nbv6pJhRGCk7q9U7Vyp/IznibT8YWSx6Mn3P0Jze
 96BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785938976; x=1786543776;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ylscO5dxN2E6dBZ4sXrzgnRFmMgQRwIDw/PLBG6hSw0=;
 b=JjcAkbyx+jSz7vKOCaQ4Gdpr7eKIueXAthDyw5xmIYHS9xKAi4p8G8KXO7SSpqmSlI
 44/HZFqcMLqZAV93QgcvgS6F2jfYlNoAgzOanv3hBykFDI25KKhjhbQ5UzwQX/Hx3cXS
 tUdm0dMT8V3n99Hc+OJQj012ePeiS0sutRv7imo/otEXSROP+HRLBfpC0ZoneTJeMYHs
 280qxQSsy3TBR40xhEw/rmXci0geAgBF/bkGgBf8kmcUxrZBAQdfwr4CQu5LfJjpZQ8i
 HzPUsMcNZwCk2rFusgCvaI8VRH9yK4OAwehVpqvOmaYXc53S1YYRPLGYb5kS46eN+13n
 5jzg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpn4F9UvuXGSzDBB+JU63VN6BOGY5Or3Vrvfhlxq/KvX9AznQvHYxEtmxMYDyUPxzJ4/qcnePXov0Bdv6BA@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx7FAcFFSmG4gT1pqHS9Tr9bXEe0oAdh6RFDfKQ1PdkJ4tKd568
 +AOdmAEs5olAmP5fulnIZIgNb2txKnl88cLone0IbMtVW3tB8hmfv9V2oVbgdwVrT2Hh7Y+koVv
 tHMpJE5gVWNtDxA8Sno4IDPKewCk6ytbXSXWTDS9uSghIsEcG5PtFkg7DZIB1cKkqmodZhTxB9m
 pRNnGTxA==
X-Gm-Gg: AR+sD12IkL6b2Lo6ZNAcsxIsLZZArSYHRF8D6tOo6mEinI55Ms8bsB+99DK7Z2oVl5g
 4UveTuzjjO2P5Bszqjv1eFab74CwVIVJohUi1kpVvgIWTi/OyzBaZV7WLySCaz+Nbec31EDQ/UG
 TPbn59AdaihIpaez/dS2SK/CyDhnDuIdO0X0b8cRyc/SHyJ+5hLn8LWhtSNmDceT7aQbsDuuE+z
 wZ+XUKPOhmZxjomPODDo9WPfVucFz0o9OVJYLIYFPdspeF++fjuIhLeNt3F0r50jbTIvxyG/yoN
 LhGwhj74/mqZPoeHcTsXf+H3C2d/oLtrzcw89GwKnHa+7HyKJfXs6AiXSgSFYp+ZX0lEaiXPyUk
 7OXhg1wQ2mUnTqlvEYX7wj7b0rlAHLiDmofpkD9j/TSI08lGRn3Dl+iJpN+O4nzjyDphjm5nEJy
 guIPySEooVp8KKEU6EwvBVEmc4zywwur+gRt3ex3vOHj8HeaKShBJCrQ6bhYkMfYdQaxiUI/ong
 Tt9B55n4id2h0JHrtlGyoOgP7muyqq7itExO41meEmGHfDnjOFTdzjMQUyrm+63krn5LP+8HBeF
 QvTv21DiliANpnVDEwO2emYg/JllDSwTlwiXO6sHL2CxawuCHFc=
X-Received: by 2002:a05:600c:1f96:b0:496:c249:dd9a with SMTP id
 5b1f17b1804b1-4994e71364fmr86588565e9.3.1785938975434; 
 Wed, 05 Aug 2026 07:09:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e9ad922sm41341285e9.4.2026.08.05.07.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 07:09:35 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 14:09:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 673e321220a104f42914bd04adb1968a7b2d9112
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 14:09:33 +0000
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5e2bebb8e788d732b979883f16590625e65a4e0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrcJW-0000JB-6p
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: do not exit the
 process when installing a DCO key fails
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4408358857211126804=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4408358857211126804==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Fto/mOp0RVA="; charset=UTF-8

--Fto/mOp0RVA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, ralf_lici=2E

plaisthos has po=
sted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1835?usp=3Demail )

Change subject: dco: do not exit the process =
when installing a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

File src/openvpn/ssl=2Eh:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835/comment/72747949_f0138f5d?u=
sp=3Demail :
PS2, Line 235: #define TLSMP_RESTART   4
Since you explicitly =
link that to DCO restart in forward=2Ec maybe just give also a name like TL=
SMP_DCO_RESTART?


File src/openvpn/ssl_common=2Eh:

http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1835/comment/9ee4af76_5e7ca6cf?usp=3Demail :
PS2, Line =
202: };
Since that is only returned by the static method init_key_contexts =
inside ssl=2Ec would it make sense to put this just above that method?



-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I564edc6e0cc179c2b8b5dd=
ef5e80838949fe9fcd
Gerrit-Change-Number: 1835
Gerrit-PatchSet: 2
Gerrit-Own=
er: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ralf_=
lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Eco=
m>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: =
Wed, 05 Aug 2026 14:09:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
No

--Fto/mOp0RVA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, ralf_lici=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/ssl=2Eh:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
35/comment/72747949_f0138f5d?usp=3Demail">Patch Set #2, Line 235:</a> <code=
 style=3D"font-family:monospace,monospace">#define TLSMP_RESTART   4</code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Since you explicitly link that to DCO restart in forward=2Ec maybe jus=
t give also a name like TLSMP_DCO_RESTART?</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/ssl_common=2Eh:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1835/comment/9ee4af76_5e7ca6cf?usp=3Demail">Patch Set #2, Line=
 202:</a> <code style=3D"font-family:monospace,monospace">};</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Sin=
ce that is only returned by the static method init_key_contexts inside ssl=
=2Ec would it make sense to put this just above that method?</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1835?usp=3Demail">change 1835</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1835?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1835 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ra=
lf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-D=
ate: Wed, 05 Aug 2026 14:09:33 +0000 </div>
<div style=3D"display:none"> Ge=
rrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels=
: No </div>

</body></html>
--Fto/mOp0RVA=--


--===============4408358857211126804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4408358857211126804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4408358857211126804==--

