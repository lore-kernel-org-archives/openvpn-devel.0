Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E2606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PDb4pOtd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VvR6YlJm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M13Ujnjt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=P9fjlIzeouAfPwThz1Mc4IOnS6qkRAS+Ft9R2AlzTrE=; b=PDb4pOtdwt1fsD
	Ru0jkSyf44RsXLah2Y4NCRoJnipnia4b7wAX3KF3Q9LuCuM7FgMeOkCL8NpviQRNUZxJbBJ/GEJsY
	cgk7kxN1vUertspmmytpp1zLIiDP+Fpvt+bP3UnEgwnRW6l7pQ1l3okcios6BE3YYf/d2kv1LXdHf
	7So=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO9FN-000000003AS-3Xxu;
	Tue, 03 Nov 2026 07:47:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xO9FL-000000003A5-3jFS for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 07:47:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I9WavMcTJ2mIlmAG9kwLs6roA5q6Ub3gtEmE1npwAhw=; b=VvR6YlJmKoHggXOd+WCtjSJd3A
 S0XUY+WAUvWv9PnXKKyqu7EFGdh+KVTxdapoRo2ULBVbbqCWWKmhw3b9KfbjcNqeNyDKaTj7yleJd
 JxPYsDl1pyjR1uMNWWJDkFCGeDu6m6GK91stJWaRrKxhKR8BrIuE6NkoSoriatcjo1sg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I9WavMcTJ2mIlmAG9kwLs6roA5q6Ub3gtEmE1npwAhw=; b=M13UjnjtZNuv0KIuyMXXMsN+on
 rgX5mNajNDGEWBT4OFJBkpFkqZKEc0I/cRRc3L3u24XL2GaD1i2/h9Hq/B/6w3+Wk1X7Badaf0Csl
 P4oU0r8iC6LllzP/5J7c3kMzSQL/L7krY4iYSZWFTUEbPPTNTyI+0gkd2Uycbq3ybG1w=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xO9FK-000000001c5-24Uh for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 07:47:55 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A37llAW006285
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 08:47:47 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A37llfK006284
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 08:47:47 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 08:47:41 +0100
Message-ID: <20261103074747.6269-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793689251000.I4bc08f4d7d8e5b33f951a3340df187da7253449e@gerrit.openvpn.net>
References: <gerrit.1793689251000.I4bc08f4d7d8e5b33f951a3340df187da7253449e@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xO9FK-000000001c5-24Uh
Subject: [Openvpn-devel] [PATCH v1] options: remove dangling
 pre_pull_default() declaration
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

The function has no definition or callers. The declaration was already
dangling in 6fbf66fa ("This is the start of the BETA21 branch..."),
the oldest commit in the history, so the commit that removed the
definition predates it.

Change-Id: I4bc08f4d7d8e5b33f951a3340df187da7253449e
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2100
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2100
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c58530a..1c908c4 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -929,8 +929,6 @@
                            uint64_t permission_mask, uint64_t *option_types_found,
                            struct env_set *es);
 
-void pre_pull_default(struct options *o);
-
 void rol_check_alloc(struct options *options);
 
 int parse_line(const char *line, char *p[], const int n, const char *file, const int line_num,


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
