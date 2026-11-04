Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E30606A33A
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YcoeMgUw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Bnf3mBLA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LVotNVj0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=atTiCO3S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=18vMJYjkKcptkX/IBIr4WvCEIMpWxtB0WmUyAqTzogI=; b=YcoeMgUwWRsFHYJwoFkU+I9DBx
	ua23SkceezhVQlXo2H8XrJjSXjhFeNtQE7BLs22c4XGT0Kp6uUfQvvPHm8nDg41LCW5YEix9A1paf
	ofxl9qmninNGnJiSC9TZaj61QaS0GXZriXbtkjGLO50mqXg/8oTpA6D9x8V/MgzQ5x+8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xObb8-000000000SM-0zEX;
	Wed, 04 Nov 2026 14:04:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xObap-000000000Qj-2ydw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QQFbwGFXdo5wcoY7D0KV66JFglD72lcQT6TSjnuWez0=; b=Bnf3mBLAwMcdty5wAdiySYGQzc
 MYUqhw88QVLJMA+Szgpoa+Hms4IpRcU9p42e/x9q1MlrjOpOIH53L1HZZQHytqiOrbmkMIrvYpZEx
 8vUa6RgwsMvtweqbhSJq4dF77xKxC88nL2tfN8PEHgGxtNjcWwNFdy9Aym0JXSONMOl8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QQFbwGFXdo5wcoY7D0KV66JFglD72lcQT6TSjnuWez0=; b=LVotNVj0/BNG5aZJwTzpi78TFn
 86YfsrrrxfDgC+H7CGCtbDK8gLZmk/0blITfx2qxlaB50mURb2TTtC3JamPwOelw84PjWeZrz2Shm
 BhbK9776lUbVMU9+If/4OeKvnS1xqP1Li5vZjoR07EZNXwLXEkW17Gu6bG2C7OcD+Xus=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xObai-000000002UP-2GiV for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 14:03:59 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so6156435e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793801026; x=1794405826; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QQFbwGFXdo5wcoY7D0KV66JFglD72lcQT6TSjnuWez0=;
 b=atTiCO3SyhbK0GO/xP4AL5oDQcX1uf4QowIxREplImFMoTku4b/5FTOEgOEwLB6FFP
 qlF/pwBZhNaeqLc1PzPVN8yBv7KjcNt0pHAguJaM/dAp1zASyclQiNnpZ5MyI1h3OHgw
 kOfBKD2ZbE3F6C5gU8ilpOnwbi3ZaRW6YFIja6NnYCE/HKUp0uFGqjOjKN5lGhrdxsx5
 ZqYLowXBV/XwQIv+0E7rQY0aSTKpgqbRm6Hh4eTVjVaNNeYPjev0dmFNsiSAwZkSDiic
 ZYAAslTBiLGC23qotynGu+5HVCPxpgv4fLH4TqDScSAucVfvr1bne3W2PfpaIQAq1UZg
 wbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793801026; x=1794405826;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QQFbwGFXdo5wcoY7D0KV66JFglD72lcQT6TSjnuWez0=;
 b=Ga5TytVPqwO0UpNxh8CQ1zSTPsb15HAJrLWfCiM8QIAPxlCkIEgL2BaYi+Tl84xQiN
 dTiafaLSJJfbf77C7ZOw2Agn4j+C99z61Tg3KUSFf9beokLaeW+P7cH/8twxVQa/1qhX
 sz5grHIYFIQUPTXtLgoS1iropnjDBW0V8SipXhrZ8Nt73wh7gpA3WVDOccp6MbBRI8ZJ
 4Kats816gViuLI+bK1ipA5g5SdC0DmYKhEwyOfANJXf1WcfYiDBrmPf3x0pGBRdQIXBO
 E6DeU8tUrh5ZLNtK4aHLwEGThhv3a2CwgxlguuO0HpRF5YCkkCTntTmY5ji01ij5yIzM
 DGaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+2gAD79r4NYzC0PPfqKtXCSY4JGNtVlyNKFp1ZBbAr7oSEhRg5J4D9hmTX54YfjfIaGdN+zrS4cKww/dd@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9qEM/R6iHWsZmEr87C/RlN4BfFrcRxGVL0GBKqxugCtIk+Ia4j
 rSJdj02d8nWCEMJTGU8Fxeaf1vEFwF49QMizsJIGainOzsfVHfK1KtNPIctKdlTNGOOFcVKf9qv
 mhKEutezObHKOws3WjAbfTy+xl37cnVZyFE15ZUy9+7GtqXhDdX/FLKbW0GePKyTeWWKI
X-Gm-Gg: AYBFou1LvgJQMKUlXRaKBQLTvkYaIQuyz108W1NXYJiHE5j20VQFZwE4OsLzMyb9qQf
 jPrKVdtUqbh05WfQEwFnygeoM/GfPwy8jzUbpYiXK45E2tyozUZpRTgfhZ4xFFhcBs9+09AxXOo
 uLFh0+Yvwpm9SrVh3lkujHgqgpVnw2M2KP7DfELiOuy9ek+MvWohhiMw9NYCC4fksvWs4yHXbNg
 ytG77X5TEvYet+wHIVJ2Ntg3oofLdOjKrxNSzWBmfhtEHGPWu+T2zkoTk4hqr+kVv//uZqWER+M
 W0Y5R5dDdsToi7HPXqrJTrO+gbRuTcaSosNnXxTqr50/M+0yGqE9IZJPPBZF2ZrOPcqiub60uU3
 GfEEgHjoEuLmduGgOGvg5SUkTmzhCaoTzrI9lR445O2lGGtTPRBFXMF+r68NGlT0ro/Y04RqSxY
 qSaLF35p8VLhK0AFqKSvogWJouXOLLVOGDMZylwQ4At/r2RHMLfTIj+03Eu5nd8CsBv1B32AjxH
 EWzZdmt/vrm2RiBFpoOaNgtJ8Xi6MXN3g9NpcbLjMr27H1IL8D7ebZd/fzqLhYCIVluS012Vy+f
 B9VTUdZCO2riP4+S39XNoaCe180WVide9EDSbcdMmbna6yTHT7fQSV8DMNzOkpC5frYL9SQlX8a
 GeHTNhW4jsEf1PLlm/UIVNJSVquI/deF7Uz5S4Y/Lqhj0Cx/68PM2l13swi8MFLO2cBn6gqyZBH
 akw/Y7nDJbGXiI8Q==
X-Received: by 2002:a05:600c:8b0a:b0:4a1:777b:8a12 with SMTP id
 5b1f17b1804b1-4ac1709ae4emr394337815e9.14.1793801025811; 
 Wed, 04 Nov 2026 06:03:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab00ff3dsm259570615e9.14.2026.11.04.06.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 06:03:45 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 14:03:43 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55
X-Gerrit-Change-Number: 2132
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2132?usp=email>
X-Gerrit-Commit: c4ce73b3e17a4772502e33ffb40bbfef7266f126
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 14:03:43 +0000
In-Reply-To: <gerrit.1793800715000.Ib33ce23448959673affdfd462b4c2cfa9a015f55@gerrit.openvpn.net>
References: <gerrit.1793800715000.Ib33ce23448959673affdfd462b4c2cfa9a015f55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODAwNzE1MDAwLkliMzNjZTIzNDQ4OTU5NjczYWZmZGZkNDYyYjRjMmNmYTlhMDE1ZjU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <68883b3f657b0ca619c174ec835324fa1c662b9f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xObai-000000002UP-2GiV
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push_util: use
 string_alloc() instead of a local gc_strdup()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8091765114402418349=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8091765114402418349==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7qV6X1OAXDA="; charset=UTF-8

--7qV6X1OAXDA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2132?usp=3Demail )

Cha=
nge subject: push_util: use string_alloc() instead of a local gc_strdup()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2132?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib3=
3ce23448959673affdfd462b4c2cfa9a015f55
Gerrit-Change-Number: 2132
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 14:03:43 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--7qV6X1OAXDA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2132?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2132?=
usp=3Demail">change 2132</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2132?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2132 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 14:03:43 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--7qV6X1OAXDA=--


--===============8091765114402418349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8091765114402418349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8091765114402418349==--

