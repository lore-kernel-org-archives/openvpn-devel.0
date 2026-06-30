Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3DCC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ph0JXqCGAHHUqcsu8dKSgkuLvSdOzvnxEYw6m/+Ayd4=; b=gw6G9XL74eBZveN+lHHwTAn/cZ
	sNHT5HmcHIIPmotbBasuroQSgQfPgmSvck6eLEW40LCDZYA61hO+jKsUodFnmbv79Z8Ky1vDrhxPs
	wkz1Ucla5IyvV0zU1gzMsx/LKgOWk8p0aoPjDASHm3DgsZ3ur+qH8sKSD5xSZcJR+yo8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weSPa-0007Wp-1S;
	Tue, 30 Jun 2026 06:57:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weSPY-0007WK-To
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 06:57:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=f3n4QKJuT/8HSL7NghRRfZi6QhKRGXfy8qKmThJGXd8=; b=jmtj2fNBOVsP1aodRvfb1uKG4G
 yPL0xjK6QDaZdcOW23Vehi4OSn1jSN9A/e/rVf49L8JiQjycw1K8X3bOvN7BIPF9B6T6t7Gt+JaMr
 Xfh6/l0lzxHJk1wAvfoW5f117ZBwKmG8iMdR8jnYpJMHvsw8PcaQPgCK48LEFS6dAZKg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=f3n4QKJuT/8HSL7NghRRfZi6QhKRGXfy8qKmThJGXd8=; b=I
 QqvV5+UO2QN1GDPIsidxpVZECZMvRKo+yVkOaWIyNPdRKqwOCh9VzwTrwuFbVpxVgNhgedpfpaJ6+
 k364/LrufVGuAJ9tp2Eom2KGBiMN+0N0ZG6NGtQcd6u2LjxngH6OAGQNuKEbWPflugxKNwq0n6Dlu
 ICNIJFs2/tZwrbtA=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weSPC-0003Bb-JW for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 06:57:17 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso463815f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 23:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782802623; x=1783407423; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f3n4QKJuT/8HSL7NghRRfZi6QhKRGXfy8qKmThJGXd8=;
 b=OIijcwucVXGSF1t+q3IX1SSqrOESgEg+hkt99LZ39SlGTcyKIoGUzstpM6cnoF4F36
 dXmA7nfKVrPYQh6+OXLbCCWAKxhD5rmcSWnTCaM81PHJRCMrglBHrZTTxOILkMLrlGTt
 ut+BPIBDPR7dug/kFhlZG6s60I2CcopdlImar73Lo8HvbkGLCphv5rDbXBD06LuphLTS
 iXNJLq20akYvKhIw+6MzfIeDx2JKyMsc+oGDML7yt7VWwA/gZ7hbQn17CYuuDBGr0o5I
 4YKayC8BPgHg3v9u33okMbE8HtlnX5jXFQbHk4RKnarwH7hbDmviKiUGlDF3UiNwq7Iq
 FZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782802623; x=1783407423;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f3n4QKJuT/8HSL7NghRRfZi6QhKRGXfy8qKmThJGXd8=;
 b=OnVpFkuVUpNxWiIpmiE/eSiH9b7m75Yet8HOJhRqVB2Louux1d4Owa8CXJ+rQieurQ
 qwMkaGx02EFPukM059TPcfIOuBEBLom/kgvbgC9SbNpj43MQ52+Oxpad/0AgX5YdWhmy
 QtRHqkyANaoTcNx+2CJ6VGK/poM+8vhPiC4hQnPMesQJrj/8wy4eeKVi5VNWnzpIcizR
 ZUqXi7ErXOcNOmSP61G8WdHXWt5nsCU6v/T22DI+biUVb+W7qbAK6lbw79Jwr4Y9Rxv2
 wnJujQOHPbrw0tJe/KBEL6fp5PKTUQaKGRfvTBVOdTF8bqzh43N81yLqD0u07mE2EPbA
 RLUQ==
X-Gm-Message-State: AOJu0YwkCo+CUHuW06Y3nrRt31BOFnxgBBU7LelLuIVjH1mUVizhHZis
 sGxz0jU1YQbwi0m1vjmbK/x9hOphx10MeJlYtKuaWQ/LiTCtT/cGBMh8m3px3Linlrbgo3hYgdk
 Q8hpA2Dxgi9kKHnW6pg5LtaymeXc8T2yfPMF+0VIIz5vZIF+eYOs9zznhqTykeOIpGPVm
X-Gm-Gg: AfdE7cmq8DHuP8NapRnNv1b1TfHW7SzKDlBGhU0dXL/Kxq2vvkbt++8M8a985MUI3Nw
 SbEPXn1odQg/HDZOM+9y6veVXgVXii7BxsygS2DFG2CTu4V6FFxc4DzQ77NnMuos3r0JZpy7OEW
 FBnC7XXaAthuouRL4TGn5W3QszlUvM1gRcZcP5Oa4kZl8wLAmhG7f72Ru+ViZ1wAmdjBSawYOU8
 ekll0jQF7DLUsh4pgJIiNrhKFNWlJBwefLpXKFdUSLp8XgHB+Lbr6yz1+GRCrCYRf8hx9xcCWOH
 ziPOzZ7y5WZg6rUXFza7VICnGW2Q2vguYSemaKbWvE2LzXm9fdmgS+5l3p+zdE/b1R4iOfKYIV+
 bDsGWgYZDDD0bW+eJ4Jf1HpFdI8cV2xWlCmMBK8DE+KNBFXab9cFXCEQr7dMQBlRH6dX7DTOEYr
 zLtN9YF/WMZ0wl2twmtOniiWIki8WsUKslhSufO4cDWpPAFkqkujVEACwWk66sqSAAgOlGsmaUS
 SxAh1su3goz7Y8si7WA+p3fVA9xC80YKA+UbEKHTDfUkHlulZh3KQWZCZbNtMpky5Bn4RN+mNP2
 D6Q=
X-Received: by 2002:a05:600c:3e86:b0:493:b877:fbc with SMTP id
 5b1f17b1804b1-493b8771027mr35417455e9.21.1782802623118; 
 Mon, 29 Jun 2026 23:57:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8c238fasm43214985e9.0.2026.06.29.23.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 23:57:02 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 30 Jun 2026 06:57:01 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
X-Gerrit-Change-Number: 1754
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1754?usp=email>
X-Gerrit-Commit: 4967193d0c494f147833c6d0de47165a6286296b
In-Reply-To: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
References: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQwMzE3MDAwLkljYmNmNGM3OWQ1NzdkOWNmMDg5YTkyMzc4YmU5MjUzYjFlOTQ4MjVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c96333cf9504af602244c59cd93a0594749d1e06-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weSPC-0003Bb-JW
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: GHA:
 Cherry-pick changes from master to keep working
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
Content-Type: multipart/mixed; boundary="===============2032712591709026298=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2032712591709026298==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0DG3FFwaBSY="; charset=UTF-8

--0DG3FFwaBSY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: GHA: Cherry-pick changes from master to keep=
 working
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA:=
 Cherry-pick changes from master to keep working

Cherry-pick applicable ch=
anges from the following commits:

- GHA: Switch to using VS 2026
(cherry p=
icked from commit 90499e51237cd11f813206371b7ba5176d8eb5ef)
- GHA: Add cach=
ing for vcpkg builds
(cherry picked from commit 157087736427059316ecff7dd21=
e16b54077221a)
- GHA: Maintenance Update April 2026
  - Updates GHA actions=

  - Switch uncrustify job to archive: false
  - Drop macos-14 builds
(cher=
ry picked from commit cc2926fd5d09fd501b51520ed5a0b69399db85da)
GHA: Mainte=
nance update June 2026
  - chore(deps): update github actions
  - chore(dep=
s): update vcpkg digest to 75672db
(cherry picked from commit f9e6d5d724851=
a938a0c064307db513df469eb62)

Further changes:
  - Drop macos-13 builds
  -=
 Add macos-26 builds
  - Drop openssl@1=2E1 from macOS, not available in al=
l versions anymore

Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
Si=
gned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1754
Message-Id: <20260629181505=2E20031-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg37398=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M =2Egithub/workflows/build=2Eyaml
M =2Egithub/workflows/coverit=
y-scan=2Eyml
2 files changed, 57 insertions(+), 32 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/1754/2

diff -=
-git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml
=
index 1abc178=2E=2E883e2dc 100644
--- a/=2Egithub/workflows/build=2Eyaml
++=
+ b/=2Egithub/workflows/build=2Eyaml
@@ -13,7 +13,7 @@
       - name: Insta=
ll dependencies
         run: sudo apt update && sudo apt install -y uncrus=
tify
       - name: Checkout OpenVPN
-        uses: actions/checkout@11bd71=
901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+        uses: actions/chec=
kout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
         with:
 =
          path: openvpn
       - name: Show uncrustify version
@@ -27,9 +27=
,9 @@
       - name: Show changes on standard output
         run: git diff=

         working-directory: openvpn
-      - uses: actions/upload-artifact=
@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2
+      - uses: actio=
ns/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1
  =
       with:
-          name: uncrustify-changes=2Epatch
+          archive=
: false
           path: 'openvpn/uncrustify-changes=2Epatch'
       - name=
: Set job status
         run: test ! -s uncrustify-changes=2Epatch
@@ -45,=
27 +45,38 @@
     runs-on: ubuntu-24=2E04
     env:
       VCPKG_ROOT: ${{ =
github=2Eworkspace }}/vcpkg
+      VCPKG_BINARY_SOURCES: clear;default,read=
write
+      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
=
     steps:
       - name: Install dependencies
         run: sudo apt upda=
te && sudo apt install -y mingw-w64 unzip build-essential wget python3-docu=
tils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/c=
heckout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+        uses=
: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
 
=
-      - uses: lukka/get-cmake@6b3e96a9bc9976b8b546346fdd102effedae0ca8 # v=
4=2E0=2E3
-      - name: Restore from cache and install vcpkg
-        uses=
: lukka/run-vcpkg@5e0cab206a5ea620130caf672fce3e4a6b5666a1 # v11=2E5
+     =
 - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=
=2E3
+      - name: Setup vcpkg
+        uses: lukka/run-vcpkg@b1a0dd252f06=
b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
         with:
-          vcpkgGitCo=
mmitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
+          vcpkgGitCommitI=
d: ${{ env=2EVCPKG_GIT_COMMIT_ID }}
           vcpkgJsonGlob: '**/mingw/vcp=
kg=2Ejson'
 
+      - name: Set up vcpkg binary cache
+        uses: action=
s/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+        with=
:
+          path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}
+          key: =
mingw-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles('**/mingw/vcpkg=
=2Ejson') }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}
+          restore-keys: |
+ =
           mingw-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles('**/=
mingw/vcpkg=2Ejson') }}-
+            mingw-${{ matrix=2Earch }}-vcpkg-bina=
ry-cache-
+
       - name: Run CMake with vcpkg=2Ejson manifest
-        us=
es: lukka/run-cmake@af1be47fd7c933593f687731bc6fdbee024d3ff4 # v10=2E8
+   =
     uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10=
=2E9
         with:
           configurePreset: mingw-${{ matrix=2Earch }}
=
           buildPreset: mingw-${{ matrix=2Earch }}
           buildPresetAd=
ditionalArgs: "['--config Debug']"
 
-      - uses: actions/upload-artifact=
@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2
+      - uses: actio=
ns/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1
  =
       with:
           name: openvpn-mingw-${{ matrix=2Earch }}
          =
 path: |
@@ -73,7 +84,7 @@
             ${{ github=2Eworkspace }}/out/build=
/mingw/${{ matrix=2Earch }}/**/Debug/*=2Edll
             !${{ github=2Ewor=
kspace }}/out/build/mingw/${{ matrix=2Earch }}/Debug/test_*=2Eexe
 
-      =
- uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # =
v4=2E6=2E2
+      - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1=
c64a875d1fc6a0a # v7=2E0=2E1
         with:
           name: openvpn-mingw-=
${{ matrix=2Earch }}-tests
           path: |
@@ -88,11 +99,11 @@
         =
arch: [x86, x64]
         test: [argv, auth_token, buffer, cryptoapi, crypt=
o, misc, ncp, packet_id, pkt, provider, tls_crypt]
 
-    runs-on: windows-=
latest
+    runs-on: windows-2025-vs2026
     name: "mingw unittest ${{ mat=
rix=2Etest }} - ${{ matrix=2Earch }} - OSSL"
     steps:
       - name: Ret=
rieve mingw unittest
-        uses: actions/download-artifact@d3f86a106a0ba=
c45b974a628896c90dbdf5c8093 # v4=2E3=2E0
+        uses: actions/download-ar=
tifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E0=2E1
         with:=

           name: openvpn-mingw-${{ matrix=2Earch }}-tests
           path:=
 unittests
@@ -131,7 +142,7 @@
       - name: Install dependencies
        =
 run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz=
4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev =
python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - =
name: Checkout OpenVPN
-        uses: actions/checkout@11bd71901bbe5b1630ce=
ea73d27597364c9af683 # v4=2E2=2E2
+        uses: actions/checkout@df4cb1c06=
9e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
       - name: autoconf
      =
   run: autoreconf -fvi
       - name: configure
@@ -158,7 +169,7 @@
      =
 - name: Install dependencies
         run: sudo apt update && sudo apt ins=
tall -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev =
linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automa=
ke autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: a=
ctions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+    =
    uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E=
0=2E3
       - name: autoconf
         run: autoreconf -fvi
       - name: =
configure
@@ -172,9 +183,9 @@
     strategy:
       fail-fast: false
      =
 matrix:
-        ssllib: [openssl@1=2E1, openssl@3, libressl]
+        ssl=
lib: [openssl@3, libressl]
         build: [normal, asan]
-        os: [mac=
os-13, macos-14, macos-15]
+        os: [macos-15, macos-26]
         inclu=
de:
           - build: asan
             cflags: "-fsanitize=3Daddress,und=
efined -fno-sanitize-recover=3Dall -fno-optimize-sibling-calls -fsanitize-a=
ddress-use-after-scope -fno-omit-frame-pointer -g -O1"
@@ -196,7 +207,7 @@
=
       - name: Install dependencies
         run: brew install ${{matrix=2E=
ssllib}} lzo lz4 man2html cmocka libtool automake autoconf
       - name: C=
heckout OpenVPN
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27=
597364c9af683 # v4=2E2=2E2
+        uses: actions/checkout@df4cb1c069e1874e=
dd31b4311f1884172cec0e10 # v6=2E0=2E3
       - name: Set environment
      =
   run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -223,38 +234,52 @@
       =
name: "msbuild - ${{ matrix=2Earch }} - openssl"
       env:
         BUILD=
_CONFIGURATION: Release
+        VCPKG_BINARY_SOURCES: clear;default,readwr=
ite
+        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
=
 
-      runs-on: windows-latest
+      runs-on: windows-2025-vs2026
      =
 steps:
-      - uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9=
af683 # v4=2E2=2E2
-      - uses: lukka/get-cmake@6b3e96a9bc9976b8b546346fd=
d102effedae0ca8 # v4=2E0=2E3
+      - uses: actions/checkout@df4cb1c069e187=
4edd31b4311f1884172cec0e10 # v6=2E0=2E3
+      - uses: lukka/get-cmake@5918=
17e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3
 
       - name: Install =
rst2html
         run: python -m pip install --upgrade pip docutils
 
-    =
  - name: Restore artifacts, or setup vcpkg (do not install any package)
- =
       uses: lukka/run-vcpkg@5e0cab206a5ea620130caf672fce3e4a6b5666a1 # v11=
=2E5
+      - name: Setup vcpkg (do not install any package)
+        uses:=
 lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
       =
  with:
-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7a=
bf
+          vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_ID }}
          =
 vcpkgJsonGlob: '**/windows/vcpkg=2Ejson'
 
+      - name: Set up vcpkg bin=
ary cache
+        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386f=
ccae # v5=2E0=2E5
+        with:
+          path: ${{ env=2EVCPKG_DEFAULT_B=
INARY_CACHE }}
+          key: msvc-${{ matrix=2Earch }}-vcpkg-binary-cache=
-${{ hashFiles('**/windows/vcpkg=2Ejson') }}-${{ env=2EVCPKG_GIT_COMMIT_ID =
}}
+          restore-keys: |
+            msvc-${{ matrix=2Earch }}-vcpkg-=
binary-cache-${{ hashFiles('**/windows/vcpkg=2Ejson') }}-
+            msvc=
-${{ matrix=2Earch }}-vcpkg-binary-cache-
+
+
       - name: Run CMake with=
 vcpkg=2Ejson manifest (NO TESTS)
-        uses: lukka/run-cmake@af1be47fd7=
c933593f687731bc6fdbee024d3ff4 # v10=2E8
+        uses: lukka/run-cmake@5d5=
5ea7949e25f69f0ecb516d8d572297e03a956 # v10=2E9
         if: ${{ matrix=2Ea=
rch =3D=3D 'arm64' }}
         with:
           configurePreset: win-${{ ma=
trix=2Earch }}-release
           buildPreset: win-${{ matrix=2Earch }}-rel=
ease
+          configurePresetAdditionalArgs: "['-GVisual Studio 18 2026']=
"
 
       - name: Run CMake with vcpkg=2Ejson manifest
-        uses: lukk=
a/run-cmake@af1be47fd7c933593f687731bc6fdbee024d3ff4 # v10=2E8
+        use=
s: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10=2E9
     =
    if: ${{ matrix=2Earch !=3D 'arm64' }}
         with:
           configu=
rePreset: win-${{ matrix=2Earch }}-release
           buildPreset: win-${{ =
matrix=2Earch }}-release
           testPreset: win-${{ matrix=2Earch }}-re=
lease
+          configurePresetAdditionalArgs: "['-GVisual Studio 18 2026'=
]"
           testPresetAdditionalArgs: "['--output-on-failure']"
 
-      =
- uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # =
v4=2E6=2E2
+      - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1=
c64a875d1fc6a0a # v7=2E0=2E1
         with:
           name: openvpn-msvc-$=
{{ matrix=2Earch }}
           path: |
@@ -294,7 +319,7 @@
       - name: I=
nstall dependencies
         run: sudo apt update && sudo apt install -y li=
blzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-d=
ev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libn=
l-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/che=
ckout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+        uses: =
actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
    =
     with:
           path: libressl
           repository: libressl/portab=
le
@@ -316,7 +341,7 @@
       - name: "ldconfig"
         run: sudo ldconfi=
g
       - name: Checkout OpenVPN
-        uses: actions/checkout@11bd71901=
bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+        uses: actions/checkou=
t@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2
       - name: auto=
conf
         run: autoreconf -fvi
       - name: configure
diff --git a/=
=2Egithub/workflows/coverity-scan=2Eyml b/=2Egithub/workflows/coverity-scan=
=2Eyml
index 1a9e5a3=2E=2E105f23e 100644
--- a/=2Egithub/workflows/coverity=
-scan=2Eyml
+++ b/=2Egithub/workflows/coverity-scan=2Eyml
@@ -13,7 +13,7 @@=

     steps:
       - name: Check submission cache
         id: check_submi=
t
-        uses: actions/cache/restore@5a3ec84eff668545956fd18022155c47e93e=
2684 # v4=2E2=2E3
+        uses: actions/cache/restore@27d5ce7f107fe9357f9d=
f03efb73ab90386fccae # v5=2E0=2E5
         with:
           path: |
       =
      cov-int
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
         =
if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'true'
-        uses: a=
ctions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4
+        uses=
: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3
 
=
       - name: Download Coverity Build Tool
         if: steps=2Echeck_subm=
it=2Eoutputs=2Ecache-hit !=3D 'true'
@@ -65,7 +65,7 @@
 
       - name: Cac=
he submission
         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D =
'true'
-        uses: actions/cache/save@5a3ec84eff668545956fd18022155c47e9=
3e2684 # v4=2E2=2E3
+        uses: actions/cache/save@27d5ce7f107fe9357f9df=
03efb73ab90386fccae # v5=2E0=2E5
         with:
           path: |
        =
     cov-int

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1754?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-I=
d: Icbcf4c79d577d9cf089a92378be9253b1e94825d
Gerrit-Change-Number: 1754
Ger=
rit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--0DG3FFwaBSY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">GHA: Cherry-pick chang=
es from master to keep working<br><br>Cherry-pick applicable changes from t=
he following commits:<br><br>- GHA: Switch to using VS 2026<br>(cherry pick=
ed from commit 90499e51237cd11f813206371b7ba5176d8eb5ef)<br>- GHA: Add cach=
ing for vcpkg builds<br>(cherry picked from commit 157087736427059316ecff7d=
d21e16b54077221a)<br>- GHA: Maintenance Update April 2026<br>  - Updates GH=
A actions<br>  - Switch uncrustify job to archive: false<br>  - Drop macos-=
14 builds<br>(cherry picked from commit cc2926fd5d09fd501b51520ed5a0b69399d=
b85da)<br>GHA: Maintenance update June 2026<br>  - chore(deps): update gith=
ub actions<br>  - chore(deps): update vcpkg digest to 75672db<br>(cherry pi=
cked from commit f9e6d5d724851a938a0c064307db513df469eb62)<br><br>Further c=
hanges:<br>  - Drop macos-13 builds<br>  - Add macos-26 builds<br>  - Drop =
openssl@1=2E1 from macOS, not available in all versions anymore<br><br>Chan=
ge-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1754<br>Message-Id: &lt;20260629181505=2E20031-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg37398=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M =2Egithub/workflows/build=2Eyaml<br>M =
=2Egithub/workflows/coverity-scan=2Eyml<br>2 files changed, 57 insertions(+=
), 32 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/54/1754/2</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=2Egithu=
b/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml</span><br><span=
>index 1abc178=2E=2E883e2dc 100644</span><br><span>--- a/=2Egithub/workflow=
s/build=2Eyaml</span><br><span>+++ b/=2Egithub/workflows/build=2Eyaml</span=
><br><span>@@ -13,7 +13,7 @@</span><br><span>       - name: Install depende=
ncies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt ins=
tall -y uncrustify</span><br><span>       - name: Checkout OpenVPN</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout=
@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@de0fac2e4=
500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span>         with:=
</span><br><span>           path: openvpn</span><br><span>       - name: Sh=
ow uncrustify version</span><br><span>@@ -27,9 +27,9 @@</span><br><span>   =
    - name: Show changes on standard output</span><br><span>         run: g=
it diff</span><br><span>         working-directory: openvpn</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact=
@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@04=
3fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1</span><br><span>       =
  with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          name=
: uncrustify-changes=2Epatch</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+          archive: false</span><br><span>           path: &#39;ope=
nvpn/uncrustify-changes=2Epatch&#39;</span><br><span>       - name: Set job=
 status</span><br><span>         run: test ! -s uncrustify-changes=2Epatch<=
/span><br><span>@@ -45,27 +45,38 @@</span><br><span>     runs-on: ubuntu-24=
=2E04</span><br><span>     env:</span><br><span>       VCPKG_ROOT: ${{ gith=
ub=2Eworkspace }}/vcpkg</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      VCPKG_BINARY_SOURCES: clear;default,readwrite</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      VCPKG_GIT_COMMIT_ID: 75672db6bd81=
2b060482b0f00b5a16b18a0c0f07</span><br><span>     steps:</span><br><span>  =
     - name: Install dependencies</span><br><span>         run: sudo apt up=
date &amp;&amp; sudo apt install -y mingw-w64 unzip build-essential wget py=
thon3-docutils man2html-base</span><br><span>       - name: Checkout OpenVP=
N</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: action=
s/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout=
@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/get-=
cmake@6b3e96a9bc9976b8b546346fdd102effedae0ca8 # v4=2E0=2E3</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      - name: Restore from cache and =
install vcpkg</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
uses: lukka/run-vcpkg@5e0cab206a5ea620130caf672fce3e4a6b5666a1 # v11=2E5</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/ge=
t-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      - name: Setup vcpkg</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-vcp=
kg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6</span><br><span>     =
    with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vc=
pkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: ${{ env=2E=
VCPKG_GIT_COMMIT_ID }}</span><br><span>           vcpkgJsonGlob: &#39;**/mi=
ngw/vcpkg=2Ejson&#39;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      - name: Set up vcpkg binary cache</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache@27d5ce7=
f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        with:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+          path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          key: min=
gw-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/mingw/vcpk=
g=2Ejson&#39;) }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+          restore-keys: |</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            mingw-${{ matrix=2Earch }}=
-vcpkg-binary-cache-${{ hashFiles(&#39;**/mingw/vcpkg=2Ejson&#39;) }}-</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            mingw-${{ ma=
trix=2Earch }}-vcpkg-binary-cache-</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>       - name: Run CMake with vcpkg=2Ejson =
manifest</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses:=
 lukka/run-cmake@af1be47fd7c933593f687731bc6fdbee024d3ff4 # v10=2E8</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-cma=
ke@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10=2E9</span><br><span>     =
    with:</span><br><span>           configurePreset: mingw-${{ matrix=2Ear=
ch }}</span><br><span>           buildPreset: mingw-${{ matrix=2Earch }}</s=
pan><br><span>           buildPresetAdditionalArgs: &quot;[&#39;--config De=
bug&#39;]&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92=
b4886f43607fa02 # v4=2E6=2E2</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64=
a875d1fc6a0a # v7=2E0=2E1</span><br><span>         with:</span><br><span>  =
         name: openvpn-mingw-${{ matrix=2Earch }}</span><br><span>         =
  path: |</span><br><span>@@ -73,7 +84,7 @@</span><br><span>             ${=
{ github=2Eworkspace }}/out/build/mingw/${{ matrix=2Earch }}/**/Debug/*=2Ed=
ll</span><br><span>             !${{ github=2Eworkspace }}/out/build/mingw/=
${{ matrix=2Earch }}/Debug/test_*=2Eexe</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-artifact@e=
a165f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artifact@043=
fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1</span><br><span>        =
 with:</span><br><span>           name: openvpn-mingw-${{ matrix=2Earch }}-=
tests</span><br><span>           path: |</span><br><span>@@ -88,11 +99,11 @=
@</span><br><span>         arch: [x86, x64]</span><br><span>         test: =
[argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, pr=
ovider, tls_crypt]</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    runs-on: windows-latest</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    runs-on: windows-2025-vs2026</span><br><span>   =
  name: &quot;mingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earch }} - =
OSSL&quot;</span><br><span>     steps:</span><br><span>       - name: Retri=
eve mingw unittest</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     uses: actions/download-artifact@d3f86a106a0bac45b974a628896c90dbdf5c80=
93 # v4=2E3=2E0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7=
c # v8=2E0=2E1</span><br><span>         with:</span><br><span>           na=
me: openvpn-mingw-${{ matrix=2Earch }}-tests</span><br><span>           pat=
h: unittests</span><br><span>@@ -131,7 +142,7 @@</span><br><span>       - n=
ame: Install dependencies</span><br><span>         run: sudo apt update &am=
p;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-d=
ev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils =
libtool automake autoconf ${SSLPKG} ${PKCS11PKG}</span><br><span>       - n=
ame: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v=
4=2E2=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        us=
es: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3<=
/span><br><span>       - name: autoconf</span><br><span>         run: autor=
econf -fvi</span><br><span>       - name: configure</span><br><span>@@ -158=
,7 +169,7 @@</span><br><span>       - name: Install dependencies</span><br>=
<span>         run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-=
dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev m=
an2html clang libcmocka-dev python3-docutils libtool automake autoconf libm=
bedtls-dev</span><br><span>       - name: Checkout OpenVPN</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@11bd719=
01bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874ed=
d31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       - name: autocon=
f</span><br><span>         run: autoreconf -fvi</span><br><span>       - na=
me: configure</span><br><span>@@ -172,9 +183,9 @@</span><br><span>     stra=
tegy:</span><br><span>       fail-fast: false</span><br><span>       matrix=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ssllib: [ope=
nssl@1=2E1, openssl@3, libressl]</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        ssllib: [openssl@3, libressl]</span><br><span>        =
 build: [normal, asan]</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        os: [macos-13, macos-14, macos-15]</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        os: [macos-15, macos-26]</span><br><span>  =
       include:</span><br><span>           - build: asan</span><br><span>  =
           cflags: &quot;-fsanitize=3Daddress,undefined -fno-sanitize-recov=
er=3Dall -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fn=
o-omit-frame-pointer -g -O1&quot;</span><br><span>@@ -196,7 +207,7 @@</span=
><br><span>       - name: Install dependencies</span><br><span>         run=
: brew install ${{matrix=2Essllib}} lzo lz4 man2html cmocka libtool automak=
e autoconf</span><br><span>       - name: Checkout OpenVPN</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@11bd719=
01bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874ed=
d31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       - name: Set env=
ironment</span><br><span>         run: |</span><br><span>           cat &gt=
;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span>@@ -223,38 +234,52 @@</span><=
br><span>       name: &quot;msbuild - ${{ matrix=2Earch }} - openssl&quot;<=
/span><br><span>       env:</span><br><span>         BUILD_CONFIGURATION: R=
elease</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VCPKG=
_BINARY_SOURCES: clear;default,readwrite</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00=
b5a16b18a0c0f07</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      runs-on: windows-latest</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      runs-on: windows-2025-vs2026</span><br><span>  =
     steps:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - us=
es: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: lukka/ge=
t-cmake@6b3e96a9bc9976b8b546346fdd102effedae0ca8 # v4=2E0=2E3</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/checkout@df=
4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@591817e96fc=
ad43505fb4eae36172462abb3a42e # v4=2E3=2E3</span><br><span> </span><br><spa=
n>       - name: Install rst2html</span><br><span>         run: python -m p=
ip install --upgrade pip docutils</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - name: Restore artifacts, or setup v=
cpkg (do not install any package)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        uses: lukka/run-vcpkg@5e0cab206a5ea620130caf672fce3e4a6=
b5666a1 # v11=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    - name: Setup vcpkg (do not install any package)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-vcpkg@b1a0dd252f0=
6b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6</span><br><span>         with:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId=
: f33cc491c85a7d643c5ab6da1667c1458e6d7abf</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+          vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COMM=
IT_ID }}</span><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg=2E=
json&#39;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      - name: Set up vcpkg binary cache</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: actions/cache@27d5ce7f107fe9357f9=
df03efb73ab90386fccae # v5=2E0=2E5</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        with:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+          path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+          key: msvc-${{ matrix=
=2Earch }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/windows/vcpkg=2Ejson&#3=
9;) }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          restore-keys: |</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            msvc-${{ matrix=2Earch }}-vcpkg-binar=
y-cache-${{ hashFiles(&#39;**/windows/vcpkg=2Ejson&#39;) }}-</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msvc-${{ matrix=2Earch=
 }}-vcpkg-binary-cache-</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>       - name: Run CMake with vcpkg=2Ejson manifest (NO TESTS)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@af=
1be47fd7c933593f687731bc6fdbee024d3ff4 # v10=2E8</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@5d55ea7949e25f69=
f0ecb516d8d572297e03a956 # v10=2E9</span><br><span>         if: ${{ matrix=
=2Earch =3D=3D &#39;arm64&#39; }}</span><br><span>         with:</span><br>=
<span>           configurePreset: win-${{ matrix=2Earch }}-release</span><b=
r><span>           buildPreset: win-${{ matrix=2Earch }}-release</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+          configurePresetAddit=
ionalArgs: &quot;[&#39;-GVisual Studio 18 2026&#39;]&quot;</span><br><span>=
 </span><br><span>       - name: Run CMake with vcpkg=2Ejson manifest</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-cma=
ke@af1be47fd7c933593f687731bc6fdbee024d3ff4 # v10=2E8</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@5d55ea7949e=
25f69f0ecb516d8d572297e03a956 # v10=2E9</span><br><span>         if: ${{ ma=
trix=2Earch !=3D &#39;arm64&#39; }}</span><br><span>         with:</span><b=
r><span>           configurePreset: win-${{ matrix=2Earch }}-release</span>=
<br><span>           buildPreset: win-${{ matrix=2Earch }}-release</span><b=
r><span>           testPreset: win-${{ matrix=2Earch }}-release</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+          configurePresetAdditi=
onalArgs: &quot;[&#39;-GVisual Studio 18 2026&#39;]&quot;</span><br><span> =
          testPresetAdditionalArgs: &quot;[&#39;--output-on-failure&#39;]&q=
uot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607=
fa02 # v4=2E6=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0=
a # v7=2E0=2E1</span><br><span>         with:</span><br><span>           na=
me: openvpn-msvc-${{ matrix=2Earch }}</span><br><span>           path: |</s=
pan><br><span>@@ -294,7 +319,7 @@</span><br><span>       - name: Install de=
pendencies</span><br><span>         run: sudo apt update &amp;&amp; sudo ap=
t install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html cl=
ang libcmocka-dev python3-docutils libtool automake autoconf pkg-config lib=
cap-ng-dev libnl-genl-3-dev</span><br><span>       - name: &quot;libressl: =
checkout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=
=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: a=
ctions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span=
><br><span>         with:</span><br><span>           path: libressl</span><=
br><span>           repository: libressl/portable</span><br><span>@@ -316,7=
 +341,7 @@</span><br><span>       - name: &quot;ldconfig&quot;</span><br><s=
pan>         run: sudo ldconfig</span><br><span>       - name: Checkout Ope=
nVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: act=
ions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/check=
out@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span> =
      - name: autoconf</span><br><span>         run: autoreconf -fvi</span>=
<br><span>       - name: configure</span><br><span>diff --git a/=2Egithub/w=
orkflows/coverity-scan=2Eyml b/=2Egithub/workflows/coverity-scan=2Eyml</spa=
n><br><span>index 1a9e5a3=2E=2E105f23e 100644</span><br><span>--- a/=2Egith=
ub/workflows/coverity-scan=2Eyml</span><br><span>+++ b/=2Egithub/workflows/=
coverity-scan=2Eyml</span><br><span>@@ -13,7 +13,7 @@</span><br><span>     =
steps:</span><br><span>       - name: Check submission cache</span><br><spa=
n>         id: check_submit</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        uses: actions/cache/restore@5a3ec84eff668545956fd18022155c47e=
93e2684 # v4=2E2=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        uses: actions/cache/restore@27d5ce7f107fe9357f9df03efb73ab90386fcc=
ae # v5=2E0=2E5</span><br><span>         with:</span><br><span>           p=
ath: |</span><br><span>             cov-int</span><br><span>@@ -25,7 +25,7 =
@@</span><br><span> </span><br><span>       - name: Checkout OpenVPN</span>=
<br><span>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D &#39=
;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        use=
s: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkou=
t@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span> </=
span><br><span>       - name: Download Coverity Build Tool</span><br><span>=
         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;=
</span><br><span>@@ -65,7 +65,7 @@</span><br><span> </span><br><span>      =
 - name: Cache submission</span><br><span>         if: steps=2Echeck_submit=
=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        uses: actions/cache/save@5a3ec84eff668545956fd=
18022155c47e93e2684 # v4=2E2=2E3</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uses: actions/cache/save@27d5ce7f107fe9357f9df03efb73a=
b90386fccae # v5=2E0=2E5</span><br><span>         with:</span><br><span>   =
        path: |</span><br><span>             cov-int</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1754?usp=3Demail">change 1754</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1754?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Icbcf4c79d577d9cf089a92378be9253b=
1e94825d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1754 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html=
>
--0DG3FFwaBSY=--


--===============2032712591709026298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2032712591709026298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2032712591709026298==--

