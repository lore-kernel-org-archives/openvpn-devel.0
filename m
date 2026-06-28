Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E6BC43458
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ok5hu2BloZep3Cav6THpnZ9GiubDcBGR1HIMvCaCV0I=; b=msv0zTqTa7odeCwXeraknECRcw
	J8/fT/gXt1iMN8va1VKKXTw9/N9s3raaQAQbvlZYpdoHaDEtLSX38Bi65tpo7uCMOMJ4uOwMPpmgV
	em3zB0cRKxtWmbuinK38A3LLN9fdm0jMXmH6iE5UqFkQ3DpwZviSKtxG344wJFncG7m0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdpCd-0000pb-Du;
	Sun, 28 Jun 2026 13:05:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wdpCK-0000pG-62
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 13:05:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IhKSop+rVYaBkmFqISxExgB9YjnWo+SBviaaODoXeqY=; b=PtcTrxO5bDzs1s8H0Sap787Kn3
 ICp415GWbME8zPZytyDQlXae5c8FoqOV78UHu6vHAgYbb03Bj2KlfuCXvITo3BokF0IT19sdQEzVO
 tj1f8y7KhH6pOgciqJIgjSqR305X79AGArtHVm+fQYsahPqZRkBeS1kdidbO3Lqbdyi0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IhKSop+rVYaBkmFqISxExgB9YjnWo+SBviaaODoXeqY=; b=YASqISFcxAeSLkGEITj5GafWHS
 gixZm4MmSSQWP593MXBsssQ3OzFNhq1mYuGgoJi0Wzw1VtvuAisCGxVmjMvUe6HhdBosJQvW836mF
 y2hPwRQb4GIQXOQNj+6Q7EzMuGJx5PAIQs5gbQDTZVWhBaqik3zp8D0IgqBQrKEvQl9s=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wdpCD-0007SH-J4 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 13:05:15 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65SD52Si026117
 for <openvpn-devel@lists.sourceforge.net>; Sun, 28 Jun 2026 15:05:02 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65SD52pO026116
 for openvpn-devel@lists.sourceforge.net; Sun, 28 Jun 2026 15:05:02 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 28 Jun 2026 15:04:55 +0200
Message-ID: <20260628130500.26086-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
References: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wdpCD-0007SH-J4
Subject: [Openvpn-devel] [PATCH v3] Extract handle_connection_attempt from
 multi_get_create_instance_udp
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

The multi_get_create_instance_udp is quite large. This factors out the
one branch that handles and creates new connection attempts.

Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1720
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1720
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b1de446..7d4fee1 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -194,12 +194,81 @@
     return false;
 }
 
-/*
+/**
+ * Handles a packet if no existing session exists for this incoming packet.
+ *
+ * It will either send a reply with a hmac cookie if this is the first
+ * packet of a three-way handshake or create a multi_instance if it is a
+ * packet that completes the three-way handshake.
+ */
+static struct multi_instance *
+handle_connection_attempt(struct multi_context *m,
+                          struct link_socket *sock,
+                          struct mroute_addr *real,
+                          const uint64_t hv,
+                          struct hash_bucket *bucket)
+{
+    struct hash *hash = m->hash;
+    struct tls_pre_decrypt_state state = { 0 };
+    struct multi_instance *mi = NULL;
+    struct gc_arena gc = gc_new();
+
+    if (m->deferred_shutdown_signal.signal_received)
+    {
+        msg(D_MULTI_ERRORS,
+            "MULTI: Connection attempt from %s ignored while server is "
+            "shutting down",
+            mroute_addr_print(real, &gc));
+    }
+    else if (do_pre_decrypt_check(m, &state, *real, sock))
+    {
+        /* This is an unknown session but with valid tls-auth/tls-crypt
+         * (or no auth at all).  If this is the initial packet of a
+         * session, we just send a reply with a HMAC session id and
+         * do not generate a session slot */
+
+        if (frequency_limit_event_allowed(m->new_connection_limiter))
+        {
+            /* a successful three-way handshake only counts against
+             * connect-freq but not against connect-freq-initial */
+            reflect_filter_rate_limit_decrease(m->initial_rate_limiter);
+
+            mi = multi_create_instance(m, real, sock);
+            if (mi)
+            {
+                hash_add_fast(hash, bucket, &mi->real, hv, mi);
+                mi->did_real_hash = true;
+                multi_assign_peer_id(m, mi);
+
+                /* If we have a session id already, ensure that the
+                 * state is using the same */
+                if (session_id_defined(&state.server_session_id)
+                    && session_id_defined((&state.peer_session_id)))
+                {
+                    mi->context.c2.tls_multi->n_sessions++;
+                    struct tls_session *session =
+                        &mi->context.c2.tls_multi->session[TM_INITIAL];
+                    session_skip_to_pre_start(session, &state, &m->top.c2.from);
+                }
+            }
+        }
+        else
+        {
+            msg(D_MULTI_ERRORS,
+                "MULTI: Connection from %s would exceed new connection frequency limit as controlled by --connect-freq",
+                mroute_addr_print(real, &gc));
+        }
+    }
+    free_tls_pre_decrypt_state(&state);
+    gc_free(&gc);
+    return mi;
+}
+
+/**
  * Get a client instance based on real address.  If
  * the instance doesn't exist, create it while
  * maintaining real address hash table atomicity.
  */
-
 struct multi_instance *
 multi_get_create_instance_udp(struct multi_context *m, bool *floated, struct link_socket *sock)
 {
@@ -258,54 +327,7 @@
         /* we have no existing multi instance for this connection */
         if (!mi)
         {
-            struct tls_pre_decrypt_state state = { 0 };
-            if (m->deferred_shutdown_signal.signal_received)
-            {
-                msg(D_MULTI_ERRORS,
-                    "MULTI: Connection attempt from %s ignored while server is "
-                    "shutting down",
-                    mroute_addr_print(&real, &gc));
-            }
-            else if (do_pre_decrypt_check(m, &state, real, sock))
-            {
-                /* This is an unknown session but with valid tls-auth/tls-crypt
-                 * (or no auth at all).  If this is the initial packet of a
-                 * session, we just send a reply with a HMAC session id and
-                 * do not generate a session slot */
-
-                if (frequency_limit_event_allowed(m->new_connection_limiter))
-                {
-                    /* a successful three-way handshake only counts against
-                     * connect-freq but not against connect-freq-initial */
-                    reflect_filter_rate_limit_decrease(m->initial_rate_limiter);
-
-                    mi = multi_create_instance(m, &real, sock);
-                    if (mi)
-                    {
-                        hash_add_fast(hash, bucket, &mi->real, hv, mi);
-                        mi->did_real_hash = true;
-                        multi_assign_peer_id(m, mi);
-
-                        /* If we have a session id already, ensure that the
-                         * state is using the same */
-                        if (session_id_defined(&state.server_session_id)
-                            && session_id_defined((&state.peer_session_id)))
-                        {
-                            mi->context.c2.tls_multi->n_sessions++;
-                            struct tls_session *session =
-                                &mi->context.c2.tls_multi->session[TM_INITIAL];
-                            session_skip_to_pre_start(session, &state, &m->top.c2.from);
-                        }
-                    }
-                }
-                else
-                {
-                    msg(D_MULTI_ERRORS,
-                        "MULTI: Connection from %s would exceed new connection frequency limit as controlled by --connect-freq",
-                        mroute_addr_print(&real, &gc));
-                }
-            }
-            free_tls_pre_decrypt_state(&state);
+            mi = handle_connection_attempt(m, sock, &real, hv, bucket);
         }
 
 #ifdef ENABLE_DEBUG


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
