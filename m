Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4368606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bgveFJeu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YIx7Da0b;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eqAR8tpi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1tn/BJYp9nx+Esk6S/f3cCOEIJaZZWYB+Z9cU56FbLw=; b=bgveFJeu3Er292
	ekkgYQII1vnG6WH9Wn483wOWwLY0a64gWDLYT0QU2kDUMCo2lVGjNMygaM3emPPx6RC+BF3j4BAyP
	CLojWW2PFfhoOCqe8rSxc748h6GLBBC1tjeL/3+cortfu2K1j6WxYEcrhsdrbaPO7C9TfEqlcLovL
	Vj8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLguH-000000000zg-47CY;
	Tue, 27 Oct 2026 13:08:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xLguG-000000000zR-0NPa for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:08:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mQi+ihXEeZ5futWRsmYrp290zOj/92Zf4/li7J9Ufng=; b=YIx7Da0bTLkkmlyGS26v+/aY8W
 RXu1OkmeeBArN6FayhrQHyqlKgVHeWw+QfL/X/xpqOWjMHY5Bi6AJVIgrANmkDjiXvYRKPEhIuF4S
 b71vKDxakCQ0QMfujgtFaCQgEoZF+P8debMCRn1FX5mdIsBV5fI0RB5W6anb+aaDHJd8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mQi+ihXEeZ5futWRsmYrp290zOj/92Zf4/li7J9Ufng=; b=eqAR8tpiIw4tGJvITIi4MAsz5t
 M3mcxsX/5uUBe4rAwo0EgpKi+i3XhBLsIHx285QJa1MW6b+N/5hz0GDHKCCQYK7ggD8JfGo9EcGpm
 W9DCmu3jpCiEHNcSCKqfx3ZE0Tx6dp+PbfJLK74R2oOFN6apUFGROu5AzFWooB6GrJLg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLguE-000000006Yh-3SR5 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:07:59 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69RD7qSW002964
 for <openvpn-devel@lists.sourceforge.net>; Tue, 27 Oct 2026 14:07:52 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69RD7qqO002963
 for openvpn-devel@lists.sourceforge.net; Tue, 27 Oct 2026 14:07:52 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 27 Oct 2026 14:07:46 +0100
Message-ID: <20261027130751.2950-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793094393000.I603585c6bb4e407d0df62f4233ff2c135aa00db0@gerrit.openvpn.net>
References: <gerrit.1793094393000.I603585c6bb4e407d0df62f4233ff2c135aa00db0@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xLguE-000000006Yh-3SR5
Subject: [Openvpn-devel] [PATCH v1] mtcp: make set_global_rw_flags TCP only
 again
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

UDP sockets are shared among instances and are already set in
multi_io_wait(), so calling socket_set() on them per instance is
redundant.

On a server with two UDP and one TCP listener this saves about one
epoll_ctl() per received packet (syscalls per received packet
5.75 -> 4.61, UDP only 6.82 -> 5.28) and, at saturation, delivers
about 10% more traffic with UDP only.

Move the function back to mtcp.c as multi_tcp_set_global_rw_flags()
and skip datagram instances.

Change-Id: I603585c6bb4e407d0df62f4233ff2c135aa00db0
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2041
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2041
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index c744638..2b5c5b1 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -115,6 +115,18 @@
     multi_io->n_esr = 0;
 }
 
+void
+multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi)
+{
+    if (mi && !proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
+    {
+        mi->socket_set_called = true;
+        socket_set(mi->context.c2.link_sockets[0], m->multi_io->es,
+                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &mi->ev_arg,
+                   &mi->tcp_rwflags);
+    }
+}
+
 bool
 multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct multi_instance *mi,
                                       const unsigned int mpp_flags)
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index bb117fa..de9d7ba 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -39,6 +39,8 @@
 
 void multi_tcp_instance_specific_free(struct multi_instance *mi);
 
+void multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi);
+
 bool multi_tcp_process_outgoing_link(struct multi_context *m, bool defer,
                                      const unsigned int mpp_flags);
 
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index bb5dde58..ebee86c 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -122,28 +122,6 @@
 }
 
 void
-multi_io_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi)
-{
-    if (!mi)
-    {
-        return;
-    }
-
-    mi->socket_set_called = true;
-    if (proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
-    {
-        socket_set(mi->context.c2.link_sockets[0], m->multi_io->es, EVENT_READ,
-                   &mi->context.c2.link_sockets[0]->ev_arg, NULL);
-    }
-    else
-    {
-        socket_set(mi->context.c2.link_sockets[0], m->multi_io->es,
-                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &mi->ev_arg,
-                   &mi->tcp_rwflags);
-    }
-}
-
-void
 multi_io_free(struct multi_io *multi_io)
 {
     if (multi_io)
@@ -378,7 +356,7 @@
 
         case TA_INITIAL:
             ASSERT(mi);
-            multi_io_set_global_rw_flags(m, mi);
+            multi_tcp_set_global_rw_flags(m, mi);
             multi_process_post(m, mi, mpp_flags);
             break;
 
@@ -428,7 +406,7 @@
             }
             else
             {
-                multi_io_set_global_rw_flags(m, mi);
+                multi_tcp_set_global_rw_flags(m, mi);
             }
             break;
 
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index d6734bd..4299cba 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -68,8 +68,6 @@
 
 void multi_io_process_io(struct multi_context *m);
 
-void multi_io_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi);
-
 void multi_io_action(struct multi_context *m, struct multi_instance *mi, int action, bool poll);
 
 void multi_io_delete_event(struct multi_io *multi_io, event_t event);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
