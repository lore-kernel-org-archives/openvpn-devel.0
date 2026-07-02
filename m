Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C041C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AOoRqp8c5JkU9AX4ATOW05Lz+pIPHUtf5/1F02Rk1dY=; b=KZR5VMoI4p9lGRbePusAuOvFCc
	BvH/TyWxsklqam2qmX1IinOd8Cu3B8hAEZZtDcWgE2X3htgXPqTufs1m4eNfBZVWN/vebe/CxygkN
	js71wyZ4JvuAfNJ31EQgP0fd2u+Q79Ho4naC3od829e7yEtE5j9+DIbddWgcW/7t4Pp4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfEKJ-0007lx-A5;
	Thu, 02 Jul 2026 10:07:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wfEKG-0007lk-Ic
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 10:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oZmlQnOyZi3zaUwJ9q6uTYcVxzfqyaWQJ/klbpHfS5o=; b=C+8lt96Hl40gciEXfFu67oI9xD
 RNE7D+VlCDesyozGoO5xBZiFGxTbI4y/dCD9rxBV97tzIgI4DnbVsf+8WeIOw1qyxwjGmaUOsAA9H
 cLUy4DGYI/MoLruu0qf/KHhIat6mxoJX1MckrzcFM7iib7snd8RyBWydxTjJr8RVD2QA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oZmlQnOyZi3zaUwJ9q6uTYcVxzfqyaWQJ/klbpHfS5o=; b=icGsF9PJCqT85UEhZkN7GYLarH
 STLtcPRr6asSU/xDvIEAHujpwa17QxJcgIMCcRc8JQFzP9hkWTV7d0+EryCOOS7r5lcdMAY9jXAEE
 qDOl2DrzcRNQPkUw37PzE/sn0sVe9XyrDvbGVhjz7jWIzAjp8rOHrnmkZNtE2g3JsDR4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfEKC-00076N-HU for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 10:07:18 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 662A75pS024730
 for <openvpn-devel@lists.sourceforge.net>; Thu, 2 Jul 2026 12:07:05 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 662A75ig024729
 for openvpn-devel@lists.sourceforge.net; Thu, 2 Jul 2026 12:07:05 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2026 12:06:59 +0200
Message-ID: <20260702100704.24692-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782986182000.I20cc89a546b69aceadcd1630828de407d530d7c7@gerrit.openvpn.net>
References: <gerrit.1782986182000.I20cc89a546b69aceadcd1630828de407d530d7c7@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wfEKC-00076N-HU
Subject: [Openvpn-devel] [PATCH v1] ssl_pkt: Fix doxygen warning about
 read_control_auth
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

Commit 01ee1693f960a696a613e7b83f9960002264a379
("Ensure tls-crypt keys are not setup twice") removed
the argument but did not delete it from the doxygen
documentation, leading to warnings.

Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1765
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1765
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 640885e..82cb5b1 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -207,7 +207,6 @@
  * @param ctx               control channel security context
  * @param from              incoming link socket address
  * @param opt               tls options struct for the session
- * @param initial_packet    whether this is the initial packet for the connection
  * @return                  if the packet was successfully processed
  */
 bool read_control_auth(struct buffer *buf, struct tls_wrap_ctx *ctx,


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
