Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDDCC982C5
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hjWa4bUaHwlNNp2J/W+LHhiTvU+l0dE21bGwQLcklao=; b=E+yorcHtuqXzbLP+0zTkau7oWo
	HWN1xb5AowLVrMTQE1Ge8n0Hg2Fe2gyfXv3o87S/EvaKO0OVC0UwmlClhzcAsB5FbD+0ngVkhJtVz
	fGc6Ok8vUf6/yUY+f0lQAILQG7SsQ3FguMOvTtxxXB4g+cGbt5HoyeKPtZqgyP3nf6LA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6V1B-0007II-Hj;
	Tue, 15 Sep 2026 15:24:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6V17-0007Hy-MQ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y6ZcSuLvQ6X5Ydek+ixWKUb5I/qvCbobOvM28/42oS8=; b=bn6nD2ba+Cz5CzCY/3uQ9kVKAc
 JegkYTkOx1DHuow+vRDh+ZVRV+fEpbpvQB4uHXeEAzdXV15V3PeUabK9qsUa4la//SiX51oG7tqke
 SkqqWiLSaxNhTXKaFo0GyLfUNfSuo3kI4Q3k8+UBacpJDZ2SJkfEuSjHVttYVRr54WH4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y6ZcSuLvQ6X5Ydek+ixWKUb5I/qvCbobOvM28/42oS8=; b=cGiOFRugo5QOB28SX5Dv9RGAMK
 o1BgIns9BJz0HD9W14qyJA5TYHV6CUmzvhRAhkz3yevNyZNw0SXMjCZ9A+F41wc2VBWAvIXQSFCKd
 AlmzKfhCpEnanyAOvywXupH53ANgKQVvlif5jtOEFcW9FTzS1dcyaTE47oUw26qDy6mY=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6V11-000771-Ru for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:15 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4hkm5J432DzLmF9
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 17:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789485844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6ZcSuLvQ6X5Ydek+ixWKUb5I/qvCbobOvM28/42oS8=;
 b=rFx3yZec2cYmQjPU8lpec6q6atMoiwLr3g9Cdmod1xiUVzbyAAtwjGhky0INhN+NCdViFq
 897csrGf4NfOmB82uNvWgHQiSQgtm8U5Sbml2AcK2FZBxof0ACDL5uTxuBMRTCDCz3yUMf
 psAn6M2RZBmBg5mdU4z8y28ukRvhon8T7s3x3svSbi6Bz3U2t7vN3z0g6ls8OovYzaiYTb
 QCLEoT7Iynbic4NbHHPSu+29gTAm5Ga9KG7LmNQhgxnMdtii7MeXnwQpFAZNFUzVRmOMwp
 Fgxjb4gWNJVPQ0zMp1B7pTGUoYv+vahbIr/lmjHpJr1mnAgL6YEXge2zxr4gDw==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 15 Sep 2026 17:23:53 +0200
Message-ID: <dd08a7a2fe0dfc88509115b5d7ee17825020c012.1789485693.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789485693.git.ralf@mandelbit.com>
References: <cover.1789485693.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x6V11-000771-Ru
Subject: [Openvpn-devel] [RFC ovpn net-next 5/9] ovpn: coalesce UDP data
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
 drivers/net/ovpn/io.c  |   7 +-
 drivers/net/ovpn/udp.c | 174 ++++++++++++++++++++++++++++++++++++++++-
 net/core/gro.c         |   1 +
 net/ipv4/udp_offload.c |   3 +-
 4 files changed, 178 insertions(+), 7 deletions(-)

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
index 4802d982de08..dfb1aa10556d 100644
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
@@ -27,6 +29,169 @@
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
+			nhoff = skb_gro_receive_network_offset(skb);
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
+	struct sk_buff *curr, *list = skb_shinfo(skb)->frag_list;
+	unsigned int data_len = 0, truesize = 0;
+
+	if (!list)
+		return NULL;
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
+	struct sk_buff *next;
+
+	skb->next = ovpn_udp_gro_detach(skb);
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
@@ -121,8 +286,7 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	/* pop off outer UDP header */
 	__skb_pull(skb, sizeof(struct udphdr));
-	skb_mark_not_on_list(skb);
-	ovpn_recv(peer, skb);
+	ovpn_udp_recv(peer, skb);
 	return 0;
 
 drop:
@@ -408,6 +572,8 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 		.encap_type = UDP_ENCAP_OVPNINUDP,
 		.encap_rcv = ovpn_udp_encap_recv,
 		.encap_destroy = ovpn_udp_encap_destroy,
+		.gro_receive = ovpn_udp_gro_receive_fraglist,
+		.gro_complete = ovpn_udp_gro_complete,
 	};
 	struct ovpn_socket *old_data;
 	int ret;
@@ -454,6 +620,8 @@ void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
 	struct sock *sk = ovpn_sock->sk;
 
+	udp_tunnel_cleanup_gro(sk);
+
 	/* Re-enable multicast loopback */
 	inet_set_bit(MC_LOOP, sk);
 	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
@@ -462,6 +630,8 @@ void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
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
