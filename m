Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DB4CD6E7C
	for <openvpn-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5zChISPRRabAyxowfI51r6SEXK8gVH9b1v90jDdKVJw=; b=j13L25M3z4IDTYOAWUZGZZ4v1P
	CwpTyVCYEYU3S0NMNo0bCxvuTwMrIwBN8cWkMivNjq+LpV059IK3LfHQLKPuM87bDv9c8rLXxBuAQ
	+b9TUnMTOPdhABDKWTgHAEOwQa3qZ/Nym87LJt5zdfO4caQF9fdvYCPA8j0e6EQ4e584=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wVYzK-0006Rl-4B;
	Fri, 05 Jun 2026 18:09:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wVYzI-0006Rf-4A
 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lfvUY4VWiN17IWp50/psskd76wQE9gGnDrZZBj2Hwck=; b=b/my7nWy48DhbAMqH66/Sftp1e
 AzgXsr8kJv/H+/xXDcfVWGpxmGiRSRLoy+XDgCXh5NHwzJAck0OLvZTW2pZQSGimacTsdIHrBTDtN
 y9fHtADIKWXH+kKlIolYXHCj+RwwB2qzieooepqbUdXSrgyTzXpmyz+Xv3WSvR2a/GMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lfvUY4VWiN17IWp50/psskd76wQE9gGnDrZZBj2Hwck=; b=OSJC5BW98kKL9E6OGBuhrvpQfD
 TBSsVig0RE6a32u/8PBV7kNI1AYd/u3Uy06MEcczZUul+of8Ag1lww9LCk4BKGrorlUfa1Y4IjHp1
 jxzxC0Qsr/xvxiJSx01df/Nj3ope5VfgRFdEfCJYDmHD7jxQcC8319K2GxvlcIOayikA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wVYzH-0002LL-5h for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:09:44 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 655I9VNW003570
 for <openvpn-devel@lists.sourceforge.net>; Fri, 5 Jun 2026 20:09:31 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 655I9Vbt003569
 for openvpn-devel@lists.sourceforge.net; Fri, 5 Jun 2026 20:09:31 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  5 Jun 2026 20:09:25 +0200
Message-ID: <20260605180931.3547-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1780494160000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
References: <gerrit.1780494160000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wVYzH-0002LL-5h
Subject: [Openvpn-devel] [PATCH v1] Ensure pushed tun-mtu is no lower than
 TUN_MTU_MIN
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

From: Arne Schwabe <arne@rfc2549.org>

The normal path ensure that the minimum tun mtu is set to at least
TUN_MTU_MIN. However, the pushed options path does not have this
restriction.

Check that the tun-mtu is within the limits of min/max mtu
in options.c. This ensure that the check is also correctly done
on the pushed variant.

Also add an extra check to keep the allowed payload for icmp6 packets
to be at least 64 bytes in the the block-ipv6 code path
(ipv6_send_icmp_unreachable) as extra layer of defence.

Pushing a low mtu like 1 and also block-ipv6 could trigger an
assertion in the ipv6_send_icmp_unreachable code path.

Reported-By: Haiyang Huang <huanghaiyang83@gmail.com>
Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Acked-by: MaxF <max@max-fillinger.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1707
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1707
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
MaxF <max@max-fillinger.net>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 27cfd36..d24f534 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1598,7 +1598,9 @@
      * frame should be <= 1280 and have as much as possible of the original
      * packet
      */
-    const int max_payload_size = min_int(MAX_ICMPV6LEN, c->c2.frame.tun_mtu - icmpheader_len);
+    int max_payload_size = min_int(MAX_ICMPV6LEN, c->c2.frame.tun_mtu - icmpheader_len);
+    /* Ensure that minimum payload size is at least 64 bytes as extra safety layer */
+    max_payload_size = max_int(max_payload_size, 64);
     const int payload_len = min_int(max_payload_size, BLEN(&inputipbuf));
     const uint16_t icmp_len = (uint16_t)(sizeof(struct openvpn_icmp6hdr) + payload_len);
 
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index ca8109c..8f07e75 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -68,6 +68,11 @@
  */
 #define TUN_MTU_DEFAULT 1500
 
+/**
+ * Maximum MTU we accept for MTU related options
+ */
+#define TUN_MTU_MAX 65536
+
 /*
  * Minimum maximum MTU
  */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0c2866c..128d1e5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6409,26 +6409,28 @@
     else if (streq(p[0], "tun-mtu") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_PUSH_MTU | OPT_P_CONNECTION);
-        options->ce.tun_mtu = positive_atoi(p[1], msglevel);
-        options->ce.tun_mtu_defined = true;
-        if (p[2])
+        if (atoi_constrained(p[1], &options->ce.tun_mtu, "tun-mtu", TUN_MTU_MIN, TUN_MTU_MAX, msglevel))
         {
-            options->ce.occ_mtu = positive_atoi(p[2], msglevel);
-        }
-        else
-        {
-            options->ce.occ_mtu = 0;
+            options->ce.tun_mtu_defined = true;
+            if (p[2])
+            {
+                atoi_constrained(p[2], &options->ce.occ_mtu, "tun-mtu occ-mtu", TUN_MTU_MIN, TUN_MTU_MAX, msglevel);
+            }
+            else
+            {
+                options->ce.occ_mtu = 0;
+            }
         }
     }
     else if (streq(p[0], "tun-mtu-max") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
-        atoi_constrained(p[1], &options->ce.tun_mtu_max, p[0], TUN_MTU_MAX_MIN, 65536, msglevel);
+        atoi_constrained(p[1], &options->ce.tun_mtu_max, p[0], TUN_MTU_MAX_MIN, TUN_MTU_MAX, msglevel);
     }
     else if (streq(p[0], "tun-mtu-extra") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
-        if (atoi_constrained(p[1], &options->ce.tun_mtu_extra, p[0], 0, 65536, msglevel))
+        if (atoi_constrained(p[1], &options->ce.tun_mtu_extra, p[0], 0, TUN_MTU_MAX, msglevel))
         {
             options->ce.tun_mtu_extra_defined = true;
         }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
