Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D9606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZtkeHq7j;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Uf9ugsqV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Enpi0diZ;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=E6Zrp03F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wShcAArO456Ewmmz6uXqc9o0FiHNL0d81qFICKY/ygE=; b=ZtkeHq7jPokrg/
	O6Ak9ktTHFM82Dev9B2skh4xbsBvW8FWl6fnN1B+tq5fH78PrPFxTQ8vC5mn8dvz5vHzvxSfmBRfj
	gbHCTUFAeXe22IT7rCkuDt+BSHGRO1VE7rPr616U063aylaWXXPMGt3Ko4iGcz0ILeDAJF8jEto/s
	vvw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQSzD-0000000072D-1qMf;
	Mon, 09 Nov 2026 17:16:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQSzC-0000000071m-1lzy
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 17:16:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4/L3lBlo8ps1ZrYb9ptJvVUdbT4CceCmF3qzRP4wyUs=; b=Uf9ugsqVXd5OPTufco0E9QJNgi
 wjIRldXeNuHHHE5XuCUoAPDbzYiq64NTg6W3EazDuibV6f9s62PKcd391TXh881+RI6m9DPtlreRZ
 bx7doJP3jluxPhn0UhpL5S37ANbfMBftnELOcCQo9RHGVWXwirY3Zv0zyc2PEN2mbuHM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4/L3lBlo8ps1ZrYb9ptJvVUdbT4CceCmF3qzRP4wyUs=; b=Enpi0diZ1YXml2TT6GovSBPJ4g
 FymdPOEKyIQSyY1MRY8iHCDp4qCeiig/hTWOPlS3k/7SFsGZnp2ie6ibVUCHxHy8y6K1dusqv7GP+
 DF7uatrFzi07k+a2Mbh5QIrXLl+JlNHfeaAMGqolgqnWJeCRHJcTaXhrbucyzHcOjnDk=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQSz8-000000004ge-1R5m for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 17:16:50 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jNbzn6zFmz5wP4
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 18:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794244598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/L3lBlo8ps1ZrYb9ptJvVUdbT4CceCmF3qzRP4wyUs=;
 b=E6Zrp03F6Xq4SXxpnO4syRVGQrKRj+v2R8BZ1Idgr0VRv6wh7YM7end0AQfyNyk2g13y0u
 rbKYBIUp+j8D0atoGAhJLg5Ck1JdkrW/rWkT+3yciCdaYy/F7RQ1Yc4YpqvCmSBPGTymG0
 Tb9Virzok4HC8Dx+D0zUSvR159p8889fgNezXlYOQLLlOSzatYrU4GhYulJKFH2Nh1b2XX
 X50yJWgltqxpA0V1H4++Ak/quY49mg4bqqFWBrZfJ6aAmzo0TyG4j8Uxy66SiYIGc0S1Lg
 dxOKken987JguYUNtrOWFDqSchfGZNYYmtTOaRyTq9QWlVutE2NMG9yyT7jy/Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 18:16:20 +0100
Message-ID: <1533a769382fd369d6f3e839d870f42efd1b4809.1794244231.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794244231.git.ralf@mandelbit.com>
References: <cover.1794244231.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNbzn6zFmz5wP4
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQSz8-000000004ge-1R5m
Subject: [Openvpn-devel] [PATCH ovpn net-next v5 4/9] ovpn: record
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
No changes since v4 https://lore.kernel.org/openvpn-devel/1533a769382fd369d6f3e839d870f42efd1b4809.1794234673.git.ralf@mandelbit.com/

No changes since v3 https://lore.kernel.org/openvpn-devel/1533a769382fd369d6f3e839d870f42efd1b4809.1794223133.git.ralf@mandelbit.com/

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
