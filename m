Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D533C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aBi4jVR8cGup7Th8sbglyQhIDdnETDQjWnTrYqGuo3c=; b=Dv9WNd8v/x/PlOHWiRNzpB1L7Q
	iLcz0oUO8PQ16Mn7K4FVyFY78GQl2OqXdNKHl/j/o1PnvlWCI2WHDHS0GmwPjS3KtgYQk3G4Gm+Qi
	ZSBvWrk42F02g+IOLmvIi4Ksze2R5tSw/feBzMkxt+tL+evimQ6uovU5nsrv/Je3cAPM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weGVq-0001uU-Kt;
	Mon, 29 Jun 2026 18:15:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1weGVo-0001uN-Om
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 18:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uIQggEUSV8w5QGVZa/d0kRcb43QaUXbl7VldWIGMYDY=; b=Y/Z+2kvZIoAZi5wvumXLPzm8rF
 dmxyG5NPeQuKQ38PGNu//WCLml2wNLPSr8DIlWdjZYm9d4RBtzp9mGPbkeUjqnJhcB+8ig+nfIxIn
 Icr3UgNQ/O+JkFOH/zdL4NCs8QDvoNsWxvbMXhaFQrEs5n+ElQNxynDxhBOFs7Rl2O5E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uIQggEUSV8w5QGVZa/d0kRcb43QaUXbl7VldWIGMYDY=; b=B3G2Ure2NyPHrCmD36QKNlE3te
 lk7RFxRsAEtPpGG2Wsr3E1KPlZDLQX39y07GKa89bMzGcBdK4UbRZ1N+FmoB4qL//ye8q56BipKY1
 8Tj7df31ic/pGwema35qVdbDGUNlRil7OfFkAPpCSmsCbur4lLsbCFD1w4gGMz7bEBZ0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weGVl-0005cp-MP for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 18:15:17 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65TIF5ki020064
 for <openvpn-devel@lists.sourceforge.net>; Mon, 29 Jun 2026 20:15:05 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65TIF5k8020063
 for openvpn-devel@lists.sourceforge.net; Mon, 29 Jun 2026 20:15:05 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 29 Jun 2026 20:15:00 +0200
Message-ID: <20260629181505.20031-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
References: <gerrit.1782740317000.Icbcf4c79d577d9cf089a92378be9253b1e94825d@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1weGVl-0005cp-MP
Subject: [Openvpn-devel] [PATCH v1] GHA: Cherry-pick changes from master to
 keep working
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

Cherry-pick applicable changes from the following commits:

- GHA: Switch to using VS 2026
(cherry picked from commit 90499e51237cd11f813206371b7ba5176d8eb5ef)
- GHA: Add caching for vcpkg builds
(cherry picked from commit 157087736427059316ecff7dd21e16b54077221a)
- GHA: Maintenance Update April 2026
  - Updates GHA actions
  - Switch uncrustify job to archive: false
  - Drop macos-14 builds
(cherry picked from commit cc2926fd5d09fd501b51520ed5a0b69399db85da)
GHA: Maintenance update June 2026
  - chore(deps): update github actions
  - chore(deps): update vcpkg digest to 75672db
(cherry picked from commit f9e6d5d724851a938a0c064307db513df469eb62)

Further changes:
  - Drop macos-13 builds
  - Add macos-26 builds
  - Drop openssl@1.1 from macOS, not available in all versions anymore

Change-Id: Icbcf4c79d577d9cf089a92378be9253b1e94825d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1754
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1754
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 1abc178..883e2dc 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -13,7 +13,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y uncrustify
       - name: Checkout OpenVPN
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2
+        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
         with:
           path: openvpn
       - name: Show uncrustify version
@@ -27,9 +27,9 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4.6.2
+      - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7.0.1
         with:
-          name: uncrustify-changes.patch
+          archive: false
           path: 'openvpn/uncrustify-changes.patch'
       - name: Set job status
         run: test ! -s uncrustify-changes.patch
@@ -45,27 +45,38 @@
     runs-on: ubuntu-24.04
     env:
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
+      VCPKG_BINARY_SOURCES: clear;default,readwrite
+      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
 
-      - uses: lukka/get-cmake@6b3e96a9bc9976b8b546346fdd102effedae0ca8 # v4.0.3
-      - name: Restore from cache and install vcpkg
-        uses: lukka/run-vcpkg@5e0cab206a5ea620130caf672fce3e4a6b5666a1 # v11.5
+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4.3.3
+      - name: Setup vcpkg
+        uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11.6
         with:
-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
+          vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
+      - name: Set up vcpkg binary cache
+        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5.0.5
+        with:
+          path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}
+          key: mingw-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/mingw/vcpkg.json') }}-${{ env.VCPKG_GIT_COMMIT_ID }}
+          restore-keys: |
+            mingw-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/mingw/vcpkg.json') }}-
+            mingw-${{ matrix.arch }}-vcpkg-binary-cache-
+
       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@af1be47fd7c933593f687731bc6fdbee024d3ff4 # v10.8
+        uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10.9
         with:
           configurePreset: mingw-${{ matrix.arch }}
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"
 
-      - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4.6.2
+      - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7.0.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -73,7 +84,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/Debug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
 
-      - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4.6.2
+      - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7.0.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -88,11 +99,11 @@
         arch: [x86, x64]
         test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, provider, tls_crypt]
 
-    runs-on: windows-latest
+    runs-on: windows-2025-vs2026
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@d3f86a106a0bac45b974a628896c90dbdf5c8093 # v4.3.0
+        uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8.0.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -131,7 +142,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -158,7 +169,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -172,9 +183,9 @@
     strategy:
       fail-fast: false
       matrix:
-        ssllib: [openssl@1.1, openssl@3, libressl]
+        ssllib: [openssl@3, libressl]
         build: [normal, asan]
-        os: [macos-13, macos-14, macos-15]
+        os: [macos-15, macos-26]
         include:
           - build: asan
             cflags: "-fsanitize=address,undefined -fno-sanitize-recover=all -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
@@ -196,7 +207,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -223,38 +234,52 @@
       name: "msbuild - ${{ matrix.arch }} - openssl"
       env:
         BUILD_CONFIGURATION: Release
+        VCPKG_BINARY_SOURCES: clear;default,readwrite
+        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
 
-      runs-on: windows-latest
+      runs-on: windows-2025-vs2026
       steps:
-      - uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2
-      - uses: lukka/get-cmake@6b3e96a9bc9976b8b546346fdd102effedae0ca8 # v4.0.3
+      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4.3.3
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
 
-      - name: Restore artifacts, or setup vcpkg (do not install any package)
-        uses: lukka/run-vcpkg@5e0cab206a5ea620130caf672fce3e4a6b5666a1 # v11.5
+      - name: Setup vcpkg (do not install any package)
+        uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11.6
         with:
-          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
+          vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
+      - name: Set up vcpkg binary cache
+        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5.0.5
+        with:
+          path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}
+          key: msvc-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/windows/vcpkg.json') }}-${{ env.VCPKG_GIT_COMMIT_ID }}
+          restore-keys: |
+            msvc-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/windows/vcpkg.json') }}-
+            msvc-${{ matrix.arch }}-vcpkg-binary-cache-
+
+
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
-        uses: lukka/run-cmake@af1be47fd7c933593f687731bc6fdbee024d3ff4 # v10.8
+        uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10.9
         if: ${{ matrix.arch == 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release
+          configurePresetAdditionalArgs: "['-GVisual Studio 18 2026']"
 
       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@af1be47fd7c933593f687731bc6fdbee024d3ff4 # v10.8
+        uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10.9
         if: ${{ matrix.arch != 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release
           testPreset: win-${{ matrix.arch }}-release
+          configurePresetAdditionalArgs: "['-GVisual Studio 18 2026']"
           testPresetAdditionalArgs: "['--output-on-failure']"
 
-      - uses: actions/upload-artifact@ea165f8d65b6e75b540449e92b4886f43607fa02 # v4.6.2
+      - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7.0.1
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -294,7 +319,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2
+        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
         with:
           path: libressl
           repository: libressl/portable
@@ -316,7 +341,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2
+        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index 1a9e5a3..105f23e 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@5a3ec84eff668545956fd18022155c47e93e2684 # v4.2.3
+        uses: actions/cache/restore@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5.0.5
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
 
       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit != 'true'
@@ -65,7 +65,7 @@
 
       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/cache/save@5a3ec84eff668545956fd18022155c47e93e2684 # v4.2.3
+        uses: actions/cache/save@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5.0.5
         with:
           path: |
             cov-int


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
