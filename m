Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199B3C43458
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pKLuTtEWzMPAwtckPm+Cy0OzoXPmCPaxI7XYvfBgJag=; b=XBeWlUwxYSK/dSQtnr1AcUMXyE
	KsqXUUIyH4ftdLfmLSv9hPeUiZy7SAwTBXqRd0UpmKERRq+lzWK0qfn6exg6QSq8hNFvQXR5hdkgY
	SdV41kf3ofutT7TI6OcfQ39CrxhNlo0hvfXyFE6+8rMEHJiZbuLFcB8KMU2uWbX7bcVA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdr2j-0002Tw-3V;
	Sun, 28 Jun 2026 15:03:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wdr2i-0002Tp-BU
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 15:03:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gYpL7gylVKE/3eRwKAiBpll7TNeuoPIsn/dgwR8kxoA=; b=VlinJxSAKSIosWqLV5WETWwqIt
 ES3gykAil6PVfTUdu5zKksAyQvTgoLwtDXFExMWtJn/C3mzbqe/tY8R79b9K1JgJFnmyOQ+XZ7A2D
 KU8ZIesPp0JDqFXNSBPSUeVhmslMad+4Ccqw4/Nc6MOHR0kujG//CVLptoLtII31wr1I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gYpL7gylVKE/3eRwKAiBpll7TNeuoPIsn/dgwR8kxoA=; b=BD/zl2PxGOcj3yELfZWyAWycSp
 tJHYRycOh2ZtjJajQwIoDJ0urirCGjqE6IRtN7eiyUD55RHOLyto/GIsD0ssKoUNE665QNBT12Fgl
 M9ntQ/TFnz3tXaTIwtHGlbGU5GDro/Kea6V6wAIXEAaX5kxZdhtATpJbBDdcrbEdteLg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wdr2h-0006w2-KV for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 15:03:32 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65SF3KlB013267
 for <openvpn-devel@lists.sourceforge.net>; Sun, 28 Jun 2026 17:03:20 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65SF3KVD013266
 for openvpn-devel@lists.sourceforge.net; Sun, 28 Jun 2026 17:03:20 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 28 Jun 2026 17:03:15 +0200
Message-ID: <20260628150320.13244-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
References: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wdr2h-0006w2-KV
Subject: [Openvpn-devel] [PATCH v6] Fix building wolfSSL with CMake
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

Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1604
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1604
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 715d02c..4779d69 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -327,6 +327,7 @@
     elseif (${WOLFSSL})
         pkg_search_module(wolfssl wolfssl REQUIRED)
         target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})
+        target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS})
         target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS}/wolfssl)
     else ()
         find_package(OpenSSL REQUIRED)
@@ -367,6 +368,7 @@
 elseif (${WOLFSSL})
     set(ENABLE_CRYPTO_OPENSSL YES)
     set(ENABLE_CRYPTO_WOLFSSL YES)
+    set(EXTERNAL_OPTS_OPENVPN YES)
 else ()
     set(ENABLE_CRYPTO_OPENSSL YES)
 endif ()
diff --git a/config.h.cmake.in b/config.h.cmake.in
index ae1d264..34f289d 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -13,6 +13,7 @@
 
 /* Use wolfSSL crypto library */
 #cmakedefine ENABLE_CRYPTO_WOLFSSL
+#cmakedefine EXTERNAL_OPTS_OPENVPN
 
 /* Enable shared data channel offload */
 #cmakedefine ENABLE_DCO


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
