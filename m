Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08FACD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6I6UzPUgghTBTq2Yc5dzWWf+xQPh0Z7DJGRBY0eihA0=; b=S0ttE4PjtvwgsCn5sOrvMLk2mq
	d2DT8yK1aJDeKnKqqCnzjn30/L+5o+eK5b8uImvmAlu2euTm+yLyvAbCpPMPxcaKfaBxNvPbT3JhB
	R8qvMpu3aRrFddN2X6QXHQKo2XntzpLXnssqgGx1H/KT20Dl7vXyR6srIFYUtYYgRxLo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWyGU-0005cc-98;
	Tue, 09 Jun 2026 15:21:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWyGS-0005cW-IV
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:21:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5YC33SKCVx0oniyxIPVhypDPJxuI93K4fZXDkSlqbNQ=; b=c9DmUUkkHoLOQ8jYpno7EbzEZj
 jeyMDVDT5RRnJHbABColOOvDMPvjI5WJSIMrfPtUQ36ImfkPgrGFgtLHQgDOCNiuK2B7DDz9tnAXW
 a5brxdHxyhLKwTq8mxnPXxoxdpjZ14JyCRr5RZH6Gz+J3wuq/L/UeKZQp8OmQUeNcavo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5YC33SKCVx0oniyxIPVhypDPJxuI93K4fZXDkSlqbNQ=; b=FDl3PnUtjw2p4pn6jfl1huZjz/
 d9RDdYzWJvqVQtH4qkYZ8XfnL3u6/A0H/3RGSLnxqsBhU6AttCPRG2OEq7rRANRftc47v/NWEQHdx
 ccsmAYLROX+wy0ITPUcB1EJXLthwbVQBx+1NT+wrzRa+8ev0mKlPNEbrdRMoTBYTcfSE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWyGQ-0003gc-Sq for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:21:17 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 659FL3J0027432
 for <openvpn-devel@lists.sourceforge.net>; Tue, 9 Jun 2026 17:21:03 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 659FL33s027431
 for openvpn-devel@lists.sourceforge.net; Tue, 9 Jun 2026 17:21:03 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  9 Jun 2026 17:20:57 +0200
Message-ID: <20260609152103.27418-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1781017122000.I11fc104878ba244c5be04ce8019695b6892c4457@gerrit.openvpn.net>
References: <gerrit.1781017122000.I11fc104878ba244c5be04ce8019695b6892c4457@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWyGQ-0003gc-Sq
Subject: [Openvpn-devel] [PATCH v1] GHA: Maintenance update June 2026
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
- chore(deps): update github actions
- chore(deps): update vcpkg digest to 75672db
- chore(deps): update dependency aws/aws-lc to v5
- chore(deps): update dependency libressl/portable to v4.3.2

Change-Id: I11fc104878ba244c5be04ce8019695b6892c4457
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1710
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1710
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b530fcc..323645a 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -14,7 +14,7 @@
           sudo apt update && sudo apt install -y python3-pip
           pip3 install pre-commit
       - name: Checkout OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
       - name: Run clang-format
         run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
@@ -43,11 +43,11 @@
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
       VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7
+      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
-      - uses: lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4.3.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4.3.3
       - name: Setup vcpkg
         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11.6
         with:
@@ -84,14 +84,14 @@
     env:
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
       VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7
+      VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
 
-      - uses: lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4.3.2
+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4.3.3
       - name: Setup vcpkg
         uses: lukka/run-vcpkg@b1a0dd252f06b9e25b3c022a9a03bd7a427fb6a2 # v11.6
         with:
@@ -142,7 +142,7 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - ${{ matrix.build }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
       - name: Retrieve mingw unittest
         uses: actions/download-artifact@3e5f45b2cfb9172054b4087a40e8e0b5a5461e7c # v8.0.1
         with:
@@ -183,7 +183,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -213,7 +213,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -253,7 +253,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -283,12 +283,12 @@
       env:
         BUILD_CONFIGURATION: Release
         VCPKG_BINARY_SOURCES: clear;default,readwrite
-        VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7
+        VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
 
       runs-on: windows-2025
       steps:
-      - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
-      - uses: lukka/get-cmake@7bfc9baacbbdcb5e37957ad05c3546b3e222be3c # v4.3.2
+      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
+      - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4.3.3
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -342,7 +342,7 @@
       ovpnlibdesc: LibreSSL
       # versioning=semver-coerced
       ghrepo: libressl/portable
-      gitref: v4.2.1
+      gitref: v4.3.2
       libconfigure: "LIBRESSL_GIT_OPTIONS=--no-single-branch ./autogen.sh && ./configure --prefix=$LIBPREFIX"
 
   openssl4:
@@ -376,7 +376,7 @@
       ovpnlibdesc: AWS-LC
       # versioning=semver-coerced
       ghrepo: aws/aws-lc
-      gitref: v1.70.0
+      gitref: v5.0.0
       libconfigure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$LIBPREFIX" -DBUILD_SHARED_LIBS=1
       libmake: cmake --build build
       libinstall: sudo cmake --install build
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index 1eec1ed..105f23e 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
 
       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit != 'true'
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index 30988b5..3755b92 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -11,7 +11,7 @@
     runs-on: ubuntu-24.04
     if: ${{ github.repository_owner == 'openvpn' || github.event_name == 'workflow_dispatch' }}
     steps:
-      - uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
+      - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
         with:
           path: openvpn
 
diff --git a/.github/workflows/test-ssllib.yml b/.github/workflows/test-ssllib.yml
index c6a2e44..d8178a7 100644
--- a/.github/workflows/test-ssllib.yml
+++ b/.github/workflows/test-ssllib.yml
@@ -77,7 +77,7 @@
           key: ${{matrix.os}}-${{inputs.libname}}-${{matrix.build }}-${{inputs.gitref}}
       - name: "${{inputs.libname}}: checkout"
         if: steps.ssllib-cache.outputs.cache-hit != 'true'
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
         with:
           submodules: recursive
           path: ${{inputs.libname}}
@@ -98,7 +98,7 @@
       - name: Run ldconfig
         run: sudo ldconfig
       - name: "OpenVPN: checkout"
-        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
+        uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
       - name: "OpenVPN: autoreconf"
         run: autoreconf -fvi
       - name: "OpenVPN: configure"


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
