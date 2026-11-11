Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B3D606A334
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WZ0ERWxj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Q9V/y5/G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LHjp45zn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gxayzIQzgMvhlZqnOvI60imfyYEHTs3MRordRb9+tFE=; b=WZ0ERWxjAk6unE
	HBQx023/BvpUnvHb9EvKIbIpCtkucQbqJGN4O/l3jB7StHHp9SrK3kKSwzZ91Uhe3ht8GcHjJR8qH
	FeyMTxGPnI75SoMTQMwUYz/sVBbz7TUHMyEGGEjVI7V8saWpove15T4ruhBVYvYvQDjetIsFiiO9P
	IVs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRBMp-000000003iU-3xqG;
	Wed, 11 Nov 2026 16:40:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRBMT-000000003gC-14GD for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 16:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VwIRcvuLKORY6VN/5Q9Rqr+KGAxw/a6yDdL0kUY4DIg=; b=Q9V/y5/GSves+MGtrCyLuKyELp
 tsgwcxkxqjJephKdpGd4LZIDr3Pt5UX9LB7DgSDO11BC5XucnISQeXlqMaVSdl8qkds4JUM+WZaCs
 TSOSzsFQx43+Y8+OcqcCw9J2grxOvAaZa35tgetUu5MmzxqKNjbnn1t7BsNIsKOnB5EM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VwIRcvuLKORY6VN/5Q9Rqr+KGAxw/a6yDdL0kUY4DIg=; b=LHjp45znMGniPyBLg0Rjd7em+v
 IKZylNnbSpLtuE/l1JUdA31WG/ZaVCFV/GFiJOsmiwCBf268lhRXkdVNiLxKONauzxtdnxV7gnN4u
 ZFl4/V/Sy4t/5lp1b072/klOVLbwUXRaZq1jKFQNYU1F4e6RL9pStsQ9Ag8+lfK2c75I=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRBMM-0000000059Y-2xTA for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 16:39:44 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ABGdZld006625
 for <openvpn-devel@lists.sourceforge.net>; Wed, 11 Nov 2026 17:39:35 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ABGdZAD006624
 for openvpn-devel@lists.sourceforge.net; Wed, 11 Nov 2026 17:39:35 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 11 Nov 2026 17:39:30 +0100
Message-ID: <20261111163935.6604-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794316034000.I2490a0780a6e7c98a270e97b415b0387093d37be@gerrit.openvpn.net>
References: <gerrit.1794316034000.I2490a0780a6e7c98a270e97b415b0387093d37be@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRBMM-0000000059Y-2xTA
Subject: [Openvpn-devel] [PATCH v2] httpdigest: replace IN/OUT macros with
 plain const
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

From: Steffan Karger <steffan@karger.me>

httpdigest.h defines IN as const, and never undefines it. This leaks
into the pkcs11-helper headers that proxy.c includes later on, which
use IN/OUT as empty annotations and only define them if not defined
yet. That changes the pkcs11-helper declarations proxy.c sees ('IN
void * const' becomes 'const void * const'), and makes clang spit out
over a hundred -Wduplicate-decl-specifier warnings.

Just use const where we used IN, and drop OUT. No functional change.

Change-Id: I2490a0780a6e7c98a270e97b415b0387093d37be
Signed-off-by: Steffan Karger <steffan@karger.me>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2166
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2166
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 52df383..9bfa074 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -32,7 +32,7 @@
 #include "httpdigest.h"
 
 static void
-CvtHex(IN HASH Bin, OUT HASHHEX Hex)
+CvtHex(const HASH Bin, HASHHEX Hex)
 {
     for (unsigned short i = 0; i < HASHLEN; i++)
     {
@@ -60,8 +60,8 @@
 
 /* calculate H(A1) as per spec */
 void
-DigestCalcHA1(IN char *pszAlg, IN char *pszUserName, IN char *pszRealm, IN char *pszPassword,
-              IN char *pszNonce, IN char *pszCNonce, OUT HASHHEX SessionKey)
+DigestCalcHA1(const char *pszAlg, const char *pszUserName, const char *pszRealm, const char *pszPassword,
+              const char *pszNonce, const char *pszCNonce, HASHHEX SessionKey)
 {
     HASH HA1;
     md_ctx_t *md5_ctx = md_ctx_new();
@@ -90,15 +90,15 @@
 
 /* calculate request-digest/response-digest as per HTTP Digest spec */
 void
-DigestCalcResponse(IN HASHHEX HA1,         /* H(A1) */
-                   IN char *pszNonce,      /* nonce from server */
-                   IN char *pszNonceCount, /* 8 hex digits */
-                   IN char *pszCNonce,     /* client nonce */
-                   IN char *pszQop,        /* qop-value: "", "auth", "auth-int" */
-                   IN char *pszMethod,     /* method from the request */
-                   IN char *pszDigestUri,  /* requested URL */
-                   IN HASHHEX HEntity,     /* H(entity body) if qop="auth-int" */
-                   OUT HASHHEX Response    /* request-digest or response-digest */
+DigestCalcResponse(const HASHHEX HA1,         /* H(A1) */
+                   const char *pszNonce,      /* nonce from server */
+                   const char *pszNonceCount, /* 8 hex digits */
+                   const char *pszCNonce,     /* client nonce */
+                   const char *pszQop,        /* qop-value: "", "auth", "auth-int" */
+                   const char *pszMethod,     /* method from the request */
+                   const char *pszDigestUri,  /* requested URL */
+                   const HASHHEX HEntity,     /* H(entity body) if qop="auth-int" */
+                   HASHHEX Response           /* request-digest or response-digest */
 )
 {
     HASH HA2;
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index 9f3b075..37f3d98 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -26,25 +26,21 @@
 typedef unsigned char HASH[HASHLEN];
 #define HASHHEXLEN 32
 typedef unsigned char HASHHEX[HASHHEXLEN + 1];
-#undef IN
-#undef OUT
-#define IN const
-#define OUT
 
 /* calculate H(A1) as per HTTP Digest spec */
-void DigestCalcHA1(IN char *pszAlg, IN char *pszUserName, IN char *pszRealm, IN char *pszPassword,
-                   IN char *pszNonce, IN char *pszCNonce, OUT HASHHEX SessionKey);
+void DigestCalcHA1(const char *pszAlg, const char *pszUserName, const char *pszRealm, const char *pszPassword,
+                   const char *pszNonce, const char *pszCNonce, HASHHEX SessionKey);
 
 /* calculate request-digest/response-digest as per HTTP Digest spec */
-void DigestCalcResponse(IN HASHHEX HA1,         /* H(A1) */
-                        IN char *pszNonce,      /* nonce from server */
-                        IN char *pszNonceCount, /* 8 hex digits */
-                        IN char *pszCNonce,     /* client nonce */
-                        IN char *pszQop,        /* qop-value: "", "auth", "auth-int" */
-                        IN char *pszMethod,     /* method from the request */
-                        IN char *pszDigestUri,  /* requested URL */
-                        IN HASHHEX HEntity,     /* H(entity body) if qop="auth-int" */
-                        OUT HASHHEX Response    /* request-digest or response-digest */
+void DigestCalcResponse(const HASHHEX HA1,         /* H(A1) */
+                        const char *pszNonce,      /* nonce from server */
+                        const char *pszNonceCount, /* 8 hex digits */
+                        const char *pszCNonce,     /* client nonce */
+                        const char *pszQop,        /* qop-value: "", "auth", "auth-int" */
+                        const char *pszMethod,     /* method from the request */
+                        const char *pszDigestUri,  /* requested URL */
+                        const HASHHEX HEntity,     /* H(entity body) if qop="auth-int" */
+                        HASHHEX Response           /* request-digest or response-digest */
 );
 
 #endif /* if PROXY_DIGEST_AUTH */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
