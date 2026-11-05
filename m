Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE0606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Lb79qD77;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CJmRAZeI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Scx6iQi7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8msGQedw9chdpQkDLwEuQpxAx89iYrFDKNwldb4rbLs=; b=Lb79qD77cVuqq7
	a9P68PGwk8HKBjSFAtH+bjND2ZRQnc0Ek/uwmqejWa+RegbOfYDEBu6QN2LEh85RsGXLfiClYoYKx
	zG7D6wKsbdo1yuTjQD+uhFvyLh5OB7IfU1+7ZK8ww79+a3nAuJSdsQaFD8PN66L9bSdkLGOuxvymK
	jxs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOtuV-000000001qB-2Y5S;
	Thu, 05 Nov 2026 09:37:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOtuT-000000001q3-2lD1 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 09:37:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rohbIsfYla/sJeVVJbSzgwdur/vRW/0q1c6vWfuzzfQ=; b=CJmRAZeI98h79zUDTNkRoN/Oo7
 LHro78qjYG2C1C+NcWm/lqWL+S4PmKFKCqJHliwT6wNiC7hE2HnkFYC31LKm6VWyFe7RCrK8HLnOH
 l/20+E81bZOsq57Wr8aKgXyrpryzhWHLQU7uz5xjOyvrSa82XXO4foov2ju6jpSXPEJI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rohbIsfYla/sJeVVJbSzgwdur/vRW/0q1c6vWfuzzfQ=; b=Scx6iQi7P9FydbN4X52YEmcUYu
 0fc7wpNY90G2P/xMXxyyrKCfgWDbIFGP3waTjXbmXOwE0J0fw//CnsN9kNd/DWwih9xrBoRA/XU/b
 5S3COabLpcq1qKEgNWwzlN2U1eWfbRL4d4JMFDjtlpmBgjY/+RQlMlJSGHzw+egIvR58=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOtuR-000000003k9-2fks for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 09:37:29 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A59bK5t011797
 for <openvpn-devel@lists.sourceforge.net>; Thu, 5 Nov 2026 10:37:20 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A59bKXY011796
 for openvpn-devel@lists.sourceforge.net; Thu, 5 Nov 2026 10:37:20 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  5 Nov 2026 10:37:12 +0100
Message-ID: <20261105093720.11781-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793496732000.I4d35f54402460c5866aeba26216ac1b2d2f8ebdc@gerrit.openvpn.net>
References: <gerrit.1793496732000.I4d35f54402460c5866aeba26216ac1b2d2f8ebdc@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOtuR-000000003k9-2fks
Subject: [Openvpn-devel] [PATCH v1] ssl: Wipe the key source material in
 key_state_free()
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

From: Hansaem Wi <hansaemw@gmail.com>

ks->key_src holds the pre_master and random values that the peers
exchange in key method 2. It is wiped after the data channel keys have
been generated and on the error paths of key_method_2_read() and
key_method_2_write(). When a key state is freed before the keys are
generated, for example because an --auth-user-pass-verify script or a
client-connect script rejects the client, key_state_free() frees it
with plain free() and the key material stays in freed memory, on the
server and on the client.

Wipe it with secure_memzero() before freeing it.

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: I4d35f54402460c5866aeba26216ac1b2d2f8ebdc
Signed-off-by: Hansaem Wi <hansaemw@gmail.com>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2075
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2075
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 086a6fc..eef8e7d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -934,6 +934,10 @@
 
     free(ks->rec_ack);
     free(ks->lru_acks);
+    if (ks->key_src)
+    {
+        secure_memzero(ks->key_src, sizeof(*ks->key_src));
+    }
     free(ks->key_src);
 
     packet_id_free(&ks->crypto_options.packet_id);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
