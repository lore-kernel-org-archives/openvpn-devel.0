Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A36C44512
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 04:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8W7S3ulzsM/AE7BhOCyyPgmrRqPPnFtvpkiHTjAdq1A=; b=KBfMbQJzpt37O3hqpq1M95EArs
	NzB0AtziYGP/GyFahjjwWP65ExHq9l01oc7hc4mfSQggGMupZNSbw7t02O2T/SGoVdMXyDbXCv48b
	KvW9FcKb6Bls6OoMxBsX2ST03KKlzeBSvq5Ah7NBUcxIlMNAKRqhQNoJ6f7MxbHnOseA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmOsv-0001FR-UR;
	Wed, 22 Jul 2026 04:48:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wmOsf-0001F8-Bh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 04:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ie30qSNCGFbASrL8SUlz2Epnc7sLQHyDocYbl2TxDlY=; b=jVULH7io26zSQ11ZyrrNYd8gMf
 We6HYm45hgdjfYNjPnoEbadO8y40aZ5v/HmqTAa0fx0s2HCuXPeBOc2djQ+c/ATTDr6TzaShW3Xaq
 8VGrG66dxPU7P2AopsLuCGioSGK42Cjecbkcr3h0w4iWaFP1UMXwDOsoDAOrvvpkUHBg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ie30qSNCGFbASrL8SUlz2Epnc7sLQHyDocYbl2TxDlY=; b=E
 ZTXytijFhTFaF0EyoGROJwslWIREAm6xyEkArf9FZkRnhUvS3B2ZPXpIQwyS3Bn4aydCArV5KUzLL
 zPbn6LVXk1+AB1CBY1UaSzEITn/tE5zgKLDIotSA8ftRdoDv+PtGnkKNlJ5dh1autHw3bRyCVKNRd
 VWEd9kw3SgL0gDoI=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmOsV-0007Qu-M8 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 04:48:21 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4h4hZt4WdqzFr6v;
 Wed, 22 Jul 2026 06:48:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1784695686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ie30qSNCGFbASrL8SUlz2Epnc7sLQHyDocYbl2TxDlY=;
 b=QfBVBM653o/q7ekkB3FR2eXaMkU9vO9B/KwaMYaLDLrvqATKTn3KcXv9oTU63QGkvEcyib
 6OoHhzfjxK6in6pCwMXpsnxeJUxJ9Wg9EKEUVkoj4iMnG5gFHOiMLpS94NEsVIzGshmd6C
 OV0OU0PDSIgVLgtf8rfYZDIdr9fszgIfMy8HBmynRdWIltKIKOvMIjzAJ+3Ff7R4ccwrUz
 /yzg9/uqbKrK5STZnaB2S5uHQ6BFetxrvOUps/Rj6hHMjHkWQnwZTeiHPuB1SYcb0V/F1p
 FL/yg8lR2VLVauFmtgZ3of4f2XI0EWbAURqYqoVuH4Vox1nANqsFFoKuNsPFOw==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 22 Jul 2026 06:47:56 +0200
Message-ID: <20260722044756.872870-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wmOsV-0007Qu-M8
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: limit keepalive values to
 one day
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Large keepalive values can overflow the delayed-work delay on 32-bit
systems, causing the keepalive worker to be repeatedly scheduled.

A correct configuration should not require such large keepalive values,
and an upper limit of one day is already generous and unnecessary in
practice. Limit both the keepalive interval and timeout to 86400 seconds.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 Documentation/netlink/specs/ovpn.yaml |  4 ++++
 drivers/net/ovpn/netlink-gen.c        | 20 ++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index b0c782e59a32..ac50d1d7c00a 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -118,12 +118,16 @@ attribute-sets:
         doc: >-
           The number of seconds after which a keep alive message is sent to the
           peer
+        checks:
+          max: 86400
       -
         name: keepalive-timeout
         type: u32
         doc: >-
           The number of seconds from the last activity after which the peer is
           assumed dead
+        checks:
+          max: 86400
       -
         name: del-reason
         type: u32
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 2147cec7c2c5..92d2fdc17c2e 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -16,6 +16,14 @@ static const struct netlink_range_validation ovpn_a_peer_id_range = {
 	.max	= 16777215ULL,
 };
 
+static const struct netlink_range_validation ovpn_a_peer_keepalive_interval_range = {
+	.max	= 86400ULL,
+};
+
+static const struct netlink_range_validation ovpn_a_peer_keepalive_timeout_range = {
+	.max	= 86400ULL,
+};
+
 static const struct netlink_range_validation ovpn_a_peer_tx_id_range = {
 	.max	= 16777215ULL,
 };
@@ -68,8 +76,8 @@ const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_LOCAL_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
 	[OVPN_A_PEER_LOCAL_PORT] = NLA_POLICY_MIN(NLA_BE16, 1),
-	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
-	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_interval_range),
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_timeout_range),
 	[OVPN_A_PEER_DEL_REASON] = NLA_POLICY_MAX(NLA_U32, 4),
 	[OVPN_A_PEER_VPN_RX_BYTES] = { .type = NLA_UINT, },
 	[OVPN_A_PEER_VPN_TX_BYTES] = { .type = NLA_UINT, },
@@ -97,8 +105,8 @@ const struct nla_policy ovpn_peer_new_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_VPN_IPV6] = NLA_POLICY_EXACT_LEN(16),
 	[OVPN_A_PEER_LOCAL_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
-	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
-	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_interval_range),
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_timeout_range),
 	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
 };
 
@@ -112,8 +120,8 @@ const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 	[OVPN_A_PEER_VPN_IPV6] = NLA_POLICY_EXACT_LEN(16),
 	[OVPN_A_PEER_LOCAL_IPV4] = { .type = NLA_BE32, },
 	[OVPN_A_PEER_LOCAL_IPV6] = NLA_POLICY_EXACT_LEN(16),
-	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
-	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_interval_range),
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_keepalive_timeout_range),
 	[OVPN_A_PEER_TX_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_tx_id_range),
 };
 
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
