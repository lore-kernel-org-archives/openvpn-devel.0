Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD1606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kTC/DPyg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eC6swsA4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fU3x4Kde;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=v0L0KCEK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=GeudwhtT5miwaLU5UTFX9q0qaXIaflw68tHitoF7MAI=; b=kTC/DPygKM3afFLj4xmAf6unzZ
	hzdqP1QtBp35FWkJm7q9Ssxex2x2Ur0XX/+qKyt4U4Yel5fzgCwlhf6dRXA4R4gmkzpc1lDhOj1UF
	Ws9Hqzq+KnLsnQNocSH6rscGogQhZfqNwjGVWTdPGWGrluVSmxQiAMsjeJETIgG7TPbk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWNle-000000007eR-47Jh;
	Thu, 26 Nov 2026 00:55:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xWNla-000000007eH-3Js5
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 00:55:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BDpsYm3k9BJAjizIu2JvfBhfI+NIHhmf0M+pNAftiz0=; b=eC6swsA4VVPH9zq2pTvLt/5Opi
 Xz57Q94Og+Zfy/WKxFWnSlMi11wqxUlQeYXV8eo1AuzM8J1b7u92BvSn8oHH7HI+luDeIjMMl5Non
 NGZ34t9+UAjatmFkKRaWJwa2QihFMV8BU1arFESSXO9sWSexC/J/9K3L4Woop+hVnzIk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BDpsYm3k9BJAjizIu2JvfBhfI+NIHhmf0M+pNAftiz0=; b=fU3x4KdecQtItTNueZu5f1YyhN
 vKe0hi3ODeI1w3zZU8P/9YJtk+jjm9WUISicdvKlQPjq7fejSs/GTZ6+l1ga7H4YCD7LKCI4NSUOK
 01AH3lC0oPXi5XduQgxS42DsYsM+GfV2h6rMGaaKLqYHlPo5j33sJfpboPSSU/5tZiHY=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWNlY-0000000011q-3GIx for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 00:55:14 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jZdPH75Nrz8sl7
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 01:54:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1795654500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BDpsYm3k9BJAjizIu2JvfBhfI+NIHhmf0M+pNAftiz0=;
 b=v0L0KCEKYLKkFWeZVcj0+Gf7CUSwfL4g+EwUxk2R/n4ezs+yhPmQByky6XK/jqNAs1iimO
 zp/RV2AVZ3k23ug22HLkO6wVg/KplI6DHk2o8Rwg6ND8aHel17erxbWyfYs07rmPxLIxXK
 GrDlENpdaQFAJN4Z1XL5kNn3WvyRBQDkDrBH2/S2K5rMHk1fhmASjnmHd4aphmKtAjkG6M
 VgSGyXtlunhTATYBXP29F1JM+IFZUVg75Y3VFPwdnnLEHMEI1uB1du8WuZXAgekOTF6kYi
 fKFrN5eCwu8SdC0ijLbB9LBO3rYloymabG02uKrsXSpn+KM+PSCUo5ciPu0LeQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 01:54:59 +0100
Message-ID: <20261126005459.3289071-1-a@unstable.cc>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jZdPH75Nrz8sl7
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWNlY-0000000011q-3GIx
Subject: [Openvpn-devel] [PATCH ovpn net v2] ovpn: disable BHs in async
 encrypt completion callback
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

From: Antonio Quartulli <antonio@openvpn.net>

ovpn_encrypt_post() may take the TCP transport socket lock with a plain
spin_lock(), which requires BHs disabled as the lock is also taken in
softirq context. Some async crypto drivers complete requests from a
workqueue or kthread with BHs enabled (e.g. qce, starfive, keembay), and
a completion can then deadlock against TCP softirq processing on the
same CPU.

Crypto drivers are expected to complete with BHs disabled (see
crypto_engine's lockdep_assert_in_softirq()), but not all do: wrap the
async encrypt completion in local_bh_disable()/enable().

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Cc: stable@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---

v2:
- only wrap the encrypt completion: the RX path already disables BHs
  where needed
- reword commit message around the TCP socket lock, fix Fixes tag
v1: https://lore.kernel.org/all/20261125231040.2941106-1-a@unstable.cc/

 drivers/net/ovpn/crypto_aead.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 74eaf6fac2f5..1b3cd3ea12c5 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -135,6 +135,16 @@ static struct scatterlist *ovpn_aead_crypto_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
+/* Crypto drivers should complete requests with BHs disabled, but not all
+ * do. ovpn_encrypt_post() relies on it (TCP socket lock): enforce it here.
+ */
+static void ovpn_aead_encrypt_done(void *data, int ret)
+{
+	local_bh_disable();
+	ovpn_encrypt_post(data, ret);
+	local_bh_enable();
+}
+
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
@@ -229,7 +239,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	/* setup async crypto operation */
 	aead_request_set_tfm(req, ks->encrypt);
-	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
+	aead_request_set_callback(req, 0, ovpn_aead_encrypt_done, skb);
 	aead_request_set_crypt(req, sg, sg,
 			       skb->len - ovpn_aead_encap_overhead(ks), iv);
 	aead_request_set_ad(req, OVPN_AAD_SIZE);
-- 
2.56.1



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
