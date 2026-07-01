Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D577C44503
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfDEbVP1cQ4S0LERO4P3EYPd0K3hNW+aggOKtFU0b5M=; b=kjETGOmdwtdL4DAo3pjgDd4w7D
	bBPIe2eAoc3KbMyoQUKxezCWE8Mts6vbmweaqBE4FFkbf/fUO+Z/23eE6CKlT2WZt2xbQ85KxsB1Y
	Bfciwwa/Fx4BL6+F5yLTmDbIlsQ0BhUwG9Sg5Kn7I5QQnZxlpjMXA3ib/S+y2ZD5Y99U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wepmB-0000I8-0m;
	Wed, 01 Jul 2026 07:54:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wepm9-0000Ho-EW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 07:54:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Fw8VNa3BBfgyODGQeFWMK6IRpGLOH4mqtDSo05YE3ek=; b=beYbCwdSNFq7xrWiDLYDY2k9lU
 piikNdiXF91KQnt0QGhSJKtocKgRX4quDeDarchWuRYvO77S2TvSkutF0tghl0ITfG04KMd/c1/54
 MBcCT8mcbDb8rJgHHD5D+pZJw/k7TWF5pC0jLOLsdhRzzlp1kw3aq81AyFMqSEuLK3nc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Fw8VNa3BBfgyODGQeFWMK6IRpGLOH4mqtDSo05YE3ek=; b=g
 HA3K+y6taNq0g0OACTThEtPihwcA8eLHrBpLZtOMdxUZqDW4SKBm0ZaBEIHsaOAI96h37SWqVM2Ak
 nWrMgdE0HUhvPKpV1pVA7qmcBANphr1Q5bkFJe57AEAvbHlBIhQ6Fad8KtmMsw6Xem2g32ZdoVnAs
 CthL/sIh2a+oNY0I=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wepm6-0004Yu-Jx for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 07:54:29 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493be1b9682so2421085e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 00:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782892455; x=1783497255; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fw8VNa3BBfgyODGQeFWMK6IRpGLOH4mqtDSo05YE3ek=;
 b=RgeM27EK9s/P2FPl0DWvbtjuPA3WqNma0EKvTRBPdMwbh8rR8mXoF9HQdFkIWMqAYJ
 +eJo5pCK8KjsvUUD/PGrUmDMU2S5z9lo9N0QSZe3+rHDFibD6EJkZHhCLvE7wxOaQjRQ
 +kcTj6lpH/VaeBGx9OhDhKUgVobmcJSTNLTWsfu6TrfCY4ZQNjJTYyAkeGkm2o5HSz7H
 j3KuAFHSELhRNuYExmFpqkQT39tZPz47d43GPvJC00acyEBEUyfdkPHdB8+JGE586ol3
 kgnKolnqdyn0hAb8cnOxZuW4aDoiRJkSL/rUOhCEEyEPjcEQkvqqEl/yVW/YycpM3uZG
 Y10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782892455; x=1783497255;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fw8VNa3BBfgyODGQeFWMK6IRpGLOH4mqtDSo05YE3ek=;
 b=TFu3TSjbLZhGUxILVCaMnOWaRSxDtV+eFpH9udJRzQJiYtTxhLwowo3zJwDD1UVZG7
 QyP9oE8H5EFK/egZOmDJXW2UtTUYHXiLjL6VfZGTkbngCxMd6oR9s1+a3EepOVrsuEQb
 pXWZ5PBhZDzQi9QtRc/qcUEn6y69+PqPgRiP2e0lHvNZWGyqwFfHbueYmoQQI/9wtJYT
 v6AyX6nEv8edjBnUj3viQ6VLbxRErLSH/aXcHY9BHB9JU7zEuabSp5tHZKw7Xd1c1LE7
 dI/c2WTE3NsdJJkrjtKnDJQGi4WImt98btP6GurtRfwAV5I22Vn2j7kdnH/2Y/07ySjF
 30jg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yCoq1SAvePZBy3AabZ/OG43h0a8hNtvlMIgarr6plF+0Of0/Hcegilff+WeLNCOfB2mtdoa3XOsHL3M77@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwG8AWhX9KoRdj/9LeXS+wIDBSNAPSIbnrv03uN8+FKRS5TAKR5
 hrmtCh7hwppCLkrgM91/wbOg0poEJXAuIexL/nN5Qw7bmYudZ9Lf/7k6Fx1q8GpNN9CloFZLJ3c
 Q+SfVC8vP9kngpOidkFr9U4d4pHaWZ+0+ha4j2qBg0ymdvFFCs3FwC6e0SrEb8VuVPI27
X-Gm-Gg: AfdE7clU27bswi015ai/I41Ib9XFGV6URirkwTMM5MkRW2f027MpU94ovNhds6u6qi8
 P2AKSLoEgQ/rcIfb++fmoxE95BGN2VR0FjjXZ8Njb1rSfAN02JSw3mE8fiUxYhSsxdPcmlmwT0c
 dMfhOTyabpyeHUKtf6fgtQ3tknlrB+mi3phEFa1LZJrYXRYA8rTgOyY7vgNW5mMAxNr/mp8lSkZ
 bEZOqT4ZAKPkdaE+nTsaraiF0NAyr7oKeP/uSwep/d0QvpMehAhVB0QmboL1cjIXhc9wCxJx9+S
 8CfcyHz7No6lg2OP96e3+WZWS0uzB+8bNVzLOUqymlRtlxZpzsdmLr9o9gOY86FoHw7Gvnl4Lds
 rf3jM9S9qtSiPsv90EwNaGD5PeP7MxAAyM7vYxMevZV4wW9RkQ/uvpR+T0mGIcdt1vkkShJZY0g
 j1UAqcuh1rY34VBJm+fY8dl/6u6PeuNGFTlyxNPssyn3gl14GTOFgkR99bx/Pc4tEqL+GZp3imd
 5b1MAgOjgE2lYLqHm2ROG01L5MaFfHYVniaUgPfF0ESmtpNgfXPi0WGAXicT8mM7h/Awpe2psTT
 EydHJKorlciliA==
X-Received: by 2002:a05:600c:8217:b0:493:bf88:edbe with SMTP id
 5b1f17b1804b1-493c2b7d9c7mr7706605e9.19.1782892455012; 
 Wed, 01 Jul 2026 00:54:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4bfdd5sm98151945e9.1.2026.07.01.00.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 00:54:13 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 07:54:12 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id8945dce437da11e6fecae9550c3be52e393d4cf
X-Gerrit-Change-Number: 1760
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1760?usp=email>
X-Gerrit-Commit: cda2f2533c27f37cfe7a741c9e042a54740e377f
In-Reply-To: <gerrit.1782883869000.Id8945dce437da11e6fecae9550c3be52e393d4cf@gerrit.openvpn.net>
References: <gerrit.1782883869000.Id8945dce437da11e6fecae9550c3be52e393d4cf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODgzODY5MDAwLklkODk0NWRjZTQzN2RhMTFlNmZlY2FlOTU1MGMzYmU1MmUzOTNkNGNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f19c8ab6c60d6ed13da6a4794beecb1031e74c4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wepm6-0004Yu-Jx
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6561691585932450984=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6561691585932450984==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tEMfj94b8u4="; charset=UTF-8

--tEMfj94b8u4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1760?usp=3Demail )

Change subject: dco=2Ec: fix argument order in dco_=
install_key() log string
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

dco=2Ec: fix argument order in dco_install_key() log string

=
The debug log in dco_install_key() has the epoch and dco_keys_installed
arg=
uments swapped=2E So a line like epoch=3D1, currently 0 keys installed
actu=
ally means dco_keys_installed =3D=3D 1 and epoch =3D=3D false=2E

Use the c=
orrect argument ordering in the log string=2E

Change-Id: Id8945dce437da11e=
6fecae9550c3be52e393d4cf
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
Ac=
ked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1760
Message-Id: <20260701074122=2E28795-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg37418=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/dco=2Ec
1 file changed, 2 insertions(=
+), 2 deletions(-)




diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=
=2Ec
index f5b7081=2E=2Ee944547 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/=
openvpn/dco=2Ec
@@ -57,8 +57,8 @@
 
 {
     bool epoch =3D ks->crypto_optio=
ns=2Eflags & CO_EPOCH_DATA_KEY_FORMAT;
-    msg(D_DCO_DEBUG, "%s: peer_id=
=3D%d keyid=3D%d epoch=3D%d, currently %d keys installed", __func__,
-     =
   multi->dco_peer_id, ks->key_id, multi->dco_keys_installed, epoch);
+    =
msg(D_DCO_DEBUG, "%s: peer_id=3D%d keyid=3D%d epoch=3D%d, currently %d keys=
 installed",
+        __func__, multi->dco_peer_id, ks->key_id, epoch, mult=
i->dco_keys_installed);
 
     /* Install a key in the PRIMARY slot only wh=
en no other key exist=2E
      * From that moment on, any new key will be i=
nstalled in the SECONDARY

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1760?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Id8945dce437da11e6fecae9550c3be52e393d4cf
Gerrit-Change-Number: 1760
Ge=
rrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Revi=
ewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>

--tEMfj94b8u4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1760?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dco=2Ec: fix argument order in dco_install=
_key() log string<br><br>The debug log in dco_install_key() has the epoch a=
nd dco_keys_installed<br>arguments swapped=2E So a line like epoch=3D1, cur=
rently 0 keys installed<br>actually means dco_keys_installed =3D=3D 1 and e=
poch =3D=3D false=2E<br><br>Use the correct argument ordering in the log st=
ring=2E<br><br>Change-Id: Id8945dce437da11e6fecae9550c3be52e393d4cf<br>Sign=
ed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>Acked-by: Gert Doering=
 &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1760<br>Message-Id: &lt;20260701074122=2E28795-1-gert@green=
ie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg37418=2Ehtml<br>Signed-off-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco=2Ec<br>1 file chang=
ed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index f5b7081=2E=2Ee944547=
 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src=
/openvpn/dco=2Ec</span><br><span>@@ -57,8 +57,8 @@</span><br><span> </span>=
<br><span> {</span><br><span>     bool epoch =3D ks-&gt;crypto_options=2Efl=
ags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer_id=3D%d keyid=3D%d epoch=
=3D%d, currently %d keys installed&quot;, __func__,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;dco_peer_id, ks-&gt;key_i=
d, multi-&gt;dco_keys_installed, epoch);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer_id=3D%d keyid=3D%d=
 epoch=3D%d, currently %d keys installed&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        __func__, multi-&gt;dco_peer_id, ks-&gt=
;key_id, epoch, multi-&gt;dco_keys_installed);</span><br><span> </span><br>=
<span>     /* Install a key in the PRIMARY slot only when no other key exis=
t=2E</span><br><span>      * From that moment on, any new key will be insta=
lled in the SECONDARY</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1760?usp=3Demail">change=
 1760</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1760?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
d8945dce437da11e6fecae9550c3be52e393d4cf </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1760 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ra=
lf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--tEMfj94b8u4=--


--===============6561691585932450984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6561691585932450984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6561691585932450984==--

