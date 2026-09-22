Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39889C982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oUKOh1J7Zr+vv6ylaV2FddfuM5f6yLyUj6G0jC/+gMk=; b=HK2W3CbqiA4S4ErG1ke2IWQdRS
	kJmkfLKXjs9ZPQMO0f8cYbkrE0lkN2Ue7XO5k4fUwl+WWTdJdpcT2v11+1GO+Hp/VXRZgjDIlOOXa
	cP4eYOdYvzkeqHrFPeEGuXMJ4VUh3fa62tQvOm4FEOJfIM169kZhuoSU2l2vACxz5tTI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8zEq-0008I0-27;
	Tue, 22 Sep 2026 12:04:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x8zEo-0008Ht-5i
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eV0e/rKeDrrcIvI2t2XzkfIsRIy5HEFjJQmt/FuYN5o=; b=dSnYbfpUJdrlVanYE6rYpjlVxE
 4565C6Bb3/2psajNf1SdqQhfrcbq5A8Adg1CNpm2UcG7rbyOHW0UI2ZilqVlrfjlbCwwCqopg8ByM
 whdIvdBbTNclqxnNKKjQwqUqkDjosyH5LUWDzUaEpBEr+Du89I5d2zzsO0Skhx96oYr0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eV0e/rKeDrrcIvI2t2XzkfIsRIy5HEFjJQmt/FuYN5o=; b=kaSqzIQnEbkbZ0DZ/Z/vSi3bp2
 ElRsDUkrWYQQpt7Rhoci9Q2z3htA0efW5MSbi8t8rutZLwJSzDmbgaZsNFkOKLBiTjh2Zw6Vc+0Tf
 UvJ+DvPRJUgsrUIDMnoXaK7wBMnb4Gh3BUQ1Yq7LNu+gSxD11FmVYgFLAB2b+KDmzf9c=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8zEm-0002cM-Od for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:04:42 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68MC4XTY029316
 for <openvpn-devel@lists.sourceforge.net>; Tue, 22 Sep 2026 14:04:33 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68MC4XYt029315
 for openvpn-devel@lists.sourceforge.net; Tue, 22 Sep 2026 14:04:33 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 22 Sep 2026 14:04:27 +0200
Message-ID: <20260922120433.29303-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
References: <gerrit.1790006381000.I983d67e1c90bea460f531f11d4c58d33a351d81b@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x8zEm-0002cM-Od
Subject: [Openvpn-devel] [PATCH v3] GHA: Maintenance update September 2026
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

Contains the following renovate updates:
- chore(deps): update vcpkg digest to 5f96cd1
- Update dependency ubuntu to v26
- chore(deps): update dependency aws/aws-lc to v5.9.0
- chore(deps): update github actions
- Update github actions (major)

Change-Id: I983d67e1c90bea460f531f11d4c58d33a351d81b
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1922
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1922
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d67c215..27f08df 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -7,14 +7,14 @@
 jobs:
   clang-format:
     name: Check code style with clang-format
-    runs-on: ubuntu-24.04
+    runs-on: ubuntu-26.04
     steps:
       - name: Install dependencies
         run: |
           sudo apt update && sudo apt install -y python3-pip
           pip3 install pre-commit
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
       - name: Run clang-format
         run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
@@ -34,7 +34,7 @@
         include:
           - abi: arm64-v8a
             vcpkg_triplet: arm64-android
-    runs-on: ubuntu-24.04
+    runs-on: ubuntu-26.04
     name: "Android - ${{ matrix.abi }}"
     # Github images already setup NDK with ANDROID_NDK_ROOT pointing to the root
     # of the SDK
@@ -43,17 +43,17 @@
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
       VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
+      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4.3.3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4.4.2
       - name: Setup vcpkg
         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11.6
         with:
           vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}
       - name: Set up vcpkg binary cache
-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5.0.5
+        uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6.1.0
         with:
           path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}
           key: android-${{ matrix.abi }}-vcpkg-binary-cache-${{ env.VCPKG_GIT_COMMIT_ID }}
@@ -82,18 +82,18 @@
         build: [Release, Debug]
 
     name: "gcc-mingw - ${{ matrix.arch }} - ${{ matrix.build }} - OSSL"
-    runs-on: ubuntu-24.04
+    runs-on: ubuntu-26.04
     env:
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
       VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
+      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
 
-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4.3.3
+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4.4.2
       - name: Setup vcpkg
         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11.6
         with:
@@ -101,7 +101,7 @@
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Set up vcpkg binary cache
-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5.0.5
+        uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6.1.0
         with:
           path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}
           key: mingw-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/mingw/vcpkg.json') }}-${{ env.VCPKG_GIT_COMMIT_ID }}
@@ -144,7 +144,7 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - ${{ matrix.build }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
       - name: Retrieve mingw unittest
         uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8.0.1
         with:
@@ -185,7 +185,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -215,7 +215,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -255,7 +255,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -285,12 +285,12 @@
       env:
         BUILD_CONFIGURATION: Release
         VCPKG_BINARY_SOURCES: clear;default,readwrite
-        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
+        VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
 
       runs-on: windows-2025-vs2026
       steps:
-      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
-      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4.3.3
+      - uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
+      - uses: lukka/get-cmake@fffaaafeea488556c2c12dad60690008bc1caacb # v4.4.2
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -302,7 +302,7 @@
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Set up vcpkg binary cache
-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5.0.5
+        uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6.1.0
         with:
           path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}
           key: msvc-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/windows/vcpkg.json') }}-${{ env.VCPKG_GIT_COMMIT_ID }}
@@ -380,7 +380,7 @@
       ovpnlibdesc: AWS-LC
       # versioning=semver-coerced
       ghrepo: aws/aws-lc
-      gitref: v5.0.0
+      gitref: v5.9.0
       libconfigure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$LIBPREFIX" -DBUILD_SHARED_LIBS=1
       libmake: cmake --build build
-      libinstall: sudo cmake --install build
\ No newline at end of file
+      libinstall: sudo cmake --install build
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index 105f23e..e103aec 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -9,11 +9,11 @@
     # Running coverity requires the secrets.COVERITY_SCAN_TOKEN token
     # which is only available on the main repository
     if: github.repository_owner == 'OpenVPN'
-    runs-on: ubuntu-24.04
+    runs-on: ubuntu-26.04
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5.0.5
+        uses: actions/cache/restore@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6.1.0
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
 
       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit != 'true'
@@ -65,7 +65,7 @@
 
       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/cache/save@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5.0.5
+        uses: actions/cache/save@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6.1.0
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index 3755b92..784f81e 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -8,10 +8,10 @@
   cancel-in-progress: false
 jobs:
   build:
-    runs-on: ubuntu-24.04
+    runs-on: ubuntu-26.04
     if: ${{ github.repository_owner == 'openvpn' || github.event_name == 'workflow_dispatch' }}
     steps:
-      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+      - uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
         with:
           path: openvpn
 
@@ -35,7 +35,7 @@
           touch doc/doxygen/html/.nojekyll
       - name: Upload static files as artifact
         id: deployment
-        uses: actions/upload-pages-artifact@fc324d3547104276b827a68afc52ff2a11cc49c9 # v5
+        uses: actions/upload-pages-artifact@fc324d3547104276b827a68afc52ff2a11cc49c9 # v5.0.0
         with:
           path: doxygen/doc/doxygen/html/
 
@@ -47,8 +47,8 @@
     environment:
       name: github-pages
       url: ${{ steps.deployment.outputs.page_url }}
-    runs-on: ubuntu-24.04
+    runs-on: ubuntu-26.04
     steps:
       - name: Deploy to GitHub Pages
         id: deployment
-        uses: actions/deploy-pages@cd2ce8fcbc39b97be8ca5fce6e763baed58fa128 # v5
+        uses: actions/deploy-pages@368f82528645a54fb793d4d04e342629a3f51346 # v5.0.1
diff --git a/.github/workflows/test-ssllib.yml b/.github/workflows/test-ssllib.yml
index d8178a7..64607cf 100644
--- a/.github/workflows/test-ssllib.yml
+++ b/.github/workflows/test-ssllib.yml
@@ -70,14 +70,14 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: Restore ${{inputs.libname}} from cache
-        uses: actions/cache@27d5ce7f107fe9357f9df03efb73ab90386fccae # v5.0.5
+        uses: actions/cache@55cc8345863c7cc4c66a329aec7e433d2d1c52a9 # v6.1.0
         id: ssllib-cache
         with:
           path: ${{env.LIBPREFIX}}
           key: ${{matrix.os}}-${{inputs.libname}}-${{matrix.build }}-${{inputs.gitref}}
       - name: "${{inputs.libname}}: checkout"
         if: steps.ssllib-cache.outputs.cache-hit != 'true'
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
         with:
           submodules: recursive
           path: ${{inputs.libname}}
@@ -98,7 +98,7 @@
       - name: Run ldconfig
         run: sudo ldconfig
       - name: "OpenVPN: checkout"
-        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+        uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
       - name: "OpenVPN: autoreconf"
         run: autoreconf -fvi
       - name: "OpenVPN: configure"


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
