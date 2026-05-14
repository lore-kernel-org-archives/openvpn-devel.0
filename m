Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F69CD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 23:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PiPKkgmaoyJkiydostbptZprk9P+wrQ92Kpe0YmK5tQ=; b=NP7Y48Z8cealkAtWxwwWVbDEpc
	RcNNUcH86Lcq1jeGD9pHo/ZKq3D39V4RVXuhbQjMavZCrVJWxqbS2WjcYXDnnGDRr0f/+YmlxORQY
	Uf/sTOTYgcfMxBeW8MBRnZIfXV4uXyHvrdbbZmktp2Z+f/sx+DHH487BnIy3qdsf2sRE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNfPJ-0003sT-HV;
	Thu, 14 May 2026 23:23:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wNfPH-0003sJ-Q7
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 23:23:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/yDB4T864RCIAPAtZan4Cvu1ucuaOrjHc4ek6raz4PM=; b=kzB36lLaG9E7r/qZ+zd8mxb3Gt
 5WoyDC3H75kHvB6G/ESYYip9S/fS2UJdZFRaGjGCWDfSaguO6els34c2q5tgzG8wPhSMKkMXt4GIc
 /6dNXYVJCmT63ii6tQWibGlovf+mSQTlh7eHUzg3JAOtLD9X/G8lFa8aeZvBE6wWrh1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/yDB4T864RCIAPAtZan4Cvu1ucuaOrjHc4ek6raz4PM=; b=N
 V17uYTEeZPFmtf45/xJ7by9R50Ih/aCPiZRFRjapfgd/TZ0fS7RI3pMD/R+kEU0PMZSBtz6mF2WIc
 aXhJy/B3GlQZb0hoytlQKyI4juOwwyTlDRhQ7N2Fz2V4gDB7mlr9wX8O0Vk6r8M0KSkIpoZ/T2AY1
 bvTzwnTv8Fat7QUM=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNfPG-0003Bc-DS for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 23:23:55 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gGmc2393yz9v70;
 Fri, 15 May 2026 01:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778801026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/yDB4T864RCIAPAtZan4Cvu1ucuaOrjHc4ek6raz4PM=;
 b=HYPRWVh65hJVS3dYdA2ckHwwruUMngoz8Qz7a+yz+jKOmoaGNP5B+XTWoTzx2Z6T68VyUx
 Wu7ErXpRmfS9PYj5OXvQmJRsMhLXdOW9iPe3ze8f6k/fFdyh3VqmlnA7kGJnx+4BJHTLis
 F49vhNubsOvLM+bNUJODLU4dRegBqweDjorBXPSOiqsJQvja6wxNerjy9X6hhDvgDfKni9
 ay+nZh20ovEKA/kBLOgPGlFMh+boGZ5tToUszXKbXhFBmESeDTqj91bd+Xv5W+GzBivaIO
 ALxfDMh2vhQxKg4tQje6nfXLqoMsE6/45XGAu55uOz07KQ1oAKooOEQwQ9Fc4g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 15 May 2026 01:23:43 +0200
Message-ID: <20260514232343.805411-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gGmc2393yz9v70
X-Headers-End: 1wNfPG-0003Bc-DS
Subject: [Openvpn-devel] [PATCH ovpn net-next] ovpn: netlink - check
 CAP_NET_ADMIN in source namespace only
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

From: Antonio Quartulli <antonio@openvpn.net>

Netlink API calls can be allowed as long as the user has
CAP_NET_ADMIN in the source namespace.

There is no need to enforce broader capabilities.

Therefore switch to GENL_UNS_ADMIN_PERM for all netlink ops.

Closes: https://github.com/OpenVPN/ovpn-net-next/issues/33
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/ovpn.yaml | 16 ++++++++--------
 drivers/net/ovpn/netlink-gen.c        | 18 +++++++++---------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index b0c782e59a32..5d1f71b2ff78 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -397,7 +397,7 @@ operations:
     -
       name: peer-new
       attribute-set: ovpn-peer-new-input
-      flags: [admin-perm]
+      flags: [uns-admin-perm]
       doc: Add a remote peer
       do:
         pre: ovpn-nl-pre-doit
@@ -409,7 +409,7 @@ operations:
     -
       name: peer-set
       attribute-set: ovpn-peer-set-input
-      flags: [admin-perm]
+      flags: [uns-admin-perm]
       doc: modify a remote peer
       do:
         pre: ovpn-nl-pre-doit
@@ -421,7 +421,7 @@ operations:
     -
       name: peer-get
       attribute-set: ovpn
-      flags: [admin-perm]
+      flags: [uns-admin-perm]
       doc: Retrieve data about existing remote peers (or a specific one)
       do:
         pre: ovpn-nl-pre-doit
@@ -443,7 +443,7 @@ operations:
     -
       name: peer-del
       attribute-set: ovpn-peer-del-input
-      flags: [admin-perm]
+      flags: [uns-admin-perm]
       doc: Delete existing remote peer
       do:
         pre: ovpn-nl-pre-doit
@@ -461,7 +461,7 @@ operations:
     -
       name: key-new
       attribute-set: ovpn
-      flags: [admin-perm]
+      flags: [uns-admin-perm]
       doc: Add a cipher key for a specific peer
       do:
         pre: ovpn-nl-pre-doit
@@ -473,7 +473,7 @@ operations:
     -
       name: key-get
       attribute-set: ovpn-keyconf-get
-      flags: [admin-perm]
+      flags: [uns-admin-perm]
       doc: Retrieve non-sensitive data about peer key and cipher
       do:
         pre: ovpn-nl-pre-doit
@@ -488,7 +488,7 @@ operations:
     -
       name: key-swap
       attribute-set: ovpn-keyconf-swap-input
-      flags: [admin-perm]
+      flags: [uns-admin-perm]
       doc: Swap primary and secondary session keys for a specific peer
       do:
         pre: ovpn-nl-pre-doit
@@ -507,7 +507,7 @@ operations:
     -
       name: key-del
       attribute-set: ovpn-keyconf-del-input
-      flags: [admin-perm]
+      flags: [uns-admin-perm]
       doc: Delete cipher key for a specific peer
       do:
         pre: ovpn-nl-pre-doit
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 2147cec7c2c5..6f1237f65674 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -179,7 +179,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_peer_new_nl_policy,
 		.maxattr	= OVPN_A_PEER,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= OVPN_CMD_PEER_SET,
@@ -188,7 +188,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_peer_set_nl_policy,
 		.maxattr	= OVPN_A_PEER,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= OVPN_CMD_PEER_GET,
@@ -197,14 +197,14 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_peer_get_do_nl_policy,
 		.maxattr	= OVPN_A_PEER,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= OVPN_CMD_PEER_GET,
 		.dumpit		= ovpn_nl_peer_get_dumpit,
 		.policy		= ovpn_peer_get_dump_nl_policy,
 		.maxattr	= OVPN_A_IFINDEX,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
 		.cmd		= OVPN_CMD_PEER_DEL,
@@ -213,7 +213,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_peer_del_nl_policy,
 		.maxattr	= OVPN_A_PEER,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= OVPN_CMD_KEY_NEW,
@@ -222,7 +222,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_new_nl_policy,
 		.maxattr	= OVPN_A_KEYCONF,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= OVPN_CMD_KEY_GET,
@@ -231,7 +231,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_get_nl_policy,
 		.maxattr	= OVPN_A_KEYCONF,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= OVPN_CMD_KEY_SWAP,
@@ -240,7 +240,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_swap_nl_policy,
 		.maxattr	= OVPN_A_KEYCONF,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= OVPN_CMD_KEY_DEL,
@@ -249,7 +249,7 @@ static const struct genl_split_ops ovpn_nl_ops[] = {
 		.post_doit	= ovpn_nl_post_doit,
 		.policy		= ovpn_key_del_nl_policy,
 		.maxattr	= OVPN_A_KEYCONF,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
 
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
