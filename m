Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA999C55ABA
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mxZvRs4rwltseqO5Oc4OsSgKhkK1G7GFR5yEwr0gNj4=; b=MNnrVOamz18hy/gYUNmCvXu6Mv
	L+Fw2Q1D/DrbiLvu2T9TZpJZoGpfSr7VyjCnQntKrMna/7fzi2C+8U8SBSyeh42gvXEtI6BXL3AKj
	Qe/gRqHvKaR6wNTHvWBeneVajmYHXzaTBxpsjaa3Rv8V4StqEWB6hfwvGpm6SqsS4B1U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrbwv-0000i6-AX;
	Wed, 05 Aug 2026 13:46:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wrbwu-0000hz-H6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iy0xdBmxTiFOqybp8UvL2Xh71TjkR/AenFR0AGD6HnU=; b=YOP/sJBlOZRrq68mo8f8a9gYTq
 CjDKacgdcG0nI+AVb1dosW2tJeCOUs+8a5oPZFBesy2oKAmClu/bfSag7sdIm2pn10p+McLEay6V+
 ALCWV7KKGuQ+v3CkOKXoUmPB+qGF7EFvO8Rbn2tru8rdRjy25iaN+atP+qhztxMVtngM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Iy0xdBmxTiFOqybp8UvL2Xh71TjkR/AenFR0AGD6HnU=; b=I6uAOLca5oevHwDL6+pMyVm1xx
 rOh41BbQx3d9K8R/4fWzMo0hN4Sww0jheDWW7vmrJZEqxAVTYlPvKPbf34TpDEH/tOJCz9tbC3Hrt
 MbYZSw8zeggFJ+C6KK9D5MQEn/NQv+rvfvMyjWGGe3q0tYb4XCnt8CoY3aN/hYNe8JP4=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrbwy-00085W-1X for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:46:25 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hFWsN1YM5z8v0p;
 Wed, 05 Aug 2026 15:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1785937576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iy0xdBmxTiFOqybp8UvL2Xh71TjkR/AenFR0AGD6HnU=;
 b=w94cXAPLwjPHD+yCoI2aXnSkBEgmZqRnoX5e40H4b68p0JAJX6vd+3l59M9MaEUnShWdWc
 Gzg1PnteLM7JKWQT+43YpGqmUkC0H2XT7jtonTWVMG1RXMQxWf+swwT30Xj/A9QIRfXMtb
 mOe8uN3Q0wpyyN8oTrudUouDcjEgwUBvqU5nQ6rTjz5q0zO6E3LqgQY68W2zLMVJp6I4zC
 N+rOPhUpT00AjMxAiP1teyF5x+o4EOr3k+Jynp0qK6Np2gJ+ExqNkxlOoWbWpIBA/LxrwA
 V7WDz01a7Kk2qvBrsPECH8I0uYgIhAXq1iGyVwgRr+Vg+kbxfT7kvjFKZ3V4DA==
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  5 Aug 2026 15:46:14 +0200
Message-ID: <20260805134614.163847-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic75ca2ee9b59a4e11f37cd9653df268bba33889c@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wrbwy-00085W-1X
Subject: [Openvpn-devel] [PATCH v11] mudp: extract send_standalone_reply()
 helper
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
Cc: Antonio Quartulli <antonio@mandelbit.com>, Lev Stipakov <lev@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Lev Stipakov <lev@openvpn.net>

Factor the synchronous, stateless "send a standalone control packet back to the
peer that just contacted us" sequence out of send_hmac_reset_packet() into a
reusable helper. No behavioural change.

This lets a following commit reuse it for the out-of-band probe reply instead of
duplicating the aux_buf / to_link / process_outgoing_link sequence.

Change-Id: Ic75ca2ee9b59a4e11f37cd9653df268bba33889c
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1743
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1743
This mail reflects revision 11 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 9acf297..2be085f 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -37,6 +37,41 @@
 #include <sys/inotify.h>
 #endif
 
+/**
+ * Send an already-built standalone control packet back to the peer that just
+ * contacted us (c2.from), synchronously and without keeping any state.
+ *
+ * We do not want to keep state for a reply to an initial/out-of-band packet, so
+ * we send it without queueing. If we hit EAGAIN on a busy socket the packet is
+ * lost and the client simply retries -- an acceptable compromise that avoids
+ * consuming server resources under attack.
+ *
+ * @param m       the server's multi_context
+ * @param buf     the packet to send (built by a tls_*_standalone() helper)
+ * @param prefix  msg() prefix to set for the duration of the send
+ * @param detail  D_MULTI_DEBUG message describing the reply
+ * @param sock    the socket to send the reply on
+ */
+static void
+send_standalone_reply(struct multi_context *m, struct buffer *buf, const char *prefix,
+                      const char *detail, struct link_socket *sock)
+{
+    struct context *c = &m->top;
+
+    /* dco-win server requires prepend with sockaddr, so preserve offset */
+    ASSERT(buf_init(&c->c2.buffers->aux_buf, buf->offset));
+    buf_copy(&c->c2.buffers->aux_buf, buf);
+
+    msg_set_prefix(prefix);
+    c->c2.to_link = c->c2.buffers->aux_buf;
+    c->c2.to_link_addr = &c->c2.from;
+    msg(D_MULTI_DEBUG, "%s", detail);
+    process_outgoing_link(c, sock);
+    c->c2.to_link.len = 0;
+    c->c2.to_link_addr = NULL;
+    msg_set_prefix(NULL);
+}
+
 static void
 send_hmac_reset_packet(struct multi_context *m, struct tls_pre_decrypt_state *state,
                        struct tls_auth_standalone *tas, struct session_id *sid,
@@ -48,29 +83,8 @@
     struct buffer buf = tls_reset_standalone(&state->tls_wrap_tmp, tas, sid,
                                              &state->peer_session_id, header, request_resend_wkc);
 
-    struct context *c = &m->top;
-
-    /* dco-win server requires prepend with sockaddr, so preserve offset */
-    ASSERT(buf_init(&c->c2.buffers->aux_buf, buf.offset));
-
-    buf_copy(&c->c2.buffers->aux_buf, &buf);
-
-    /*
-     * We do not want to keep any state here, so we send the reply to the
-     * initial packet synchronously without queueing anything.
-     *
-     * If we hit EAGAIN on a busy socket, the packet will be lost and the
-     * client will have to retransmit its HARD_RESET. This is considered an
-     * acceptable compromise to avoid consuming server resources under attack.
-     */
-    msg_set_prefix("Connection Attempt");
-    c->c2.to_link = c->c2.buffers->aux_buf;
-    c->c2.to_link_addr = &c->c2.from;
-    msg(D_MULTI_DEBUG, "Reset packet from client, sending HMAC based reset challenge");
-    process_outgoing_link(c, sock);
-    c->c2.to_link.len = 0;
-    c->c2.to_link_addr = NULL;
-    msg_set_prefix(NULL);
+    send_standalone_reply(m, &buf, "Connection Attempt",
+                          "Reset packet from client, sending HMAC based reset challenge", sock);
 }
 
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
