Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BC0C982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f3wi69AyluGP4WS4ICyIqlacp20HRJvzmRjTY0+68SE=; b=J0x3dI7DQxLSHyUAP7EjUI3MGz
	1wzKxNE0p+nia7wk/sGW4BgkgtNdHR3apNAXa74ZCXkQq3M+cP3v6vfuGDBoPoY2Tkt9QDV8wfGKr
	D+Cq9omqgdDTGzSLk+mVYArszW15tV7lqqZkwCVB5RbU3Pq6k1ceNjKruMkCcROL3s/Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91R3-0002XZ-Bo;
	Tue, 22 Sep 2026 14:25:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x91Qt-0002XL-W2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZZuR28K1sZQa8aBWzy0MTx0jcdYG+4JCY2sfwQC6FSc=; b=g9Zlkj5ngzLdY/6oNnwIgX/vRJ
 JLm4cCs/dhSy80hFpGHddbS7pOWvyIgr2wNWaMmdvILVC+dNTZ6t4jYfWJHXiVXj35Ua7h3i1aFYm
 cxOzqlHA/HRmHt1AO1kLGk1qzKiWeRtA0mDIkwdnSbr0W53Qqu0Lz9FpayPSW1QKQpcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZZuR28K1sZQa8aBWzy0MTx0jcdYG+4JCY2sfwQC6FSc=; b=W
 FEWs6llM9OsuDlHg+VIaPiid+UlO83JICkfme2XUHwGCpDcrnRX53xYUTAsMPMVKoi/oBri1Zyv4Q
 kd51gCydrmsBLs4Jqe+AyYZ7XVBC1sNsNbDOZ1JC/LuzfrgDFN7xFVyGK9snAmi1KsVsbYkfuTWD/
 SK2VCo9+u0xmZl14=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x91Qr-0002VE-Pj for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:25:19 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hq2S523n4z5wkH;
 Tue, 22 Sep 2026 16:25:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790087109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZZuR28K1sZQa8aBWzy0MTx0jcdYG+4JCY2sfwQC6FSc=;
 b=hJHXBaXGTBgUNBe3yWkHqmxysaPZqKkL/AIQrqFUiLA0Gp2X0TAwKxPa46qQ8jzAfUHYCG
 +E7fapUC7h1uRhLkRnOfosIPqRi+ADis6tHJHKDo/AlVfecNXljWJTuRflc1nU2NkoAxZ0
 lrhUntOuqWKEVlvrY80XiZl0FmTuEXkWnnebjDHh6wWY2z6hXv49wOQcF3fBqIPErUGbYL
 3nY1eojvqFjdzULZ1n8hnFcE4ukBq6f+ghK9q9F+M6MFEp32a0h/4gkqGKC7f+5VJX01lQ
 0ZRrdFO0xLW5UPeROlUoxadjgpPihk+BbF8FfLOCSZNvt2QvITTMaLOl4s5vug==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 22 Sep 2026 16:25:03 +0200
Message-ID: <20260922142505.3138388-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hq2S523n4z5wkH
X-Headers-End: 1x91Qr-0002VE-Pj
Subject: [Openvpn-devel] [PATCH ovpn net-next 1/3] ovpn: support operations
 on interfaces in foreign netns
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
 Documentation/netlink/specs/ovpn.yaml | 27 ++++++++++++++++
 drivers/net/ovpn/netlink-gen.c        | 45 ++++++++++++++++-----------
 drivers/net/ovpn/netlink.c            | 34 +++++++++++++++++---
 include/uapi/linux/ovpn.h             |  1 +
 4 files changed, 84 insertions(+), 23 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index ac50d1d7c00a6..3d8055282ebe5 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -341,12 +341,20 @@ attribute-sets:
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
@@ -356,6 +364,8 @@ attribute-sets:
     attributes:
       -
         name: ifindex
+      -
+        name: target-netnsid
       -
         name: peer
         nested-attributes: peer-set-input
@@ -365,6 +375,8 @@ attribute-sets:
     attributes:
       -
         name: ifindex
+      -
+        name: target-netnsid
       -
         name: peer
         nested-attributes: peer-del-input
@@ -374,6 +386,8 @@ attribute-sets:
     attributes:
       -
         name: ifindex
+      -
+        name: target-netnsid
       -
         name: keyconf
         nested-attributes: keyconf-get
@@ -383,6 +397,8 @@ attribute-sets:
     attributes:
       -
         name: ifindex
+      -
+        name: target-netnsid
       -
         name: keyconf
         nested-attributes: keyconf-swap-input
@@ -392,6 +408,8 @@ attribute-sets:
     attributes:
       -
         name: ifindex
+      -
+        name: target-netnsid
       -
         name: keyconf
         nested-attributes: keyconf-del-input
@@ -409,6 +427,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - peer
     -
       name: peer-set
@@ -421,6 +440,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - peer
     -
       name: peer-get
@@ -433,6 +453,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - peer
         reply:
           attributes:
@@ -441,6 +462,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
         reply:
           attributes:
             - peer
@@ -455,6 +477,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - peer
     -
       name: peer-del-ntf
@@ -473,6 +496,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - keyconf
     -
       name: key-get
@@ -485,6 +509,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - keyconf
         reply:
           attributes:
@@ -500,6 +525,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - keyconf
     -
       name: key-swap-ntf
@@ -519,6 +545,7 @@ operations:
         request:
           attributes:
             - ifindex
+            - target-netnsid
             - keyconf
 
     -
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 92d2fdc17c2e8..7ac9de00e0206 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -126,55 +126,64 @@ const struct nla_policy ovpn_peer_set_input_nl_policy[OVPN_A_PEER_TX_ID + 1] = {
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
 
@@ -186,7 +195,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_peer_new_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_peer_new_nl_policy,
-		.maxattr	= OVPN_A_PEER,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -195,7 +204,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_peer_set_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_peer_set_nl_policy,
-		.maxattr	= OVPN_A_PEER,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -204,14 +213,14 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
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
@@ -220,7 +229,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_peer_del_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_peer_del_nl_policy,
-		.maxattr	= OVPN_A_PEER,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -229,7 +238,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_key_new_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_new_nl_policy,
-		.maxattr	= OVPN_A_KEYCONF,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -238,7 +247,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_key_get_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_get_nl_policy,
-		.maxattr	= OVPN_A_KEYCONF,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -247,7 +256,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_key_swap_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_swap_nl_policy,
-		.maxattr	= OVPN_A_KEYCONF,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -256,7 +265,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.doit		= ovpn_nl_key_del_doit,
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_del_nl_policy,
-		.maxattr	= OVPN_A_KEYCONF,
+		.maxattr	= OVPN_A_TARGET_NETNSID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4dad852941982..04df2c0288a5d 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -9,6 +9,7 @@
 #include <linux/netdevice.h>
 #include <linux/types.h>
 #include <net/genetlink.h>
+#include <net/rtnetlink.h>
 
 #include <uapi/linux/ovpn.h>
 
@@ -26,31 +27,52 @@ MODULE_ALIAS_GENL_FAMILY(OVPN_FAMILY_NAME);
 /**
  * ovpn_get_dev_from_attrs - retrieve the ovpn private data from the netdevice
  *			     a netlink message is targeting
- * @net: network namespace where to look for the interface
+ * @sk: requesting netlink socket
  * @info: generic netlink info from the user request
  * @tracker: tracker object to be used for the netdev reference acquisition
  *
  * Return: the ovpn private data, if found, or an error otherwise
  */
 static struct ovpn_priv *
-ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info,
+ovpn_get_dev_from_attrs(struct sock *sk, const struct genl_info *info,
 			netdevice_tracker *tracker)
 {
+	struct net *target_net = NULL;
+	struct net *net = sock_net(sk);
 	struct ovpn_priv *ovpn;
 	struct net_device *dev;
-	int ifindex;
+	int ifindex, target_id;
 
 	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_IFINDEX))
 		return ERR_PTR(-EINVAL);
 
 	ifindex = nla_get_u32(info->attrs[OVPN_A_IFINDEX]);
 
+	if (info->attrs[OVPN_A_TARGET_NETNSID]) {
+		/* Target netns IDs are relative to the requesting Netlink socket */
+		target_id = nla_get_s32(info->attrs[OVPN_A_TARGET_NETNSID]);
+		target_net = rtnl_get_net_ns_capable(sk, target_id);
+		if (IS_ERR(target_net)) {
+			if (PTR_ERR(target_net) == -EACCES)
+				NL_SET_ERR_MSG_MOD(info->extack,
+						   "insufficient permission for target network namespace");
+			else
+				NL_SET_ERR_MSG_MOD(info->extack,
+						   "invalid target network namespace ID");
+			NL_SET_BAD_ATTR(info->extack,
+					info->attrs[OVPN_A_TARGET_NETNSID]);
+			return ERR_CAST(target_net);
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
 
@@ -59,12 +81,14 @@ ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info,
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
@@ -73,7 +97,7 @@ int ovpn_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info)
 {
 	netdevice_tracker *tracker = (netdevice_tracker *)&info->user_ptr[1];
-	struct ovpn_priv *ovpn = ovpn_get_dev_from_attrs(genl_info_net(info),
+	struct ovpn_priv *ovpn = ovpn_get_dev_from_attrs(NETLINK_CB(skb).sk,
 							 info, tracker);
 
 	if (IS_ERR(ovpn))
@@ -738,7 +762,7 @@ int ovpn_nl_peer_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	struct ovpn_priv *ovpn;
 	struct ovpn_peer *peer;
 
-	ovpn = ovpn_get_dev_from_attrs(sock_net(cb->skb->sk), info, &tracker);
+	ovpn = ovpn_get_dev_from_attrs(NETLINK_CB(cb->skb).sk, info, &tracker);
 	if (IS_ERR(ovpn))
 		return PTR_ERR(ovpn);
 
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
index 06690090a1a95..3fdf24182df43 100644
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
