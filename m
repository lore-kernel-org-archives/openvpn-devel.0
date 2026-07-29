Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04D7C54F55
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QTsz+spzJRkHM0UTqOWWgkhKoTIc+PEa2ysX7bD/OdE=; b=BkaFlImDG/MzCfvI9CvGpJdEsM
	wHwBRUOq5SNzplG0p01cRH2eqb090n/c9zMn6qvJ/xg7drxxZ5wKztoEIEt9qsxNMsf+2Hs2WT3uB
	OJ0qGoaUMQWwoU88360YvSWvL5kCH/x2rm+9gLPzpK1Iq7X0Oxgbu9OAtm/BYT0//Uy4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp6QV-0000HX-WF;
	Wed, 29 Jul 2026 15:42:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp6QL-0000Gw-D5
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qfyvVT5hMi7U1bEGiftz0J1aR0CmR0zSYLIzaNN656I=; b=jN5PZi1sHCAdI5dv6qMVxioZxG
 JyDBn4rsU/yqcrwCNivx2wr7of0C0kamexpQPpv+86oZyWlk3KgPjLXXzz+QHOTtAT3Y8X1w0vHmm
 RGPXH5qtiyDhVR/x/qs6ZG4syl4vFN8qc/NodXqRjubt/K3rRX/bo5dDyRISG9ERtC/c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qfyvVT5hMi7U1bEGiftz0J1aR0CmR0zSYLIzaNN656I=; b=LkGSPsLnZxFZZDp1TF+cZYutQc
 rtjJymLQJVFSerlArXc88qQopFUk/N9LhI1McFP1x3R1zjxst6o7dsmZcJqCGMetGjeuZlT7Yb6Uf
 Cm3i9pJEw22cAo22HnUfS9TsSF8KLEMK90gogW9RuQ66r82Loz/noXn6FtsOFAiLoU24=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp6QJ-0001TE-EA for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:22 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4h9GmN0flqz9tbx;
 Wed, 29 Jul 2026 17:42:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785339732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfyvVT5hMi7U1bEGiftz0J1aR0CmR0zSYLIzaNN656I=;
 b=O6HGdI8N6drObt9WZ+dYvHxrMCfswC9xpuW4DLtOkOyqVqwaNBTJRfyYDfniq240YeEFaZ
 BwU/YrcC6xEXYeoAMlE+mpVJ43hsnl5am03EV6qHmCZtQLc6U6/ag6p0519BTTR3+FRsvd
 pdnkrxpWGUIVsLbTsIUNtEff/XWMNpqCovBB3/pY5fJdzgDQpuzQVgw8lt6ywmN7XwOM5K
 hJg+WVeHpw0WPziiu0W2ruzicl1smTI5DaOBoklr9NKgEjtvFNh3/uEJbFhDsyaINBOcAt
 Q3MxCOVkCUl4JeNDbDMKr/2/sIEfGDXAePqWFyeMgYcm0We3esT/MIE3Hv7+6A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 17:37:43 +0200
Message-ID: <7b19fd9eb8d2c2a4afc4a8d102bdfeeeec8024bf.1785338921.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785338921.git.ralf@mandelbit.com>
References: <cover.1785338921.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9GmN0flqz9tbx
X-Headers-End: 1wp6QJ-0001TE-EA
Subject: [Openvpn-devel] [PATCH ovpn net 5/5] selftests: ovpn: validate peer
 VPN addresses
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

Exercise peer VPN address validation through both peer creation and
update. Check missing, unspecified, duplicate, multicast, broadcast,
loopback, IPv4-compatible and IPv4-mapped addresses.

Temporarily configure a peer with both address families to verify that
either family can be cleared while the other remains configured, then
restore the original addresses before running the existing traffic
tests.

Extend ovpn-cli peer updates with an optional VPN address and preserve
peer creation errors so the negative tests can observe rejected netlink
requests.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 tools/testing/selftests/net/ovpn/common.sh  | 13 ++++
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 54 ++++++++++-----
 tools/testing/selftests/net/ovpn/test.sh    | 75 ++++++++++++++++++++-
 3 files changed, 123 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e..5e9c81e885e6 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -136,6 +136,19 @@ ovpn_create_ns() {
 	ip netns add "ovpn_peer${1}"
 }
 
+ovpn_peer_vpn_addr() {
+	local peer="$1"
+	local file
+
+	if [ "${OVPN_PROTO}" == "UDP" ]; then
+		file="${OVPN_UDP_PEERS_FILE}"
+	else
+		file="${OVPN_TCP_PEERS_FILE}"
+	fi
+
+	awk -v peer="${peer}" '$1 == peer {print $NF; exit}' "${file}"
+}
+
 ovpn_setup_ns() {
 	local peer="ovpn_peer${1}"
 	local server_ns="ovpn_peer0"
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index f4effa7580c0..3b612a8a18fe 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -650,6 +650,26 @@ static int ovpn_connect(struct ovpn_ctx *ovpn)
 	return ret;
 }
 
+static int ovpn_nl_put_vpn_addr(struct nl_msg *msg,
+				const struct ovpn_ctx *ovpn)
+{
+	if (!ovpn->peer_ip_set)
+		return 0;
+
+	switch (ovpn->peer_ip.in4.sin_family) {
+	case AF_INET:
+		return nla_put_u32(msg, OVPN_A_PEER_VPN_IPV4,
+				   ovpn->peer_ip.in4.sin_addr.s_addr);
+	case AF_INET6:
+		return nla_put(msg, OVPN_A_PEER_VPN_IPV6,
+			       sizeof(struct in6_addr),
+			       &ovpn->peer_ip.in6.sin6_addr);
+	default:
+		fprintf(stderr, "Invalid family for peer address\n");
+		return -EAFNOSUPPORT;
+	}
+}
+
 static int ovpn_new_peer(struct ovpn_ctx *ovpn, bool is_tcp)
 {
 	struct nlattr *attr;
@@ -691,22 +711,9 @@ static int ovpn_new_peer(struct ovpn_ctx *ovpn, bool is_tcp)
 		}
 	}
 
-	if (ovpn->peer_ip_set) {
-		switch (ovpn->peer_ip.in4.sin_family) {
-		case AF_INET:
-			NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_VPN_IPV4,
-				    ovpn->peer_ip.in4.sin_addr.s_addr);
-			break;
-		case AF_INET6:
-			NLA_PUT(ctx->nl_msg, OVPN_A_PEER_VPN_IPV6,
-				sizeof(struct in6_addr),
-				&ovpn->peer_ip.in6.sin6_addr);
-			break;
-		default:
-			fprintf(stderr, "Invalid family for peer address\n");
-			goto nla_put_failure;
-		}
-	}
+	ret = ovpn_nl_put_vpn_addr(ctx->nl_msg, ovpn);
+	if (ret)
+		goto nla_put_failure;
 
 	nla_nest_end(ctx->nl_msg, attr);
 
@@ -732,6 +739,10 @@ static int ovpn_set_peer(struct ovpn_ctx *ovpn)
 		    ovpn->keepalive_interval);
 	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_KEEPALIVE_TIMEOUT,
 		    ovpn->keepalive_timeout);
+
+	ret = ovpn_nl_put_vpn_addr(ctx->nl_msg, ovpn);
+	if (ret)
+		goto nla_put_failure;
 	nla_nest_end(ctx->nl_msg, attr);
 
 	ret = ovpn_nl_msg_send(ctx, NULL);
@@ -1730,13 +1741,14 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tmark: socket FW mark value\n");
 
 	fprintf(stderr,
-		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
+		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout> [vpnaddr]: set peer attributes\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
 	fprintf(stderr,
 		"\tkeepalive_interval: interval for sending ping messages\n");
 	fprintf(stderr,
 		"\tkeepalive_timeout: time after which a peer is timed out\n");
+	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
 
 	fprintf(stderr, "* del_peer <iface> <peer_id>: delete peer\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
@@ -2090,6 +2102,8 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			return ret;
 
 		ret = ovpn_new_peer(ovpn, false);
+		if (ret < 0)
+			return ret;
 		ovpn_waitbg();
 		break;
 	case CMD_NEW_MULTI_PEER:
@@ -2331,6 +2345,12 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 				"keepalive interval value out of range\n");
 			return -1;
 		}
+
+		if (argc > 6) {
+			ret = ovpn_parse_remote(ovpn, NULL, NULL, argv[6]);
+			if (ret < 0)
+				return -1;
+		}
 		break;
 	case CMD_DEL_PEER:
 		if (argc < 4)
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032..392109d5e14e 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -56,6 +56,76 @@ ovpn_prepare_network() {
 	done
 }
 
+ovpn_new_test_peer() {
+	local peer_id="$1"
+
+	shift
+	ip netns exec ovpn_peer0 "${OVPN_CLI}" new_peer tun0 \
+		"${peer_id}" none 65000 10.10.1.2 1 "$@"
+}
+
+ovpn_set_peer_vpn_addr() {
+	ip netns exec ovpn_peer0 "${OVPN_CLI}" set_peer tun0 \
+		"$1" 60 120 "$2"
+}
+
+ovpn_run_vpn_addr_validation() {
+	local addr
+	local peer1_addr4
+	local test_peer_id=$((OVPN_NUM_PEERS + 1))
+	local test_peer_addr6="2001:db8::2"
+	# Do not include 0.0.0.0 or :: here. They are invalid on creation, but
+	# clear one address family on update and are valid if the other remains.
+	local -a invalid_addrs=(
+		"127.0.0.1"
+		"224.0.0.1"
+		"255.255.255.255"
+		"::1"
+		"::192.0.2.1"
+		"::ffff:192.0.2.1"
+		"ff02::1"
+	)
+
+	peer1_addr4=$(ovpn_peer_vpn_addr 1)
+
+	ovpn_cmd_fail "reject peer without VPN address" \
+		ovpn_new_test_peer "${test_peer_id}"
+
+	for addr in "0.0.0.0" "::" "${invalid_addrs[@]}"; do
+		ovpn_cmd_fail "reject new peer VPN address ${addr}" \
+			ovpn_new_test_peer "${test_peer_id}" "${addr}"
+	done
+
+	ovpn_cmd_fail "reject duplicate IPv4 address on peer creation" \
+		ovpn_new_test_peer "${test_peer_id}" "${peer1_addr4}"
+	ovpn_cmd_fail "reject clearing the last peer VPN address" \
+		ovpn_set_peer_vpn_addr 1 0.0.0.0
+
+	for addr in "${invalid_addrs[@]}"; do
+		ovpn_cmd_fail "reject updated peer VPN address ${addr}" \
+			ovpn_set_peer_vpn_addr 1 "${addr}"
+	done
+
+	ovpn_cmd_fail "reject duplicate IPv4 address on peer update" \
+		ovpn_set_peer_vpn_addr 2 "${peer1_addr4}"
+
+	ovpn_cmd_ok "add peer IPv6 address" \
+		ovpn_set_peer_vpn_addr 1 "${test_peer_addr6}"
+	ovpn_cmd_fail "reject duplicate IPv6 address on peer creation" \
+		ovpn_new_test_peer "${test_peer_id}" "${test_peer_addr6}"
+	ovpn_cmd_fail "reject duplicate IPv6 address on peer update" \
+		ovpn_set_peer_vpn_addr 2 "${test_peer_addr6}"
+
+	ovpn_cmd_ok "clear peer IPv4 address" \
+		ovpn_set_peer_vpn_addr 1 0.0.0.0
+	ovpn_cmd_fail "reject clearing the remaining peer IPv6 address" \
+		ovpn_set_peer_vpn_addr 1 ::
+	ovpn_cmd_ok "restore peer IPv4 address" \
+		ovpn_set_peer_vpn_addr 1 "${peer1_addr4}"
+	ovpn_cmd_ok "clear peer IPv6 address" \
+		ovpn_set_peer_vpn_addr 1 ::
+}
+
 ovpn_run_basic_traffic() {
 	local p
 	local header1
@@ -293,15 +363,16 @@ trap ovpn_stage_err ERR
 
 ktap_print_header
 if [ "${OVPN_FLOAT}" == "1" ]; then
-	ktap_set_plan 13
+	ktap_set_plan 14
 else
-	ktap_set_plan 12
+	ktap_set_plan 13
 fi
 
 ovpn_cleanup
 modprobe -q ovpn || true
 
 ovpn_run_stage "setup network topology" ovpn_prepare_network
+ovpn_run_stage "validate peer VPN addresses" ovpn_run_vpn_addr_validation
 ovpn_run_stage "run baseline data traffic" ovpn_run_basic_traffic
 ovpn_run_stage "run LAN traffic behind peer1" ovpn_run_lan_traffic
 [ "${OVPN_FLOAT}" == "1" ] && ovpn_run_stage "run floating peer checks" \
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
