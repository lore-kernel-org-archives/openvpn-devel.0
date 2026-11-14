Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28694606A337
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WEkDotA0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ld+v3VLI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jiqHJhRR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0KceyEDyjRfe49zMGU1GvC6Ls1o2M2lEDbXqoSxaa9g=; b=WEkDotA0M281kU
	+0qoXCildu2gabia/amvUB1QHIecb08CvFYVqIUPbEfczmKCvWBFdhDX/KDLyFfMtV7CWNIOzsNjJ
	yw2N8r7Be1jVacU7fN13SehA07VZoyc6/0cFWw7KU1FYrNF+I38OLuyYpb9GV77VUmGd7+8y1pp97
	rMM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSH22-000000004fh-3vtW;
	Sat, 14 Nov 2026 16:55:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSH21-000000004fb-0Hsk for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:55:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bJjzIvfxN6nRJL9TYSQIqSHxuZj1sui7H2RZYg43tf8=; b=ld+v3VLIRFaFkmXc1Q3h0Btq+W
 O3Eml4251Cz/d+c403H0xHWDTIdVzpVmdkaFT53ybxrCMH2Y6cPjIabAkZPSnu/4rC4hsEXLUP5Mz
 wqEUamG4vvsRHEHwdxbnB7WYrVANte7of5VwBOD1pHkJh6D/b17RkSYsr51iRWAK5Z00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bJjzIvfxN6nRJL9TYSQIqSHxuZj1sui7H2RZYg43tf8=; b=jiqHJhRRVENQU3wECSfu3m8o4z
 +Im2GYft+cDAuCHeuskY0Kw2ZsHvxJvcg9IN/nWlg5moNsDspm9u0DsFAjopN+2uYysRmdPhsb0ve
 huMrTFZDTM7HOg2EK86ixG+U+AwX7I5m5f+298AReX2XUWAvDv8zjRUUO8Wi47Jkk2Ho=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSH20-000000001Rs-0mAq for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:55:13 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AEGt5kC008065
 for <openvpn-devel@lists.sourceforge.net>; Sat, 14 Nov 2026 17:55:05 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEGt5G1008064
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 17:55:05 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 14 Nov 2026 17:55:00 +0100
Message-ID: <20261114165505.8053-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793094393000.I4637d59ed1fba450e81518766526d934cd2902b7@gerrit.openvpn.net>
References: <gerrit.1793094393000.I4637d59ed1fba450e81518766526d934cd2902b7@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSH20-000000001Rs-0mAq
Subject: [Openvpn-devel] [PATCH v3] multi_io: replace TA_INITIAL with
 TA_INSTANCE_POST
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

TA_INITIAL is TA_INSTANCE_POST plus multi_tcp_set_global_rw_flags(),
which multi_io_post() already calls once the instance has no output
left. Use TA_INSTANCE_POST for new TCP instances too and drop
TA_INITIAL.

With UDP instances going through the state machine as well, make the
MTP_NONE branch of multi_io_post() explicitly TCP only: reading the
stream residual and re-arming the socket only make sense on a
connection-oriented socket. multi_tcp_set_global_rw_flags() is then
never called on a datagram instance, and loses its proto check.

Change-Id: I4637d59ed1fba450e81518766526d934cd2902b7
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2049
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2049
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 2d0af06..524e437 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -118,11 +118,8 @@
 void
 multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi)
 {
-    if (mi && !proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
-    {
-        mi->socket_set_called = true;
-        socket_set(mi->context.c2.link_sockets[0], m->multi_io->es,
-                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &mi->ev_arg,
-                   &mi->tcp_rwflags);
-    }
+    mi->socket_set_called = true;
+    socket_set(mi->context.c2.link_sockets[0], m->multi_io->es,
+               mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ, &mi->ev_arg,
+               &mi->tcp_rwflags);
 }
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index a6ce1d4..50c95b5 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -76,9 +76,6 @@
         case TA_TUN_WRITE:
             return "TA_TUN_WRITE";
 
-        case TA_INITIAL:
-            return "TA_INITIAL";
-
         case TA_TIMEOUT:
             return "TA_TIMEOUT";
 
@@ -435,12 +432,6 @@
             multi_io_write_link(m, mi, true, mpp_flags);
             break;
 
-        case TA_INITIAL:
-            ASSERT(mi);
-            multi_tcp_set_global_rw_flags(m, mi);
-            multi_process_post(m, mi, mpp_flags);
-            break;
-
         case TA_INSTANCE_POST:
             ASSERT(mi);
             multi_process_post(m, mi, mpp_flags);
@@ -486,13 +477,16 @@
             break;
 
         case MTP_NONE:
-            if (mi && sockets_read_residual(c))
+            if (mi && link_socket_connection_oriented(mi->context.c2.link_sockets[0]))
             {
-                newaction = TA_SOCKET_READ_RESIDUAL;
-            }
-            else
-            {
-                multi_tcp_set_global_rw_flags(m, mi);
+                if (sockets_read_residual(c))
+                {
+                    newaction = TA_SOCKET_READ_RESIDUAL;
+                }
+                else
+                {
+                    multi_tcp_set_global_rw_flags(m, mi);
+                }
             }
             break;
 
@@ -564,7 +558,7 @@
                          * before returning to the main loop. */
                         if (mi)
                         {
-                            multi_io_action(m, mi, NULL, TA_INITIAL, false);
+                            multi_io_action(m, mi, NULL, TA_INSTANCE_POST, false);
                         }
                     }
                     else if (e->rwflags & EVENT_READ)
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 591225c..e178240 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -41,10 +41,9 @@
 #define TA_SOCKET_WRITE_DEFERRED 5
 #define TA_TUN_READ              6
 #define TA_TUN_WRITE             7
-#define TA_INITIAL               8
-#define TA_TIMEOUT               9
-#define TA_TUN_WRITE_TIMEOUT     10
-#define TA_INSTANCE_POST         11
+#define TA_TIMEOUT               8
+#define TA_TUN_WRITE_TIMEOUT     9
+#define TA_INSTANCE_POST         10
 
 /*
  * I/O state and events tracker


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
