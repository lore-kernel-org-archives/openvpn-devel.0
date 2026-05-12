Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DFFCD4F24
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rd8zBPfZenIL+zIKJerAQyrOxECcLIvoQoGQEdWPHus=; b=KMvNo6wYqrVoe6RrhTstpoYjLl
	RDywXWGu9mLfzC+TfH5c0w0eshqcPJYai1Lt6nQtNPhmLxSInyPIslnB7kWtHKX2o40IN/J9THyvH
	0hu/XLip0+Ic5Lo4kiPuFKh6QG4oUKEi0DkDmgImFItIoNqyO3CZE/Lz9mbTLFKFK12E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMoMD-0006Cm-0f;
	Tue, 12 May 2026 14:45:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wMoMB-0006Cb-2l
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 14:45:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F1aC4kiyLPhJt1em6RAH8o2ggwVTWNSAxQVCNApHTkM=; b=FKzc2LuhYFwcY817zcDAzWoZuL
 o6a1rLtGAxWEzr7qq0gLqT7CqT3CG893E7RqGgF72P3HqmLV3uhYpX9HfFrcWBqUe2smn/hbvCz+i
 rAIUxZLUCu6gl8l2MyObzB3CYjpn1erep5czfYxCaIc88dZ43JN+ihpC5G1INQwNSZII=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F1aC4kiyLPhJt1em6RAH8o2ggwVTWNSAxQVCNApHTkM=; b=ZLfO77D7JxjMKrEi9IB2VcW29G
 AutjYt1E+pwZlA3LE/4W0stNDRtcj/sIfcTPt3HOHt9Kz2BtkNz9F2gN6jF1KtYy2gt7Om7rbuAgo
 13wpfCC+9WcescU6lvsS3cFgRriyHZ0zSdndULfUNgV+uE4JWnTWIY9IKrMZR9qSEhgU=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMoM3-0007Ia-UY for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 14:45:07 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gFKBC4LRpz9vFj;
 Tue, 12 May 2026 16:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778597091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1aC4kiyLPhJt1em6RAH8o2ggwVTWNSAxQVCNApHTkM=;
 b=ObTxKBi6lmFsaOPk6go6AjtkJh1tYONpxw13Im/tzSHPocR2fJW4hznc1m3BlJM6IDNUG8
 8drLUHHdzveFVVOGqgMJpsE1p61ljPMyhkfp+dKMSTzRJnEGHYULElNrNtLbf9fOxiaKtb
 rKk77QdQUPmEDrcREATNSOSTWVb46oxn4hS5xDbE37nroiI5tTFrkQxKUQwYu8mJfgP45i
 kIPn5wpqXJGDzoqzEq/fscaSEcHqaJLJA/v5zEUTODQAysDaPpUspb/SYzOXnBUDSguzBM
 LnCaeXfwXSKl3GJwg1oBJblraXa864vMyOoxWgdeRLdnYot+pxJBh/EA9O0lcA==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 12 May 2026 16:43:55 +0200
Message-ID: <20260512144358.419599-2-a@unstable.cc>
In-Reply-To: <20260512144358.419599-1-a@unstable.cc>
References: <20260512144358.419599-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wMoM3-0007Ia-UY
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/5] selftests: ovpn: add test
 for bound device
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
Cc: Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Ralf Lici <ralf@mandelbit.com>

Add a selftest to verify that when a UDP socket is bound to a device,
ovpn traffic is transmitted and received only through the bound
interface.

The test sets up a P2P session between two peers in separate network
namespaces connected by two veth pairs. It binds each side to both veth
interfaces in turn and uses tcpdump to verify the selected underlay
path.

It also checks negative cases where the route-selected egress device or
the ingress device does not match the configured bind device, ensuring
that mismatched traffic does not complete the tunnel exchange.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile     |   1 +
 tools/testing/selftests/net/ovpn/common.sh    |  13 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   |  49 ++-
 tools/testing/selftests/net/ovpn/test-bind.sh | 281 ++++++++++++++++++
 tools/testing/selftests/net/ovpn/test-mark.sh |   4 +-
 5 files changed, 324 insertions(+), 24 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-bind.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index 169f0464ac3a..5c70cac0a95b 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -33,6 +33,7 @@ TEST_FILES = \
 # end of TEST_FILES
 
 TEST_PROGS := \
+	test-bind.sh \
 	test-chachapoly.sh \
 	test-close-socket-tcp.sh \
 	test-close-socket.sh \
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e..06ce298b6e0e 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -213,12 +213,13 @@ ovpn_add_peer() {
 	local peer_ns
 	local server_ns="ovpn_peer0"
 	M_ID=${labels[OVPN_SYMMETRIC_ID]}
+	local dev=${2:-"any"}
 
 	if [ "${OVPN_PROTO}" == "UDP" ]; then
 		if [ ${1} -eq 0 ]; then
-			ip netns exec "${server_ns}" ${OVPN_CLI} \
-				new_multi_peer tun0 1 ${M_ID} \
-				${OVPN_UDP_PEERS_FILE}
+			ip netns exec "${server_ns}" "${OVPN_CLI}" \
+				new_multi_peer tun0 "${dev}" 1 "${M_ID}" \
+				"${OVPN_UDP_PEERS_FILE}"
 
 			for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 				ip netns exec "${server_ns}" ${OVPN_CLI} \
@@ -241,9 +242,9 @@ ovpn_add_peer() {
 				${OVPN_UDP_PEERS_FILE})
 			LPORT=$(awk "NR == ${1} {print \$6}" \
 				${OVPN_UDP_PEERS_FILE})
-			ip netns exec "${peer_ns}" ${OVPN_CLI} new_peer \
-				tun${1} ${PEER_ID} ${TX_ID} ${LPORT} ${RADDR} \
-				${RPORT}
+			ip netns exec "${peer_ns}" "${OVPN_CLI}" new_peer \
+				tun"${1}" "${dev}" "${PEER_ID}" "${TX_ID}" \
+				"${LPORT}" "${RADDR}" "${RPORT}"
 			ip netns exec "${peer_ns}" ${OVPN_CLI} new_key tun${1} \
 				${PEER_ID} 1 0 ${OVPN_ALG} 1 data64.key
 		fi
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index d40953375c86..312822c27909 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -136,6 +136,7 @@ struct ovpn_ctx {
 
 	uint32_t mark;
 	bool asymm_id;
+	const char *bind_dev;
 
 	const char *peers_file;
 };
@@ -543,6 +544,14 @@ static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 		}
 	}
 
+	if (ctx->bind_dev) {
+		if (setsockopt(s, SOL_SOCKET, SO_BINDTODEVICE, ctx->bind_dev,
+			       strlen(ctx->bind_dev) + 1) != 0) {
+			perror("setsockopt for SO_BINDTODEVICE");
+			return -1;
+		}
+	}
+
 	ret = bind(s, (struct sockaddr *)&local_sock, sock_len);
 	if (ret < 0) {
 		perror("cannot bind socket");
@@ -1703,8 +1712,10 @@ static void usage(const char *cmd)
 		"\tkey_file: file containing the symmetric key for encryption\n");
 
 	fprintf(stderr,
-		"* new_peer <iface> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
+		"* new_peer <iface> <dev> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr,
+		"\tdev: transport interface name to bind to, supports 'any'\n");
 	fprintf(stderr,
 		"\tpeer_id: peer ID found in data packets received from this peer\n");
 	fprintf(stderr,
@@ -1715,8 +1726,10 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
 
 	fprintf(stderr,
-		"* new_multi_peer <iface> <lport> <id_type> <peers_file> [mark]: add multiple peers as listed in the file\n");
+		"* new_multi_peer <iface> <dev> <lport> <id_type> <peers_file> [mark]: add multiple peers as listed in the file\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
+	fprintf(stderr,
+		"\tdev: transport interface name to bind to, supports 'any'\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr, "\tid_type:\n");
 	fprintf(stderr,
@@ -2258,48 +2271,52 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 		break;
 	case CMD_NEW_PEER:
-		if (argc < 8)
+		if (argc < 9)
 			return -EINVAL;
 
-		ovpn->asymm_id = strcmp(argv[4], "none");
+		ovpn->bind_dev = strcmp(argv[3], "any") == 0 ? NULL : argv[3];
 
-		ovpn->lport = strtoul(argv[5], NULL, 10);
+		ovpn->asymm_id = strcmp(argv[5], "none");
+
+		ovpn->lport = strtoul(argv[6], NULL, 10);
 		if (errno == ERANGE || ovpn->lport > 65535) {
 			fprintf(stderr, "lport value out of range\n");
 			return -1;
 		}
 
-		const char *vpnip = (argc > 8) ? argv[8] : NULL;
+		const char *vpnip = (argc > 9) ? argv[9] : NULL;
 
-		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[6],
-					  argv[7], vpnip);
+		ret = ovpn_parse_new_peer(ovpn, argv[4], argv[5], argv[7],
+					  argv[8], vpnip);
 		if (ret < 0)
 			return -1;
 		break;
 	case CMD_NEW_MULTI_PEER:
-		if (argc < 6)
+		if (argc < 7)
 			return -EINVAL;
 
-		ovpn->lport = strtoul(argv[3], NULL, 10);
+		ovpn->bind_dev = strcmp(argv[3], "any") == 0 ? NULL : argv[3];
+
+		ovpn->lport = strtoul(argv[4], NULL, 10);
 		if (errno == ERANGE || ovpn->lport > 65535) {
 			fprintf(stderr, "lport value out of range\n");
 			return -1;
 		}
 
-		if (!strcmp(argv[4], "SYMM")) {
+		if (!strcmp(argv[5], "SYMM")) {
 			ovpn->asymm_id = false;
-		} else if (!strcmp(argv[4], "ASYMM")) {
+		} else if (!strcmp(argv[5], "ASYMM")) {
 			ovpn->asymm_id = true;
 		} else {
-			fprintf(stderr, "Cannot parse id type: %s\n", argv[4]);
+			fprintf(stderr, "Cannot parse id type: %s\n", argv[5]);
 			return -1;
 		}
 
-		ovpn->peers_file = argv[5];
+		ovpn->peers_file = argv[6];
 
 		ovpn->mark = 0;
-		if (argc > 6) {
-			ovpn->mark = strtoul(argv[6], NULL, 10);
+		if (argc > 7) {
+			ovpn->mark = strtoul(argv[7], NULL, 10);
 			if (errno == ERANGE || ovpn->mark > UINT32_MAX) {
 				fprintf(stderr, "mark value out of range\n");
 				return -1;
diff --git a/tools/testing/selftests/net/ovpn/test-bind.sh b/tools/testing/selftests/net/ovpn/test-bind.sh
new file mode 100755
index 000000000000..bc0b8a0b4373
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-bind.sh
@@ -0,0 +1,281 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2025 OpenVPN, Inc.
+#
+#	Author:	Antonio Quartulli <antonio@openvpn.net>
+#		Ralf Lici <ralf@mandelbit.com>
+
+#set -x
+# shellcheck disable=SC2329
+set -eE
+
+OVPN_PROTO=UDP
+
+source ./common.sh
+
+ovpn_test_finished=0
+declare -a OVPN_BIND_TCPDUMP_PIDS=()
+
+ovpn_test_exit() {
+	local pid
+
+	for pid in "${OVPN_BIND_TCPDUMP_PIDS[@]}"; do
+		kill -TERM "${pid}" 2>/dev/null || true
+		wait "${pid}" 2>/dev/null || true
+	done
+	OVPN_BIND_TCPDUMP_PIDS=()
+
+	ovpn_cleanup
+	modprobe -r ovpn || true
+
+	if [ "${ovpn_test_finished}" -eq 0 ]; then
+		ktap_print_totals
+	fi
+}
+
+ovpn_bind_prepare_network() {
+	ovpn_cmd_ok "create namespace peer1" ip netns add ovpn_peer1
+	ovpn_cmd_ok "create namespace peer2" ip netns add ovpn_peer2
+
+	ovpn_cmd_ok "create first underlay link" \
+		ip link add veth1 netns ovpn_peer1 type veth peer name \
+			veth1 netns ovpn_peer2
+	ovpn_cmd_ok "create second underlay link" \
+		ip link add veth2 netns ovpn_peer1 type veth peer name \
+			veth2 netns ovpn_peer2
+
+	ovpn_cmd_ok "configure peer1 first underlay address" \
+		ip -n ovpn_peer1 addr add 10.10.10.1/24 dev veth1
+	ovpn_cmd_ok "bring up peer1 first underlay link" \
+		ip -n ovpn_peer1 link set veth1 up
+	ovpn_cmd_ok "configure peer1 second underlay address" \
+		ip -n ovpn_peer1 addr add 20.20.20.1/24 dev veth2
+	ovpn_cmd_ok "bring up peer1 second underlay link" \
+		ip -n ovpn_peer1 link set veth2 up
+
+	ovpn_cmd_ok "configure peer2 first underlay address" \
+		ip -n ovpn_peer2 addr add 10.10.10.2/24 dev veth1
+	ovpn_cmd_ok "bring up peer2 first underlay link" \
+		ip -n ovpn_peer2 link set veth1 up
+	ovpn_cmd_ok "configure peer2 second underlay address" \
+		ip -n ovpn_peer2 addr add 20.20.20.2/24 dev veth2
+	ovpn_cmd_ok "bring up peer2 second underlay link" \
+		ip -n ovpn_peer2 link set veth2 up
+
+	# Some test cases intentionally bind peer1 to a device that does not
+	# match the route-selected underlay, so allow asymmetric underlay paths.
+	ovpn_cmd_ok "disable peer1 global rp_filter" \
+		ip netns exec ovpn_peer1 sysctl -w \
+			net.ipv4.conf.all.rp_filter=0
+	ovpn_cmd_ok "disable peer1 veth1 rp_filter" \
+		ip netns exec ovpn_peer1 sysctl -w \
+			net.ipv4.conf.veth1.rp_filter=0
+	ovpn_cmd_ok "disable peer1 veth2 rp_filter" \
+		ip netns exec ovpn_peer1 sysctl -w \
+			net.ipv4.conf.veth2.rp_filter=0
+
+	# Keep peer2 from answering ARP for one underlay address on the other
+	# underlay device; mismatch cases rely on the two L2 paths staying
+	# distinct.
+	ovpn_cmd_ok "enable peer2 strict global ARP replies" \
+		ip netns exec ovpn_peer2 sysctl -w \
+			net.ipv4.conf.all.arp_ignore=1
+	ovpn_cmd_ok "enable peer2 strict veth1 ARP replies" \
+		ip netns exec ovpn_peer2 sysctl -w \
+			net.ipv4.conf.veth1.arp_ignore=1
+	ovpn_cmd_ok "enable peer2 strict veth2 ARP replies" \
+		ip netns exec ovpn_peer2 sysctl -w \
+			net.ipv4.conf.veth2.arp_ignore=1
+
+	ovpn_cmd_ok "create peer1 ovpn interface" \
+		ip netns exec ovpn_peer1 "${OVPN_CLI}" new_iface tun1 P2P
+	ovpn_cmd_ok "create peer2 ovpn interface" \
+		ip netns exec ovpn_peer2 "${OVPN_CLI}" new_iface tun2 P2P
+
+	ovpn_cmd_ok "configure peer1 ovpn address" \
+		ip -n ovpn_peer1 addr add 5.5.5.1 dev tun1
+	ovpn_cmd_ok "start peer1 ovpn interface" \
+		ip -n ovpn_peer1 link set tun1 up
+	ovpn_cmd_ok "configure peer2 ovpn address" \
+		ip -n ovpn_peer2 addr add 5.5.5.2 dev tun2
+	ovpn_cmd_ok "start peer2 ovpn interface" \
+		ip -n ovpn_peer2 link set tun2 up
+
+	ovpn_cmd_ok "install peer1 ovpn route" \
+		ip -n ovpn_peer1 route add 5.5.5.0/24 dev tun1
+	ovpn_cmd_ok "install peer2 ovpn route" \
+		ip -n ovpn_peer2 route add 5.5.5.0/24 dev tun2
+}
+
+ovpn_bind_configure_peers() {
+	local dev1="$1"
+	local dev2="$2"
+	local raddr4_peer1="$3"
+	local raddr4_peer2="$4"
+
+	ip netns exec ovpn_peer1 "${OVPN_CLI}" del_peer tun1 1 \
+		>/dev/null 2>&1 || true
+	ip netns exec ovpn_peer2 "${OVPN_CLI}" del_peer tun2 10 \
+		>/dev/null 2>&1 || true
+
+	# Close any active userspace socket before installing a new peer pair.
+	killall "$(basename "${OVPN_CLI}")" 2>/dev/null || true
+
+	ovpn_cmd_ok "create peer1 bound peer on ${dev1}" \
+		ip netns exec ovpn_peer1 "${OVPN_CLI}" new_peer tun1 \
+			"${dev1}" 1 10 1 "${raddr4_peer1}" 1
+	ovpn_cmd_ok "install peer1 key" \
+		ip netns exec ovpn_peer1 "${OVPN_CLI}" new_key tun1 1 1 0 \
+			"${OVPN_ALG}" 0 data64.key
+	ovpn_cmd_ok "create peer2 bound peer on ${dev2}" \
+		ip netns exec ovpn_peer2 "${OVPN_CLI}" new_peer tun2 \
+			"${dev2}" 10 1 1 "${raddr4_peer2}" 1
+	ovpn_cmd_ok "install peer2 key" \
+		ip netns exec ovpn_peer2 "${OVPN_CLI}" new_key tun2 10 1 0 \
+			"${OVPN_ALG}" 1 data64.key
+
+	ovpn_cmd_ok "set peer1 timeout" \
+		ip netns exec ovpn_peer1 "${OVPN_CLI}" set_peer tun1 1 60 120
+	ovpn_cmd_ok "set peer2 timeout" \
+		ip netns exec ovpn_peer2 "${OVPN_CLI}" set_peer tun2 10 60 120
+}
+
+ovpn_bind_start_capture() {
+	local dev="$1"
+	local count="$2"
+	local filter="$3"
+	local pid
+	local tcpdump_timeout="2s"
+
+	ovpn_run_bg pid timeout "${tcpdump_timeout}" \
+		ip netns exec ovpn_peer1 tcpdump --immediate-mode -p -ni \
+			"${dev}" -c "${count}" "${filter}" -n -q
+	OVPN_BIND_TCPDUMP_PIDS+=("${pid}")
+}
+
+ovpn_bind_run_positive_case() {
+	local dev1="$1"
+	local dev2="$2"
+	local raddr4_peer1="$3"
+	local raddr4_peer2="$4"
+	local expected_dev="$5"
+	local unexpected_dev="$6"
+	local filter
+	local header1="0x48000001"
+	local header2="0x4800000a"
+	local ping_start_delay="0.3"
+
+	ovpn_bind_configure_peers "${dev1}" "${dev2}" "${raddr4_peer1}" \
+		"${raddr4_peer2}"
+	filter="$(printf '(%s) or (%s)' \
+		"$(ovpn_build_capture_filter "${header1}" "${raddr4_peer1}")" \
+		"$(ovpn_build_capture_filter "${header2}" "${raddr4_peer2}")")"
+
+	# The expected device must carry matching ovpn data packets.
+	ovpn_bind_start_capture "${expected_dev}" 1 "${filter}"
+
+	# The unexpected device must not carry even one matching data packet.
+	ovpn_bind_start_capture "${unexpected_dev}" 1 "${filter}"
+
+	sleep "${ping_start_delay}"
+	ovpn_cmd_ok "send tunnel traffic from peer1 to peer2" \
+		ip netns exec ovpn_peer1 ping -qfc 10 -w 3 5.5.5.2
+
+	# Reaching -c is success for the expected capture and failure for the
+	# unexpected one; timeout means the opposite.
+	ovpn_cmd_ok "capture packets on ${expected_dev}" \
+		wait "${OVPN_BIND_TCPDUMP_PIDS[0]}"
+	OVPN_BIND_TCPDUMP_PIDS=("${OVPN_BIND_TCPDUMP_PIDS[@]:1}")
+
+	ovpn_cmd_fail "capture packets on ${unexpected_dev}" \
+		wait "${OVPN_BIND_TCPDUMP_PIDS[0]}"
+	OVPN_BIND_TCPDUMP_PIDS=("${OVPN_BIND_TCPDUMP_PIDS[@]:1}")
+}
+
+ovpn_bind_run_sender_negative_case() {
+	local dev1="$1"
+	local raddr4_peer1="$2"
+	local raddr4_peer2="$3"
+	local unexpected_dev="$4"
+	local filter
+	local header="0x4800000a"
+	local ping_start_delay="0.3"
+
+	ovpn_bind_configure_peers "${dev1}" any "${raddr4_peer1}" \
+		"${raddr4_peer2}"
+	filter="$(ovpn_build_capture_filter "${header}" "${raddr4_peer1}")"
+
+	# The route-selected device must not carry peer1 egress data when
+	# peer1 is bound to the other underlay device.
+	ovpn_bind_start_capture "${unexpected_dev}" 1 "${filter}"
+
+	sleep "${ping_start_delay}"
+	ovpn_cmd_fail "fail tunnel traffic with mismatched peer1 bind_dev" \
+		ip netns exec ovpn_peer1 ping -qfc 10 -w 3 5.5.5.2
+	ovpn_cmd_fail "capture packets on ${unexpected_dev}" \
+		wait "${OVPN_BIND_TCPDUMP_PIDS[0]}"
+	OVPN_BIND_TCPDUMP_PIDS=("${OVPN_BIND_TCPDUMP_PIDS[@]:1}")
+}
+
+ovpn_bind_run_receiver_negative_case() {
+	local dev2="$1"
+	local raddr4_peer1="$2"
+	local raddr4_peer2="$3"
+	local capture_dev="$4"
+	local filter
+	local header="0x4800000a"
+	local ping_start_delay="0.3"
+
+	ovpn_bind_configure_peers any "${dev2}" "${raddr4_peer1}" \
+		"${raddr4_peer2}"
+	filter="$(ovpn_build_capture_filter "${header}" "${raddr4_peer1}")"
+
+	# The mismatched ingress device should carry peer1 data packets, but
+	# the receiver-side bind mismatch must prevent ping replies.
+	ovpn_bind_start_capture "${capture_dev}" 1 "${filter}"
+
+	sleep "${ping_start_delay}"
+	ovpn_cmd_fail "fail tunnel traffic with mismatched peer2 bind_dev" \
+		ip netns exec ovpn_peer1 ping -qfc 10 -w 3 5.5.5.2
+	ovpn_cmd_ok "capture mismatched ingress on ${capture_dev}" \
+		wait "${OVPN_BIND_TCPDUMP_PIDS[0]}"
+	OVPN_BIND_TCPDUMP_PIDS=("${OVPN_BIND_TCPDUMP_PIDS[@]:1}")
+}
+
+trap ovpn_test_exit EXIT
+trap ovpn_stage_err ERR
+
+ktap_print_header
+ktap_set_plan 9
+
+ovpn_cleanup
+modprobe -q ovpn || true
+
+ovpn_run_stage "setup network topology" ovpn_bind_prepare_network
+ovpn_run_stage "peer1 bind_dev=veth1 routes over veth1" \
+	ovpn_bind_run_positive_case \
+	veth1 any 10.10.10.2 10.10.10.1 veth1 veth2
+ovpn_run_stage "peer1 bind_dev=veth2 routes over veth2" \
+	ovpn_bind_run_positive_case \
+	veth2 any 20.20.20.2 20.20.20.1 veth2 veth1
+ovpn_run_stage "peer2 bind_dev=veth1 replies over veth1" \
+	ovpn_bind_run_positive_case \
+	any veth1 10.10.10.2 10.10.10.1 veth1 veth2
+ovpn_run_stage "peer2 bind_dev=veth2 replies over veth2" \
+	ovpn_bind_run_positive_case \
+	any veth2 20.20.20.2 20.20.20.1 veth2 veth1
+ovpn_run_stage "peer1 bind_dev=veth1 blocks veth2 egress" \
+	ovpn_bind_run_sender_negative_case \
+	veth1 20.20.20.2 20.20.20.1 veth2
+ovpn_run_stage "peer1 bind_dev=veth2 blocks veth1 egress" \
+	ovpn_bind_run_sender_negative_case \
+	veth2 10.10.10.2 10.10.10.1 veth1
+ovpn_run_stage "peer2 bind_dev=veth1 rejects veth2 ingress" \
+	ovpn_bind_run_receiver_negative_case \
+	veth1 20.20.20.2 20.20.20.1 veth2
+ovpn_run_stage "peer2 bind_dev=veth2 rejects veth1 ingress" \
+	ovpn_bind_run_receiver_negative_case \
+	veth2 10.10.10.2 10.10.10.1 veth1
+
+ovpn_test_finished=1
+ktap_finished
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
index 5a8f47554286..010f5b44dbf4 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -38,8 +38,8 @@ ovpn_mark_prepare_network() {
 	done
 
 	ovpn_cmd_ok "create server-side multi-peer with fwmark" \
-		ip netns exec ovpn_peer0 "${OVPN_CLI}" new_multi_peer tun0 1 \
-			ASYMM "${OVPN_UDP_PEERS_FILE}" "${MARK}"
+		ip netns exec ovpn_peer0 "${OVPN_CLI}" new_multi_peer tun0 \
+			any 1 ASYMM "${OVPN_UDP_PEERS_FILE}" "${MARK}"
 	for p in $(seq 1 3); do
 		ovpn_cmd_ok "install server key for peer ${p}" \
 			ip netns exec ovpn_peer0 "${OVPN_CLI}" new_key tun0 \
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
