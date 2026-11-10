Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67C606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U4BEKxHJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nKGw6c14;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RhJALD7x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xFQcmKQSfpOlHU5VkpLsEyI/m99LDFoWoCVnH1NTH5o=; b=U4BEKxHJOfpIal
	M4c5QTbqNy5hQAGXWS8pEu4VB2/vpWXzImW8Fott8TedKhZODm47VKGb6TSqg0OJ46Be/D1afQxU2
	EDnF8sP4XYWi31Rkm1jZxUKXbiNC5V1Eg5XHzXCYTZX7bzvp9NVEfZR+OnvvrmMHnxkDBjuv7jPQD
	H3Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQmyH-000000005UU-49n3;
	Tue, 10 Nov 2026 14:37:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQmyG-000000005UN-0k6w for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oiKerZ311hCMp6Rm9M3QWN4L05dPo+QnqEPczNBs0pg=; b=nKGw6c14B7XXZWbIH2fSWmz/xF
 EyV5AjDYH0A3M0CO4SyqpMLSDDE4+sESCjBZD+KfMOnJMCycl7kgIqrORcNhZO8tb4FdAWwjIztRo
 ys5ulJohIHZZ2Zc2qF8iLk8SJQqNyvCLS/qFl2nM9yWZVN0JcMlBiD1X5MeScrW85wDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oiKerZ311hCMp6Rm9M3QWN4L05dPo+QnqEPczNBs0pg=; b=RhJALD7xBOrRDM29Clb91/2sij
 c4I/C5+30guji9oxx8pAT0Mixgd6/gSQ8MlUap8rPC22irLMLn037PYVwtUEq55B4KlWUjDXPnCmo
 I2b1RvOMgLlz4YVz0Z9/llGZpBfFbQFl+6GpDdzMFspfN/SpPxSCWy1r+1D6O5eTPoFY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQmyE-000000008R1-3eEs for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:37:11 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AAEb3ji015175
 for <openvpn-devel@lists.sourceforge.net>; Tue, 10 Nov 2026 15:37:03 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AAEb3ZQ015174
 for openvpn-devel@lists.sourceforge.net; Tue, 10 Nov 2026 15:37:03 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 15:36:56 +0100
Message-ID: <20261110143703.15137-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794067506000.Ibc9eb15714f14a9f49366fc84072087fc3f013c9@gerrit.openvpn.net>
References: <gerrit.1794067506000.Ibc9eb15714f14a9f49366fc84072087fc3f013c9@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQmyE-000000008R1-3eEs
Subject: [Openvpn-devel] [PATCH v1] ssl_verify: reject an empty certificate
 fingerprint
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

verify_cert() compares the configured hashes over the length of the
computed fingerprint. With mbedTLS built without SHA-1 the SHA-1
fingerprint is empty, so the zero-length compare matched the first
entry and --verify-hash <hash> SHA1 accepted any CA certificate at
depth 1. Reject an empty fingerprint instead.

The compare length has come from the computed fingerprint since
2193d7c0 ("crypto: Enable SHA256 fingerprint checking in --verify-hash").

Change-Id: Ibc9eb15714f14a9f49366fc84072087fc3f013c9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2152
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2152
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0cdec1e..a5b57a5 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -697,6 +697,13 @@
                 goto cleanup;
         }
 
+        if (BLEN(&cert_fp) == 0)
+        {
+            msg(D_TLS_ERRORS, "TLS Error: cannot compute the certificate fingerprint for "
+                              "--verify-hash/--peer-fingerprint");
+            goto cleanup;
+        }
+
         const struct verify_hash_list *current_hash = opt->verify_hash;
 
         while (current_hash)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
