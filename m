Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CFAC56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yTPMGlKTV8S2FV9ROYW7/q1LvECNeCi4O8mp0FdxfJ0=; b=lG9ABu4+QoFxiIn0sXfOdNLH0/
	zW6ELdg1jnhycW3BjMVSlsxEdhg8avcZ8dyLdU9MY0+dhgXezJLlDfLQsi/DmKBUBCtN5ISiipx4W
	hgUBJRFgowZrI4HM76bLNoH1MieyweE5t3l7SZ27noN8i64uy9Vzm4Y7CjMQcb0PH/Vg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrxFp-00055w-LG;
	Thu, 06 Aug 2026 12:31:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wrxFo-00055o-4j
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z6vBBgnS9d9L3iSjAkzdc41CVh4jSiN3mgEgp9vNWFU=; b=PqIxMhJjHQwTgbg2riIAkUPbTg
 FA/RGen28+Z5/xkiLHxut4k3xF4Waf7pvigUi+e60khUGDhrk2B7z50/Qfh88tekJSrc0qMwT5TGl
 ImiQZM93/fq2Fg/zg0djzPowm9YCOItFDbJpa+ZMJCAR9VZ67zrJJcVtJSK1YBzoDPgc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z6vBBgnS9d9L3iSjAkzdc41CVh4jSiN3mgEgp9vNWFU=; b=RIadx6+AoR2PgSRE7c7bSxdZIl
 Kwkf5CnZBdk7N70beuaCeaEFVUBCyyDvyFjVQDOiyCFRaayEyc01BNt4SQwIx/TKy9jg6j3tE7z51
 oGVErd3HDlU46Fv9yMmvaOPAs/uGybzayWxcrJaDru69iI917xWU5PaVPxr6p+qgRk4E=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrxFk-0008SD-LK for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:31:19 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 676C2Lnt003823
 for <openvpn-devel@lists.sourceforge.net>; Thu, 6 Aug 2026 14:02:21 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 676C2Lsu003822
 for openvpn-devel@lists.sourceforge.net; Thu, 6 Aug 2026 14:02:21 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  6 Aug 2026 14:02:14 +0200
Message-ID: <20260806120220.3806-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wrxFk-0008SD-LK
Subject: [Openvpn-devel] [PATCH v3] dco: do not exit the process when
 installing a DCO key fails
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

From: Antonio Quartulli <antonio@mandelbit.com>

When the DCO peer is gone from the kernel while userspace still believes
it exists, dco_new_key() fails with ENOENT and init_key_contexts() calls
msg(M_FATAL, ...). On a server this terminates the whole daemon and
disconnects every other client, even though only a single peer is
affected.

Propagate the failure instead. Since a DCO desync needs a different
recovery than any other key generation error - the kernel peer has to be
re-created, which only a reconnect can do - report it as a distinct
key_gen_status through generate_key_expansion() and
tls_session_generate_data_channel_keys(), and let tls_multi_process()
turn it into a new TLSMP_RESTART result that check_tls() dispatches as a
SIGUSR1. On a server this restarts only the affected client instance.

The restart request is tracked separately from 'active' because it must
not be overwritten by a later TLSMP_ACTIVE or TLSMP_RECONNECT
assignment, and the return value now applies an explicit precedence:
killing the session supersedes restarting it, which supersedes 'active'.

tls_session_update_crypto_params_do_work() collapses the desync back to
a plain failure, as all of its callers already turn a failure into a
SIGUSR1.

Note that commit ea3bb67e2b1e ("dco: make key state desync recoverable")
does not cover this case, as both of its hunks are conditional on the
key installation having succeeded.

Github: fixes OpenVPN/openvpn#542
Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1835
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1835
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 46e1a53..a0ddb0f 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -206,6 +206,12 @@
                 register_signal(c->sig, SIGTERM, "auth-control-exit");
             }
         }
+        else if (tmp_status == TLSMP_RESTART)
+        {
+            /* The session cannot recover on its own. Kill the connection so
+             * that it is set up again from scratch */
+            register_signal(c->sig, SIGUSR1, "dco key state desync");
+        }
 
         interval_future_trigger(&c->c2.tmp_int, wakeup);
     }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ccd8264..4a4feaf 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1373,7 +1373,22 @@
     secure_memzero(&e1_recv, sizeof(e1_recv));
 }
 
-static void
+/**
+ * Outcome of generating the data channel keys of a session.
+ *
+ * \c KEY_GEN_DCO_DESYNC is kept distinct from \c KEY_GEN_FAILED because it
+ * means userspace and kernel disagree about the DCO peer: the session cannot
+ * recover on its own and the connection has to be restarted, while any other
+ * failure only invalidates the affected key state.
+ */
+enum key_gen_status
+{
+    KEY_GEN_OK,         /**< keys were generated and installed */
+    KEY_GEN_FAILED,     /**< generation failed, invalidate the key state */
+    KEY_GEN_DCO_DESYNC, /**< the DCO peer is gone from the kernel */
+};
+
+static enum key_gen_status
 init_key_contexts(struct key_state *ks, struct tls_multi *multi, const struct key_type *key_type,
                   bool server, struct key2 *key2, bool dco_enabled)
 {
@@ -1392,7 +1407,16 @@
         int ret = init_key_dco_bi(multi, ks, key2, key_direction, key_type->cipher, server);
         if (ret < 0)
         {
-            msg(M_FATAL, "Impossible to install key material in DCO: %s", strerror(-ret));
+            /* This normally means the DCO peer is gone from the kernel while
+             * userspace still believes it exists. Do not take the whole
+             * process down over a single peer: report the desync so that the
+             * connection is restarted and the peer re-created from scratch */
+            msg(M_WARN,
+                "Impossible to install key material in DCO: %s. The underlying "
+                "DCO peer may have been deleted from the kernel without "
+                "notifying userspace. Restarting the session.",
+                strerror(-ret));
+            return KEY_GEN_DCO_DESYNC;
         }
 
         /* encrypt/decrypt context are unused with DCO */
@@ -1415,6 +1439,8 @@
     {
         init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel");
     }
+
+    return KEY_GEN_OK;
 }
 
 static bool
@@ -1475,11 +1501,11 @@
  * Using source entropy from local and remote hosts, mix into
  * master key.
  */
-static bool
+static enum key_gen_status
 generate_key_expansion(struct tls_multi *multi, struct key_state *ks, struct tls_session *session)
 {
     struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
-    bool ret = false;
+    enum key_gen_status ret = KEY_GEN_FAILED;
     struct key2 key2;
 
     if (key->initialized)
@@ -1524,8 +1550,8 @@
         }
     }
 
-    init_key_contexts(ks, multi, &session->opt->key_type, server, &key2, session->opt->dco_enabled);
-    ret = true;
+    ret = init_key_contexts(ks, multi, &session->opt->key_type, server, &key2,
+                            session->opt->dco_enabled);
 
 exit:
     secure_memzero(&key2, sizeof(key2));
@@ -1539,10 +1565,10 @@
  * This erases the source material used to generate the data channel keys, and
  * can thus be called only once per session.
  */
-bool
+static enum key_gen_status
 tls_session_generate_data_channel_keys(struct tls_multi *multi, struct tls_session *session)
 {
-    bool ret = false;
+    enum key_gen_status ret = KEY_GEN_FAILED;
     struct key_state *ks = &session->key[KS_PRIMARY]; /* primary key */
 
     if (ks->authenticated <= KS_AUTH_FALSE)
@@ -1553,7 +1579,8 @@
 
     ks->crypto_options.flags = session->opt->crypto_flags;
 
-    if (!generate_key_expansion(multi, ks, session))
+    ret = generate_key_expansion(multi, ks, session);
+    if (ret != KEY_GEN_OK)
     {
         msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
         goto cleanup;
@@ -1565,7 +1592,6 @@
     /* set the state of the keys for the session to generated */
     ks->state = S_GENERATED_KEYS;
 
-    ret = true;
 cleanup:
     secure_memzero(ks->key_src, sizeof(*ks->key_src));
     return ret;
@@ -1637,7 +1663,10 @@
             }
         }
     }
-    return tls_session_generate_data_channel_keys(multi, session);
+    /* A DCO desync is reported as a plain failure here: every caller of this
+     * function already turns a failure into a SIGUSR1, which is exactly the
+     * recovery a desync needs */
+    return tls_session_generate_data_channel_keys(multi, session) == KEY_GEN_OK;
 }
 
 bool
@@ -3232,6 +3261,9 @@
     struct gc_arena gc = gc_new();
     int active = TLSMP_INACTIVE;
     bool error = false;
+    /* kept separate from 'active' on purpose: a restart request must not be
+     * overwritten by a later TLSMP_ACTIVE/TLSMP_RECONNECT assignment */
+    bool restart = false;
 
     tls_clear_error();
 
@@ -3334,12 +3366,22 @@
             /* Session is now fully authenticated.
              * tls_session_generate_data_channel_keys will move ks->state
              * from S_ACTIVE to S_GENERATED_KEYS */
-            if (!tls_session_generate_data_channel_keys(multi, session))
+            enum key_gen_status status = tls_session_generate_data_channel_keys(multi, session);
+            if (status != KEY_GEN_OK)
             {
                 msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
                 ks->authenticated = KS_AUTH_FALSE;
                 key_state_ssl_shutdown(&ks->ks_ssl);
                 ks->state = S_ERROR_PRE;
+
+                /* Invalidating the key state is not enough to recover from a
+                 * DCO desync: the kernel peer has to be re-created, and the
+                 * key state we just invalidated will never be retried, so ask
+                 * for a restart right away */
+                if (status == KEY_GEN_DCO_DESYNC)
+                {
+                    restart = true;
+                }
             }
 
             /* Update auth token on the client if needed on renegotiation
@@ -3428,7 +3470,17 @@
 
     gc_free(&gc);
 
-    return (tas == TLS_AUTHENTICATION_FAILED) ? TLSMP_KILL : active;
+    /* strongest outcome wins: killing the session supersedes restarting it,
+     * and restarting supersedes whatever 'active' ended up being */
+    if (tas == TLS_AUTHENTICATION_FAILED)
+    {
+        return TLSMP_KILL;
+    }
+    if (restart)
+    {
+        return TLSMP_RESTART;
+    }
+    return active;
 }
 
 /**
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 7ddf965..5483fbb 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -231,6 +231,8 @@
 #define TLSMP_ACTIVE    1
 #define TLSMP_KILL      2
 #define TLSMP_RECONNECT 3
+/** the session cannot recover on its own and has to be restarted */
+#define TLSMP_RESTART   4
 
 /*
  * Called by the top-level event loop.
@@ -554,15 +556,6 @@
 void show_available_tls_ciphers(const char *cipher_list, const char *cipher_list_tls13,
                                 const char *tls_cert_profile);
 
-
-/**
- * Generate data channel keys for the supplied TLS session.
- *
- * This erases the source material used to generate the data channel keys, and
- * can thus be called only once per session.
- */
-bool tls_session_generate_data_channel_keys(struct tls_multi *multi, struct tls_session *session);
-
 void tls_session_soft_reset(struct tls_multi *multi);
 
 /**


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
