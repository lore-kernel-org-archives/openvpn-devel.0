Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE77E606A338
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DIiHhVX3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FdLMbvuV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZP6sQUpg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=v3TXCK2P6RaERYwGuWiJi4HfxhkzW0DMndGGiMZig18=; b=DIiHhVX3Byqedi
	Kf5NeOdyM2I0X5mCWKIp7Udp5+DVQSdQpw/QOJ53REGrxaV/YVx5JsGKZRftby3Tj7QujPMcU4myI
	qR13P0gqjm4lHHjcQQ7AdxQG5cLuQx7lb2zLqcp4lGVn0jmrvSB5HgQSVbgKBxHKxGIeHlJRuL7HX
	uuE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVUQw-000000003nZ-0774;
	Mon, 23 Nov 2026 13:50:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVUQu-000000003nR-11p6 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:50:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GqrFXO8qf0naRMzXxuJuW3fYNOdETeSu+EZb6Gt00mo=; b=FdLMbvuVgdmxk0pJUy8ZzISb7w
 p6pLejGZ3NnmZu/VLxhdPPxScVkhhO0vfcpCqG35YGGc4Gn7JFLbNY47DzLBd3gLBft3uY0VoFze8
 G4I7OzFVCH8VOcM/iGHNmttI7plOAQI5SywXpEF4e9wqWrrFeBnxtCFlLVHmkkoGMGcY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GqrFXO8qf0naRMzXxuJuW3fYNOdETeSu+EZb6Gt00mo=; b=ZP6sQUpgK6X4JqbCtUoS3hdFBj
 fexxr+qHzswJdtRLmksZrTH2uKsxNVYquWRD9BjXL06s0rf8+6f9ffPyaSnjZVbNV38OmUqTgLoto
 8N8MlyMx/Ri5KxdKJxKiYN3jum08h8x/6Yxy8NBKRDAZxnMyAwoKMMBmFTsfxTy176vI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVUQs-000000003dR-1bQv for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:50:11 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ANDo3Y9031937
 for <openvpn-devel@lists.sourceforge.net>; Mon, 23 Nov 2026 14:50:03 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANDo3Ea031936
 for openvpn-devel@lists.sourceforge.net; Mon, 23 Nov 2026 14:50:03 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 23 Nov 2026 14:49:58 +0100
Message-ID: <20261123135003.31908-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
References: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVUQs-000000003dR-1bQv
Subject: [Openvpn-devel] [PATCH v2] manage: free ext_cert_input in
 man_connection_close()
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

ext_key_input was freed there, its certificate counterpart was not.
While here, pass mc to in_extra_reset() like the rest of the function.

Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2237
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2237
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 86c498e..a5b635d 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2860,8 +2860,9 @@
 
     event_timeout_clear(&mc->bytecount_update_interval);
 
-    in_extra_reset(&man->connection, IER_RESET);
+    in_extra_reset(mc, IER_RESET);
     buffer_list_free(mc->ext_key_input);
+    buffer_list_free(mc->ext_cert_input);
     man_connection_clear(mc);
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
