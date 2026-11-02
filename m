Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0EA606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gZOE157J;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nPxT5yaI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jJ8flYZM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vDxRQKRaONegmFgQvoAPTnaWIC0AD44jmi56SaJjYj8=; b=gZOE157JIKisWt
	dUOq2zXK65ab2YU4+xPXvoYLNdvmQLAnMFBwcd2JzOOAxJE/nFRh1Jzrw+BubjgjglXEseKGvmnip
	uUyMEx2652S9hAztcfmaUt4QXk3YLNsZixgVK7rjTlKmF5rJZdAOlIKED1iFfyQnFyFZZCDB0Ljei
	T2k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNsPf-000000006sB-1zQV;
	Mon, 02 Nov 2026 13:49:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNsPd-000000006s2-3M4c for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:49:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cs93Z8+HH8jVaIOEsk9OCsdJtkW6Ow440PUl2Kb14fc=; b=nPxT5yaINtOua7C3wZ7jXOXwkK
 vsRno0ViHATYTlBwmIrrriccFk9+HAHO8ufat2pzvyzpv0un5KUTIv2s2D+LRA/4mExS2GTTc1kf5
 8ykR8/NfcFo2negacSMUoHna89dpL1fqxCHH0yJTsU1BezBDVZVXcScvb2b1S03w6j1Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cs93Z8+HH8jVaIOEsk9OCsdJtkW6Ow440PUl2Kb14fc=; b=jJ8flYZMQNypjkanTOMnMXPB5/
 bgnM8BPWZXx/zNjoTaDveJPaMjgbekKcyt65jHbcq3UT3V/Jz5HJXmjy4eUrtjRwszuB2U5YT+V0E
 0h4g7BsKdnKHCThVAGarhK6p2uTI+tQu6YwDks5XqdaNNAeyX7lEBv09Lo7x3tDu30hM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNsPb-000000000S6-0Paq for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:49:23 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2DnGIs026617
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 14:49:16 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2DnGax026616
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 14:49:16 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 14:49:10 +0100
Message-ID: <20261102134915.26599-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
References: <gerrit.1793618230000.Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNsPb-000000000S6-0Paq
Subject: [Openvpn-devel] [PATCH v3] Clean up weak key check
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

From: Arne Schwabe <arne@rfc2549.org>

These methods only check for zero keys after weak DES checks were removed.
Simplify all this to always the first 32 bytes of key and hmac and ensure
that they are not zero.

This now always raises a FATAL alert instead of handling this error
gracefully but a all zeros keys should never ever happen.

Change-Id: Ic5cf5ef723a33ad304b080ef19db2e4a0f4bb2eb
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2080
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2080
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 3d3ab0c..ff17b22 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1104,40 +1104,6 @@
     ctx->initialized = false;
 }
 
-static bool
-key_is_zero(const struct key *key, const struct key_type *kt)
-{
-    size_t cipher_length = cipher_kt_key_size(kt->cipher);
-    for (size_t i = 0; i < cipher_length; ++i)
-    {
-        if (key->cipher[i])
-        {
-            return false;
-        }
-    }
-    msg(D_CRYPT_ERRORS, "CRYPTO INFO: WARNING: zero key detected");
-    return true;
-}
-
-/*
- * Make sure that cipher key is a valid key for current key_type.
- */
-bool
-check_key(const struct key *key, const struct key_type *kt)
-{
-    if (cipher_defined(kt->cipher))
-    {
-        /*
-         * Check for zero key
-         */
-        if (key_is_zero(key, kt))
-        {
-            return false;
-        }
-    }
-    return true;
-}
-
 /*
  * Generate a random key.
  */
@@ -1307,8 +1273,8 @@
             print_key_filename(key_file, key_inline));
     }
 
-    /* check for and fix highly unlikely key problems */
-    verify_fix_key2(&key2, key_type, key_file);
+    /* check for highly unlikely key problems */
+    check_key2(&key2);
 
     /* handle key direction */
     key_direction_state_init(&kds, key_direction);
@@ -1708,18 +1674,19 @@
 }
 
 void
-verify_fix_key2(struct key2 *key2, const struct key_type *kt, const char *shared_secret_file)
+check_key2(struct key2 *key2)
 {
-    int i;
+    /* Check the first 128 bit of every key slot to be not 0. This is
+     * not a comprehensive check, but no valid key should fail this check */
 
-    for (i = 0; i < key2->n; ++i)
+    uint8_t zero_key[16] = { 0 };
+
+    if (memcmp_constant_time(key2->keys[0].cipher, zero_key, sizeof(zero_key)) == 0
+        || memcmp_constant_time(key2->keys[1].cipher, zero_key, sizeof(zero_key)) == 0
+        || memcmp_constant_time(key2->keys[0].hmac, zero_key, sizeof(zero_key)) == 0
+        || memcmp_constant_time(key2->keys[1].hmac, zero_key, sizeof(zero_key)) == 0)
     {
-        /* This should be a very improbable failure */
-        if (!check_key(&key2->keys[i], kt))
-        {
-            msg(M_FATAL, "Key #%d in '%s' is bad.  Try making a new key with --genkey.", i + 1,
-                shared_secret_file);
-        }
+        msg(M_FATAL, "One key in static key/generated key  is all zero.");
     }
 }
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index e3c1c6a..dbe0802 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -414,8 +414,6 @@
  */
 int write_key_file(const int nkeys, const char *filename);
 
-bool check_key(const struct key *key, const struct key_type *kt);
-
 /**
  * Initialize a key_type structure with.
  *
@@ -621,7 +619,7 @@
 
 void key_direction_state_init(struct key_direction_state *kds, int key_direction);
 
-void verify_fix_key2(struct key2 *key2, const struct key_type *kt, const char *shared_secret_file);
+void check_key2(struct key2 *key2);
 
 void must_have_n_keys(const char *filename, const char *option, const struct key2 *key2, int n);
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 086a6fc..ddee3eb 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1583,15 +1583,7 @@
     key2_print(&key2, &session->opt->key_type, "Master Encrypt", "Master Decrypt");
 
     /* check for weak keys */
-    for (int i = 0; i < 2; ++i)
-    {
-        if (!check_key(&key2.keys[i], &session->opt->key_type))
-        {
-            msg(D_TLS_ERRORS, "TLS Error: Bad dynamic key generated");
-            goto exit;
-        }
-    }
-
+    check_key2(&key2);
     ret = init_key_contexts(ks, multi, &session->opt->key_type, server, &key2,
                             session->opt->dco_enabled);
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
