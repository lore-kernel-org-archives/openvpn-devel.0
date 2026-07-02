Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CE2C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XR1XHt8CdQHwi0OELWA7z5dtq0JNZIW4+cNyVevzqbQ=; b=BoxqGQej90kGFG4LYo8Wvkb8Nu
	eTaEeFM1IT/ubLqUPMoi6yHUUxgznKIW+iMk9j/AvyTuKaSUwHkg2kVVPpZGw1oKcFJEUH4e3qYY0
	puCycb6vTQSMfbXcLDRgIR6xrAvkf/6E+MsJKW/wwcHt7tyaDnEmHnJIiHZwHGKXQysc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfFyo-0001gI-TZ;
	Thu, 02 Jul 2026 11:53:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfFym-0001gA-OZ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lOOxtbNdj0/1K+eQqMh7U0u+VrjYM+S83uLDH/KN33Y=; b=bWYwR1RPgeBtbFldE6dr3ECn/r
 R6os5yUE1QWUArgp6b94K658X9/Z4/ouQeUptPoaaSfK3tnGUNtZf9sGNgAS0oIIlJMGCe8Z/DJ1n
 utqlpKVYsRPROlDYt1HJ2ojEdZ7ZdXJax8msO5tIao3emN8bWupxFl4OzXFhyqkQFlmY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lOOxtbNdj0/1K+eQqMh7U0u+VrjYM+S83uLDH/KN33Y=; b=DBZbFQA/aXPhtxGSM85RvpgyLL
 fafsoU94pmSxMU4WOjaXeh3BO1P/OHJhlMjhxRWfvt2gD30pBXmnuirMavE5zD6z9cCloMTEFVs7Y
 9zoKerRipmE596hsN2g9g6G8BPKso9oiZZddYyMiMGV4vQhesL8xfVOtq2S2YhX/JPqU=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfFyk-0004JD-TS for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:17 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4grZyW2H80zDs65;
 Thu,  2 Jul 2026 13:53:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782993187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lOOxtbNdj0/1K+eQqMh7U0u+VrjYM+S83uLDH/KN33Y=;
 b=n5/FKP8zwZmRwR6uA6zSEx+Nr0f7a7QKSOD9EEhsDnHO8VAglxbZGsPv4HQoGCUKSIgIII
 GM5bddeGhGHPk0QqrursOBl+3zm7uqNfpLya1X6syEMsC9wYOZ/3RllT9Ucw4Hu1t5Xn6G
 0ws8/MUfR+yiaz0Qj5QNooAupoX39Aa+Ph5xSVCe4+RQVI99i545m2jwkDi20fjjt3IFUL
 +RHCa/0GNiGPWX++kPUzIHsAj5QHrt8mYwxIu34wvkR72bPR0E52lJvmVgDkpu3n1e3QvE
 jrnhvCIQUhCjtRme/slzNPSR1y70jP0pizGA3CKuLoQMmPnqDAfo+Jgd3TPBkg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2026 13:52:16 +0200
Message-ID: <6c66a38af8ea53e4fbc587f087c594573fd8ee6a.1782986577.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782986577.git.ralf@mandelbit.com>
References: <cover.1782986577.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4grZyW2H80zDs65
X-Headers-End: 1wfFyk-0004JD-TS
Subject: [Openvpn-devel] [RFC ovpn net-next v2 01/14] ovpn: prepare packet
 ID state for usage limits
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

OpenVPN needs packet-ID and cipher usage thresholds to decide when a
data-channel key should be renewed or stopped. The existing transmit
packet-ID helper only returns the next ID and has no way to request a
threshold notification.

Teach the transmit packet-ID helper to return 1 when the fixed OpenVPN
packet-ID soft threshold is crossed. The counter is monotonic, so the
exact crossing is naturally reported only once. The hard packet-ID wrap
check still stops TX; this only gives userspace a chance to rekey while
packet-ID space is still available.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v1 https://lore.kernel.org/openvpn-devel/6c66a38af8ea53e4fbc587f087c594573fd8ee6a.1782919654.git.ralf@mandelbit.com/

 drivers/net/ovpn/crypto_aead.c |  3 +++
 drivers/net/ovpn/netlink.c     |  4 ++--
 drivers/net/ovpn/pktid.h       | 31 +++++++++++++++++++++++++------
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 8f07c418622b..86b69aeddcf7 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -19,6 +19,7 @@
 #include "pktid.h"
 #include "crypto_aead.h"
 #include "crypto.h"
+#include "netlink.h"
 #include "peer.h"
 #include "proto.h"
 #include "skb.h"
@@ -207,6 +208,8 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
 	if (unlikely(ret < 0))
 		return ret;
+	if (unlikely(ret > 0))
+		ovpn_nl_key_swap_notify(peer, ks->key_id);
 
 	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
 	 * nonce
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4c66c1ec497e..83d81a468b5a 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1312,8 +1312,8 @@ int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 	int ret = -EMSGSIZE;
 	void *hdr;
 
-	netdev_info(peer->ovpn->dev, "peer with id %u must rekey - primary key unusable.\n",
-		    peer->id);
+	netdev_info(peer->ovpn->dev, "peer with id %u should rekey key %u\n",
+		    peer->id, key_id);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 	if (!msg)
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
index 21845f353bc8..82f59256b4a3 100644
--- a/drivers/net/ovpn/pktid.h
+++ b/drivers/net/ovpn/pktid.h
@@ -17,6 +17,9 @@
  */
 #define PKTID_RECV_EXPIRE (30 * HZ)
 
+/* notify userspace when the packet ID space is close to wrapping */
+#define PKTID_XMIT_REKEY_NOTIFY 0xff000000U
+
 /* Packet-ID state for transmitter */
 struct ovpn_pktid_xmit {
 	atomic_t seq_num;
@@ -52,20 +55,36 @@ struct ovpn_pktid_recv {
 	spinlock_t lock;
 };
 
-/* Get the next packet ID for xmit */
+/**
+ * ovpn_pktid_xmit_next - allocate a transmit packet ID
+ * @pid: transmit packet ID state
+ * @pktid: location where the generated packet ID is stored
+ *
+ * The returned packet ID becomes part of the AEAD nonce, so the helper rejects
+ * the packet before the 32-bit packet-ID space wraps.
+ *
+ * The packet-ID soft threshold does not reject the packet. It returns 1 once
+ * so the caller can notify userspace to rekey while packet-ID space remains.
+ *
+ * Return: 1 if userspace should be notified, 0 if no notification is needed,
+ * or a negative error code otherwise.
+ */
 static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u32 *pktid)
 {
 	const u32 seq_num = atomic_fetch_add_unless(&pid->seq_num, 1, 0);
-	/* when the 32bit space is over, we return an error because the packet
-	 * ID is used to create the cipher IV and we do not want to reuse the
-	 * same value more than once
-	 */
+	int ret = 0;
+
+	/* packet IDs are used to create cipher IVs and must not wrap */
 	if (unlikely(!seq_num))
 		return -ERANGE;
 
+	/* notify userspace before the packet ID space is close to wrapping */
+	if (unlikely(seq_num == PKTID_XMIT_REKEY_NOTIFY))
+		ret = 1;
+
 	*pktid = seq_num;
 
-	return 0;
+	return ret;
 }
 
 /* Write 12-byte AEAD IV to dest */
-- 
2.54.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
