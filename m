Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4E606A31E
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g/BOnKQf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=I9lxPhX1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aydffLBC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JrHdVl/v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=c37mQ3p1yXyIWfq2I9y+2LP9P05upL5RjasV31ZAu3I=; b=g/BOnKQf0Tc+bYhKaLxGWVldFR
	/LnSavuj7omDPx4T+ua3VvkJyEudlBJ1L4maRBN+rhFdHs6VgRSnNe9lfVMzEWErkl+hiMjUbpJh2
	UC6qijtfKLBLrEi54/YxI3qrG6QII8wb2ZQAEqrDEwkwHB+UdgtrARWHlCF1YjfJNLdU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVY9S-000000002D9-2r38;
	Mon, 23 Nov 2026 17:48:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVY9R-000000002D2-3woJ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:48:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fu4tOETDcFejsJxMXcrmz36BDqMYnrrcDWcvsGtwDiI=; b=I9lxPhX1H9G/EFETLuDow0aOcn
 iAktx6At8SHpQ2dBzDnom1WMXBLGFJkwgg6P2H+vmlvB3ycL+wnUiPO3wXLewrBC3zPc0KRaWEx93
 Ta057ej09wOSNxS5PpXukixUEluXCW6Xp+aR5hWV/SFEi1jLRNF0XragvP9S3EyX7zD0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fu4tOETDcFejsJxMXcrmz36BDqMYnrrcDWcvsGtwDiI=; b=aydffLBC8WMdhPSpZyAZVEgq2T
 +UQ8qhyFAwS9tNxfKKzpHA3dA5Z1fxGJEqEMRzl8XWEptx/XnfQ+/VCQxrMEIZSUHZKHEEYWb1uAi
 cLQ4G3ZiiKzh6eQ/8m+M2geXpV5UKbA+cPYhA4XV1v/YLKo8e1om+UfOg9p8cjiyLCVQ=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVY9R-000000002G4-0eb4 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:48:25 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so2524239f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 09:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795456098; x=1796060898; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fu4tOETDcFejsJxMXcrmz36BDqMYnrrcDWcvsGtwDiI=;
 b=JrHdVl/vFK+qh9UaQDtuvVwjY9xVwle7+nFaD6DVGa3i/F8IjxKJ/QB7RuSmFSB73c
 1DpO7XjZK1I9zK34QOyfRTLOeWgfRCAosvS9vRyikgvEBM+3XvwsiAaZhOvDH+17P7sB
 fB45zhbtYH6xABvcWvn9F/qy9o9HyjK/dZQIPFcyEjoXoMol15vklQgxCb99SmUl5heP
 dPT+KRiP+4TbQEypEISXk1FLMhk+nb1Jtjfg9o+GWrhuQUfTmXE/E/e/3GTe+gK/qFjI
 LjbxK0lGXCffUNUTp8PZhkNuS+5kuRLQkoH5FxQLFvYe9UZ5i5zXHwqsKdoLRxRwI+cX
 otHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456098; x=1796060898;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fu4tOETDcFejsJxMXcrmz36BDqMYnrrcDWcvsGtwDiI=;
 b=i+EYFdBqC0Dl2j/kcpLKZMEtALyVqzJ/R8h4+4K8Ef2w1qO1T7RrkE0wrBCvaunzf4
 GEyMcGJxFbuazmVq+Eczr7ZSZnTu6dFk3B09zjcnrgByK4P15a/grwL3nwKOlLMGeRV6
 JDhWjL0dieKDDDnVKumYJGiOsKrQdce/ar92JASWIqvg93o4Tc6GTizFWgGKbMk1L6v4
 sqwci4hZa7eHoUECCLkFmfoK0eVZD+2ushzYyxDc3L2kUGFq901AAeN/DbYDlPySsmG+
 n/rg6tqmsjaLwUFyehkjLO2s5Gwr0SBq3KUz95Wqe0N2N2jXintGFrOW5MGAx+mnIj+c
 ebnQ==
X-Gm-Message-State: APuU4Z+sgnvkl2DhI3qc4HMKzO3NJmlX1EG7Qa1+QRTf1Bi0tELJpdOa
 2Nykijb7zQgVUlIYQrARMZxRhAj+2iBJTA//5rqzjoK31Gd4JljUd0fCLgaCTFmjEaYWlyWNJFC
 9b6QP5z+9PXce1JjdAijjPssVX3OU4mz5h4KzKTIPpAdQWzjIIgrSyH8CEw6jIvllUQy6
X-Gm-Gg: AZFdTZcI94IDO0gPdQc3OcPC1aU+ZgC4ZloDmks51MI2nZZJnL2PTY35nWhyta/VzKe
 QvXC4HNbiI6nYcUkoa0PnqNV1JhG6mYeHbMvOI5eID3e75cZbSoGYlpP61/ctEsZG/nPlq0dY1J
 44Z/Si0Iy8EUHnSQ1jsdoy0UN0XZbjDVgcN/XRi1dkWaW4Nw8a1vh5KlA61Rj928V4mebzRyUsX
 vAaJClgr/exNUYwidQlACYzLJoPN5pbUjp78f9Dles6gLrfTToaoUolM1XXDawfYxOCYoXC2+KH
 vNH7JVG/MNK0riAEe3Xx/gx8fccXdNGuGK9/Xq2ufjqDP7OB0HKhvRcmcGo8pruFn+TJLryGhU9
 U8qvPM5ZdQxfkyv1tG+qvg3V845g9z2Srpbzu1UYxnI5RHy/cnPJfe+UBGoi8hgv4m07+A1ONgr
 BLD4LyyH9NVTzfML4qlW6GpyvRoG5kd63DZ65TT7ZMQbn6yR7cp4iI2jkCUC0BkqPQon8WtIu3E
 dlpXmMFto36Ue8nx0oe0flSVAUjDDz0jEBNFggqzoKJ7URU9anAmMy+49/kek+BcR7yHqCgMGpQ
 NAxUMAmQ3UUzvmmXox5EFf9eFj/orl02iIxzx7VG7bP/tHaP/kM8DsA7U3c8MprDDvERYWAuefN
 QRXd94WRadeYs7TZ5IhCPeU12PBj4JavcEv7UAF9cQht8jcRs8m53qU0wTKpG/5jnHVUj6Cx8BS
 5lmjbuGagA5wrdewY=
X-Received: by 2002:a05:6000:2282:b0:48e:7833:2e7b with SMTP id
 ffacd0b85a97d-4aa4e01e1a6mr31272870f8f.1.1795456098275; 
 Mon, 23 Nov 2026 09:48:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm22015761f8f.18.2026.11.23.09.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:48:17 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 17:48:17 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36
X-Gerrit-Change-Number: 2330
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2330?usp=email>
X-Gerrit-Commit: f7a56d3206481b5aa8bb39723cdab03e3c503446
In-Reply-To: <gerrit.1795445611000.I9b2ed331b92212cf517568b0a0acecf5a97b2d36@gerrit.openvpn.net>
References: <gerrit.1795445611000.I9b2ed331b92212cf517568b0a0acecf5a97b2d36@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQ1NjExMDAwLkk5YjJlZDMzMWI5MjIxMmNmNTE3NTY4YjBhMGFjZWNmNWE5N2IyZDM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fc496f7ea78315b3f6f1b988fb8d09c05e7f7799-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVY9R-000000002G4-0eb4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_common: drop
 unused key_state.acf_last_mod
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2183308659703118583=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2183308659703118583==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+cKckDiyatM="; charset=UTF-8

--+cKckDiyatM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2330?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: ssl_common: drop unu=
sed key_state=2Eacf_last_mod
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

ssl_common: drop unused key_state=2Eacf_last_mod

Added in=
 47ae8457 and never read or written=2E

Change-Id: I9b2ed331b92212cf517568b=
0a0acecf5a97b2d36
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Ac=
ked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2330
Message-Id: <20261123152105=2E9130-1-g=
ert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg41836=2Ehtml
Signed-off-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_common=2Eh
1 file changed, 0 in=
sertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/30/2330/2

diff --git a/src/openvpn/ssl_common=2Eh b/s=
rc/openvpn/ssl_common=2Eh
index 436770b=2E=2Ecfe3fea 100644
--- a/src/openv=
pn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -263,7 +263,6 @@
    =
 unsigned int mda_key_id;
     enum auth_deferred_result mda_status;
 #endi=
f
-    time_t acf_last_mod;
 
     struct auth_deferred_status plugin_auth;=

     struct auth_deferred_status script_auth;

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2330?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36
G=
errit-Change-Number: 2330
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--+cKckDiyatM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2330?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">ssl_common: drop unused key_state=2Eacf_last_mod<br><br>Added in 47ae84=
57 and never read or written=2E<br><br>Change-Id: I9b2ed331b92212cf517568b0=
a0acecf5a97b2d36<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2330<br>Message-Id: &lt=
;20261123152105=2E9130-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41836=2Ehtml<=
br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =
src/openvpn/ssl_common=2Eh<br>1 file changed, 0 insertions(+), 1 deletion(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/30/2330/2</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_common=2E=
h b/src/openvpn/ssl_common=2Eh</span><br><span>index 436770b=2E=2Ecfe3fea 1=
00644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ =
b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -263,7 +263,6 @@</span><br>=
<span>     unsigned int mda_key_id;</span><br><span>     enum auth_deferred=
_result mda_status;</span><br><span> #endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    time_t acf_last_mod;</span><br><span> </span><br>=
<span>     struct auth_deferred_status plugin_auth;</span><br><span>     st=
ruct auth_deferred_status script_auth;</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2330?usp=3Demail">chang=
e 2330</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2330?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2330 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--+cKckDiyatM=--


--===============2183308659703118583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2183308659703118583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2183308659703118583==--

