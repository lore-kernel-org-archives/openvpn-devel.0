Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B860752A8
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kvwvFeSa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=efG8J3rN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YeNStAjG;
	dkim=neutral header.d=lichtenheld.com header.i=@lichtenheld.com header.a=rsa-sha256 header.s=MBO0001 header.b=hjcyjO+i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uj/gcUOUSYP4fn1wsKJimC7lkR1UnKVU1c0strCfCxA=; b=kvwvFeSaOR7cUJ
	Psi1k87C7QBfQsl2V4OuL3pDbjEuhsHGH0oLDedcEzV0auKDpXE0nigrPKRedUhk+ykRET4ugHduE
	+CBxmf5xJxlPQVeKxcYLj6glrx9thdjKFPo7uJmeAVGDJMDZHypAOTJn9WNfcVuraMWdmm9sdb4NW
	7tQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvNl-000000001ns-41q9;
	Mon, 02 Nov 2026 16:59:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <frank@lichtenheld.com>) id 1xNvNi-000000001nV-3GSP
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:59:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0163Zdf6d7AqUAOnC49lPrR5hZHSLVimAhSkHWt2MKI=; b=efG8J3rNbCWZ9ygvZENEQHeQFy
 y46b9o33lUGMR9/CLOvGcD2fJ2VFg+1yG+SLi+ou0om6amwW/lP/yPp06mE0ozzgQZllGMByy8k5e
 9WIxmpC0tdacmgBv5cdBUof7ES78mRhoQEgmngzjitTaphQ/g4lWOOTkwyjHe/SNOGtQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0163Zdf6d7AqUAOnC49lPrR5hZHSLVimAhSkHWt2MKI=; b=YeNStAjGuPbMMJMDj1rlNtZYj4
 LokyZTFg2cqEfult1u6MQZuWXw0MRcMB4H8bHXVxWPzjR/TEe3aTmKwvIqeiArlDeOGxubKmoi6DK
 XlXaEbTzYJAUsoiJ1ZFgAqv0j2loLRUSLdqOPxorrmNEpd01WcVjJI20YwWoHcFCjlOY=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNvNg-000000005vY-2Lkf for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:59:37 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jJHxD0q3DzMlfc
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 17:59:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1793638768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0163Zdf6d7AqUAOnC49lPrR5hZHSLVimAhSkHWt2MKI=;
 b=hjcyjO+i2dmXxgzGzwSwQAwgqoi0tJ1JyRjspHO3qctW4pN1tG0STiKTLpB4upxXqOjpe+
 asUdBM8y7i1a0mSKjcyjKZ8Tzt83D2wCNZIBCIlJ2XF5NUd8GbSOKdHalKkKG03CAqTOMi
 2O7zK4OzPGuJJzxqdOMgV9xxKO7heoW3UszzNNTTdq4OlAGP6wlc2/NltVigjXw14z+8zc
 gTKvIF9JnxsKFMthwMy+0m9dDCDufWYaJBIHZN/WOWLzlyeYarakpgguAnzZ5uWtPt6pHm
 Kf3Jfq4KcD8SlXDVGyF3FwyRoQ0729iVo65UKeO/BTRQrvH18USTL2x9hfk1+Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 17:59:27 +0100
Message-ID: <20261102165927.110589-1-frank@lichtenheld.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <gerrit.1793636884000.Ia0304e5ef5f8a553262a32d78ed21577973ee2e9@gerrit.openvpn.net>
References: <gerrit.1793636884000.Ia0304e5ef5f8a553262a32d78ed21577973ee2e9@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJHxD0q3DzMlfc
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNvNg-000000005vY-2Lkf
Subject: [Openvpn-devel] [PATCH v1] route: close socket in Haiku
 get_default_gateway()
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

The socket used for the routing table ioctls was never closed. Close
it on the early returns and right after the last ioctl.

Broken since 7da14925 ("Haiku: Add calls to manage routing table").

Change-Id: Ia0304e5ef5f8a553262a32d78ed21577973ee2e9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2093
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2093
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 0bce966..e8de2d5 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3719,12 +3719,14 @@
     if (ioctl(sockfd, SIOCGRTSIZE, &config, sizeof(struct ifconf)) < 0)
     {
         msg(M_ERRNO, "%s: Error getting routing table size", __func__);
+        close(sockfd);
         return;
     }
 
     uint32 size = (uint32)config.ifc_value;
     if (size == 0)
     {
+        close(sockfd);
         return;
     }
 
@@ -3733,7 +3735,9 @@
 
     config.ifc_len = size;
     config.ifc_buf = buffer;
-    if (ioctl(sockfd, SIOCGRTTABLE, &config, sizeof(struct ifconf)) < 0)
+    int ret = ioctl(sockfd, SIOCGRTTABLE, &config, sizeof(struct ifconf));
+    close(sockfd);
+    if (ret < 0)
     {
         free(buffer);
         return;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
