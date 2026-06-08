Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72403CD8C9F
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GTBNcw2aZSvakQoLEvjlg9u/aMADNhEYeXZt0puff2o=; b=erIwHA/uXmcyfclXlS0huLLtsp
	DZFMB/SGNFjkMxl8vk0Q9iY/NkmAalGSfkERv1NM0YvA2NDOh938mU75aFUVqSOyTJ3fhPEB1N8TA
	e/9SgCUENkjXlNw6hrFXRVR3XH0ivk+oG4OE+Ef5ltRMlcp4LuOttCu7zcRSAClrv69w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWYvj-0001kl-Nz;
	Mon, 08 Jun 2026 12:18:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWYvi-0001kc-1m
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o2GSitftwWWA2lrrEBg4QPUmDaXq1e6AbZZXld+JlYI=; b=aVO5ITqzFC1t5dXs5qTBHCMTQ0
 0/BpKacuxbo/JQ8voH49dxL+zTufTuP3QQ4nOCzWEEqs3KUmyzdrD7y9b2LbUh+Lk9CqkYqkOXt57
 djrmxrXOhZ98+DmZZsIDVVO3Ctu8mOaKFe1suBWuaOAc0m1StDgqqLW8LupbPokVc+g4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o2GSitftwWWA2lrrEBg4QPUmDaXq1e6AbZZXld+JlYI=; b=CWDhikmfWx1y4V73W6HKj2AjvT
 M5CqpxGh0VaEoUskNeH5CsdkqeCeomd9+Qmx5YUZ3+MUCeezTIzTOILTSLUkVo9RsOY0gXgULZwPZ
 hFN3U//s0wJUoX28a25baXsmkFQHu/uc36AzqxKjU9pZ/ujhkwHiiIwPaZ+eU4mFd650=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWYve-0005DD-Hy for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:18:09 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 658CI0uq010136
 for <openvpn-devel@lists.sourceforge.net>; Mon, 8 Jun 2026 14:18:00 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 658CI0O3010135
 for openvpn-devel@lists.sourceforge.net; Mon, 8 Jun 2026 14:18:00 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  8 Jun 2026 14:17:54 +0200
Message-ID: <20260608121759.10121-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1780919555000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
References: <gerrit.1780919555000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWYve-0005DD-Hy
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
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1708
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1708
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index e43ce28..2255951 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1610,6 +1610,8 @@
      */
     int max_payload_size = min_int(MAX_ICMPV6LEN,
                                    c->c2.frame.tun_mtu - icmpheader_len);
+    /* Ensure that minimum payload size is at least 64 bytes as extra safety layer */
+    max_payload_size = max_int(max_payload_size, 64);
     int payload_len = min_int(max_payload_size, BLEN(&inputipbuf));
 
     pip6out.payload_len = htons(sizeof(struct openvpn_icmp6hdr) + payload_len);
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index d3df5b2..70ec43d 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -69,6 +69,11 @@
  */
 #define TUN_MTU_DEFAULT    1500
 
+/**
+ * Maximum MTU we accept for MTU related options
+ */
+#define TUN_MTU_MAX 65536
+
 /*
  * MTU Defaults for TAP devices
  */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 044aab3..ea640da 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6552,7 +6552,15 @@
     else if (streq(p[0], "tun-mtu") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);
-        options->ce.tun_mtu = positive_atoi(p[1]);
+        int mtu = positive_atoi(p[1]);
+        if (mtu < TUN_MTU_MIN || mtu > TUN_MTU_MAX)
+        {
+            msg(msglevel, "--mtu parm must be between %d and %d.", TUN_MTU_MIN,
+                TUN_MTU_MAX);
+            goto err;
+        }
+
+        options->ce.tun_mtu = mtu;
         options->ce.tun_mtu_defined = true;
         if (p[2])
         {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
