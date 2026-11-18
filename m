Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328B5606A320
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OYFbVgYG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=A/piHwal;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ni/5B5w8;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IsaFuHRP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UVm8pyqhMgF9I1Jem+7XcysUyeiVQoTeAgZ8mTiwFyc=; b=OYFbVgYGwZIyZak0b5DAoiu+pl
	uf5kzScojaiIyRYqHx+rUGfP1I7+LRVZDH/FFCBenSvNl5XXdhnEp6K4kB3ggh1Kkcod3w+s3+RnT
	f27DEdMucL2dxg7L/RZwhZswv02IRhGL743ZsBj90HThw94MAmvqrYcPSBf6a2kyGQW0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTgsX-000000004H6-3lWs;
	Wed, 18 Nov 2026 14:43:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTgsW-000000004H0-0HFX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:43:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7lVh4c4sBn0tkh2+cpaDiVFvswbT/vmhZ0NJ6GtfJDU=; b=A/piHwalQOa/R6p0FYfdbCh5fv
 DIULz5Qlz2lSWeeqPsW3wqoTlItJ98fBP/pvbM+/wOoMHwq8dd6doxMyPpyikGLxEVDQw3jtlQ9FQ
 J/X+oSt1Q19/qCb4VjahFkn7tGuHc/4PLvEPxncdHPerWym3RD2mft5eYM9flpC+5tP8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7lVh4c4sBn0tkh2+cpaDiVFvswbT/vmhZ0NJ6GtfJDU=; b=Ni/5B5w8afnBGRsAdlf1AVcCp+
 R6IwbgC9jeE+X1wETFwLQ/CqGgdMRTeWBj/N7kRs2GR09j0Ovjm91pp0n7R3ZND8Ze3HwtrmczRgK
 uEUNop73HUJqt2gTSXn2LjHJT2aEPe8QXlWl5AaNIsnfhMoUm6KVYdFF+m2mSs5uIeGg=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTgsV-000000001A9-1OwA for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:43:15 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb64c99d2fso12083285e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795012989; x=1795617789; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7lVh4c4sBn0tkh2+cpaDiVFvswbT/vmhZ0NJ6GtfJDU=;
 b=IsaFuHRPEIH/rPlVMalxa4aco/Rf8uhW7N0/mVsIB5Go0f2CEat7u28GEQuC5LybLG
 vajsC/o7IcYdIL3K6kAgwquvyMzCpjpwkQ2i7azVH/iiPjZbCVVd2+yPdHLvdR+snKMF
 h+DMeeqStbbsy4iJ9mNmhVdYHOYRSpXA025bJo5M03FDUxgltxC1KmFHGMuncHM981Co
 L03Jyrc+vDXQYpp3SyPjMqHp65J1kMekcUE5M/X2NYaySsDauKFbvGV4lfRzdysIkpEQ
 YXjtcJTzX3CBzDBdBTtD97SAsQRAHI7R6WPP1FfTpvCbfRigs1wZ7akQ7iRTftMR/Emy
 My8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795012989; x=1795617789;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7lVh4c4sBn0tkh2+cpaDiVFvswbT/vmhZ0NJ6GtfJDU=;
 b=E3LPVcIHCP2ifoI7xkAYzNUt4sfj2cuRZOuyX+QwUBPCjydreiAY8I2ZpVYsMMUKAc
 TTI+O1RtcgJdfPZA7rHFEa/eGxx6nUA+d1uj58VmiwG+cI/xnT6TZoUNNQCJJFDEYndK
 pTA7of7zvQ+r48ICMquqJq+YfckpPY1mm6GeM7Oog0w+qVUfs3MWeIThV9Voq91HkPJO
 CVNn0Jky0+quf9HqNWn9LfyIyXB6Lb42oENFahcMn8dt5ckQuSR5kvHG9/095Z91VbHE
 1fQiBTZYsN9C4JXWobrsd1w89A4NJ18QEtsrrqZATH/HpxvnQiQnn7i3P8hDlBQ0ab/j
 vuXQ==
X-Gm-Message-State: APuU4Z9kS4Rtkj6Lz5i63uvHyWtd/A63PYubswgiJNAGEgkNwcAME/va
 tIQ1HnXALx+kvIaC/riTGeFCxukO6Vb9ck0LMCJbmHQdJg0Y8RtUoi5p6wu08I7ShCW5TFlEMAO
 rG1AyTOBLo0tBpMW11sE9+tXuZywCpisyGt0TVdvJB9/wzrY2Ywx4YR2sVlQ2flrj9i/R
X-Gm-Gg: AYBFou3/sF4QKJWlBWvTymBflHddGrcS0PNQiWa7fERrFLHGCWA3Jfe+zzBJG8VQyS7
 p/GJ7yDhLPx+JM0t64OlO195nLlRHhHuN88AMis3aYje5pchFrjhDtrnJUYCvzGbthYEerZ/1sa
 xMay9j5LMApitJbHAmqJwCmzlnryiKL2VBemaOd4G47VfwyglOmMDiuFd8uVneM6UUGSTc+IdDH
 rUjB9x9ooAIPdXMrJ5VOGdlyEhiHvvE7xnzamPgAARmVXuQyZBPZfW7k7Pjn0gAAJDxVFJ2L+j2
 framEZYBgMwk2Ubed6Pyh43/68/0JwLmlWvin5jGT/fHGC//U5NA2LssBRO/wj4Px0jfOh+BFEN
 mDXZeNZpJrH+RY6oVVTTFd80E4Nbiwi0p69f/PLMETIu/CsozOuNXky6UwbqBX36ePl5yo3f9hd
 QBET98Fpz3Ox2NGC2DIRbeFYUlivfx++qzrDw2sf+X5JGcgsi49yRAc4kbnc7bCWByJf0TiEgGD
 pE4ZS9petZmWcRvuGFtMsNXx0Z3o1dfd+DVU6btYk11jifjHd2eycUmMawUcCKeCcE5Rqvj13hO
 Ogn1QKO3MUVxvPmnjCBUP01dL4i5b7ec/DGSHYTPWj9s9nQDCLcdCaE6hjHWm8uQMqtm7RWsmhY
 bgZUxonXyhCnvHeHq8hW4aa9P4b5j7QsIeYu1jgOtqPEdgrsenkwHw6UJid+1eHfIMK+YIhR1Xu
 HRUpglstICDsvh9ps=
X-Received: by 2002:a05:600c:6092:b0:4bb:685e:cc41 with SMTP id
 5b1f17b1804b1-4bb7da229bbmr53855485e9.8.1795012988510; 
 Wed, 18 Nov 2026 06:43:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d29c614sm71339595e9.4.2026.11.18.06.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:43:08 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 14:43:07 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic49db236b36014ea6ee621a09252a534e3d05ef7
X-Gerrit-Change-Number: 2205
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2205?usp=email>
X-Gerrit-Commit: 3a72da5a1608f039e359168cea20c5ca99c778bb
In-Reply-To: <gerrit.1794903017000.Ic49db236b36014ea6ee621a09252a534e3d05ef7@gerrit.openvpn.net>
References: <gerrit.1794903017000.Ic49db236b36014ea6ee621a09252a534e3d05ef7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTAzMDE3MDAwLkljNDlkYjIzNmIzNjAxNGVhNmVlNjIxYTA5MjUyYTUzNGUzZDA1ZWY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cfcd14c3bf5c8989c3c6ed6def79fd46aea16576-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTgsV-000000001A9-1OwA
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: console_systemd:
 treat read() error as failure
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
Content-Type: multipart/mixed; boundary="===============0291282806891346713=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0291282806891346713==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hPpspBB4EQY="; charset=UTF-8

--hPpspBB4EQY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2205?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: console_systemd: tre=
at read() error as failure
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

console_systemd: treat read() error as failure

read() return=
ing -1 was taken as success, so a failed read from
systemd-ask-password yie=
lded an empty response instead of an error=2E

Change-Id: Ic49db236b36014ea=
6ee621a09252a534e3d05ef7
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2E=
org>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2205
Message-Id: <20261117175223=2E1=
4555-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg41575=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/console_systemd=2Ec
1 file =
changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/05/2205/3

diff --git a/src/openvpn/conso=
le_systemd=2Ec b/src/openvpn/console_systemd=2Ec
index f0ca7fa=2E=2E059686f=
 100644
--- a/src/openvpn/console_systemd=2Ec
+++ b/src/openvpn/console_sys=
temd=2Ec
@@ -76,7 +76,7 @@
         return false;
     }
     memset(input,=
 0, capacity);
-    if (read(std_out, input, capacity - 1) !=3D 0)
+    if =
(read(std_out, input, capacity - 1) > 0)
     {
         chomp(input);
    =
     ret =3D true;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2205?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Ic49db236b36014ea6ee621a09252a534e3d05ef7
Gerrit-Change-Number: 2205
Ge=
rrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--hPpspBB4EQY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2205?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">console_systemd: treat read() error as failure<br><br>read() returning =
-1 was taken as success, so a failed read from<br>systemd-ask-password yiel=
ded an empty response instead of an error=2E<br><br>Change-Id: Ic49db236b36=
014ea6ee621a09252a534e3d05ef7<br>Signed-off-by: Razvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2205<br>Me=
ssage-Id: &lt;20261117175223=2E14555-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g41575=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M src/openvpn/console_systemd=2Ec<br>1 file changed, 1 insertio=
n(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/05/2205/3</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/console_systemd=2Ec b/src/openvpn/console_systemd=2Ec</span><br><span>=
index f0ca7fa=2E=2E059686f 100644</span><br><span>--- a/src/openvpn/console=
_systemd=2Ec</span><br><span>+++ b/src/openvpn/console_systemd=2Ec</span><b=
r><span>@@ -76,7 +76,7 @@</span><br><span>         return false;</span><br>=
<span>     }</span><br><span>     memset(input, 0, capacity);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (read(std_out, input, capaci=
ty - 1) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (read(std_out, input, capacity - 1) &gt; 0)</span><br><span>     {</span=
><br><span>         chomp(input);</span><br><span>         ret =3D true;</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2205?usp=3Demail">change 2205</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2205?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: Ic49db236b36014ea6ee621a09252a534e=
3d05ef7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2205 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--hPpspBB4EQY=--


--===============0291282806891346713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0291282806891346713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0291282806891346713==--

