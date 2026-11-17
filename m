Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F41E607053A
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dXfAYbvz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TcgRnj2A;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VvaCicxy;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=eXdQRJ71
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+JiYLcDdg08cZ6PPFcfNU/BmiK5efHPnX1ubO7cYu60=; b=dXfAYbvz7/Bnp1
	AGJiLiyjOgGzvLgAPsqY8l7mIEuDedNkjLZyb7ZRKcvh7SwNnP+5w+B6AtnpwuADfqLy7oEEML6Ty
	HyB/6R7yQ0gQTW2SALn8jrGXXzGtv68BHqC8nQN6gnnl62JqdDTlJXJYrH/ikD0Q5T5wnrAPpHdLF
	Ixo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTJu6-000000001sx-3ME1;
	Tue, 17 Nov 2026 14:11:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xTJu5-000000001sZ-0UxJ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:11:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=el38liqVEHYqmnWDeZ1yuP1/i4B9z0xN3MNdso0KXR0=; b=TcgRnj2AIzi/1HsyneSUlkl+oa
 Ah3l1hJd7pS9WBxkavmRNZcYLEKVOkXeGHCYDg1DabFtjM4edMavc38Fy3EBOa4s0Ji/EzHFYPEuK
 IpLT63QIBNFcwXw7atKpaRDTZhADM9ydfegUgQNeaoeiepeyKcPDsq+CgEc+1cmtTXcA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=el38liqVEHYqmnWDeZ1yuP1/i4B9z0xN3MNdso0KXR0=; b=VvaCicxydc16DnD7BRDwjkYrr3
 PXc9zaQDDtZ8bLdMmdKryet6kMAX0vYd6H0+ozPM8Xx2CSibzJtVjmwk7An0k3Lpfyv0IqzSDFjNh
 jMzTALH6EqDKiKBb0y5pzJG6E2bfYXXmldovo1bfmdmC33DegndhvMrfy/cfusjQNujU=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTJu2-000000007sy-1ddx for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:11:21 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jTRV63ZrxzKmcv
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 15:11:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794924670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=el38liqVEHYqmnWDeZ1yuP1/i4B9z0xN3MNdso0KXR0=;
 b=eXdQRJ71wBvrcgW4YFdJYiXxcHFmJsfZkt304/DPgqcoL48/+o+qb7NIIbwnimqtWsIRlr
 5DVbwDvqSyF1q2vLTXFmqr6ZI+ERsbHndz+Ew7QxYH+LKUIT4Ogwb5ZzQ1pBXihFQOx1dX
 LCzj/FgDvV1HCZpsfQKTZGWxB3V4UHNDRtgSElHCxgTS//J60Lm2eRzI2WtXCqR6gnWQZg
 kqvcw0qqBTj0puvgbbTLaPALnCv+l2uymL1EHlAfRd4krowkJB7nLE342I6yfqyFECIHok
 nDUnETwvLO0Qdk3sD754n3kLSBAPA6g7HVfMls0Ge8kjGerxpYItSHjpR3y0NQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 15:11:00 +0100
Message-ID: <45fd7978aa65dca13632657bcaba9fab6002f6c3.1794922487.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794922487.git.ralf@mandelbit.com>
References: <cover.1794922487.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jTRV63ZrxzKmcv
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTJu2-000000007sy-1ddx
Subject: [Openvpn-devel] [PATCH ovpn net-next 3/4] net: restore
 __get_hash_from_flowi4
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

__get_hash_from_flowi4 was removed for lack of users in commit
de7a0f871fab ("net: Remove unused get_hash_from_flow functions"), while
its IPv6 counterpart survived for automatic flow labels. A tunnel which
routes its outer packets with a flowi can use these helpers to set the
outer flow hash without dissecting the packet, as ovpn will.

Restore the helper and add skb_get_hash_flowi4 next to
skb_get_hash_flowi6. Like the IPv6 variant, it leaves basic.n_proto
unset, so the hash is stable for a flow but not identical to the one
the flow dissector computes from the packet itself.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 include/linux/skbuff.h    | 13 +++++++++++++
 include/net/flow.h        |  1 +
 net/core/flow_dissector.c | 16 ++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index aaa33d44b01c..1c8bcacd4d0d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1679,6 +1679,19 @@ static inline __u32 skb_get_hash(struct sk_buff *skb)
 	return skb->hash;
 }
 
+static inline __u32 skb_get_hash_flowi4(struct sk_buff *skb,
+					const struct flowi4 *fl4)
+{
+	if (!skb->l4_hash && !skb->sw_hash) {
+		struct flow_keys keys;
+		__u32 hash = __get_hash_from_flowi4(fl4, &keys);
+
+		__skb_set_sw_hash(skb, hash, flow_keys_have_l4(&keys));
+	}
+
+	return skb->hash;
+}
+
 static inline __u32 skb_get_hash_flowi6(struct sk_buff *skb, const struct flowi6 *fl6)
 {
 	if (!skb->l4_hash && !skb->sw_hash) {
diff --git a/include/net/flow.h b/include/net/flow.h
index ae9481c40063..7a6ccd0d56bd 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -194,5 +194,6 @@ static inline struct flowi_common *flowi6_to_flowi_common(struct flowi6 *fl6)
 }
 
 __u32 __get_hash_from_flowi6(const struct flowi6 *fl6, struct flow_keys *keys);
+__u32 __get_hash_from_flowi4(const struct flowi4 *fl4, struct flow_keys *keys);
 
 #endif
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1be6c739e3c7..8533a9ce232e 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -2020,6 +2020,22 @@ __u32 __get_hash_from_flowi6(const struct flowi6 *fl6, struct flow_keys *keys)
 }
 EXPORT_SYMBOL(__get_hash_from_flowi6);
 
+__u32 __get_hash_from_flowi4(const struct flowi4 *fl4, struct flow_keys *keys)
+{
+	memset(keys, 0, sizeof(*keys));
+
+	keys->addrs.v4addrs.src = fl4->saddr;
+	keys->addrs.v4addrs.dst = fl4->daddr;
+	keys->control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
+	keys->ports.src = fl4->fl4_sport;
+	keys->ports.dst = fl4->fl4_dport;
+	keys->keyid.keyid = fl4->fl4_gre_key;
+	keys->basic.ip_proto = fl4->flowi4_proto;
+
+	return flow_hash_from_keys(keys);
+}
+EXPORT_SYMBOL(__get_hash_from_flowi4);
+
 static const struct flow_dissector_key flow_keys_dissector_keys[] = {
 	{
 		.key_id = FLOW_DISSECTOR_KEY_CONTROL,
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
