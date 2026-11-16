Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7F2606A895
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iXZtNcP8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=f4o87qSq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Yp88iFez
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LlGKfataidE2hkqa17xvv0Ax8npOQv9bseDm0Atv9gA=; b=iXZtNcP8sxhr5j
	9mg0NNTvbeheKFTdwtihqOO4/xn9bBoVGdh4Bxth1a6kUyxa66MOn2Z72j2jvXFPC/+xfFfW1rYxZ
	H8ihRiwr1okzvnnXHXOVHQ/0JtXZwPhusgL8EkeZp/tq6kFxUzt3ncuLTx+8kVFDp1oy4CuZnpd8U
	g5M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0e6-000000006BQ-1yKK;
	Mon, 16 Nov 2026 17:37:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xT0e5-000000006BK-3pax for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DXP6q2ud84BrjjsM3/NysTmhFOfas9rfAQwzkNBEuz4=; b=f4o87qSqAS51+WqzzNj1mTbkwn
 E67uA7dllK3Wpq8NienVg4j6No9dhGpQfY7VT8v2VbAvMSJMXzHlodXqoF4ANOnfl9B3HQlnPz0ak
 +aHR+ufG2M1nyc35lHRKAyiHJ6ndnA0TJYix5vzdXpw/09B9vlf8DpXY90HJRmwjISus=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DXP6q2ud84BrjjsM3/NysTmhFOfas9rfAQwzkNBEuz4=; b=Yp88iFezduRo20yIgBlPxke0HY
 DYPMDm5Wj2vcLKZUogfE0I9ZM2wMofYnlbWY6vNCFICQenABzOTap4w8WgWIO9WT6DHUuY1YOhqP5
 gXpo8Nepas+xTgHWjrbTP7h6qVdW5OKZO7GJsgck+T835dm0/0fwzU7Pg8lGaJpjHgX4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT0e4-0000000052q-2rBX for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:37:33 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AGHbQ3H024599
 for <openvpn-devel@lists.sourceforge.net>; Mon, 16 Nov 2026 18:37:26 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGHbQRF024598
 for openvpn-devel@lists.sourceforge.net; Mon, 16 Nov 2026 18:37:26 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 16 Nov 2026 18:37:19 +0100
Message-ID: <20261116173725.24585-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794828082000.I604fdff9c0a7cbbddfd025a72e6f19a96bb51753@gerrit.openvpn.net>
References: <gerrit.1794828082000.I604fdff9c0a7cbbddfd025a72e6f19a96bb51753@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xT0e4-0000000052q-2rBX
Subject: [Openvpn-devel] [PATCH v1] crypto: drop redundant epoch assignments
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

init_key_ctx() already sets ctx->epoch from the key parameters.

Change-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2190
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2190
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index db1cb41..dda6702 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1040,7 +1040,6 @@
     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_ENCRYPT, log_prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
-    ctx->epoch = key_params->epoch;
 }
 
 void
@@ -1052,7 +1051,6 @@
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, log_prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
-    ctx->epoch = key_params->epoch;
 }
 
 void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
