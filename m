Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D4F606A320
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AQjN4wX/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OaNpI0GJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Jbco1d5p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=J0n5lZsgNULN/9ZAm1Ld5B+DuZKh9drSZb+1wWKj1+0=; b=AQjN4wX/PBNtNO
	2s4vlt0aUKJvbVS+3Pxv0wKs8Zg8PrwGIUahQ+QBvjKBy9xPekapPKGB0s3IhORPSveK3Dqtm3Syb
	7M3c687S5PkuXrgMxDGIwWRDowFd/lw8CSo/iFjxjLnnQD4UZ4WmB9tl/VfgTwTiDgU1sFuaZxyE9
	TEQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLgWg-000000002DK-1PKm;
	Tue, 27 Oct 2026 12:43:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xLgWe-000000002DD-3q4b for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1/sn+85iYiL982hxWrVmD/1yCKnxkRfVtgpXf7lfZbs=; b=OaNpI0GJ59JbPd0gnZB4GKLNU1
 z66AqCm1I+Fg10lm7tNA5H2Us9KBCoYBV9jNrKdv1g1BpUzcLsBvI8XoECww9nTW6O1isD1V/KtOS
 473d228QQTkMgM8ZRWR/qGXG6RN47IMsPDLor7N37QDqi4ciR7V6ki6qHxzAvHJY3/vo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1/sn+85iYiL982hxWrVmD/1yCKnxkRfVtgpXf7lfZbs=; b=Jbco1d5pEEJl5uadBj3uZYEwDJ
 /Rmm/MRqWypacPdcF69s9hFRUPRyAwGJ763FPGH9mFMtTkA3HXuSmvdt8smPc3SKRPZZ+txjq3PtN
 QYnQrehcKoBnf6o95IH/V4VYgiA0xqGVDvRXaHMA/tK77r9Q0NJC7SnHYc+mcfu93Xyg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLgWb-000000005ez-2PuN for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:43:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69RChQtR000429
 for <openvpn-devel@lists.sourceforge.net>; Tue, 27 Oct 2026 13:43:26 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69RChQ98000428
 for openvpn-devel@lists.sourceforge.net; Tue, 27 Oct 2026 13:43:26 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 27 Oct 2026 13:43:20 +0100
Message-ID: <20261027124326.413-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793094393000.Iac629903f49ad9e0e1d1891acf35e2000f31f5de@gerrit.openvpn.net>
References: <gerrit.1793094393000.Iac629903f49ad9e0e1d1891acf35e2000f31f5de@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xLgWb-000000005ez-2PuN
Subject: [Openvpn-devel] [PATCH v1] multi_io: move the link write functions
 to multi_io.c
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gianmarco De Gregori <gianmarco@mandelbit.com>

Writing an instance's to_link was spread over three files: choosing the
instance in multi_process_outgoing_link_pre() and the actual write in
multi_process_outgoing_link_dowork(), both static inline in multi.h,
and the write-or-queue logic in mtcp.c as
multi_tcp_process_outgoing_link() and
multi_tcp_process_outgoing_link_ready(), although they serve UDP
instances as well.

Move them to multi_io.c next to their callers in multi_io_dispatch(),
as multi_io_write_link_pre(), multi_io_send_link(),
multi_io_write_link() and multi_io_write_link_deferred().
multi_io_send_link() stays exported for the UDP write event handler in
mudp.c. Drop the prototype of multi_tcp_link_out_deferred(), which has
no definition.

No functional change.

Change-Id: Iac629903f49ad9e0e1d1891acf35e2000f31f5de
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2043
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2043
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 2b5c5b1..2d0af06 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -126,69 +126,3 @@
                    &mi->tcp_rwflags);
     }
 }
-
-bool
-multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct multi_instance *mi,
-                                      const unsigned int mpp_flags)
-{
-    struct mbuf_item item;
-    bool ret = true;
-    ASSERT(mi);
-
-    /* extract from queue */
-    if (mbuf_extract_item(mi->tcp_link_out_deferred, &item)) /* ciphertext IP packet */
-    {
-        dmsg(D_MULTI_TCP, "MULTI TCP: transmitting previously deferred packet");
-
-        ASSERT(mi == item.instance);
-        mi->context.c2.to_link = item.buffer->buf;
-        ret = multi_process_outgoing_link_dowork(m, mi, mpp_flags);
-        mbuf_free_buf(item.buffer);
-    }
-    return ret;
-}
-
-bool
-multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, const unsigned int mpp_flags)
-{
-    struct multi_instance *mi = multi_process_outgoing_link_pre(m);
-    bool ret = true;
-
-    if (mi)
-    {
-        if ((defer && !proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
-            || mbuf_defined(mi->tcp_link_out_deferred))
-        {
-            /* save to queue */
-            struct buffer *buf = &mi->context.c2.to_link;
-            if (BLEN(buf) > 0)
-            {
-                struct mbuf_buffer *mb = mbuf_alloc_buf(buf);
-                struct mbuf_item item;
-
-                set_prefix(mi);
-                dmsg(D_MULTI_TCP, "MULTI TCP: queuing deferred packet");
-                item.buffer = mb;
-                item.instance = mi;
-                mbuf_add_item(mi->tcp_link_out_deferred, &item);
-                mbuf_free_buf(mb);
-                buf_reset(buf);
-                ret = multi_process_post(m, mi, mpp_flags);
-                if (!ret)
-                {
-                    mi = NULL;
-                }
-                clear_prefix();
-            }
-        }
-        else
-        {
-            ret = multi_process_outgoing_link_dowork(m, mi, mpp_flags);
-            if (!ret)
-            {
-                mi = NULL;
-            }
-        }
-    }
-    return ret;
-}
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index de9d7ba..47c6308 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -41,16 +41,8 @@
 
 void multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi);
 
-bool multi_tcp_process_outgoing_link(struct multi_context *m, bool defer,
-                                     const unsigned int mpp_flags);
-
-bool multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct multi_instance *mi,
-                                           const unsigned int mpp_flags);
-
 struct multi_instance *multi_create_instance_tcp(struct multi_context *m, struct link_socket *sock);
 
-void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_instance *mi);
-
 void multi_tcp_delete_event(struct multi_io *multi_io, event_t event);
 
 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 201d756..217b299 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -29,6 +29,7 @@
 #include "multi.h"
 #include <inttypes.h>
 #include "forward.h"
+#include "multi_io.h"
 
 #include "memdbg.h"
 #include "ssl_pkt.h"
@@ -470,7 +471,7 @@
 {
     if (m->pending)
     {
-        multi_process_outgoing_link_dowork(m, m->pending, mpp_flags);
+        multi_io_send_link(m, m->pending, mpp_flags);
     }
 }
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 2d4983c..5aed191 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -294,7 +294,7 @@
  * may need updating and some follow-up action may be required.  This
  * function controls the necessary postprocessing.  It is called by many
  * other functions that handle VPN tunnel related activity, such as \c
- * multi_process_incoming_link(), \c multi_process_outgoing_link(), \c
+ * multi_process_incoming_link(), \c multi_io_write_link(), \c
  * multi_process_incoming_tun(), \c multi_io_write_tun(), and \c
  * multi_process_timeout(), among others.
  *
@@ -412,27 +412,6 @@
 #endif
 
 /*
- * Determine which instance has pending output
- * and prepare the output for sending in
- * the to_link buffer.
- */
-static inline struct multi_instance *
-multi_process_outgoing_link_pre(struct multi_context *m)
-{
-    struct multi_instance *mi = NULL;
-
-    if (m->pending)
-    {
-        mi = m->pending;
-    }
-    else if (mbuf_defined(m->mbuf))
-    {
-        mi = multi_get_queue(m->mbuf);
-    }
-    return mi;
-}
-
-/*
  * Per-client route quota management
  */
 
@@ -629,18 +608,6 @@
     (OPT_P_INSTANCE | OPT_P_INHERIT | OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG | OPT_P_ECHO \
      | OPT_P_COMP | OPT_P_SOCKFLAGS)
 
-static inline bool
-multi_process_outgoing_link_dowork(struct multi_context *m, struct multi_instance *mi,
-                                   const unsigned int mpp_flags)
-{
-    bool ret = true;
-    set_prefix(mi);
-    process_outgoing_link(&mi->context, mi->context.c2.link_sockets[0]);
-    ret = multi_process_post(m, mi, mpp_flags);
-    clear_prefix();
-    return ret;
-}
-
 /**
  * Determines if the ifconfig_push_local address falls into the range of the local
  * IP addresses of the VPN interface (ifconfig_local with ifconfig_remote_netmask)
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 164b214..ac730b4 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -346,6 +346,104 @@
     clear_prefix();
 }
 
+/*
+ * Determine which instance has pending output
+ * and prepare the output for sending in
+ * the to_link buffer.
+ */
+static struct multi_instance *
+multi_io_write_link_pre(struct multi_context *m)
+{
+    struct multi_instance *mi = NULL;
+
+    if (m->pending)
+    {
+        mi = m->pending;
+    }
+    else if (mbuf_defined(m->mbuf))
+    {
+        mi = multi_get_queue(m->mbuf);
+    }
+    return mi;
+}
+
+bool
+multi_io_send_link(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
+{
+    bool ret = true;
+    set_prefix(mi);
+    process_outgoing_link(&mi->context, mi->context.c2.link_sockets[0]);
+    ret = multi_process_post(m, mi, mpp_flags);
+    clear_prefix();
+    return ret;
+}
+
+static bool
+multi_io_write_link_deferred(struct multi_context *m, struct multi_instance *mi,
+                             const unsigned int mpp_flags)
+{
+    struct mbuf_item item;
+    bool ret = true;
+    ASSERT(mi);
+
+    /* extract from queue */
+    if (mbuf_extract_item(mi->tcp_link_out_deferred, &item)) /* ciphertext IP packet */
+    {
+        dmsg(D_MULTI_TCP, "MULTI TCP: transmitting previously deferred packet");
+
+        ASSERT(mi == item.instance);
+        mi->context.c2.to_link = item.buffer->buf;
+        ret = multi_io_send_link(m, mi, mpp_flags);
+        mbuf_free_buf(item.buffer);
+    }
+    return ret;
+}
+
+static bool
+multi_io_write_link(struct multi_context *m, bool defer, const unsigned int mpp_flags)
+{
+    struct multi_instance *mi = multi_io_write_link_pre(m);
+    bool ret = true;
+
+    if (mi)
+    {
+        if ((defer && !proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
+            || mbuf_defined(mi->tcp_link_out_deferred))
+        {
+            /* save to queue */
+            struct buffer *buf = &mi->context.c2.to_link;
+            if (BLEN(buf) > 0)
+            {
+                struct mbuf_buffer *mb = mbuf_alloc_buf(buf);
+                struct mbuf_item item;
+
+                set_prefix(mi);
+                dmsg(D_MULTI_TCP, "MULTI TCP: queuing deferred packet");
+                item.buffer = mb;
+                item.instance = mi;
+                mbuf_add_item(mi->tcp_link_out_deferred, &item);
+                mbuf_free_buf(mb);
+                buf_reset(buf);
+                ret = multi_process_post(m, mi, mpp_flags);
+                if (!ret)
+                {
+                    mi = NULL;
+                }
+                clear_prefix();
+            }
+        }
+        else
+        {
+            ret = multi_io_send_link(m, mi, mpp_flags);
+            if (!ret)
+            {
+                mi = NULL;
+            }
+        }
+    }
+    return ret;
+}
+
 static struct multi_instance *
 multi_io_dispatch(struct multi_context *m, struct multi_instance *mi, const int action)
 {
@@ -399,15 +497,15 @@
 
         case TA_SOCKET_WRITE_READY:
             ASSERT(mi);
-            multi_tcp_process_outgoing_link_ready(m, mi, mpp_flags);
+            multi_io_write_link_deferred(m, mi, mpp_flags);
             break;
 
         case TA_SOCKET_WRITE:
-            multi_tcp_process_outgoing_link(m, false, mpp_flags);
+            multi_io_write_link(m, false, mpp_flags);
             break;
 
         case TA_SOCKET_WRITE_DEFERRED:
-            multi_tcp_process_outgoing_link(m, true, mpp_flags);
+            multi_io_write_link(m, true, mpp_flags);
             break;
 
         case TA_INITIAL:
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 4299cba..c7f8f89 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -72,4 +72,7 @@
 
 void multi_io_delete_event(struct multi_io *multi_io, event_t event);
 
+bool multi_io_send_link(struct multi_context *m, struct multi_instance *mi,
+                        const unsigned int mpp_flags);
+
 #endif /* ifndef MULTI_IO_H */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
