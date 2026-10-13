Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7E0CC6B12
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LLo8NMcolodzVmGYJBA0YFkuSx+ofHa8uKpyx22JI5Y=; b=LP8TeKf+9QBiRsdlGO679ujOx7
	IPTzVXLJ1BYPfYeRsW83JYCGMmtqKuDrUWusPudOMb7KhDqN/pwkRB9Gs+O0Avu/95hAEoRqmfyjt
	fpF+8Zb+6J0fPTw/3hP0V891hO/P+teRK6ipdA05xRScbus+ZU7K79x6a0srdQ3hkOZ0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGiRY-0005Y7-N5;
	Tue, 13 Oct 2026 19:45:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xGiRE-0005Xn-Cr
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 19:45:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J72IIEdPJisbrQclKs53RPbmuDf2wOFaH49M71YDxyo=; b=hqIh0+lps/lu35IDcA0OL2ZQaB
 AmcrTpSVUVH8sS0OSCHqEZbdk80FmuM/zMkVCqbFXOnuUDiacUQ0q+uxBGS/YeedYDqYfrIRzt00h
 0pk72Hh3Ao3p/k7kZD39lCa+3QlLNHCK4PzvdpaBT+tiJ5Vawk103NxLscfYLzdZ3IM8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=J72IIEdPJisbrQclKs53RPbmuDf2wOFaH49M71YDxyo=; b=WA6fbZDq1EJGoaIQpci3T9htDO
 9MhxZpsiCfW4geHU9bfxjEQf1Lkvgcshizrj3QGrIW2JmwtAekZGgbGLIO/wfI387JP4yhyeOt9K4
 pF9v3olmIXJZOCcb8fFrjVXh8t42fGEswmkZId1sogY/vUs3CoM9PsLQc0qjrlnpaGhk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGiRC-0002DS-D3 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 19:45:29 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69DJjJpU030689
 for <openvpn-devel@lists.sourceforge.net>; Tue, 13 Oct 2026 21:45:19 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69DJjJU0030688
 for openvpn-devel@lists.sourceforge.net; Tue, 13 Oct 2026 21:45:19 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 13 Oct 2026 21:45:13 +0200
Message-ID: <20261013194518.30653-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xGiRC-0002DS-D3
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
Tested-By: Andreas Gabriel Berbescu <aberbescu@gmail.com>
Github: openvpn/openvpn-private-issues#157
Reported-By: Haruki Oyama (Waseda University)
Github: openvpn/openvpn-private-issues#132
Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1893
Acked-by: MaxF <max@max-fillinger.net>
Message-Id: <20260903061209.12599-1-gert@greenie.muc.de>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38913.html
Signed-off-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1985
(cherry picked from commit 2a881d737b2562ee28247148160cfb60f0ba4645)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.5.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1985
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9b6cfa0..26a1b5d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -93,6 +93,14 @@
 
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
  * SSL/TLS Cipher suite name translation table
  */
@@ -989,10 +997,15 @@
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
@@ -1143,16 +1156,25 @@
  * @param session      - A pointer to the \c tls_session structure to be
  *                       cleaned up.
  * @param clear        - Whether the memory allocated for the \a session
- *                       object should be overwritten with 0s.
+ *                       object should be overwritten with 0s. This
+ *                       implicitly sets many states to 0/false,
+ *                       e.g. the validity of the keys in the structure
+ * @param to_link      - if not NULL, check that the buffer does not contain
+ *                       any pointer to one of the internal structs of ks
+ *
  */
 static void
-tls_session_free(struct tls_session *session, bool clear)
+tls_session_free(struct tls_session *session, bool clear, struct buffer *to_link)
 {
+    check_session_buf_not_used(to_link, session);
     tls_wrap_free(&session->tls_wrap);
 
     for (size_t i = 0; i < KS_SIZE; ++i)
     {
-        key_state_free(&session->key[i], false);
+        /* we don't need clear=true for this call since
+         * the structs are part of session and get cleared
+         * as part of session */
+        key_state_free(&session->key[i], false, to_link);
     }
 
     if (session->common_name)
@@ -1174,8 +1196,10 @@
 
 
 static void
-move_session(struct tls_multi *multi, int dest, int src, bool reinit_src)
+move_session(struct tls_multi *multi, int dest, int src, bool reinit_src,
+             struct buffer *to_link)
 {
+    check_session_buf_not_used(to_link, &multi->session[dest]);
     msg(D_TLS_DEBUG_LOW, "TLS: move_session: dest=%s src=%s reinit_src=%d",
         session_index_name(dest),
         session_index_name(src),
@@ -1183,7 +1207,7 @@
     ASSERT(src != dest);
     ASSERT(src >= 0 && src < TM_SIZE);
     ASSERT(dest >= 0 && dest < TM_SIZE);
-    tls_session_free(&multi->session[dest], false);
+    tls_session_free(&multi->session[dest], false, to_link);
     multi->session[dest] = multi->session[src];
 
     if (reinit_src)
@@ -1199,9 +1223,9 @@
 }
 
 static void
-reset_session(struct tls_multi *multi, struct tls_session *session)
+reset_session(struct tls_multi *multi, struct tls_session *session, struct buffer *to_link)
 {
-    tls_session_free(session, false);
+    tls_session_free(session, false, to_link);
     tls_session_init(multi, session);
 }
 
@@ -1369,7 +1393,7 @@
 
     for (int i = 0; i < TM_SIZE; ++i)
     {
-        tls_session_free(&multi->session[i], false);
+        tls_session_free(&multi->session[i], false, NULL);
     }
 
     if (clear)
@@ -2125,13 +2149,13 @@
  * active key.
  */
 static void
-key_state_soft_reset(struct tls_session *session)
+key_state_soft_reset(struct tls_session *session, struct buffer *to_link)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
     struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
 
     ks->must_die = now + session->opt->transition_window; /* remaining lifetime of old key */
-    key_state_free(ks_lame, false);
+    key_state_free(ks_lame, false, to_link);
     *ks_lame = *ks;
 
     key_state_init(session, ks);
@@ -2249,7 +2273,7 @@
          * push request, also signal that the client wants
          * to get push-reply messages without without requiring a round
          * trip for a push request message*/
-        if(session->opt->pull)
+        if (session->opt->pull)
         {
             iv_proto |= IV_PROTO_REQUEST_PUSH;
         }
@@ -2426,7 +2450,7 @@
      * NCP options are processed and we have no extra state for NCP finished.
      */
     if (session->opt->server && (session->opt->mode != MODE_SERVER
-            || multi->multi_state == CAS_SUCCEEDED))
+                                 || multi->multi_state == CAS_SUCCEEDED))
     {
         if (ks->authenticated > KS_AUTH_FALSE)
         {
@@ -2679,13 +2703,13 @@
             (int) (now - ks->established), session->opt->renegotiate_seconds,
             ks->n_bytes, session->opt->renegotiate_bytes,
             ks->n_packets, session->opt->renegotiate_packets);
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
 
@@ -3009,6 +3033,56 @@
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
+            "(ks.ack_write_buf, key-id %d)",
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
+
 /**
  * This is a safe guard function to double check that a buffer from a session is
  * not used in a session to avoid a use after free.
@@ -3019,58 +3093,24 @@
 static void
 check_session_buf_not_used(struct buffer *to_link, struct tls_session *session)
 {
-    uint8_t *dataptr = to_link->data;
-    if (!dataptr)
+    if (!to_link || !to_link->data)
     {
         return;
     }
+    const uint8_t *dataptr = to_link->data;
 
     /* Checks buffers in tls_wrap */
     if (session->tls_wrap.work.data == dataptr)
     {
         msg(M_INFO, "Warning buffer of freed TLS session is "
-                    "still in use (tls_wrap.work.data)");
+            "still in use (tls_wrap.work.data)");
         goto used;
     }
 
     for (int i = 0; i < KS_SIZE; i++)
     {
-        struct key_state *ks = &session->key[i];
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
+        const struct key_state *ks = &session->key[i];
+        check_keystate_buf_not_used(to_link, ks);
     }
     return;
 
@@ -3170,13 +3210,11 @@
                     && ks_lame->state >= S_ACTIVE
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
@@ -3191,7 +3229,7 @@
      */
     if (lame_duck_must_die(&multi->session[TM_LAME_DUCK], wakeup))
     {
-        tls_session_free(&multi->session[TM_LAME_DUCK], true);
+        tls_session_free(&multi->session[TM_LAME_DUCK], true, to_link);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: killed expiring key");
     }
 
@@ -3206,8 +3244,7 @@
      */
     if (DECRYPT_KEY_ENABLED(multi, &multi->session[TM_UNTRUSTED].key[KS_PRIMARY]))
     {
-        check_session_buf_not_used(to_link, &multi->session[TM_ACTIVE]);
-        move_session(multi, TM_ACTIVE, TM_UNTRUSTED, true);
+        move_session(multi, TM_ACTIVE, TM_UNTRUSTED, true, to_link);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: untrusted session promoted to %strusted",
             tas == TLS_AUTHENTICATION_SUCCEEDED ? "" : "semi-");
     }
@@ -3622,7 +3659,7 @@
                 goto error;
             }
 
-            key_state_soft_reset(session);
+            key_state_soft_reset(session, NULL);
 
             dmsg(D_TLS_DEBUG,
                  "TLS: received P_CONTROL_SOFT_RESET_V1 s=%d sid=%s",


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
