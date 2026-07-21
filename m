Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DF1C44529
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2DymKvoBPxUbKxta4k4O/bN+xARPOD5U5jkQghsA+Bs=; b=TpY4ydDzY96QPYlaP+FDWqqezK
	NrLFY27o+V8THZNJg88vEQqfe/xEaAsDcpyAhb4NtmZFQbz935dXi6inGLPQzchJb0fv4HkUsO2e7
	J5/h8uRNE3dCtk1aDSkn91PNw2lbs1L9pMNwk5gA8JdxNA9xV+Fny3sj0XbdDWwZ7gJo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm4Ej-00050s-Ca;
	Tue, 21 Jul 2026 06:45:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm4Ei-00050k-0u
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 06:45:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=e04lUKUW4vkn6ZMjgB095Pi1Sg3lhfkOP/Q+wzkR7MI=; b=kJvNz6hmQ+AlRAtNPSRth1Qwuv
 Y8wEQQjgvme4+59DZoUk2mlzJSQCLu+3xO8oLdBKiqkFeKPTB64a8iHXuSPjPwwew1qxN4av9olh7
 uVNmGsew2PNvd+8gwDk/QhMih6ZnwPqG1raWzQBSKzO10BzJj4rQqWtYbTdaV8RhtJdE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e04lUKUW4vkn6ZMjgB095Pi1Sg3lhfkOP/Q+wzkR7MI=; b=E
 LCzcUet2u+6egyfpWxQS/nZ9JlXFnoZc1tirfxWNSBI7eph4cB0dOouNOkAU+zhx0g8KSlasNKI1s
 No4PLWCI3F3A2PT2uZDJn7gxtTi2S6TO3BcIrXlE7phkNP4XLbcwqTIokTQfmuBug4JWxenMPuAql
 Xl1/U5/sFlfSJrXA=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm4Ed-0007uT-QH for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 06:45:49 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so85786075e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784616341; x=1785221141; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e04lUKUW4vkn6ZMjgB095Pi1Sg3lhfkOP/Q+wzkR7MI=;
 b=dN6jix7Uv1jOWKYuhRcFYydady3vXMxdsJqQlF9Ev2pX0zO3KBuiAPBZPr0Wia23RV
 xlVu4wJwtwORXtijjLfIadfpXTvGUAKDAuSEIieTCs4hMxRUUcPYb2SSPKY1tcpqEiYy
 zR1fl9VjML7DAze4h2xjI1lWUsTKLSqCZqm560cjgaAGfsKhC5A6BDEJCiR3JJ60RMi1
 V9onU/cAUeowcTlU7R7OGV7V1mMa/qbgOodoTPfcf3X5QBJpELHJKe16BTbVP+swss+f
 o/kl93eLfQ6eQR/QlNkjlgf8/AnaMnh8sgIfAj1kZFCkAF9S3mFKLsy5hbqnpE9DzKaO
 VH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784616341; x=1785221141;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e04lUKUW4vkn6ZMjgB095Pi1Sg3lhfkOP/Q+wzkR7MI=;
 b=AFgD9T94xuq+OxjLpzns1mY3olqbdc/iBFF7e1vyD92VLqr2Jn4/U+eDFqZVp8JInv
 tmw1cyDmMd4rx8oD5s8C4H7xm+XEsOmyadTtcsBwMrLxVpstz6Qcc0zJwy/vvoPhPqvr
 2r2uxsIsizpM4Fa0ZkV+IOnw2EnG1rRFnjAqq2CT2oJS+aeC0JHRMEEocFKiJsIoVPIY
 3axwZQXt1OS2KNMsmakVZAiUOxkGeVTR2bmnnd228tTYgbdvl49w69ip5BNqgMww+fma
 tHh4WgUK1PM2R3GooRwDZyEVxgokibRMTvVnQFsYz3GDaGq54YpmbeNUIyhVgjwhB2ua
 Q6gA==
X-Gm-Message-State: AOJu0YyWpmOWDSyNKLLK7jUlEwdZCaYgIJw1C7BMYVDo9k7j3d1Ig3x+
 o4R9+gBVQOnj77OxZSgwf/mp63LOgAE/PqoldIiaw7Lmhqn/UuWz2ZrtjWIj9VQFLJmLDuxdw8D
 m7gPP8jV1zUGcv5scVgnblIAdhernYp168+4A0EaItSYkvpYIp4rIk6XQUnGiyQdeYcN152vOkT
 4h7Ycm1Q==
X-Gm-Gg: AfdE7cnG5N8zJyVhkVzdd/s0CR5SVuLXKuWeIworCEDDmG2S02RNJPZ4+Nvao3MePIY
 y7sv72bgo0DL7Y8qpdOs0AyxBEz2N6fnMeKE7qHmdSlvnp0u1rMjzQK2jxQi/u8BXUuT+JnxXH/
 COt/r/5eidrnXIqoKVS1MpwCkbgSvwBOvAslfcWsaMKGnyPsyFqcJHfRbroh9usgsQrf1GfMk5W
 1vheizCp3i8edjJHxRJsLjGGI/ivjPJ3y/+k5R+fnCOypTsK2b04Xi1jY01s9Se4b27G8H3tsDX
 ZRa5oNb/1L7dfAEfNFbfEUliVKjQj0Ayphe3QTUzdyfZLVSJ3mr6bfdrrozp3yPhZdgAglBBfnD
 p+0q8v1VLjzkKfxKGVOzJ6XaRR/GIjF+FJD3BMv0lQ8FOunrjB0uj0shRZSnL7/Ra7FcDWyLv5n
 K9OvknrBj6HUpmn5Mf8yKyOj9tMOc2NilAzudb2DgCyZ0gpFOWEyR2KrRZ49GGcFSpU8HQJULZt
 TPlv9E+CKavs7qi2jSpux8MxZlCCIbJ68LUfmombW4LaKNMTzfz1MfMjTMywVacCm8W
X-Received: by 2002:a05:600c:4f94:b0:493:d741:5d72 with SMTP id
 5b1f17b1804b1-4954a513ef9mr184080865e9.38.1784616341052; 
 Mon, 20 Jul 2026 23:45:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956546db86sm43142765e9.2.2026.07.20.23.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 23:45:40 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 06:45:36 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5295e5d26c5bf60cd9607da4c804d04f2144634a
X-Gerrit-Change-Number: 1796
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1796?usp=email>
X-Gerrit-Commit: 4ad3c71ec4bdad706332d0281a3bb3bba0234288
In-Reply-To: <gerrit.1784537981000.I5295e5d26c5bf60cd9607da4c804d04f2144634a@gerrit.openvpn.net>
References: <gerrit.1784537981000.I5295e5d26c5bf60cd9607da4c804d04f2144634a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTM3OTgxMDAwLkk1Mjk1ZTVkMjZjNWJmNjBjZDk2MDdkYTRjODA0ZDA0ZjIxNDQ2MzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5eccb577840a6ee9dad33d285986c65888de6578-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm4Ed-0007uT-QH
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: silence autoconf
 warnings about openvpnserv_testdriver_CFLAGS etc
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7194566203912880010=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7194566203912880010==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yvsp2AV1NqM="; charset=UTF-8

--Yvsp2AV1NqM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Plea=
se visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1796?usp=3Demail

t=
o look at the new patch set (#2)=2E

The following approvals got outdated a=
nd were removed:
Code-Review+2 by flichtenheld


Change subject: silence au=
toconf warnings about openvpnserv_testdriver_CFLAGS etc
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

silence autoconf warnings about=
 openvpnserv_testdriver_CFLAGS etc

Github: OpenVPN/openvpn#1079

Change-Id=
: I5295e5d26c5bf60cd9607da4c804d04f2144634a
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1796
Message-Id: <=
20260720113838=2E19668-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37699=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/open=
vpnserv/Makefile=2Eam
1 file changed, 1 insertion(+), 0 deletions(-)


  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/1796/2

d=
iff --git a/tests/unit_tests/openvpnserv/Makefile=2Eam b/tests/unit_tests/o=
penvpnserv/Makefile=2Eam
index 6294c52=2E=2E19de666 100644
--- a/tests/unit=
_tests/openvpnserv/Makefile=2Eam
+++ b/tests/unit_tests/openvpnserv/Makefil=
e=2Eam
@@ -5,6 +5,7 @@
 if WIN32
 test_binaries =3D openvpnserv_testdriver
=
 endif
+check_PROGRAMS =3D $(test_binaries)
 
 openvpnserv_testdriver_CFLAG=
S  =3D -I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/=
src/compat -I$(top_srcdir)/src/openvpnserv @TEST_CFLAGS@
 openvpnserv_testd=
river_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1796?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I5295e5d26c5bf60cd9607da4c804d0=
4f2144634a
Gerrit-Change-Number: 1796
Gerrit-PatchSet: 2
Gerrit-Owner: cron=
2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--Yvsp2AV1NqM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1796?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by flichten=
held</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">silence autoconf warnings about openvpnserv_testdrive=
r_CFLAGS etc<br><br>Github: OpenVPN/openvpn#1079<br><br>Change-Id: I5295e5d=
26c5bf60cd9607da4c804d04f2144634a<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1796<b=
r>Message-Id: &lt;20260720113838=2E19668-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg37699=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M tests/unit_tests/openvpnserv/Makefile=2Eam<br>1 file chan=
ged, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/1796/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/tests/unit_tests/openvpnserv/Makefile=2Eam b/tests/unit_tests/open=
vpnserv/Makefile=2Eam</span><br><span>index 6294c52=2E=2E19de666 100644</sp=
an><br><span>--- a/tests/unit_tests/openvpnserv/Makefile=2Eam</span><br><sp=
an>+++ b/tests/unit_tests/openvpnserv/Makefile=2Eam</span><br><span>@@ -5,6=
 +5,7 @@</span><br><span> if WIN32</span><br><span> test_binaries =3D openv=
pnserv_testdriver</span><br><span> endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+check_PROGRAMS =3D $(test_binaries)</span><br><span> <=
/span><br><span> openvpnserv_testdriver_CFLAGS  =3D -I$(top_srcdir)/include=
 -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat -I$(top_srcdir)/src=
/openvpnserv @TEST_CFLAGS@</span><br><span> openvpnserv_testdriver_LDFLAGS =
=3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1796?usp=3Demail">change 1796</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1796?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I5295e5d26c5bf60cd9607da4c804d04f2144634a </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1796 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--Yvsp2AV1NqM=--


--===============7194566203912880010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7194566203912880010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7194566203912880010==--

