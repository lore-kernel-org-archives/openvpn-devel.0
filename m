Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0312CC61DBC
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CXj2q/FiOwBPn+zDgqzd2/DdYPGOheIBgppet1/tyA=; b=C4i2VUYeAv7D6siAJYUyyFpTrk
	TW4j13WNp5gFFMiYy6CZqoTHzf3Ksvwa/iBnh6ve9SumHjLi0bfaFdpxkoq5LjFITExeWuFSmp5aZ
	0xQkHzsac6tdc/Y8LZhpIRst7NO0212N6bB6yox+yBgsTfNmeoTRKnXxJ2y6IV6mhDzU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyuMA-0007eg-Kv;
	Tue, 25 Aug 2026 16:50:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wyuM8-0007eZ-Px
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 16:50:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OHBxURZAcgYfAdjDv2Jx4B5PklSEb5uLVsOuf+Sntn8=; b=BFsOBM1FOgRx+LiUDgqmeaNDpu
 iPpSRfBKgfRQptysbIiBSarpHpjeQQL+fhmdwy3zOFiXG3D/yXrfdOjwmt2A+kpNUR2Q1tpOxyvD5
 z3+gQ4gSHXBABYCOXF6/oBlxIhaV57KUDyfWcMaCQoGBnqfMAuFD2RUswD+JmwKnzXz8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OHBxURZAcgYfAdjDv2Jx4B5PklSEb5uLVsOuf+Sntn8=; b=KKUfYGVMcFjyjlOmpJr5SrkcbC
 0jJySgEmgajboOeHEiRlGRmbxWW1LWhCznQTUOBjokejGIRVlNIrBBWiKMQalp1EB8zhOTcOoxQim
 SCiuoIgdmtv4Yb+eljlQ0FLObp6b6Iy/rakqcTr5xgVPFsO/FBPmrJIZTBZFqGtytMGA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyuM7-0004EQ-DV for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 16:50:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67PGoSQ4009839
 for <openvpn-devel@lists.sourceforge.net>; Tue, 25 Aug 2026 18:50:28 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67PGoSps009838
 for openvpn-devel@lists.sourceforge.net; Tue, 25 Aug 2026 18:50:28 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 25 Aug 2026 18:50:22 +0200
Message-ID: <20260825165028.9823-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787150406000.I57b4122b292f643ddedd91e81bf95fe2f5b2e03a@gerrit.openvpn.net>
References: <gerrit.1787150406000.I57b4122b292f643ddedd91e81bf95fe2f5b2e03a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wyuM7-0004EQ-DV
Subject: [Openvpn-devel] [PATCH v1] doc: Update doxygen references to
 removed tunnel_server_{udp, tcp}()
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

From: Razvan Cojocaru <razvanc@mailbox.org>

The point-to-multipoint server event loop is no longer split into
protocol-specific tunnel_server_udp() and tunnel_server_tcp()
functions; tunnel_server() now handles both UDP and TCP.

Update the Doxygen module documentation accordingly: list
tunnel_server() as the server-mode event loop implementation, and
rewrite the server-mode startup, initialization and cleanup sections
so that they describe tunnel_server() instead of the removed
functions.

Documentation only, no functional change.

Change-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1850
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1850
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/doc/doxygen/doc_eventloop.h b/doc/doxygen/doc_eventloop.h
index 55ecd73..4c1b012 100644
--- a/doc/doxygen/doc_eventloop.h
+++ b/doc/doxygen/doc_eventloop.h
@@ -60,6 +60,5 @@
  * event loop function is called to drive the event processing.  The
  * following implementations are available:
  * - Client mode using UDP or TCP: \c tunnel_point_to_point()
- * - Server mode using UDP: \c tunnel_server_udp()
- * - Server mode using TCP: \c tunnel_server_tcp()
+ * - Server mode using UDP or TCP: \c tunnel_server()
  */
diff --git a/doc/doxygen/doc_tunnel_state.h b/doc/doxygen/doc_tunnel_state.h
index 296e804..424f81e 100644
--- a/doc/doxygen/doc_tunnel_state.h
+++ b/doc/doxygen/doc_tunnel_state.h
@@ -117,10 +117,10 @@
  * tunnel_point_to_point() or \c tunnel_server().
  *
  * In server-mode, \c main() calls the \c tunnel_server() function, which
- * transfers control to \c tunnel_server_udp() or \c
- * tunnel_server_tcp() depending on the external transport protocol.
+ * drives the event loop for both the UDP and TCP external transport
+ * protocols.
  *
- * These functions receive the \c context created in \c main().  This
+ * This function receives the \c context created in \c main().  This
  * object has a special status in server-mode, as it does not represent an
  * active VPN tunnel, but does contain process-wide configuration
  * parameters.  In the source code, it is often stored in "top" variables.
@@ -130,11 +130,10 @@
  * CM_CHILD_UDP or \c CM_CHILD_TCP, depending on the external transport
  * protocol.
  *
- * Both \c tunnel_server_udp_single_threaded() and \c tunnel_server_tcp()
- * perform similar initialization.  In either case, a \c multi_context
- * structure is created, and it is initialized according to the
- * configuration stored in the top \c context by the \c multi_init() and
- * \c multi_top_init() functions.
+ * During initialization, \c tunnel_server() creates a \c multi_context
+ * structure, which is initialized according to the configuration stored
+ * in the top \c context by the \c multi_init() and \c multi_top_init()
+ * functions.
  *
  * @subsection tunnel_state_server_tunnels Creating and destroying VPN tunnels
  *
@@ -146,8 +145,7 @@
  *
  * @subsection tunnel_state_server_cleanup Final cleanup
  *
- * After the main event loop exits, both \c
- * tunnel_server_udp_single_threaded() and \c tunnel_server_tcp() perform
- * similar cleanup.  They call \c multi_uninit() followed by \c
- * multi_top_free() to clean up the \c multi_context structure.
+ * After the main event loop exits, \c tunnel_server() performs the
+ * cleanup.  It calls \c multi_uninit() followed by \c multi_top_free()
+ * to clean up the \c multi_context structure.
  */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
