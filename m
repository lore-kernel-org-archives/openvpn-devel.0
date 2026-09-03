Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AE8C624D4
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gmx/PRrVLe6wiFake78PH/wMJLoRrzM6MwzuSayPd9I=; b=m4VHblvU52YGUQBuwtV7ynJpFs
	S2ShJ5t5FdqmauluhB7CpfZomrDD8WxYDichhrdGikNPukgw5uXcZAfVzj4yJby9ZR4iiS5myH+N6
	C8mhJBu1w6Y9ZNavB6BTSbMCHdyyVfCHFv22ZUfqythOKKhPdyfUV2I7h3log+os5ewg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x20gl-0004Sj-Ct;
	Thu, 03 Sep 2026 06:12:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x20gU-0004SR-LQ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 06:12:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s46Nd+OrANvBILNp6mrQyrj9k5XX/WkvpKLuEX5q6Nc=; b=J1ejoruQrL7oVl0GDEf7rT/0wT
 qGAHEbiwKvc30UP6FUL5FzFgzX0+flfYfvwkpL94OCQkUKKPwViRaR0ffmqwJHC/wTvFcbnAAHVKj
 KBKWNkxK6/hE8CqpNXW/OOk+GWHts28twkde0Ha3NQpA+kKq5kM6Th5wwSouV9cVJTgk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s46Nd+OrANvBILNp6mrQyrj9k5XX/WkvpKLuEX5q6Nc=; b=aVfMiRfe8TNduQaUo9ZXOT+nfm
 tS2EVFqEX16d2BxyVg23dkNNleUxu2BDmkTEYKmvzrBVAigRMTs8Bad1f0EgcwOwaFsEWfHfACGkk
 39cvYTKoug1i5wpW2/2QoTms39K7IaF23h+lbLCjhazix1E0R39akLgvoRSCZ1AWrzDI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x20gL-0002zG-05 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 06:12:19 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6836C9Ho012618
 for <openvpn-devel@lists.sourceforge.net>; Thu, 3 Sep 2026 08:12:09 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6836C9vc012617
 for openvpn-devel@lists.sourceforge.net; Thu, 3 Sep 2026 08:12:09 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 08:12:02 +0200
Message-ID: <20260903061209.12599-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788368618000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1788368618000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x20gL-0002zG-05
Subject: [Openvpn-devel] [PATCH v3] Move check_session_buf_not_used method
 into the method that free the buffer
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

This cleans the code up a bit and ensure that we do not miss an invocation
of a problematic code path. This is still a band-aid fix and a real fix
requires more refactoring and changing the logic.

v2: sprinkle some "const" over check_keystate_buf_not_used() args
v3: add missing doxygen for to_link parameter to tls_session_free()

CVE: 2026-84471
Reported-By: Andreas Gabriel Berbescu <aberbescu@gmail.com>
Github: openvpn/openvpn-private-issues#157
Reported-By: Haruki Oyama (Waseda University)
Github: openvpn/openvpn-private-issues#132
Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1893
Acked-by: MaxF <max@max-fillinger.net>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1893
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5f5d1f9..71459ee 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -96,6 +96,14 @@
 
 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */
 
+/* forward decleration since tls_process needs this function prototype */
+static void
+check_session_buf_not_used(struct buffer *to_link, struct tls_session *session);
+
+static void
+check_keystate_buf_not_used(struct buffer *to_link, const struct key_state *ks);
+
+
 /**
  * Limit the reneg_bytes value when using a small-block (<128 bytes) cipher.
  *
@@ -896,10 +904,15 @@
  *                       cleaned up.
  * @param clear        - Whether the memory allocated for the \a ks object
  *                       should be overwritten with 0s.
+ *
+ * @param to_link      - if not NULL, check that the buffer does not contain
+ *                       any pointer to one of the internal structs of ks
  */
 static void
-key_state_free(struct key_state *ks, bool clear)
+key_state_free(struct key_state *ks, bool clear, struct buffer *to_link)
 {
+    check_keystate_buf_not_used(to_link, ks);
+
     ks->state = S_UNDEF;
 
     key_state_ssl_free(&ks->ks_ssl);
@@ -1043,11 +1056,14 @@
  *                       object should be overwritten with 0s. This
  *                       implicitly sets many states to 0/false,
  *                       e.g. the validity of the keys in the structure
+ * @param to_link      - if not NULL, check that the buffer does not contain
+ *                       any pointer to one of the internal structs of ks
  *
  */
 static void
-tls_session_free(struct tls_session *session, bool clear)
+tls_session_free(struct tls_session *session, bool clear, struct buffer *to_link)
 {
+    check_session_buf_not_used(to_link, session);
     tls_wrap_free(&session->tls_wrap);
     tls_wrap_free(&session->tls_wrap_reneg);
 
@@ -1056,7 +1072,7 @@
         /* we don't need clear=true for this call since
          * the structs are part of session and get cleared
          * as part of session */
-        key_state_free(&session->key[i], false);
+        key_state_free(&session->key[i], false, to_link);
     }
 
     free(session->common_name);
@@ -1075,14 +1091,16 @@
 
 
 static void
-move_session(struct tls_multi *multi, int dest, int src, bool reinit_src)
+move_session(struct tls_multi *multi, int dest, int src, bool reinit_src,
+             struct buffer *to_link)
 {
+    check_session_buf_not_used(to_link, &multi->session[dest]);
     msg(D_TLS_DEBUG_LOW, "TLS: move_session: dest=%s src=%s reinit_src=%d",
         session_index_name(dest), session_index_name(src), reinit_src);
     ASSERT(src != dest);
     ASSERT(src >= 0 && src < TM_SIZE);
     ASSERT(dest >= 0 && dest < TM_SIZE);
-    tls_session_free(&multi->session[dest], false);
+    tls_session_free(&multi->session[dest], false, to_link);
     multi->session[dest] = multi->session[src];
 
     if (reinit_src)
@@ -1098,9 +1116,9 @@
 }
 
 static void
-reset_session(struct tls_multi *multi, struct tls_session *session)
+reset_session(struct tls_multi *multi, struct tls_session *session, struct buffer *to_link)
 {
-    tls_session_free(session, false);
+    tls_session_free(session, false, to_link);
     tls_session_init(multi, session);
 }
 
@@ -1265,7 +1283,7 @@
 
     for (int i = 0; i < TM_SIZE; ++i)
     {
-        tls_session_free(&multi->session[i], false);
+        tls_session_free(&multi->session[i], false, NULL);
     }
 
     if (clear)
@@ -1764,13 +1782,13 @@
  * active key.
  */
 static void
-key_state_soft_reset(struct tls_session *session)
+key_state_soft_reset(struct tls_session *session, struct buffer *to_link)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];        /* primary key */
     struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
 
     ks->must_die = now + session->opt->transition_window;    /* remaining lifetime of old key */
-    key_state_free(ks_lame, false);
+    key_state_free(ks_lame, false, to_link);
     *ks_lame = *ks;
 
     key_state_init(session, ks);
@@ -1781,7 +1799,7 @@
 void
 tls_session_soft_reset(struct tls_multi *tls_multi)
 {
-    key_state_soft_reset(&tls_multi->session[TM_ACTIVE]);
+    key_state_soft_reset(&tls_multi->session[TM_ACTIVE], NULL);
 }
 
 /*
@@ -3101,13 +3119,13 @@
             session->opt->aead_usage_limit,
             ks->crypto_options.key_ctx_bi.decrypt.plaintext_blocks + ks->n_packets,
             session->opt->aead_usage_limit);
-        key_state_soft_reset(session);
+        key_state_soft_reset(session, to_link);
     }
 
     /* Kill lame duck key transition_window seconds after primary key negotiation */
     if (lame_duck_must_die(session, wakeup))
     {
-        key_state_free(ks_lame, true);
+        key_state_free(ks_lame, true, to_link);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
     }
 
@@ -3200,6 +3218,55 @@
     return false;
 }
 
+static void
+check_keystate_buf_not_used(struct buffer *to_link, const struct key_state *ks)
+{
+    if (ks->state == S_UNDEF || !to_link || !to_link->data)
+    {
+        return;
+    }
+
+    uint8_t *dataptr = to_link->data;
+
+    /* we don't expect send_reliable to be NULL when state is
+     * not S_UNDEF, but people have reported crashes nonetheless,
+     * therefore we better catch this event, report and exit.
+     */
+    if (!ks->send_reliable)
+    {
+        msg(M_FATAL,
+            "ERROR: ks.send_reliable (key-id %d), is NULL "
+            "while key state is %s. Exiting.",
+            ks->key_id, state_name(ks->state));
+    }
+
+    for (int j = 0; j < ks->send_reliable->size; j++)
+    {
+        if (ks->send_reliable->array[j].buf.data == dataptr)
+        {
+            msg(M_INFO,
+                "Warning buffer of freed TLS session is still in"
+                " use (key-id %d, ks.send_reliable->array[%d])",
+                ks->key_id, j);
+
+            goto used;
+        }
+    }
+
+    if (ks->ack_write_buf.data == dataptr)
+    {
+        msg(M_INFO, "Warning buffer of freed TLS session is still in use "
+                    "(ks.ack_write_buf, key-id %d)",
+            ks->key_id);
+
+        goto used;
+    }
+    return;
+
+used:
+    to_link->len = 0;
+    to_link->data = 0;
+}
 
 /**
  * This is a safe guard function to double check that a buffer from a session is
@@ -3211,11 +3278,11 @@
 static void
 check_session_buf_not_used(struct buffer *to_link, struct tls_session *session)
 {
-    const uint8_t *dataptr = to_link->data;
-    if (!dataptr)
+    if (!to_link || !to_link->data)
     {
         return;
     }
+    const uint8_t *dataptr = to_link->data;
 
     /* Checks buffers in tls_wrap */
     if (session->tls_wrap.work.data == dataptr)
@@ -3234,41 +3301,7 @@
     for (int i = 0; i < KS_SIZE; i++)
     {
         const struct key_state *ks = &session->key[i];
-        if (ks->state == S_UNDEF)
-        {
-            continue;
-        }
-
-        /* we don't expect send_reliable to be NULL when state is
-         * not S_UNDEF, but people have reported crashes nonetheless,
-         * therefore we better catch this event, report and exit.
-         */
-        if (!ks->send_reliable)
-        {
-            msg(M_FATAL,
-                "ERROR: session->key[%d]->send_reliable is NULL "
-                "while key state is %s. Exiting.",
-                i, state_name(ks->state));
-        }
-
-        for (int j = 0; j < ks->send_reliable->size; j++)
-        {
-            if (ks->send_reliable->array[j].buf.data == dataptr)
-            {
-                msg(M_INFO,
-                    "Warning buffer of freed TLS session is still in"
-                    " use (session->key[%d].send_reliable->array[%d])",
-                    i, j);
-
-                goto used;
-            }
-        }
-        if (ks->ack_write_buf.data == dataptr)
-        {
-            msg(M_INFO, "Warning buffer of freed TLS session is still in use (session->key[%d].ack_write_buf)", i);
-
-            goto used;
-        }
+        check_keystate_buf_not_used(to_link, ks);
     }
     return;
 
@@ -3362,13 +3395,11 @@
                 if (i == TM_ACTIVE && ks_lame->state >= S_GENERATED_KEYS
                     && !multi->opt.single_session)
                 {
-                    check_session_buf_not_used(to_link, session);
-                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);
+                    move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true, to_link);
                 }
                 else
                 {
-                    check_session_buf_not_used(to_link, session);
-                    reset_session(multi, session);
+                    reset_session(multi, session, to_link);
                 }
             }
         }
@@ -3421,7 +3452,7 @@
      */
     if (lame_duck_must_die(&multi->session[TM_LAME_DUCK], wakeup))
     {
-        tls_session_free(&multi->session[TM_LAME_DUCK], true);
+        tls_session_free(&multi->session[TM_LAME_DUCK], true, to_link);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: killed expiring key");
     }
 
@@ -3436,8 +3467,7 @@
      */
     if (TLS_AUTHENTICATED(multi, &multi->session[TM_INITIAL].key[KS_PRIMARY]))
     {
-        check_session_buf_not_used(to_link, &multi->session[TM_ACTIVE]);
-        move_session(multi, TM_ACTIVE, TM_INITIAL, true);
+        move_session(multi, TM_ACTIVE, TM_INITIAL, true, to_link);
         tas = tls_authentication_status(multi);
         msg(D_TLS_DEBUG_LOW,
             "TLS: tls_multi_process: initial untrusted "
@@ -3839,7 +3869,7 @@
                 goto error;
             }
 
-            key_state_soft_reset(session);
+            key_state_soft_reset(session, NULL);
 
             dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOFT_RESET_V1 s=%d sid=%s", i,
                  session_id_print(&sid, &gc));


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
