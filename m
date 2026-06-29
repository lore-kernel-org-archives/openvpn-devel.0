Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CBFC43602
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=7zDRuYDP44QztRBI8OR6etwbwM/+NBiyFyKOS918lAY=; b=KZ4BLpJb23HvBW
	oA/NpagBAVUdfYt2KXfmq6t3t8q7bE2jgUdKxwlY85g9uLG4VBSO6ytQyLKXR163q/HSLJk+fwdVe
	6C/1qtU4hkxRJYZjDE9uHOJhzosbEVU0YqgEcfIBWw2QVgp5f1LOpqmLXJte7MPcRMNy/VM3MiYNU
	ggI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weCCP-0003f8-SM;
	Mon, 29 Jun 2026 13:38:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weCCO-0003el-0t
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:38:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KwCkKTnuNWWidEOoTqVvGx/UJd8raIEctcQkTNrIy3I=; b=Q7u71lVTkvLlDvXuwgiOyySvRz
 O9LJ3Z02JZpKSGrNjJlKtoQwXNT5OexbYWIQmM2O+Hf6fXLZi0zKnjFRcX0A9eDgFf1AjpiPEgivN
 wlSYyfzNeWDRkGwOW7emnrhW7B0m5YbHjV72A4UfKZUSSQJGk+zJjDkNKkgT0D0R10yc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KwCkKTnuNWWidEOoTqVvGx/UJd8raIEctcQkTNrIy3I=; b=c
 EKNzTsn7avydnlZzlcln6W+tVfPstObmMT4Y5VgDxLsNlZff2/Geo7yHatZqYEgWDPA2Sb8EdmBJs
 3cNJO5FGZ7e3rw1SzU46qg1/jsFc/o4fbd8DS1JzzAgrqV3W7MfHp/cevxLDnr0Nj9zVJZH6npcTL
 RSVF5i2op1exYj7Q=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weCCL-0008CB-3z for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:38:56 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493b691cb44so3041225e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782740322; x=1783345122; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwCkKTnuNWWidEOoTqVvGx/UJd8raIEctcQkTNrIy3I=;
 b=SxqaexfEO1sLBumnPIr9paFVAdEOn1vbBuzlvEB7XEB5W31BNPB0KadMutNyHPIehf
 jKpVM2UwOI7Rvw8d0TOzAVxB9+zFv1Fx16rIgjWbV+LRl4y1MZOUfV5Z1lKg8NARYZ7E
 HFpjhb6E9Igd32Hr2FC3rEYrBTfpIP2eCxLpmoyTWw02PsANM+B9mdSHvddqWsZ7Eq3W
 U19sEju7FtGG5cn4/+921qY9lI79Vtiy5JzOTURWpFTz5P8fVFsJ1hiSZa3WiIXEiIij
 7cb7P5/MHmUSkb/m4IG9t5cxuRe0dJweorGGpLLfXFrbbMWW2/oiGPczPZbpREKgEQsQ
 PUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740322; x=1783345122;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KwCkKTnuNWWidEOoTqVvGx/UJd8raIEctcQkTNrIy3I=;
 b=a8TCocB1jEHISvhGTS+cW+Xcac4hgBke0G2uaDXTYYyFJ1BEeigaXTxhL0LGULrtms
 KKJrtpsg3n+1dVff5y/SqFRdoE0xUsCDAE5oU3mZcCIGSmZ1CmrXM9iXt2qjlM1LM3hf
 MMVJXr4DQhqakN1apZzVtHbPqTHTqUBwvRuxQ57aK4NprfLYwfKJX2mBHkwsYzFFLfiP
 36moFjwInJ64qNTrEFLcDtowUZG+QOvQDiG/mXa8Bk9YRfZZuR12KXPMN9KHfSyKiRzR
 JDV2V/lA7V8g1tJs2rZXtgsnHxAk1YYn6gpOTuYJ4ogz+WbW0N0tRSGFv7i+6KUICgZT
 7yKQ==
X-Gm-Message-State: AOJu0YyHbBAWZjE6pcIQKsyuStInf/pJ+B/iBARMvJO+wdUfaysaextM
 jj0lsSujIf3eV2oA6MlytPPyckj7Yo3dcsuF/xl954B8t7IjecUArCDK0Mu9H2zDIwYCBsTt1i8
 JbRDy7RF1sID6PHeXHGbav833W4YsVoyy9kR7gK6Jeibe7rxsFm+3LErofCav0rq/kYweXusziA
 P1ZZJIMg==
X-Gm-Gg: AfdE7cm3HyoJ3LYjoGB9YhNCYaGDaBUlSy7UfMAtoG8qwCXUUcmL/iW8yi3g7F7PYJa
 k9psK0O0+4TMxxM3hEhWjXAAuf74hMzgZRHyCFj3yv6oBqdng21hMqDlOgf9CBIGTBC6VzB4ZPk
 x40RTF09cNyHLW1iaILsg1esvhW8MBDCLQPDiJcwWF/8PXTAfjrDUyrCysZevwzGVNce3BfflgZ
 17UF0QZ+vHMQgftCnvhbI53FimFJWWMQ+1ez557dUd38ZUEp3hyWFA4tOyvHuGmBQA2uwax52E+
 PesqRC1xCc0Aa/PjbZC9KGjw1M8lE196q0WRPPkKK82ygQXppYKy6MaFaWJA+oF8l5emnY4r5um
 NIMSSewij/PjChs8aEFuwTbQuS1NI6vm/pp+UoDZhCyCCKZCWG56sacwyVuYE8mdYHmoVNHsCq9
 dYUn0OxK7hIiF27JUpjp7Mk85rSVDDkQ+ZLBn3EyReP8XL86wQ70LNvvNO51Te9Oov2MDGr7h8g
 bNvFW4hWO+OGhnFv2zoMZxdkg9mJ7Gu6v04sfe+Aa70zgZ/Gavox0HG1TXLg6crwVdjLJFr92gb
 ung=
X-Received: by 2002:a05:600c:8b74:b0:493:a976:5c6e with SMTP id
 5b1f17b1804b1-493a9765f47mr82039285e9.16.1782740320954; 
 Mon, 29 Jun 2026 06:38:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4701835b625sm28166353f8f.36.2026.06.29.06.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:38:40 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 13:38:40 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
X-Gerrit-Change-Number: 1754
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1754?usp=email>
X-Gerrit-Commit: 438ec4d558136e24dad22269dc2421e55c47dafb
References: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQwMzE3MDAwLkljYmNmNGM3OWQ1NzdkOWNmMDg5YTkyMzc4YmU5MjUzYjFlOTQ4MjVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <729f6c8df5fecec5b19d6a3f4e65d420a13862b2-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weCCL-0008CB-3z
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8659492181702059514=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8659492181702059514==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dr/Hd5NyyKw="; charset=UTF-8

--dr/Hd5NyyKw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1754?usp=3Demail

to review the following change=2E


Chang=
e subject: GHA: Cherry-pick changes from master to keep working
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

GHA: Cherry-pick chang=
es from master to keep working

Cherry-pick applicable changes from the fol=
lowing commits:

- GHA: Switch to using VS 2026
(cherry picked from commit =
90499e51237cd11f813206371b7ba5176d8eb5ef)
- GHA: Add caching for vcpkg buil=
ds
(cherry picked from commit 157087736427059316ecff7dd21e16b54077221a)
- G=
HA: Maintenance Update April 2026
  - Updates GHA actions
  - Switch uncrus=
tify job to archive: false
  - Drop macos-14 builds
(cherry picked from com=
mit cc2926fd5d09fd501b51520ed5a0b69399db85da)
GHA: Maintenance update June =
2026
  - chore(deps): update github actions
  - chore(deps): update vcpkg d=
igest to 75672db
(cherry picked from commit f9e6d5d724851a938a0c064307db513=
df469eb62)

Further changes:
  - Drop macos-13 builds
  - Add macos-26 buil=
ds
  - Drop openssl@1=2E1 from macOS, not available in all versions anymore=


Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
Signed-off-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
---
M =2Egithub/workflows/build=2Eya=
ml
M =2Egithub/workflows/coverity-scan=2Eyml
2 files changed, 57 insertions=
(+), 32 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/54/1754/1

diff --git a/=2Egithub/workflows/build=2Eyaml b/=
=2Egithub/workflows/build=2Eyaml
index 1abc178=2E=2E883e2dc 100644
--- a/=
=2Egithub/workflows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ =
-13,7 +13,7 @@
       - name: Install dependencies
         run: sudo apt u=
pdate && sudo apt install -y uncrustify
       - name: Checkout OpenVPN
-  =
      uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=
=2E2=2E2
+        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447=
ce83dd # v6=2E0=2E2
         with:
           path: openvpn
       - name: =
Show uncrustify version
@@ -27,9 +27,9 @@
       - name: Show changes on st=
andard output
         run: git diff
         working-directory: openvpn
- =
     - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa=
02 # v4=2E6=2E2
+      - uses: actions/upload-artifact@043fb46d1a93c77aae65=
6e7c1c64a875d1fc6a0a # v7=2E0=2E1
         with:
-          name: uncrustif=
y-changes=2Epatch
+          archive: false
           path: 'openvpn/uncru=
stify-changes=2Epatch'
       - name: Set job status
         run: test ! -=
s uncrustify-changes=2Epatch
@@ -45,27 +45,38 @@
     runs-on: ubuntu-24=2E=
04
     env:
       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg
+      VCPK=
G_BINARY_SOURCES: clear;default,readwrite
+      VCPKG_GIT_COMMIT_ID: 75672=
db6bd812b060482b0f00b5a16b18a0c0f07
     steps:
       - name: Install depe=
ndencies
         run: sudo apt update && sudo apt install -y mingw-w64 unz=
ip build-essential wget python3-docutils man2html-base
       - name: Check=
out OpenVPN
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d275973=
64c9af683 # v4=2E2=2E2
+        uses: actions/checkout@df4cb1c069e1874edd31=
b4311f1884172cec0e10 # v6=2E0=2E3
 
-      - uses: lukka/get-cmake@6b3e96a9=
bc9976b8b546346fdd102effedae0ca8 # v4=2E0=2E3
-      - name: Restore from c=
ache and install vcpkg
-        uses: lukka/run-vcpkg@5e0cab206a5ea620130ca=
f672fce3e4a6b5666a1 # v11=2E5
+      - uses: lukka/get-cmake@591817e96fcad4=
3505fb4eae36172462abb3a42e # v4=2E3=2E3
+      - name: Setup vcpkg
+       =
 uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11=2E6
 =
        with:
-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c145=
8e6d7abf
+          vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_ID }}
    =
       vcpkgJsonGlob: '**/mingw/vcpkg=2Ejson'
 
+      - name: Set up vcpkg=
 binary cache
+        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90=
386fccae # v5=2E0=2E5
+        with:
+          path: ${{ env=2EVCPKG_DEFAU=
LT_BINARY_CACHE }}
+          key: mingw-${{ matrix=2Earch }}-vcpkg-binary-=
cache-${{ hashFiles('**/mingw/vcpkg=2Ejson') }}-${{ env=2EVCPKG_GIT_COMMIT_=
ID }}
+          restore-keys: |
+            mingw-${{ matrix=2Earch }}-vc=
pkg-binary-cache-${{ hashFiles('**/mingw/vcpkg=2Ejson') }}-
+            mi=
ngw-${{ matrix=2Earch }}-vcpkg-binary-cache-
+
       - name: Run CMake wit=
h vcpkg=2Ejson manifest
-        uses: lukka/run-cmake@af1be47fd7c933593f68=
7731bc6fdbee024d3ff4 # v10=2E8
+        uses: lukka/run-cmake@5d55ea7949e25=
f69f0ecb516d8d572297e03a956 # v10=2E9
         with:
           configurePr=
eset: mingw-${{ matrix=2Earch }}
           buildPreset: mingw-${{ matrix=
=2Earch }}
           buildPresetAdditionalArgs: "['--config Debug']"
 
-  =
    - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa0=
2 # v4=2E6=2E2
+      - uses: actions/upload-artifact@043fb46d1a93c77aae656=
e7c1c64a875d1fc6a0a # v7=2E0=2E1
         with:
           name: openvpn-mi=
ngw-${{ matrix=2Earch }}
           path: |
@@ -73,7 +84,7 @@
             =
${{ github=2Eworkspace }}/out/build/mingw/${{ matrix=2Earch }}/**/Debug/*=
=2Edll
             !${{ github=2Eworkspace }}/out/build/mingw/${{ matrix=
=2Earch }}/Debug/test_*=2Eexe
 
-      - uses: actions/upload-artifact@ea16=
5f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2
+      - uses: actions/up=
load-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1
       =
  with:
           name: openvpn-mingw-${{ matrix=2Earch }}-tests
         =
  path: |
@@ -88,11 +99,11 @@
         arch: [x86, x64]
         test: [arg=
v, auth_token, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, provid=
er, tls_crypt]
 
-    runs-on: windows-latest
+    runs-on: windows-2025-vs=
2026
     name: "mingw unittest ${{ matrix=2Etest }} - ${{ matrix=2Earch }}=
 - OSSL"
     steps:
       - name: Retrieve mingw unittest
-        uses: =
actions/download-artifact@d3f86a106a0bac45b974a628896c90dbdf5c8093 # v4=2E3=
=2E0
+        uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e=
0b5a5461e7c # v8=2E0=2E1
         with:
           name: openvpn-mingw-${{ =
matrix=2Earch }}-tests
           path: unittests
@@ -131,7 +142,7 @@
     =
  - name: Install dependencies
         run: sudo apt update && sudo apt in=
stall -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev=
 linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake au=
toconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses=
: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+ =
       uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=
=2E0=2E3
       - name: autoconf
         run: autoreconf -fvi
       - nam=
e: configure
@@ -158,7 +169,7 @@
       - name: Install dependencies
      =
   run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev lib=
lz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmo=
cka-dev python3-docutils libtool automake autoconf libmbedtls-dev
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
@@ -172,9 +183,9 @@
     s=
trategy:
       fail-fast: false
       matrix:
-        ssllib: [openssl@1=
=2E1, openssl@3, libressl]
+        ssllib: [openssl@3, libressl]
         =
build: [normal, asan]
-        os: [macos-13, macos-14, macos-15]
+        =
os: [macos-15, macos-26]
         include:
           - build: asan
       =
      cflags: "-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall -=
fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-fra=
me-pointer -g -O1"
@@ -196,7 +207,7 @@
       - name: Install dependencies
=
         run: brew install ${{matrix=2Essllib}} lzo lz4 man2html cmocka lib=
tool automake autoconf
       - name: Checkout OpenVPN
-        uses: actio=
ns/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
+        =
uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E=
3
       - name: Set environment
         run: |
           cat >>$GITHUB_E=
NV <<EOF;
@@ -223,38 +234,52 @@
       name: "msbuild - ${{ matrix=2Earch }=
} - openssl"
       env:
         BUILD_CONFIGURATION: Release
+        VCP=
KG_BINARY_SOURCES: clear;default,readwrite
+        VCPKG_GIT_COMMIT_ID: 75=
672db6bd812b060482b0f00b5a16b18a0c0f07
 
-      runs-on: windows-latest
+  =
    runs-on: windows-2025-vs2026
       steps:
-      - uses: actions/check=
out@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2
-      - uses: lu=
kka/get-cmake@6b3e96a9bc9976b8b546346fdd102effedae0ca8 # v4=2E0=2E3
+      =
- uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=2E0=
=2E3
+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42=
e # v4=2E3=2E3
 
       - name: Install rst2html
         run: python -m pi=
p install --upgrade pip docutils
 
-      - name: Restore artifacts, or set=
up vcpkg (do not install any package)
-        uses: lukka/run-vcpkg@5e0cab=
206a5ea620130caf672fce3e4a6b5666a1 # v11=2E5
+      - name: Setup vcpkg (do=
 not install any package)
+        uses: lukka/run-vcpkg@b1a0dd252f06b9e25b=
3c022a9a03bd7a427fb6a2 # v11=2E6
         with:
-          vcpkgGitCommitId=
: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
+          vcpkgGitCommitId: ${{=
 env=2EVCPKG_GIT_COMMIT_ID }}
           vcpkgJsonGlob: '**/windows/vcpkg=
=2Ejson'
 
+      - name: Set up vcpkg binary cache
+        uses: actions/=
cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5
+        with:
=
+          path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}
+          key: ms=
vc-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles('**/windows/vcpkg=
=2Ejson') }}-${{ env=2EVCPKG_GIT_COMMIT_ID }}
+          restore-keys: |
+ =
           msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles('**/w=
indows/vcpkg=2Ejson') }}-
+            msvc-${{ matrix=2Earch }}-vcpkg-bina=
ry-cache-
+
+
       - name: Run CMake with vcpkg=2Ejson manifest (NO TESTS=
)
-        uses: lukka/run-cmake@af1be47fd7c933593f687731bc6fdbee024d3ff4 #=
 v10=2E8
+        uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e0=
3a956 # v10=2E9
         if: ${{ matrix=2Earch =3D=3D 'arm64' }}
         w=
ith:
           configurePreset: win-${{ matrix=2Earch }}-release
         =
  buildPreset: win-${{ matrix=2Earch }}-release
+          configurePresetA=
dditionalArgs: "['-GVisual Studio 18 2026']"
 
       - name: Run CMake wit=
h vcpkg=2Ejson manifest
-        uses: lukka/run-cmake@af1be47fd7c933593f68=
7731bc6fdbee024d3ff4 # v10=2E8
+        uses: lukka/run-cmake@5d55ea7949e25=
f69f0ecb516d8d572297e03a956 # v10=2E9
         if: ${{ matrix=2Earch !=3D '=
arm64' }}
         with:
           configurePreset: win-${{ matrix=2Earch =
}}-release
           buildPreset: win-${{ matrix=2Earch }}-release
       =
    testPreset: win-${{ matrix=2Earch }}-release
+          configurePreset=
AdditionalArgs: "['-GVisual Studio 18 2026']"
           testPresetAddition=
alArgs: "['--output-on-failure']"
 
-      - uses: actions/upload-artifact@=
ea165f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2
+      - uses: action=
s/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1
   =
      with:
           name: openvpn-msvc-${{ matrix=2Earch }}
           p=
ath: |
@@ -294,7 +319,7 @@
       - name: Install dependencies
         run=
: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-de=
v linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool auto=
make autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "lib=
ressl: checkout"
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d2=
7597364c9af683 # v4=2E2=2E2
+        uses: actions/checkout@de0fac2e4500dab=
e0009e67214ff5f5447ce83dd # v6=2E0=2E2
         with:
           path: libr=
essl
           repository: libressl/portable
@@ -316,7 +341,7 @@
       - =
name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVP=
N
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 =
# v4=2E2=2E2
+        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f=
5447ce83dd # v6=2E0=2E2
       - name: autoconf
         run: autoreconf -f=
vi
       - name: configure
diff --git a/=2Egithub/workflows/coverity-scan=
=2Eyml b/=2Egithub/workflows/coverity-scan=2Eyml
index 1a9e5a3=2E=2E105f23e=
 100644
--- a/=2Egithub/workflows/coverity-scan=2Eyml
+++ b/=2Egithub/workf=
lows/coverity-scan=2Eyml
@@ -13,7 +13,7 @@
     steps:
       - name: Check=
 submission cache
         id: check_submit
-        uses: actions/cache/re=
store@5a3ec84eff668545956fd18022155c47e93e2684 # v4=2E2=2E3
+        uses: =
actions/cache/restore@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5=

         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@
 =

       - name: Checkout OpenVPN
         if: steps=2Echeck_submit=2Eoutput=
s=2Ecache-hit !=3D 'true'
-        uses: actions/checkout@11bd71901bbe5b163=
0ceea73d27597364c9af683 # v4
+        uses: actions/checkout@df4cb1c069e187=
4edd31b4311f1884172cec0e10 # v6=2E0=2E3
 
       - name: Download Coverity =
Build Tool
         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'tr=
ue'
@@ -65,7 +65,7 @@
 
       - name: Cache submission
         if: steps=
=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D 'true'
-        uses: actions/ca=
che/save@5a3ec84eff668545956fd18022155c47e93e2684 # v4=2E2=2E3
+        use=
s: actions/cache/save@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5=

         with:
           path: |
             cov-int

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ger=
rit-Branch: release/2=2E6
Gerrit-Change-Id: Icbcf4c79d577d9cf089a92378be925=
3b1e94825d
Gerrit-Change-Number: 1754
Gerrit-PatchSet: 1
Gerrit-Owner: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--dr/Hd5NyyKw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">GHA: Cherry-pick changes from master to keep working<br><br>Cherry-pic=
k applicable changes from the following commits:<br><br>- GHA: Switch to us=
ing VS 2026<br>(cherry picked from commit 90499e51237cd11f813206371b7ba5176=
d8eb5ef)<br>- GHA: Add caching for vcpkg builds<br>(cherry picked from comm=
it 157087736427059316ecff7dd21e16b54077221a)<br>- GHA: Maintenance Update A=
pril 2026<br>  - Updates GHA actions<br>  - Switch uncrustify job to archiv=
e: false<br>  - Drop macos-14 builds<br>(cherry picked from commit cc2926fd=
5d09fd501b51520ed5a0b69399db85da)<br>GHA: Maintenance update June 2026<br> =
 - chore(deps): update github actions<br>  - chore(deps): update vcpkg dige=
st to 75672db<br>(cherry picked from commit f9e6d5d724851a938a0c064307db513=
df469eb62)<br><br>Further changes:<br>  - Drop macos-13 builds<br>  - Add m=
acos-26 builds<br>  - Drop openssl@1=2E1 from macOS, not available in all v=
ersions anymore<br><br>Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---=
<br>M =2Egithub/workflows/build=2Eyaml<br>M =2Egithub/workflows/coverity-sc=
an=2Eyml<br>2 files changed, 57 insertions(+), 32 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/54/1754/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Eg=
ithub/workflows/build=2Eyaml</span><br><span>index 1abc178=2E=2E883e2dc 100=
644</span><br><span>--- a/=2Egithub/workflows/build=2Eyaml</span><br><span>=
+++ b/=2Egithub/workflows/build=2Eyaml</span><br><span>@@ -13,7 +13,7 @@</s=
pan><br><span>       - name: Install dependencies</span><br><span>         =
run: sudo apt update &amp;&amp; sudo apt install -y uncrustify</span><br><s=
pan>       - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597=
364c9af683 # v4=2E2=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd=
 # v6=2E0=2E2</span><br><span>         with:</span><br><span>           pat=
h: openvpn</span><br><span>       - name: Show uncrustify version</span><br=
><span>@@ -27,9 +27,9 @@</span><br><span>       - name: Show changes on sta=
ndard output</span><br><span>         run: git diff</span><br><span>       =
  working-directory: openvpn</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886=
f43607fa02 # v4=2E6=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d=
1fc6a0a # v7=2E0=2E1</span><br><span>         with:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-          name: uncrustify-changes=2Epatch<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+          archive: f=
alse</span><br><span>           path: &#39;openvpn/uncrustify-changes=2Epat=
ch&#39;</span><br><span>       - name: Set job status</span><br><span>     =
    run: test ! -s uncrustify-changes=2Epatch</span><br><span>@@ -45,27 +45=
,38 @@</span><br><span>     runs-on: ubuntu-24=2E04</span><br><span>     en=
v:</span><br><span>       VCPKG_ROOT: ${{ github=2Eworkspace }}/vcpkg</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      VCPKG_BINARY_SOURCE=
S: clear;default,readwrite</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07<=
/span><br><span>     steps:</span><br><span>       - name: Install dependen=
cies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt inst=
all -y mingw-w64 unzip build-essential wget python3-docutils man2html-base<=
/span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        uses: actions/checkout@11bd71901bbe5b1630=
ceea73d27597364c9af683 # v4=2E2=2E2</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874edd31b4311f18=
84172cec0e10 # v6=2E0=2E3</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@6b3e96a9bc9976b8b546346=
fdd102effedae0ca8 # v4=2E0=2E3</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      - name: Restore from cache and install vcpkg</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-vcpkg@5e0cab2=
06a5ea620130caf672fce3e4a6b5666a1 # v11=2E5</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@591817e96fcad43505fb4=
eae36172462abb3a42e # v4=2E3=2E3</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      - name: Setup vcpkg</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a=
03bd7a427fb6a2 # v11=2E6</span><br><span>         with:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: f33cc491c85a7=
d643c5ab6da1667c1458e6d7abf</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+          vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_ID }}</span>=
<br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg=2Ejson&#39;</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - n=
ame: Set up vcpkg binary cache</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386f=
ccae # v5=2E0=2E5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
  path: ${{ env=2EVCPKG_DEFAULT_BINARY_CACHE }}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+          key: mingw-${{ matrix=2Earch }}-vcpkg=
-binary-cache-${{ hashFiles(&#39;**/mingw/vcpkg=2Ejson&#39;) }}-${{ env=2EV=
CPKG_GIT_COMMIT_ID }}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+          restore-keys: |</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            mingw-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashF=
iles(&#39;**/mingw/vcpkg=2Ejson&#39;) }}-</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            mingw-${{ matrix=2Earch }}-vcpkg-binary-c=
ache-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>       - name: Run CMake with vcpkg=2Ejson manifest</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/run-cmake@af1be47fd7c9=
33593f687731bc6fdbee024d3ff4 # v10=2E8</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8=
d572297e03a956 # v10=2E9</span><br><span>         with:</span><br><span>   =
        configurePreset: mingw-${{ matrix=2Earch }}</span><br><span>       =
    buildPreset: mingw-${{ matrix=2Earch }}</span><br><span>           buil=
dPresetAdditionalArgs: &quot;[&#39;--config Debug&#39;]&quot;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: act=
ions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - uses: action=
s/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1</sp=
an><br><span>         with:</span><br><span>           name: openvpn-mingw-=
${{ matrix=2Earch }}</span><br><span>           path: |</span><br><span>@@ =
-73,7 +84,7 @@</span><br><span>             ${{ github=2Eworkspace }}/out/b=
uild/mingw/${{ matrix=2Earch }}/**/Debug/*=2Edll</span><br><span>          =
   !${{ github=2Eworkspace }}/out/build/mingw/${{ matrix=2Earch }}/Debug/te=
st_*=2Eexe</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886=
f43607fa02 # v4=2E6=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d=
1fc6a0a # v7=2E0=2E1</span><br><span>         with:</span><br><span>       =
    name: openvpn-mingw-${{ matrix=2Earch }}-tests</span><br><span>        =
   path: |</span><br><span>@@ -88,11 +99,11 @@</span><br><span>         arc=
h: [x86, x64]</span><br><span>         test: [argv, auth_token, buffer, cry=
ptoapi, crypto, misc, ncp, packet_id, pkt, provider, tls_crypt]</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: wi=
ndows-latest</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run=
s-on: windows-2025-vs2026</span><br><span>     name: &quot;mingw unittest $=
{{ matrix=2Etest }} - ${{ matrix=2Earch }} - OSSL&quot;</span><br><span>   =
  steps:</span><br><span>       - name: Retrieve mingw unittest</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/download-ar=
tifact@d3f86a106a0bac45b974a628896c90dbdf5c8093 # v4=2E3=2E0</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/download-art=
ifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8=2E0=2E1</span><br><span=
>         with:</span><br><span>           name: openvpn-mingw-${{ matrix=
=2Earch }}-tests</span><br><span>           path: unittests</span><br><span=
>@@ -131,7 +142,7 @@</span><br><span>       - name: Install dependencies</s=
pan><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y =
liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-li=
bc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${=
SSLPKG} ${PKCS11PKG}</span><br><span>       - name: Checkout OpenVPN</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checko=
ut@11bd71901bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@df4cb1c=
069e1874edd31b4311f1884172cec0e10 # v6=2E0=2E3</span><br><span>       - nam=
e: autoconf</span><br><span>         run: autoreconf -fvi</span><br><span> =
      - name: configure</span><br><span>@@ -158,7 +169,7 @@</span><br><span=
>       - name: Install dependencies</span><br><span>         run: sudo apt=
 update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev =
libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev =
python3-docutils libtool automake autoconf libmbedtls-dev</span><br><span> =
      - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9=
af683 # v4=2E2=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=
=2E0=2E3</span><br><span>       - name: autoconf</span><br><span>         r=
un: autoreconf -fvi</span><br><span>       - name: configure</span><br><spa=
n>@@ -172,9 +183,9 @@</span><br><span>     strategy:</span><br><span>      =
 fail-fast: false</span><br><span>       matrix:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        ssllib: [openssl@1=2E1, openssl@3, libre=
ssl]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ssllib:=
 [openssl@3, libressl]</span><br><span>         build: [normal, asan]</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        os: [macos-13, maco=
s-14, macos-15]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    os: [macos-15, macos-26]</span><br><span>         include:</span><br><s=
pan>           - build: asan</span><br><span>             cflags: &quot;-fs=
anitize=3Daddress,undefined -fno-sanitize-recover=3Dall -fno-optimize-sibli=
ng-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&=
quot;</span><br><span>@@ -196,7 +207,7 @@</span><br><span>       - name: In=
stall dependencies</span><br><span>         run: brew install ${{matrix=2Es=
sllib}} lzo lz4 man2html cmocka libtool automake autoconf</span><br><span> =
      - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9=
af683 # v4=2E2=2E2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6=
=2E0=2E3</span><br><span>       - name: Set environment</span><br><span>   =
      run: |</span><br><span>           cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF=
;</span><br><span>@@ -223,38 +234,52 @@</span><br><span>       name: &quot;=
msbuild - ${{ matrix=2Earch }} - openssl&quot;</span><br><span>       env:<=
/span><br><span>         BUILD_CONFIGURATION: Release</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VCPKG_BINARY_SOURCES: clear;defau=
lt,readwrite</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      runs-on: w=
indows-latest</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
runs-on: windows-2025-vs2026</span><br><span>       steps:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/checkout@11bd719=
01bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      - uses: lukka/get-cmake@6b3e96a9bc9976b8b546=
346fdd102effedae0ca8 # v4=2E0=2E3</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884=
172cec0e10 # v6=2E0=2E3</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e =
# v4=2E3=2E3</span><br><span> </span><br><span>       - name: Install rst2h=
tml</span><br><span>         run: python -m pip install --upgrade pip docut=
ils</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
      - name: Restore artifacts, or setup vcpkg (do not install any package=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: lukka/=
run-vcpkg@5e0cab206a5ea620130caf672fce3e4a6b5666a1 # v11=2E5</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      - name: Setup vcpkg (do not =
install any package)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v=
11=2E6</span><br><span>         with:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c14=
58e6d7abf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
vcpkgGitCommitId: ${{ env=2EVCPKG_GIT_COMMIT_ID }}</span><br><span>        =
   vcpkgJsonGlob: &#39;**/windows/vcpkg=2Ejson&#39;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Set up vcpk=
g binary cache</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E=
5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        with:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+          path: ${{ env=
=2EVCPKG_DEFAULT_BINARY_CACHE }}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+          key: msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-${=
{ hashFiles(&#39;**/windows/vcpkg=2Ejson&#39;) }}-${{ env=2EVCPKG_GIT_COMMI=
T_ID }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          re=
store-keys: |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-${{ hashFiles(&#39;**/wi=
ndows/vcpkg=2Ejson&#39;) }}-</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msvc-${{ matrix=2Earch }}-vcpkg-binary-cache-</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>       - name: Run CMake with =
vcpkg=2Ejson manifest (NO TESTS)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        uses: lukka/run-cmake@af1be47fd7c933593f687731bc6fdbee02=
4d3ff4 # v10=2E8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10=
=2E9</span><br><span>         if: ${{ matrix=2Earch =3D=3D &#39;arm64&#39; =
}}</span><br><span>         with:</span><br><span>           configurePrese=
t: win-${{ matrix=2Earch }}-release</span><br><span>           buildPreset:=
 win-${{ matrix=2Earch }}-release</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+          configurePresetAdditionalArgs: &quot;[&#39;-GVisual=
 Studio 18 2026&#39;]&quot;</span><br><span> </span><br><span>       - name=
: Run CMake with vcpkg=2Ejson manifest</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        uses: lukka/run-cmake@af1be47fd7c933593f687731bc6f=
dbee024d3ff4 # v10=2E8</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 #=
 v10=2E9</span><br><span>         if: ${{ matrix=2Earch !=3D &#39;arm64&#39=
; }}</span><br><span>         with:</span><br><span>           configurePre=
set: win-${{ matrix=2Earch }}-release</span><br><span>           buildPrese=
t: win-${{ matrix=2Earch }}-release</span><br><span>           testPreset: =
win-${{ matrix=2Earch }}-release</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+          configurePresetAdditionalArgs: &quot;[&#39;-GVisual =
Studio 18 2026&#39;]&quot;</span><br><span>           testPresetAdditionalA=
rgs: &quot;[&#39;--output-on-failure&#39;]&quot;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-      - uses: actions/upload-a=
rtifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4=2E6=2E2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-arti=
fact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7=2E0=2E1</span><br><span>=
         with:</span><br><span>           name: openvpn-msvc-${{ matrix=2Ea=
rch }}</span><br><span>           path: |</span><br><span>@@ -294,7 +319,7 =
@@</span><br><span>       - name: Install dependencies</span><br><span>    =
     run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam=
0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docut=
ils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</sp=
an><br><span>       - name: &quot;libressl: checkout&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@11bd719=
01bbe5b1630ceea73d27597364c9af683 # v4=2E2=2E2</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        uses: actions/checkout@de0fac2e4500dabe0=
009e67214ff5f5447ce83dd # v6=2E0=2E2</span><br><span>         with:</span><=
br><span>           path: libressl</span><br><span>           repository: l=
ibressl/portable</span><br><span>@@ -316,7 +341,7 @@</span><br><span>      =
 - name: &quot;ldconfig&quot;</span><br><span>         run: sudo ldconfig</=
span><br><span>       - name: Checkout OpenVPN</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        uses: actions/checkout@11bd71901bbe5b1630c=
eea73d27597364c9af683 # v4=2E2=2E2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5=
f5447ce83dd # v6=2E0=2E2</span><br><span>       - name: autoconf</span><br>=
<span>         run: autoreconf -fvi</span><br><span>       - name: configur=
e</span><br><span>diff --git a/=2Egithub/workflows/coverity-scan=2Eyml b/=
=2Egithub/workflows/coverity-scan=2Eyml</span><br><span>index 1a9e5a3=2E=2E=
105f23e 100644</span><br><span>--- a/=2Egithub/workflows/coverity-scan=2Eym=
l</span><br><span>+++ b/=2Egithub/workflows/coverity-scan=2Eyml</span><br><=
span>@@ -13,7 +13,7 @@</span><br><span>     steps:</span><br><span>       -=
 name: Check submission cache</span><br><span>         id: check_submit</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cac=
he/restore@5a3ec84eff668545956fd18022155c47e93e2684 # v4=2E2=2E3</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache/re=
store@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span><br><span=
>         with:</span><br><span>           path: |</span><br><span>        =
     cov-int</span><br><span>@@ -25,7 +25,7 @@</span><br><span> </span><br>=
<span>       - name: Checkout OpenVPN</span><br><span>         if: steps=2E=
check_submit=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uses: actions/checkout@11bd71901bb=
e5b1630ceea73d27597364c9af683 # v4</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        uses: actions/checkout@df4cb1c069e1874edd31b4311f188=
4172cec0e10 # v6=2E0=2E3</span><br><span> </span><br><span>       - name: D=
ownload Coverity Build Tool</span><br><span>         if: steps=2Echeck_subm=
it=2Eoutputs=2Ecache-hit !=3D &#39;true&#39;</span><br><span>@@ -65,7 +65,7=
 @@</span><br><span> </span><br><span>       - name: Cache submission</span=
><br><span>         if: steps=2Echeck_submit=2Eoutputs=2Ecache-hit !=3D &#3=
9;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        us=
es: actions/cache/save@5a3ec84eff668545956fd18022155c47e93e2684 # v4=2E2=2E=
3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: acti=
ons/cache/save@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5=2E0=2E5</span>=
<br><span>         with:</span><br><span>           path: |</span><br><span=
>             cov-int</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3Demail">change=
 1754</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1754?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1754 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--dr/Hd5NyyKw=--


--===============8659492181702059514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8659492181702059514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8659492181702059514==--

