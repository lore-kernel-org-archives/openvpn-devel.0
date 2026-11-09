Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82F606A334
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cbSW6+MR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B3Ir29Zx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Jw0CBJEh;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=LzrMBtub
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=a4ws/NRpKKny0gXw7cJ8nvLi/nuXf4BcHX6Pr6cnYo8=; b=cbSW6+MR6B/xyt
	xV01EVCgx7RzPIfY1RyYE/BCSZdO2GKRDODS1AVgL4vjcNm8fJIKx5GpzOSbAqkJSELpPLKgYmIoL
	dk/16mjTAgroYRs/nxgGBVGSVHEvmxurex1wlZYX7oeFr/hC8Bd+Svx94dsru2G7Ngnn9MFMdpbL5
	B8U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQNVU-000000000Eu-1Wnk;
	Mon, 09 Nov 2026 11:25:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQNVT-000000000Ee-0Nmt
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 11:25:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6kKkuLkZCGynnGRhj8a+I9cQev0AfdNSRee++Uaqs9Q=; b=B3Ir29Zx4mapvzYn/iI1tfKwmm
 bAHlIYxJ5ydwWi7ZlAaZzfKvUpL8eTX0veoppdEo9kZvHMx0nvRzVal8rK5s/k8XQXBawROyAhGH4
 Ne9kB7mSzjYNpueG2MVCX0zeydyIuVSou4VXQTENNPxKwTxAbcsxnhWRXLCDaLzfieg4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6kKkuLkZCGynnGRhj8a+I9cQev0AfdNSRee++Uaqs9Q=; b=Jw0CBJEhNhNbSySFBVh6obg3PI
 AEpW305QZd+aiGRGJLBVypE21ronYvqyv3mj3LhaII6HD8KMEsFm+LjXmXL/vyiaHTV4IXnKs7Xhd
 gh9yMnwo3d5k988+tvz1sODLILnqctZDFTCshh+XCvh+Lw5KmIZTIPdlSYE5xMGZBBLM=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQNVP-000000004rn-2XDu for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 11:25:47 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jNSBl5xywzNlcG
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 12:25:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794223535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kKkuLkZCGynnGRhj8a+I9cQev0AfdNSRee++Uaqs9Q=;
 b=LzrMBtubIfdKMq+dWmUxTQvb2EZGqeZLKozACntE8blDtMRxC1+AeB/Z1us7kOkZqKcL7X
 4uWTzzHh5Mdus6HjOH11WDDGEE9J8X3zU8K+N+ZU1e17brMrHGpc8atBHBhbjBrvHRRUxd
 dHM3ikuwi+SHhezpCCQrv266apjP4wUnMhAEGrKr7P9END8qfa7gWCElFTkJV83IY8N34R
 8sboNo2dVmSfb0UlkcTBzcANjp0byKGnR7WfYy3PrieN5ePTE3WHzhQ17jy9X4n5mgpLMt
 mcoQVGWcVpTq+oohZUpuMcm5FNJk6zO4VL3vBPH0EJvCUr76IoveJ6PyhAkapg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 12:25:19 +0100
Message-ID: <1533a769382fd369d6f3e839d870f42efd1b4809.1794223133.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794219839.git.ralf@mandelbit.com>
References: <cover.1794219839.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNSBl5xywzNlcG
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQNVP-000000004rn-2XDu
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 4/8] ovpn: record
 asynchronous transmit crypto
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

The UDP GSO output path introduced next requires a synchronous encrypt
transform. Record the transform type in the immutable key slot when it
is created, avoiding repeated inspection of the crypto algorithm flags
in the data path.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
New in v3.

 drivers/net/ovpn/crypto.h      | 2 ++
 drivers/net/ovpn/crypto_aead.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index e3feb16d5498..8ce324e9b58f 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -39,6 +39,8 @@ struct ovpn_peer_key_reset {
 
 struct ovpn_crypto_key_slot {
 	u8 key_id;
+	/* whether the encrypt transform is asynchronous */
+	bool async;
 
 	struct crypto_aead *encrypt;
 	struct crypto_aead *decrypt;
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 30299581422d..5e5320338165 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -462,6 +462,7 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 		ks->encrypt = NULL;
 		goto destroy_ks;
 	}
+	ks->async = crypto_tfm_is_async(crypto_aead_tfm(ks->encrypt));
 
 	ks->decrypt = ovpn_aead_init("decrypt", alg_name,
 				     kc->decrypt.cipher_key,
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
