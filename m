Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0656606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ys6/Mg+S;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W/rpMWtj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CeY7taua
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XbVNSAJTKTbc/SBf/BwTkJmd15mqdz86z/R6WhC9Evs=; b=Ys6/Mg+SLymYsu
	vGQnH7gFXJ2okyCoiCnG5QVeZr6pClG8TVV0g5SBxGVS5WbVqWhGXEZPv+uEzrWGjKaqC5rIsjrjV
	j27dOORrdnEtkNGlnHZB+wM/aShH9wUD2BWQPiCiwlRHc6+BfJVRI6Fxr0zkz3Rc4BfEpzts/02jz
	cwc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTMw2-000000000Zq-3py3;
	Tue, 17 Nov 2026 17:25:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTMw1-000000000Zb-1PwK for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/ADB1IGlV8wy2fW0gkIWWRj5UTb4P3qVGo9pEiUyqhM=; b=W/rpMWtjwmgVfrSFTTuAjarfNK
 KDBgyKMCpmTMnOeZ//SNdVzYwCnChJvFhweMdQBLW4jddyCfLk9WXZHOL2yAzvF9tFp80ih64KBoM
 kMv36iTa7o3ai+TqtZpjkUL6pic0s6Wb3cPBK+fN2UK0CJyNvy9YnNQcEJNyzdHCaMgY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/ADB1IGlV8wy2fW0gkIWWRj5UTb4P3qVGo9pEiUyqhM=; b=CeY7tauauYAXdECcdtsqTaT2x8
 Ph9zGlSgbb6IVQCLJ3jpTzkB0XZC81pLnkb/qVBndNtgMHkkz097YNKsHfbjktAx+skWWVGbab9IE
 T45WGCwfTd6n5V3zSY4UVTji/UwV9sIXsIY83hUiwR4MfoGb4k2B9zeImpAhHvfaunOE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTMvz-000000004QB-1azT for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:25:33 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AHHPOgg011424
 for <openvpn-devel@lists.sourceforge.net>; Tue, 17 Nov 2026 18:25:24 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHHPOAJ011423
 for openvpn-devel@lists.sourceforge.net; Tue, 17 Nov 2026 18:25:24 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 18:25:18 +0100
Message-ID: <20261117172524.11381-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
References: <gerrit.1794934992000.I33123fe621512376410765031fc9ae68cdd91a6c@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTMvz-000000004QB-1azT
Subject: [Openvpn-devel] [PATCH v2] ssl_openssl: fix -Wsign-conversion in
 tls_ctx_set_tls_groups()
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

From: Razvan Cojocaru <razvanc@mailbox.org>

Since 7d46ff17 dropped the -Wsign-conversion pragma, LibreSSL and
AWS-LC CI builds fail: their SSL_CTX_set1_groups() takes a size_t
length, but glistlen is an int.

The buildbot LibreSSL builds pass because the headers also define
SSL_CTX_set1_groups as a macro, and clang suppresses warnings in
expansions of system header macros. CI includes the libraries with
plain -I, so their headers aren't system headers and the warning fires.

OpenSSL 1.1.1's macro passes the length to SSL_CTX_ctrl() as a long,
so add openssl_groups_len_t to pick the type per library.

Change-Id: I33123fe621512376410765031fc9ae68cdd91a6c
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2214
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2214
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 8309cee..ae182d2 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -61,6 +61,14 @@
 typedef uint64_t openssl_opt_t;
 #endif
 
+/* SSL_CTX_set1_groups() length: size_t in LibreSSL and AWS-LC, passed to
+ * SSL_CTX_ctrl() as long by OpenSSL 1.1.1's macro */
+#if defined(LIBRESSL_VERSION_NUMBER) || defined(OPENSSL_IS_AWSLC)
+typedef size_t openssl_groups_len_t;
+#else
+typedef long openssl_groups_len_t;
+#endif
+
 
 /* Functionality missing in LibreSSL before 3.5 */
 #if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050000fL
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 30ef383..b95de8e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -535,7 +535,7 @@
     ALLOC_ARRAY_CLEAR_GC(glist, int, groups_count, &gc);
 
     /* Parse allowed ciphers, getting IDs */
-    int glistlen = 0;
+    openssl_groups_len_t glistlen = 0;
     char *tmp_groups = string_alloc(groups, &gc);
 
     const char *token;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
