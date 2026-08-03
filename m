Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40458C55182
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XI6aj/JNozMSuPOjOSYfirZsVqNdN88lDN/XYBsgTg0=; b=biIAcKWiKX9pBh9lKI5fL11XWS
	P3BpMj7cjtjL4UfhjNLSH4cLftCOmM5JDaS+nWHiNjOWJrypB5g0gJiu2LehaXFSW+qukddYXnEXv
	aazVt9Cj+0ARQ8xDknyUagC6De34svq1yP4qhe2vdp+ctvbWf0JI2O4cEYPK/wlEdbis=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqsbg-0007Xn-DU;
	Mon, 03 Aug 2026 13:21:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wqsbe-0007Xg-78
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2PO2TRbgkXg19UfpH4jQO2BLMzpSA9SzBMSIF+7WMMQ=; b=cCMGH5LyH0oWRsmrMvp7qe1yF9
 tpu7CaO4eHJFDrjjCzx6YiBj6tghSkqJOnevZ2DvmOrheC4Z6NyaBqdYpKKNVSsKw0QiBwSIAaMig
 hcSn4MFBp23Tp6U6dFW57lFtqM1aRZ+/YwnjiM/gqXkqbgkt8rK8jm7EN10D7eKAfAUk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2PO2TRbgkXg19UfpH4jQO2BLMzpSA9SzBMSIF+7WMMQ=; b=Kc/QghGqxQ3/uZuiHoBufyhHyN
 2HksNcUkzDFxIBytOnYcrOJyvF4SyXUD5dksFi+fFMIakof5ptw4HOzozleCuHodl0b4N8qvTmkzh
 ycZeVsFzOJ5Uz7BVrSyj5z6XQvXMr2cPtjCyxgpgddpZ0f1VPhZBMd6GQEZ6E0YLEX/Q=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqsbg-0003IM-On for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:21:26 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 673DLHZt006367
 for <openvpn-devel@lists.sourceforge.net>; Mon, 3 Aug 2026 15:21:17 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 673DLHP0006366
 for openvpn-devel@lists.sourceforge.net; Mon, 3 Aug 2026 15:21:17 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  3 Aug 2026 15:21:12 +0200
Message-ID: <20260803132117.6353-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
References: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wqsbg-0003IM-On
Subject: [Openvpn-devel] [PATCH v1] Replace ASSERT(rand_bytes(...)) with
 prng_bytes
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

prng_bytes is already ASSERT(rand_bytes(...)), so this change is
just a little cleanup that makes a code a little bit nicer.

Change-Id: If458a3362e03630ce699bd122e957169601657a5
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1833
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1833
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ee43d65..8f59838 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1219,7 +1219,7 @@
             ASSERT(cipher_ctx_iv_length(cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
 
             /* Generate dummy implicit IV */
-            ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH));
+            prng_bytes(co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
 
             memcpy(co->key_ctx_bi.decrypt.implicit_iv, co->key_ctx_bi.encrypt.implicit_iv,
                    OPENVPN_MAX_IV_LENGTH);
@@ -1239,7 +1239,7 @@
         ASSERT(buf_init(&src, 0));
         ASSERT(i <= src.capacity);
         src.len = i;
-        ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+        prng_bytes(BPTR(&src), BLEN(&src));
 
         /* copy source to input buf */
         buf = work;
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 9f3ec93..9acb2fa 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -734,7 +734,7 @@
                 }
 
                 /* generate a client nonce */
-                ASSERT(rand_bytes(cnonce_raw, sizeof(cnonce_raw)));
+                prng_bytes(cnonce_raw, sizeof(cnonce_raw));
                 cnonce = make_base64_string2(cnonce_raw, sizeof(cnonce_raw), &gc);
 
 
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index d473d67..b86d57c 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -322,7 +322,7 @@
         ASSERT(buf_init(&src, 0));
         ASSERT(i <= src.capacity);
         src.len = i;
-        ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+        prng_bytes(BPTR(&src), BLEN(&src));
 
         /* copy source to input buf */
         buf = work;
@@ -368,7 +368,7 @@
     ASSERT(buf_init(&src, 0));
     ASSERT(len <= src.capacity);
     src.len = len;
-    ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+    prng_bytes(BPTR(&src), BLEN(&src));
 
     /* copy source to input buf */
     buf = work;
@@ -453,10 +453,10 @@
     }
     else
     {
-        ASSERT(rand_bytes(key2.keys[0].cipher, sizeof(key2.keys[0].cipher)));
-        ASSERT(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac)));
-        ASSERT(rand_bytes(key2.keys[1].cipher, sizeof(key2.keys[1].cipher)));
-        ASSERT(rand_bytes(key2.keys[1].hmac, sizeof(key2.keys)[1].hmac));
+        prng_bytes(key2.keys[0].cipher, sizeof(key2.keys[0].cipher));
+        prng_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac));
+        prng_bytes(key2.keys[1].cipher, sizeof(key2.keys[1].cipher));
+        prng_bytes(key2.keys[1].hmac, sizeof(key2.keys)[1].hmac);
     }
 
     struct crypto_options co = { 0 };


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
