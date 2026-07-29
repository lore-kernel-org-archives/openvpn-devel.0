Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D9CC53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=flU2E9eHjxcY3BwRUmf+82nVyOm0GTN9MmO78CNQxYw=; b=CUbw5l+iIVtCS5vCm7zRrYM+cS
	QouLggIepFstdYCtt7Hzit4pNi4YdPKOrS6osYjCP1DFT5+oltQLc9TyNGIiyTV7ACWyRcwvMCQwk
	PQOOWk1Xzw9MTgHuCTQDghW5gK8divg01/penQ0yTmp7LxfnO+UQ4y8KqYpA8eSf8amk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp6Mk-00006q-6b;
	Wed, 29 Jul 2026 15:38:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wp6Mh-00006h-7S
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:38:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lb0YP1uJIfAnj2rVGAeXX6Qm4EZjASdPl0bfvXjvuNY=; b=mzN89rTV1yZRAs4VWZeowkGXyl
 kibyR2qUDJMur+BPiFFaE/35YSlnFxrJo5q3RhD9YaYYtWJ169hhU4l9JACIN77dGrLvTRpMWTyLF
 am+rsMQ3BwnIG4GcDidjG4SkLvNQVpFJGUlOmEDpUPzhpcG3ovCeLxk0g5nhB/QrZr58=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Lb0YP1uJIfAnj2rVGAeXX6Qm4EZjASdPl0bfvXjvuNY=; b=j
 iQlFlMmkAIt6nDSSXYbOQB4xE6U2dCR0bi/3kHFEBsVPfRRotprmI2E6zq/9751rM+cUzImjrdfyH
 uss5zInrF8jPjf+IQUgY5ul0wB91CThvSaMKn8XUrUFxMwPEBY+2N95jPRYF59VNBVQVo7cqPFYCG
 hVbWJeAVLLzctMLQ=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp6Mb-0002oE-Bq for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:38:35 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4h9Gh130fpzFr08;
 Wed, 29 Jul 2026 17:38:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785339505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lb0YP1uJIfAnj2rVGAeXX6Qm4EZjASdPl0bfvXjvuNY=;
 b=tmeihN2oK7/SCfvTOo1v06n7OWBT6pY7yUMoXHIuHQp4O4B2CSBTSih90XQgR1mcSObWvr
 cLL4Xca3+nMqK37a/wIJBaCxfgqFyTN9dskTI7piMZIod7u5R4xz8Y3FrewDarT37Cd6+V
 VYySsGCICvlySi8sT/C9zRcNAWD6wqSX+JX6SECHcFuF/BVk5qA53aM2ruC1Lf+znMzARO
 /r6NbyIAbZZa4di5yBdPvQ4fgcOgYdtux2W3I32qBnDOvOxyG+IDxhYQsIV/KN+Y43GNy7
 M1q/49QZ5spqRGO0np38fHbuAyK0j5RBUbRv9BeOCe+84ugKJnX28A6LwkN9fw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 17:38:12 +0200
Message-ID: <20260729153815.2637139-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9Gh130fpzFr08
X-Headers-End: 1wp6Mb-0002oE-Bq
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 1/4] ovpn: support
 operations on interfaces in foreign netns
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

ovpn currently looks up the target interface in the network namespace
associated with the netlink socket. This prevents a userspace process
from controlling an ovpn interface located in another namespace.

Add the optional OVPN_A_TARGET_NETNSID attribute. When present, it
identifies the namespace containing the target interface relative to the
namespace of the requesting Netlink socket. Resolve the ID and perform
the interface lookup there. When absent, preserve the existing lookup
behavior.

Allow the attribute in all peer and key request policies, including
peer dump requests.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
Changes in v3:
- None.

Changes in v2:
- Improved Doc.

 Documentation/netlink/specs/ovpn.yaml | 27 ++++++++++++++++
 drivers/net/ovpn/netlink-gen.c        | 45 ++++++++++++++++-----------
 drivers/net/ovpn/netlink.c            | 17 ++++++++++
 include/uapi/linux/ovpn.h             |  1 +
 4 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index b0c782e59a32..1f0d4d6037c0 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -337,12 +337,20 @@ attribute-sets:
         type: nest
         doc: Peer specific cipher configuration
         nested-attributes: keyconf
+      -
+        name: target-netnsid
+        type: s32
+        doc: >-
+          ID of the network namespace containing the ovpn interface, relative to
+          the network namespace of the requesting Netlink socket
   -
     name: ovpn-peer-new-input
     subset-of: ovpn
     attributes:
       -
         name: ifindex
+      -
+        name: target-netnsid
       -
         name: peer
         nested-attributes: peer-new-input
@@ -352,6 +360,8 @@ attribute-sets:
     attributes:
       -
         name: ifindex
+      -
+        name: target-netnsid
       -
         name: peer
         nested-attributes: peer-set-input
@@ -361,6 +371,8 @@ attribute-sets:
     attributes:
       -
         name: ifindex
+      -
+        name: target-netnsid
       -
         name: peer
         nested-attributes: peer-del-input
@@ -370,6 +382,8 @@ attribute-sets:
     attributes:
       -
         name: ifindex
+      -
+        name: target-netnsid
       -
         name: keyconf
         nested-attributes: keyconf-get
@@ -379,6 +393,8 @@ attribute-sets:
     attributes:
       -
         name: ifindex
+      -
+        name: target-netnsid
       -
         name: keyconf
         nested-attributes: keyconf-swap-input
@@ -388,6 +404,8 @@ attribute-sets:
     attributes:
       -
         name: ifindex
+      -
+        name: target-netnsid
       -
         name: keyconf
         nested-attributes: keyconf-del-input
@@ -405,6 +423,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - peer
     -
       name: peer-set
@@ -417,6 +436,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - peer
     -
       name: peer-get
@@ -429,6 +449,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - peer
         reply:
           attributes:
@@ -437,6 +458,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
         reply:
           attributes:
             - peer
@@ -451,6 +473,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - peer
     -
       name: peer-del-ntf
@@ -469,6 +492,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - keyconf
     -
       name: key-get
@@ -481,6 +505,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - keyconf
         reply:
           attributes:
@@ -496,6 +521,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - keyconf
     -
       name: key-swap-ntf
@@ -515,6 +541,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - keyconf
 
     -
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 2147cec7c2c5..3f513e3675a3 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -118,55 +118,64 @@ const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
 };
 
 /* OVPN_CMD_PEER_NEW - do */
-static const struct nla_policy ovpn_peer_new_nl_policy[OVPN_A_PEER + 1] = {
+static const struct nla_policy ovpn_peer_new_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
 	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_new_input_nl_policy),
 };
 
 /* OVPN_CMD_PEER_SET - do */
-static const struct nla_policy ovpn_peer_set_nl_policy[OVPN_A_PEER + 1] = {
+static const struct nla_policy ovpn_peer_set_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
 	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_set_input_nl_policy),
 };
 
 /* OVPN_CMD_PEER_GET - do */
-static const struct nla_policy ovpn_peer_get_do_nl_policy[OVPN_A_PEER + 1] = {
+static const struct nla_policy ovpn_peer_get_do_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
 	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
 };
 
 /* OVPN_CMD_PEER_GET - dump */
-static const struct nla_policy ovpn_peer_get_dump_nl_policy[OVPN_A_IFINDEX + 1] = {
+static const struct nla_policy ovpn_peer_get_dump_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
 };
 
 /* OVPN_CMD_PEER_DEL - do */
-static const struct nla_policy ovpn_peer_del_nl_policy[OVPN_A_PEER + 1] = {
+static const struct nla_policy ovpn_peer_del_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
 	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_del_input_nl_policy),
 };
 
 /* OVPN_CMD_KEY_NEW - do */
-static const struct nla_policy ovpn_key_new_nl_policy[OVPN_A_KEYCONF + 1] = {
+static const struct nla_policy ovpn_key_new_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
 	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_nl_policy),
 };
 
 /* OVPN_CMD_KEY_GET - do */
-static const struct nla_policy ovpn_key_get_nl_policy[OVPN_A_KEYCONF + 1] = {
+static const struct nla_policy ovpn_key_get_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
 	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_get_nl_policy),
 };
 
 /* OVPN_CMD_KEY_SWAP - do */
-static const struct nla_policy ovpn_key_swap_nl_policy[OVPN_A_KEYCONF + 1] = {
+static const struct nla_policy ovpn_key_swap_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
 	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_swap_input_nl_policy),
 };
 
 /* OVPN_CMD_KEY_DEL - do */
-static const struct nla_policy ovpn_key_del_nl_policy[OVPN_A_KEYCONF + 1] = {
+static const struct nla_policy ovpn_key_del_nl_policy[OVPN_A_TARGET_NETNSID + 1] = {
 	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_TARGET_NETNSID] = { .type = NLA_S32, },
 	[OVPN_A_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_del_input_nl_policy),
 };
 
@@ -178,7 +187,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_peer_new_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_peer_new_nl_policy,
-		.maxattr	= OVPN_A_PEER,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -187,7 +196,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_peer_set_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_peer_set_nl_policy,
-		.maxattr	= OVPN_A_PEER,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -196,14 +205,14 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_peer_get_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_peer_get_do_nl_policy,
-		.maxattr	= OVPN_A_PEER,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= OVPN_CMD_PEER_GET,
 		.dumpit		= ovpn_nl_peer_get_dumpit,
 		.policy		= ovpn_peer_get_dump_nl_policy,
-		.maxattr	= OVPN_A_IFINDEX,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -212,7 +221,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_peer_del_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_peer_del_nl_policy,
-		.maxattr	= OVPN_A_PEER,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -221,7 +230,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_key_new_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_new_nl_policy,
-		.maxattr	= OVPN_A_KEYCONF,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -230,7 +239,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_key_get_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_get_nl_policy,
-		.maxattr	= OVPN_A_KEYCONF,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -239,7 +248,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_key_swap_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_swap_nl_policy,
-		.maxattr	= OVPN_A_KEYCONF,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -248,7 +257,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_key_del_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_del_nl_policy,
-		.maxattr	= OVPN_A_KEYCONF,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4c66c1ec497e..b70ecfaf46c8 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -38,6 +38,7 @@ ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info,
 {
 	struct ovpn_priv *ovpn;
 	struct net_device *dev;
+	struct net *target_net = NULL;
 	int ifindex;
 
 	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_IFINDEX))
@@ -45,12 +46,26 @@ ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info,
 
 	ifindex = nla_get_u32(info->attrs[OVPN_A_IFINDEX]);
 
+	if (info->attrs[OVPN_A_TARGET_NETNSID]) {
+		/* Target netns IDs are relative to the requesting Netlink socket */
+		target_net = get_net_ns_by_id(net, nla_get_s32(info->attrs[OVPN_A_TARGET_NETNSID]));
+		if (!target_net) {
+			NL_SET_ERR_MSG_MOD(info->extack,
+					   "invalid target network namespace ID");
+			NL_SET_BAD_ATTR(info->extack,
+					info->attrs[OVPN_A_TARGET_NETNSID]);
+			return ERR_PTR(-EINVAL);
+		}
+		net = target_net;
+	}
+
 	rcu_read_lock();
 	dev = dev_get_by_index_rcu(net, ifindex);
 	if (!dev) {
 		rcu_read_unlock();
 		NL_SET_ERR_MSG_MOD(info->extack,
 				   "ifindex does not match any interface");
+		put_net(target_net);
 		return ERR_PTR(-ENODEV);
 	}
 
@@ -59,12 +74,14 @@ ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info,
 		NL_SET_ERR_MSG_MOD(info->extack,
 				   "specified interface is not ovpn");
 		NL_SET_BAD_ATTR(info->extack, info->attrs[OVPN_A_IFINDEX]);
+		put_net(target_net);
 		return ERR_PTR(-EINVAL);
 	}
 
 	ovpn = netdev_priv(dev);
 	netdev_hold(dev, tracker, GFP_ATOMIC);
 	rcu_read_unlock();
+	put_net(target_net);
 
 	return ovpn;
 }
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
index 06690090a1a9..3fdf24182df4 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -85,6 +85,7 @@ enum {
 	OVPN_A_IFINDEX = 1,
 	OVPN_A_PEER,
 	OVPN_A_KEYCONF,
+	OVPN_A_TARGET_NETNSID,
 
 	__OVPN_A_MAX,
 	OVPN_A_MAX = (__OVPN_A_MAX - 1)
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
