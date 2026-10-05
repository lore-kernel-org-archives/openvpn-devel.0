Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B7ACA5FF0
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9Ta/3SOyQ2I3q7K1dwH3plN5nge8ZTodtWkSMbnmow=; b=aJt3SazeD5A625GwLDGIrR58z6
	Mil4XWzK68qg5/ABJHTHRAOaf7301IE4b738UDdtKLQHVQtG4ykQ/IH0IS/ZMO1VqPYcXTA4wImiF
	EjQn8kItaJoaQhIMx80Y8QIHXpIKIDswvjtfjuh0WQZSTsdD35vnxqsAruhORv1/9XxQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDicO-0001Vx-RW;
	Mon, 05 Oct 2026 13:20:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xDicN-0001Vr-UY
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 13:20:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gxuied3QEnKTGhvU6gVekqxP6II6N0nqZlQJdtNB3YE=; b=l7vKuV1tLw1JCkWQxD/Zu8mbfe
 2EshH0QLGwnKi6i5mFc6uxxm7PMxp43N0CcrXQ03DSATb6CvNH3L03PsCmCDXp24qCEQVZD7jWPd/
 gOKemia/hmXOe+8FJkshDNIQ4Y9JeA433NsmhCU06nTSHpbzfgKyw7Bpejz5lY7u9pQs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Gxuied3QEnKTGhvU6gVekqxP6II6N0nqZlQJdtNB3YE=; b=fD/Zb2g+NbpZSxkU70zbExGOTy
 ovnoKhQL93h4b9BcB9Ew8HkFBIX/33v6nPiCUTGKxyVXhN1V6FLkH3EvyAYDxf9DGPXaAsfp4okEx
 uv9KBe/4j7aJJIRzZYvEdjKiYoIrCnMb9e2DHELxI4LQk4iue/IueTBAf8CfU5/0z8ag=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDicJ-00084x-PI for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 13:20:33 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 695DKO9f027504
 for <openvpn-devel@lists.sourceforge.net>; Mon, 5 Oct 2026 15:20:24 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 695DKOZC027503
 for openvpn-devel@lists.sourceforge.net; Mon, 5 Oct 2026 15:20:24 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  5 Oct 2026 15:20:15 +0200
Message-ID: <20261005132023.27464-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
References: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xDicJ-00084x-PI
Subject: [Openvpn-devel] [PATCH v2] multi_io: drop IOW_MBUF
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

Before the UDP and TCP server loops were merged, each drained the
bcast/mcast/client-to-client queue its own way: UDP armed EVENT_WRITE
through IOW_MBUF, TCP used the flush loop at the end of
multi_io_process_io().  The merge kept both, leaving two consumers with
different disciplines.

The queue mixes instances of both protocols and neither consumer gets to
pick: mbuf_peek() and multi_get_queue() hand back whatever sits at the
head.  The TCP side is prepared for that, testing proto_is_dgram() and
tcp_link_out_deferred before writing.  The UDP side is not: it writes
straight to the instance's own socket, so a TCP instance reaching it
skips the deferred queue that carries backpressure.

Drain the queue from the flush loop alone and drop the UDP consumer.
IOW_MBUF only existed to arm the socket for it, so it goes as well.

This leaves the queue drained from one event-driven point: the timeout
branch of tunnel_server_loop() does not reach the flush loop, so what
multi_io_action(TA_TIMEOUT) manages to queue there waits for the next
pass that has events.  Acting on the queue only when there is an event
to act on is the simpler rule, and the delay is bounded by the next
event.

Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1962
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1962
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 1604224..b97fb7a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2122,14 +2122,6 @@
     }
 
     /*
-     * outgoing bcast buffer waiting to be sent?
-     */
-    if (flags & IOW_MBUF)
-    {
-        socket |= EVENT_WRITE;
-    }
-
-    /*
      * Force wait on TUN input, even if also waiting on TCP/UDP output
      */
     if (flags & IOW_READ_TUN_FORCE)
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 324c0b4..0309725 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -58,7 +58,6 @@
 #define IOW_SHAPER         (1 << 4)
 #define IOW_CHECK_RESIDUAL (1 << 5)
 #define IOW_FRAG           (1 << 6)
-#define IOW_MBUF           (1 << 7)
 #define IOW_READ_TUN_FORCE (1 << 8)
 #define IOW_WAIT_SIGNAL    (1 << 9)
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 2b08ada..94e03d6 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -451,10 +451,9 @@
 static inline void
 multi_process_outgoing_link(struct multi_context *m, const unsigned int mpp_flags)
 {
-    struct multi_instance *mi = multi_process_outgoing_link_pre(m);
-    if (mi)
+    if (m->pending)
     {
-        multi_process_outgoing_link_dowork(m, mi, mpp_flags);
+        multi_process_outgoing_link_dowork(m, m->pending, mpp_flags);
     }
 }
 
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 51c7d31..348e424 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -177,10 +177,6 @@
             flags |= IOW_TO_LINK;
         }
     }
-    else if (mbuf_defined(m->mbuf))
-    {
-        flags |= IOW_MBUF;
-    }
     else
     {
         flags |= IOW_READ;
@@ -565,7 +561,7 @@
     multi_io->n_esr = 0;
 
     /*
-     * Process queued mbuf packets destined for TCP socket
+     * Drain the queued mbuf packets, datagram and TCP instances alike
      */
     {
         struct multi_instance *mi;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
