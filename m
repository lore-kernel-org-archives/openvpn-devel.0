Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0D7CD5BD2
	for <openvpn-devel@archiver.kernel.org>; Mon, 25 May 2026 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PiPKkgmaoyJkiydostbptZprk9P+wrQ92Kpe0YmK5tQ=; b=dBQd5xjQBMrDxKRSn4Y/ufZuR9
	ABgqFsBzcvolp992b7fZXAXqahKTN1j7BDKnonjSno3IEY4HCKXJkq8jkHjqE53JQmQI2pz9W8GBN
	ZfqyAu4xtNJ5t6rplD+qzRMd0WopfuXjVIStoNfF6/DAd/gxn0eT7bMIiAjXRd2xQkgM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRWPs-00030E-So;
	Mon, 25 May 2026 14:36:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wRWPj-0002zz-Sc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 25 May 2026 14:36:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/yDB4T864RCIAPAtZan4Cvu1ucuaOrjHc4ek6raz4PM=; b=iKvQhE3WjiWZ4YB8DVtUzodqmg
 z0YmL/7XUy10EOwc6GGFxgzS3g9jme+zV/zvWhtlo8LCXqK6mWxKI2HS/y+fBhg6EF3pZGXZQxdF6
 p5MFsS8F5YertpIh+4Lx+PRnVMuj/AGZOBkt8+EvkImFlROmFxjHDV4sn/Ep7X701fJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/yDB4T864RCIAPAtZan4Cvu1ucuaOrjHc4ek6raz4PM=; b=d9/3izTGzL3x12Jwpg1EfZG78m
 QBPqf7KFVQKysjmO7EEtVBBIdciIJb+wAjpTx/vkwKAon3vNYiHv68Mlft96hTumXeK7AMmTi1dDK
 RpEHuxJJP9capr3JdpWVWZIO+Y7BV6tVaShpiLxlxZr41kWZxuqSFFslH6clLYfdb7qo=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRWPi-0003pE-Vt for openvpn-devel@lists.sourceforge.net;
 Mon, 25 May 2026 14:36:20 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gPJNB3ypqz9vJR;
 Mon, 25 May 2026 16:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779719770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/yDB4T864RCIAPAtZan4Cvu1ucuaOrjHc4ek6raz4PM=;
 b=xZWtC+P9Fgc0mB2PLsuThNnQnS9gFD4czcGTf+CZFO5l45JrrQ5iwWyIfs6G0wKucbB1Ol
 RWTVaD/iPOwEG8jKcwaAaU8WxtwOgHLr+jd0Ry/3F/oJRRk9zrzna9Fko8NK6dNaBsbArf
 XbUWeQ5Xzx8VWNHnJ23Rh0XHDbcSgCUr+jd4ig7xT7oNZovBeqzLOrkb0cBfRB76kIrR3K
 bfvzdYSjjfBYQbLLmWQyqmZkegXRzyj2pp6oOnOsSj/FQVqwcUEqCUUHQoblPDLdxePmfJ
 ggQYsjkdVzwcrvsChll0bdERw4NYUpLPWFLjNPnClwPGLr7dxs93PuhBCExJlQ==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 25 May 2026 16:36:06 +0200
Message-ID: <20260525143606.1532168-4-a@unstable.cc>
In-Reply-To: <20260525143606.1532168-1-a@unstable.cc>
References: <20260525143606.1532168-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wRWPi-0003pE-Vt
Subject: [Openvpn-devel] [PATCH 4/4] ovpn: netlink - check CAP_NET_ADMIN in
 source namespace only
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
