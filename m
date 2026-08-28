Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BC8C61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zprAGpHSA0QDbu2HMdcgUKyO/LAzQiMD5bN/MAK+wxY=; b=krjaQHnXg9iB4QH3KKZidd0OJF
	i3j+ZqI4ITVRVzxoGTjRnK9d2kHxDP+Xl/WAJGKVYYtf+noeqHK6fJc1b2fQpuHCVLUplnhOf4AZM
	57kieSGuG581xpUtdpOmPLr1ol2t58tPC01TWqXYpSki8XX6qRCWenmumR2AZTKUyeJM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x031e-0006Lb-6U;
	Fri, 28 Aug 2026 20:18:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x031c-0006LS-Ob
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 20:18:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=teqr5lNlbjVaUjNWk+FXzKVk0sobbSbRToJ5c76Q2xo=; b=dU0znS9tGsQJ5/qF6GPioNz11T
 su2FCVFcFfiBhQdhSN1pavEGeQC4tMUn14b5gc0GtoxakEWM1NLBZ6B+pyBZRfKMPDBgoZJpzgEYA
 RvAyzpieS2L1WWLJ8PtW6cZfhmhq420edWK8tTiYh43nPmoZaL+24PQamd4YvM61y3xE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=teqr5lNlbjVaUjNWk+FXzKVk0sobbSbRToJ5c76Q2xo=; b=Y+2nm1Cv4d8VXvN7Te+hdBm64R
 qstJ2QVtjcYvqciSQKEfVNlF47L1aWk3oISWh3W6Q6Z9fn96Qs8SCWAaxHKDyYfOVcN2ff1wBjxxM
 2KNMlxL6Y7r/ykt8E3rkn/FRNnGrFMb8iKjPi6AA2TB+w6eZ6moodzT7vSvqCQZAc9fo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x031Y-00052i-Rw for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 20:18:06 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67SKHvFW000764
 for <openvpn-devel@lists.sourceforge.net>; Fri, 28 Aug 2026 22:17:57 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67SKHvSL000763
 for openvpn-devel@lists.sourceforge.net; Fri, 28 Aug 2026 22:17:57 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 22:17:50 +0200
Message-ID: <20260828201757.744-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
References: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x031Y-00052i-Rw
Subject: [Openvpn-devel] [PATCH v2] mbedtls: Work-around bug in mbedtls
 4.1.0 and 4.2.0
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

Since the first distros have started to pick up these
versions before a fix is released, let's make our tests
pass on these versions.

A fix is merged, so it might be fixed in 4.3.0. But I
didn't want to add that to the version check until we
have verified that.

Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1849
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1849
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 29e8be2a..56dd3ed 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -365,7 +365,7 @@
       ovpnlibdesc: mbed TLS 4.
       # versioning=semver-coerced
       ghrepo: Mbed-TLS/mbedtls
-      gitref: v4.0.0
+      gitref: v4.2.0
       libconfigure: cmake -B build -DCMAKE_INSTALL_PREFIX=$LIBPREFIX
       libmake: cmake --build build
       libinstall: sudo cmake --install build
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 50739b6..ec45a0f 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -43,6 +43,7 @@
 #include "crypto_mbedtls_legacy.h"
 #else
 #include <mbedtls/oid.h>
+#include "crypto_mbedtls.h"
 #endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 
 #ifdef HAVE_PSA_CRYPTO_H
@@ -228,6 +229,18 @@
 mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_pk_context *prv)
 {
 #if MBEDTLS_VERSION_NUMBER >= 0x04000000
+    /* work around bug in mbedtls 4.1.0 by adding missing public key information in prv
+     * cf. https://github.com/Mbed-TLS/TF-PSA-Crypto/issues/807 */
+#if MBEDTLS_VERSION_NUMBER >= 0x04010000
+    if (prv->MBEDTLS_PRIVATE(pub_raw_len) == 0)
+    {
+        mbedtls_pk_context *mut_prv = (mbedtls_pk_context *)prv; /* remove const */
+        ASSERT(mbed_ok(psa_export_public_key(mut_prv->MBEDTLS_PRIVATE(priv_id),
+                                             mut_prv->MBEDTLS_PRIVATE(pub_raw),
+                                             sizeof(mut_prv->MBEDTLS_PRIVATE(pub_raw)),
+                                             &mut_prv->MBEDTLS_PRIVATE(pub_raw_len))));
+    }
+#endif
     return mbedtls_pk_check_pair(pub, prv);
 #else
     return mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_random, rand_ctx_get());


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
