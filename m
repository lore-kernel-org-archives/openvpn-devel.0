Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C6606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G72fAQHK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LmmbEnrS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ipj3XUWa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LUBrRov8Ma9FdmkJ0uAiHSUoupn2JTwI+HDVDXl8eY4=; b=G72fAQHKFT9fFH
	/5kcW+GzzlibsN1ZyxjSU5ELDIJPPljWVHIlLmz7G6jucbQr/MmU42t7ZuOal3ua8HeSeGhEFFOWM
	p1GeYi8p3Ochty9U6+iOTzL0kjKAxwMMuWIO2yFmfooS4OhjqWM7Wn97Bp8eUA+NNJw+l066smWdH
	fkg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSy8K-000000002Ym-2xDO;
	Mon, 16 Nov 2026 14:56:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSy89-000000002Ya-1f1j for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:56:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y0WuJBF1ELcAHbyjNh1aNa276VChsMlwU2h0mDPDTvQ=; b=LmmbEnrSqEjjuuHUs6hf23Og7A
 NLkNrBtoddbokioQjrL3/t45oTvUy/aVf/emzS4XzoMxi7cBscwgKldrFR+atnrvGAKcSKPSIFdbc
 pya37c5/UuBGuG+gh/hEd09zBscoMfgM4KBOQfcQasZgdDYP2fHXFYqhpTPs4MB/KzPE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y0WuJBF1ELcAHbyjNh1aNa276VChsMlwU2h0mDPDTvQ=; b=ipj3XUWatMVJyYt09tnFqsUaj/
 Hbzg4mpvpvft8yEf1q0d3W61wtWBh8UNIaMNR6Q7WUEaA4dhDfYC5kqwQtg6WpjnBdMQZ75chPZxJ
 fb8AMmCRmdcOkq9aIOcx3W/sAQHToAJ4uORfZ4bFARnqBa+WoNdBCU+wPz5jd0kHDX4k=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSy87-00000000188-2sur for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:56:25 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AGEuGwQ008126
 for <openvpn-devel@lists.sourceforge.net>; Mon, 16 Nov 2026 15:56:16 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGEuGIL008125
 for openvpn-devel@lists.sourceforge.net; Mon, 16 Nov 2026 15:56:16 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 16 Nov 2026 15:56:10 +0100
Message-ID: <20261116145616.8110-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794832910000.Ib2849dc2c0a451b26fad985faf757ff22a852e91@gerrit.openvpn.net>
References: <gerrit.1794832910000.Ib2849dc2c0a451b26fad985faf757ff22a852e91@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSy87-00000000188-2sur
Subject: [Openvpn-devel] [PATCH v2] GHA: Use latest NDK
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Lichtenheld <frank@lichtenheld.com>

Stay in sync with what buildbot uses. The images still use
NDK r27 which is quite old by now.

While here, update vcpkg reference to latest master.

Change-Id: Ib2849dc2c0a451b26fad985faf757ff22a852e91
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2194
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2194
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d50b7ff..19c78e9 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -36,14 +36,12 @@
             vcpkg_triplet: arm64-android
     runs-on: ubuntu-26.04
     name: "Android - ${{ matrix.abi }}"
-    # Github images already setup NDK with ANDROID_NDK_ROOT pointing to the root
-    # of the SDK
     env:
       VCPKG_DEFAULT_TRIPLET: ${{ matrix.vcpkg_triplet }}
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
       VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
+      VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
@@ -59,6 +57,10 @@
           key: android-${{ matrix.abi }}-vcpkg-binary-cache-${{ env.VCPKG_GIT_COMMIT_ID }}
           restore-keys: |
             android-${{ matrix.abi }}-vcpkg-binary-cache-
+      - name: Configure NDK version
+        run: |
+          echo "ANDROID_NDK_HOME=$ANDROID_NDK_LATEST_HOME" >>$GITHUB_ENV
+          echo "ANDROID_NDK_ROOT=$ANDROID_NDK_LATEST_HOME" >>$GITHUB_ENV
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -90,7 +92,7 @@
     env:
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
       VCPKG_BINARY_SOURCES: clear;default,readwrite
-      VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
+      VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-essential wget python3-docutils man2html-base
@@ -290,7 +292,7 @@
       env:
         BUILD_CONFIGURATION: Release
         VCPKG_BINARY_SOURCES: clear;default,readwrite
-        VCPKG_GIT_COMMIT_ID: 5f96cd15fd745122cf27e0524606d6c1efc5fd07
+        VCPKG_GIT_COMMIT_ID: 8f363bdc11359ede4bc51e5eb32a2617538049c8
 
       runs-on: windows-2025-vs2026
       steps:


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
