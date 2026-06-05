Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD407CD6E7D
	for <openvpn-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=16knpds4MGCTwhMx1f2RqySlqOQl1UTisckKjHqZZUI=; b=LXl5Lm0q2xa4wEiIYK0TXa0WOu
	84O31Tu8YsgCBt+rXuYkSE4VE8oY5HSRxge1tAOiZk4A5LZ/tGnCRsHhN9rp6DrKwdoiSohRANjL4
	WmfQB9uNmB1jtkdnk5y5oXK3xunX4BUj7swda8WPeCBg0JIMvL+i+Ag0cK0+Xujd/KsA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wVVNP-0005n1-T7;
	Fri, 05 Jun 2026 14:18:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wVVNO-0005mo-5C
 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 14:18:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XI4PHv7MetiGMV0f25OnpgurTjdzLFks8VMM0s1NjVo=; b=lidgmc7Gw/JZgrndQ5BTiMSwTY
 v3KKeabWKmPe+zEi79B14FoZKlxL91ZlEsQX4LqhiYudgmdzFYV2gQXb5oXNb7Yq2jsC4+T59h9As
 p1ZNY3dgcizYs3USS9X9xvvyvxSi/1RJ3njS1RUYRa3VgJJKtgMQdIXC1yzByfyIowx8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XI4PHv7MetiGMV0f25OnpgurTjdzLFks8VMM0s1NjVo=; b=BLPb1JCoMrdgf9ct4S3wHAmSuU
 wO45UqCmNpfUsbJMRYJo0RPRFCNCkCaEyIkZcKPhNVFSLy64V0yXEcM0hNHMviKUbI37JP9hoFAN5
 cW4jCYtwf1CuSzudWaGujPKRgrPdz8os5R/qI2fjL1+PB3fS3bxkRXHSOtBG8DnFLrSs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wVVNM-0007tp-EB for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 14:18:22 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 655EI8p5014048
 for <openvpn-devel@lists.sourceforge.net>; Fri, 5 Jun 2026 16:18:08 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 655EI8r8014047
 for openvpn-devel@lists.sourceforge.net; Fri, 5 Jun 2026 16:18:08 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  5 Jun 2026 16:18:02 +0200
Message-ID: <20260605141808.14028-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1780404721000.I2ce954aa5b74002be5e38d53783435736625bb2f@gerrit.openvpn.net>
References: <gerrit.1780404721000.I2ce954aa5b74002be5e38d53783435736625bb2f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wVVNM-0007tp-EB
Subject: [Openvpn-devel] [PATCH v1] socket: assert buffer length before
 reading prepended sockaddr family
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

From: Lev Stipakov <lev@openvpn.net>

read_sockaddr_from_packet() inspected sa->sa_family before any check
on buf->len, so a short delivery from the dco-win driver would have
produced a garbage peer address from uninitialized buffer memory.
The driver always prepends a full sockaddr and validates the family
before writing, so reaching any of the size/family checks would mean
something is severely wrong on the driver side - assert the three
preconditions instead of M_FATAL'ing on them.

GitHub: https://github.com/OpenVPN/openvpn-private-issues/issues/105

Change-Id: I2ce954aa5b74002be5e38d53783435736625bb2f
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1706
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1706
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 624ce4f..df2cc9e 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2813,38 +2813,31 @@
 {
     int sa_len = 0;
 
+    /* In dco-win multipeer mode the kernel driver always prepends a full
+     * sockaddr_in or sockaddr_in6 in front of the control-packet payload,
+     * so the buffer must hold at least sizeof(struct sockaddr_in) bytes
+     * before we may inspect sa_family. */
+    ASSERT(buf_len(buf) >= (int)sizeof(struct sockaddr_in));
+
     const struct sockaddr *sa = (const struct sockaddr *)BPTR(buf);
     switch (sa->sa_family)
     {
         case AF_INET:
             sa_len = sizeof(struct sockaddr_in);
-            if (buf_len(buf) < sa_len)
-            {
-                msg(M_FATAL,
-                    "ERROR: received incoming packet with too short length of %d -- must be at least %d.",
-                    buf_len(buf), sa_len);
-            }
-            memcpy(dst, sa, sa_len);
-            buf_advance(buf, sa_len);
             break;
 
         case AF_INET6:
             sa_len = sizeof(struct sockaddr_in6);
-            if (buf_len(buf) < sa_len)
-            {
-                msg(M_FATAL,
-                    "ERROR: received incoming packet with too short length of %d -- must be at least %d.",
-                    buf_len(buf), sa_len);
-            }
-            memcpy(dst, sa, sa_len);
-            buf_advance(buf, sa_len);
+            ASSERT(buf_len(buf) >= sa_len);
             break;
 
         default:
-            msg(M_FATAL, "ERROR: received incoming packet with invalid address family %d.",
-                sa->sa_family);
+            ASSERT(0); /* driver validates the family before writing */
     }
 
+    memcpy(dst, sa, sa_len);
+    buf_advance(buf, sa_len);
+
     return sa_len;
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
