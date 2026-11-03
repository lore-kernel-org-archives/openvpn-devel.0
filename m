Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4F606A333
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cP4IyBeY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EfQeGg4Z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=X78yhIz2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=g8zM5DZRvtiT4pH7WYuj8X80EYOmkbdwCh9IsBzrgF4=; b=cP4IyBeY86C/my
	3CqvK8koO5BL4OR4EX8Hi5WIBavU1azmzszKWV1JO8TGsVNHmqv+Wdgj+ZNa937OcwA5oRRGTRLPy
	Kpa7xO3jnhCMrqPb8iF69kdDwji+Z91BjpSwbaFovnxkWln6F4LOh+sIT4vaq0sXx1BmRqJCU2AkA
	AJI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODjE-000000003bw-04AZ;
	Tue, 03 Nov 2026 12:35:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xODjD-000000003bq-1SLh for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:35:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=86bvpoR3MD0fr+A+PhBiZ/W+/6Wp48dGmppJEjclMzQ=; b=EfQeGg4ZS+2w4iTNLMvKAkqSUt
 bLAuO+xpHj6YxpfCguxcCQiA/3MltUmjtj/CtKGPN015nOTWDfBuPBOLKi0U8g6V7soG1rUJtMCJd
 PooCbYDEJrdRGCWQGk3XOMVPwxAZnYuUuzzS9RKdAIss6UImq/oOSTO8hCQ1sAHt52A4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=86bvpoR3MD0fr+A+PhBiZ/W+/6Wp48dGmppJEjclMzQ=; b=X78yhIz2gw5DqvBTpA/D6HpMV/
 XVzlrm4eZdyPutxB/9ebBI85mz2YUlSc01fumOgmcq0Iwf7ynFNlJ3Q64B/NjMWKsjWuAejpgXK/2
 kWnrUx1RS6BLDFpEuOi3BfYBdDM8YshJm9xHT4ple7O9Hx/x1UqoXG5S9ssy8EjkhWGI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xODjC-000000003bC-1ZWM for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:35:03 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A3CYtqb004079
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 13:34:55 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3CYtkC004078
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 13:34:55 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 13:34:50 +0100
Message-ID: <20261103123455.4065-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793704368000.I88ea70e88c3ec133261210e0404f324bbf025d9b@gerrit.openvpn.net>
References: <gerrit.1793704368000.I88ea70e88c3ec133261210e0404f324bbf025d9b@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xODjC-000000003bC-1ZWM
Subject: [Openvpn-devel] [PATCH v1] proxy: free proxy_authenticate in
 http_proxy_close()
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
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

The Digest challenge stored by store_proxy_authenticate() was never
freed when the proxy info was released.

Reported-by: hz86 https://github.com/OpenVPN/openvpn/issues/1134

GitHub: closes OpenVPN/openvpn#1134
Change-Id: I88ea70e88c3ec133261210e0404f324bbf025d9b
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2104
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2104
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index c3ad7de..7b5a289 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -523,6 +523,10 @@
 void
 http_proxy_close(struct http_proxy_info *hp)
 {
+    if (hp)
+    {
+        free(hp->proxy_authenticate);
+    }
     free(hp);
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
