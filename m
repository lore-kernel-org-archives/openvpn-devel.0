Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602C606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mSDfoO9/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RCFeAhNN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JaOXHCDu;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=wyUsXB9x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=054ExcMcuhUj3mS+Pr/FJB7oOycgijTJyMkGEUxNLXY=; b=mSDfoO9/KCuepS
	OrLWd8hq0CTZaExCG570PZdDo6NOaR4DxcNHwOQKKTBOjJl6/ZSBqzGw4s0uZ+Kczr2pgOfkAgsxe
	ZN7cFpfm/AwQCCroub5r07xr8s2QvNa7BlYm+lPUp7OPb6X4tIADxIofTxL5Qs2gQ0odH4ThVBGgP
	new=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQpJ9-000000000V1-3nu8;
	Tue, 10 Nov 2026 17:06:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQpJ1-000000000U7-2St4
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 17:06:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XasjfT8UaxuVL+wBkYQNjWq9PAhbzmdO7oehnAWWRDU=; b=RCFeAhNNEyOLuGHR7/z8KlOoc7
 VwNCOv0iDPJqNY6+Tjq8vPvzU2i8eJk0UtoagrCAX1z06ZWOMId2zoaBL33XIGdv5zNC6vHe9pbSr
 /i6RssZ/lgU0HP5C6otvW4e78tS+9BLbt8TTE1DuNiPfj+mLIj+mITyqJ686oMyiyoB8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XasjfT8UaxuVL+wBkYQNjWq9PAhbzmdO7oehnAWWRDU=; b=JaOXHCDuwlvfRgK07DcCFdJ/xY
 Px9e8Jqr+1scGdXsodhIRABtMad/8y0B/HD1zWk3C2lnQwGLd3RL5D0vA6Nt5de2CfZG6WcVEredU
 CKBpIzNgKIcA8jqfkP416gLk+hiD33wf7zT0yjNdj6TMD7aNJ/niq7dWcrvMHrNtUBJc=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQpIz-000000003wV-1iIs for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 17:06:47 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jPCjm1vGtz9s5q
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 18:06:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794330396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XasjfT8UaxuVL+wBkYQNjWq9PAhbzmdO7oehnAWWRDU=;
 b=wyUsXB9xf1+/Vf4EQz39mVrXyOTOzEjFKUj419ibm7V1vlzIYoC6QMZbAHjjapevlT2pmx
 1cuhN8IEgSlKdqZh4x4eE6WR25nS0+z/4D+eDXFLAOky5fH6f/GsPNgc23pTTNrKqtDTqY
 Znf/8e6S9RIVfYJxmpdYpbgMWxlgcgEGqaugTOYqUjXp/Lw/6Kh6nqixWEp9A9KplRIpFD
 +9ziLTaUK5qEY+X+2vwaAuD8NJYq866fiQJC4hGDAa52DmHRuRi1FDfHkIPW4H+zVTzFlM
 xqmf5GSQAr2syPqF1TazZKN+Zk4WJ812CKEoHl9pv+uBJXxTFfPFJeWorjSi3Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 18:06:21 +0100
Message-ID: <3f88e036a4684c371956d26962e2ce6d02d61ab1.1794329430.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794329430.git.ralf@mandelbit.com>
References: <cover.1794329430.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jPCjm1vGtz9s5q
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQpIz-000000003wV-1iIs
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 5/6] ovpn: coalesce UDP
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

Register a UDP tunnel GRO receive callback for ovpn data sockets and
coalesce compatible DATA_V2 records from one transport flow. Keep every
encrypted record as a separate frag-list entry so the receive path can
authenticate it independently.

Match the complete opcode, key and peer header and require compatible
outer-network and checksum state. Flush on short records, differing
segment geometry, existing GSO input, or the 64-record limit. Complete a
held aggregate before an incompatible record from the same transport
flow, preventing the new record from overtaking it.

GRO socket lookup is not authoritative, so a generic UDP frag-list
aggregate may later land on an ovpn socket, for example after DNAT.
Consume only aggregates with standard, unmodified geometry, private head
and child skbs, linear and uniform OpenVPN headers, and an outer tuple
unchanged since GRO. Decline every other aggregate so UDP segments it
and retries delivery one datagram at a time. Inspect aggregates without
pulling, since a declined one must reach UDP unmodified.

Detach compatible frag lists directly instead of rebuilding standalone
UDP packets whose outer headers would be discarded after decryption.
Repair the aggregate head accounting, retain the outer headers needed
for authenticated endpoint updates, propagate post-GRO protocol, ingress
interface, priority, security mark and tc index metadata to every
record. Clear the outer VLAN tag, redirect and classification flags and
delivery time, which the receive stack consumed on the head only.

The socket also opts into the detachable GRO receive contract, since
it's owned by userspace. Refuse a socket which another encapsulation,
such as ESP-in-UDP, has configured without setting sk_user_data, since
its GRO callback could not be replaced. Teardown removes callbacks only
while they remain owned by ovpn and waits for readers which may already
have captured one. This keeps ovpn detachable GRO state and callback
lifetimes consistent if UDP_ENCAP changes the socket configuration.

The GRO implementation does not depend on the linked ovpn UDP GSO
transmit series, but the measurement kernel carried it so that transmit
did not limit throughput. On two directly connected 100-Gbit/s mlx5
ports, five interleaved 60-second iperf3 -Z single-flow AES-128-GCM runs
in each direction, after a 10-second warm-up, produced the following
mean throughput:

                         Forward          Reverse
Without GRO             18.721 Gbit/s    18.777 Gbit/s
With GRO                21.542 Gbit/s    21.366 Gbit/s

GRO improved throughput by 15.1% forward and 13.8% reverse. Mean cycles
and instructions per byte across the monitored data-path CPUs fell from
4.535 to 4.207 (7.2%) and from 10.913 to 9.417 (13.7%), respectively.

Link: https://lore.kernel.org/openvpn-devel/cover.1794244231.git.ralf@mandelbit.com/
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1 https://lore.kernel.org/openvpn-devel/36b08ba627b885149ef45de3b6a26c52f857387d.1794314969.git.ralf@mandelbit.com/
- Refuse a socket which another encapsulation has configured without
  setting sk_user_data (Sashiko)
- Read a held aggregate's header without pulling it (Sashiko)
- Check aggregates in the encap callback without pulling them (Sashiko)
- Clear the redirect, classification and delivery time state which the
  receive stack consumed on the aggregate head only (Sashiko)
- Test skb_is_gso before pulling a new record's header

 drivers/net/ovpn/udp.c | 326 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 315 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 055cdb1bee13..f2deec4b44fb 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -8,11 +8,14 @@
 
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
+#include <linux/if_vlan.h>
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
@@ -27,6 +30,242 @@
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
+	int ret = 0, nhoff;
+	bool flush;
+	u32 header;
+
+	/* A packet which cannot join an aggregate must not overtake records of
+	 * the same flow which GRO is still holding. Complete those first, as
+	 * the other GRO handlers do.
+	 */
+	if (NAPI_GRO_CB(skb)->flush || skb->encapsulation || skb_is_gso(skb) ||
+	    !ovpn_udp_gro_header(skb, &header) ||
+	    FIELD_GET(OVPN_OPCODE_PKTTYPE_MASK, header) != OVPN_DATA_V2) {
+		NAPI_GRO_CB(skb)->flush = 1;
+		list_for_each_entry(p, head, list)
+			if (NAPI_GRO_CB(p)->same_flow)
+				return p;
+		return NULL;
+	}
+
+	/* udp_gro_receive sets encap_mark before invoking a tunnel callback,
+	 * normally because the callback recurses into an inner protocol. ovpn
+	 * retains complete outer UDP records instead, so clear it and use
+	 * ordinary UDP frag-list completion.
+	 */
+	NAPI_GRO_CB(skb)->encap_mark = 0;
+	NAPI_GRO_CB(skb)->is_flist = 1;
+
+	list_for_each_entry(p, head, list) {
+		if (!NAPI_GRO_CB(p)->same_flow)
+			continue;
+
+		/* A different representation, opcode, key or peer ID completes
+		 * the held aggregate; this record can start the next one.
+		 * Read the held header without pulling which might change the
+		 * skb shape.
+		 */
+		if (NAPI_GRO_CB(p)->encap_mark || !NAPI_GRO_CB(p)->is_flist ||
+		    skb_headlen(p) < skb_gro_offset(p) + OVPN_OPCODE_SIZE ||
+		    get_unaligned_be32(p->data + skb_gro_offset(p)) != header)
+			return p;
+
+		/* GRO has already matched the outer addresses and UDP ports;
+		 * check the remaining outer IP fields
+		 */
+		flush = gro_receive_network_flush(udp_hdr(skb), udp_hdr(p), p);
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
+static bool ovpn_udp_outer_match(const struct sk_buff *head,
+				 const struct sk_buff *frag)
+{
+	const struct udphdr *uhf = udp_hdr(frag);
+	const struct udphdr *uhh = udp_hdr(head);
+
+	/* NAT might have rewritten endpoints after GRO */
+	if (unlikely(uhh->source != uhf->source || uhh->dest != uhf->dest))
+		return false;
+
+	switch (head->protocol) {
+	case htons(ETH_P_IP):
+		return ip_hdr(head)->saddr == ip_hdr(frag)->saddr &&
+		       ip_hdr(head)->daddr == ip_hdr(frag)->daddr;
+	case htons(ETH_P_IPV6):
+		return ipv6_addr_equal(&ipv6_hdr(head)->saddr,
+				       &ipv6_hdr(frag)->saddr) &&
+		       ipv6_addr_equal(&ipv6_hdr(head)->daddr,
+				       &ipv6_hdr(frag)->daddr);
+	default:
+		return false;
+	}
+}
+
+/* validate an skb and turn it into a list of uniform OpenVPN records or return
+ * NULL without modifying an aggregate which UDP must segment
+ */
+static struct sk_buff *ovpn_udp_gso_prepare(struct sk_buff *skb, u32 header)
+{
+	unsigned int len = 0, truesize = 0;
+	struct sk_buff *list, *record;
+
+	if (!skb_is_gso(skb)) {
+		skb_mark_not_on_list(skb);
+		goto out;
+	}
+
+	list = skb_shinfo(skb)->frag_list;
+	if (unlikely(!list))
+		return NULL;
+
+	/* if any of the skbs is not private, ask the stack to segment */
+	if (unlikely(skb_shared(skb) || skb_cloned(skb)))
+		return NULL;
+
+	/* transformations after GRO only update the aggregate head: if its
+	 * outer tuple changed, ask UDP to propagate it while segmenting
+	 */
+	if (unlikely(skb_pagelen(skb) != sizeof(struct udphdr) +
+					 skb_shinfo(skb)->gso_size ||
+		     !ovpn_udp_outer_match(skb, list)))
+		return NULL;
+
+	skb_walk_frags(skb, record) {
+		/* if the OpenVPN header is not uniform (batch created by
+		 * generic GRO by coalescing unrelated packets) ask the stack
+		 * to segment and handle each segment independently
+		 */
+		if (unlikely(skb_shared(record) || skb_cloned(record) ||
+			     skb_headlen(record) < OVPN_OPCODE_SIZE ||
+			     get_unaligned_be32(record->data) != header))
+			return NULL;
+
+		len += record->len;
+		truesize += record->truesize;
+	}
+
+	if (unlikely(skb->data_len < len || skb->len < len ||
+		     skb->truesize < truesize))
+		return NULL;
+
+	/* detach the exclusively owned fraglist */
+	skb_shinfo(skb)->frag_list = NULL;
+	skb->data_len -= len;
+	skb->truesize -= truesize;
+	skb->len -= len;
+	skb->next = list;
+	skb_gso_reset(skb);
+
+out:
+	/* skb_gro_receive_list has already pulled the UDP headers from child
+	 * records, while the aggregate head still starts at UDP, so pull its
+	 * header too before returning the list
+	 */
+	__skb_pull(skb, sizeof(struct udphdr));
+	return skb;
+}
+
+static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *list)
+{
+	const __be16 proto = list->protocol;
+	const u32 priority = list->priority;
+#ifdef CONFIG_NET_SCHED
+	const u16 tc_index = list->tc_index;
+#endif
+#ifdef CONFIG_NETWORK_SECMARK
+	const u32 secmark = list->secmark;
+#endif
+	const int skb_iif = list->skb_iif;
+	struct sk_buff *skb, *next;
+
+	skb_list_walk_safe(list, skb, next) {
+		/* propagate post-GRO metadata from the list head, and clear
+		 * the state which the receive stack consumed on the head only
+		 */
+		skb->protocol = proto;
+		skb->skb_iif = skb_iif;
+		skb->priority = priority;
+#ifdef CONFIG_NETWORK_SECMARK
+		skb->secmark = secmark;
+#endif
+#ifdef CONFIG_NET_SCHED
+		skb->tc_index = tc_index;
+#endif
+		__vlan_hwaccel_clear_tag(skb);
+		skb_reset_redirect(skb);
+#ifdef CONFIG_NET_XGRESS
+		skb->tc_skip_classify = 0;
+#endif
+		skb_clear_delivery_time(skb);
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
+		ovpn_recv(peer, skb);
+	}
+}
+
 /* Retrieve the corresponding ovpn object from a UDP socket
  * rcu_read_lock must be held on entry
  */
@@ -69,7 +308,9 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	struct ovpn_socket *ovpn_sock;
 	struct ovpn_priv *ovpn;
 	struct ovpn_peer *peer;
-	u32 peer_id;
+	bool aggregate = false;
+	struct sk_buff *list;
+	u32 header, peer_id;
 	u8 opcode;
 
 	ovpn_sock = ovpn_socket_from_udp_sock(sk);
@@ -89,14 +330,28 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	 * header are accessible.
 	 * They are required to fetch the OP code, the key ID and the peer ID.
 	 */
-	if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
-				    OVPN_OPCODE_SIZE))) {
+	if (skb_is_gso(skb)) {
+		/* Only an accepted frag-list aggregate can carry OpenVPN
+		 * records. It is checked without pulling, since one which we
+		 * decline must reach UDP unmodified so that it can segment it.
+		 */
+		if (unlikely(skb_shinfo(skb)->gso_type !=
+			     (SKB_GSO_UDP_L4 | SKB_GSO_FRAGLIST)))
+			goto drop;
+		aggregate = true;
+
+		if (unlikely(skb_headlen(skb) <
+			     sizeof(struct udphdr) + OVPN_OPCODE_SIZE))
+			goto drop;
+	} else if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
+					   OVPN_OPCODE_SIZE))) {
 		net_dbg_ratelimited("%s: packet too small from UDP socket\n",
 				    netdev_name(ovpn->dev));
 		goto drop;
 	}
 
-	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
+	header = get_unaligned_be32(skb->data + sizeof(struct udphdr));
+	opcode = FIELD_GET(OVPN_OPCODE_PKTTYPE_MASK, header);
 	if (unlikely(opcode != OVPN_DATA_V2)) {
 		/* DATA_V1 is not supported */
 		if (opcode == OVPN_DATA_V1)
@@ -106,7 +361,7 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		return 1;
 	}
 
-	peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
+	peer_id = FIELD_GET(OVPN_OPCODE_PEERID_MASK, header);
 	/* some OpenVPN server implementations send data packets with the
 	 * peer-id set to UNDEF. In this case we skip the peer lookup by peer-id
 	 * and we try with the transport address
@@ -119,12 +374,27 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(!peer))
 		goto drop;
 
-	/* pop off outer UDP header */
-	__skb_pull(skb, sizeof(struct udphdr));
-	ovpn_recv(peer, skb);
+	/* A generic aggregate may contain records for different consumers and
+	 * post-GRO transformations may have changed only its head. Prepare
+	 * only a private, unmodified aggregate with uniform opcode, key ID and
+	 * peer ID; otherwise return it to UDP for segmentation.
+	 */
+	list = ovpn_udp_gso_prepare(skb, header);
+	if (unlikely(!list)) {
+		ovpn_peer_put(peer);
+		return 1;
+	}
+
+	ovpn_udp_recv(peer, list);
 	return 0;
 
 drop:
+	/* let UDP segment an accepted aggregate so that every datagram gets
+	 * its own verdict
+	 */
+	if (aggregate)
+		return 1;
+
 	ovpn_dev_dstats_rx_dropped(ovpn->dev);
 drop_noovpn:
 	kfree_skb(skb);
@@ -512,8 +782,11 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 	struct udp_tunnel_sock_cfg cfg = {
 		.sk_user_data = ovpn_sock,
 		.encap_type = UDP_ENCAP_OVPNINUDP,
+		.udp_flags = BIT(UDP_FLAGS_GRO_RCV_DETACHABLE) |
+			     BIT(UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST),
 		.encap_rcv = ovpn_udp_encap_recv,
 		.encap_destroy = ovpn_udp_encap_destroy,
+		.gro_receive = ovpn_udp_gro_receive_fraglist,
 	};
 	struct ovpn_socket *old_data;
 	int ret;
@@ -522,6 +795,18 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 	rcu_read_lock();
 	old_data = rcu_dereference_sk_user_data(ovpn_sock->sk);
 	if (!old_data) {
+		/* another encapsulation (such as ESP-in-UDP) may own the
+		 * socket without setting sk_user_data, and the GRO callback
+		 * which it may have registered cannot be replaced
+		 */
+		if (READ_ONCE(udp_sk(ovpn_sock->sk)->encap_type) ||
+		    READ_ONCE(udp_sk(ovpn_sock->sk)->gro_receive)) {
+			rcu_read_unlock();
+			netdev_dbg(ovpn->dev,
+				   "provided socket already taken by other user\n");
+			return -EBUSY;
+		}
+
 		/* socket is currently unused - we can take it */
 		rcu_read_unlock();
 		setup_udp_tunnel_sock(sock_net(ovpn_sock->sk), sock->sk, &cfg);
@@ -558,16 +843,35 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
  */
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
+	struct udp_sock *up = udp_sk(ovpn_sock->sk);
 	struct sock *sk = ovpn_sock->sk;
 
+	/* Stop accepting aggregates while encap_rcv is still available. A
+	 * reader which sampled acceptance before it was cleared can either be
+	 * consumed by ovpn or fall back to UDP segmentation.
+	 */
+	if (udp_test_bit(GRO_RCV_DETACHABLE, sk) &&
+	    READ_ONCE(up->gro_receive) == ovpn_udp_gro_receive_fraglist)
+		udp_tunnel_detach_gro(sk);
+
+	/* UDP_ENCAP may have replaced encap_rcv while leaving other ovpn state
+	 * attached. Clear only callbacks still owned by ovpn. The final RCU
+	 * grace period in ovpn_socket_release drains readers which captured
+	 * encap_rcv before this point.
+	 */
+	if (READ_ONCE(up->encap_rcv) == ovpn_udp_encap_recv)
+		WRITE_ONCE(up->encap_rcv, NULL);
+	if (READ_ONCE(up->encap_destroy) == ovpn_udp_encap_destroy)
+		WRITE_ONCE(up->encap_destroy, NULL);
+
 	/* Re-enable multicast loopback */
 	inet_set_bit(MC_LOOP, sk);
 	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
 	inet_dec_convert_csum(sk);
 
-	WRITE_ONCE(udp_sk(sk)->encap_type, 0);
-	WRITE_ONCE(udp_sk(sk)->encap_rcv, NULL);
-	WRITE_ONCE(udp_sk(sk)->encap_destroy, NULL);
+	/* UDP_ENCAP might have rewritten the encap_type */
+	if (READ_ONCE(up->encap_type) == UDP_ENCAP_OVPNINUDP)
+		WRITE_ONCE(up->encap_type, 0);
 
 	rcu_assign_sk_user_data(sk, NULL);
 }
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
