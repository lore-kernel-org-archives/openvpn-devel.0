Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0024606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=J0pPxf+8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fOE7Eloc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Tyk0+OSj;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=apah7SOp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=T84ag+P/8W4r5grJ5wTnSvum06muxddhzwgZxfnzlfo=; b=J0pPxf+8sTFcGB
	hieweEyyZyZpF/+NcpnfjrIoxBxrlInwqHtWua+PyGWlE34ccOTYJzQDvwcgP4DHCPwS1EyUmA5II
	cp0KyYeFSLug2juXx8YW0Nzdopr4CyChRvwlKtw1IFN71Lk7CtpJnNLWSKqfptFw6/jkCv3Lb3VEp
	5ME=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xW2Bt-000000005xu-27qn;
	Wed, 25 Nov 2026 01:52:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xW2Bq-000000005xh-2PTW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 01:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0OZjNgAIcn1c2M0BaXQIitdvN6JuKDfTlLE6kDshDLM=; b=fOE7Eloc4rNvrnjyEYJPtyxuW3
 N4ncpwzfibiwx8dlT5Oj/fWU3nrH+SbzNwqVpY/SiFQY4Wc2RayMxoLla0XRCJ3bM/I065GKkQULu
 EZWKbHRvWIivIbf21qdudDIlU9yLeXdRm5q3WH6ougSScyv78VfpU9qbbNBpJg0VQxsI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0OZjNgAIcn1c2M0BaXQIitdvN6JuKDfTlLE6kDshDLM=; b=Tyk0+OSjPEn8ujsKaonLv04sMN
 l8fJtJXNF8sGKrJF4UZ/1SloUu2wlUPDgHXiZYMICdQ8IguRSRgRs5fanJ6AV5sm8jjPPdeAo/k5d
 CA546e8CS7Rv+ekMTrL496VX6amLdB+pLi+Sea7cI7pEnn9i2OBU0i95QT76aG5R/hGc=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xW2Bo-000000003B8-2uso for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 01:52:54 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jZ2kN46mQzKmy7;
 Wed, 25 Nov 2026 02:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1795571564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OZjNgAIcn1c2M0BaXQIitdvN6JuKDfTlLE6kDshDLM=;
 b=apah7SOpk1jYbtxQeP5EpM2ytar2hx7kNwqqUbSLrAlRjzlk4TPFdfUhq6IAdlylBrkphR
 Sx7Wr5VAwIna/agWY9XHRyc3JuLrzpbPFfZZxfzOzd1AoBzcPXdMdyBHfDIntfa0lgeTvs
 Vp15HeuNOe2jqP7HAfd/ATHJ4x7jgb7luAwXYi8qAYMQP6Lz1KAlwOQIiedNU5fTX7dFvL
 BZqfezZGI6ohNxibBDCbfWtjvjslGk1N/eOGvREdo+y5UkAC4EkKB7lWeb5ayBEJk3E+YM
 yM+abEybfwQ2trF1Emb3CpR6CywMoSSAcFl01DtKH1gxyGWLa2AeMGgr8RZ3wg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 25 Nov 2026 02:52:43 +0100
Message-ID: <20261125015243.238861-1-a@unstable.cc>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <874ca8e9efb787fd37a942817239c8ba1a4fa4b3.1794388607.git.ralf@mandelbit.com>
References: <cover.1794388607.git.ralf@mandelbit.com>
 <874ca8e9efb787fd37a942817239c8ba1a4fa4b3.1794388607.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jZ2kN46mQzKmy7
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xW2Bo-000000003B8-2uso
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next v3 6/6] ovpn: prefetch
 encrypted records before GRO batch decryption
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
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ralf,

On 11/11/2026 10:22, Ralf Lici wrote:
> Frag-list GRO exposes later encrypted records before the receive path
> decrypts the current one. Use this lookahead to request write ownership
> of linear ciphertext cache lines two records in advance, and maintain
> the same distance throughout the batch, overlapping their memory access
> latency with the current AEAD operation.

I tried issuing the prefetch earlier: in ovpn_udp_gro_receive_fraglist(),
when each record joins the aggregate, instead of in ovpn_udp_recv() right
before decryption.

The lines are then requested one record at a time,
as the packets arrive, and they are already cached when the batch is
decrypted, including the first records of the batch, which the window
can only prime right before they are decrypted.

On our perf branch (your v3 plus some RX changes of ours), single stream
over UDP transport, ConnectX-5 back to back, mlx5 with RX look-ahead
prefetch, NIC MTU 1500, 3 rounds, Gbit/s:

                         window   join
  TCP      aes            40.71  43.56   +7.0%
           aegis128x4     44.01  45.19   +2.7%
  UDP GSO  aes            44.86  48.29   +7.6%
           aegis128x4     47.20  52.34  +10.9%

"window" is your patch 6, "join" is the change below, everything else
is identical.

The receiving CPU spends 3-14% fewer cycles per packet,
about twice as many demand fills are served from L2, and in the UDP GSO
test the receiver drops half as many packets. On the previous GRO
design, with the stock mlx5 driver, I had measured +0.8% to +10.2%.

The change against your v3:

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 2f77acc47bd9..66d80a4268db 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -35,9 +35,6 @@
 /* like UDP and TCP frag-list GRO */
 #define OVPN_UDP_GRO_CNT_MAX 64
 
-/* leave enough work between a cache hint and the record which consumes it */
-#define OVPN_UDP_GRO_PREFETCH_DISTANCE 2
-
 static void ovpn_udp_prefetchw_linear(const struct sk_buff *skb)
 {
 	unsigned long addr = (unsigned long)skb->data;
@@ -94,6 +91,11 @@ static struct sk_buff *ovpn_udp_gro_receive_fraglist(struct sock *sk,
 	NAPI_GRO_CB(skb)->encap_mark = 0;
 	NAPI_GRO_CB(skb)->is_flist = 1;
 
+	/* the record is decrypted only after its aggregate is delivered: start
+	 * fetching its linear data now, one record at a time
+	 */
+	ovpn_udp_prefetchw_linear(skb);
+
 	list_for_each_entry(p, head, list) {
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
@@ -249,7 +251,7 @@ static struct sk_buff *ovpn_udp_gso_prepare(struct sk_buff *skb, u32 header)
 
 static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *list)
 {
-	struct sk_buff *skb, *next, *prefetch;
+	struct sk_buff *skb, *next;
 	const __be16 proto = list->protocol;
 	const u32 priority = list->priority;
 #ifdef CONFIG_NET_SCHED
@@ -259,23 +261,8 @@ static void ovpn_udp_recv(struct ovpn_peer *peer, struct sk_buff *list)
 	const u32 secmark = list->secmark;
 #endif
 	const int skb_iif = list->skb_iif;
-	int i;
-
-	/* a fraglist GRO aggregate makes later ciphertext visible before the
-	 * current record is decrypted, so we prime the first two records, then
-	 * keep the cache hints the same distance ahead while draining the list
-	 */
-	prefetch = list->next ? list : NULL;
-	for (i = 0; i < OVPN_UDP_GRO_PREFETCH_DISTANCE && prefetch; i++) {
-		ovpn_udp_prefetchw_linear(prefetch);
-		prefetch = prefetch->next;
-	}
 
 	skb_list_walk_safe(list, skb, next) {
-		if (prefetch) {
-			ovpn_udp_prefetchw_linear(prefetch);
-			prefetch = prefetch->next;
-		}
 		/* propagate post-GRO metadata from the list head, and clear
 		 * the state which the receive stack consumed on the head only
 		 */

Records that GRO refuses (not DATA_V2, already GSO, inside FOU/GUE) take
the flush path before the prefetch, so they are not touched; records
that start a new aggregate, or are delivered alone, are prefetched too.

Let me know what you think and if you want to fold this change into
patch 6.

Cheers,

--
Antonio Quartulli


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
