Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F7A606A323
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=S92bj/b0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lMPArPiT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QCPlaFIA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DGryAC98/gYF/35Tzziei3LT/BMUG3yg5l/lznGUTrI=; b=S92bj/b0fD0zUL
	KmiQZUhfjqz+iHIsnMmEk7WH22MI0QKqyrT8O6TsnX7GSNrZgxwNsftRo/dVY0wMo1IMcjARtnzcg
	C+XEifv6bYtN4i/e7u3G1jLh1hAbCixRm/WMnxp8B6AZ0AeC7YR3n2PjNr/9gjh8HWMyVWTRJTMSg
	gf8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGyz-000000007Mb-2L5r;
	Sat, 14 Nov 2026 16:52:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSGyy-000000007MU-22C7 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:52:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sfKKUZ7sa1G9yLhPlwtIyOSvz6GgYgEpBZQflARF2qo=; b=lMPArPiThpa/AayOVlpYTSssDG
 CYmBQlELS8dc/SzgGpADs3p5Tr6T7+XkOufDSKzD/UPeokTv6lRQzQaJ8nCujyj/JCuar1uVH5s8s
 fol0fEYuAn+vXb0bSxlyUbMIxIZfiBLDuW8ZFtQmdvBlxvcw5XjdRTwI73CGtVnDCuTc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sfKKUZ7sa1G9yLhPlwtIyOSvz6GgYgEpBZQflARF2qo=; b=QCPlaFIAwK6zNvyWDZrdmlcsG2
 /UiYAP9yJ3lh7UWKPI01vEYhT2TyKCnXWPGGni1V2sN/75dbWjlHe/WrBlMGLnjwmiQhr6hnzAJ5i
 YXgrDjMW3vR4gIp7Pr//xtv971JzTIoxKwHFVOmfmZ0aTQj4Me3CK5iBDbttRwtRTwNY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSGyx-000000001Oo-2ed8 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:52:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AEGpvL5007755
 for <openvpn-devel@lists.sourceforge.net>; Sat, 14 Nov 2026 17:51:57 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEGpvpV007754
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 17:51:57 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 14 Nov 2026 17:51:51 +0100
Message-ID: <20261114165156.7743-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793094393000.I49777902951d3a05c48cddd0d33c14e028e5d706@gerrit.openvpn.net>
References: <gerrit.1793094393000.I49777902951d3a05c48cddd0d33c14e028e5d706@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSGyx-000000001Oo-2ed8
Subject: [Openvpn-devel] [PATCH v3] multi: resume deferred auth through
 multi_io_action()
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

multi_process_file_closed() is the last place where multi_process_post()
runs without a multi_io_action() following it, so any output it produces
stays in m->pending across event_wait().

Add TA_INSTANCE_POST, which only runs multi_process_post() on the given
instance, and use it so pending output is flushed as for every other
event. Likewise, an instance signalled during this post-processing is
now closed right away instead of on its next event. This is needed
before m->pending can be removed.

Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d706
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2047
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2047
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3f82052..b1a648b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2841,7 +2841,7 @@
  * (or be deferred again by client-connect)
  */
 void
-multi_process_file_closed(struct multi_context *m, const unsigned int mpp_flags)
+multi_process_file_closed(struct multi_context *m)
 {
     char buffer[INOTIFY_EVENT_BUFFER_SIZE];
     ssize_t buffer_i = 0;
@@ -2869,7 +2869,7 @@
             if (mi)
             {
                 /* continue authentication, perform NCP negotiation and send push_reply */
-                multi_process_post(m, mi, mpp_flags);
+                multi_io_action(m, mi, TA_INSTANCE_POST, false);
             }
             else
             {
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3d2e932..4a93971 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -382,9 +382,8 @@
  * Continues authentication and sends push_repl
  *
  * @param m multi_context
- * @param mpp_flags
  */
-void multi_process_file_closed(struct multi_context *m, const unsigned int mpp_flags);
+void multi_process_file_closed(struct multi_context *m);
 
 #endif
 
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index fb4810b..a6e97af 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -85,6 +85,9 @@
         case TA_TUN_WRITE_TIMEOUT:
             return "TA_TUN_WRITE_TIMEOUT";
 
+        case TA_INSTANCE_POST:
+            return "TA_INSTANCE_POST";
+
         default:
             return "?";
     }
@@ -492,6 +495,11 @@
             multi_process_post(m, mi, mpp_flags);
             break;
 
+        case TA_INSTANCE_POST:
+            ASSERT(mi);
+            multi_process_post(m, mi, mpp_flags);
+            break;
+
         default:
             msg(M_FATAL, "MULTI IO: multi_io_dispatch, unhandled action=%d", action);
     }
@@ -659,7 +667,7 @@
 #ifdef ENABLE_ASYNC_PUSH
                 else if (e->arg == MULTI_IO_FILE_CLOSE_WRITE)
                 {
-                    multi_process_file_closed(m, MPP_PRE_SELECT | MPP_RECORD_TOUCH);
+                    multi_process_file_closed(m);
                 }
 #endif
         }
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index c7f8f89..4d56e25 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -44,6 +44,7 @@
 #define TA_INITIAL               8
 #define TA_TIMEOUT               9
 #define TA_TUN_WRITE_TIMEOUT     10
+#define TA_INSTANCE_POST         11
 
 /*
  * I/O state and events tracker


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
