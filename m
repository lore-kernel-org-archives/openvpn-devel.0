Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7111606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pr8SddmJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OB0T64b0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gXtqMByV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5C3gv5w2sJJnUqhm+E9GGKWheYy7yXyif3PX73CPw2c=; b=Pr8SddmJlKjWtH
	CUTnU1Tr6T2U5SAQQhfCIyW8jvDA/CK+LJksCbyzZnZd0mCQ+Ja9fCKwZt7BHnWm1sqMlR6UXNgLY
	TSk0Gu72qHnUAucCjzsLXXa7MMuPbdN2XI8pdPtyqfpqjjbkRRN6sLq6foUJsagavbzKeP7aZAyH5
	WiQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLgXJ-000000008B4-0CTz;
	Tue, 27 Oct 2026 12:44:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xLgXI-000000008Ay-1Zyt for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:44:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MPTouUUW5iMyRT1y9zWj7nCE28qoj5bCdQMMAMtORw4=; b=OB0T64b0as4ycjc79eHOeFTW/0
 JAJXOTOjCiapm1+PxvxNCEOX06MmA7qWKH3/lJkbjWOqqlQbC2+iNo7wWV+WZesgWdogzH4xyOUli
 EKKsP4qD3H/yNehhJ6YPEP7c0t3c8R4Um75Q08gSMm/ZCkInreGXX6m4FGzFdds5LqBc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MPTouUUW5iMyRT1y9zWj7nCE28qoj5bCdQMMAMtORw4=; b=gXtqMByV3OPZklV6nAqOzrL8cX
 Fyq+U6yHrb3y/E07tbuI+t64n2R7lkPFeKCAIKsuYhYttY/iNfwUoJnc7krvLjcr58uXRr6yE4V2X
 Wz8d34hA91tz2efngaRDJwomYyg0EQxe2QDz6VRu32ghWDxf4Uv1NxC57SMP1XyiHUEY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLgXH-000000005gI-1mn7 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 12:44:16 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69RCi8pE000561
 for <openvpn-devel@lists.sourceforge.net>; Tue, 27 Oct 2026 13:44:08 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69RCi82A000560
 for openvpn-devel@lists.sourceforge.net; Tue, 27 Oct 2026 13:44:08 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 27 Oct 2026 13:44:02 +0100
Message-ID: <20261027124408.526-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793094393000.I1abb10515665e1d6351689d2c2dd9d4aba8bb98e@gerrit.openvpn.net>
References: <gerrit.1793094393000.I1abb10515665e1d6351689d2c2dd9d4aba8bb98e@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xLgXH-000000005gI-1mn7
Subject: [Openvpn-devel] [PATCH v1] multi_io: drop the read cases from
 multi_io_wait_lite()
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gianmarco De Gregori <gianmarco@mandelbit.com>

multi_io_action() only polls before writes: reads are dispatched with
poll false, both from the event loop and when chaining a tun read
after a write. The TA_TUN_READ and TA_SOCKET_READ cases of
multi_io_wait_lite() are never reached.

Change-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb98e
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2044
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2044
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index ac730b4..56216d4 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -235,18 +235,6 @@
 
     switch (action)
     {
-        case TA_TUN_READ:
-            looking_for = TUN_READ;
-            tun_input_pending = NULL;
-            io_wait(c, IOW_READ_TUN);
-            break;
-
-        case TA_SOCKET_READ:
-            looking_for = SOCKET_READ;
-            tun_input_pending = NULL;
-            io_wait(c, IOW_READ_LINK);
-            break;
-
         case TA_TUN_WRITE:
             looking_for = TUN_WRITE;
             tun_input_pending = NULL;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
