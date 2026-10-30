Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71E606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lhmuwTkI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SRTYoqZS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WzDeT/Kx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wbHqMegef/eXkk+LPzYuYvqAoOVKlPeRc1XV7YISwXM=; b=lhmuwTkIw3vEoe
	jg+dE6ug0Gs/iX/rMJ9NM4ISz588X6h/TLhejf4T1EQ7LWyIQ8VQWX5ovIziTNOExv4ynbHGXWucy
	HhkOA/3tqGfbtwH0guVAv30jKWlhi8TJZixozoonkpAbpg561ipBZHW5xX1JBkhaPyfGA8Mk4PzTo
	o7A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMmqV-000000000Y9-0ER2;
	Fri, 30 Oct 2026 13:40:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xMmqQ-000000000Y0-136H for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 13:40:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uwR90ntgGXPHtWzUgyXvvAN8GiWe/rdmhu9o5mMuz14=; b=SRTYoqZSEkmkUfXzbxmHbIMJrj
 Hj7wiSTu544SYgLuj8OsxrLdpfjU9WUD0AO5M1xEb9f7QNYVAwLJYbnNvyKZkWCBAszqjjvUWfLyz
 nrV8r8StssG0m9bGmx3w5S5WbGM6xv5MkH46T0XighkJM3qIzLLBY/2IIFvNYeuNhzz0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uwR90ntgGXPHtWzUgyXvvAN8GiWe/rdmhu9o5mMuz14=; b=WzDeT/KxYZbMVNjj1xVmyhMSH7
 qJCeBXlk7BpbmOK+Ol4U+bxKgU9vZxAMfn1tTeHLvQ1rfC9q3H+vQLn6I1evLdyX7slgTfCe7NVEL
 14HA32cZyDpo336OkXkB1ZCK9Jgb523VlUuwAW7AQJ/c3k4R7iqJjlWS6xRS8hNB+NaM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMmqO-000000006ZF-31m8 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 13:40:34 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69UDePld019818
 for <openvpn-devel@lists.sourceforge.net>; Fri, 30 Oct 2026 14:40:25 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69UDePlG019817
 for openvpn-devel@lists.sourceforge.net; Fri, 30 Oct 2026 14:40:25 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 30 Oct 2026 14:40:11 +0100
Message-ID: <20261030134023.19798-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
References: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xMmqO-000000006ZF-31m8
Subject: [Openvpn-devel] [PATCH v2] Do not hash real addresses of TCP
 connection
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

From: Arne Schwabe <arne@rfc2549.org>

With neither status report nor max-clients depending on TCP
connections in m->hash anymore, remove hashing of TCP
connection.

This now allows an obscure corner case of two TCP clients coming
from the same IP and port to different IP or port on the server
but as our operating system can handle this case, we do not have
a problem with that either.

This has a small added benefit to keep the number of entries in
m->hash a bit smaller.

Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2067
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2067
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 90270f5..dc1f896 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2455,13 +2455,22 @@
 
 /**
  * This sets up the client real address (outer tunnel addr) in the
- * hash map for data channel packet. If the address is already taken
- * this steps fails
+ * hash map for data channel packet lookup for DATA_V1 packets.
+ * If the address is already taken this steps fails.
  */
 static enum client_connect_return
 multi_client_connect_real_addr(struct multi_context *m, struct multi_instance *mi,
                                bool deferred, uint64_t *option_types_found)
 {
+    if (proto_is_tcp(mi->real.proto))
+    {
+        /* For TCP connection we neither need to be able to map incoming
+         * DATA_V1 packets to the multi_instance nor do we need to ensure
+         * that two TCP connections are not using the same address as the
+         * OS takes care of that. */
+        return CC_RET_SUCCEEDED;
+    }
+
     /* If the address is already taken up by another client we fail the new
      * connection */
     if (!multi_check_dest_addr_allowed(m, mi, &mi->real))


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
