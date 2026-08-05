Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A72C55ABA
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HBMC6CcLNcWyDGklbDAS5IlNV2WB4AhUlQYfDJI+F8o=; b=cQVfMt9spDJXUnQB2KHm01nfCj
	b1d6fJyPV0+hFGC87xrMqzJU43slppFaK76F4/D7G9YQWcryB1clZ11uAXqj4SxeDhjogrzb2YLzC
	xbDTCLDnBUr8HTYEBkz2ryrXGQFk+xmffC4yvL2UqNBGSHBy/CVS5vT5KNF0ORu97mcQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrbuR-0000d9-PF;
	Wed, 05 Aug 2026 13:43:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wrbuP-0000cz-Fd
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:43:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=STbMD6Wujlzlqp36Hz/uzA1StMlZz58H6Ek0nyCHHV8=; b=WwUJUm8kOpfb/eTu0Ynr+xwSlb
 6x1f+OFl092LjEh3dO47HpWa0zYvhlVtTnh/WSCjBwnZtVzDBopLBGUGPKNqOw7kA2Ik5fgsXvegp
 7YUKFyn7vaihmdy0tPuQ0Fa7PUmCRLeOdJr0MTV/BISf3VYoJsZFsiSeFO/VGkYDLYUI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=STbMD6Wujlzlqp36Hz/uzA1StMlZz58H6Ek0nyCHHV8=; b=AYRwOTPNFRmfhD7wLnHeoCNwBV
 hvgtFljBtzeG7IB5snOruVR+PqFSIGTB7aj4W+QWzB4t8kTipAdheKUGexYNBuKAUJ4WQm9Y9d5UO
 KmNK9xRGhS/PcsDWfHGO8xzMi6BNJfU8IOzZre8/dfFu4tYhtPLsG4aC50y41GlPD9d8=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrbuP-00081X-4J for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:43:47 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hFWpK4wBTzKryG;
 Wed, 05 Aug 2026 15:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1785937417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STbMD6Wujlzlqp36Hz/uzA1StMlZz58H6Ek0nyCHHV8=;
 b=uol/CA9TTXRWG9T0DPP1ZB1x9+vBXMplEw5/gPn2jmqI4jHZ73jpTKuzvhl2vzBrSA0s3n
 +gtvBAbH4EKS8MNzGEHVfxODnNqmuk/j8QpMmxCw6+ah7fR4cImDiIuDnDhVJad044r3KD
 GtZ4nwt28laU3QFfDUAq1PLYrUsJwucY3wE/aKEYfFN18ml81u94J/W83YXpsNaUKFbxr+
 zvgdxbTsR2s/eP/QgpeY3n60QCnE6wGW9U1Fba+NWWc+/c5WPRFp8qifwUpr93uFpQ8mGA
 fOqDEnEZE3SHOEr46oNNNPua/SPPw5VS61O0Gzj3ixI/Maomu4Phzh+W0JaRHA==
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  5 Aug 2026 15:43:36 +0200
Message-ID: <20260805134336.163392-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1785402220000.Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3@gerrit.openvpn.net>
References: <gerrit.1785402220000.Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wrbuP-00081X-4J
Subject: [Openvpn-devel] [PATCH v1] ssl: Do not queue control ciphertext
 while a packet is still queued
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
Cc: Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

An outgoing control channel packet is handed to the link layer as a
buffer descriptor pointing into the reliable send buffer it was built
from, and the packet id sits in that buffer's headroom, right in front
of the payload.  If the entry is reused before the packet has been
written out, buf_copy_n() writes the new payload and
reliable_mark_active_outgoing() prepends the new packet id exactly over
the packet id of the queued packet, while its opcode, ACK array and
length stay untouched.  The queued packet then goes out with somebody
else's packet id.

Observed in a TCP p2p handshake: both peers reset simultaneously, the
peer's two HARD_RESET packets arrive back to back, so io_wait_dowork()
takes the residual data shortcut (event_set_status = SOCKET_READ) and
does not write out our already queued HARD_RESET retransmit.  The ACK
in the second peer reset then purges our reset from the send window,
tls_process_state() moves to S_START and queues the ClientHello into
the very same (now inactive) entry.  Result on the wire: a HARD_RESET
with the ClientHello's packet id 1, followed by the ClientHello with
the same id 1.  The receiver consumes the reset, advances its receive
window, and drops the real ClientHello as a replay - the handshake
deadlocks until it times out.

The send path in tls_process_state() and the dedicated ACK path in
tls_process() are already guarded by to_link->len, only the ciphertext
queueing was not.  Guard it as well.  A pending to_link makes
tls_process() report itself as active, so we are called again as soon
as the packet has been written out.  In the error path this can drop a
TLS alert that we would have queued, which is in line with that path
not ensuring delivery anyway.

Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1831
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1831
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 60df7ce..7f2e850 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2714,8 +2714,15 @@
 
 static bool
 check_outgoing_ciphertext(struct key_state *ks, struct tls_session *session,
-                          bool *continue_tls_process)
+                          struct buffer *to_link, bool *continue_tls_process)
 {
+    if (to_link->len)
+    {
+        dmsg(D_TLS_DEBUG,
+             "Deferring outgoing ciphertext, previous packet not written out yet");
+        return true;
+    }
+
     /* Outgoing Ciphertext to reliable buffer */
     if (ks->state >= S_START)
     {
@@ -2895,7 +2902,7 @@
             dmsg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
         }
     }
-    if (!check_outgoing_ciphertext(ks, session, &continue_tls_process))
+    if (!check_outgoing_ciphertext(ks, session, to_link, &continue_tls_process))
     {
         goto error;
     }
@@ -2907,7 +2914,7 @@
     /* Shut down the TLS session but do a last read from the TLS
      * object to be able to read potential TLS alerts */
     key_state_ssl_shutdown(&ks->ks_ssl);
-    check_outgoing_ciphertext(ks, session, &continue_tls_process);
+    check_outgoing_ciphertext(ks, session, to_link, &continue_tls_process);
 
     /* Put ourselves in the pre error state that will only send out the
      * control channel packets but nothing else */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
