Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0536BCD98C7
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ulLAwkn3gHpuUtmmK5Vbmrbp8Gz8uAvEg26p53oW8Do=; b=fEUZYaqfBi5XNsxMEVvBicuD6r
	Lbf6DcENWoCz6tmO73w/qLhMX2Au4or5rCN3DYOJJiamZkojbc7WqLsb4r+CPejFWzCmZHv1l3uKx
	1csjuvykWISG17bkOWw6VjABpToXFhsga6J0RcnugpfcaGTnXBikGOnE5xsplWJUI838=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXPSf-0007Ts-K8;
	Wed, 10 Jun 2026 20:23:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXPSe-0007Tk-Gj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=p9t/2rNICZAC9xAluOs6tvX/MNd82CP6uuGPFvwPBDk=; b=N67BsPPFmBj4QNF15ZGlS9Hk5X
 E1SyV0zzGqak1yrgt6lWRRBw54g5zVnK+aUhxO5M2UUuGhOWZ1IITIyKeUa8qmSwC+WHNdsahrC3S
 ZkFmBgt7BdbtVET0yHkkBjvzL9WxAQ/sKDIuGAtNs6ZzU8L8OSgGZjNcEFVThTHYoAEY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=p9t/2rNICZAC9xAluOs6tvX/MNd82CP6uuGPFvwPBDk=; b=I
 EgY7wayFVYU7cA0ukBSzKvGgDNsHwikyCTMczHaQ0L9hkLkiNyolYXQeclirGlUnFpBhTqE/fu0H/
 HK152q8vENZDRCLXmjXUgkPpu8IrNsp7x+HwL/F0JoUIngFHFN94wqE5gqz94GspblvUuA8+sHmVM
 P2RhpDYjsfvHblh0=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXPSd-00009u-JY for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:23:41 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so2053765e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781123008; x=1781727808; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p9t/2rNICZAC9xAluOs6tvX/MNd82CP6uuGPFvwPBDk=;
 b=aUKsISuvuaV97BDb7XRYlZq2ps4CR+oOOFtkdBfTdluGlxRyOp/A49AyxZTKW9fPVY
 2LhdOy7Wql2K4Qx1DDAkc38dSiyuv3nfDTjNsSao8/h0+D/bQL3cckWb3luZdxKWRE9r
 CVbQQ8+AeNT6dyeZSrPa/kJGaLYCE9TiAZ4rSvFOWmX8VfKZF2rtqMhDFm+RVfLBQjvQ
 jarqlJsZBYZaxuW6wnojkHg8CILC28sdwau/toGC+Qw4tbOOplSsfoKJHemtB3BSlj33
 ZHAqH4x1f12cqayLIJR6lvLVbx/kfNFHISXWO98ynlqXhY+ZECdOjBLuPDE2ObNs5mpt
 PcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781123008; x=1781727808;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p9t/2rNICZAC9xAluOs6tvX/MNd82CP6uuGPFvwPBDk=;
 b=SMrZtKdXpjRa1yp/9o2wyohf7QgxEgLpj8VLyEpLd+MxAF+39ZAu78CAGl/XO8sSNg
 jQg9QKtAXSw8fElKv963KDQFDdB2ir6Y7wv1vihHuG0heVq1n1+42s7Pjt6+S0Qx9u+I
 OcYGTeWG2h48F34t/ARmmZAe8oOdOOOuQCPopqX25nzELvMVL1ToUx//G5TcgD4haDgg
 vv2x4JagcSGeFtbwI2NHrRwLIwyPnDand3HVcy3bfYRHtcZVzfmtJzvFZ4epLFdIij1Z
 wRAClS9gmwmMBpGbajJnIj01XL0m4E2sfqbqeyaFMfXqov06FzHp+bKmMRHc1Iprmrrv
 Q5UQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SaH+rsiMF2WoJGCpCXtwlnabRwDa+eu7pLYiuJRT+LDvLRFhAYV79G9YZ1YsLcHjxBWBfWlVsYVZd/7GA@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzd+6fhbPSEh9KKFC8SCDhLnF3wGPhDljtEH5mMyMjJiwVJ9HjK
 QfW8RdS1kyZCeCI0g4C03b8L4PPGndR59fkAHk3diem0wacPKv//lysH+bbkyAlqPJnb64K98Cc
 rjxAMOBRLuUz3DnLoKP0uCOyd7MnHM2uCVsAl6wli5LUieQBzgYaLjk3NDQF+brnIEzmT
X-Gm-Gg: Acq92OFmnuVzwHhTnMfOK1mMPLQN/jpw7n5th4ilc9LStBHfNraLOD8QHAtebYtfz/m
 XuB5R1iugnnkW46hcCHM+XtRLyUrZZ0ajeOLrooJoiWCR8S1MyhDlQ+bpeZlIE5p0ZyirpGVspy
 MTjYmyS45HLtdahG0EwG9DlOlrUX162s6fTqn5e6JBKm+gIbDMTe5026phUoxLtDlZu6EHJ3tI9
 Vf4cnI8CWodvpF1NBkDq2Ljt4MyIXmpAX8wHHnmaCZsAUxqXmwKmEFKS96fo2ApQOwtRxIZjFWI
 u+DmKT4Vmcrl/DF5c7pmMjHIUfAGU5UUfQobVQQrlgt0ZCZpJ3y5Gz2eiMpTlOMBnTLeRFEJ6Ja
 Cl3MYqhxXJ4lbEo+7uTE8p/gcttd3RGUvp0VoxMX359yYTFXdci0U8mLsK6Olbm4pWghqzuo2E6
 ztQgVE+MbKdabQ/SSOXj6W0Xd1aXmVFvedKnvEmLWz9m6jHhuVmy1aHcpVDHVdAsFR0mMyIVvij
 4QusB6mi1AxCRIjmVc8vSLEvZ7dBxx905ykPa3j+VSFDDWnNaMIOY+MoXiTOwj6bGpyuRv2gTJt
 rqxn/6UzsbTj/DjdOgrB+RQJ
X-Received: by 2002:a05:600c:1790:b0:488:7d01:f67b with SMTP id
 5b1f17b1804b1-490e34a7e63mr1285295e9.6.1781123008488; 
 Wed, 10 Jun 2026 13:23:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm129648861f8f.27.2026.06.10.13.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:23:28 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 20:23:27 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8a17d452e9e5690a5507d17129286142df6c88f1
X-Gerrit-Change-Number: 1711
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1711?usp=email>
X-Gerrit-Commit: 90499e51237cd11f813206371b7ba5176d8eb5ef
In-Reply-To: <gerrit.1781017122000.I8a17d452e9e5690a5507d17129286142df6c88f1@gerrit.openvpn.net>
References: <gerrit.1781017122000.I8a17d452e9e5690a5507d17129286142df6c88f1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkk4YTE3ZDQ1MmU5ZTU2OTBhNTUwN2QxNzEyOTI4NjE0MmRmNmM4OGYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ecb3bc4f899eac2c46b6933efd58d854d76ba52-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXPSd-00009u-JY
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Switch to
 using VS 2026
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7953941818180558223=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7953941818180558223==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="brU9dhtRNgY="; charset=UTF-8

--brU9dhtRNgY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1711?usp=3Demail )

Change subject: GHA: Switch to using VS 2026
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Switch to usin=
g VS 2026

Since Github will switch to windows-2025 image to use
VS 2026 at=
 some point in the near future (according to
https://github=2Eblog/changelo=
g/2026-02-05-github-actions-early-february-2026-updates/#windows-server-202=
5-with-visual-studio-2026-image-now-available-for-github-hosted-runners)
en=
force that switch to avoid any build failures=2E Since
we hardcode the VS v=
ersion in CMakePresets=2Ejson (and I
do not see an easy way to avoid this w=
ith CMake), we
need to override the generator value=2E We can switch the
de=
fault once our release infrastructure has been switched
to VS 2026=2E

Chan=
ge-Id: I8a17d452e9e5690a5507d17129286142df6c88f1
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1711
Messa=
ge-Id: <20260609152123=2E27460-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37139=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =2Egithub/wo=
rkflows/build=2Eyaml
1 file changed, 4 insertions(+), 2 deletions(-)




di=
ff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Ey=
aml
index 323645a=2E=2E4cab0ac 100644
--- a/=2Egithub/workflows/build=2Eyam=
l
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -138,7 +138,7 @@
         test:=
 [argv, auth_token, buffer, cryptoapi, crypto, misc, options_parse, ncp, op=
envpnserv, packet_id, pkt, provider, ssl, tls_crypt, user_pass]
         bu=
ild: [Release, Debug]
 
-    runs-on: windows-2025
+    runs-on: windows-20=
25-vs2026
     name: "mingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Ear=
ch }} - ${{ matrix=2Ebuild }} - OSSL"
     steps:
       - name: Checkout O=
penVPN
@@ -285,7 +285,7 @@
         VCPKG_BINARY_SOURCES: clear;default,rea=
dwrite
         VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f=
07
 
-      runs-on: windows-2025
+      runs-on: windows-2025-vs2026
     =
  steps:
       - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172c=
ec0e10 # v6=2E0=2E3
       - uses: lukka/get-cmake@591817e96fcad43505fb4eae=
36172462abb3a42e # v4=2E3=2E3
@@ -315,6 +315,7 @@
         with:
          =
 configurePreset: win-${{ matrix=2Earch }}-release
           buildPreset: =
win-${{ matrix=2Earch }}-release
+          configurePresetAdditionalArgs: =
"['-GVisual Studio 18 2026']"
 
       - name: Run CMake with vcpkg=2Ejson =
manifest
         uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e0=
3a956 # v10=2E9
@@ -323,6 +324,7 @@
           configurePreset: win-${{ mat=
rix=2Earch }}-release
           buildPreset: win-${{ matrix=2Earch }}-rele=
ase
           testPreset: win-${{ matrix=2Earch }}-release
+          conf=
igurePresetAdditionalArgs: "['-GVisual Studio 18 2026']"
           testPre=
setAdditionalArgs: "['--output-on-failure']"
 
       - uses: actions/uploa=
d-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1711?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8a17d452e9e5690a5507d17129286=
142df6c88f1
Gerrit-Change-Number: 1711
Gerrit-PatchSet: 2
Gerrit-Owner: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--brU9dhtRNgY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1711?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">GHA: Switch to using VS 2026<br><br>Since =
Github will switch to windows-2025 image to use<br>VS 2026 at some point in=
 the near future (according to<br>https://github=2Eblog/changelog/2026-02-0=
5-github-actions-early-february-2026-updates/#windows-server-2025-with-visu=
al-studio-2026-image-now-available-for-github-hosted-runners)<br>enforce th=
at switch to avoid any build failures=2E Since<br>we hardcode the VS versio=
n in CMakePresets=2Ejson (and I<br>do not see an easy way to avoid this wit=
h CMake), we<br>need to override the generator value=2E We can switch the<b=
r>default once our release infrastructure has been switched<br>to VS 2026=
=2E<br><br>Change-Id: I8a17d452e9e5690a5507d17129286142df6c88f1<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1711<br>Message-Id: &lt;20260609152123=2E27460-1-=
gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg37139=2Ehtml<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =2Egithub/workflows/build=
=2Eyaml<br>1 file changed, 4 insertions(+), 2 deletions(-)<br><br></pre>
<p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=
=2Eyaml</span><br><span>index 323645a=2E=2E4cab0ac 100644</span><br><span>-=
-- a/=2Egithub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/workf=
lows/build=2Eyaml</span><br><span>@@ -138,7 +138,7 @@</span><br><span>     =
    test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options_parse=
, ncp, openvpnserv, packet_id, pkt, provider, ssl, tls_crypt, user_pass]</s=
pan><br><span>         build: [Release, Debug]</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: windows-2025</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: windows-2025-=
vs2026</span><br><span>     name: &quot;mingw unittest ${{ matrix=2Etest }}=
 - ${{ matrix=2Earch }} - ${{ matrix=2Ebuild }} - OSSL&quot;</span><br><spa=
n>     steps:</span><br><span>       - name: Checkout OpenVPN</span><br><sp=
an>@@ -285,7 +285,7 @@</span><br><span>         VCPKG_BINARY_SOURCES: clear=
;default,readwrite</span><br><span>         VCPKG_GIT_COMMIT_ID: 75672db6bd=
812b060482b0f00b5a16b18a0c0f07</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-      runs-on: windows-2025</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      runs-on: windows-2025-vs2026</span=
><br><span>       steps:</span><br><span>       - uses: actions/checkout@df=
4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       =
- uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=
=2E3</span><br><span>@@ -315,6 +315,7 @@</span><br><span>         with:</sp=
an><br><span>           configurePreset: win-${{ matrix=2Earch }}-release</=
span><br><span>           buildPreset: win-${{ matrix=2Earch }}-release</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+          configurePres=
etAdditionalArgs: &quot;[&#39;-GVisual Studio 18 2026&#39;]&quot;</span><br=
><span> </span><br><span>       - name: Run CMake with vcpkg=2Ejson manifes=
t</span><br><span>         uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8=
d572297e03a956 # v10=2E9</span><br><span>@@ -323,6 +324,7 @@</span><br><spa=
n>           configurePreset: win-${{ matrix=2Earch }}-release</span><br><s=
pan>           buildPreset: win-${{ matrix=2Earch }}-release</span><br><spa=
n>           testPreset: win-${{ matrix=2Earch }}-release</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          configurePresetAdditionalAr=
gs: &quot;[&#39;-GVisual Studio 18 2026&#39;]&quot;</span><br><span>       =
    testPresetAdditionalArgs: &quot;[&#39;--output-on-failure&#39;]&quot;</=
span><br><span> </span><br><span>       - uses: actions/upload-artifact@043=
fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1711?usp=3Demail">change 1711</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1711?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I8a17d452e9e5690a5507d17129286142df6c88f1 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1711 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--brU9dhtRNgY=--


--===============7953941818180558223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7953941818180558223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7953941818180558223==--

