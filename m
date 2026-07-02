Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4DEC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3R1/nWdwYLYVmszjeYtdPN4t3xl5oW5fdsh6PKAr/6k=; b=Xg3dllXp59jo+yvqCYNCyi7CAd
	SynSSB4CzoJ2nyeqnDNcKfUDXFBM0IJBA6xabGk7f2AmL3wxvLnfPCIMnSFPARH5Wn+KAMMQElGBl
	LqNIBhUb6WcwcTlHgn3oP6GNwyP49hzwyXss3K9taq75qJ9S3HLzq5/BQ6yC+06fJFWE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfFzE-0005bG-1I;
	Thu, 02 Jul 2026 11:53:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfFzD-0005b7-Gl
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NmROwgokUFkhRRdbb2a8lDdv8GmDpdfnGrJ8PyHwbmQ=; b=R+CMefOleiKndxj5d7TxHtTXAN
 ocrhxXgdJ4aiogwqoiSrZT8AW8xL/zVQ6y8rBU89oMvupm9JKVGMn9NIJqb+Ye65RvGogq84+jUWB
 d8F0IG53V38fdIKzi5BDl9UGB/L52w/9LnQVZhfI+xbWoJyf2pcauDEndNAdD/sjDxHk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NmROwgokUFkhRRdbb2a8lDdv8GmDpdfnGrJ8PyHwbmQ=; b=hfUD6zsunZsrt6ePl8R0aPcYcl
 icBnC450oRxjUorzv2zbRNsbGWEu0IGEnfeseIKe7dB+IYogfcCMvDy70kxYppvJdfduEE+bJU6F/
 RpC5rqvbBMauKscZYBl55zbvhTTqpauffZJ+o+jQyfnWo4Uze8//+R1aM1FcyHT6ORFI=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfFzA-0004LC-97 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 11:53:43 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4grZyv6jKcz9yCD;
 Thu,  2 Jul 2026 13:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782993208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmROwgokUFkhRRdbb2a8lDdv8GmDpdfnGrJ8PyHwbmQ=;
 b=jqpe2URN0ECWlvHn/KqVZY5uAROEIPmDNyABZXSn5rJ4uCNKgSuJk5Ivqe15Z/Jbp7G+YR
 N3WWaixlek53EZ7LSEmfUdlFe5b1hZ3uex5l6bJ/n9424dIGW88ov+rgBWvGnHDIkeVGga
 lMrs0TzuBullno8FChKpI1r9cvcSkUxu2nWMAm3BJQ+l9sbrP55afP/1IFiXkQX0hcvEOa
 C9OrLAS1xCBNqKy1GLJsRb8CfjSbwqrFszcTw23DtNmG5iRV8yBfcB/jiKatlZqueQlBRN
 5ezdqvM1XE4AqKZesbsn+x5rDKsZ8OKdP2OEs/qrqncT7M9Jz0GMDzWqGyAXtg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2026 13:52:29 +0200
Message-ID: <93d28583fda6f6983e567ca9a724892478e688ad.1782986577.git.ralf@mandelbit.com>
In-Reply-To: <cover.1782986577.git.ralf@mandelbit.com>
References: <cover.1782986577.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4grZyv6jKcz9yCD
X-Headers-End: 1wfFzA-0004LC-97
Subject: [Openvpn-devel] [RFC ovpn net-next v2 14/14] selftests: ovpn:
 exercise epoch keys
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

Extend ovpn-cli's key installation command with an explicit key type so
that the tests can install either direct keys or epoch keys. Use the
same selector for the TCP connect helper when it auto-installs a key.

Add epoch wrappers around the existing UDP and TCP data-path tests. The
packet capture filter also checks epoch 1 in DATA_V2 packet IDs, so the
tests verify netlink key installation and the epoch packet layout
without adding a separate topology.

This intentionally does not cover epoch rotation or future-key refill:
the selftests use normal production limits, so the short traffic run
does not consume enough packet-ID or AEAD budget to advance epochs.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v1 https://lore.kernel.org/openvpn-devel/d6fa57646d97b24e60613f8b28665610244846e8.1782919654.git.ralf@mandelbit.com/

 tools/testing/selftests/net/ovpn/Makefile     |   2 +
 tools/testing/selftests/net/ovpn/common.sh    |  30 +++--
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 116 +++++++++++++++---
 .../selftests/net/ovpn/test-epoch-tcp.sh      |  11 ++
 .../testing/selftests/net/ovpn/test-epoch.sh  |  10 ++
 tools/testing/selftests/net/ovpn/test-mark.sh |   3 +-
 tools/testing/selftests/net/ovpn/test.sh      |  12 +-
 7 files changed, 154 insertions(+), 30 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-epoch-tcp.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-epoch.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index 169f0464ac3a..515aeac945a4 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -36,6 +36,8 @@ TEST_PROGS := \
 	test-chachapoly.sh \
 	test-close-socket-tcp.sh \
 	test-close-socket.sh \
+	test-epoch-tcp.sh \
+	test-epoch.sh \
 	test-float.sh \
 	test-large-mtu.sh \
 	test-mark.sh \
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e..de5ff9a9e97a 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -12,6 +12,7 @@ OVPN_TCP_PEERS_FILE=${OVPN_TCP_PEERS_FILE:-tcp_peers.txt}
 OVPN_CLI=${OVPN_CLI:-${OVPN_COMMON_DIR}/ovpn-cli}
 OVPN_YNL=${OVPN_YNL:-${OVPN_COMMON_DIR}/../../../../net/ynl/pyynl/cli.py}
 OVPN_ALG=${OVPN_ALG:-aes}
+OVPN_KEY_TYPE=${OVPN_KEY_TYPE:-direct}
 OVPN_PROTO=${OVPN_PROTO:-UDP}
 OVPN_FLOAT=${OVPN_FLOAT:-0}
 OVPN_SYMMETRIC_ID=${OVPN_SYMMETRIC_ID:-0}
@@ -184,14 +185,26 @@ ovpn_build_capture_filter() {
 		# address. The IPv6 branch assumes there are no extension
 		# headers in the outer packet.
 		if [[ "${2}" == *:* ]]; then
-			printf "ip6 and ip6[6] = 17 and ip6[48:4] = %s" "${1}"
+			printf "ip6 and ip6[6] = 17 and ip6[48:4] = %s" \
+				"${1}"
+			if [ "${OVPN_KEY_TYPE}" == "epoch" ]; then
+				printf " and ip6[52:2] = 0x0001"
+			fi
 		else
 			printf "ip and udp[8:4] = %s" "${1}"
+			if [ "${OVPN_KEY_TYPE}" == "epoch" ]; then
+				printf " and udp[12:2] = 0x0001"
+			fi
 		fi
 	else
 		# openvpn over TCP prepends a 2-byte packet length ahead of the
 		# DATA_V2 opcode, so skip it before matching the payload header
-		printf "ip and tcp[(((tcp[12] & 0xf0) >> 2) + 2):4] = %s" "${1}"
+		printf "ip and tcp[(((tcp[12] & 0xf0) >> 2) + 2):4] = %s" \
+			"${1}"
+		if [ "${OVPN_KEY_TYPE}" == "epoch" ]; then
+			printf " and tcp[(((tcp[12] & 0xf0) >> 2) + 6):2] = "
+			printf "0x0001"
+		fi
 	fi
 }
 
@@ -222,8 +235,8 @@ ovpn_add_peer() {
 
 			for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 				ip netns exec "${server_ns}" ${OVPN_CLI} \
-					new_key tun0 ${p} 1 0 ${OVPN_ALG} 0 \
-					data64.key
+					new_key tun0 ${p} 1 0 ${OVPN_ALG} \
+					${OVPN_KEY_TYPE} 0 data64.key
 			done
 		else
 			peer_ns="ovpn_peer${1}"
@@ -245,7 +258,8 @@ ovpn_add_peer() {
 				tun${1} ${PEER_ID} ${TX_ID} ${LPORT} ${RADDR} \
 				${RPORT}
 			ip netns exec "${peer_ns}" ${OVPN_CLI} new_key tun${1} \
-				${PEER_ID} 1 0 ${OVPN_ALG} 1 data64.key
+				${PEER_ID} 1 0 ${OVPN_ALG} ${OVPN_KEY_TYPE} \
+				1 data64.key
 		fi
 	else
 		if [ ${1} -eq 0 ]; then
@@ -254,7 +268,8 @@ ovpn_add_peer() {
 				for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 					ip netns exec "${server_ns}" \
 						${OVPN_CLI} new_key tun0 ${p} \
-						1 0 ${OVPN_ALG} 0 data64.key
+						1 0 ${OVPN_ALG} \
+						${OVPN_KEY_TYPE} 0 data64.key
 				done
 			}) &
 			sleep 5
@@ -269,7 +284,8 @@ ovpn_add_peer() {
 				TX_ID=${1}
 			fi
 			ip netns exec "${peer_ns}" ${OVPN_CLI} connect tun${1} \
-				${PEER_ID} ${TX_ID} 10.10.${1}.1 1 data64.key
+				${PEER_ID} ${TX_ID} 10.10.${1}.1 1 \
+				${OVPN_KEY_TYPE} data64.key
 		fi
 	fi
 }
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index d40953375c86..90bfcb6d39e2 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -61,6 +61,11 @@ enum ovpn_key_direction {
 	KEY_DIR_OUT,
 };
 
+enum ovpn_key_type {
+	KEY_TYPE_DIRECT = 0,
+	KEY_TYPE_EPOCH,
+};
+
 #define KEY_LEN (256 / 8)
 #define NONCE_LEN 8
 
@@ -130,6 +135,7 @@ struct ovpn_ctx {
 	__u32 keepalive_interval;
 	__u32 keepalive_timeout;
 
+	enum ovpn_key_type key_type;
 	enum ovpn_key_direction key_dir;
 	enum ovpn_key_slot key_slot;
 	int key_id;
@@ -451,6 +457,18 @@ static int ovpn_parse_cipher(const char *cipher, struct ovpn_ctx *ctx)
 	return 0;
 }
 
+static int ovpn_parse_key_type(const char *type, struct ovpn_ctx *ctx)
+{
+	if (strcmp(type, "direct") == 0)
+		ctx->key_type = KEY_TYPE_DIRECT;
+	else if (strcmp(type, "epoch") == 0)
+		ctx->key_type = KEY_TYPE_EPOCH;
+	else
+		return -ENOTSUP;
+
+	return 0;
+}
+
 static int ovpn_parse_key_direction(const char *dir, struct ovpn_ctx *ctx)
 {
 	int in_dir;
@@ -921,9 +939,38 @@ static int ovpn_get_peer(struct ovpn_ctx *ovpn)
 	return ret;
 }
 
+static int ovpn_put_direct_key(struct nl_msg *msg, int attr, const __u8 *key,
+			       const __u8 *nonce)
+{
+	struct nlattr *key_dir;
+
+	key_dir = nla_nest_start(msg, attr);
+	NLA_PUT(msg, OVPN_A_KEYDIR_CIPHER_KEY, KEY_LEN, key);
+	NLA_PUT(msg, OVPN_A_KEYDIR_NONCE_TAIL, NONCE_LEN, nonce);
+	nla_nest_end(msg, key_dir);
+
+	return 0;
+nla_put_failure:
+	return -1;
+}
+
+static int ovpn_put_epoch_key(struct nl_msg *msg, int attr, const __u8 *key)
+{
+	struct nlattr *epoch;
+
+	epoch = nla_nest_start(msg, attr);
+	NLA_PUT(msg, OVPN_A_EPOCH_KEY, KEY_LEN, key);
+	NLA_PUT_U32(msg, OVPN_A_EPOCH_CIPHER_KEY_LEN, KEY_LEN);
+	nla_nest_end(msg, epoch);
+
+	return 0;
+nla_put_failure:
+	return -1;
+}
+
 static int ovpn_new_key(struct ovpn_ctx *ovpn)
 {
-	struct nlattr *keyconf, *key_dir;
+	struct nlattr *keyconf;
 	struct nl_ctx *ctx;
 	int ret = -1;
 
@@ -937,15 +984,37 @@ static int ovpn_new_key(struct ovpn_ctx *ovpn)
 	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_KEY_ID, ovpn->key_id);
 	NLA_PUT_U32(ctx->nl_msg, OVPN_A_KEYCONF_CIPHER_ALG, ovpn->cipher);
 
-	key_dir = nla_nest_start(ctx->nl_msg, OVPN_A_KEYCONF_ENCRYPT_DIR);
-	NLA_PUT(ctx->nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, KEY_LEN, ovpn->key_enc);
-	NLA_PUT(ctx->nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, NONCE_LEN, ovpn->nonce);
-	nla_nest_end(ctx->nl_msg, key_dir);
+	switch (ovpn->key_type) {
+	case KEY_TYPE_DIRECT:
+		ret = ovpn_put_direct_key(ctx->nl_msg,
+					  OVPN_A_KEYCONF_ENCRYPT_DIR,
+					  ovpn->key_enc, ovpn->nonce);
+		if (ret)
+			goto nla_put_failure;
 
-	key_dir = nla_nest_start(ctx->nl_msg, OVPN_A_KEYCONF_DECRYPT_DIR);
-	NLA_PUT(ctx->nl_msg, OVPN_A_KEYDIR_CIPHER_KEY, KEY_LEN, ovpn->key_dec);
-	NLA_PUT(ctx->nl_msg, OVPN_A_KEYDIR_NONCE_TAIL, NONCE_LEN, ovpn->nonce);
-	nla_nest_end(ctx->nl_msg, key_dir);
+		ret = ovpn_put_direct_key(ctx->nl_msg,
+					  OVPN_A_KEYCONF_DECRYPT_DIR,
+					  ovpn->key_dec, ovpn->nonce);
+		if (ret)
+			goto nla_put_failure;
+		break;
+	case KEY_TYPE_EPOCH:
+		ret = ovpn_put_epoch_key(ctx->nl_msg,
+					 OVPN_A_KEYCONF_ENCRYPT_EPOCH,
+					 ovpn->key_enc);
+		if (ret)
+			goto nla_put_failure;
+
+		ret = ovpn_put_epoch_key(ctx->nl_msg,
+					 OVPN_A_KEYCONF_DECRYPT_EPOCH,
+					 ovpn->key_dec);
+		if (ret)
+			goto nla_put_failure;
+		break;
+	default:
+		ret = -EINVAL;
+		goto nla_put_failure;
+	}
 
 	nla_nest_end(ctx->nl_msg, keyconf);
 
@@ -1691,7 +1760,7 @@ static void usage(const char *cmd)
 		"\tipv6: whether the socket should listen to the IPv6 wildcard address\n");
 
 	fprintf(stderr,
-		"* connect <iface> <peer_id> <tx_id> <raddr> <rport> [key_file]: start connecting peer of TCP-based VPN session\n");
+		"* connect <iface> <peer_id> <tx_id> <raddr> <rport> [key_type key_file]: start connecting peer of TCP-based VPN session\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr,
 		"\tpeer_id: peer ID found in data packets received from this peer\n");
@@ -1699,8 +1768,8 @@ static void usage(const char *cmd)
 		"\ttx_id: peer ID to be used when sending to this peer, 'none' for symmetric peer ID\n");
 	fprintf(stderr, "\traddr: peer IP address to connect to\n");
 	fprintf(stderr, "\trport: peer TCP port to connect to\n");
-	fprintf(stderr,
-		"\tkey_file: file containing the symmetric key for encryption\n");
+	fprintf(stderr, "\tkey_type: key type, supported: direct, epoch\n");
+	fprintf(stderr, "\tkey_file: file containing the pre-shared key\n");
 
 	fprintf(stderr,
 		"* new_peer <iface> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
@@ -1748,7 +1817,7 @@ static void usage(const char *cmd)
 		"\tpeer_id: peer ID of the peer to query. All peers are returned if omitted\n");
 
 	fprintf(stderr,
-		"* new_key <iface> <peer_id> <slot> <key_id> <cipher> <key_dir> <key_file>: set data channel key\n");
+		"* new_key <iface> <peer_id> <slot> <key_id> <cipher> <key_type> <key_dir> <key_file>: set data channel key\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr,
 		"\tpeer_id: peer ID of the peer to configure the key for\n");
@@ -1756,6 +1825,7 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tkey_id: an ID from 0 to 7\n");
 	fprintf(stderr,
 		"\tcipher: cipher to use, supported: aes (AES-GCM), chachapoly (CHACHA20POLY1305)\n");
+	fprintf(stderr, "\tkey_type: key type, supported: direct, epoch\n");
 	fprintf(stderr,
 		"\tkey_dir: key direction, must 0 on one host and 1 on the other\n");
 	fprintf(stderr, "\tkey_file: file containing the pre-shared key\n");
@@ -2247,12 +2317,19 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 
 		if (argc > 7) {
+			if (argc < 9)
+				return -EINVAL;
+
 			ovpn->key_slot = OVPN_KEY_SLOT_PRIMARY;
 			ovpn->key_id = 0;
 			ovpn->cipher = OVPN_CIPHER_ALG_AES_GCM;
 			ovpn->key_dir = KEY_DIR_OUT;
 
-			ret = ovpn_parse_key(argv[7], ovpn);
+			ret = ovpn_parse_key_type(argv[7], ovpn);
+			if (ret < 0)
+				return -1;
+
+			ret = ovpn_parse_key(argv[8], ovpn);
 			if (ret)
 				return -1;
 		}
@@ -2351,7 +2428,7 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 		break;
 	case CMD_NEW_KEY:
-		if (argc < 9)
+		if (argc < 10)
 			return -EINVAL;
 
 		ovpn->peer_id = strtoul(argv[3], NULL, 10);
@@ -2374,11 +2451,15 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		if (ret < 0)
 			return -1;
 
-		ret = ovpn_parse_key_direction(argv[7], ovpn);
+		ret = ovpn_parse_key_type(argv[7], ovpn);
+		if (ret < 0)
+			return -1;
+
+		ret = ovpn_parse_key_direction(argv[8], ovpn);
 		if (ret < 0)
 			return -1;
 
-		ret = ovpn_parse_key(argv[8], ovpn);
+		ret = ovpn_parse_key(argv[9], ovpn);
 		if (ret)
 			return -1;
 		break;
@@ -2442,6 +2523,7 @@ int main(int argc, char *argv[])
 	memset(&ovpn, 0, sizeof(ovpn));
 	ovpn.sa_family = AF_UNSPEC;
 	ovpn.cipher = OVPN_CIPHER_ALG_NONE;
+	ovpn.key_type = KEY_TYPE_DIRECT;
 
 	ovpn.cmd = ovpn_parse_cmd(argv[1]);
 	if (ovpn.cmd == CMD_INVALID) {
diff --git a/tools/testing/selftests/net/ovpn/test-epoch-tcp.sh b/tools/testing/selftests/net/ovpn/test-epoch-tcp.sh
new file mode 100755
index 000000000000..ec7b243d1923
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-epoch-tcp.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 OpenVPN, Inc.
+#
+#	Author:	Ralf Lici <ralf@mandelbit.com>
+#		Antonio Quartulli <antonio@openvpn.net>
+
+OVPN_KEY_TYPE="epoch"
+OVPN_PROTO="TCP"
+
+source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test-epoch.sh b/tools/testing/selftests/net/ovpn/test-epoch.sh
new file mode 100755
index 000000000000..17641dad87c4
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-epoch.sh
@@ -0,0 +1,10 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 OpenVPN, Inc.
+#
+#	Author:	Ralf Lici <ralf@mandelbit.com>
+#		Antonio Quartulli <antonio@openvpn.net>
+
+OVPN_KEY_TYPE="epoch"
+
+source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
index 7c1d56e9c525..43b4798fefde 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -43,7 +43,8 @@ ovpn_mark_prepare_network() {
 	for p in $(seq 1 3); do
 		ovpn_cmd_ok "install server key for peer ${p}" \
 			ip netns exec ovpn_peer0 "${OVPN_CLI}" new_key tun0 \
-				"${p}" 1 0 "${OVPN_ALG}" 0 data64.key
+				"${p}" 1 0 "${OVPN_ALG}" "${OVPN_KEY_TYPE}" \
+				0 data64.key
 	done
 
 	for p in $(seq 1 3); do
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032..a30842903fdb 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -67,14 +67,15 @@ ovpn_run_basic_traffic() {
 	local tcpdump_timeout="1.5s"
 
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-		# The first part of the data packet header consists of:
+		# The tcpdump filters match the cleartext data packet prefix:
 		# - TCP only: 2 bytes for the packet length
 		# - 5 bits for opcode ("9" for DATA_V2)
 		# - 3 bits for key-id ("0" at this point)
-		# - 12 bytes for peer-id:
+		# - 24 bits for peer-id:
 		#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
 		#	other way
 		#     - with symmetric ID: "${p}" both ways
+		# - epoch keys only: 2 bytes for epoch ("1" at this point)
 		header1=$(printf "0x4800000%x" ${p})
 		header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
 		raddr=""
@@ -152,11 +153,12 @@ ovpn_run_key_rollover() {
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "add secondary key on peer0 for peer ${p}" \
 			ip netns exec ovpn_peer0 ${OVPN_CLI} new_key tun0 \
-				${p} 2 1 ${OVPN_ALG} 0 data64.key
+				${p} 2 1 ${OVPN_ALG} ${OVPN_KEY_TYPE} \
+				0 data64.key
 		ovpn_cmd_ok "add secondary key on peer${p} for peer ${p}" \
 			ip netns exec "${peer_ns}" ${OVPN_CLI} new_key tun${p} \
-				$((p + OVPN_ID_OFFSET)) 2 1 ${OVPN_ALG} 1 \
-				data64.key
+				$((p + OVPN_ID_OFFSET)) 2 1 ${OVPN_ALG} \
+				${OVPN_KEY_TYPE} 1 data64.key
 		ovpn_cmd_ok "swap keys on peer${p}" \
 			ip netns exec "${peer_ns}" ${OVPN_CLI} swap_keys \
 				tun${p} $((p + OVPN_ID_OFFSET))
-- 
2.54.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
