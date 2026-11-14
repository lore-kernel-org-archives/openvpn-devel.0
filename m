Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675A606A323
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Lxsbc4qG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WXXXBlca;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LWjsAa27
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zr0zbJ14BTI7kvqtM3fU2GmZ0rKNit7hycwUT6AM17o=; b=Lxsbc4qGZqM1WL
	6/xJEeLpaKkGOnXWL0q+Gpgf6BsDzY65YKqrS0V5XOwuzr22fY83/Cf6+PP5dUIz2DTwGSInDpm5w
	49+mCqBHR2ek3BkEi3Nok21cx3lEUEjirax9c147wCvsdR4Eylt10XyL6dHzN2CvqfHNZlm5xsNQp
	6R8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSHv6-000000000Cw-3GpP;
	Sat, 14 Nov 2026 17:52:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSHv4-000000000Co-2rwZ for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:52:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SoQKE8ZQPambZYbLmdx6UO4b5bLTzkL0Vs5TOx9PegM=; b=WXXXBlca+6FODDb4I37knghyFW
 QYI2PrTIJwV9fuX/ApGoEZ6mY99mlzfbmfkQWwouuA3il7AC9GdNxvUFeE4exgAa3vUd6LNA/YZdm
 D+CRr03F3hZg0n52ivEoYOBQii/FOgNBjnULIns7z64aKgUkXbrx6wWVF9H5BmQeno1c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SoQKE8ZQPambZYbLmdx6UO4b5bLTzkL0Vs5TOx9PegM=; b=LWjsAa27mBvpndZYHYIp3EwlKV
 w1q+7+GZOZD7SI0liTbW99PMDzSepIDbqKKZQichlrkMy9vNxqYqB5fH7Uzme7hCw7+/jbq3rgfb8
 LsIadDe6ndpTEEbAZRQQ3r36/6pD3TioFU3ZzPxKoC84YrlAWNFt1RwlSAFRXV3A7f+I=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSHv3-000000002yz-2k95 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:52:06 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AEHpwU2013447
 for <openvpn-devel@lists.sourceforge.net>; Sat, 14 Nov 2026 18:51:58 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEHpwwO013446
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 18:51:58 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 14 Nov 2026 18:51:53 +0100
Message-ID: <20261114175158.13434-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSHv3-000000002yz-2k95
Subject: [Openvpn-devel] [PATCH v32] init: Extract init_tls_wrap_ctx()
 control-channel wrap helper
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

From: Lev Stipakov <lev@openvpn.net>

Factor the tls-auth/tls-crypt wrapping-context setup out of
do_init_crypto_tls() into a reusable init_tls_wrap_ctx() helper, and
expose it in init.h together with do_init_tls_wrap_key(), which now
takes the connection entry to read its keys from instead of using
options.ce. Both call sites pass &c->options.ce, so there is no behavior
change.

A planned server-probe feature will use the helper to build the wrapping
context before a connection exists, so that a probe can be wrapped with
tls-auth/tls-crypt like any other control packet.

Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1749
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1749
This mail reflects revision 32 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ff3bfe5..bea8e60 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3097,13 +3097,13 @@
 /*
  * Initialize the tls-auth/crypt key context
  */
-static void
-do_init_tls_wrap_key(struct context *c)
+void
+do_init_tls_wrap_key(struct context *c, const struct connection_entry *ce)
 {
     const struct options *options = &c->options;
 
     /* TLS handshake authentication (--tls-auth) */
-    if (options->ce.tls_auth_file)
+    if (ce->tls_auth_file)
     {
         /* Initialize key_type for tls-auth with auth only */
         CLEAR(c->c1.ks.tls_auth_key_type);
@@ -3118,33 +3118,31 @@
         }
 
         crypto_read_openvpn_key(&c->c1.ks.tls_auth_key_type, &c->c1.ks.tls_wrap_key,
-                                options->ce.tls_auth_file, options->ce.tls_auth_file_inline,
-                                options->ce.key_direction, "Control Channel Authentication",
-                                "tls-auth", &c->c1.ks.original_wrap_keydata);
+                                ce->tls_auth_file, ce->tls_auth_file_inline, ce->key_direction,
+                                "Control Channel Authentication", "tls-auth",
+                                &c->c1.ks.original_wrap_keydata);
     }
 
     /* TLS handshake encryption+authentication (--tls-crypt) */
-    if (options->ce.tls_crypt_file)
+    if (ce->tls_crypt_file)
     {
         tls_crypt_init_key(&c->c1.ks.tls_wrap_key, &c->c1.ks.original_wrap_keydata,
-                           options->ce.tls_crypt_file, options->ce.tls_crypt_file_inline,
-                           options->tls_server);
+                           ce->tls_crypt_file, ce->tls_crypt_file_inline, options->tls_server);
     }
 
     /* tls-crypt with client-specific keys (--tls-crypt-v2) */
-    if (options->ce.tls_crypt_v2_file)
+    if (ce->tls_crypt_v2_file)
     {
         if (options->tls_server)
         {
             tls_crypt_v2_init_server_key(&c->c1.ks.tls_crypt_v2_server_key, true,
-                                         options->ce.tls_crypt_v2_file,
-                                         options->ce.tls_crypt_v2_file_inline);
+                                         ce->tls_crypt_v2_file, ce->tls_crypt_v2_file_inline);
         }
         else
         {
             tls_crypt_v2_init_client_key(&c->c1.ks.tls_wrap_key, &c->c1.ks.original_wrap_keydata,
-                                         &c->c1.ks.tls_crypt_v2_wkc, options->ce.tls_crypt_v2_file,
-                                         options->ce.tls_crypt_v2_file_inline);
+                                         &c->c1.ks.tls_crypt_v2_wkc, ce->tls_crypt_v2_file,
+                                         ce->tls_crypt_v2_file_inline);
         }
         /* We have to ensure that the loaded tls-crypt key is small enough
          * to fit into the initial hard reset v3 packet */
@@ -3153,18 +3151,45 @@
         /* empty ACK/message id, tls-crypt, Opcode, UDP, ipv6 */
         int required_size = 5 + wkc_len + tls_crypt_buf_overhead() + 1 + 8 + 40;
 
-        if (required_size > c->options.ce.tls_mtu)
+        if (required_size > ce->tls_mtu)
         {
             msg(M_WARN,
                 "ERROR: tls-crypt-v2 client key too large to work with "
                 "requested --max-packet-size %d, requires at least "
                 "--max-packet-size %d. Packets will ignore requested "
                 "maximum packet size",
-                c->options.ce.tls_mtu, required_size);
+                ce->tls_mtu, required_size);
         }
     }
 }
 
+void
+init_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce, bool tls_client,
+                  const struct key_schedule *ks, struct packet_id_persist *pid_persist)
+{
+    CLEAR(*tls_wrap);
+
+    /* TLS handshake authentication (--tls-auth) */
+    if (ce->tls_auth_file)
+    {
+        tls_wrap->mode = TLS_WRAP_AUTH;
+    }
+
+    /* TLS handshake encryption (--tls-crypt) */
+    if (ce->tls_crypt_file || (ce->tls_crypt_v2_file && tls_client))
+    {
+        tls_wrap->mode = TLS_WRAP_CRYPT;
+    }
+
+    if (tls_wrap->mode == TLS_WRAP_AUTH || tls_wrap->mode == TLS_WRAP_CRYPT)
+    {
+        tls_wrap->opt.key_ctx_bi = ks->tls_wrap_key;
+        tls_wrap->opt.pid_persist = pid_persist;
+        tls_wrap->opt.flags |= CO_PACKET_ID_LONG_FORM;
+        tls_wrap->original_wrap_keydata = ks->original_wrap_keydata;
+    }
+}
+
 /*
  * Initialize the persistent component of OpenVPN's TLS mode,
  * which is preserved across SIGUSR1 resets.
@@ -3236,7 +3261,7 @@
         init_key_type(&c->c1.ks.key_type, ciphername, options->authname, true, warn);
 
         /* initialize tls-auth/crypt/crypt-v2 key */
-        do_init_tls_wrap_key(c);
+        do_init_tls_wrap_key(c, &c->options.ce);
 
         /* initialise auth-token crypto support */
         if (c->options.auth_token_generate)
@@ -3261,7 +3286,7 @@
          * tls-auth/crypt key can be configured per connection block, therefore
          * we must reload it as it may have changed
          */
-        do_init_tls_wrap_key(c);
+        do_init_tls_wrap_key(c, &c->options.ce);
     }
 }
 
@@ -3439,25 +3464,9 @@
         to.ekm_size = 0;
     }
 
-    /* TLS handshake authentication (--tls-auth) */
-    if (options->ce.tls_auth_file)
-    {
-        to.tls_wrap.mode = TLS_WRAP_AUTH;
-    }
-
-    /* TLS handshake encryption (--tls-crypt) */
-    if (options->ce.tls_crypt_file || (options->ce.tls_crypt_v2_file && options->tls_client))
-    {
-        to.tls_wrap.mode = TLS_WRAP_CRYPT;
-    }
-
-    if (to.tls_wrap.mode == TLS_WRAP_AUTH || to.tls_wrap.mode == TLS_WRAP_CRYPT)
-    {
-        to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
-        to.tls_wrap.opt.pid_persist = &c->c1.pid_persist;
-        to.tls_wrap.opt.flags |= CO_PACKET_ID_LONG_FORM;
-        to.tls_wrap.original_wrap_keydata = c->c1.ks.original_wrap_keydata;
-    }
+    /* Control-channel wrapping (--tls-auth / --tls-crypt) */
+    init_tls_wrap_ctx(&to.tls_wrap, &c->options.ce, options->tls_client, &c->c1.ks,
+                      &c->c1.pid_persist);
 
     if (options->ce.tls_crypt_v2_file)
     {
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index c486158..67834a9 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -73,6 +73,39 @@
 
 void do_test_crypto(struct context *o);
 
+/**
+ * @brief Load the tls-auth/tls-crypt(-v2) key material into c->c1.ks.
+ *
+ * Reads the key from the file configured on connection entry ce (--tls-auth,
+ * --tls-crypt or --tls-crypt-v2); a no-op when none of them is set. May be
+ * called more than once (the key can be configured per connection block, so it
+ * is reloaded for each connection).
+ *
+ * @param c  The context whose c1.ks key schedule is populated.
+ * @param ce The connection entry whose tls-wrap key file is loaded.
+ */
+void do_init_tls_wrap_key(struct context *c, const struct connection_entry *ce);
+
+/**
+ * @brief Configure a control-channel wrapping context from a connection entry
+ *        and previously loaded tls-wrap key material.
+ *
+ * Sets tls_wrap to TLS_WRAP_AUTH (--tls-auth) or TLS_WRAP_CRYPT
+ * (--tls-crypt / client --tls-crypt-v2) and installs the key context, or
+ * leaves it in TLS_WRAP_NONE when neither is configured. The key material must
+ * already have been loaded with do_init_tls_wrap_key(). tls-crypt-v2 specifics
+ * (the wrapped client key and the server key) are left to the caller.
+ *
+ * @param tls_wrap    The wrapping context to configure.
+ * @param ce          The connection entry selecting the wrapping mode.
+ * @param tls_client  Whether this is a TLS client (selects tls-crypt-v2 mode).
+ * @param ks          Key schedule holding the loaded tls-wrap key material.
+ * @param pid_persist Packet-id persistence object to attach to the context.
+ */
+void init_tls_wrap_ctx(struct tls_wrap_ctx *tls_wrap, const struct connection_entry *ce,
+                       bool tls_client, const struct key_schedule *ks,
+                       struct packet_id_persist *pid_persist);
+
 void context_gc_free(struct context *c);
 
 bool do_up(struct context *c, bool pulled_options, uint64_t option_types_found);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
