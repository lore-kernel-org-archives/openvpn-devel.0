Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B11CD4F3E
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=McmmUC1jxWXX4NZH67by3/8SF1KlmHBhpifOwJRmqPs=; b=A2BfQHiTUxBsIncwd0pIzfz3TQ
	EanGsiTfzPII/DnQQqqXY93Au7RxlrorNt52oHO4ptmRxj2I8Okag1EtRJrSwndv/B5n1QqFopi/t
	le5iOMNdc6sO/WRcvD5ZQP3OoSLLn2E3ZKlcnrfDiXRd04tSgMbIwxfASHk8LV1g6dbU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNSjx-0005sC-5W;
	Thu, 14 May 2026 09:52:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wNSjv-0005s4-TV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:52:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=08qlaEW/4Z8aTVH+fgFqZNPX9Ghxm7aE5V/AVfa3Ru4=; b=L/YVFbT/7SxdQP/LkJn9se87nM
 co2Z3aD6KPIox/WTaUzIxt9/x9SPtYv/rOQ0SHcw6BcdU20jI6hZSYcccbdrOJ3za+MCi7ha3Doq6
 8DgmEFdFEgN3Gk8e5OPhoUMYfjk4XFCC+H8XO3mijQB/NZRQ93j5ShJEKN/kMwlLMxVA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=08qlaEW/4Z8aTVH+fgFqZNPX9Ghxm7aE5V/AVfa3Ru4=; b=nB3hZ+RduBA/vDKD2i4Gisv//5
 3kaCnRIaDqw7UnYAz+PuDZrbPDybj7FNxrqe761f3WfMIKH5+nmt1Zn2nfpC6IDsAfynovnB1lnwo
 knIkbgpDwlsqQErAVVSatyC8EQqW3xEm4+95iBRIt6rV3qOJ7B3q31qUxheGRLK0H4JA=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNSju-0004Te-F2 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:52:24 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4gGQbh42KVz9xXG;
 Thu, 14 May 2026 11:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1778752336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08qlaEW/4Z8aTVH+fgFqZNPX9Ghxm7aE5V/AVfa3Ru4=;
 b=15rHgEUJVHJG7lr9Ixb9GAACqyDbrbChvpV6/kK/SIFQRoWmSCpKjGd0VA9xXtryDrUxBN
 rmLPLCsj08H4UBW3aC09SkJHMSNFTmaXzeuCc7vEVFmeIGk2y5TCnlg0nlHUI2o0ekYu9W
 l7IN7rDS16A47xBXj3eZH7b7Card3Bh5cTbjvG+fTrevyy/DGJygO2nbtVcc9UDlToqBNU
 /oBIYl096MIx+mJfyH0ANooCgefk3JDHiPkzcXF/0bq6ktaDPJd+NNDlEhf5zuiDUWsrek
 wEPeCVSuMTgEgRpCuDRws87j9oVw5CbW6M8XXRMWnMhEMbbQGUN+FP9ZHl8BHg==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 14 May 2026 11:52:09 +0200
Message-ID: <20260514095210.288979-4-marco@mandelbit.com>
In-Reply-To: <20260514095210.288979-1-marco@mandelbit.com>
References: <20260514095210.288979-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wNSju-0004Te-F2
Subject: [Openvpn-devel] [RFC ovpn net-next 4/5] ovpn: add IGMPv3 and MLDv2
 ASM snooping
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

Extend multicast snooping to handle IGMPv3 and MLDv2 membership
reports received from tunnel peers. These protocols carry multiple
group records per report, each with an INCLUDE/EXCLUDE filter mode
and an optional source list.

For ASM (Any Source Multicast), the snooping logic treats EXCLUDE
mode with an empty source list as a join and INCLUDE mode with an
empty source list as a leave, matching the behavior of IGMPv2 and
MLDv1. SSM is not supported yet.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/mcast.c | 127 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/mcast.c b/drivers/net/ovpn/mcast.c
index 59b0b62afcde..1e436a6721bb 100644
--- a/drivers/net/ovpn/mcast.c
+++ b/drivers/net/ovpn/mcast.c
@@ -268,13 +268,68 @@ static bool ovpn_mcast_mld_offset(struct sk_buff *skb, unsigned int *offsetp)
 	return true;
 }
 
+/**
+ * ovpn_mcast_snoop_mldv2 - inspect an MLDv2 report message
+ * @peer: the peer this packet was received from
+ * @skb: the packet to inspect
+ * @offset: bytes from the start of the network header to the start of the MLD group records
+ * @ngrec: number of group records
+ *
+ * Parse the MLDv2 report and update the multicast subscription table.
+ *
+ * Return: true if the packet was a recognized MLDv2 join/leave and was
+ *         consumed, false otherwise
+ */
+static bool ovpn_mcast_snoop_mldv2(struct ovpn_peer *peer, struct sk_buff *skb,
+				   unsigned int offset, const int ngrec)
+{
+	struct mld2_grec *grec;
+	int i;
+	__u16 nsrcs;
+	unsigned int rec_len;
+
+	for (i = 0; i < ngrec; i++) {
+		if (!pskb_may_pull(skb, offset + sizeof(*grec)))
+			return true;
+
+		grec = (struct mld2_grec *)(skb_network_header(skb) + offset);
+		nsrcs = ntohs(grec->grec_nsrcs);
+
+		rec_len = sizeof(*grec) + nsrcs * sizeof(struct in6_addr) +
+			  grec->grec_auxwords * 4;
+		offset += rec_len;
+
+		if (!pskb_may_pull(skb, offset))
+			return true;
+
+		/* recompute grec after potential head reallocation */
+		grec = (struct mld2_grec *)(skb_network_header(skb) + offset - rec_len);
+
+		/* In MLDv2 ASM, EXCLUDE mode with an empty source list means
+		 * "exclude nothing, receive everything" -> JOIN.
+		 * INCLUDE mode with an empty source list means
+		 * "include nothing, receive nothing" -> LEAVE.
+		 * See RFC 3810, section 4.
+		 */
+		if (nsrcs == 0 &&
+		    (grec->grec_type == MLD2_CHANGE_TO_INCLUDE ||
+		     grec->grec_type == MLD2_MODE_IS_INCLUDE)) {
+			ovpn_mcast_leave(peer->ovpn, peer, &grec->grec_mca);
+		} else {
+			ovpn_mcast_join(peer->ovpn, peer, &grec->grec_mca);
+		}
+	}
+
+	return true;
+}
+
 /**
  * ovpn_mcast_snoop_mld - inspect an IPv6 packet for MLD join/leave messages
  * @peer: the peer this packet was received from
  * @skb: the packet to inspect
  *
  * Parse the MLD header and update the multicast subscription table on
- * MLDv1 reports and done messages.
+ * MLDv1/v2 reports and done messages.
  *
  * Return: true if the packet was a recognized MLD join/leave and was
  *         consumed, false otherwise
@@ -293,6 +348,11 @@ static bool ovpn_mcast_snoop_mld(struct ovpn_peer *peer, struct sk_buff *skb)
 	mld = (struct mld_msg *)(skb_network_header(skb) + offset);
 
 	switch (mld->mld_type) {
+	case ICMPV6_MLD2_REPORT:
+		return ovpn_mcast_snoop_mldv2(peer, skb,
+			offset + sizeof(struct mld2_report),
+			ntohs(((struct mld2_report *)mld)->mld2r_ngrec)
+		);
 	case ICMPV6_MGM_REPORT:
 		ovpn_mcast_join(peer->ovpn, peer, &mld->mld_mca);
 		return true;
@@ -305,13 +365,71 @@ static bool ovpn_mcast_snoop_mld(struct ovpn_peer *peer, struct sk_buff *skb)
 	return false;
 }
 
+/**
+ * ovpn_mcast_snoop_igmpv3 - inspect an IGMPv3 report message
+ * @peer: the peer this packet was received from
+ * @skb: the packet to inspect
+ * @offset: bytes from the start of the network header to the start of the IGMP group records
+ * @ngrec: number of group records
+ *
+ * Parse the IGMPv3 report and update the multicast subscription table.
+ *
+ * Return: true if the packet was a recognized IGMPv3 join/leave and was
+ *         consumed, false otherwise
+ */
+static bool ovpn_mcast_snoop_igmpv3(struct ovpn_peer *peer, struct sk_buff *skb,
+				    unsigned int offset, const int ngrec)
+{
+	struct igmpv3_grec *grec;
+	struct in6_addr addr6;
+	int i;
+	unsigned int rec_len;
+	__u16 nsrcs;
+
+	for (i = 0; i < ngrec; i++) {
+		if (!pskb_may_pull(skb, offset + sizeof(*grec)))
+			return true;
+
+		grec = (struct igmpv3_grec *)(skb_network_header(skb) + offset);
+		nsrcs = ntohs(grec->grec_nsrcs);
+
+		rec_len = sizeof(*grec) + nsrcs * sizeof(__be32) +
+			  grec->grec_auxwords * 4;
+		offset += rec_len;
+
+		if (!pskb_may_pull(skb, offset))
+			return true;
+
+		/* recompute grec after potential head reallocation */
+		grec = (struct igmpv3_grec *)(skb_network_header(skb) + offset - rec_len);
+
+		/* In IGMPv3 ASM, EXCLUDE mode with an empty source list means
+		 * "exclude nothing, receive everything" -> JOIN.
+		 * INCLUDE mode with an empty source list means
+		 * "include nothing, receive nothing" -> LEAVE.
+		 * See RFC 3376, section 3.
+		 */
+		if (nsrcs == 0 &&
+		    (grec->grec_type == IGMPV3_CHANGE_TO_INCLUDE ||
+		     grec->grec_type == IGMPV3_MODE_IS_INCLUDE)) {
+			ipv6_addr_set_v4mapped(grec->grec_mca, &addr6);
+			ovpn_mcast_leave(peer->ovpn, peer, &addr6);
+		} else {
+			ipv6_addr_set_v4mapped(grec->grec_mca, &addr6);
+			ovpn_mcast_join(peer->ovpn, peer, &addr6);
+		}
+	}
+
+	return true;
+}
+
 /**
  * ovpn_mcast_snoop_igmp - inspect an IPv4 packet for IGMP join/leave messages
  * @peer: the peer this packet was received from
  * @skb: the packet to inspect
  *
  * Parse the IGMP header and update the multicast subscription table on
- * IGMPv2 membership reports and leave messages.
+ * IGMPv2/v3 membership reports and leave messages.
  *
  * Return: true if the packet was a recognized IGMP join/leave and was
  *         consumed, false otherwise
@@ -329,6 +447,11 @@ static bool ovpn_mcast_snoop_igmp(struct ovpn_peer *peer, struct sk_buff *skb)
 	ih = (struct igmphdr *)(skb_network_header(skb) + ihl);
 
 	switch (ih->type) {
+	case IGMPV3_HOST_MEMBERSHIP_REPORT:
+		return ovpn_mcast_snoop_igmpv3(peer, skb,
+			ihl + sizeof(struct igmpv3_report),
+			ntohs(((struct igmpv3_report *)ih)->ngrec)
+		);
 	case IGMPV2_HOST_MEMBERSHIP_REPORT:
 		ipv6_addr_set_v4mapped(ih->group, &addr6);
 		ovpn_mcast_join(peer->ovpn, peer, &addr6);
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
