Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CDFC4453E
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vseGNQ5oOXi7BtYC4vewv6o0mQgrDkqfKJB4H4koIWU=; b=J40TeH7WPtPIO0nmRyoN7yymXk
	q6bT5ecqHV5SuYnGaC93mgjReHH01iG22FbokZDgDxlYSo3qBxhE5XPqDAOuekLqDn5ltKexclx5a
	BnCJb2ykfKT/IRvPhBsvWs5MpsJLAt5JM8evGBopiL2pYBYmx0jSzWhYS5aZQslDxetM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmZxZ-0007Wr-OA;
	Wed, 22 Jul 2026 16:38:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wmZxY-0007Wi-Mq
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:38:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+JLYf8chetaakVip0jDf1PpsbKVz0ZPg7p6iQLsShJs=; b=J3b6z18uK2L5rWRs6Fj/n6PEso
 dzPdjAj139qjGLqCCjlWQzSrL0+uM/URN06X0dk9G/oJ6MZnBgYDGW64U+QlqMjTT7nKDpgiEkzd2
 YcO6/D4nywkFBqnNX2gcBQlnJZ1uYZpkS0oDsrIG3O6qkXPQGFYYDbJH+qnkf1upfQD8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+JLYf8chetaakVip0jDf1PpsbKVz0ZPg7p6iQLsShJs=; b=W1fsh/NKGiy5GQOFe7EZErV2lQ
 KLDuf+P6cKIkosxP4Pwq4fAF3EZBReQP5kicl/JEgHUlwtWxyR5BrSztA+SYfNJ/JN69LAQnL/P0J
 /JkPC5E1YJ/tv8UrWcH60vhpbPvCLQnCOR83ZXS5dZTWCsEw+CeLgBoNCHsbuLmESjjU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmZxV-0002hz-Dt for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:38:15 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66MGc1Dl002497
 for <openvpn-devel@lists.sourceforge.net>; Wed, 22 Jul 2026 18:38:01 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66MGc1Fw002496
 for openvpn-devel@lists.sourceforge.net; Wed, 22 Jul 2026 18:38:01 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 22 Jul 2026 18:37:55 +0200
Message-ID: <20260722163800.2474-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
References: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wmZxV-0002hz-Dt
Subject: [Openvpn-devel] [PATCH v2] Remove --providers from --help output
 for Mbed TLS
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

From: Max Fillinger <maximilian.fillinger@sentyron.com>

This option is OpenSSL-only. When used with Mbed TLS, it prints warnings
and does not do anything. With this change, the option is still parsed,
to ensure compatiblity of configurations, but it is removed from the
--help text.

Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
Signed-off-by: Max Fillinger <maximilian.fillinger@sentyron.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1799
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1799
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 87218d4..2424431 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -606,7 +606,9 @@
     "                : Use --show-tls to see a list of supported TLS ciphers (suites).\n"
     "--tls-cert-profile p : Set the allowed certificate crypto algorithm profile\n"
     "                  (default=legacy).\n"
+#ifndef ENABLE_CRYPTO_MBEDTLS
     "--providers l   : A list l of OpenSSL providers to load.\n"
+#endif
     "--tls-timeout n : Packet retransmit timeout on TLS control channel\n"
     "                  if no ACK from remote within n seconds (default=%d).\n"
     "--reneg-bytes n : Renegotiate data chan. key after n bytes sent and recvd.\n"


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
