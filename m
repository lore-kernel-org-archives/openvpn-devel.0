Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA78CD8C9D
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5fTNtRtrEu2vtseOD0EpGI3H1j56jNqlyFMAsq2zGiI=; b=KFRcfSOFWWR6kU7mmXTJqyaElb
	MvnxghjAiEetelH3XPrM7dewzHc1HAmiQrKddaZlbiLCEjTWZWq5+n88jFWnwVILg6gUZsyfv1fs1
	lcLjh/ecEAmOEacyQOf3mzGjzThmWR7UD3opg9EZ5JrnIaWHo9yYq/zUucfq183x/nPU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWT4P-0002Yc-04;
	Mon, 08 Jun 2026 06:02:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWT4G-0002YS-Pc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 06:02:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S363IwMrXt33tmfNv4KWE4zAWEaLI2DBTZTDjXf5Xlw=; b=eYI7SXVFr3UlqoONyOw07b5BOV
 L8SuSMSv4tBPuCvNd3AX/mJvEUfZ5MOZX4RWXf/+kF4mzs4P3jvtpmx7N1Zwg7Ay/uerzNutqIj4F
 yWu3R7U7ZkaPcum2HSW++um98gbZuVuvGrHJzqrOv33nBnfRfLMr6vQ1ZS6ztF2LOEHM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=S363IwMrXt33tmfNv4KWE4zAWEaLI2DBTZTDjXf5Xlw=; b=j1gFBHADt16dZKsOLnHkiImmRd
 f6i4eJTYG19+1x4QCRsNigVI8/k2pxkKr1ubRSUlGZWcL5UTcz4nY/tWuGSpJ4op2Z6gs9qaUEbdZ
 sBqb78sSdnCdFWmOJ3g/ISVr6SUgieQ7Z47boJIdvM5gnZkooijtUMYcc99QFCcReEjQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWT4E-0006tQ-6G for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 06:02:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65862RqC009906
 for <openvpn-devel@lists.sourceforge.net>; Mon, 8 Jun 2026 08:02:27 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65862ReU009904
 for openvpn-devel@lists.sourceforge.net; Mon, 8 Jun 2026 08:02:27 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  8 Jun 2026 08:02:20 +0200
Message-ID: <20260608060227.9892-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
References: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWT4E-0006tQ-6G
Subject: [Openvpn-devel] [PATCH v1] mudp: send HMAC reset reply synchronously
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

Building a HARD_RESET reply was queueing the result into three
multi_context fields and deferring the send to the next event-loop
iteration, where multi_process_outgoing_link() flushed it:

  struct buffer hmac_reply;
  struct link_socket_actual *hmac_reply_dest;  /* aliased &m->top.c2.from */
  struct link_socket *hmac_reply_ls;

The mechanism had three latent issues:

1. hmac_reply_dest = &m->top.c2.from stored a pointer alias into
   shared mutable state.  Any subsequent read into m->top.c2.from
   silently retargeted the pending reply to a different peer.
2. m->hmac_reply_ls = sock; at the top of multi_get_create_instance_udp()
   was executed unconditionally for every UDP packet, including packets
   that did not queue a reply.  A stale queued reply could thus be sent
   on the wrong listening socket.
3. hmac_reply.data pointed into m->top.c2.buffers->aux_buf (the only
   slot).  A second send_hmac_reset_packet() before the first flush
   would overwrite the first reply's bytes.

These were latent on master because m->multi_io->udp_flags was consumed
and zeroed by the first event in each multi_io_process_io() loop, so at
most one UDP read ran per outer iteration.

Send the reply synchronously from within send_hmac_reset_packet() using
the sock that the read fired on (threaded through do_pre_decrypt_check).
The reply is small, stateless, and rate-limited by the existing
reflect_filter_rate_limit_check(); dropping on EAGAIN is acceptable
because the client retransmits its HARD_RESET.  The three multi_context
fields and the deferred-flush block in multi_process_outgoing_link() are
gone; p2mp_iow_flags() no longer needs an IOW_TO_LINK branch for hmac
state.

Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1702
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1702
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 432c79a..874736e 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -40,7 +40,7 @@
 static void
 send_hmac_reset_packet(struct multi_context *m, struct tls_pre_decrypt_state *state,
                        struct tls_auth_standalone *tas, struct session_id *sid,
-                       bool request_resend_wkc)
+                       bool request_resend_wkc, struct link_socket *sock)
 {
     reset_packet_id_send(&state->tls_wrap_tmp.opt.packet_id.send);
     state->tls_wrap_tmp.opt.packet_id.rec.initialized = true;
@@ -54,8 +54,19 @@
     ASSERT(buf_init(&c->c2.buffers->aux_buf, buf.offset));
 
     buf_copy(&c->c2.buffers->aux_buf, &buf);
-    m->hmac_reply = c->c2.buffers->aux_buf;
-    m->hmac_reply_dest = &m->top.c2.from;
+
+    /* Send synchronously: queueing across event-loop iterations would alias
+     * m->top.c2.from and aux_buf into cross-socket race territory.  The reply
+     * is small, stateless, and rate-limited by reflect_filter_rate_limit_check();
+     * dropping on EAGAIN is acceptable as the client retransmits its HARD_RESET. */
+    msg_set_prefix("Connection Attempt");
+    c->c2.to_link = c->c2.buffers->aux_buf;
+    c->c2.to_link_addr = &c->c2.from;
+    process_outgoing_link(c, sock);
+    c->c2.to_link.len = 0;
+    c->c2.to_link_addr = NULL;
+    msg_set_prefix(NULL);
+
     msg(D_MULTI_DEBUG, "Reset packet from client, sending HMAC based reset challenge");
 }
 
@@ -63,7 +74,7 @@
 /* Returns true if this packet should create a new session */
 static bool
 do_pre_decrypt_check(struct multi_context *m, struct tls_pre_decrypt_state *state,
-                     struct mroute_addr addr)
+                     struct mroute_addr addr, struct link_socket *sock)
 {
     ASSERT(m->top.c2.tls_auth_standalone);
 
@@ -106,7 +117,7 @@
             /* Calculate the session ID HMAC for our reply and create reset packet */
             struct session_id sid =
                 calculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
-            send_hmac_reset_packet(m, state, tas, &sid, true);
+            send_hmac_reset_packet(m, state, tas, &sid, true, sock);
 
             return false;
         }
@@ -139,7 +150,7 @@
         struct session_id sid =
             calculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
 
-        send_hmac_reset_packet(m, state, tas, &sid, false);
+        send_hmac_reset_packet(m, state, tas, &sid, false, sock);
 
         /* We have a reply do not create a new session */
         return false;
@@ -194,7 +205,6 @@
     struct multi_instance *mi = NULL;
     struct hash *hash = m->hash;
     real.proto = sock->info.proto;
-    m->hmac_reply_ls = sock;
 
     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true) && m->top.c2.buf.len > 0)
     {
@@ -253,7 +263,7 @@
                     "shutting down",
                     mroute_addr_print(&real, &gc));
             }
-            else if (do_pre_decrypt_check(m, &state, real))
+            else if (do_pre_decrypt_check(m, &state, real, sock))
             {
                 /* This is an unknown session but with valid tls-auth/tls-crypt
                  * (or no auth at all).  If this is the initial packet of a
@@ -321,15 +331,6 @@
     {
         multi_process_outgoing_link_dowork(m, mi, mpp_flags);
     }
-    if (m->hmac_reply_dest && m->hmac_reply.len > 0)
-    {
-        msg_set_prefix("Connection Attempt");
-        m->top.c2.to_link = m->hmac_reply;
-        m->top.c2.to_link_addr = m->hmac_reply_dest;
-        process_outgoing_link(&m->top, m->hmac_reply_ls);
-        m->hmac_reply_ls = NULL;
-        m->hmac_reply_dest = NULL;
-    }
 }
 
 /*
@@ -382,10 +383,6 @@
     {
         flags |= IOW_MBUF;
     }
-    else if (m->hmac_reply_dest)
-    {
-        flags |= IOW_TO_LINK;
-    }
     else
     {
         flags |= IOW_READ;
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3ed08d4..8b837fa 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -201,10 +201,6 @@
     struct context top; /**< Storage structure for process-wide
                          *   configuration. */
 
-    struct buffer hmac_reply;
-    struct link_socket_actual *hmac_reply_dest;
-    struct link_socket *hmac_reply_ls;
-
     /*
      * Timer object for stale route check
      */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
