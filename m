Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7623CCD98CE
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96oSPgE5tTd63xE6qB9C0KYFpV5Xc3OWUEGc0LkYlBo=; b=RR/YB7PxH18vSS+c4VYpd+f0PP
	8QMqIpVnC7fkqhc6BfU5e3fTC3koHPAGQysObvsZndmP3l2mNuu+UW7j9x9HUeSB3vgM6Os/pkHCp
	mDmHj0p8EL61ANKYwWrxriMt8LdOe1H8WIFLiLS4ggwd0ZXSCrIr8MxifU8r3BLaNcw4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wY2fA-00033q-FB;
	Fri, 12 Jun 2026 14:15:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wY2f9-00033k-5q
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 14:15:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iGOzsayBXO0TDLvptPX9LKGwwubOIx5agBPoAVONBME=; b=MVh2I5KBgdfoccLbqwKtHGPyGr
 73d60H+cpB40vVIvZ/zkSbpwX/GtUznX2qEMMqL/G50+njA6hge+KuQFKEc6xFWjUXH43dOI9vl1D
 xQ54Pks/LPDi8iUJFc4lqDEGk3KthekqszBbGnP3b1FFciIb2VLPyLsSiQS+Qus18sXo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iGOzsayBXO0TDLvptPX9LKGwwubOIx5agBPoAVONBME=; b=j5ikW2mSBOc3I7HNnsFuWucXgL
 J/HNw8gwcPLzwiO4SYqCB3Uc2owub386vV0rWAy9aU4mHdcjeidwHpbOpXez4v2LrhIEId0ZWgEFI
 +eeR3EoAVt8OEENmtIG8710F+NipU+vFrx8ZdSCX6fPeXNM6DYpbERzssOcLavHDWqP4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wY2f5-00026s-5e for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 14:15:11 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65CEEtCT012500
 for <openvpn-devel@lists.sourceforge.net>; Fri, 12 Jun 2026 16:14:55 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65CEEt2w012499
 for openvpn-devel@lists.sourceforge.net; Fri, 12 Jun 2026 16:14:55 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 12 Jun 2026 16:14:49 +0200
Message-ID: <20260612141455.12476-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wY2f5-00026s-5e
Subject: [Openvpn-devel] [PATCH v5] Multisocket: use event engine rwflags
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
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1635
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1635
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d24f534..f2dc2da 100644
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
@@ -2123,39 +2122,8 @@
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
-}
-
-/*
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
 }
 
 /*
@@ -2165,8 +2133,6 @@
 void
 io_wait(struct context *c, const unsigned int flags)
 {
-    unsigned int out_socket;
-    unsigned int out_tuntap;
     struct event_set_return esr[4];
 
     /* These shifts all depend on EVENT_READ and EVENT_WRITE */
@@ -2185,7 +2151,7 @@
      */
     event_reset(c->c2.event_set);
 
-    multi_io_process_flags(c, c->c2.event_set, flags, &out_socket, &out_tuntap);
+    multi_io_process_flags(c, c->c2.event_set, c->c2.link_sockets[0], flags);
 
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (c->c1.tuntap)
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 0d3e492..d4edfba 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -68,7 +68,7 @@
 
 extern counter_type link_write_bytes_global;
 
-void get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags);
+void multi_io_process_flags(struct context *c, struct event_set *es, struct link_socket *sock, const unsigned int flags);
 
 void io_wait(struct context *c, const unsigned int flags);
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 432c79a..bb89221 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -336,18 +336,17 @@
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
@@ -355,25 +354,25 @@
             multi_process_incoming_link(m, NULL, mpp_flags, sock);
         }
     }
-
-    m->multi_io->udp_flags = ES_ERROR;
 }
 
 /*
- * Return the io_wait() flags appropriate for
+ * Return the io flags appropriate for
  * a point-to-multipoint tunnel.
  */
 unsigned int
-p2mp_iow_flags(const struct multi_context *m)
+p2mp_iow_flags(const struct multi_context *m, struct link_socket *sock)
 {
     unsigned int flags = IOW_WAIT_SIGNAL;
+
     if (m->pending)
     {
         if (TUN_OUT(&m->pending->context))
         {
             flags |= IOW_TO_TUN;
         }
-        if (LINK_OUT(&m->pending->context))
+
+        if (LINK_OUT(&m->pending->context) && m->pending->context.c2.link_sockets[0] == sock)
         {
             flags |= IOW_TO_LINK;
         }
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 005ee10..dfc69b9 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -30,9 +30,9 @@
 struct context;
 struct multi_context;
 
-unsigned int p2mp_iow_flags(const struct multi_context *m);
+unsigned int p2mp_iow_flags(const struct multi_context *m, struct link_socket *sock);
 
-void multi_process_io_udp(struct multi_context *m, struct link_socket *sock);
+void multi_process_io_udp(struct multi_context *m, struct link_socket *sock, unsigned int rwflags);
 /**************************************************************************/
 /**
  * Get, and if necessary create, the multi_instance associated with a
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index e6f4e9c..1334a74 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -171,7 +171,17 @@
 
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
@@ -457,7 +467,7 @@
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
