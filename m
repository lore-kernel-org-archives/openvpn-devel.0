Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED25C88E77
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTV71Sm4XsIGOGJbtGRIBCl4pGOf5iegvOsXhvTtVNU=; b=lBCSqgWZvT8sih7eVJbEt5xm5r
	gV36RQxigjjxqigw/Mq5IMilpOqHccJeYvh/QFT8YE0N/61MI4f4Hd/NWZF/ZTpekz5NXinOzTs9i
	+6O/5e+uttX5ENxvjDt+s6bAHViSQ5XE4XPPYJbRdyd/8gLTOHm7lWk/Q1qfExyaOpUg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6l7H-0004Xp-G4;
	Wed, 16 Sep 2026 08:35:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6l7G-0004Xe-AH
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:35:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xcbn1IBV1wPJscBwKDfKRS+bBZAuL6cXU3ZhvYBlixY=; b=ZKWyJF4aPQSQbZXfAiiDMqn6G5
 Og9Hi8MwMqwVWdC3QkSNnJMXFaOcMrvoHFQLMj2gd/3J1oGWAk6wZVtczAi57AnP65UGyv/QV6d6E
 +TbrZSGirpZxoGZ2W9gDQqaAuf45gcdFrpajLzNUBgQV3Db5qiMQDXFHsY4+PWxUOPi8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Xcbn1IBV1wPJscBwKDfKRS+bBZAuL6cXU3ZhvYBlixY=; b=VdP8kVkX45Zaef8Ot5dRjqFxsw
 vXrcMJVgcQHEsDdMX0cy1U5w2PNIhJvX+wHD0lEqK0X3AlO8uk99Qq7nfkymQZ6XOZpWLT2tmkiDM
 umdcRVddWSFyhZAc9l5hn7VsX//VdX9drRvxHPyDBWWt9TpqZ10mCTxUwPaAJyMATPjM=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6l7E-00053H-Dl for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:35:43 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hlBzS0wHFzLm5C
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 10:35:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789547732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xcbn1IBV1wPJscBwKDfKRS+bBZAuL6cXU3ZhvYBlixY=;
 b=D+Iy1hn9fqTjXxHtLlQZCD2SZeD0XgK3y4QAa/jLeOf/iYgCIo5KkarMavgy+rWeUxkfMf
 OHJbeLMKkgcr80qusSx1PMtsv3N1V08UcY8jSdUDs03quqoRjPeRPA50y6rhCFxOuk9Q6n
 aMnVMn0OZVu1X/2TRLU/62hocdPUk5hqPj7cUbx68NVBSjoluXrj8Qp5aUXL3qLqTwHPf7
 oQjnG9dS9YV0Z3f6Q64axZQrwMAdoEg72kwhbz346Ly4i6p3nc8DR4PPrS0M1+b2Y501Xh
 U228rmLpcQlxITfReCNQA4aKI9/Ezzd1+pvr4LEeM0gg5tPKxi/7yas+GlDKvg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 10:35:14 +0200
Message-ID: <903e2f55a68a1653f15014a91b0d7ac35ccabf11.1789546917.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789546917.git.ralf@mandelbit.com>
References: <cover.1789546917.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hlBzS0wHFzLm5C
X-Headers-End: 1x6l7E-00053H-Dl
Subject: [Openvpn-devel] [RFC ovpn net-next v3 5/9] ovpn: coalesce UDP data
 records with GRO
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

Register UDP tunnel GRO callbacks for ovpn data sockets and coalesce
compatible DATA_V2 records from one transport flow. Keep each encrypted
record as a separate frag-list entry so the receive path can detach and
authenticate records independently.

Match the complete opcode/key/peer header and require compatible outer-
network and checksum state. Flush on short records, differing segment
geometry, existing GSO input, or the 64-record limit.

Export skb_gro_receive_list, which is already shared by the core UDP and
TCP frag-list GRO paths, so modular ovpn can use the same primitive
instead of maintaining a local copy.

On two directly connected 100-Gbit/s mlx5 ports, five interleaved iperf3
-t 60 -O 10 single-flow AES-128-GCM runs in each direction produced the
following throughput:

                         Forward          Reverse
Without receive GRO     18.308 Gbit/s    19.233 Gbit/s
With frag-list GRO      22.087 Gbit/s    22.962 Gbit/s

The preceding UDP GSO transmit path and hardware UDP segmentation were
enabled in both cases. The equal-weight mean of the two directional
results increased from 18.770 to 22.524 Gbit/s, a 20.0% improvement.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/openvpn-devel/76cb811457ac17b519d219b13fb2a4317a6d5e74.1789540779.git.ralf@mandelbit.com/
- Unclone GRO aggregates to avoid shared skb corruption in
  ovpn_udp_gro_detach. (Sashiko)

Changes since v1 https://lore.kernel.org/openvpn-devel/dd08a7a2fe0dfc88509115b5d7ee17825020c012.1789485693.git.ralf@mandelbit.com/
- Preserve the outer network offset in ovpn_udp_gro_receive_fraglist.
  (Sashiko)
- Detach frag_list only from a UDP-tunnel GSO aggregate. (Sashiko)

 drivers/net/ovpn/io.c  |   7 +-
 drivers/net/ovpn/udp.c | 197 ++++++++++++++++++++++++++++++++++++++++-
 net/core/gro.c         |   1 +
 net/ipv4/udp_offload.c |   3 +-
 4 files changed, 201 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 3ad4cadeeb02..11f7f16d7b79 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -70,11 +70,10 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	unsigned int pkt_len;
 	int ret;
 
-	/*
-	 * GSO state from the transport layer is not valid for the tunnel/data
-	 * path. Reset all GSO fields to prevent any further GSO processing
-	 * from entering an inconsistent state.
+	/* the transport encapsulation and its GSO metadata do not describe the
+	 * decrypted inner packet
 	 */
+	skb->encapsulation = 0;
 	skb_gso_reset(skb);
 
 	/* we can't guarantee the packet wasn't corrupted before entering the
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 4802d982de08..ee3b9d1aec25 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -11,8 +11,10 @@
 #include <linux/skbuff.h>
 #include <linux/socket.h>
 #include <linux/udp.h>
+#include <linux/unaligned.h>
 #include <net/addrconf.h>
 #include <net/dst_cache.h>
+#include <net/gro.h>
 #include <net/route.h>
 #include <net/transp_v6.h>
 #include <net/udp.h>
@@ -27,6 +29,192 @@
 #include "socket.h"
 #include "udp.h"
 
+/* like UDP and TCP frag-list GRO */
+#define OVPN_UDP_GRO_CNT_MAX 64
+
+static bool ovpn_udp_gro_header(struct sk_buff *skb, u32 *header)
+{
+	const unsigned int offset = skb_gro_offset(skb);
+
+	/* GRO replaces its frag0 pointer after holding an skb, so keep the
+	 * openvpn header linear for later candidate comparisons
+	 */
+	if (!pskb_may_pull(skb, offset + OVPN_OPCODE_SIZE))
+		return false;
+
+	*header = get_unaligned_be32(skb->data + offset);
+	return true;
+}
+
+static struct sk_buff *ovpn_udp_gro_receive_fraglist(struct sock *sk,
+						     struct list_head *head,
+						     struct sk_buff *skb)
+{
+	const unsigned int gso_size = skb_gro_len(skb);
+	struct sk_buff *p, *pp = NULL;
+	u32 header, header2;
+	int ret = 0, nhoff;
+	bool flush;
+
+	if (!ovpn_udp_gro_header(skb, &header) ||
+	    FIELD_GET(OVPN_OPCODE_PKTTYPE_MASK, header) != OVPN_DATA_V2) {
+		NAPI_GRO_CB(skb)->flush = 1;
+		return NULL;
+	}
+
+	/* do not nest an existing GSO packet in the record list */
+	if (skb_is_gso(skb)) {
+		NAPI_GRO_CB(skb)->flush = 1;
+		return NULL;
+	}
+
+	list_for_each_entry(p, head, list) {
+		if (!NAPI_GRO_CB(p)->same_flow)
+			continue;
+
+		/* match opcode, key ID and peer ID */
+		if (!ovpn_udp_gro_header(p, &header2) || header != header2) {
+			NAPI_GRO_CB(p)->same_flow = 0;
+			continue;
+		}
+
+		/* GRO has already matched the outer addresses and UDP ports;
+		 * check the remaining outer IP fields
+		 */
+		nhoff = skb_transport_offset(p) -
+			NAPI_GRO_CB(p)->network_offset;
+		flush = __gro_receive_network_flush(udp_hdr(skb), udp_hdr(p), p,
+						    nhoff, false);
+
+		/* The first record determines the nominal GSO size. A shorter
+		 * final record may follow it, but a larger record cannot.
+		 * Checksum metadata must also be uniform because the aggregate
+		 * exposes only one checksum state.
+		 */
+		if (gso_size > skb_shinfo(p)->gso_size || flush ||
+		    skb->ip_summed != p->ip_summed ||
+		    skb->csum_level != p->csum_level) {
+			pp = p;
+		} else {
+			/* skb_gro_receive_list pulls the headers already
+			 * processed by GRO before linking this skb to the
+			 * record list so we have to manually preserve the
+			 * outer network header location for later handling
+			 */
+			nhoff = NAPI_GRO_CB(skb)->network_offset;
+			skb_set_network_header(skb, nhoff);
+			ret = skb_gro_receive_list(p, skb);
+		}
+
+		/* complete the aggregate if the append failed, or after
+		 * appending a shorter final record, or after reaching the
+		 * record-count limit
+		 */
+		if (ret || gso_size != skb_shinfo(p)->gso_size ||
+		    NAPI_GRO_CB(p)->count >= OVPN_UDP_GRO_CNT_MAX)
+			pp = p;
+
+		return pp;
+	}
+
+	return NULL;
+}
+
+static int ovpn_udp_gro_complete(struct sock *sk, struct sk_buff *skb,
+				 int nhoff)
+{
+	/* udp_gro_complete has already marked this as a UDP tunnel GSO packet.
+	 * Keep that type so UDP passes the aggregate directly to the encap cb,
+	 * where the original record skbs are detached.
+	 */
+	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
+
+	/* Each outer UDP checksum was either validated (or accepted in case of
+	 * checksumless UDP) before its record was merged in
+	 * skb_gro_checksum_validate_zero_check.
+	 * The checksum in the aggregate cannot describe the concatenation of
+	 * independent UDP payloads, so we preserve the validation result.
+	 */
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	skb->csum_level = 0;
+	skb->csum_valid = 0;
+
+	return 0;
+}
+
+/* skb_gro_receive_list keeps the first openvpn record in 'skb' and links the
+ * remaining records through frag_list. Here we segment by detaching that list
+ * before delivering the records individually, and remove the child skbs from
+ * the head skb's length and memory accounting so the head describes only the
+ * first record again.
+ */
+static struct sk_buff *ovpn_udp_gro_detach(struct sk_buff *skb)
+{
+	unsigned int data_len = 0, truesize = 0;
+	struct sk_buff *curr, *list;
+	int ret;
+
+	/* IP reassembly may also use fraglist, but it is not a record batch */
+	if (!skb_is_gso(skb) ||
+	    !(skb_shinfo(skb)->gso_type &
+	      (SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM)))
+		return NULL;
+
+	if (unlikely(!skb_shinfo(skb)->frag_list))
+		return NULL;
+
+	/* packet taps may have cloned the aggregate before it reached UDP, so
+	 * make shared info private before removing its frag_list
+	 */
+	ret = skb_unclone(skb, GFP_ATOMIC);
+	if (unlikely(ret))
+		return ERR_PTR(ret);
+
+	list = skb_shinfo(skb)->frag_list;
+
+	for (curr = list; curr; curr = curr->next) {
+		data_len += curr->len;
+		truesize += curr->truesize;
+	}
+
+	skb_shinfo(skb)->frag_list = NULL;
+	skb->len -= data_len;
+	skb->data_len -= data_len;
+	skb->truesize -= truesize;
+
+	return list;
+}
+
+static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct sk_buff *list, *next;
+
+	list = ovpn_udp_gro_detach(skb);
+	if (IS_ERR(list)) {
+		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
+		kfree_skb(skb);
+		ovpn_peer_put(peer);
+		return;
+	}
+	skb->next = list;
+
+	skb_list_walk_safe(skb, skb, next)
+	{
+		skb_mark_not_on_list(skb);
+
+		/* keep the current reference alive for the next record before
+		 * handing this one to crypto
+		 */
+		if (next && unlikely(!ovpn_peer_hold(peer))) {
+			DEBUG_NET_WARN_ON_ONCE(1);
+			kfree_skb_list(next);
+			next = NULL;
+		}
+
+		ovpn_recv(peer, skb);
+	}
+}
+
 /* Retrieve the corresponding ovpn object from a UDP socket
  * rcu_read_lock must be held on entry
  */
@@ -121,8 +309,7 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	/* pop off outer UDP header */
 	__skb_pull(skb, sizeof(struct udphdr));
-	skb_mark_not_on_list(skb);
-	ovpn_recv(peer, skb);
+	ovpn_udp_recv(peer, skb);
 	return 0;
 
 drop:
@@ -408,6 +595,8 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 		.encap_type = UDP_ENCAP_OVPNINUDP,
 		.encap_rcv = ovpn_udp_encap_recv,
 		.encap_destroy = ovpn_udp_encap_destroy,
+		.gro_receive = ovpn_udp_gro_receive_fraglist,
+		.gro_complete = ovpn_udp_gro_complete,
 	};
 	struct ovpn_socket *old_data;
 	int ret;
@@ -454,6 +643,8 @@ void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
 	struct sock *sk = ovpn_sock->sk;
 
+	udp_tunnel_cleanup_gro(sk);
+
 	/* Re-enable multicast loopback */
 	inet_set_bit(MC_LOOP, sk);
 	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
@@ -462,6 +653,8 @@ void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 	WRITE_ONCE(udp_sk(sk)->encap_type, 0);
 	WRITE_ONCE(udp_sk(sk)->encap_rcv, NULL);
 	WRITE_ONCE(udp_sk(sk)->encap_destroy, NULL);
+	WRITE_ONCE(udp_sk(sk)->gro_receive, NULL);
+	WRITE_ONCE(udp_sk(sk)->gro_complete, NULL);
 
 	rcu_assign_sk_user_data(sk, NULL);
 }
diff --git a/net/core/gro.c b/net/core/gro.c
index 29b4d02bf519..b6acedc919f8 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -262,6 +262,7 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 
 	return 0;
 }
+EXPORT_SYMBOL(skb_gro_receive_list);
 
 static void gro_complete(struct gro_node *gro, struct sk_buff *skb)
 {
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c6611a..187f108f3ee8 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -40,7 +40,8 @@ struct udp_tunnel_type_entry {
 #define UDP_MAX_TUNNEL_TYPES (IS_ENABLED(CONFIG_GENEVE) + \
 			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
 			      IS_ENABLED(CONFIG_NET_FOU) * 2 + \
-			      IS_ENABLED(CONFIG_XFRM) * 2)
+			      IS_ENABLED(CONFIG_XFRM) * 2 + \
+			      IS_ENABLED(CONFIG_OVPN))
 
 DEFINE_STATIC_CALL(udp_tunnel_gro_rcv, dummy_gro_rcv);
 static DEFINE_STATIC_KEY_FALSE(udp_tunnel_static_call);
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
