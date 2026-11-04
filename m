Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0AF606EEA0
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FdIEN6JH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jK4pGPpA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SGoaKGan
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/z7T13eUgqD+lbHWFwjawH8v8k01KxjIc5tDsZB60qc=; b=FdIEN6JH9/WUgO
	IARec77SRBu7vzOW2D/H0IhwGsOCZDI6wEtNrZ0J4cfIkpK962mbT/x+gcojUdoYjeaqAqHhG4vJt
	8OX97+9xmVx12HBNU9+UVtqkDtyc7sEGcF2EyjDrmfhIi/GDRpLrXkqHZgt+I30TLxpFt4ZNAd80+
	wSE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaRr-000000003yU-3P4x;
	Wed, 04 Nov 2026 12:50:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOaRq-000000003yN-2iiT for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:50:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QruChIZ8ak5adKqW/7m+wWsg+8tkfI6hGVYMCbTw/qc=; b=jK4pGPpAjzkCHXO1Anvkzzf8Vp
 hAPf1h/Qxg6s81VeZ9blK+0w0WIFl5hODzOsq2sSjVMnbD338JkcO/BCBwTvYxbeuXvc7195EDJJJ
 aSNGaGIr7d/o9fzO+SbwPOe/bI91Jq/4gAKnLR54MTrW7AB1+G5PHVSKMbIp5HmgnIjY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QruChIZ8ak5adKqW/7m+wWsg+8tkfI6hGVYMCbTw/qc=; b=SGoaKGan/JKawgM9ogYenWQY2X
 qA4O1owQ6ZXTL8badYDKoHiBBqkaT5AZpg4devzJT6rPiV5SlcprFR39WJEuwcu0qXF7GgEVgNbPO
 7HeU0NRGeaH+xYwM5+O92FUvWbrrjg4oQ0Gf7tslDwqdMrbmDzHRXTeN3dXk/6CjRBog=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOaRo-000000002r6-1yIL for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:50:38 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4CoTWh018726
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 13:50:29 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4CoTMl018725
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 13:50:29 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 13:50:25 +0100
Message-ID: <20261104125029.18712-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793776745000.Ieee93e625bd25f1f674ce1c3b6475fd73770c73f@gerrit.openvpn.net>
References: <gerrit.1793776745000.Ieee93e625bd25f1f674ce1c3b6475fd73770c73f@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOaRo-000000002r6-1yIL
Subject: [Openvpn-devel] [PATCH v1] lladdr: pass S_* flags, not M_WARN,
 to openvpn_execve_check()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

The flags argument takes S_* values. M_WARN shares no bits with them,
so this is no functional change.

Change-Id: Ieee93e625bd25f1f674ce1c3b6475fd73770c73f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2119
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2119
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index 195245f..554975c 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -36,7 +36,7 @@
     struct argv argv = argv_new();
     argv_printf(&argv, IFCONFIG_LLADDR_FMT, IFCONFIG_PATH, ifname, lladdr);
     argv_msg(M_INFO, &argv);
-    int r = openvpn_execve_check(&argv, es, M_WARN, "ERROR: Unable to set link layer address.");
+    int r = openvpn_execve_check(&argv, es, 0, "ERROR: Unable to set link layer address.");
     argv_free(&argv);
     return r;
 #else


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
