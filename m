Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30087C43327
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QNL0u3hJFGwKFutwJkqjZeFgTXnoutawgKhF1aL+Gfo=; b=hNGVgBRsSDdPUD6yYMqj39G6fk
	4fvKlEz1b8Vhrcj6PDg9rHuEvcqCjPCfRyCwdKYxX5wxv01BKCwgZa/81EcvSgbFg3ELBNO4twW5b
	A1bqJiqQ7V4HwsqP1xnbEdbYarF5QGLzalMP6dMCAM5ee5ynup5LU9p7UTq5D+45A+kQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wepm8-0003F2-BD;
	Wed, 01 Jul 2026 07:54:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wepm7-0003Eu-G6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 07:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RKiYAOX/dxdXAmlSjvE1wwvdK7D+nNIKUZV+Pgep1aQ=; b=Sf1TK70pgeAgLQvvpSDQjn6mc/
 1ogLQKml4ZJvss8ybdscosA1RVOV03C2zETC1fxW/tveBX4Ruz+bAYXJuq3y4jnobFkdtfS1NS6Cq
 4II3sKl1UzotctunyemaOOHYLK38Ew+rZ2/uTrb9V0x6WNduMKy8hxl3/YIfcJmo9aJ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RKiYAOX/dxdXAmlSjvE1wwvdK7D+nNIKUZV+Pgep1aQ=; b=l
 IxQ1y4l8wAPLIzaRiOM90E9nRIlf51HuCXjqZcvyg3pwaunI8OI2eBYr1bDgINQEirfPBvaJIlZff
 X0xkpmzdM560mE1IjYuPMEGa+4Y+p+7ZMYJt3nxKTNLAZbG52JEhvSVnVNw52rInfbDGTucW+iC2h
 KZmKKb9R6NYC0m3Q=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wepm3-0004Yn-QJ for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 07:54:24 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493ba701891so2279285e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 00:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782892453; x=1783497253; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RKiYAOX/dxdXAmlSjvE1wwvdK7D+nNIKUZV+Pgep1aQ=;
 b=UNmuv+UUpnD1NTF0Lt0GirGn99scdDvMNd6PMzBbz+y/fPCeMsvU58iecgIMtUTNcU
 4gUoje9orpAouUkPqGqcJ0ZsSNrwxzjhFfA6uH/PmwJaV+dQ0UqAkxqPPpJx2uwNRfUV
 dYIK+huJfmejUMDHshF+SjAZgO9miEBChD6jpW3DMzsrTWsiQQReFWabchvO0gmIISG7
 AtDGmGddNDDhFAn0ND/B5C+79Uvthl8OPYj8wCDEASg0bmAt4teA/3XXL39yjByqGVYG
 qOFsCSrXzqKxCoYQQAw77EFsgCl6arhhyeFgg2gFhXUPNbrA7GfRJ32HQNyPfaeNydND
 t8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782892453; x=1783497253;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RKiYAOX/dxdXAmlSjvE1wwvdK7D+nNIKUZV+Pgep1aQ=;
 b=IXgH5WYeMqpVy3DdQzhVYflKJ4bkaoeso5+swBmtfYuc8psHaF1U8xImeBWnj02LaZ
 ioclzBiCKegYWPnwbAuXeN9sTxoIau3o1c0RA8gYWdRvu8tQvyVBoRECPwwVvbEilpzF
 a+k3YTUQHPpuJBXQMxYzQ7c0+nRy1R0RAFohmITRhSLqf82nUvyz+x4OHWK7m59FEGJO
 Vm3y3Q7z257k062fZGLGOOoR5cSU5Y5V8ifPuE7EIgUGzlaGbEjzs8+0ZO21JyAbOnEc
 /y8vicdygdlsg1U62vWgYNNuQ+l7waq7U/8A3/5yV4iCJfodRfaP6RggvYU8tN2oR0Nc
 Gz2Q==
X-Gm-Message-State: AOJu0YyjcpD54YSmDRy3XMO4gIOWGfJjx0ucx6kCVW7XaRntwjXRYx5o
 pNPVKYudoUWVogHBAbKKao+yLHrQ2mSIWcLU/FRpBhrIKL4/eyuvmnrv7nIJOt6Dm+QUUON2CJ6
 RDca2W/7tDeyGRwhmrhLOmsLFGoldYVDqN260dZ5pwkSv+bdf1HgzsdhknFhIH9+NhIZa
X-Gm-Gg: AfdE7cl+ztAVPz388chuumHirjZyUwxPZAw9eYN/0VBHPyC++R0AIlqhS22h8uVu9O8
 ejRl+9YRMYJ18jvtJFH0pBbQEPlH/wDmBW73PO64x5bQ6LRPvcei3dCSuzHV7giHvwWqyU4+6VI
 v0BKmeSG9ysxo9HBOGhquuFzpnFyuyfP6sSmeVOgBzT1EyK+k2tkfTj2TbgCmHqYPulsrNZ7UU6
 pqzPcRbIXzTDkpQpi5i/RmqQSCcWQcSdocibPfPt4TPAtei20tY7Xm7bLsSqTmFgDo56TLXzF4+
 dqAi5RZ+WQ5CJKtQEkuuEWmpHKyZOwgNqqHUKEiAu2eCYPXWUYC+nMwhe7Cb/lxojN+xHD0QjMm
 ArXswtnN6KRg0/RlodQDJsugXJsOZbRyz82HAgt4xVWk1zlZoK08j+vfBMdzOxM4KaDqjKG70FR
 Iwwbc7hYkfBlYghX8W1zw0nOxWKNxDwAJ1rRD2t3vtaxKXu2H8ZGRypAksRHqHzvua6ByZ+61GD
 yR+/Tb+Pp1eXRWpA0WYqXG/CRUSa6h07eJ6NXAAhffKAOZDUVGanez6hr+vDbbHrAIakLPiWIow
 Ya0=
X-Received: by 2002:a05:600c:6217:b0:493:bc4a:c6b5 with SMTP id
 5b1f17b1804b1-493c2bb1ba0mr6877465e9.39.1782892452429; 
 Wed, 01 Jul 2026 00:54:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4d2a9fsm60617115e9.6.2026.07.01.00.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 00:54:11 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 07:54:09 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id8945dce437da11e6fecae9550c3be52e393d4cf
X-Gerrit-Change-Number: 1760
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1760?usp=email>
X-Gerrit-Commit: cda2f2533c27f37cfe7a741c9e042a54740e377f
In-Reply-To: <gerrit.1782883869000.Id8945dce437da11e6fecae9550c3be52e393d4cf@gerrit.openvpn.net>
References: <gerrit.1782883869000.Id8945dce437da11e6fecae9550c3be52e393d4cf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODgzODY5MDAwLklkODk0NWRjZTQzN2RhMTFlNmZlY2FlOTU1MGMzYmU1MmUzOTNkNGNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f19c8ab6c60d6ed13da6a4794beecb1031e74c4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wepm3-0004Yn-QJ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco.c: fix argument
 order in dco_install_key() log string
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2027651688648720648=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2027651688648720648==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/NJm+DJX6ZI="; charset=UTF-8

--/NJm+DJX6ZI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ralf_lici=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1760?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
cron2


Change subject: dco=2Ec: fix argument order in dco_install_key() lo=
g string
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco=
=2Ec: fix argument order in dco_install_key() log string

The debug log in =
dco_install_key() has the epoch and dco_keys_installed
arguments swapped=2E=
 So a line like epoch=3D1, currently 0 keys installed
actually means dco_ke=
ys_installed =3D=3D 1 and epoch =3D=3D false=2E

Use the correct argument o=
rdering in the log string=2E

Change-Id: Id8945dce437da11e6fecae9550c3be52e=
393d4cf
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
Acked-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1760
Message-Id: <20260701074122=2E28795-1-gert@greenie=2Emuc=2Ed=
e>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg37418=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/dco=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/17=
60/2

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index f5b7081=
=2E=2Ee944547 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@=
 -57,8 +57,8 @@
 
 {
     bool epoch =3D ks->crypto_options=2Eflags & CO_EP=
OCH_DATA_KEY_FORMAT;
-    msg(D_DCO_DEBUG, "%s: peer_id=3D%d keyid=3D%d epo=
ch=3D%d, currently %d keys installed", __func__,
-        multi->dco_peer_i=
d, ks->key_id, multi->dco_keys_installed, epoch);
+    msg(D_DCO_DEBUG, "%s=
: peer_id=3D%d keyid=3D%d epoch=3D%d, currently %d keys installed",
+      =
  __func__, multi->dco_peer_id, ks->key_id, epoch, multi->dco_keys_installe=
d);
 
     /* Install a key in the PRIMARY slot only when no other key exis=
t=2E
      * From that moment on, any new key will be installed in the SECO=
NDARY

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1760?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id8945dce43=
7da11e6fecae9550c3be52e393d4cf
Gerrit-Change-Number: 1760
Gerrit-PatchSet: =
2
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <ge=
rt@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--/NJm+DJX6ZI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by ralf_lici=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1760?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">dco=2Ec: fix argument order=
 in dco_install_key() log string<br><br>The debug log in dco_install_key() =
has the epoch and dco_keys_installed<br>arguments swapped=2E So a line like=
 epoch=3D1, currently 0 keys installed<br>actually means dco_keys_installed=
 =3D=3D 1 and epoch =3D=3D false=2E<br><br>Use the correct argument orderin=
g in the log string=2E<br><br>Change-Id: Id8945dce437da11e6fecae9550c3be52e=
393d4cf<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>Acked-b=
y: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1760<br>Message-Id: &lt;20260701074122=2E287=
95-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg37418=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco=2Ec<=
br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/176=
0/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><b=
r><span>index f5b7081=2E=2Ee944547 100644</span><br><span>--- a/src/openvpn=
/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -57,8=
 +57,8 @@</span><br><span> </span><br><span> {</span><br><span>     bool ep=
och =3D ks-&gt;crypto_options=2Eflags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;=
%s: peer_id=3D%d keyid=3D%d epoch=3D%d, currently %d keys installed&quot;, =
__func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mult=
i-&gt;dco_peer_id, ks-&gt;key_id, multi-&gt;dco_keys_installed, epoch);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &q=
uot;%s: peer_id=3D%d keyid=3D%d epoch=3D%d, currently %d keys installed&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        __func__=
, multi-&gt;dco_peer_id, ks-&gt;key_id, epoch, multi-&gt;dco_keys_installed=
);</span><br><span> </span><br><span>     /* Install a key in the PRIMARY s=
lot only when no other key exist=2E</span><br><span>      * From that momen=
t on, any new key will be installed in the SECONDARY</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1760?usp=3Demail">change 1760</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1760?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Id8945dce437da11e6fecae9550c3be52e393d=
4cf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1760 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body><=
/html>
--/NJm+DJX6ZI=--


--===============2027651688648720648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2027651688648720648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2027651688648720648==--

