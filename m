Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D17CD98C7
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RDpvNPyRrJuO7bC3QkEaAjfITWOOBqGvYCqyppvmnUM=; b=HQzsXhLADZaDk5D66j7fkHnH6y
	yFpQnLexLyaq1PFqVJvv+FXM6wLmvBnNYjlJ7IWOkjBiSdgqBT0cVY8Qt1W6q6jdkHhcxSTny5ScP
	fEZr2nv3ULWaXKuukyQbmKz8KHchKU/hpUXHmwtNCMMcoWONQySWyNuEs97GtwSRT2w8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXPSb-0004Vv-HG;
	Wed, 10 Jun 2026 20:23:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXPSZ-0004Vd-KC
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hGvovHi9oz/+hsfEoubb3xUqEDQWpuiBvUaf1+RsRAw=; b=XeuRSSVCUc8pNxohdpX6wkBIFr
 Dzo7M8WZDpMbYPn/2s15m01QKQfMr36AUH2V+Wwiv4JBABrFPSTHzxftA6Q/tK0QQh8Ek8AG9vxBg
 xhRx1nxczcbZcZeVUkk+uexekI6Dad1JgXWY+fnz6Q++oNiTwd1WMzB8l2bgsBs61BL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hGvovHi9oz/+hsfEoubb3xUqEDQWpuiBvUaf1+RsRAw=; b=F
 1um13fkdd82BWNUiZcxmBIp5JdPEfz+3BXF/NvH5wXfSnBKy4YYZQvIHBj/lSOjdhDteLUf5GgO3g
 N38fF1Ur3ydumwuWkDcYgVLCzOViGOxKN7pXzIwXiIjOwIKtVnxkAO2McHe6DdeaiCZwj9wYHtAoa
 cyQxsNsLUILzD59I=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXPSX-00009J-Un for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:23:36 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490c1915793so51856435e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781123008; x=1781727808; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hGvovHi9oz/+hsfEoubb3xUqEDQWpuiBvUaf1+RsRAw=;
 b=WgW7qkH5xLAK4bLmMLBmHgDfSjWnj/4/MbtrbAlLHZjYsWp27509kvNmpnDkV68K7i
 k/9s1/w4XChQK+t32cB9E+jrx3hxNCfH36ex+RFqJnGCqPbyACPLJA6y5iMCUEdIzROl
 XSsRQtqP8f6xPyZiJPwlu6zdsuCoowDjwhdsUXbCZEAvl5BiiZDUznQMdvDsmvFMD9SM
 qlciN7WJF7XLpt1/Y8t36+bgJ13ZQCW+DV50mWQxxbcsJKhg3528bARAnHqecQQpRuEh
 UIHhVI0w60qWYEzfWNF9VN7QXTiJ10KSy52iI1s0mPIypx8URc0sC6N48QmSxlmbRAFu
 KX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781123008; x=1781727808;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hGvovHi9oz/+hsfEoubb3xUqEDQWpuiBvUaf1+RsRAw=;
 b=mqChSPwcU1TKZlpVTQmYsIPx2Ul2n21phoH6N0Y1h9hdQ4FB/AucEF++nPG/JRoYzv
 BNEdfx5GXGIcjaYv3rSuDf2LONGHifgxlU5gT0EPedCdYzwdkDm7SYkzxiuxU0Fn2IUB
 Bd0z28K0lfQr2UylejflE71J9oXEBjAhXBVuI/YwXKhGJmKVeHeoa31i1k48W0lTxraY
 yhDF8kBoNTP9ilmjRFMAwjX8m3bx8w2Ps/dj6PVQ7pufQbfLnx4+dxeWCkigweFNsnBI
 Bd5mTi9+Fxtzokfz76pqo6D1xgXsfD4E6RstUkPoXtTYeomLsiDCSWIVUqzrGZKrkJMr
 q8yw==
X-Gm-Message-State: AOJu0YyctwBRiV0UOGUFkMIx6L99Sn8tACRtxQE5uMArG7bIZ5rEtYk6
 BkX/WgXTa1K2DJdpKiRDfsffqecQ8Gj91IexkulbL9TPRD2s1huIuTfZkSd4H1GA0BGbZSl5TLJ
 c1Xw8Byvk+A/gJVE+WqzA8+pDyVMwTgnTIOTRmVS+Z0mLNki+m6w1qOz/SmrubmgeScW6BrPuBk
 tlfDN8Gg==
X-Gm-Gg: Acq92OHu8YqzAq3hPSIkYsg5sfaAXQpRPQ1ObEr1h1oqONPfVKGCIxfcGJFXiBPBaZy
 7LpXq2DhK+i90M2sXswlavFE3oWKCQbobeIs0P7tcWvO6p8SzMuDY8MlsBECrqaCCMPrheXrkcH
 vwQa6XOxMiuqA2CLofTbOD00LcKds6eHielA1bHVYyIRxr2SvYU8vxupZf6D5uWwRdFqpCdXAki
 RCB3MEchrf8gtw0jv0t0KVfKd6tUtPrRNSHa5omx6fXBpI/LpX8wLTaSo4z3UctQZHwI3JEQS/M
 6mG1ove6fW2sXFsOJH3GuH7wBIB8BxW1xZusUW+PyM+NxYu5oyXk7AFCO4HGvb5ewTqG8xolgCB
 oz5gmH/ab82nKdugD3ZQK1tsvue+Y70OZMzVilsDFEi1zwkMm8wtInLT1ghPxJwkw0evVx3bpGW
 yH/6eovvN8yjFkeBp3DUoNtOOHqz+9hOY9MNcEBXo9jWWSsMcXZTf5wi9Twtu+uWEPQCoC1b3nS
 DuNDdPnNKv5sH6r3+9ZmgEKzU9P/JDt/gBrgMEICdWudmemt3IOphEQ6zKU0NB1bmP0/3RE9uJb
 fhq3iEoAC++8XF6uHhariy2yakSyYCmEhyc=
X-Received: by 2002:a05:600c:4fcf:b0:490:c2a3:3302 with SMTP id
 5b1f17b1804b1-490e2e976cfmr5236205e9.35.1781123007728; 
 Wed, 10 Jun 2026 13:23:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490dc471b6dsm70203555e9.0.2026.06.10.13.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:23:27 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 20:23:26 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8a17d452e9e5690a5507d17129286142df6c88f1
X-Gerrit-Change-Number: 1711
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1711?usp=email>
X-Gerrit-Commit: 90499e51237cd11f813206371b7ba5176d8eb5ef
In-Reply-To: <gerrit.1781017122000.I8a17d452e9e5690a5507d17129286142df6c88f1@gerrit.openvpn.net>
References: <gerrit.1781017122000.I8a17d452e9e5690a5507d17129286142df6c88f1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkk4YTE3ZDQ1MmU5ZTU2OTBhNTUwN2QxNzEyOTI4NjE0MmRmNmM4OGYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ecb3bc4f899eac2c46b6933efd58d854d76ba52-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXPSX-00009J-Un
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7572200920842409247=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7572200920842409247==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IohC64I4lME="; charset=UTF-8

--IohC64I4lME=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1711?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: GHA: Switch to using VS 2026
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Switch to using VS 2026=


Since Github will switch to windows-2025 image to use
VS 2026 at some poi=
nt in the near future (according to
https://github=2Eblog/changelog/2026-02=
-05-github-actions-early-february-2026-updates/#windows-server-2025-with-vi=
sual-studio-2026-image-now-available-for-github-hosted-runners)
enforce tha=
t switch to avoid any build failures=2E Since
we hardcode the VS version in=
 CMakePresets=2Ejson (and I
do not see an easy way to avoid this with CMake=
), we
need to override the generator value=2E We can switch the
default onc=
e our release infrastructure has been switched
to VS 2026=2E

Change-Id: I8=
a17d452e9e5690a5507d17129286142df6c88f1
Signed-off-by: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1711
Message-Id: <2=
0260609152123=2E27460-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37139=2Ehtml
Signed-=
off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =2Egithub/workflows/bu=
ild=2Eyaml
1 file changed, 4 insertions(+), 2 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/11/1711/2

diff --git =
a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml
index=
 323645a=2E=2E4cab0ac 100644
--- a/=2Egithub/workflows/build=2Eyaml
+++ b/=
=2Egithub/workflows/build=2Eyaml
@@ -138,7 +138,7 @@
         test: [argv, =
auth_token, buffer, cryptoapi, crypto, misc, options_parse, ncp, openvpnser=
v, packet_id, pkt, provider, ssl, tls_crypt, user_pass]
         build: [Re=
lease, Debug]
 
-    runs-on: windows-2025
+    runs-on: windows-2025-vs202=
6
     name: "mingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - =
${{ matrix=2Ebuild }} - OSSL"
     steps:
       - name: Checkout OpenVPN
@=
@ -285,7 +285,7 @@
         VCPKG_BINARY_SOURCES: clear;default,readwrite
 =
        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
 
-  =
    runs-on: windows-2025
+      runs-on: windows-2025-vs2026
       steps:=

       - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 #=
 v6=2E0=2E3
       - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462=
abb3a42e # v4=2E3=2E3
@@ -315,6 +315,7 @@
         with:
           configu=
rePreset: win-${{ matrix=2Earch }}-release
           buildPreset: win-${{ =
matrix=2Earch }}-release
+          configurePresetAdditionalArgs: "['-GVis=
ual Studio 18 2026']"
 
       - name: Run CMake with vcpkg=2Ejson manifest=

         uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # =
v10=2E9
@@ -323,6 +324,7 @@
           configurePreset: win-${{ matrix=2Ear=
ch }}-release
           buildPreset: win-${{ matrix=2Earch }}-release
    =
       testPreset: win-${{ matrix=2Earch }}-release
+          configurePre=
setAdditionalArgs: "['-GVisual Studio 18 2026']"
           testPresetAddit=
ionalArgs: "['--output-on-failure']"
 
       - uses: actions/upload-artifa=
ct@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1711?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I8a17d452e9e5690a5507d17129286142df=
6c88f1
Gerrit-Change-Number: 1711
Gerrit-PatchSet: 2
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>

--IohC64I4lME=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1711?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">GHA: Switch to using V=
S 2026<br><br>Since Github will switch to windows-2025 image to use<br>VS 2=
026 at some point in the near future (according to<br>https://github=2Eblog=
/changelog/2026-02-05-github-actions-early-february-2026-updates/#windows-s=
erver-2025-with-visual-studio-2026-image-now-available-for-github-hosted-ru=
nners)<br>enforce that switch to avoid any build failures=2E Since<br>we ha=
rdcode the VS version in CMakePresets=2Ejson (and I<br>do not see an easy w=
ay to avoid this with CMake), we<br>need to override the generator value=2E=
 We can switch the<br>default once our release infrastructure has been swit=
ched<br>to VS 2026=2E<br><br>Change-Id: I8a17d452e9e5690a5507d17129286142df=
6c88f1<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<=
br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1711<br>Message-Id: &lt;2026060=
9152123=2E27460-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37139=2Ehtml<br>Sign=
ed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =2Egith=
ub/workflows/build=2Eyaml<br>1 file changed, 4 insertions(+), 2 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/11/1711/2</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/=2Egithub/workflows/build=
=2Eyaml b/=2Egithub/workflows/build=2Eyaml</span><br><span>index 323645a=2E=
=2E4cab0ac 100644</span><br><span>--- a/=2Egithub/workflows/build=2Eyaml</s=
pan><br><span>+++ b/=2Egithub/workflows/build=2Eyaml</span><br><span>@@ -13=
8,7 +138,7 @@</span><br><span>         test: [argv, auth_token, buffer, cry=
ptoapi, crypto, misc, options_parse, ncp, openvpnserv, packet_id, pkt, prov=
ider, ssl, tls_crypt, user_pass]</span><br><span>         build: [Release, =
Debug]</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    runs-on: windows-2025</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    runs-on: windows-2025-vs2026</span><br><span>     name: &quot;=
mingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - ${{ matrix=2Eb=
uild }} - OSSL&quot;</span><br><span>     steps:</span><br><span>       - n=
ame: Checkout OpenVPN</span><br><span>@@ -285,7 +285,7 @@</span><br><span> =
        VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span>     =
    VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      runs-on=
: windows-2025</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 runs-on: windows-2025-vs2026</span><br><span>       steps:</span><br><span=
>       - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 #=
 v6=2E0=2E3</span><br><span>       - uses: lukka/get-cmake@591817e96fcad435=
05fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><span>@@ -315,6 +315,7 @@</=
span><br><span>         with:</span><br><span>           configurePreset: w=
in-${{ matrix=2Earch }}-release</span><br><span>           buildPreset: win=
-${{ matrix=2Earch }}-release</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+          configurePresetAdditionalArgs: &quot;[&#39;-GVisual Stu=
dio 18 2026&#39;]&quot;</span><br><span> </span><br><span>       - name: Ru=
n CMake with vcpkg=2Ejson manifest</span><br><span>         uses: lukka/run=
-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10=2E9</span><br><span>@=
@ -323,6 +324,7 @@</span><br><span>           configurePreset: win-${{ matr=
ix=2Earch }}-release</span><br><span>           buildPreset: win-${{ matrix=
=2Earch }}-release</span><br><span>           testPreset: win-${{ matrix=2E=
arch }}-release</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      configurePresetAdditionalArgs: &quot;[&#39;-GVisual Studio 18 2026&#3=
9;]&quot;</span><br><span>           testPresetAdditionalArgs: &quot;[&#39;=
--output-on-failure&#39;]&quot;</span><br><span> </span><br><span>       - =
uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=
=2E0=2E1</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1711?usp=3Demail">change 1711</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1711?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a17d452=
e9e5690a5507d17129286142df6c88f1 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1711 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--IohC64I4lME=--


--===============7572200920842409247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7572200920842409247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7572200920842409247==--

