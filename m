Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F2606A326
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Huj/CsjR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Rh0VHxFn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Al5ptQAg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6i5eLf+uu92xP8+/NQv0Rya4eQBCX8ugh2A0Y5rBJpY=; b=Huj/CsjRXIacH6
	MlcS6x/eN39grPwBX852RH1tJvFdOquezR+YDdryJK018f8ivgnXKfsJ/zfUrKxeJL4bHcc+uGFeB
	19Z2xxuhH2ZPZzJRUz2Ueo9TdbVMv21PLAlV4abae7yI/2ZhPJehenjMWSYjUvWfKOCZk10O1VZIY
	HeA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWKZL-000000004ou-0h8r;
	Wed, 25 Nov 2026 21:30:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWKZK-000000004oo-0sH4 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 21:30:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wkkxzKblg6QHgtyha2Ak0F+pDre4J/Nf8P7EmaehV8Q=; b=Rh0VHxFnzRpz3w0KVmpbxGsNav
 hbZjE0TFybO3lxXLh8Euk/BdEn5l2sApALF2/Ap2LjHphcKvqMIYNMapsGlNYMVvSKQCM2yYxtuof
 tgQRzDCJeqoe4pkqOBSnm9CWRZdKZK1sSq+egGPm0spY+iB4hehE4EHvb8yCxHC2AN6o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wkkxzKblg6QHgtyha2Ak0F+pDre4J/Nf8P7EmaehV8Q=; b=Al5ptQAg9fMn5OX8AWE16opUTO
 lOl2lCMVqjdpj5pk6lVpd09fJaSQTbMa+HAO5zY1wQLxgSsM8XL4EjOaE8R1qIeNk2tbG8izf6qyx
 5IytfKYArefmrSOdCp4F6djxnsom8kFDGZdycKQcpSwwhuPqLnFhWXVbwhvOsMdbGt9o=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWKZI-000000002JP-20y1 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 21:30:22 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6APLUDM9015814
 for <openvpn-devel@lists.sourceforge.net>; Wed, 25 Nov 2026 22:30:13 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6APLUDYV015813
 for openvpn-devel@lists.sourceforge.net; Wed, 25 Nov 2026 22:30:13 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 25 Nov 2026 22:30:07 +0100
Message-ID: <20261125213012.15799-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794903672000.I9d9b658a00f95ffdcd0db9abd0d8907618925746@gerrit.openvpn.net>
References: <gerrit.1794903672000.I9d9b658a00f95ffdcd0db9abd0d8907618925746@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWKZI-000000002JP-20y1
Subject: [Openvpn-devel] [PATCH v2] Wipe auth token and PEM key copies
 before freeing them
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

generate_auth_token() freed the previous token and its intermediate copies
without wiping them, unlike wipe_auth_token(). crypto_pem_decode() in the
mbed TLS backend freed its copy of the PEM key text the same way.

Change-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2206
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2206
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 261c7c2..d8e599b 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -271,10 +271,15 @@
     ASSERT(buf_write(&session_token, b64output, strlen(b64output)));
     ASSERT(buf_write_u8(&session_token, 0));
 
+    secure_memzero(b64output, strlen(b64output));
     free(b64output);
 
     /* free the auth-token if defined, we will replace it with a new one */
-    free(multi->auth_token);
+    if (multi->auth_token)
+    {
+        secure_memzero(multi->auth_token, strlen(multi->auth_token));
+        free(multi->auth_token);
+    }
     multi->auth_token = string_alloc((char *)BPTR(&session_token), NULL);
 
     dmsg(D_SHOW_KEYS, "Generated token for client: %s (%s)", multi->auth_token, up->username);
@@ -288,6 +293,8 @@
         multi->auth_token_initial = string_alloc(multi->auth_token, NULL);
     }
 
+    buf_clear(&token);
+    buf_clear(&session_token);
     gc_free(&gc);
 }
 
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index ceaaad4..58c1fd2 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -1150,6 +1150,7 @@
     }
 
     mbedtls_pem_free(&ctx);
+    buf_clear(&input);
     gc_free(&gc);
     return ret;
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
