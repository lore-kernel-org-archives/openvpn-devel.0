Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAA606A323
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SrpEK5An;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CR4hhoqI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iJJjsWK8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PlNqoS69GNYhFPoIDjQu0FRbpAfafabW1e2Zn/yB3UM=; b=SrpEK5An9e3z4u
	AfuhlqQkQ7sCPuIClRC3+uy1NIlMZz/FbS6oaV9bJcrNQUwc1t2/4oqU/AjKUDV/t2n+Vj2x3JpTO
	luIBlcLk0AjRZ1u9fZbbP/9YLMa4YVEhgVNKRM9wUVHqM/rseyGoBoIe8V+yZ25cr/NZEfYpXelGv
	HIQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSH1T-000000004c6-33r7;
	Sat, 14 Nov 2026 16:54:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSH1R-000000004bz-2Fmu for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qw7ym8ZzCHEXYITpTz9MNhChTCXYiRZA81B+ZGXk5lo=; b=CR4hhoqIBtk+Alz9AnqjFaHX/0
 qXYWCuK51AvO5Mbfn9vlR/UZvle16TAVy9Z5y/zxxqDHAqTzK/YV/YYsZ9LIQAuK0TQWPTgSlIdgz
 Lwq9nrx+dFkw+KTi3yH3eV6EfFV/0YiaULFxuAzh3iSgtMQoJTRy4RPUvf/TV1coh86I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qw7ym8ZzCHEXYITpTz9MNhChTCXYiRZA81B+ZGXk5lo=; b=iJJjsWK8f0ZcAzjnGM/MIUhLF7
 iHmRd6GhodhoyHY3Z8QtWcb1W4pKRcmxWMYzspfwtQ5WUXLh0IMfqbo9P66hdmLR6x8ZAjbh2421K
 VO7kuNYyK8mTlwbhRWIXCaYZTLVaGqY3WrdI9vffZVYIMndTqzqXtzwpINitofQEHVSI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSH1Q-000000001R3-15fP for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:54:37 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AEGsTJH007983
 for <openvpn-devel@lists.sourceforge.net>; Sat, 14 Nov 2026 17:54:29 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEGsTFF007982
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 17:54:29 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 14 Nov 2026 17:54:23 +0100
Message-ID: <20261114165429.7967-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793094393000.Ie755169bb32da856e941a214f43fbb243b768d75@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ie755169bb32da856e941a214f43fbb243b768d75@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSH1Q-000000001R3-15fP
Subject: [Openvpn-devel] [PATCH v3] multi: drop MPP_CLOSE_ON_SIGNAL
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

The UDP path, the last user of MPP_CLOSE_ON_SIGNAL, now goes through
multi_io_action(), which closes the signalled instance itself. Without
the flag multi_process_post() always returns true, and the functions
that only passed its result along return a value nobody reads.

Drop the flag and make multi_process_post(), the incoming and timeout
processing functions and the static write functions of multi_io.c
return void. The check of the multi_process_post() result in
multi_create_instance() could never fail and goes away as well.

Change-Id: Ie755169bb32da856e941a214f43fbb243b768d75
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2051
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2051
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2a4f78b..05bdf91 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -778,11 +778,7 @@
     mi->inotify_watch = -1;
 #endif
 
-    if (!multi_process_post(m, mi, MPP_PRE_SELECT))
-    {
-        msg(D_MULTI_ERRORS, "MULTI: signal occurred during client instance initialization");
-        goto err;
-    }
+    multi_process_post(m, mi, MPP_PRE_SELECT);
 
     mi->ev_arg.type = EVENT_ARG_MULTI_INSTANCE;
     mi->ev_arg.u.mi = mi;
@@ -3033,14 +3029,10 @@
  * Figure instance-specific timers, convert
  * earliest to absolute time in mi->wakeup,
  * call scheduler with our future wakeup time.
- *
- * Also close context on signal.
  */
-bool
+void
 multi_process_post(struct multi_context *m, struct multi_instance *mi, const unsigned int flags)
 {
-    bool ret = true;
-
     if (!IS_SIG(&mi->context)
         && ((flags & MPP_PRE_SELECT)))
     {
@@ -3098,16 +3090,8 @@
         }
     }
 
-    if (IS_SIG(&mi->context))
-    {
-        if (flags & MPP_CLOSE_ON_SIGNAL)
-        {
-            multi_close_instance_on_signal(m, mi);
-            ret = false;
-        }
-    }
 #ifdef MULTI_DEBUG_EVENT_LOOP
-    else
+    if (!IS_SIG(&mi->context))
     {
         printf("POST %s[%d] to=%d lo=%d/%d w=%" PRIi64 "/%ld\n", id(mi), (int)ANY_OUT(&mi->context),
                mi->context.c2.to_tun.len, mi->context.c2.to_link.len,
@@ -3120,8 +3104,6 @@
     {
         *m->mpp_touched = mi;
     }
-
-    return ret;
 }
 
 /**
@@ -3554,13 +3536,12 @@
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,
  * i.e. client -> server direction.
  */
-bool
+void
 multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance,
                             const unsigned int mpp_flags, struct link_socket *sock)
 {
     struct multi_instance *mi = instance;
     struct context *c;
-    bool ret = true;
     bool floated = false;
 
     if (!mi)
@@ -3573,7 +3554,7 @@
 
     if (!mi)
     {
-        return true;
+        return;
     }
     set_prefix(mi);
 
@@ -3598,22 +3579,18 @@
     }
 
     /* postprocess and set wakeup */
-    ret = multi_process_post(m, mi, mpp_flags);
+    multi_process_post(m, mi, mpp_flags);
 
     clear_prefix();
-
-    return ret;
 }
 
 /*
  * Process packets in the TUN/TAP interface -> TCP/UDP socket direction,
  * i.e. server -> client direction.
  */
-bool
+void
 multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags)
 {
-    bool ret = true;
-
     if (BLEN(&m->top.c2.buf) > 0)
     {
         unsigned int mroute_flags;
@@ -3630,7 +3607,7 @@
             vid = vlan_decapsulate(&m->top, &m->top.c2.buf);
             if (vid < 0)
             {
-                return false;
+                return;
             }
         }
 
@@ -3681,14 +3658,13 @@
                     process_incoming_tun(c, c->c2.link_sockets[0]);
 
                     /* postprocess and set wakeup */
-                    ret = multi_process_post(m, mi, mpp_flags);
+                    multi_process_post(m, mi, mpp_flags);
 
                     clear_prefix();
                 }
             }
         }
     }
-    return ret;
 }
 
 /*
@@ -3731,11 +3707,9 @@
  * Called when an I/O wait times out.  Usually means that a particular
  * client instance object needs timer-based service.
  */
-bool
+void
 multi_process_timeout(struct multi_context *m, const unsigned int mpp_flags)
 {
-    bool ret = true;
-
 #ifdef MULTI_DEBUG_EVENT_LOOP
     printf("%s -> TIMEOUT\n", id(m->earliest_wakeup));
 #endif
@@ -3752,12 +3726,11 @@
         else
         {
             set_prefix(m->earliest_wakeup);
-            ret = multi_process_post(m, m->earliest_wakeup, mpp_flags);
+            multi_process_post(m, m->earliest_wakeup, mpp_flags);
             clear_prefix();
         }
         m->earliest_wakeup = NULL;
     }
-    return ret;
 }
 
 /*
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 305208a..9d0fa85 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -284,11 +284,10 @@
 
 void multi_close_instance(struct multi_context *m, struct multi_instance *mi, bool shutdown);
 
-bool multi_process_timeout(struct multi_context *m, const unsigned int mpp_flags);
+void multi_process_timeout(struct multi_context *m, const unsigned int mpp_flags);
 
-#define MPP_PRE_SELECT      (1 << 0)
-#define MPP_CLOSE_ON_SIGNAL (1 << 1)
-#define MPP_RECORD_TOUCH    (1 << 2)
+#define MPP_PRE_SELECT   (1 << 0)
+#define MPP_RECORD_TOUCH (1 << 2)
 
 
 /**************************************************************************/
@@ -307,13 +306,8 @@
  * @param mi           - The \c multi_instance of the VPN tunnel to be
  *                       postprocessed.
  * @param flags        - Fast I/O optimization flags.
- *
- * @return
- *  - True, if the VPN tunnel instance \a mi was not closed due to a
- *    signal during processing.
- *  - False, if the VPN tunnel instance \a mi was closed.
  */
-bool multi_process_post(struct multi_context *m, struct multi_instance *mi,
+void multi_process_post(struct multi_context *m, struct multi_instance *mi,
                         const unsigned int flags);
 
 /**
@@ -347,7 +341,7 @@
  * @param mpp_flags    - Fast I/O optimization flags.
  * @param sock         - Socket where the packet was received.
  */
-bool multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance,
+void multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance,
                                  const unsigned int mpp_flags, struct link_socket *sock);
 
 
@@ -366,7 +360,7 @@
  * @param m            - The single \c multi_context structure.
  * @param mpp_flags    - Fast I/O optimization flags.
  */
-bool multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags);
+void multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags);
 
 
 struct multi_instance *multi_get_queue(struct mbuf_set *ms);
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 2a88356d..30676ce 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -253,26 +253,18 @@
  * @param m            - The single \c multi_context structure.
  * @param mi           - The \c multi_instance with the packet to send.
  * @param mpp_flags    - Fast I/O optimization flags.
- *
- * @return
- *  - True, if the \c multi_instance associated with the packet sent was
- *    not closed due to a signal during processing.
- *  - Falls, if the \c multi_instance was closed.
  */
-static bool
+static void
 multi_io_write_tun(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
-    bool ret = true;
-
 #ifdef MULTI_DEBUG_EVENT_LOOP
     printf("%s -> TUN len=%d\n", id(mi), mi->context.c2.to_tun.len);
 #endif
     set_prefix(mi);
     vlan_process_outgoing_tun(m, mi);
     process_outgoing_tun(&mi->context, mi->context.c2.link_sockets[0]);
-    ret = multi_process_post(m, mi, mpp_flags);
+    multi_process_post(m, mi, mpp_flags);
     clear_prefix();
-    return ret;
 }
 
 /*
@@ -292,23 +284,20 @@
     clear_prefix();
 }
 
-static bool
+static void
 multi_io_send_link(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
-    bool ret = true;
     set_prefix(mi);
     process_outgoing_link(&mi->context, mi->context.c2.link_sockets[0]);
-    ret = multi_process_post(m, mi, mpp_flags);
+    multi_process_post(m, mi, mpp_flags);
     clear_prefix();
-    return ret;
 }
 
-static bool
+static void
 multi_io_write_link_deferred(struct multi_context *m, struct multi_instance *mi,
                              const unsigned int mpp_flags)
 {
     struct mbuf_item item;
-    bool ret = true;
     ASSERT(mi);
 
     /* extract from queue */
@@ -318,18 +307,15 @@
 
         ASSERT(mi == item.instance);
         mi->context.c2.to_link = item.buffer->buf;
-        ret = multi_io_send_link(m, mi, mpp_flags);
+        multi_io_send_link(m, mi, mpp_flags);
         mbuf_free_buf(item.buffer);
     }
-    return ret;
 }
 
-static bool
+static void
 multi_io_write_link(struct multi_context *m, struct multi_instance *mi, bool defer,
                     const unsigned int mpp_flags)
 {
-    bool ret = true;
-
     if (mi && LINK_OUT(&mi->context))
     {
         if ((defer && !proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
@@ -349,16 +335,15 @@
                 mbuf_add_item(mi->tcp_link_out_deferred, &item);
                 mbuf_free_buf(mb);
                 buf_reset(buf);
-                ret = multi_process_post(m, mi, mpp_flags);
+                multi_process_post(m, mi, mpp_flags);
                 clear_prefix();
             }
         }
         else
         {
-            ret = multi_io_send_link(m, mi, mpp_flags);
+            multi_io_send_link(m, mi, mpp_flags);
         }
     }
-    return ret;
 }
 
 static struct multi_instance *


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
