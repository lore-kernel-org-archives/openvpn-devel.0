Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06392C5516D
	for <openvpn-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zblDJuJ1oCfqTLGAW0erGG4NmOGiIWD1wYJdWddpOvs=; b=ApAR8vddYRd+n0jm3I/63L2lEq
	UWa9eubAxwtdd1Ixe/RQydGmJ/eTVk+GsBoaaB/jRJUBAPaL7bO/znLQZtnciL5dYPsSnySaekppL
	qSlwWC4W2oIBENNIISfJIltnunusnNWUmGyl2QVZfgGXhJvHg9skm7Cg2c/zFK++S3L8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wplgv-0006bx-Pr;
	Fri, 31 Jul 2026 11:46:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wplgu-0006br-Hv
 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 11:46:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qn+oJXUo9L6wwqSLnhVtJsd8pEajYx0qbxNTahO1R5Q=; b=a+++c+MPG/s1e1ErjishkJxYHr
 jC2tIMnzuG2I1wjvrVCsTargxOFmnjBjtX/kblZYcqurY8WP1iwsOX2G1pGABdymstCBlwXFi/uv4
 0mNt6q4F3YQ3XU6k8cXTaXlPMtBG1kestOyV4jOC3wSk8H+/O8W9pVg3XO0COaTK1JmE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Qn+oJXUo9L6wwqSLnhVtJsd8pEajYx0qbxNTahO1R5Q=; b=KnilHdOfFBT4kxOpe5MZHZTnjU
 5cYVUKJqB6tM0TeZR1HlbfV7Tj6vy2uBTe6c7bZ/nsplYHsKdQIygNeoYINXhn1t5+weMVk8uPey1
 UQyQ0AgJduil74iIK7LpKjLacqZbcy1Ts7C0Ctw4j0KaELO08RwJJCGAVvtN+DYvr+Xs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wplgq-00071t-Py for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 11:46:14 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66VBk5cZ011618
 for <openvpn-devel@lists.sourceforge.net>; Fri, 31 Jul 2026 13:46:05 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66VBk5vH011617
 for openvpn-devel@lists.sourceforge.net; Fri, 31 Jul 2026 13:46:05 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 31 Jul 2026 13:45:54 +0200
Message-ID: <20260731114605.11596-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1785402220000.I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d@gerrit.openvpn.net>
References: <gerrit.1785402220000.I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wplgq-00071t-Py
Subject: [Openvpn-devel] [PATCH v1] ssl: Ignore hard reset packets with a
 non-zero packet id
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

From: Frank Lichtenheld <frank@lichtenheld.com>

A hard reset is always the first packet of a session, so it always
carries reliable packet id 0. tls_process_state() relies on that when it
treats a received reset as the early negotiation packet only for packet
id 0, and the stateless three-way handshake relies on it as well (see
the comment in session_skip_to_pre_start()).

A reset claiming a different id is therefore bogus.

We had a bug that could cause hard reset replays with packet id 1 in
specific scenarios (P2P TCP). In that case we accepted the packet id
at face value and then ignored the control packet that actually had
id 1 as an replay. This caused a difficult to diagnose dead connection
that was stuck just before TLS negotiation. The check added handles
this specific scenario well in that we just ignore the bogus reset
but do not abort the connection attempt. Starting fresh might retrigger
the bug. If there would be a separate bug where the client only sends
hard resets with packet id 1 we will still get logging on the server
side now.

Change-Id: I3c7d1f9e5b2a4c6d8e1f3a5b7c9d2e4f6a8b1c3d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1832
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1832
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7f2e850..46ccc12 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3903,8 +3903,22 @@
         /* Extract the packet ID from the packet */
         if (reliable_ack_read_packet_id(buf, &id))
         {
+            /* A hard reset always is the first packet of a session, so it
+             * always must use packet id 0. Ignore it if it claims another id.
+             * In a specific existing bug these packets were replays of an
+             * already handled reset, so ignoring it is better than aborting
+             * the connection attempt.
+             */
+            if (is_hard_reset_method2(op) && id != 0)
+            {
+                msg(D_TLS_ERRORS,
+                    "TLS Error: received %s with packet id " packet_id_format
+                    " from %s -- 0 was expected, ignoring packet",
+                    packet_opcode_name(op), (packet_id_print_type)id,
+                    print_link_socket_actual(from, &gc));
+            }
             /* Avoid deadlock by rejecting packet that would de-sequentialize receive buffer */
-            if (reliable_wont_break_sequentiality(ks->rec_reliable, id))
+            else if (reliable_wont_break_sequentiality(ks->rec_reliable, id))
             {
                 if (reliable_not_replay(ks->rec_reliable, id))
                 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
