Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C40CC88E75
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=19Bs2Iw8v7p3uZctTnxHBwyOtReLGSlbqgbRoERdSIQ=; b=ip3RafIjEsoVR4kIRd0BrHuxjT
	rkwr3pukV5P/kgjlEVnJ8p0h1PAuS6EHx8psdVbhFBQvHvwBz5K8n2ibrlP6g8GYtKGOtSOj884Kj
	lZyINIDgvBfCZUw8ZsIujSVkTLm9JutGfWFufDUIzuvn/fOdYk1ZmQwBhp83iq4LGgAY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6WBS-0004AV-VE;
	Tue, 15 Sep 2026 16:39:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x6WBR-0004AO-Kf
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:39:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y38S8YptZAmD25uDvwoFOD/1V6Zd8A7UsfgYRvykmDU=; b=X1YoGywz/1urOv/DF4Og+Ox/+6
 0h/3Isnh0PWPmrF9zqrJUOTHFr6VZ/9Zw3cLBjHDLO/rADKOv0gasYTlrDmhJQd2OWRReiWG0O1Cd
 KDGGIe22HLdQ04wb6Y3pCXuawjrUAWPSTuJtC4QBIm0waO9pnw7+BcPHrTKJuZ0izR34=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y38S8YptZAmD25uDvwoFOD/1V6Zd8A7UsfgYRvykmDU=; b=mZTBI/lz+tRNrgOoFmPFBmdgTg
 E+3yQZ/8Q7lXLi/9cuKhUz0T62TaFUcAI47fKJg4mtO/EPysIXPfF4Qw5cLJgZZhltz+pBi9LpNRU
 Wlh4uTA51Saq3kD6vq2mnxKlJwpl/EbffbuFwuaeq9LIe6zo7miQdP0jZa3E5Xy9FtBo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6WBQ-00014P-Ms for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:39:02 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68FGcrRG003504
 for <openvpn-devel@lists.sourceforge.net>; Tue, 15 Sep 2026 18:38:53 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68FGcrP3003503
 for openvpn-devel@lists.sourceforge.net; Tue, 15 Sep 2026 18:38:53 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 15 Sep 2026 18:38:47 +0200
Message-ID: <20260915163852.3477-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x6WBQ-00014P-Ms
Subject: [Openvpn-devel] [PATCH v10] Make required action returned from
 pre_decrypt_verdict more explicit
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

The current code relies on the condition if state.server_session_id
is defined to decide if session_skip_to_pre_start should be used.

Instead explicitly return the intent and use that to decide if
session_skip_to_pre_start should be called.

Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1826
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1826
This mail reflects revision 10 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index de3d467..88b0091 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -87,9 +87,28 @@
                           "Reset packet from client, sending HMAC based reset challenge", sock);
 }
 
+/**
+ * Verdict if this packet should create a new session. If a packet is invalid
+ * or we send out an HMAC based challenge, we do not want to create a new
+ * session.
+ */
+enum pre_decrypt_verdict
+{
+    /** This packet should not create a new session */
+    PRE_DECRYPT_NO_ACTION,
+    /** This packet creates a new session on the first packet on the session.
+     * We only do this for legacy tls-crypt-v2 clients that do not work with
+     * the HMAC cookie challenge approach where we need to keep the client
+     * specific tls-crypt key to be able to decrypt the third packet */
+    PRE_DECRYPT_CREATE_SESSION,
+    /** Creates a new session. The HMAC challenge has been already completed
+     * and the first two packets of the three way handshake are skipped in
+     * the session setup */
+    PRE_DECRYPT_CREATE_SESSION_SKIP
+};
 
-/* Returns true if this packet should create a new session */
-static bool
+/** Returns a verdict if this packet should create a new session */
+static enum pre_decrypt_verdict
 do_pre_decrypt_check(struct multi_context *m, struct tls_pre_decrypt_state *state,
                      struct mroute_addr addr, struct link_socket *sock)
 {
@@ -111,7 +130,7 @@
          * responses */
         if (!reflect_filter_rate_limit_check(m->initial_rate_limiter))
         {
-            return false;
+            return PRE_DECRYPT_NO_ACTION;
         }
     }
 
@@ -136,7 +155,7 @@
                 calculate_session_id_hmac(state->peer_session_id, from, hmac_key, handwindow, 0);
             send_hmac_reset_packet(m, state, tas, &sid, true, sock);
 
-            return false;
+            return PRE_DECRYPT_NO_ACTION;
         }
         else
         {
@@ -153,11 +172,11 @@
                     "ignoring connection attempt from old client (%s)",
                     peer);
                 gc_free(&gc);
-                return false;
+                return PRE_DECRYPT_NO_ACTION;
             }
             else
             {
-                return true;
+                return PRE_DECRYPT_CREATE_SESSION;
             }
         }
     }
@@ -170,7 +189,7 @@
         send_hmac_reset_packet(m, state, tas, &sid, false, sock);
 
         /* We have a reply do not create a new session */
-        return false;
+        return PRE_DECRYPT_NO_ACTION;
     }
     else if (verdict == VERDICT_VALID_CONTROL_V1 || verdict == VERDICT_VALID_ACK_V1
              || verdict == VERDICT_VALID_WKC_V1)
@@ -181,6 +200,7 @@
 
         bool pkt_is_ack = (verdict == VERDICT_VALID_ACK_V1);
         bool ret = check_session_hmac_and_pkt_id(state, from, hmac_key, handwindow, pkt_is_ack);
+        enum pre_decrypt_verdict action = PRE_DECRYPT_NO_ACTION;
 
         const char *peer = print_link_socket_actual(&m->top.c2.from, &gc);
         uint8_t pkt_firstbyte = *BPTR(&m->top.c2.buf);
@@ -198,14 +218,15 @@
                 "Valid packet (%s) with HMAC challenge from peer (%s), "
                 "accepting new connection.",
                 packet_opcode_name(op), peer);
+            action = PRE_DECRYPT_CREATE_SESSION_SKIP;
         }
         gc_free(&gc);
 
-        return ret;
+        return action;
     }
 
     /* VERDICT_INVALID */
-    return false;
+    return PRE_DECRYPT_NO_ACTION;
 }
 
 /**
@@ -220,9 +241,6 @@
                           struct link_socket *sock,
                           struct mroute_addr *real)
 {
-    struct hash *hash = m->hash;
-    struct tls_pre_decrypt_state state = { 0 };
-    struct multi_instance *mi = NULL;
     struct gc_arena gc = gc_new();
 
     if (m->deferred_shutdown_signal.signal_received)
@@ -231,8 +249,17 @@
             "MULTI: Connection attempt from %s ignored while server is "
             "shutting down",
             mroute_addr_print(real, &gc));
+        gc_free(&gc);
+        return NULL;
     }
-    else if (do_pre_decrypt_check(m, &state, *real, sock))
+
+    struct hash *hash = m->hash;
+    struct tls_pre_decrypt_state state = { 0 };
+    struct multi_instance *mi = NULL;
+
+    enum pre_decrypt_verdict verdict = do_pre_decrypt_check(m, &state, *real, sock);
+
+    if (verdict != PRE_DECRYPT_NO_ACTION)
     {
         /* This is an unknown session but with valid tls-auth/tls-crypt
          * (or no auth at all).  If this is the initial packet of a
@@ -255,14 +282,14 @@
                 mi->did_real_hash = true;
                 multi_assign_peer_id(m, mi);
 
-                /* If we have a session id already, ensure that the
-                 * state is using the same */
-                if (session_id_defined(&state.server_session_id)
-                    && session_id_defined((&state.peer_session_id)))
+                struct tls_session *session =
+                    &mi->context.c2.tls_multi->session[TM_INITIAL];
+
+                if (verdict == PRE_DECRYPT_CREATE_SESSION_SKIP)
                 {
+                    /* This verdict is only possible if we have a peer session ID */
+                    ASSERT(session_id_defined(&state.peer_session_id));
                     mi->context.c2.tls_multi->n_sessions++;
-                    struct tls_session *session =
-                        &mi->context.c2.tls_multi->session[TM_INITIAL];
                     session_skip_to_pre_start(session, &state, &m->top.c2.from);
                 }
             }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
