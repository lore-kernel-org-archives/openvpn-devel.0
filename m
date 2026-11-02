Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE24606BA52
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RTwx8p8G;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lrocqGd0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SSu3852m;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ZaaxmICa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YFy7Apk4sI36o22QkbjWgIG+xSne4gcEp0roc7Bot1c=; b=RTwx8p8GjNovnJ
	daB3e+l9GLiCEkPItQXgpg9tPIiUsLBR3EYmvbrM5tOuA6QIuvt0cU10YfXTJcYbE7sPq34SpqqIJ
	LGfdAnTWS/XSAQ2g5h/cf5iopTQ8FmLcMfdbEb2Gan8KUSvtjGrTCnR9KDariCFxbppRwbVXLr4xB
	JGs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNv8x-000000002ut-25sU;
	Mon, 02 Nov 2026 16:44:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xNv8k-000000002uI-1iA7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F0fYOdr11VdzVW/OCy0NoSfqna0l63USk5YISmx+6eA=; b=lrocqGd0NSKOcqRNGV3G4NpJ13
 xma2MAdtIhu1jPSz5rFxM8Y1QlszqVpA6cGTwgsGC98iETHnNEgX4urTyOvZQ2Qn3aXP+aqYlJgMp
 E3UOYVqh9GSTnqxRYCPp8DB1s2sgVsLOZrDPAZ+JxyOgFP+hPQs0SAIL4Mj/COqNFwYs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F0fYOdr11VdzVW/OCy0NoSfqna0l63USk5YISmx+6eA=; b=SSu3852mm9HLZcWQwM6D7uJybZ
 FkosX7CkUwBozJMff4BeI4mK1QA8VWZmXu/vnxb9yrgF27/xblY2WidCtK/tjr29oNtZE69r1crSM
 vg8Y3FhHsp9V8GpF0OVjLlI3dwqXZWJ8PuRvOmOz5pHseihGfSRNZ5TNXcR8kUFkxkhM=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNv8i-000000005hO-1m00 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:44:10 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jJHbN0JNhzLlsX
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 17:44:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1793637840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F0fYOdr11VdzVW/OCy0NoSfqna0l63USk5YISmx+6eA=;
 b=ZaaxmICaxDH/9BU9/wAtuRbsjPTVejZ7Xj25hce7fj3VkEG3Tm6rlXsBKdx47Nke6xBMZg
 fiFTrZxfvq/fhYEWDAdxbhBH/W7nvmME6bU2j83088JhesyDPpy+VkT1Zd5BjJNmi2PRY0
 asYPp9IFo01Vx2klJwQlRhnd09PonP7rMdyN+/Obw13cGYbdVUUxc8aQx8Vz+ps1i9NsxL
 6YYQB4Ssbt+G9m1GyCkFArgIMdRo90jUJ7rbHGh09u4Z2+p5DdenVXaOfXGK/K81Z76imn
 g1qVRqSDNzrn4pM54QZGBJl7V+kzoYUvx6Ldp/u0VWbWbVutGSi2UnZRJfmBcg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 17:43:48 +0100
Message-ID: <20261102164353.459969-7-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102164353.459969-1-ralf@mandelbit.com>
References: <20261102164353.459969-1-ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJHbN0JNhzLlsX
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNv8i-000000005hO-1m00
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 6/9] ovpn: coalesce UDP
 data records with GRO
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

Register UDP tunnel GRO callbacks for ovpn data sockets and coalesce
compatible DATA_V2 records from one transport flow. Keep each encrypted
record as a separate frag-list entry so the receive path can detach and
authenticate records independently.

Match the complete opcode/key/peer header and require compatible outer-
network and checksum state. Flush on short records, differing segment
geometry, existing GSO input, or the 64-record limit.

Do not let a record which cannot join an aggregate overtake records of the
same transport flow which GRO is still holding. Complete the held aggregate
first; after an opcode, key ID or peer ID change, let the new record start the
next aggregate.

Export skb_gro_receive_list, which is already shared by the core UDP and
TCP frag-list GRO paths, so modular ovpn can use the same primitive
instead of maintaining a local copy.

Packet taps may clone a completed aggregate before UDP receives it.
Making the aggregate head private retains shared references to its child
skbs, so also clone and unshare each shared child before detaching the
list and handing its records to crypto.

On two directly connected 100-Gbit/s mlx5 ports, five interleaved
iperf3 -t 60 -O 10 single-flow AES-128-GCM runs in each direction
produced the following mean throughput:

                         Forward          Reverse
Without receive GRO     19.279 Gbit/s    19.819 Gbit/s
With frag-list GRO      22.773 Gbit/s    22.796 Gbit/s

The preceding UDP GSO transmit path and hardware UDP segmentation were
enabled in both cases. Frag-list GRO improved throughput by 18.1%
forward and 15.0% reverse.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1 https://lore.kernel.org/openvpn-devel/0431607b16294b9521e908f4d29a524698e39bb7.1790843153.git.ralf@mandelbit.com/
- Complete a held GRO aggregate before delivering an unmergeable record,
  and let a DATA_V2 record with a changed header start the next
  aggregate. (Antonio)

 drivers/net/ovpn/io.c  |   7 +-
 drivers/net/ovpn/udp.c | 216 ++++++++++++++++++++++++++++++++++++++++-
 net/core/gro.c         |   1 +
 net/ipv4/udp_offload.c |   3 +-
 4 files changed, 220 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 0f877be9807b..debe3d4d5731 100644
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
index a000401ed543..0c3557d90a1e 100644
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
@@ -27,6 +29,211 @@
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
+	/* A packet which cannot join an aggregate must not overtake records of
+	 * the same flow which GRO is still holding. Complete those first, as
+	 * the other GRO handlers do.
+	 */
+	if (!ovpn_udp_gro_header(skb, &header) ||
+	    FIELD_GET(OVPN_OPCODE_PKTTYPE_MASK, header) != OVPN_DATA_V2 ||
+	    skb_is_gso(skb)) {
+		NAPI_GRO_CB(skb)->flush = 1;
+		list_for_each_entry(p, head, list)
+			if (NAPI_GRO_CB(p)->same_flow)
+				return p;
+		return NULL;
+	}
+
+	list_for_each_entry(p, head, list) {
+		if (!NAPI_GRO_CB(p)->same_flow)
+			continue;
+
+		/* A different opcode, key ID or peer ID completes the held
+		 * aggregate; this record can start the next one.
+		 */
+		if (!ovpn_udp_gro_header(p, &header2) || header != header2)
+			return p;
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
+ * remaining records through fraglist. Here we segment by detaching that list
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
+	 * make shared info private before removing its fraglist
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
+		/* skb_unclone can leave fraglist children shared with a packet
+		 * tap, so make each skb header private before changing its
+		 * list pointer or control block. skb_cow_data makes the packet
+		 * data writable later in the decrypt path.
+		 */
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (unlikely(!skb)) {
+			ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
+
+			/* carry the current record's peer reference to the
+			 * next record or release it at the end of the list
+			 */
+			if (!next)
+				ovpn_peer_put(peer);
+			continue;
+		}
+
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
@@ -121,8 +328,7 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	/* pop off outer UDP header */
 	__skb_pull(skb, sizeof(struct udphdr));
-	skb_mark_not_on_list(skb);
-	ovpn_recv(peer, skb);
+	ovpn_udp_recv(peer, skb);
 	return 0;
 
 drop:
@@ -533,6 +739,8 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 		.encap_type = UDP_ENCAP_OVPNINUDP,
 		.encap_rcv = ovpn_udp_encap_recv,
 		.encap_destroy = ovpn_udp_encap_destroy,
+		.gro_receive = ovpn_udp_gro_receive_fraglist,
+		.gro_complete = ovpn_udp_gro_complete,
 	};
 	struct ovpn_socket *old_data;
 	int ret;
@@ -579,6 +787,8 @@ void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
 	struct sock *sk = ovpn_sock->sk;
 
+	udp_tunnel_cleanup_gro(sk);
+
 	/* Re-enable multicast loopback */
 	inet_set_bit(MC_LOOP, sk);
 	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
@@ -587,6 +797,8 @@ void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 	WRITE_ONCE(udp_sk(sk)->encap_type, 0);
 	WRITE_ONCE(udp_sk(sk)->encap_rcv, NULL);
 	WRITE_ONCE(udp_sk(sk)->encap_destroy, NULL);
+	WRITE_ONCE(udp_sk(sk)->gro_receive, NULL);
+	WRITE_ONCE(udp_sk(sk)->gro_complete, NULL);
 
 	rcu_assign_sk_user_data(sk, NULL);
 }
diff --git a/net/core/gro.c b/net/core/gro.c
index ff828a3dce3c..069df5d96075 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -266,6 +266,7 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 
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
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
