Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7AC60A2621
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DjaMoquK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=c2tQA2o5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iR0i2BRH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CysknWnprSccpM2dGxOkT+wTGZsSwKeoYL9MckA3G68=; b=DjaMoquKykfp6o
	wATA0XM3PJthS/QqHpHI1iQU9sIM62xKX2x9vzXcvB+qw3X/ev7lOBtjTdo1tHIah38cm8cSGFLh0
	QUFpc+Rqvz36utn03PYGLuYTUCcNtIGQ7yVYOF9VGRfmETPZw1xaPBcQwr7j2nEDQ9k5HTZ7wV8IM
	Ya8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM5Zt-000000006Sd-1O1n;
	Wed, 28 Oct 2026 15:28:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xM5Zr-000000006SW-1XX5 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:28:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/8Be/l0MlBrR5JJ4uJ9tPHwCaHcHGsoGVctLNmUPeBs=; b=c2tQA2o5hghK2KzX6CMhgWrvmz
 UsMHnQ7T1H9Iyn5nRUpH12LQtEWoy9olOQo7gHBDih1RLeHXkNM59yDgDMtuAO1OW4Wfd6XNAMppU
 4IQ4cOc9TMMeo0Bw7QyCz0946P1h3lhIDvk5dNlIN3BIw8/t8v5T7tWf3V1HFVuUfClY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/8Be/l0MlBrR5JJ4uJ9tPHwCaHcHGsoGVctLNmUPeBs=; b=iR0i2BRHTv4agwSvCFGilABEqU
 awfOAwEmi3Mjm9/tPew2KDUiLS8JuJ/R67R2HR50Lf7mG4RVUDSxdZdV1VYCNZeZbcGzsuaMUbPAi
 3EDBy92nucL+6E4RHMz2ELwCe7lgNLcF6l4Q7byVO/kyXlU3OY1nRfRAYvWJtbcSPTrs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xM5Zp-000000001m9-1O8I for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:28:35 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69SFSQtb019729
 for <openvpn-devel@lists.sourceforge.net>; Wed, 28 Oct 2026 16:28:26 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69SFSQBT019728
 for openvpn-devel@lists.sourceforge.net; Wed, 28 Oct 2026 16:28:26 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 28 Oct 2026 16:28:19 +0100
Message-ID: <20261028152825.19716-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793094393000.Ie3384ba46347801a6dea11b97cdf9edc17632c4d@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ie3384ba46347801a6dea11b97cdf9edc17632c4d@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xM5Zp-000000001m9-1O8I
Subject: [Openvpn-devel] [PATCH v1] multi: remove m->pending
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

From: Gianmarco De Gregori <gianmarco@mandelbit.com>

m->pending pointed to the instance with output still to be written. It
was set as a side effect of multi_process_post() and read back by the
multi_io_action() state machine, by p2mp_iow_flags() to arm tun and UDP
sockets for writing across event_wait(), and by the incoming functions,
which dropped the packet if it was still set.

Now that every event goes through multi_io_action() and its output is
written before returning to the main loop, nothing is ever left pending
across event_wait(). Take the instance with output from the one
dispatch touched instead, and pass it explicitly to the write functions.
Tun and UDP sockets are only armed for reading, so drop p2mp_iow_flags()
and the tun/UDP write event branches.

Change-Id: Ie3384ba46347801a6dea11b97cdf9edc17632c4d
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2048
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2048
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2841a81..b1d7713 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -575,10 +575,6 @@
     mi->n_clients_delta = 0;
 
     /* prevent dangling pointers */
-    if (m->pending == mi)
-    {
-        multi_set_pending(m, NULL);
-    }
     if (m->earliest_wakeup == mi)
     {
         m->earliest_wakeup = NULL;
@@ -3098,18 +3094,15 @@
             ret = false;
         }
     }
+#ifdef MULTI_DEBUG_EVENT_LOOP
     else
     {
-        /* continue to pend on output? */
-        multi_set_pending(m, ANY_OUT(&mi->context) ? mi : NULL);
-
-#ifdef MULTI_DEBUG_EVENT_LOOP
-        printf("POST %s[%d] to=%d lo=%d/%d w=%" PRIi64 "/%ld\n", id(mi), (int)(mi == m->pending),
+        printf("POST %s[%d] to=%d lo=%d/%d w=%" PRIi64 "/%ld\n", id(mi), (int)ANY_OUT(&mi->context),
                mi->context.c2.to_tun.len, mi->context.c2.to_link.len,
                mi->context.c2.fragment ? mi->context.c2.fragment->outgoing.len : -1,
                (int64_t)mi->context.c2.timeval.tv_sec, (long)mi->context.c2.timeval.tv_usec);
-#endif
     }
+#endif
 
     if ((flags & MPP_RECORD_TOUCH) && m->mpp_touched)
     {
@@ -3400,13 +3393,14 @@
  * data packets.
  */
 static void
-multi_process_incoming_link_data(struct multi_context *m, bool floated, struct link_socket *sock)
+multi_process_incoming_link_data(struct multi_context *m, struct multi_instance *mi, bool floated,
+                                 struct link_socket *sock)
 {
     struct link_socket_info *lsi = &sock->info;
     const uint8_t *orig_buf;
 
     /* decrypt in instance context */
-    struct context *c = &m->pending->context;
+    struct context *c = &mi->context;
 
     orig_buf = c->c2.buf.data;
     if (process_incoming_link_part1(c, lsi, floated))
@@ -3414,7 +3408,7 @@
         /* nonzero length means that we have a valid, decrypted packed */
         if (floated && c->c2.buf.len > 0)
         {
-            multi_process_float(m, m->pending, sock);
+            multi_process_float(m, mi, sock);
         }
 
         process_incoming_link_part2(c, lsi, orig_buf);
@@ -3433,7 +3427,7 @@
             c->c2.to_tun.len = 0;
         }
         /* make sure that source address is associated with this client */
-        else if (multi_get_instance_by_virtual_addr(m, &src, true) != m->pending)
+        else if (multi_get_instance_by_virtual_addr(m, &src, true) != mi)
         {
             /* IPv6 link-local address (fe80::xxx)? */
             if ((src.type & MR_ADDR_MASK) == MR_ADDR_IPV6
@@ -3458,18 +3452,18 @@
             if (mroute_flags & MROUTE_EXTRACT_MCAST)
             {
                 /* for now, treat multicast as broadcast */
-                multi_bcast(m, &c->c2.to_tun, m->pending, 0);
+                multi_bcast(m, &c->c2.to_tun, mi, 0);
             }
             else /* possible client to client routing */
             {
                 ASSERT(!(mroute_flags & MROUTE_EXTRACT_BCAST));
-                struct multi_instance *mi = multi_get_instance_by_virtual_addr(m, &dest, true);
+                struct multi_instance *dest_mi = multi_get_instance_by_virtual_addr(m, &dest, true);
 
                 /* if dest addr is a known client, route to it */
-                if (mi)
+                if (dest_mi)
                 {
                     {
-                        multi_unicast(m, &c->c2.to_tun, mi);
+                        multi_unicast(m, &c->c2.to_tun, dest_mi);
                         register_activity(c, BLEN(&c->c2.to_tun));
                     }
                     c->c2.to_tun.len = 0;
@@ -3502,23 +3496,24 @@
 
         if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
         {
-            if (multi_learn_addr(m, m->pending, &src, 0) == m->pending)
+            if (multi_learn_addr(m, mi, &src, 0) == mi)
             {
                 /* check for broadcast */
                 if (m->enable_c2c)
                 {
                     if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
                     {
-                        multi_bcast(m, &c->c2.to_tun, m->pending, vid);
+                        multi_bcast(m, &c->c2.to_tun, mi, vid);
                     }
                     else /* try client-to-client routing */
                     {
-                        struct multi_instance *mi = multi_get_instance_by_virtual_addr(m, &dest, false);
+                        struct multi_instance *dest_mi =
+                            multi_get_instance_by_virtual_addr(m, &dest, false);
 
                         /* if dest addr is a known client, route to it */
-                        if (mi)
+                        if (dest_mi)
                         {
-                            multi_unicast(m, &c->c2.to_tun, mi);
+                            multi_unicast(m, &c->c2.to_tun, dest_mi);
                             register_activity(c, BLEN(&c->c2.to_tun));
                             c->c2.to_tun.len = 0;
                         }
@@ -3550,35 +3545,27 @@
 multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance,
                             const unsigned int mpp_flags, struct link_socket *sock)
 {
+    struct multi_instance *mi = instance;
     struct context *c;
     bool ret = true;
     bool floated = false;
 
-    if (m->pending)
-    {
-        return true;
-    }
-
-    if (!instance)
+    if (!mi)
     {
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TCP/UDP -> TUN [%d]\n", BLEN(&m->top.c2.buf));
 #endif
-        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, sock));
-    }
-    else
-    {
-        multi_set_pending(m, instance);
+        mi = multi_get_create_instance_udp(m, &floated, sock);
     }
 
-    if (!m->pending)
+    if (!mi)
     {
         return true;
     }
-    set_prefix(m->pending);
+    set_prefix(mi);
 
     /* get instance context */
-    c = &m->pending->context;
+    c = &mi->context;
 
     if (!instance)
     {
@@ -3594,11 +3581,11 @@
 
     if (BLEN(&c->c2.buf) > 0)
     {
-        multi_process_incoming_link_data(m, floated, sock);
+        multi_process_incoming_link_data(m, mi, floated, sock);
     }
 
     /* postprocess and set wakeup */
-    ret = multi_process_post(m, m->pending, mpp_flags);
+    ret = multi_process_post(m, mi, mpp_flags);
 
     clear_prefix();
 
@@ -3625,11 +3612,6 @@
         printf("TUN -> TCP/UDP [%d]\n", BLEN(&m->top.c2.buf));
 #endif
 
-        if (m->pending)
-        {
-            return true;
-        }
-
         if (dev_type == DEV_TYPE_TAP && m->top.options.vlan_tagging)
         {
             vid = vlan_decapsulate(&m->top, &m->top.c2.buf);
@@ -3657,18 +3639,18 @@
             }
             else
             {
-                multi_set_pending(
-                    m, multi_get_instance_by_virtual_addr(m, &dest, dev_type == DEV_TYPE_TUN));
+                struct multi_instance *mi =
+                    multi_get_instance_by_virtual_addr(m, &dest, dev_type == DEV_TYPE_TUN);
 
-                if (m->pending)
+                if (mi)
                 {
                     /* get instance context */
-                    c = &m->pending->context;
+                    c = &mi->context;
 
-                    set_prefix(m->pending);
+                    set_prefix(mi);
 
                     {
-                        if (multi_output_queue_ready(m, m->pending))
+                        if (multi_output_queue_ready(m, mi))
                         {
                             /* transfer packet pointer from top-level context buffer to instance */
                             c->c2.buf = m->top.c2.buf;
@@ -3686,7 +3668,7 @@
                     process_incoming_tun(c, c->c2.link_sockets[0]);
 
                     /* postprocess and set wakeup */
-                    ret = multi_process_post(m, m->pending, mpp_flags);
+                    ret = multi_process_post(m, mi, mpp_flags);
 
                     clear_prefix();
                 }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 31635ba..02841af 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -206,8 +206,11 @@
     unsigned long cid_counter;
 #endif
 
-    struct multi_instance *pending;
     struct multi_instance *earliest_wakeup;
+    /* While multi_io_dispatch() runs an action, points to its local where
+     * multi_process_post() with MPP_RECORD_TOUCH stores the instance it
+     * processed.  An action post-processes at most one instance, which
+     * multi_io_action() then closes on signal or writes the output of. */
     struct multi_instance **mpp_touched;
     struct context_buffers *context_buffers;
     time_t per_second_trigger;
@@ -638,11 +641,6 @@
  */
 #define MULTI_CHECK_SIG(m) EVENT_LOOP_CHECK_SIGNAL(&(m)->top, multi_process_signal, (m))
 
-static inline void
-multi_set_pending(struct multi_context *m, struct multi_instance *mi)
-{
-    m->pending = mi;
-}
 /**
  * Assigns a peer-id to a a client and adds the instance to the
  * the instances array of the \c multi_context structure.
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 24a6918..a14978b 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -135,36 +135,6 @@
     }
 }
 
-/*
- * Return the io flags appropriate for
- * a point-to-multipoint tunnel.
- */
-static unsigned int
-p2mp_iow_flags(const struct multi_context *m, const struct link_socket *sock)
-{
-    unsigned int flags = IOW_WAIT_SIGNAL;
-
-    if (m->pending)
-    {
-        if (TUN_OUT(&m->pending->context))
-        {
-            flags |= IOW_TO_TUN;
-        }
-
-        /* If the to be processed socket happens to be the same one on the pending
-         * UDP client instance, we set that socket ready for write */
-        if (LINK_OUT(&m->pending->context) && m->pending->context.c2.link_sockets[0] == sock)
-        {
-            flags |= IOW_TO_LINK;
-        }
-    }
-    else
-    {
-        flags |= IOW_READ;
-    }
-    return flags;
-}
-
 int
 multi_io_wait(struct multi_context *m)
 {
@@ -177,7 +147,7 @@
 
         if (proto_is_dgram(sock->info.proto))
         {
-            multi_io_process_flags(&m->top, m->multi_io->es, sock, p2mp_iow_flags(m, sock));
+            multi_io_process_flags(&m->top, m->multi_io->es, sock, IOW_READ | IOW_WAIT_SIGNAL);
         }
         else if (!tuntap_is_dco_win(m->top.c1.tuntap))
         {
@@ -281,6 +251,7 @@
  * perform server-mode postprocessing.
  *
  * @param m            - The single \c multi_context structure.
+ * @param mi           - The \c multi_instance with the packet to send.
  * @param mpp_flags    - Fast I/O optimization flags.
  *
  * @return
@@ -289,12 +260,10 @@
  *  - Falls, if the \c multi_instance was closed.
  */
 static bool
-multi_io_write_tun(struct multi_context *m, const unsigned int mpp_flags)
+multi_io_write_tun(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
-    struct multi_instance *mi = m->pending;
     bool ret = true;
 
-    ASSERT(mi);
 #ifdef MULTI_DEBUG_EVENT_LOOP
     printf("%s -> TUN len=%d\n", id(mi), mi->context.c2.to_tun.len);
 #endif
@@ -310,12 +279,8 @@
  * Drop a TUN/TAP outgoing packet..
  */
 static void
-multi_io_drop_tun(struct multi_context *m, const unsigned int mpp_flags)
+multi_io_drop_tun(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
-    struct multi_instance *mi = m->pending;
-
-    ASSERT(mi);
-
     set_prefix(mi);
 
     msg(D_MULTI_ERRORS, "MULTI: Outgoing TUN queue full, dropped packet len=%d",
@@ -328,24 +293,22 @@
 }
 
 /*
- * Determine which instance has pending output
- * and prepare the output for sending in
- * the to_link buffer.
+ * Determine which instance has output for the
+ * link: mi itself, or else the next queued
+ * bcast/c2c packet, prepared in its to_link buffer.
  */
 static struct multi_instance *
-multi_io_write_link_pre(struct multi_context *m)
+multi_io_write_link_pre(struct multi_context *m, struct multi_instance *mi)
 {
-    struct multi_instance *mi = NULL;
-
-    if (m->pending)
+    if (mi && LINK_OUT(&mi->context))
     {
-        mi = m->pending;
+        return mi;
     }
-    else if (mbuf_defined(m->mbuf))
+    if (mbuf_defined(m->mbuf))
     {
-        mi = multi_get_queue(m->mbuf);
+        return multi_get_queue(m->mbuf);
     }
-    return mi;
+    return NULL;
 }
 
 static bool
@@ -381,11 +344,12 @@
 }
 
 static bool
-multi_io_write_link(struct multi_context *m, bool defer, const unsigned int mpp_flags)
+multi_io_write_link(struct multi_context *m, struct multi_instance *mi, bool defer,
+                    const unsigned int mpp_flags)
 {
-    struct multi_instance *mi = multi_io_write_link_pre(m);
     bool ret = true;
 
+    mi = multi_io_write_link_pre(m, mi);
     if (mi)
     {
         if ((defer && !proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
@@ -406,20 +370,12 @@
                 mbuf_free_buf(mb);
                 buf_reset(buf);
                 ret = multi_process_post(m, mi, mpp_flags);
-                if (!ret)
-                {
-                    mi = NULL;
-                }
                 clear_prefix();
             }
         }
         else
         {
             ret = multi_io_send_link(m, mi, mpp_flags);
-            if (!ret)
-            {
-                mi = NULL;
-            }
         }
     }
     return ret;
@@ -477,11 +433,13 @@
             break;
 
         case TA_TUN_WRITE:
-            multi_io_write_tun(m, mpp_flags);
+            ASSERT(mi);
+            multi_io_write_tun(m, mi, mpp_flags);
             break;
 
         case TA_TUN_WRITE_TIMEOUT:
-            multi_io_drop_tun(m, mpp_flags);
+            ASSERT(mi);
+            multi_io_drop_tun(m, mi, mpp_flags);
             break;
 
         case TA_SOCKET_WRITE_READY:
@@ -490,11 +448,11 @@
             break;
 
         case TA_SOCKET_WRITE:
-            multi_io_write_link(m, false, mpp_flags);
+            multi_io_write_link(m, mi, false, mpp_flags);
             break;
 
         case TA_SOCKET_WRITE_DEFERRED:
-            multi_io_write_link(m, true, mpp_flags);
+            multi_io_write_link(m, mi, true, mpp_flags);
             break;
 
         case TA_INITIAL:
@@ -629,10 +587,6 @@
                             multi_io_action(m, mi, NULL, TA_INITIAL, false);
                         }
                     }
-                    else if (e->rwflags & EVENT_WRITE)
-                    {
-                        multi_io_action(m, NULL, NULL, TA_SOCKET_WRITE, false);
-                    }
                     else if (e->rwflags & EVENT_READ)
                     {
                         multi_io_action(m, NULL, ev_arg->u.sock, TA_SOCKET_READ, false);
@@ -653,11 +607,7 @@
                 /* incoming data on TUN? */
                 if (e->arg == MULTI_IO_TUN)
                 {
-                    if (e->rwflags & EVENT_WRITE)
-                    {
-                        multi_io_action(m, NULL, NULL, TA_TUN_WRITE, false);
-                    }
-                    else if (e->rwflags & EVENT_READ)
+                    if (e->rwflags & EVENT_READ)
                     {
                         multi_io_action(m, NULL, NULL, TA_TUN_READ, false);
                     }
@@ -749,17 +699,17 @@
                 mi = NULL;
             }
             multi_close_instance_on_signal(m, touched);
+            touched = NULL;
         }
 
-
         /*
-         * If dispatch produced any pending output
-         * for a particular instance, point to
-         * that instance.
+         * touched is the only instance this action
+         * post-processed: having closed it above if
+         * it was signalled, write its output if any.
          */
-        if (m->pending)
+        if (touched && ANY_OUT(&touched->context))
         {
-            mi = m->pending;
+            mi = touched;
         }
 
         /*


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
