Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0171C88E5C
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y4D8IEqd09Ikz6bKEwPvw6V+C5db7es+nns46S6ZYHc=; b=JLSNM2sgm+MnkO0q10avtNb13r
	tTSxS2WUC4mhYZfe/n0+A4WW8BiERTcEijSt91O1aF1EH/eKw4iIvRdLdUXlsMwrgWoxK/QXJNj7v
	xVDoUomf32YPwJStIJuhDJIP0ldIXeRbaFiA4vUq/Bt19JBd2GlSouSHt0yCnNgTe56c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6o6a-00080b-OS;
	Wed, 16 Sep 2026 11:47:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6o6Y-00080G-VS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:47:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PdmXqDJ4XSbDTQx3vSbw/Zk67c4y0b+JCP3NdJtYkno=; b=EbSMi/T00uaKObjnanI4/6bGLZ
 m1ftJY4h1RrGfereqM51fMboCKFgTIFEmr5LmRPLc2lbAz3go/UpGarcpAwCl2sXk96Ktk8DnpHtE
 dxKGyEunTtaBh0n2Am5UucMqvCJ0QqWrggw41wpSeGsBE+qU05GCUUxqBbJ2q9sYlMjY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PdmXqDJ4XSbDTQx3vSbw/Zk67c4y0b+JCP3NdJtYkno=; b=NC0MEScmjdCKhUw3RvwaqgQLYz
 k9Lulv3DFGlY9o/4Q0t240o1r1ze6kLxIH28jVyT7dF4ByTW23JL8+VC7UkwkZX1ekmuxeKrQrJam
 t+vN4TNi9igc5wJgUbD92B1ZOyCAgJltG0NuZWtt1rQkNIXjXZbwvQAXyiCYvsMACjpU=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6o6X-0005OX-Qi for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:47:11 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hlHCs4XbGz5wp8
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 13:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789559193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdmXqDJ4XSbDTQx3vSbw/Zk67c4y0b+JCP3NdJtYkno=;
 b=n2rBHJFXNFnxpCXtRWeTRYtVOWZ2eh2iTPf5/rzPDZ5gmuugHoPY2z8GYpvlkPp6D4EjQL
 P+CmISzoU/C+BrHhYnh3Ky8HS2sGnPgrcyCp6BsuDCAkH25Lu+hYgHxpcejYzK8LBesuBI
 g/kC/FiAX+xg/fhoLVw9lSqvC8xLvpzkNBeVBgd0RUcjzCnWHRiPsqw+6Py3p+l/rCOmNN
 SF4jNX8awxSp+B+MWOcEkRqcFW0yzo3cZbte88R5mbSO8RqzpkdnaDEIF3WNZcmYUjtJJA
 JWC8ihhvgieT6d18F/8h2GaH3GX2GhNoQXMbs0P7qamp5w3YKTWwFA2nW4WbPA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 13:46:17 +0200
Message-ID: <abb01d05e0aaed435527daad3fdfde9bd9df3c5a.1789558856.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789558856.git.ralf@mandelbit.com>
References: <cover.1789558856.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hlHCs4XbGz5wp8
X-Headers-End: 1x6o6X-0005OX-Qi
Subject: [Openvpn-devel] [RFC ovpn net-next v4 9/9] ovpn: add opt-in direct
 GRO receive mode
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

The normal ovpn UDP GRO path retains compatible encrypted records in a
frag-list and lets the completed aggregate traverse the outer IP and UDP
receive stack before handing its records to the existing decryption
path.

Add an optional UDP GRO mode which instead consumes DATA_V2 packets from
the UDP tunnel GRO callback and starts their existing per-record
decryption immediately, similarly to xfrm. Control packets are flushed
from GRO, restored, and continue through the normal stack. Tagged packets
also remain on the full-stack path because VLAN device selection normally
happens after GRO.

Select the mode through the immutable IFLA_OVPN_UDP_GRO_MODE link
attribute. FULL_STACK remains the default for existing userspace, while
DIRECT enables the new path. Keep this local receive policy per ovpn
interface and select the corresponding GRO callback when each UDP socket
is attached. This makes all sockets attached to the interface behave
consistently without performing a mode lookup and dispatch for every
packet. Account for both ovpn callbacks in the UDP tunnel GRO callback
limit.

The direct mode deliberately bypasses packet taps, TC ingress, outer IP
validation and routing, netfilter hooks, the final UDP lookup, socket
XFRM policy, and normal UDP receive accounting for DATA_V2. It is
therefore an explicit operator choice for controlled transport
interfaces rather than a transparent replacement for the full receive
stack.

Extend the UDP throughput selftest with a PRE_ROUTING nftables counter,
verifying that full-stack aggregates reach the hook while direct-GRO
aggregates bypass it.

Before ciphertext prefetch was added to FULL_STACK, five interleaved
single-flow AES-128-GCM runs per direction on two directly connected
100-Gbit/s mlx5 ports measured 22.087/22.962 Gbit/s forward/reverse in
FULL_STACK and 24.315/25.313 Gbit/s in DIRECT, a 10.2% equal-weight
gain. With the preceding prefetch commit enabled in FULL_STACK, later
checks measured DIRECT within 1.3% forward and 0.7% reverse of
FULL_STACK.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v3 https://lore.kernel.org/openvpn-devel/d3636ca365346a0cd0d3a56946a792aa8bf5103a.1789546917.git.ralf@mandelbit.com/
- Leave VLAN-tagged packets to the normal receive stack in direct GRO
  mode. (Sashiko)

Changes since v2 https://lore.kernel.org/openvpn-devel/69c873c8837a0d8028c0427509aa384ee73be02b.1789540779.git.ralf@mandelbit.com/
- Copy the GRO mode into a byte-sized local before constructing the
  netlink attribute in ovpn-cli.c. (Sashiko)

No changes since v1 https://lore.kernel.org/openvpn-devel/b4bd25d6c4c01a81447a31054abd095e0533fcdd.1789485693.git.ralf@mandelbit.com/

 Documentation/netlink/specs/rt-link.yaml      |  12 ++
 drivers/net/ovpn/main.c                       |  15 ++-
 drivers/net/ovpn/ovpnpriv.h                   |   2 +
 drivers/net/ovpn/udp.c                        | 106 +++++++++++++-----
 include/uapi/linux/if_link.h                  |   6 +
 net/ipv4/udp_offload.c                        |   2 +-
 tools/testing/selftests/net/ovpn/Makefile     |   1 +
 tools/testing/selftests/net/ovpn/common.sh    |   4 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   |  40 ++++++-
 .../selftests/net/ovpn/test-gro-direct.sh     |  10 ++
 tools/testing/selftests/net/ovpn/test.sh      |  65 +++++++++++
 11 files changed, 229 insertions(+), 34 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-gro-direct.sh

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 7a72cd1b7e1e..d43e995c7f09 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -844,6 +844,14 @@ definitions:
     entries:
       - p2p
       - mp
+  -
+    name: ovpn-udp-gro-mode
+    enum-name: ovpn-udp-gro-mode
+    name-prefix: ovpn-udp-gro-mode
+    type: enum
+    entries:
+      - full-stack
+      - direct
   -
     name: br-stp-mode
     type: enum
@@ -2365,6 +2373,10 @@ attribute-sets:
         name: mode
         type: u8
         enum: ovpn-mode
+      -
+        name: udp-gro-mode
+        type: u8
+        enum: ovpn-udp-gro-mode
 
 sub-messages:
   -
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index ac4e0d85e215..ecf27d1e2420 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -129,6 +129,9 @@ static const struct device_type ovpn_type = {
 static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
 	[IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
 					    OVPN_MODE_MP),
+	[IFLA_OVPN_UDP_GRO_MODE] =
+		NLA_POLICY_RANGE(NLA_U8, OVPN_UDP_GRO_MODE_FULL_STACK,
+				 OVPN_UDP_GRO_MODE_DIRECT),
 };
 
 /**
@@ -200,6 +203,7 @@ static int ovpn_newlink(struct net_device *dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
+	enum ovpn_udp_gro_mode gro_mode = OVPN_UDP_GRO_MODE_FULL_STACK;
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct nlattr **data = params->data;
 	enum ovpn_mode mode = OVPN_MODE_P2P;
@@ -209,9 +213,14 @@ static int ovpn_newlink(struct net_device *dev,
 		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
 		netdev_dbg(dev, "setting device mode: %u\n", mode);
 	}
+	if (data && data[IFLA_OVPN_UDP_GRO_MODE]) {
+		gro_mode = nla_get_u8(data[IFLA_OVPN_UDP_GRO_MODE]);
+		netdev_dbg(dev, "setting UDP GRO mode: %u\n", gro_mode);
+	}
 
 	ovpn->dev = dev;
 	ovpn->mode = mode;
+	ovpn->gro_mode = gro_mode;
 	spin_lock_init(&ovpn->lock);
 	INIT_DELAYED_WORK(&ovpn->keepalive_work, ovpn_peer_keepalive_work);
 
@@ -237,8 +246,8 @@ static int ovpn_newlink(struct net_device *dev,
 
 static size_t ovpn_get_size(const struct net_device *dev)
 {
-	/* IFLA_OVPN_MODE */
-	return nla_total_size(sizeof(u8));
+	/* IFLA_OVPN_MODE and IFLA_OVPN_UDP_GRO_MODE */
+	return nla_total_size(sizeof(u8)) + nla_total_size(sizeof(u8));
 }
 
 static int ovpn_fill_info(struct sk_buff *skb, const struct net_device *dev)
@@ -247,6 +256,8 @@ static int ovpn_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	if (nla_put_u8(skb, IFLA_OVPN_MODE, ovpn->mode))
 		return -EMSGSIZE;
+	if (nla_put_u8(skb, IFLA_OVPN_UDP_GRO_MODE, ovpn->gro_mode))
+		return -EMSGSIZE;
 
 	return 0;
 }
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 84499140e4bd..dc6210b99f4a 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -40,6 +40,7 @@ struct ovpn_peer_collection {
  * struct ovpn_priv - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
  * @mode: device operation mode (i.e. p2p, mp, ..)
+ * @gro_mode: whether UDP data follows the full stack or is decrypted from GRO
  * @lock: protect this object
  * @peers: data structures holding multi-peer references
  * @peer: in P2P mode, this is the only remote peer
@@ -49,6 +50,7 @@ struct ovpn_peer_collection {
 struct ovpn_priv {
 	struct net_device *dev;
 	enum ovpn_mode mode;
+	enum ovpn_udp_gro_mode gro_mode;
 	spinlock_t lock; /* protect writing to the ovpn_priv object */
 	struct ovpn_peer_collection *peers;
 	struct ovpn_peer __rcu *peer;
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 920605ff329b..19526329a090 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/inetdevice.h>
 #include <linux/skbuff.h>
 #include <linux/socket.h>
@@ -272,23 +273,12 @@ static struct ovpn_socket *ovpn_socket_from_udp_sock(struct sock *sk)
 	return ovpn_sock;
 }
 
-/**
- * ovpn_udp_encap_recv - Start processing a received UDP packet.
- * @sk: socket over which the packet was received
- * @skb: the received packet
- *
- * If the first byte of the payload is:
- * - DATA_V2 the packet is accepted for further processing,
- * - DATA_V1 the packet is dropped as not supported,
- * - anything else the packet is forwarded to the UDP stack for
- *   delivery to user space.
- *
- * Return:
- *  0 if skb was consumed or dropped
- * >0 if skb should be passed up to userspace as UDP (packet not consumed)
- * <0 if skb should be resubmitted as proto -N (packet not consumed)
+/* Process one packet after the caller has made its OpenVPN header visible at
+ * @payload_offset. A zero return means the skb was consumed. A positive return
+ * leaves a control packet for the UDP socket.
  */
-static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
+static int ovpn_udp_data_recv(struct sock *sk, struct sk_buff *skb,
+			      unsigned int payload_offset)
 {
 	struct ovpn_socket *ovpn_sock;
 	struct ovpn_priv *ovpn;
@@ -309,18 +299,16 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		goto drop_noovpn;
 	}
 
-	/* Make sure the first 4 bytes of the skb data buffer after the UDP
-	 * header are accessible.
+	/* Make sure the first 4 bytes of the OpenVPN header are accessible.
 	 * They are required to fetch the OP code, the key ID and the peer ID.
 	 */
-	if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
-				    OVPN_OPCODE_SIZE))) {
+	if (unlikely(!pskb_may_pull(skb, payload_offset + OVPN_OPCODE_SIZE))) {
 		net_dbg_ratelimited("%s: packet too small from UDP socket\n",
 				    netdev_name(ovpn->dev));
 		goto drop;
 	}
 
-	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
+	opcode = ovpn_opcode_from_skb(skb, payload_offset);
 	if (unlikely(opcode != OVPN_DATA_V2)) {
 		/* DATA_V1 is not supported */
 		if (opcode == OVPN_DATA_V1)
@@ -330,7 +318,7 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		return 1;
 	}
 
-	peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
+	peer_id = ovpn_peer_id_from_skb(skb, payload_offset);
 	/* some OpenVPN server implementations send data packets with the
 	 * peer-id set to UNDEF. In this case we skip the peer lookup by peer-id
 	 * and we try with the transport address
@@ -343,8 +331,10 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(!peer))
 		goto drop;
 
-	/* pop off outer UDP header */
-	__skb_pull(skb, sizeof(struct udphdr));
+	/* the crypto receive path expects skb->data to begin at the OpenVPN
+	 * header and takes ownership of the skb
+	 */
+	__skb_pull(skb, payload_offset);
 	ovpn_udp_recv(peer, skb);
 	return 0;
 
@@ -355,6 +345,67 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+/* Consume DATA_V2 directly from UDP GRO. These packets deliberately bypass
+ * packet taps, TC ingress, the outer IP and netfilter receive paths, the final
+ * UDP lookup, and normal UDP accounting. Control packets are restored and
+ * continue through all of those layers normally.
+ */
+static struct sk_buff *ovpn_udp_gro_receive_direct(struct sock *sk,
+						   struct list_head *head,
+						   struct sk_buff *skb)
+{
+	unsigned int offset = skb_gro_offset(skb);
+
+	/* leave VLAN untagging and VLAN-device selection to the normal receive
+	 * stack rather than consuming the packet while it still describes the
+	 * lower device
+	 */
+	if (unlikely(skb_vlan_tag_present(skb) || eth_type_vlan(skb->protocol)))
+		goto flush;
+
+	/* if the OpenVPN header is not accessible, leave validation and drop
+	 * handling to the ordinary UDP receive path
+	 */
+	if (unlikely(!pskb_pull(skb, offset)))
+		goto flush;
+
+	/* tell UDP GRO not to touch the skb if it was consumed by the direct
+	 * receive path
+	 */
+	if (likely(!ovpn_udp_data_recv(sk, skb, 0)))
+		return ERR_PTR(-EINPROGRESS);
+
+	/* control packets still belong to the socket so we restore the data
+	 * pointer because the normal receive path expects the outer headers
+	 */
+	skb_push(skb, offset);
+
+flush:
+	NAPI_GRO_CB(skb)->same_flow = 0;
+	NAPI_GRO_CB(skb)->flush = 1;
+	return NULL;
+}
+
+/**
+ * ovpn_udp_encap_recv - Start processing a received UDP packet.
+ * @sk: socket over which the packet was received
+ * @skb: the received packet
+ *
+ * If the first byte of the payload is:
+ * - DATA_V2 the packet is accepted for further processing,
+ * - DATA_V1 the packet is dropped as not supported,
+ * - anything else the packet is forwarded to the UDP stack for
+ *   delivery to user space.
+ *
+ * Return:
+ * 0 if @skb was consumed or dropped
+ * 1 if @skb should continue through normal UDP delivery
+ */
+static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
+{
+	return ovpn_udp_data_recv(sk, skb, sizeof(struct udphdr));
+}
+
 /**
  * ovpn_udp4_output - send IPv4 packet over udp socket
  * @peer: the destination peer
@@ -631,7 +682,12 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 		.encap_type = UDP_ENCAP_OVPNINUDP,
 		.encap_rcv = ovpn_udp_encap_recv,
 		.encap_destroy = ovpn_udp_encap_destroy,
-		.gro_receive = ovpn_udp_gro_receive_fraglist,
+		/* GRO mode cannot change after the interface is created so
+		 * select the socket callback once at socket setup
+		 */
+		.gro_receive = ovpn->gro_mode == OVPN_UDP_GRO_MODE_DIRECT ?
+			       ovpn_udp_gro_receive_direct :
+			       ovpn_udp_gro_receive_fraglist,
 		.gro_complete = ovpn_udp_gro_complete,
 	};
 	struct ovpn_socket *old_data;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 245b36204525..2d7b320f83be 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -2067,9 +2067,15 @@ enum ovpn_mode {
 	OVPN_MODE_MP,
 };
 
+enum ovpn_udp_gro_mode {
+	OVPN_UDP_GRO_MODE_FULL_STACK,
+	OVPN_UDP_GRO_MODE_DIRECT,
+};
+
 enum {
 	IFLA_OVPN_UNSPEC,
 	IFLA_OVPN_MODE,
+	IFLA_OVPN_UDP_GRO_MODE,
 	__IFLA_OVPN_MAX,
 };
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 187f108f3ee8..bfe23ec9dfca 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -41,7 +41,7 @@ struct udp_tunnel_type_entry {
 			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
 			      IS_ENABLED(CONFIG_NET_FOU) * 2 + \
 			      IS_ENABLED(CONFIG_XFRM) * 2 + \
-			      IS_ENABLED(CONFIG_OVPN))
+			      IS_ENABLED(CONFIG_OVPN) * 2)
 
 DEFINE_STATIC_CALL(udp_tunnel_gro_rcv, dummy_gro_rcv);
 static DEFINE_STATIC_KEY_FALSE(udp_tunnel_static_call);
diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index 169f0464ac3a..412a70abf739 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -37,6 +37,7 @@ TEST_PROGS := \
 	test-close-socket-tcp.sh \
 	test-close-socket.sh \
 	test-float.sh \
+	test-gro-direct.sh \
 	test-large-mtu.sh \
 	test-mark.sh \
 	test-symmetric-id-float.sh \
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e..1467caa95168 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -10,6 +10,7 @@ source "$OVPN_COMMON_DIR/../../kselftest/ktap_helpers.sh"
 OVPN_UDP_PEERS_FILE=${OVPN_UDP_PEERS_FILE:-udp_peers.txt}
 OVPN_TCP_PEERS_FILE=${OVPN_TCP_PEERS_FILE:-tcp_peers.txt}
 OVPN_CLI=${OVPN_CLI:-${OVPN_COMMON_DIR}/ovpn-cli}
+OVPN_UDP_GRO_MODE=${OVPN_UDP_GRO_MODE:-FULL_STACK}
 OVPN_YNL=${OVPN_YNL:-${OVPN_COMMON_DIR}/../../../../net/ynl/pyynl/cli.py}
 OVPN_ALG=${OVPN_ALG:-aes}
 OVPN_PROTO=${OVPN_PROTO:-UDP}
@@ -162,7 +163,8 @@ ovpn_setup_ns() {
 		done
 	fi
 
-	ip netns exec "${peer}" ${OVPN_CLI} new_iface tun${1} $MODE
+	ip netns exec "${peer}" ${OVPN_CLI} new_iface tun${1} $MODE \
+		"${OVPN_UDP_GRO_MODE}"
 	ip -n "${peer}" addr add ${2} dev tun${1}
 	# add a secondary IP to peer 1, to test a LAN behind a client
 	if [ ${1} -eq 1 -a -n "${OVPN_LAN_IP}" ]; then
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index f4effa7580c0..5d3ae8fb1152 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -123,6 +123,8 @@ struct ovpn_ctx {
 	char ifname[IFNAMSIZ];
 	enum ovpn_mode mode;
 	bool mode_set;
+	enum ovpn_udp_gro_mode udp_gro_mode;
+	bool udp_gro_mode_set;
 
 	int socket;
 	int cli_sockets[MAX_PEERS];
@@ -1375,10 +1377,12 @@ static int ovpn_new_iface(struct ovpn_ctx *ovpn)
 {
 	struct rtattr *linkinfo, *data;
 	struct ovpn_link_req req = { 0 };
+	uint8_t udp_gro_mode;
 	int ret = -1;
 
-	fprintf(stdout, "Creating interface %s with mode %u\n", ovpn->ifname,
-		ovpn->mode);
+	fprintf(stdout,
+		"Creating interface %s with mode %u and UDP GRO mode %u\n",
+		ovpn->ifname, ovpn->mode, ovpn->udp_gro_mode);
 
 	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
 	req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
@@ -1396,15 +1400,22 @@ static int ovpn_new_iface(struct ovpn_ctx *ovpn)
 			 strlen(OVPN_FAMILY_NAME) + 1) < 0)
 		goto err;
 
-	if (ovpn->mode_set) {
+	if (ovpn->mode_set || ovpn->udp_gro_mode_set) {
 		data = ovpn_nest_start(&req.n, sizeof(req), IFLA_INFO_DATA);
 		if (!data)
 			goto err;
 
-		if (ovpn_addattr(&req.n, sizeof(req), IFLA_OVPN_MODE,
+		if (ovpn->mode_set &&
+		    ovpn_addattr(&req.n, sizeof(req), IFLA_OVPN_MODE,
 				 &ovpn->mode, sizeof(uint8_t)) < 0)
 			goto err;
 
+		udp_gro_mode = ovpn->udp_gro_mode;
+		if (ovpn->udp_gro_mode_set &&
+		    ovpn_addattr(&req.n, sizeof(req), IFLA_OVPN_UDP_GRO_MODE,
+				 &udp_gro_mode, sizeof(udp_gro_mode)) < 0)
+			goto err;
+
 		ovpn_nest_end(&req.n, data);
 	}
 
@@ -1666,11 +1677,16 @@ static void usage(const char *cmd)
 		cmd);
 	fprintf(stderr, "where <command> can be one of the following\n\n");
 
-	fprintf(stderr, "* new_iface <iface> [mode]: create new ovpn interface\n");
+	fprintf(stderr,
+		"* new_iface <iface> [mode] [udp-gro-mode]: create new ovpn interface\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr, "\tmode:\n");
 	fprintf(stderr, "\t\t- P2P for peer-to-peer mode (i.e. client)\n");
 	fprintf(stderr, "\t\t- MP for multi-peer mode (i.e. server)\n");
+	fprintf(stderr, "\tudp-gro-mode:\n");
+	fprintf(stderr, "\t\t- FULL_STACK for the normal receive stack\n");
+	fprintf(stderr,
+		"\t\t- DIRECT to decrypt data from the UDP GRO callback\n");
 
 	fprintf(stderr, "* del_iface <iface>: delete ovpn interface\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
@@ -2206,6 +2222,20 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 			return -1;
 		}
 		ovpn->mode_set = true;
+
+		if (argc < 5)
+			break;
+
+		if (!strcmp(argv[4], "FULL_STACK")) {
+			ovpn->udp_gro_mode = OVPN_UDP_GRO_MODE_FULL_STACK;
+		} else if (!strcmp(argv[4], "DIRECT")) {
+			ovpn->udp_gro_mode = OVPN_UDP_GRO_MODE_DIRECT;
+		} else {
+			fprintf(stderr, "Cannot parse UDP GRO mode: %s\n",
+				argv[4]);
+			return -1;
+		}
+		ovpn->udp_gro_mode_set = true;
 		break;
 	case CMD_DEL_IFACE:
 		break;
diff --git a/tools/testing/selftests/net/ovpn/test-gro-direct.sh b/tools/testing/selftests/net/ovpn/test-gro-direct.sh
new file mode 100755
index 000000000000..f35db23eb425
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-gro-direct.sh
@@ -0,0 +1,10 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2025 OpenVPN, Inc.
+#
+#	Author:	Ralf Lici <ralf@mandelbit.com>
+#		Antonio Quartulli <antonio@openvpn.net>
+
+OVPN_UDP_GRO_MODE="DIRECT"
+
+source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032..55cb4d4c3e3d 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -113,6 +113,67 @@ ovpn_run_lan_traffic() {
 		ip netns exec ovpn_peer0 ping -qfc 100 -w 3 "${OVPN_LAN_IP}"
 }
 
+ovpn_udp_gro_counter_add() {
+	[ "${OVPN_PROTO}" == "UDP" ] || return 0
+	# A custom tunnel MTU can fragment outer packets before UDP GRO.
+	[ -z "${MTU:-}" ] || return 0
+
+	# Enable UDP forwarding GRO on the receiving endpoint so this test
+	# exercises the configured ovpn callback.
+	ovpn_cmd_ok "enable UDP GRO on the iperf receive path" \
+		ip netns exec ovpn_peer0 ethtool -K veth1 gro on \
+		rx-udp-gro-forwarding on
+
+	ovpn_cmd_ok "create UDP GRO path counter table" \
+		ip netns exec ovpn_peer0 nft add table inet ovpn_gro_test
+	ovpn_cmd_ok "create UDP GRO path counter chain" \
+		ip netns exec ovpn_peer0 nft \
+		"add chain inet ovpn_gro_test prerouting { type filter hook \
+		prerouting priority filter; policy accept; }"
+
+	# Count only aggregated outer packets after they enter the normal
+	# receive stack in peer0. Direct GRO consumes those DATA_V2 aggregates
+	# before this hook, while small packets which bypass veth's GRO path
+	# are deliberately ignored.
+	ovpn_cmd_ok "add UDP GRO path counter" \
+		ip netns exec ovpn_peer0 nft add rule inet ovpn_gro_test \
+		prerouting iifname "veth1" meta length gt 1500 udp dport 1 \
+		counter
+}
+
+ovpn_udp_gro_counter_check() {
+	local packets
+
+	[ "${OVPN_PROTO}" == "UDP" ] || return 0
+	[ -z "${MTU:-}" ] || return 0
+
+	packets=$(ip netns exec ovpn_peer0 nft list chain inet ovpn_gro_test \
+		prerouting | sed -n \
+		's/.*counter packets \([0-9][0-9]*\) bytes.*/\1/p')
+	ovpn_cmd_ok "remove UDP GRO path counter table" \
+		ip netns exec ovpn_peer0 nft delete table inet ovpn_gro_test
+
+	if [ -z "${packets}" ]; then
+		printf '%s\n' "unable to read UDP GRO path counter"
+		return 1
+	fi
+
+	if [ "${OVPN_UDP_GRO_MODE}" == "FULL_STACK" ]; then
+		if [ "${packets}" -eq 0 ]; then
+			printf '%s\n' \
+				"full-stack UDP GRO did not reach PRE_ROUTING"
+			return 1
+		fi
+		return 0
+	fi
+
+	if [ "${packets}" -ne 0 ]; then
+		printf '%s\n' \
+			"direct UDP GRO reached PRE_ROUTING ${packets} times"
+		return 1
+	fi
+}
+
 ovpn_run_float_mode() {
 	local p
 	local peer_ns
@@ -134,12 +195,16 @@ ovpn_run_float_mode() {
 ovpn_run_iperf() {
 	local iperf_pid
 
+	ovpn_udp_gro_counter_add
+
 	ovpn_run_bg iperf_pid ip netns exec ovpn_peer0 iperf3 -1 -s
 	sleep 1
 
 	ovpn_cmd_ok "run iperf throughput flow" \
 		ip netns exec ovpn_peer1 iperf3 -Z -t 3 -c 5.5.5.1
 	wait "${iperf_pid}" || return 1
+
+	ovpn_udp_gro_counter_check
 }
 
 ovpn_run_key_rollover() {
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
