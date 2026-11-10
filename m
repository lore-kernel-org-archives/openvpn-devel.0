Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26274606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NPib6y+O;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=McTFTwqz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gxSqUmKE;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=1fL8JEY8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IEAia5BQ5irQSywuIKyNLq03DjjE7P3v1DOYaF6lLIw=; b=NPib6y+OPmgWNF
	deovUS9xEFgok2TvXwgg72FAFDwfcvY7wIwb5AIDla7FFY2tke2DEQXvBWB7cwfeqkR2Ih6G/5m0W
	w6G6YY3+ypfVEIic+NNzhF0OnjL8sOhaWPSi2Me77qFGaDjRnxmT4qf8ImNruxYNlh+6iywOBhJb0
	IYc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQpJ4-000000001QZ-3ZPw;
	Tue, 10 Nov 2026 17:06:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xQpJ0-000000001Q5-1VBs
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 17:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7T+J4+WlOB2IxlaIc1AotJlP4U892h0v4xRYK4YTHUA=; b=McTFTwqzAZjD6vQ8lUZsywTigE
 jBAUdy6YVOx44yKRL69Ge0GCj41Kcz9yTDR69ON64nmVgDqKGtwo+p6bM6Z6W0NO/5WnM6q1Se/f9
 6hBhxzKqxc4MQADlrrLlleQTdtt9feXeTZsl6rdTvXEegewdgXwzOskN1DU98ooewnSw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7T+J4+WlOB2IxlaIc1AotJlP4U892h0v4xRYK4YTHUA=; b=gxSqUmKEwcwSMW50qZTpgVorua
 tKVXFVq2sDTCef77Nj4v0tehgSbBXP5u7ntPDKcD7nKUTMmkSU3v3OFAxtBDeP72VGMvBwcF2Xtv1
 zfaPrY7W4iAnIGDvQNd13UZnGUPgVEFEy9ik9thHJHI4DC5YbYWnVsIZUxgXYsaBp6rs=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQpIx-000000003wS-1rGl for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 17:06:46 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jPCjl2QC1zQm
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 18:06:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794330395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7T+J4+WlOB2IxlaIc1AotJlP4U892h0v4xRYK4YTHUA=;
 b=1fL8JEY8lU6uafjO//C9fBJLZrIAe1QEaMaSBfDRlkj/tHSE26uktC6jSaLTjl8f9t+bYJ
 PRrxSmqywM5NtXwlryqwvxF02r+G5v9j0129nMzbkbTzEYLN3cdRr+4rI+Yal7bPlIGmxd
 /NNMoJNa+Emxcwxj2e/KQ7QYrSBB1Vs+U0fR2fjthwT/0Co3Uk0LqPbmdPjzls16VrAKrM
 GdGvZ6XEEWhzO5hlKtSZ3Il3+EvNoCiJrfIU0lpZyPrejGTnniVmDTxm4ZWCjjnYfrGsvM
 jcsTWcu3YlETQ5JX63v+xZcYqx56Rs5momMx75DEr2JL1d3bKhDEqMmNz56SnQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 18:06:19 +0100
Message-ID: <a98eab82229da1233a8debbe146feddc57e87c10.1794329430.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794329430.git.ralf@mandelbit.com>
References: <cover.1794329430.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jPCjl2QC1zQm
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQpIx-000000003wS-1rGl
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 3/6] udp_tunnel: support
 detachable GRO receive callbacks
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

UDP tunnel GRO callbacks normally remain installed until their socket is
destroyed. This permits the tunnel callback registry to use one callback
as a global static-call target when only one tunnel type is active.

A userspace-owned socket can instead outlive its association with an
encapsulator. Allow a receive callback which produces only standard UDP
frag-list GSO to opt out of the callback registry and be detached while
the socket remains live. Such aggregates need no tunnel completion
callback and remain valid after detach. The socket must not already have a
GRO callback, which would stay pinned in the registry.

Publish the detachable dispatch mode before the callback, then publish
frag-list acceptance only after all callbacks which consume that
representation. Load each callback once before invocation.

Provide a helper which removes the socket from GRO lookup, clears its
callbacks and frag-list acceptance, and waits for in-flight network
readers before retiring detachable dispatch mode. Keep the helper in
udp_offload.c, which is built into the UDP stack even when
NET_UDP_TUNNEL is a module, so built-in callers do not gain a dependency
on udp_tunnel.ko.

Existing tunnel sockets retain the static-call path and semantics.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1 https://lore.kernel.org/openvpn-devel/a648e3aea95cdd32b6411a2a920ada54905ba293.1794314969.git.ralf@mandelbit.com/
- Warn if a detachable socket already has a GRO callback, which would
  stay pinned in the registry. (Sashiko)

 include/linux/udp.h        |  1 +
 include/net/udp_tunnel.h   |  2 ++
 net/ipv4/udp_offload.c     | 59 +++++++++++++++++++++++++++++++++-----
 net/ipv4/udp_tunnel_core.c | 29 ++++++++++++++++---
 4 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index cb3fd34d56f6..3ae7ef796abb 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -71,6 +71,7 @@ enum {
 	 * an aggregate, it must leave it unmodified.
 	 */
 	UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST,
+	UDP_FLAGS_GRO_RCV_DETACHABLE, /* gro_receive may be detached */
 };
 
 /* per NUMA structure for lockless producer usage. */
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index a540e86d5f84..3a137901c88b 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -211,10 +211,12 @@ static inline int udp_tunnel_handle_offloads(struct sk_buff *skb, bool udp_csum)
 #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
 void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add);
 void udp_tunnel_update_gro_rcv(struct sock *sk, bool add);
+void udp_tunnel_detach_gro(struct sock *sk);
 #else
 static inline void udp_tunnel_update_gro_lookup(struct net *net,
 						struct sock *sk, bool add) {}
 static inline void udp_tunnel_update_gro_rcv(struct sock *sk, bool add) {}
+static inline void udp_tunnel_detach_gro(struct sock *sk) {}
 #endif
 
 static inline void udp_tunnel_cleanup_gro(struct sock *sk)
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 572a65cd8977..61b4e226d091 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -82,6 +82,10 @@ void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
 	struct udp_sock *up = udp_sk(sk);
 	int i, old_gro_type_nr;
 
+	/* Dynamically detached callbacks cannot be static-call targets. */
+	if (udp_test_bit(GRO_RCV_DETACHABLE, sk))
+		return;
+
 	if (!UDP_MAX_TUNNEL_TYPES || !up->gro_receive)
 		return;
 
@@ -144,10 +148,45 @@ void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_rcv);
 
+/**
+ * udp_tunnel_detach_gro - detach GRO callbacks from a live UDP socket
+ * @sk: UDP tunnel socket
+ *
+ * The caller must hold the socket lock and keep callback state alive until
+ * this function returns.
+ */
+void udp_tunnel_detach_gro(struct sock *sk)
+{
+	sock_owned_by_me(sk);
+
+	if (WARN_ON_ONCE(!udp_test_bit(GRO_RCV_DETACHABLE, sk)))
+		return;
+
+	udp_tunnel_update_gro_lookup(sock_net(sk), sk, false);
+	WRITE_ONCE(udp_sk(sk)->gro_receive, NULL);
+	WRITE_ONCE(udp_sk(sk)->gro_complete, NULL);
+	/* No new frag-list aggregates can be formed after gro_receive is
+	 * cleared. Any aggregate already held by GRO may safely be segmented
+	 * before encap_rcv.
+	 */
+	udp_clear_bit(ENCAP_ACCEPT_FRAGLIST, sk);
+
+	/* Readers which captured a callback before it was cleared must keep
+	 * bypassing the static-call path until they have completed.
+	 */
+	synchronize_net();
+	udp_clear_bit(GRO_RCV_DETACHABLE, sk);
+}
+EXPORT_SYMBOL_GPL(udp_tunnel_detach_gro);
+
 static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
+					  udp_tunnel_gro_receive_t gro_receive,
 					  struct list_head *head,
 					  struct sk_buff *skb)
 {
+	if (unlikely(udp_test_bit(GRO_RCV_DETACHABLE, sk)))
+		return call_gro_receive_sk(gro_receive, sk, head, skb);
+
 	if (static_branch_likely(&udp_tunnel_static_call)) {
 		if (unlikely(gro_recursion_inc_test(skb))) {
 			NAPI_GRO_CB(skb)->flush |= 1;
@@ -155,16 +194,17 @@ static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
 		}
 		return static_call(udp_tunnel_gro_rcv)(sk, head, skb);
 	}
-	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
+	return call_gro_receive_sk(gro_receive, sk, head, skb);
 }
 
 #else
 
 static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
+					  udp_tunnel_gro_receive_t gro_receive,
 					  struct list_head *head,
 					  struct sk_buff *skb)
 {
-	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
+	return call_gro_receive_sk(gro_receive, sk, head, skb);
 }
 
 #endif
@@ -776,6 +816,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 				struct udphdr *uh, struct sock *sk)
 {
+	udp_tunnel_gro_receive_t gro_receive = NULL;
 	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
 	struct udphdr *uh2;
@@ -794,7 +835,9 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	 * cases. Such packets should be caught in udp_unexpected_gso later.
 	 */
 	NAPI_GRO_CB(skb)->is_flist = 0;
-	if (!sk || !udp_sk(sk)->gro_receive) {
+	if (sk)
+		gro_receive = READ_ONCE(udp_sk(sk)->gro_receive);
+	if (!gro_receive) {
 		/* If the packet was locally encapsulated in a UDP tunnel that
 		 * wasn't detected above, do not GRO.
 		 */
@@ -841,7 +884,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	skb_gro_pull(skb, sizeof(struct udphdr)); /* pull encapsulating udp header */
 	skb_gro_postpull_rcsum(skb, uh, sizeof(struct udphdr));
-	pp = udp_tunnel_gro_rcv(sk, head, skb);
+	pp = udp_tunnel_gro_rcv(sk, gro_receive, head, skb);
 
 out:
 	skb_gro_flush_final(skb, pp, flush);
@@ -920,6 +963,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 {
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 	unsigned int newlen = skb->len - nhoff;
+	udp_tunnel_gro_complete_t gro_complete = NULL;
 	struct sock *sk;
 	int err;
 
@@ -927,7 +971,9 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
-	if (sk && udp_sk(sk)->gro_complete) {
+	if (sk)
+		gro_complete = READ_ONCE(udp_sk(sk)->gro_complete);
+	if (gro_complete) {
 		skb_shinfo(skb)->gso_type = uh->check ? SKB_GSO_UDP_TUNNEL_CSUM
 					: SKB_GSO_UDP_TUNNEL;
 
@@ -940,8 +986,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 		 * functions to make them set up the inner offsets.
 		 */
 		skb->encapsulation = 1;
-		err = udp_sk(sk)->gro_complete(sk, skb,
-				nhoff + sizeof(struct udphdr));
+		err = gro_complete(sk, skb, nhoff + sizeof(struct udphdr));
 	} else {
 		err = udp_gro_complete_segment(skb);
 	}
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index c023344891a2..426c5e4ac583 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -71,12 +71,28 @@ static bool sk_saddr_any(struct sock *sk)
 void setup_udp_tunnel_sock(struct net *net, struct sock *sk,
 			   struct udp_tunnel_sock_cfg *cfg)
 {
-	const unsigned long allowed = BIT(UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST);
+	const unsigned long allowed = BIT(UDP_FLAGS_GRO_RCV_DETACHABLE) |
+				      BIT(UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST);
 	unsigned long flags = cfg->udp_flags & allowed;
 
 	WARN_ON_ONCE(cfg->udp_flags & ~allowed);
 	/* a socket must stop accepting frag-lists before it is set up again */
 	WARN_ON_ONCE(udp_test_bit(ENCAP_ACCEPT_FRAGLIST, sk));
+	set_mask_bits(&udp_sk(sk)->udp_flags, BIT(UDP_FLAGS_GRO_RCV_DETACHABLE),
+		      flags & BIT(UDP_FLAGS_GRO_RCV_DETACHABLE));
+	if (flags & BIT(UDP_FLAGS_GRO_RCV_DETACHABLE)) {
+		WARN_ON_ONCE(cfg->gro_complete ||
+			     !(flags & BIT(UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST)));
+		/* the registry ignores detachable sockets, so a callback which
+		 * is already registered there would stay pinned
+		 */
+		WARN_ON_ONCE(udp_sk(sk)->gro_receive);
+		/* The socket may already be receiving packets so drain readers
+		 * which could have observed the old dispatch mode before
+		 * publishing the detachable callback.
+		 */
+		synchronize_net();
+	}
 
 	/* Disable multicast loopback */
 	inet_clear_bit(MC_LOOP, sk);
@@ -91,13 +107,18 @@ void setup_udp_tunnel_sock(struct net *net, struct sock *sk,
 	udp_sk(sk)->encap_err_rcv = cfg->encap_err_rcv;
 	udp_sk(sk)->encap_err_lookup = cfg->encap_err_lookup;
 	udp_sk(sk)->encap_destroy = cfg->encap_destroy;
-	udp_sk(sk)->gro_receive = cfg->gro_receive;
-	udp_sk(sk)->gro_complete = cfg->gro_complete;
+	WRITE_ONCE(udp_sk(sk)->gro_complete, cfg->gro_complete);
+	/* Publish receive after the completion callback which its aggregates
+	 * may later require
+	 */
+	WRITE_ONCE(udp_sk(sk)->gro_receive, cfg->gro_receive);
 
 	/* Publish frag-list acceptance only after the callbacks which consume
 	 * that representation
 	 */
-	set_mask_bits(&udp_sk(sk)->udp_flags, allowed, flags);
+	set_mask_bits(&udp_sk(sk)->udp_flags,
+		      BIT(UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST),
+		      flags & BIT(UDP_FLAGS_ENCAP_ACCEPT_FRAGLIST));
 
 	udp_tunnel_encap_enable(sk);
 
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
