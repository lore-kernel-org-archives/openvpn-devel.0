Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B7606A93E
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=L4MOnYjA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LKBjeRHy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f0t048Bn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TEncv+Bifgg3hrQ2S74U5CWd0oidBhO6759ArNUCbs0=; b=L4MOnYjAUfDFxJ
	iKkBufE54XIpwJTwesd+41vYog3GWXUdQ+2JTS1GirQS772g4q6tvP0tkVW+/QT0a8kl9mkXB21Rl
	WYvV/XYc/dNtVQAEzeRSQqUpbHQhBRKscL8UkB+ggi4ZRnilHLnk9+ysdwKa06p0TD3hh5jWb740O
	AHQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNtLR-000000002N8-0gE6;
	Mon, 02 Nov 2026 14:49:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNtLP-000000002MZ-2hBp for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:49:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=McjERsIh5scw81GC4eKekq5ZlO5HBmCIsVzawxvyztk=; b=LKBjeRHynDHDmFj9FSH0ISeWkR
 cHhFPbDeP2dBh3KdS44nfo4DJ/X+k9yRgeNUbgyF8qKwuN94x4Qc+Nup0UQD+4RvliTvX6ZIUSBmp
 FFK4XGt5y9m52RkFohcUuKnZ06oVPTCkYbyBKJaLUX6l2Dy8/lbbqsefHC4yDd5KXSNU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=McjERsIh5scw81GC4eKekq5ZlO5HBmCIsVzawxvyztk=; b=f0t048Bnj5xXKNkiOAWbAlLydv
 WN0yOLJF2zomnXTn6yU++RwMSB9cq0HMCWVZU3YhjxjZh3uEdlJSVG74eweUUeofQW2RV1uZrxKs5
 NY/wB4oBNmUGZxvnKmv2YGzlSOnMk5+TXy/9M6D1TxUIhF+2RUL0PLP5id5JXnL5McjM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNtL9-000000002GC-1ig4 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:48:53 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2EmiB7000935
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 15:48:44 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2Emi8o000934
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 15:48:44 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 15:48:38 +0100
Message-ID: <20261102144844.910-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
References: <gerrit.1793629964000.I80b9969f555d670bc101635318d245d1b2de8ec5@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNtL9-000000002GC-1ig4
Subject: [Openvpn-devel] [PATCH v2] tun: free gc arena in windows_set_mtu()
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

The arena used for strerror_win32() was never freed. Allocate it
only on the error path, where it is used.

Broken since 0213f80e ("Set the correct mtu on windows based systems").

Change-Id: I80b9969f555d670bc101635318d245d1b2de8ec5
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2092
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2092
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index fdd13ae..58f4750 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5203,7 +5203,6 @@
 windows_set_mtu(const int iface_index, const short family, const int mtu)
 {
     DWORD err = 0;
-    struct gc_arena gc = gc_new();
     MIB_IPINTERFACE_ROW ipiface;
     InitializeIpInterfaceEntry(&ipiface);
     const char *family_name = (family == AF_INET6) ? "IPv6" : "IPv4";
@@ -5228,8 +5227,10 @@
 
     if (err != NO_ERROR)
     {
+        struct gc_arena gc = gc_new();
         msg(M_WARN, "TUN: Setting %s mtu failed: %s [status=%lu if_index=%d]", family_name,
             strerror_win32(err, &gc), err, iface_index);
+        gc_free(&gc);
     }
     else
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
