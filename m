Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBC5C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fHobK7INKhJqZtUnmJ4qf2oKQZsr8JYdr1CljkbqUxY=; b=N+nJCjklAdP3EeHVtRQp0WeIxc
	5fwVATlyvTWAO8yiL/h3bPJzaejuMSoMbAlTqw7iRXCURv5adMpU8pKOaZeqlK2YULHZnwG037O3c
	Ks1UntZCKLPOaWJ84OO9dCx5+RbRfsi9De1Z4Y5JjQa0THle+dkWupWz8JrDFy/JBV+8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wex6v-0003kk-Qh;
	Wed, 01 Jul 2026 15:44:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wex6t-0003kP-EZ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GZI1sEhhBAtO+/IPmld9SIdEaKuHyABuJ83EmsbWIng=; b=SKNms/bwfi/mQqS1xQbAXaahQs
 zPmIU+4gftRru2gWuCkQeimP4YbP6fek+P8kgqgplK1NNFTkPfOl3FZd5YIu/0MCQkYVNvL2Higyw
 iQsParOJRTKSBE5CZjRQfhsmHVnIuX/AN9lju+hlneorkz4uflUofuXMy+JgJMhad8QA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GZI1sEhhBAtO+/IPmld9SIdEaKuHyABuJ83EmsbWIng=; b=PAA06oC/bUVOPeStGLXERhHDqL
 7BCllbGS+oFlWHI5hYFqrgjse8htbjS0I8ALa61cyCsi2Zg/4DbuFdLqCGA87HpVnXl5KzqH0kKuW
 lPtW3cm/3nTRDPAExA3duheQP2rOIlg9VJN2yPnUhaCqeuS2s39wcnBR08I2RhlfOIGI=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wex6p-0002Ao-CV for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 15:44:20 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4gr47W15VPz9xGd;
 Wed,  1 Jul 2026 17:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782920647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZI1sEhhBAtO+/IPmld9SIdEaKuHyABuJ83EmsbWIng=;
 b=QXZwfKw5ERu76EtnkgfW+XvBUwheMD8JZtZ89Qod1k26aG0SGeIYlSOXfqbVuB6ksz5aTr
 jeGSdkrvZlnfz6duhfEcSa3gnEo8e5uTvGmt3h75EUNtOn5pQrfGYbDuFnpP4E8Tar50uv
 L6oAs042ZnYSuMZyRqNiHAfcgl5tF0LAKbyPDZeOz7PiXQCLXAhvhF7CVNySpgh8Lp0rET
 KwUXEzIbC3pIMbDtpGBSRsWQDXnsdFWQCiDevfuaD4z9c9nwo9Q+H7gGkVjPFNYSzlcCgX
 i5nuD4j7auNljWmYZVgqZ2HOhiW29z2f6NseyTMWGtNMul3PwnDI475osC/apA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 17:43:28 +0200
Message-ID: <6a100e535685abf00f2b9d3982eda44ea01a2512.1782919654.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782919654.git.ralf@mandelbit.com>
References: <cover.1782919654.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wex6p-0002Ao-CV
Subject: [Openvpn-devel] [RFC ovpn net-next 13/14] ovpn: accept epoch keys
 from netlink
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

Allow KEY_NEW to receive either direct key material or epoch PRK
material. Userspace must provide exactly one key format: the existing
encrypt/decrypt direction attributes select direct keys, while the new
epoch attributes select epoch-derived keys.

Parse epoch key attributes into the common key configuration used by
crypto slot setup. Direct key attributes keep the existing UAPI shape,
so current userspace continues to install direct keys without any new
format attribute.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 Documentation/netlink/specs/ovpn.yaml |  31 ++++++++
 drivers/net/ovpn/crypto_epoch.h       |   1 -
 drivers/net/ovpn/netlink-gen.c        |   9 ++-
 drivers/net/ovpn/netlink-gen.h        |   3 +-
 drivers/net/ovpn/netlink.c            | 110 ++++++++++++++++++++++----
 include/uapi/linux/ovpn.h             |  11 +++
 6 files changed, 146 insertions(+), 19 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index b0c782e59a32..43b9ab1eb3da 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -16,6 +16,10 @@ definitions:
     type: const
     name: nonce-tail-size
     value: 8
+  -
+    type: const
+    name: epoch-prk-size
+    value: 32
   -
     type: enum
     name: cipher-alg
@@ -274,6 +278,16 @@ attribute-sets:
         type: nest
         doc: Key material for decrypt direction
         nested-attributes: keydir
+      -
+        name: encrypt-epoch
+        type: nest
+        doc: Epoch PRK material used to derive encrypt data keys
+        nested-attributes: epoch
+      -
+        name: decrypt-epoch
+        type: nest
+        doc: Epoch PRK material used to derive decrypt data keys
+        nested-attributes: epoch
   -
     name: keydir
     attributes:
@@ -291,6 +305,23 @@ attribute-sets:
           obtain the actual cipher IV
         checks:
           exact-len: nonce-tail-size
+  -
+    name: epoch
+    attributes:
+      -
+        name: key
+        type: binary
+        doc: >-
+          The epoch PRK used to derive cipher keys and implicit IVs
+        checks:
+          exact-len: epoch-prk-size
+      -
+        name: cipher-key-len
+        type: u32
+        doc: Length in bytes of the AEAD cipher key derived from the epoch PRK
+        checks:
+          min: 1
+          max: epoch-prk-size
 
   -
     name: keyconf-get
diff --git a/drivers/net/ovpn/crypto_epoch.h b/drivers/net/ovpn/crypto_epoch.h
index 7da31c2acd44..76278c73eba4 100644
--- a/drivers/net/ovpn/crypto_epoch.h
+++ b/drivers/net/ovpn/crypto_epoch.h
@@ -16,7 +16,6 @@
 #include <linux/types.h>
 #include <uapi/linux/ovpn.h>
 
-#define OVPN_EPOCH_PRK_SIZE 32
 #define OVPN_MAX_EPOCH U16_MAX
 #define OVPN_EPOCH_FUTURE_KEYS_COUNT 16
 
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 2147cec7c2c5..667a51f52158 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -25,13 +25,20 @@ static const struct netlink_range_validation ovpn_a_keyconf_peer_id_range = {
 };
 
 /* Common nested types */
-const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_DIR + 1] = {
+const struct nla_policy ovpn_epoch_nl_policy[OVPN_A_EPOCH_CIPHER_KEY_LEN + 1] = {
+	[OVPN_A_EPOCH_KEY] = NLA_POLICY_EXACT_LEN(OVPN_EPOCH_PRK_SIZE),
+	[OVPN_A_EPOCH_CIPHER_KEY_LEN] = NLA_POLICY_RANGE(NLA_U32, 1, OVPN_EPOCH_PRK_SIZE),
+};
+
+const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_EPOCH + 1] = {
 	[OVPN_A_KEYCONF_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_keyconf_peer_id_range),
 	[OVPN_A_KEYCONF_SLOT] = NLA_POLICY_MAX(NLA_U32, 1),
 	[OVPN_A_KEYCONF_KEY_ID] = NLA_POLICY_MAX(NLA_U32, 7),
 	[OVPN_A_KEYCONF_CIPHER_ALG] = NLA_POLICY_MAX(NLA_U32, 2),
 	[OVPN_A_KEYCONF_ENCRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
 	[OVPN_A_KEYCONF_DECRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
+	[OVPN_A_KEYCONF_ENCRYPT_EPOCH] = NLA_POLICY_NESTED(ovpn_epoch_nl_policy),
+	[OVPN_A_KEYCONF_DECRYPT_EPOCH] = NLA_POLICY_NESTED(ovpn_epoch_nl_policy),
 };
 
 const struct nla_policy ovpn_keyconf_del_input_nl_policy[OVPN_A_KEYCONF_SLOT + 1] = {
diff --git a/drivers/net/ovpn/netlink-gen.h b/drivers/net/ovpn/netlink-gen.h
index 67cd85f86173..72f765f574a5 100644
--- a/drivers/net/ovpn/netlink-gen.h
+++ b/drivers/net/ovpn/netlink-gen.h
@@ -13,7 +13,8 @@
 #include <uapi/linux/ovpn.h>
 
 /* Common nested types */
-extern const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_DIR + 1];
+extern const struct nla_policy ovpn_epoch_nl_policy[OVPN_A_EPOCH_CIPHER_KEY_LEN + 1];
+extern const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_EPOCH + 1];
 extern const struct nla_policy ovpn_keyconf_del_input_nl_policy[OVPN_A_KEYCONF_SLOT + 1];
 extern const struct nla_policy ovpn_keyconf_get_nl_policy[OVPN_A_KEYCONF_CIPHER_ALG + 1];
 extern const struct nla_policy ovpn_keyconf_swap_input_nl_policy[OVPN_A_KEYCONF_PEER_ID + 1];
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 910e4e67a68a..14c91729b392 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -859,6 +859,40 @@ static int ovpn_nl_get_key_dir(struct genl_info *info, struct nlattr *key,
 	return 0;
 }
 
+static int ovpn_nl_get_epoch_key(struct genl_info *info, struct nlattr *key,
+				 enum ovpn_cipher_alg cipher,
+				 struct ovpn_epoch_prk *prk)
+{
+	struct nlattr *attrs[OVPN_A_EPOCH_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested(attrs, OVPN_A_EPOCH_MAX, key,
+			       ovpn_epoch_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	switch (cipher) {
+	case OVPN_CIPHER_ALG_AES_GCM:
+	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+		if (NL_REQ_ATTR_CHECK(info->extack, key, attrs,
+				      OVPN_A_EPOCH_KEY) ||
+		    NL_REQ_ATTR_CHECK(info->extack, key, attrs,
+				      OVPN_A_EPOCH_CIPHER_KEY_LEN))
+			return -EINVAL;
+
+		prk->key = nla_data(attrs[OVPN_A_EPOCH_KEY]);
+		prk->key_size = nla_len(attrs[OVPN_A_EPOCH_KEY]);
+		prk->cipher_key_len =
+			nla_get_u32(attrs[OVPN_A_EPOCH_CIPHER_KEY_LEN]);
+		break;
+	default:
+		NL_SET_ERR_MSG_MOD(info->extack, "unsupported cipher");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * ovpn_nl_key_new_doit - configure a new key for the specified peer
  * @skb: incoming netlink message
@@ -887,9 +921,11 @@ static int ovpn_nl_get_key_dir(struct genl_info *info, struct nlattr *key,
 int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
-	struct ovpn_priv *ovpn = info->user_ptr[0];
 	struct ovpn_peer_key_reset pkr = {};
+	struct ovpn_priv *ovpn = info->user_ptr[0];
 	struct ovpn_peer *peer;
+	bool direct_key;
+	bool epoch_key;
 	u32 peer_id;
 	int ret;
 
@@ -911,28 +947,70 @@ int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
 	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
 			      OVPN_A_KEYCONF_KEY_ID) ||
 	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
-			      OVPN_A_KEYCONF_CIPHER_ALG) ||
-	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
-			      OVPN_A_KEYCONF_ENCRYPT_DIR) ||
-	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
-			      OVPN_A_KEYCONF_DECRYPT_DIR))
+			      OVPN_A_KEYCONF_CIPHER_ALG))
 		return -EINVAL;
 
 	pkr.slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);
 	pkr.key.key_id = nla_get_u32(attrs[OVPN_A_KEYCONF_KEY_ID]);
 	pkr.key.cipher_alg = nla_get_u32(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
 
-	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_ENCRYPT_DIR],
-				  pkr.key.cipher_alg,
-				  &pkr.key.direct.encrypt);
-	if (ret < 0)
-		return ret;
+	direct_key = attrs[OVPN_A_KEYCONF_ENCRYPT_DIR] ||
+		     attrs[OVPN_A_KEYCONF_DECRYPT_DIR];
+	epoch_key = attrs[OVPN_A_KEYCONF_ENCRYPT_EPOCH] ||
+		    attrs[OVPN_A_KEYCONF_DECRYPT_EPOCH];
+	if (direct_key == epoch_key) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "specify exactly one key format");
+		return -EINVAL;
+	}
 
-	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_DECRYPT_DIR],
-				  pkr.key.cipher_alg,
-				  &pkr.key.direct.decrypt);
-	if (ret < 0)
-		return ret;
+	if (direct_key) {
+		if (NL_REQ_ATTR_CHECK(info->extack,
+				      info->attrs[OVPN_A_KEYCONF], attrs,
+				      OVPN_A_KEYCONF_ENCRYPT_DIR) ||
+		    NL_REQ_ATTR_CHECK(info->extack,
+				      info->attrs[OVPN_A_KEYCONF], attrs,
+				      OVPN_A_KEYCONF_DECRYPT_DIR))
+			return -EINVAL;
+
+		pkr.key.use_epoch_keys = false;
+		ret = ovpn_nl_get_key_dir(info,
+					  attrs[OVPN_A_KEYCONF_ENCRYPT_DIR],
+					  pkr.key.cipher_alg,
+					  &pkr.key.direct.encrypt);
+		if (ret < 0)
+			return ret;
+
+		ret = ovpn_nl_get_key_dir(info,
+					  attrs[OVPN_A_KEYCONF_DECRYPT_DIR],
+					  pkr.key.cipher_alg,
+					  &pkr.key.direct.decrypt);
+		if (ret < 0)
+			return ret;
+	} else {
+		if (NL_REQ_ATTR_CHECK(info->extack,
+				      info->attrs[OVPN_A_KEYCONF], attrs,
+				      OVPN_A_KEYCONF_ENCRYPT_EPOCH) ||
+		    NL_REQ_ATTR_CHECK(info->extack,
+				      info->attrs[OVPN_A_KEYCONF], attrs,
+				      OVPN_A_KEYCONF_DECRYPT_EPOCH))
+			return -EINVAL;
+
+		pkr.key.use_epoch_keys = true;
+		ret = ovpn_nl_get_epoch_key(info,
+					    attrs[OVPN_A_KEYCONF_ENCRYPT_EPOCH],
+					    pkr.key.cipher_alg,
+					    &pkr.key.epoch.encrypt);
+		if (ret < 0)
+			return ret;
+
+		ret = ovpn_nl_get_epoch_key(info,
+					    attrs[OVPN_A_KEYCONF_DECRYPT_EPOCH],
+					    pkr.key.cipher_alg,
+					    &pkr.key.epoch.decrypt);
+		if (ret < 0)
+			return ret;
+	}
 
 	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
 	peer = ovpn_peer_get_by_id(ovpn, peer_id);
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
index 06690090a1a9..fa6436557abd 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -11,6 +11,7 @@
 #define OVPN_FAMILY_VERSION	1
 
 #define OVPN_NONCE_TAIL_SIZE	8
+#define OVPN_EPOCH_PRK_SIZE	32
 
 enum ovpn_cipher_alg {
 	OVPN_CIPHER_ALG_NONE,
@@ -68,6 +69,8 @@ enum {
 	OVPN_A_KEYCONF_CIPHER_ALG,
 	OVPN_A_KEYCONF_ENCRYPT_DIR,
 	OVPN_A_KEYCONF_DECRYPT_DIR,
+	OVPN_A_KEYCONF_ENCRYPT_EPOCH,
+	OVPN_A_KEYCONF_DECRYPT_EPOCH,
 
 	__OVPN_A_KEYCONF_MAX,
 	OVPN_A_KEYCONF_MAX = (__OVPN_A_KEYCONF_MAX - 1)
@@ -81,6 +84,14 @@ enum {
 	OVPN_A_KEYDIR_MAX = (__OVPN_A_KEYDIR_MAX - 1)
 };
 
+enum {
+	OVPN_A_EPOCH_KEY = 1,
+	OVPN_A_EPOCH_CIPHER_KEY_LEN,
+
+	__OVPN_A_EPOCH_MAX,
+	OVPN_A_EPOCH_MAX = (__OVPN_A_EPOCH_MAX - 1)
+};
+
 enum {
 	OVPN_A_IFINDEX = 1,
 	OVPN_A_PEER,
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
