Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DED606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UIbXej15;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JGXYai78;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d3wJzOfh;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=UkobgoM/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=svrO1MCPDnTdsisMAFbv6Yf6bH0hg9IcT4L1W37atms=; b=UIbXej15xKMp8Mx99nMC8rprRy
	s+1fheewkFYBJN5ZSr42B5/lK5s+vxdtMiEn1JFdebLZMXDEeyKKnIUlwXmjhF/vvgTD397i3KnYF
	wfwtr5RoGvyAWhQJ7qGencwcPJfg8wm3ODnD1mwcOGUdYx0PVKU9U4TGwg96mRK5wz8M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWM94-000000001nh-0NKg;
	Wed, 25 Nov 2026 23:11:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xWM8y-000000001nW-2Rd4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 23:11:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FGdgB/dEhxr4wz0gPUSs4A9VZSaEB8awtk0feWIlXAs=; b=JGXYai78HrEl0AvzJ/ZfDm+gRq
 mxdMA0VbY9hsOYHSdk7ktWccha7mrntKze6MGgtc2D40xJ9CxyyBCsC7HOi3MGAMi6fAOCASTBxTM
 LvNqqOZgUXefcH3vTXpaho7yycYDD9P8LS73vEb0GbvRmfZSseOUddq99d3tnoGGYdcw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FGdgB/dEhxr4wz0gPUSs4A9VZSaEB8awtk0feWIlXAs=; b=d3wJzOfhduv1vm5dkiRp9Bldyn
 gU7tyoZB40hsc5G65SCLDpSQp9FL9xyPEWSNrTURhZsTSSO7jxCJ0CRoiG+u12EcGqL2aqZvmDsxa
 C9nm6K2N8TxEnzdys6YKwLtiJF++uvlTYwVrfGRIGBounUjkHGc4jnFmtfF7n3jH0Qm0=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWM8w-000000004Ve-1gdz for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 23:11:16 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jZb502p0qz8v4B
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 00:10:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1795648244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FGdgB/dEhxr4wz0gPUSs4A9VZSaEB8awtk0feWIlXAs=;
 b=UkobgoM/eoQALo8g+YPZ+KnK5NpkNlezn8P1HcVOreiCipJ44zsm9eWMdFV4yRtEJTgOzw
 7TwmJxxiU5U5qxOnqNZmChmFvYu2IASCZlur/BOQvBAc9bCaLuI/zlLPI/2lvvwjm3IFqw
 qDL9hKWN5bZewDSDvodrsLSpCyKF+i7aZ1Bvk3CZfwxUdO3mR/cOcaph0uuAJW6j0fvOah
 JS1F5y4RqFR5sAWzDEGHmNsarA1DBFzE2XAZXWoc87ARE05c485AqBsNQbZ1vvk+9bBzWo
 HgtEhxwHcDPAj7PkLyBl3AU6WfMTST12X7A0Xk0d+AtjOTpqIrNK7Efg9X2l3g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 00:10:40 +0100
Message-ID: <20261125231040.2941106-1-a@unstable.cc>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jZb502p0qz8v4B
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWM8w-000000004Ve-1gdz
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: disable BHs in async crypto
 completion callbacks
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

ovpn_encrypt_post() and ovpn_decrypt_post() expect to run with BHs
disabled: they take socket spinlocks shared with softirq context, pass
packets to gro_cells and update per-CPU stats. This holds on the
synchronous path, but some async crypto drivers complete requests from
a workqueue, a kthread or a threaded IRQ with BHs enabled (e.g. qce,
starfive, keembay), which can deadlock or corrupt per-CPU state.

Wrap the async completion callbacks in local_bh_disable()/enable().

Fixes: 8534731dbf2d ("ovpn: implement packet processing")
Cc: stable@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto_aead.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 74eaf6fac2f5..0d96b46304d6 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -135,6 +135,23 @@ static struct scatterlist *ovpn_aead_crypto_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
+/* Async crypto drivers are expected to complete requests with BHs
+ * disabled, as the RX/TX paths require, but some do not: enforce it.
+ */
+static void ovpn_aead_encrypt_done(void *data, int ret)
+{
+	local_bh_disable();
+	ovpn_encrypt_post(data, ret);
+	local_bh_enable();
+}
+
+static void ovpn_aead_decrypt_done(void *data, int ret)
+{
+	local_bh_disable();
+	ovpn_decrypt_post(data, ret);
+	local_bh_enable();
+}
+
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
@@ -229,7 +246,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	/* setup async crypto operation */
 	aead_request_set_tfm(req, ks->encrypt);
-	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
+	aead_request_set_callback(req, 0, ovpn_aead_encrypt_done, skb);
 	aead_request_set_crypt(req, sg, sg,
 			       skb->len - ovpn_aead_encap_overhead(ks), iv);
 	aead_request_set_ad(req, OVPN_AAD_SIZE);
@@ -316,7 +333,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 	/* setup async crypto operation */
 	aead_request_set_tfm(req, ks->decrypt);
-	aead_request_set_callback(req, 0, ovpn_decrypt_post, skb);
+	aead_request_set_callback(req, 0, ovpn_aead_decrypt_done, skb);
 	aead_request_set_crypt(req, sg, sg, payload_len + tag_size, iv);
 
 	aead_request_set_ad(req, OVPN_AAD_SIZE);
-- 
2.56.1



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
