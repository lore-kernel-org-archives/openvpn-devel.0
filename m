Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872E606A332
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z5j22aRZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Io2IexEQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EA/MlCNB;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=LnWoQXdV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XoFwCjoWgDpOHTgXyiq+FNFAdrI/y7uPXK856FbJJ7o=; b=Z5j22aRZPBsAsq
	WaIZHjQJ16hRymEAzmiQ4BL1+Rq/kKkwRXB5THerVfxzbZoMCX/gQXnZr+mi9ytLBLpx4jQqMJT2T
	pL31ZugUkQYKhYAVnPZXmodyRkrPrZJ3zhEQGYms8xLh0RDG2aaxXi/+NpdrPUMkq8o7Lz+Pzezpe
	Fck=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQQzy-0000000076v-3QlP;
	Mon, 09 Nov 2026 15:09:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQQzw-0000000076f-2dHU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:09:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PO82ieRgqZM5Ro5q9/54BT5ufq6qtRF29d2pxlBvaoc=; b=Io2IexEQ3TSkK4+iR/ic7nqysG
 kpHKRd6MD4XriRLdW/aUnDKQ79ZTvTF9OQFRfnw6a2T8Ze4uAauTWgh5OTzqQ5rdAF0ZCXczJ21H9
 75PTYgokDFTOnmpaNwL+8RqQknjvuP8JkrACF9VdS7YXyqksVs0oXRNYOiVP8CHIWOTo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PO82ieRgqZM5Ro5q9/54BT5ufq6qtRF29d2pxlBvaoc=; b=EA/MlCNBz1c7j2FqekjRtKJhSV
 WhdJq70lL4khRJg7YvCbtT5w0wL5yFNEk7Un0AiIOsrU+0ayJjY2lDbLwO8z7XMVwFjk5V0X+DJX0
 d6YRnQgCTVkinQB1esXefst8fvAkA29V2uu3lErRrPX7j+YUQ2XhlVqN7TeupQNX5SRI=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQQzv-000000000Eo-0NxD for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:09:28 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jNY8t67dGzFqrD
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 16:09:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794236958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PO82ieRgqZM5Ro5q9/54BT5ufq6qtRF29d2pxlBvaoc=;
 b=LnWoQXdV+DiY3hSrfyYapuBZWPlm5DAAbLkNyQfOjR+EQTW50KGScz4qNgqx/1GWDzQlEh
 nTeWzL9gsEYPQ/b7djldxgcFqAKoaqqCQoD1kzsipSl6LQ3MxDYDAvjyjH5ztxDqXrxrSd
 0QdRL5cwUZ6F0IJzLNT9Icuj5TOZNm237/Og9Wb38T6OBkORK2M1Z843i6DOyO3JEMmYeU
 zfALJsnsmLVDpryZmpm7rL0awvLQ08yhm9Fp9rI3hftKshLEkLR1T9xaIGjwW5P0mVdCI4
 1aTpOG5P/y13L0atoMeE/PN2ldfsbz+tizu7/eLxu2pkcuCEYKBH6pSpFPxkxw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 16:09:02 +0100
Message-ID: <1533a769382fd369d6f3e839d870f42efd1b4809.1794234673.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794234673.git.ralf@mandelbit.com>
References: <cover.1794234673.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jNY8t67dGzFqrD
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQQzv-000000000Eo-0NxD
Subject: [Openvpn-devel] [PATCH ovpn net-next v4 4/9] ovpn: record
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
