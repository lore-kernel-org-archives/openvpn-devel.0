Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D23CD98E1
	for <openvpn-devel@archiver.kernel.org>; Tue, 16 Jun 2026 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E8iYdPXvulsveoukJ5nd66SX/SDGkdK2GOYlrdCeqCI=; b=f7ays04Kqmnvwpwf/ekDB5ou5T
	7Xx6+jbVtG2MJf79dqmWB7SqE6vXeE3lAbwbFItFvK0t7aamt2X+0CtRSWqvlKhD7wvPWw1fQQooD
	sP8IaxJdwH7kz0T//3Co0E0ltsUc7Y63mA97VtrriJLvUqumIY7guZm0rZtmMX7Hbldc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZWXq-0000FK-Kl;
	Tue, 16 Jun 2026 16:21:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wZWXn-0000F1-T8
 for openvpn-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 16:21:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d9CwOYFWt8eX5uYrKwKJk63fe4691paAruAZ5kZDKIE=; b=cWDTvUgWP/pWzOj8yG9sM7KsiH
 TDDErdaJZJdeo/KVaS9xiIzJnB5FMJifYtJnAmyfikssUUYXrtCFpr8oCdMFZZ7h0GeFtyNOamOem
 rkmR1D8LQtloezWMgTbyNLanIzOMl1VP3jBWZ1hQ0/0qrQIePHLqxz70P+og+K2sfGac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d9CwOYFWt8eX5uYrKwKJk63fe4691paAruAZ5kZDKIE=; b=KA2jZCDocZe/hb/SMDP31Ggp4j
 XUgDW/F6Y85DTmu/ZQqvf8lR6nnf/mLq1iOBJ4r+AfG7nZtVwqQNrK/cBdfw1pArdrODMgFBDcDB7
 CmOFaxJf/9XEJ9d/IbKsmxhDhCXvhAXfdGhdx1R9JLEA45P4B9B6vl95i+4rHKW5co3U=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZWXm-0002oi-AQ for openvpn-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 16:21:44 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65GGLU7r028546
 for <openvpn-devel@lists.sourceforge.net>; Tue, 16 Jun 2026 18:21:30 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65GGLTA1028545
 for openvpn-devel@lists.sourceforge.net; Tue, 16 Jun 2026 18:21:29 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 16 Jun 2026 18:21:23 +0200
Message-ID: <20260616162129.28519-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wZWXm-0002oi-AQ
Subject: [Openvpn-devel] [PATCH v7] Multisocket: use event engine rwflags
 for UDP I/O
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

From: Gianmarco De Gregori <gianmarco@mandelbit.com>

udp_flags does not guarantee correct association with the socket being
processed. Use the rwflags delivered by the event engine along with the
event to ensure proper per-socket I/O handling.

Remove udp_flags entirely.

Replace the previous global-style flag computation with a per-socket
decision model in p2mp_iow_flags(), which derives I/O flags
directly from the current multi_context state and the specific socket
being processed. This ensures that read/write decisions are correctly
bound to the active socket rather than shared or implicit global state.

This change is based on an investigation triggered by a report from
Joshua Rogers using ZeroPath.

Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1635
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1635
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d24f534..ab76b9e 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2030,9 +2030,8 @@
     check_timeout_random_component(c);
 }
 
-static void
-multi_io_process_flags(struct context *c, struct event_set *es, const unsigned int flags,
-                       unsigned int *out_socket, unsigned int *out_tuntap)
+void
+multi_io_process_flags(struct context *c, struct event_set *es, struct link_socket *sock, const unsigned int flags)
 {
     unsigned int socket = 0;
     unsigned int tuntap = 0;
@@ -2123,50 +2122,19 @@
      * (for TCP server sockets this happens in
      *  socket_set_listen_persistent()).
      */
-    for (int i = 0; i < c->c1.link_sockets_num; i++)
-    {
-        if ((c->options.mode != MODE_SERVER) || (proto_is_dgram(c->c2.link_sockets[i]->info.proto)))
-        {
-            socket_set(c->c2.link_sockets[i], es, socket, &c->c2.link_sockets[i]->ev_arg, NULL);
-        }
-    }
-
+    socket_set(sock, es, socket, &sock->ev_arg, NULL);
     tun_set(c->c1.tuntap, es, tuntap, (void *)tun_shift, NULL);
-
-    if (out_socket)
-    {
-        *out_socket = socket;
-    }
-
-    if (out_tuntap)
-    {
-        *out_tuntap = tuntap;
-    }
 }
 
 /*
- * Wait for I/O events.  Used for UDP sockets in
- * point-to-multipoint mode.
- */
-
-void
-get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags)
-{
-    unsigned int out_socket;
-
-    multi_io_process_flags(c, multi_io->es, flags, &out_socket, NULL);
-    multi_io->udp_flags = (out_socket << SOCKET_SHIFT);
-}
-
-/*
- * This is the core I/O wait function, used for all I/O waits except
- * for the top-level server sockets.
+ * This is the core I/O wait function, used for all I/O waits.
+ *
+ * Invoked by P2P instances in tunnel_point_to_point() or by P2MP
+ * instances within the per-client context in multi_io.c.
  */
 void
 io_wait(struct context *c, const unsigned int flags)
 {
-    unsigned int out_socket;
-    unsigned int out_tuntap;
     struct event_set_return esr[4];
 
     /* These shifts all depend on EVENT_READ and EVENT_WRITE */
@@ -2185,7 +2153,7 @@
      */
     event_reset(c->c2.event_set);
 
-    multi_io_process_flags(c, c->c2.event_set, flags, &out_socket, &out_tuntap);
+    multi_io_process_flags(c, c->c2.event_set, c->c2.link_sockets[0], flags);
 
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (c->c1.tuntap)
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 0d3e492..324c0b4 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -68,7 +68,22 @@
 
 extern counter_type link_write_bytes_global;
 
-void get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags);
+/**
+ * @brief Processes I/O flags to configure socket and TUN/TAP event monitors.
+ *
+ * Evaluates the current I/O state (`flags`) and context mode to determine
+ * which READ or WRITE events to register in the event loop.
+ *
+ * @note This function gets called from client instances from @c io_wait()
+ * and from p2mp (Point-to-multipoint) instances in @c multi_io_wait().
+ *
+ * @param c      Pointer to the core context.
+ * @param es     The event set where descriptors are registered.
+ * @param sock   The link socket to configure.
+ * @param flags  Bitmask of active I/O operation requests (e.g., @ref IOW_TO_LINK,
+ * @ref IOW_READ_TUN, @ref IOW_TO_TUN, @ref IOW_SHAPER).
+ */
+void multi_io_process_flags(struct context *c, struct event_set *es, struct link_socket *sock, const unsigned int flags);
 
 void io_wait(struct context *c, const unsigned int flags);
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index dded1ee..143a330 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -340,18 +340,17 @@
  * Process a UDP socket event.
  */
 void
-multi_process_io_udp(struct multi_context *m, struct link_socket *sock)
+multi_process_io_udp(struct multi_context *m, struct link_socket *sock, unsigned int rwflags)
 {
-    const unsigned int status = m->multi_io->udp_flags;
     const unsigned int mpp_flags = (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);
 
     /* UDP port ready to accept write */
-    if (status & SOCKET_WRITE)
+    if (rwflags & SOCKET_WRITE)
     {
         multi_process_outgoing_link(m, mpp_flags);
     }
     /* Incoming data on UDP port */
-    else if (status & SOCKET_READ)
+    else if (rwflags & SOCKET_READ)
     {
         read_incoming_link(&m->top, sock);
         if (!IS_SIG(&m->top))
@@ -359,36 +358,4 @@
             multi_process_incoming_link(m, NULL, mpp_flags, sock);
         }
     }
-
-    m->multi_io->udp_flags = ES_ERROR;
-}
-
-/*
- * Return the io_wait() flags appropriate for
- * a point-to-multipoint tunnel.
- */
-unsigned int
-p2mp_iow_flags(const struct multi_context *m)
-{
-    unsigned int flags = IOW_WAIT_SIGNAL;
-    if (m->pending)
-    {
-        if (TUN_OUT(&m->pending->context))
-        {
-            flags |= IOW_TO_TUN;
-        }
-        if (LINK_OUT(&m->pending->context))
-        {
-            flags |= IOW_TO_LINK;
-        }
-    }
-    else if (mbuf_defined(m->mbuf))
-    {
-        flags |= IOW_MBUF;
-    }
-    else
-    {
-        flags |= IOW_READ;
-    }
-    return flags;
 }
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 005ee10..6567539 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -30,9 +30,7 @@
 struct context;
 struct multi_context;
 
-unsigned int p2mp_iow_flags(const struct multi_context *m);
-
-void multi_process_io_udp(struct multi_context *m, struct link_socket *sock);
+void multi_process_io_udp(struct multi_context *m, struct link_socket *sock, unsigned int rwflags);
 /**************************************************************************/
 /**
  * Get, and if necessary create, the multi_instance associated with a
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index e6f4e9c..d8cc708 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -154,6 +154,40 @@
     }
 }
 
+/*
+ * Return the io flags appropriate for
+ * a point-to-multipoint tunnel.
+ */
+static unsigned int
+p2mp_iow_flags(const struct multi_context *m, struct link_socket *sock)
+{
+    unsigned int flags = IOW_WAIT_SIGNAL;
+
+    if (m->pending)
+    {
+        if (TUN_OUT(&m->pending->context))
+        {
+            flags |= IOW_TO_TUN;
+        }
+
+        /* If the to be processed socket happens to be the same one on the pending
+         * UDP client instance, we set that socket ready for write */
+        if (LINK_OUT(&m->pending->context) && m->pending->context.c2.link_sockets[0] == sock)
+        {
+            flags |= IOW_TO_LINK;
+        }
+    }
+    else if (mbuf_defined(m->mbuf))
+    {
+        flags |= IOW_MBUF;
+    }
+    else
+    {
+        flags |= IOW_READ;
+    }
+    return flags;
+}
+
 int
 multi_io_wait(struct multi_context *m)
 {
@@ -171,7 +205,17 @@
 
     if (has_udp_in_local_list(&m->top.options))
     {
-        get_io_flags_udp(&m->top, m->multi_io, p2mp_iow_flags(m));
+        for (int i = 0; i < m->top.c1.link_sockets_num; i++)
+        {
+            struct link_socket *sock = m->top.c2.link_sockets[i];
+
+            if ((m->top.options.mode == MODE_SERVER) && proto_is_dgram(sock->info.proto))
+            {
+                unsigned int flags = p2mp_iow_flags(m, sock);
+
+                multi_io_process_flags(&m->top, m->multi_io->es, sock, flags);
+            }
+        }
     }
 
     tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
@@ -457,7 +501,7 @@
                     }
                     else
                     {
-                        multi_process_io_udp(m, ev_arg->u.sock);
+                        multi_process_io_udp(m, ev_arg->u.sock, e->rwflags);
                         mi = m->pending;
                     }
                     /* monitor and/or handle events that are
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 6b2f59a..d6734bd 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -55,7 +55,6 @@
     int n_esr;
     int maxevents;
     unsigned int tun_rwflags;
-    unsigned int udp_flags;
 #ifdef ENABLE_MANAGEMENT
     unsigned int management_persist_flags;
 #endif


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
