Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED39C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pULh7bCJE7w8DVnTGTDJI4WuIejVLFEV7HNBN7A5rvI=; b=HzXTSMMsUvQbm5smKTsmCLFGgR
	8k8iMCNXSE1H/VL5BdsU3eCkomXi/CDPVwYCTFqtgMNN6agAlZ91diyIOY0yBBXaHQKujhqIAfwnE
	7R0wiLCL+EPla8vknU90gxkY0K6jkuw9i2Fkx+JUq9eIiIw9e9pgGdfrVQpzf8uZvgN0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whUJL-0006h8-3o;
	Wed, 08 Jul 2026 15:35:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1whUJA-0006gn-1t
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:35:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=In63TbsoHpafRMlIuj/hoWLLKn/bdKNJXZWfh9Z7m5w=; b=c88RbSXOkZM2YfMMg3DWxLi6JM
 +EwzW0x7X683lJpZiXHB9RumTkW1Z62UVbAtRVfO28e3x3Ij3PyR3oCn+btwGQqLmksKshXvT5r09
 lTf8gkw3OCr8wsTN8sSCAQhpo8Lkc94H6wRs94qP5PBZfiJ3kkxGUVx21x2VrgCDWRio=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=In63TbsoHpafRMlIuj/hoWLLKn/bdKNJXZWfh9Z7m5w=; b=lRBI5EjibQcF1stFFu3tifvzVV
 80JnRST0gTtTmsA4wqUkBIWbFICkKFXUQogbU28OJDiw7PEkzBesDqVB0WpMWvg4Usux3CCfexbnK
 IXiFXLkRewjfDz8aw4OPreECqEX/yfWdh4UdtBOSs2NVdzd5kyAOzTBfiaKZg+jwaZDA=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whUJ5-0007uN-Bw for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:35:30 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gwMc20NSMzMlKk;
 Wed, 08 Jul 2026 17:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1783524914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=In63TbsoHpafRMlIuj/hoWLLKn/bdKNJXZWfh9Z7m5w=;
 b=uUDovwfexaSAHM2PcLrOA8vyCufj6bvEjepJGBTw5XnnHvBOoHR17S+11GG1TEh0gUUDw8
 zVIjYamqfXjyB02d2ie0G8/tdpEkDK6ZWBQfAVzZR1diMIO1AODFT6OmeGrvXEFagFTMNn
 QqtTlYDEvb2e3VDNv/28Scow89AH6Y3GjrdoEflEbxv9PJN8VgnBTAxXGCezJrtVbUaguM
 sHr+76Cym1W2YN9kmU4/6Bxa2escrfTujP5DPzjiIi++ZfKs+m3XJ/JRkg5tnLc/lX+VRh
 QVxJJiuB2IAhktZDgHqGldHkMhRL4odQsdNF/G571vyvAax24Qir2ET3qMXOFg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  8 Jul 2026 17:35:12 +0200
Message-ID: <20260708153512.61577-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
References: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gwMc20NSMzMlKk
X-Headers-End: 1whUJ5-0007uN-Bw
Subject: [Openvpn-devel] [PATCH v6] Only announce support push
 updates/IV_NCP when actually supporting it
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

Currently even p2p clients that do not accept push message, so announcing
PUSH UPDATE or DNSv2 is not very useful.

The change for IV_NCP is more a documentation bugfix as in mode server
we currently never have push_peer_info_detail > 0.

But change the message to indicate that IV_NCP nowadays is more a
legacy variable and replaced by IV_CIPHERS.

Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1634
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1634
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 044e852..b95a84f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1961,21 +1961,21 @@
         /* support for P_DATA_V2 */
         int iv_proto = IV_PROTO_DATA_V2;
 
-        /* support for the latest --dns option */
-        iv_proto |= IV_PROTO_DNS_OPTION_V2;
-
         /* support for exit notify via control channel */
         iv_proto |= IV_PROTO_CC_EXIT_NOTIFY;
 
-        /* currently push-update is not supported when DCO is enabled */
-        if (!session->opt->dco_enabled)
-        {
-            /* support push-updates */
-            iv_proto |= IV_PROTO_PUSH_UPDATE;
-        }
-
         if (session->opt->pull)
         {
+            /* support for the latest --dns option */
+            iv_proto |= IV_PROTO_DNS_OPTION_V2;
+
+            /* currently push-update is not supported when DCO is enabled */
+            if (!session->opt->dco_enabled)
+            {
+                /* support push-updates */
+                iv_proto |= IV_PROTO_PUSH_UPDATE;
+            }
+
             /* support for receiving push_reply before sending
              * push request, also signal that the client wants
              * to get push-reply messages without requiring a round
@@ -1990,11 +1990,9 @@
 
             /* support for tun-mtu as part of the push message */
             buf_printf(&out, "IV_MTU=%d\n", session->opt->frame.tun_max_mtu);
-        }
 
-        /* support for Negotiable Crypto Parameters */
-        if (session->opt->mode == MODE_SERVER || session->opt->pull)
-        {
+            /* legacy support for Negotiable Crypto Parameters (deprecated in
+             * favour of IV_CIPHERS) */
             if (tls_item_in_cipher_list("AES-128-GCM", session->opt->config_ncp_ciphers)
                 && tls_item_in_cipher_list("AES-256-GCM", session->opt->config_ncp_ciphers))
             {
@@ -2003,7 +2001,7 @@
         }
         else
         {
-            /* We are not using pull or p2mp server, instead do P2P NCP */
+            /* If we are not using pull we announce P2P NCP support */
             iv_proto |= IV_PROTO_NCP_P2P;
         }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
