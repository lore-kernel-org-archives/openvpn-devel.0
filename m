Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FF7C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lz+NcBXIBzolFkEgzmVCFAMD84w6vBAJYThZ5ZUs770=; b=GUSE44FuC+9Qo9NDNHWH+fau4y
	uR+wGsWJmFsHo7HB1QaqUBWPb9D6KWbkuiWSH6vflxD1wD6SIUU2HY5fFf7Tpk68xqLPRY1wl04If
	o48D8nGjx3VnyUt7wDx5bmrfl4o5PYnU2N0RhyejRKNnMIcwHDoCbEFJr1IRHKz3BmbI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woxzs-0007x9-J7;
	Wed, 29 Jul 2026 06:42:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1woxzZ-0007wp-4f
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 06:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8+BSLFbXUhug7jXC0cN4Q1591tzJVGqwKBgkeE7UD4U=; b=DnI1oNHKSoqucIEBu1hfXmnQ2E
 2yg/HtBYegD56kC3mT/Vq74trduHNE73Ts/6jx+XpvHZQPH+2qRAQpk50izIY3AhA6YbUgTvNLIuJ
 PrMzskDWJxACHw/FGWF/0Jkykng7ObqrwnUaN4Efg+EvZe91RPW3v1lxsNgqScKS4hGM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8+BSLFbXUhug7jXC0cN4Q1591tzJVGqwKBgkeE7UD4U=; b=jrYXEsdulrUe0zebYD7hhYJq8b
 p3d1PHram+wnpxr8KhcQoChsAotAHIQxwhDmUvVmx9sxXACEXlPcxtINqS9IqudRkUv8jwCHkBjnE
 2y/jCkVO1HEe8+1GiHtvtAX6SXL8kSemnuDTuIv3njtgyrMVrqd4miQgwaAWHFuNMVaA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woxzS-0004GZ-90 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 06:42:09 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66T6fwJo015760
 for <openvpn-devel@lists.sourceforge.net>; Wed, 29 Jul 2026 08:41:58 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66T6fwJd015759
 for openvpn-devel@lists.sourceforge.net; Wed, 29 Jul 2026 08:41:58 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 08:41:52 +0200
Message-ID: <20260729064158.15731-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
References: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1woxzS-0004GZ-90
Subject: [Openvpn-devel] [PATCH v2] Correctly calculate packet id size when
 epoch packet format is in use
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

The code assumed that always when tls mode (without CFB/OFB) is in use
that the packet size is 4 bytes. With epoch packet format is incorrect
as that uses 64 bit.

Even thought packet_id_long_form has a the same size (8 byte) it is not
the same header format (32 bit time + 32 bit IV) as the epoch
format (16 bit epoch + 48 IV). Use a simple sizeof(uint64_t) to
avoid suggesting that it might be the same.

Closes: Github #1074

Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1829
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1829
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index e5db8ab..1f64a8a 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -35,6 +35,7 @@
 #include "crypto.h"
 
 #include "memdbg.h"
+#include "ssl_common.h"
 
 /* allocate a buffer for socket or tun layer */
 void
@@ -51,6 +52,13 @@
 calc_packet_id_size_dc(const struct options *options, const struct key_type *kt)
 {
     bool tlsmode = options->tls_server || options->tls_client;
+    bool epoch = options->imported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT;
+
+    /* epoch uses a 64-bit packet ID consisting of 64 bit (24 bit epoch + 48 bit IV) */
+    if (epoch)
+    {
+        return sizeof(uint64_t);
+    }
 
     bool packet_id_long_form = !tlsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
