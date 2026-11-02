Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10B606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Xpn0m2rg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eFY8pM4H;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YUwMx8Ul
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Kg6ka3k3/Omx/YtUtiE1nGtVZzlgKXNbpjZrO0owAGY=; b=Xpn0m2rgioubZJ
	UMTtx4Y+j0WAYhozgg7FqZPEJcNa498QXt4MDwjgrBknMfp7TwfX215Em+AokXAEI1KFkdognSWcU
	hlzg6mq5SsPnxcYP3xKSXzJZK2b0MIAjiPh70tKOgiuAQVejhYoLeFH7jHLjOed/Ld6VNd5n0LPDt
	bug=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNspS-000000005Vz-3L6c;
	Mon, 02 Nov 2026 14:16:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNspR-000000005Vm-1buC for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:16:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lT8mOmb+keS5Dx4HJVFFz0jI4t7sqqY4tZIWgQEcNVE=; b=eFY8pM4Hna+uB1T/FZ8tcRiJlX
 0APcKJTpl017HXIoogzDZcLoc2IdAfkB0qLkLGVyDAeI+3BcQhQO3wI+PMZCwIZCyR7Bw9llkKH1I
 W0zC1ZuiSz3lNWsc3bbgRl6Eu65ewv/bAxb7PifJDwRd351BLxJBtf7KyqLyg7eDrHE4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lT8mOmb+keS5Dx4HJVFFz0jI4t7sqqY4tZIWgQEcNVE=; b=YUwMx8UlgjojoZ+3q0233AfK0v
 CTDdcrOjUdx/dAf2okCmqo8pJ5BIlWh5RUFq59et6fu/Qlc7tR7JFVReM6zLZfmnJLL9EQqCwT5T3
 72VDTRFnJ09oXdY9/vxb8gp8mZzM/z4uXwJn1jTAJxYtqeY19fmrZVBL8KddvlH/+z3s=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNspP-000000001Ir-11b9 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:16:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2EFuOG029922
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 15:15:56 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2EFuVQ029921
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 15:15:56 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 15:15:51 +0100
Message-ID: <20261102141556.29908-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793623141000.Id6587b3d44d3326cae83c460cd85e8570ee8666a@gerrit.openvpn.net>
References: <gerrit.1793623141000.Id6587b3d44d3326cae83c460cd85e8570ee8666a@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNspP-000000001Ir-11b9
Subject: [Openvpn-devel] [PATCH v1] crypto: assert opt before first use in
 openvpn_decrypt_aead()
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

opt was dereferenced before ASSERT(opt). Move the assertion up.

Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2089
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2089
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 3d3ab0c..498c327 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -440,6 +440,7 @@
     struct gc_arena gc;
     gc_init(&gc);
 
+    ASSERT(opt);
     struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
     const bool use_epoch_data_format = opt->flags & CO_EPOCH_DATA_KEY_FORMAT;
     if (!use_epoch_data_format && cipher_decrypt_verify_fail_exceeded(ctx))
@@ -450,7 +451,6 @@
     const int tag_size = OPENVPN_AEAD_TAG_LENGTH;
 
 
-    ASSERT(opt);
     ASSERT(frame);
     ASSERT(buf->len > 0);
     ASSERT(ctx->cipher);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
