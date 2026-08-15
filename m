Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D1DC5DF6A
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KPul2o0NYK1LimmI3A8CSokLGcKXeqGxqqHPGXTOric=; b=Eq2x5sxRSz5jDB28o/FewQTMJp
	mAZc8sH3H3uMb2EANJXpWQ+PhvFOs/emh4hKugeFhLDFdxaNX7i7K3VdY9rKsGQnKDHf1VBUvnAQG
	ftPuCB74ZTP8axFK+pcMsRld0JG5P+D/uOjepwChp6Z8nMlJCUMGiPY0QF8FRVWBqLcc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvE01-00013S-MF;
	Sat, 15 Aug 2026 13:00:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wvDzo-00013E-Hr
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 13:00:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x7zFzGEqlmUrlPAtrW9uTRD0N4xsJt8p+K8ZJlfbXFc=; b=TE3rh2oMa6+I0CmieMgoMiKc3a
 wVaJ0JgenncBEz+ijvKw6TIXw/PSDEaZci53Yi2oKWf+gUsQ/iQiD5K55C4nrVo8Izyl9eQHDINIA
 227ARZpT1RnaiLBji/NccOU83J8LVk79R/gvfh8k8eEImwKlpvYid9ZybNTK3dXvctQY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x7zFzGEqlmUrlPAtrW9uTRD0N4xsJt8p+K8ZJlfbXFc=; b=KVanPDqlCvmXgffd4/ejIuYQaM
 9EmvfhW92c4fpz95aXJzbiv/5Bv+HTrwGFX5+1UzEsv2gT3V5HChbERlhOpOp9fLFlQZ21xqMlP0J
 5ZhjO8s93JKlBH1uuzYFdZ2g4JCF829SjeSWWAX+dIviqTJcuJfAyA6R4CFIMRjnOMtU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvDzp-0008GL-54 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 13:00:21 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67FD09UR019759
 for <openvpn-devel@lists.sourceforge.net>; Sat, 15 Aug 2026 15:00:09 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67FD091F019758
 for openvpn-devel@lists.sourceforge.net; Sat, 15 Aug 2026 15:00:09 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 15 Aug 2026 14:59:38 +0200
Message-ID: <20260815130008.19708-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782744874000.I08281cb511dacb2a69ff4a9607c5daf09157337b@gerrit.openvpn.net>
References: <gerrit.1782744874000.I08281cb511dacb2a69ff4a9607c5daf09157337b@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wvDzp-0008GL-54
Subject: [Openvpn-devel] [PATCH v1] Fix compiling with mbed TLS 3 and cmake
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

From: Arne Schwabe <arne@rfc2549.org>

The crypto_mbedtls_legacy.c has been added to the Makefile.am files
but was forgotten in the Cmake build system.

Change-Id: I08281cb511dacb2a69ff4a9607c5daf09157337b
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1757
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1757
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 4779d69..3f38ab9 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -443,6 +443,8 @@
     src/openvpn/crypto_openssl.h
     src/openvpn/crypto_mbedtls.c
     src/openvpn/crypto_mbedtls.h
+    src/openvpn/crypto_mbedtls_legacy.c
+    src/openvpn/crypto_mbedtls_legacy.h
     src/openvpn/cryptoapi.c
     src/openvpn/cryptoapi.h
     src/openvpn/dco.c
@@ -761,6 +763,7 @@
         src/openvpn/base64.c
         src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
+        src/openvpn/crypto_mbedtls_legacy.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
         src/openvpn/otime.c
@@ -773,6 +776,7 @@
 
     target_sources(test_crypto PRIVATE
         src/openvpn/crypto_mbedtls.c
+        src/openvpn/crypto_mbedtls_legacy.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto_epoch.c
         src/openvpn/crypto.c
@@ -790,6 +794,7 @@
             src/openvpn/base64.c
             src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
+            src/openvpn/crypto_mbedtls_legacy.c
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
             src/openvpn/cryptoapi.c
@@ -825,6 +830,7 @@
     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
+        src/openvpn/crypto_mbedtls_legacy.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
         src/openvpn/otime.c
@@ -853,6 +859,7 @@
         src/openvpn/base64.c
         src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
+        src/openvpn/crypto_mbedtls_legacy.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
         src/openvpn/env_set.c
@@ -927,6 +934,7 @@
             src/openvpn/networking_sitnl.c
             src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
+            src/openvpn/crypto_mbedtls_legacy.c
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
             src/openvpn/crypto_epoch.c
@@ -948,6 +956,7 @@
             src/openvpn/base64.c
             src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
+            src/openvpn/crypto_mbedtls_legacy.c
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
             src/openvpn/env_set.c


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
