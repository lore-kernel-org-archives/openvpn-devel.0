Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F16606A327
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WLhCI27t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cmtX5dht;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bjTrTvaU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fNjcRCWwOHL/ngzcgPHMQOkYR1NAdAibZmYcaebY55k=; b=WLhCI27tClOGdk
	c319bAs6aR+0HzaT2Hff14dMN9n1erMs0VMwb+RNXtnsZq3fPNB1F3A3BI75l2kDDKX7JK0Yr+oPF
	tWMjn04opEp5fyerbzDu4jz2DRNIGMjzy2iv5ZWTWo7lbzuVOlMcNw1A62xIb5CuhsTIWj30cJNqT
	VwU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGx4-000000007cz-1b9y;
	Sat, 14 Nov 2026 16:50:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSGx2-000000007cs-2C8Z for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:50:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kVGUiyOG4Z05WcrmwA7epgQzds3hvLry74xCV75TJqc=; b=cmtX5dht90lGIMwjlvrr68jhyv
 8Oa2xlBd9tJ+vYMc1ZKliBkj9n1o8855Xn7UJo5PggXptZ/hAmmKoJkWGtLIIZaNQrDivkFaeOvGn
 GA+eNy59lOaiBWRfrFwu0apffshPM9MhuyFab/R18yD0qsI5JJ0FjYCi6KYzWUHcez0U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kVGUiyOG4Z05WcrmwA7epgQzds3hvLry74xCV75TJqc=; b=bjTrTvaUQVNaJkhcbdFYNXFwly
 nKL2vwR/q4z5dfedhH+t9UcT8i2iFoOCaG4InMGMB+jjiFIot9bN+rpYAN3pQ6b9+YYeioXrTSqfD
 R9DgjtiuLiB6f5q9bzIhh4QArMjhF7VAH5fWVVFr0p+A2bstLWIw4L7ueuk66qyzghzY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSGwz-000000001Lq-1hlK for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:50:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AEGnsCl007546
 for <openvpn-devel@lists.sourceforge.net>; Sat, 14 Nov 2026 17:49:54 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEGnskW007545
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 17:49:54 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 14 Nov 2026 17:49:48 +0100
Message-ID: <20261114164953.7535-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSGwz-000000001Lq-1hlK
Subject: [Openvpn-devel] [PATCH v3] multi_io: dispatch UDP events through
 TA_SOCKET_READ/TA_SOCKET_WRITE
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

UDP socket events were handled by multi_process_io_udp() outside the
multi_io_action() state machine and re-entered it via TA_INITIAL,
running multi_process_post() twice.

Dispatch them as TA_SOCKET_READ, with mi == NULL and the socket passed
explicitly, and TA_SOCKET_WRITE, so that pending output is flushed
within the same event. Drop multi_process_io_udp(); multi_io_send_link()
has no caller left outside multi_io.c and becomes static.

TA_SOCKET_WRITE fell back to the bcast/c2c queue when there was no
pending instance, and only the queue drain at the end of
multi_io_process_io() relied on that. A UDP EVENT_WRITE would now reach
the fallback too and write a queued packet, possibly for a TCP instance,
outside the drain. Let the drain extract the packets itself with
multi_get_queue(), and make TA_SOCKET_WRITE write only output that is
already prepared: the pending instance's, or else that of mi.

Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2046
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2046
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 217b299..70ce458 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -29,7 +29,6 @@
 #include "multi.h"
 #include <inttypes.h>
 #include "forward.h"
-#include "multi_io.h"
 
 #include "memdbg.h"
 #include "ssl_pkt.h"
@@ -462,39 +461,3 @@
     ASSERT(!(mi && mi->halt));
     return mi;
 }
-
-/*
- * Send a packet to UDP socket.
- */
-static inline void
-multi_process_outgoing_link(struct multi_context *m, const unsigned int mpp_flags)
-{
-    if (m->pending)
-    {
-        multi_io_send_link(m, m->pending, mpp_flags);
-    }
-}
-
-/*
- * Process a UDP socket event.
- */
-void
-multi_process_io_udp(struct multi_context *m, struct link_socket *sock, unsigned int rwflags)
-{
-    const unsigned int mpp_flags = (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);
-
-    /* UDP port ready to accept write */
-    if (rwflags & SOCKET_WRITE)
-    {
-        multi_process_outgoing_link(m, mpp_flags);
-    }
-    /* Incoming data on UDP port */
-    else if (rwflags & SOCKET_READ)
-    {
-        read_incoming_link(&m->top, sock);
-        if (!IS_SIG(&m->top))
-        {
-            multi_process_incoming_link(m, NULL, mpp_flags, sock);
-        }
-    }
-}
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 6567539..c38d9e5 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -30,7 +30,6 @@
 struct context;
 struct multi_context;
 
-void multi_process_io_udp(struct multi_context *m, struct link_socket *sock, unsigned int rwflags);
 /**************************************************************************/
 /**
  * Get, and if necessary create, the multi_instance associated with a
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b1a648b..c41905b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2869,7 +2869,7 @@
             if (mi)
             {
                 /* continue authentication, perform NCP negotiation and send push_reply */
-                multi_io_action(m, mi, TA_INSTANCE_POST, false);
+                multi_io_action(m, mi, NULL, TA_INSTANCE_POST, false);
             }
             else
             {
@@ -4266,7 +4266,7 @@
         }
         else if (status == 0)
         {
-            multi_io_action(multi, NULL, TA_TIMEOUT, false);
+            multi_io_action(multi, NULL, NULL, TA_TIMEOUT, false);
         }
 
         MULTI_CHECK_SIG(multi);
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index a6e97af..83233d2 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -328,27 +328,24 @@
 }
 
 /*
- * Determine which instance has pending output
- * and prepare the output for sending in
- * the to_link buffer.
+ * Determine which instance has output for the
+ * link: the pending instance, or else mi itself.
  */
 static struct multi_instance *
-multi_io_write_link_pre(struct multi_context *m)
+multi_io_write_link_pre(struct multi_context *m, struct multi_instance *mi)
 {
-    struct multi_instance *mi = NULL;
-
     if (m->pending)
     {
-        mi = m->pending;
+        return m->pending;
     }
-    else if (mbuf_defined(m->mbuf))
+    if (mi && LINK_OUT(&mi->context))
     {
-        mi = multi_get_queue(m->mbuf);
+        return mi;
     }
-    return mi;
+    return NULL;
 }
 
-bool
+static bool
 multi_io_send_link(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
     bool ret = true;
@@ -381,11 +378,12 @@
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
@@ -426,7 +424,8 @@
 }
 
 static struct multi_instance *
-multi_io_dispatch(struct multi_context *m, struct multi_instance *mi, const int action)
+multi_io_dispatch(struct multi_context *m, struct multi_instance *mi, struct link_socket *sock,
+                  const int action)
 {
     const unsigned int mpp_flags = MPP_PRE_SELECT | MPP_RECORD_TOUCH;
     struct multi_instance *touched = mi;
@@ -448,21 +447,28 @@
 
         case TA_SOCKET_READ:
         case TA_SOCKET_READ_RESIDUAL:
-            ASSERT(mi);
-            ASSERT(mi->context.c2.link_sockets);
-            ASSERT(mi->context.c2.link_sockets[0]);
-            set_prefix(mi);
-            read_incoming_link(&mi->context, mi->context.c2.link_sockets[0]);
-            clear_prefix();
-            if (!IS_SIG(&mi->context))
+        {
+            struct context *c = multi_get_context(m, mi);
+
+            if (mi)
             {
-                multi_process_incoming_link(m, mi, mpp_flags, mi->context.c2.link_sockets[0]);
-                if (!IS_SIG(&mi->context))
+                ASSERT(mi->context.c2.link_sockets);
+                sock = mi->context.c2.link_sockets[0];
+                set_prefix(mi);
+            }
+            ASSERT(sock);
+            read_incoming_link(c, sock);
+            clear_prefix();
+            if (!IS_SIG(c))
+            {
+                multi_process_incoming_link(m, mi, mpp_flags, sock);
+                if (!IS_SIG(c))
                 {
-                    stream_buf_read_setup(mi->context.c2.link_sockets[0]);
+                    stream_buf_read_setup(sock);
                 }
             }
             break;
+        }
 
         case TA_TIMEOUT:
             multi_process_timeout(m, mpp_flags);
@@ -482,11 +488,11 @@
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
@@ -594,11 +600,11 @@
                     mi = ev_arg->u.mi;
                     if (e->rwflags & EVENT_WRITE)
                     {
-                        multi_io_action(m, mi, TA_SOCKET_WRITE_READY, false);
+                        multi_io_action(m, mi, NULL, TA_SOCKET_WRITE_READY, false);
                     }
                     else if (e->rwflags & EVENT_READ)
                     {
-                        multi_io_action(m, mi, TA_SOCKET_READ, false);
+                        multi_io_action(m, mi, NULL, TA_SOCKET_READ, false);
                     }
                     break;
 
@@ -613,18 +619,21 @@
                     {
                         socket_reset_listen_persistent(ev_arg->u.sock);
                         mi = multi_create_instance_tcp(m, ev_arg->u.sock);
+                        /* monitor and/or handle events that are
+                         * triggered in succession by the first one
+                         * before returning to the main loop. */
+                        if (mi)
+                        {
+                            multi_io_action(m, mi, NULL, TA_INITIAL, false);
+                        }
                     }
-                    else
+                    else if (e->rwflags & EVENT_WRITE)
                     {
-                        multi_process_io_udp(m, ev_arg->u.sock, e->rwflags);
-                        mi = m->pending;
+                        multi_io_action(m, NULL, NULL, TA_SOCKET_WRITE, false);
                     }
-                    /* monitor and/or handle events that are
-                     * triggered in succession by the first one
-                     * before returning to the main loop. */
-                    if (mi)
+                    else if (e->rwflags & EVENT_READ)
                     {
-                        multi_io_action(m, mi, TA_INITIAL, false);
+                        multi_io_action(m, NULL, ev_arg->u.sock, TA_SOCKET_READ, false);
                     }
                     break;
             }
@@ -644,11 +653,11 @@
                 {
                     if (e->rwflags & EVENT_WRITE)
                     {
-                        multi_io_action(m, NULL, TA_TUN_WRITE, false);
+                        multi_io_action(m, NULL, NULL, TA_TUN_WRITE, false);
                     }
                     else if (e->rwflags & EVENT_READ)
                     {
-                        multi_io_action(m, NULL, TA_TUN_READ, false);
+                        multi_io_action(m, NULL, NULL, TA_TUN_READ, false);
                     }
                 }
 
@@ -679,19 +688,22 @@
     multi_io->n_esr = 0;
 
     /*
-     * Drain the queued mbuf packets, datagram and TCP instances alike
+     * Drain the queued mbuf packets, datagram and TCP instances alike:
+     * multi_get_queue() prepares each one in the to_link buffer of its
+     * instance.
      */
     {
         struct multi_instance *mi;
-        while (!IS_SIG(&m->top) && (mi = mbuf_peek(m->mbuf)) != NULL)
+        while (!IS_SIG(&m->top) && (mi = multi_get_queue(m->mbuf)) != NULL)
         {
-            multi_io_action(m, mi, TA_SOCKET_WRITE, true);
+            multi_io_action(m, mi, NULL, TA_SOCKET_WRITE, true);
         }
     }
 }
 
 void
-multi_io_action(struct multi_context *m, struct multi_instance *mi, int action, bool poll)
+multi_io_action(struct multi_context *m, struct multi_instance *mi, struct link_socket *sock,
+                int action, bool poll)
 {
     bool tun_input_pending = false;
 
@@ -724,7 +736,7 @@
         /*
          * Dispatch the action
          */
-        struct multi_instance *touched = multi_io_dispatch(m, mi, action);
+        struct multi_instance *touched = multi_io_dispatch(m, mi, sock, action);
 
         /*
          * Signal received or connection
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 4d56e25..591225c 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -69,11 +69,9 @@
 
 void multi_io_process_io(struct multi_context *m);
 
-void multi_io_action(struct multi_context *m, struct multi_instance *mi, int action, bool poll);
+void multi_io_action(struct multi_context *m, struct multi_instance *mi, struct link_socket *sock,
+                     int action, bool poll);
 
 void multi_io_delete_event(struct multi_io *multi_io, event_t event);
 
-bool multi_io_send_link(struct multi_context *m, struct multi_instance *mi,
-                        const unsigned int mpp_flags);
-
 #endif /* ifndef MULTI_IO_H */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
