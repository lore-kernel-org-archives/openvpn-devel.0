Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF135606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cypdpOZQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OEKPiVgf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=elArV7R3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qAX+MiLOjUgvHN8bxnZ9X4pLrJqGSamFFTAqA31E1yc=; b=cypdpOZQzkjsPU
	bteFkz6BBDgzIlkQeAW1s8mWb9E7WbDuTxWDGYE1xDyOKXgPN3mtsuVb58TYHn+mr74j89JYBvNry
	48gf3byklSVkpqZ4IZn/fcaPJb7oAMBKasxawt/+r/Xkfp3kVb/9ZI7DdgUjIRQ9ABPeO9v3RcBd+
	ihs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOf1N-00000000816-0hd7;
	Wed, 04 Nov 2026 17:43:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOf15-000000007xE-2Czz for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:43:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2LxkfXB+Vbf9IfLu74Invb/S2BShx6HrD1MUdY1Ye9Y=; b=OEKPiVgfunB5YgYpC9pG1v+ZCv
 EIB+2WYcGNb+LnVXpIju4F55yawDzDnBFrcOL+fORhHGPYLZQMp2IRxieIAqBhLu8rHnUltT/Eyln
 uNvUgpFgGMP6aXF2BkULAnkYkOPOUMmfZ9dleXQ8wvqIJqE533lQbvYXT2HspU1o+dhw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2LxkfXB+Vbf9IfLu74Invb/S2BShx6HrD1MUdY1Ye9Y=; b=elArV7R3QjuhgCX89D9ivZCM9L
 hhbvTMJeKxAjKXTJwgijbIz5RMHpvCRvrLL27bbLK5KsJH5ry8kXFBMLERrz3E4idB5D2l9ojaMw2
 yGZjWPgK1cGOnRDiIrBChxUyRA0HWmilzfPeyE0lGFKzZLN6RiFSe7+ZA7zM372AaSnU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOf10-000000002tl-0nC9 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:43:16 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4Hh7U9015185
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 18:43:07 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4Hh7LY015184
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 18:43:07 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 18:43:01 +0100
Message-ID: <20261104174306.15159-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793802273000.Iba1db32cd130d092e34a31159f14d3aa37db96f2@gerrit.openvpn.net>
References: <gerrit.1793802273000.Iba1db32cd130d092e34a31159f14d3aa37db96f2@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOf10-000000002tl-0nC9
Subject: [Openvpn-devel] [PATCH v1] multi: use multi_io_delete_event() and
 drop multi_tcp_delete_event()
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

From: Razvan Cojocaru <razvanc@mailbox.org>

cbb0440e ("multiproto: move generic event handling code in dedicated
files") added multi_io_delete_event() as a copy of
multi_tcp_delete_event() but kept the old function and its only
caller. Switch management_delete_event() to the new one and remove the
old copy.

Change-Id: Iba1db32cd130d092e34a31159f14d3aa37db96f2
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2133
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2133
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gianmarco De Gregori <gianmarco@mandelbit.com>

        
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 2d0af06..62d059e 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -95,15 +95,6 @@
 }
 
 void
-multi_tcp_delete_event(struct multi_io *multi_io, event_t event)
-{
-    if (multi_io && multi_io->es)
-    {
-        event_del(multi_io->es, event);
-    }
-}
-
-void
 multi_tcp_dereference_instance(struct multi_io *multi_io, struct multi_instance *mi)
 {
     const struct link_socket *sock = mi->context.c2.link_sockets[0];
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 47c6308..b4ec1f9 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -43,6 +43,4 @@
 
 struct multi_instance *multi_create_instance_tcp(struct multi_context *m, struct link_socket *sock);
 
-void multi_tcp_delete_event(struct multi_io *multi_io, event_t event);
-
 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3f514d6..741b3d1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4025,7 +4025,7 @@
     struct multi_context *m = (struct multi_context *)arg;
     if (m->multi_io)
     {
-        multi_tcp_delete_event(m->multi_io, event);
+        multi_io_delete_event(m->multi_io, event);
     }
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
