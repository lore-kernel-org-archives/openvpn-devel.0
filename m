Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6D1CA600D
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jnuYKOKj3+Kqkcz69C3QyS2BJnE2LIHxjj6tX1iBeNs=; b=SMsNafPtl1Q2uZuUK40thLBLi6
	KOIOmhSe3LfBJJgqXGS5xscYPF5ooZslx8jA/o+UD5N/ddU3FdFXHik/hvlEmK8CroZH5IHc573sX
	eL56THV9lXrv55HjpPVzI6lx3TPLq6ChtsF7bIKQlwEXdUR5qK6811+QjYPn4zCkFCag=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEr6m-0000Uw-VQ;
	Thu, 08 Oct 2026 16:36:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1xEr6G-0000St-Ro
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 16:36:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q8DQ6WWQuSZC2fsUjgX/pRp5v0uWU0/nFKcHvlGeXHM=; b=GdOAJbx9YTjUuGH5Vib6xhrP5Y
 aW9nbOcMnEkxviBA4L/zMxhFfR7f+WRwob/l1013eaiOtTmg/b4Z0zwSomkUT/Nd+40oA7ExlRgoE
 j+jPNmI6zbX2sxbm9HBnhf1GhfzzVyRknuIpRtOdTu60+jsl3gfmoe9P0F8xIGPC+p3w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q8DQ6WWQuSZC2fsUjgX/pRp5v0uWU0/nFKcHvlGeXHM=; b=Z
 FTFuuzGzJXbKtcamhg9aYYCYQR2MAeyUK/4rpI7dFiXkZACQEcHAqb2H3kuMFIDOPT8YkOK/U7Enj
 U1KmzqGlj7nkhZHW6d5ngGGzzr5DT11D1VoXmvAte3ekTVHY0PY5Df7x8O4g8Unk+i99ljzQiwjYP
 UchlILq6eA7RuXAU=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEr6E-0004hr-Tg for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 16:36:09 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4j0wbf6q7SzKnW9;
 Thu, 08 Oct 2026 18:35:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1791477359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=q8DQ6WWQuSZC2fsUjgX/pRp5v0uWU0/nFKcHvlGeXHM=;
 b=Yx4tshJK2vysIH3tVp5m+5WhnTkHZgKOycL+mRoue13PZSy6RkY5m8Ug/pnxVrvetl/KQ7
 c1scb2TOI3tORC1TdSx0MVj/hBNQvDciufw8/J+sARRUcd85Sogxm621SaT9SfM6YOR64O
 cf7fmKXdybNEb/w6JAUBOpSUH6BWJtpYt84973JKzqIUewK/wCbQGnyVpybdYrPXba58Xl
 163PIctOvo132QP704zcxmfF7eeq1I7D/WUrMooC/vv+Zd52DWsxonNhcVpM/u3VJTC2cR
 X2EXyRnjycKMz4lfZfrw1wE8nD5J6FE7AcNAz1Lho8REZQdmSJ14WmzH1hrHIA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  8 Oct 2026 18:35:55 +0200
Message-ID: <20261008163555.606120-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4j0wbf6q7SzKnW9
X-Headers-End: 1xEr6E-0004hr-Tg
Subject: [Openvpn-devel] [PATCH ovpn net-next v2] selftests: ovpn: enable
 TCP_NODELAY on TCP sockets
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

Since OpenVPN 2.7.6, openvpn unconditionally sets TCP_NODELAY
on its TCP sockets. Do the same in ovpn-cli so the TCP
selftests match that configuration.

Allow OVPN_TCP_NODELAY=0 to keep Nagle enabled for testing sockets used
by older OpenVPN configurations. Add a TCP test variant with Nagle
enabled so the standard selftest suite exercises both settings.

The TCP peer ID capture assumes that every TCP segment starts with an
ovpn length prefix followed by a data header. TCP does not preserve
record boundaries, and enabling TCP_NODELAY makes this check unreliable.
Restrict the capture-based peer ID check to UDP.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---

Changes in v2:
 - Allow ovpn-cli to use Nagle's algorithm through the OVPN_TCP_NODELAY=0
   environment variable.
 - Add test-tcp-nagle.sh to the selftests

 tools/testing/selftests/net/ovpn/Makefile     |  1 +
 tools/testing/selftests/net/ovpn/common.sh    | 22 ++++----
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 28 ++++++++++
 .../selftests/net/ovpn/test-tcp-nagle.sh      | 11 ++++
 tools/testing/selftests/net/ovpn/test.sh      | 54 +++++++++----------
 5 files changed, 76 insertions(+), 40 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-tcp-nagle.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index 169f0464ac3a..35e4c9d4fc68 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -42,6 +42,7 @@ TEST_PROGS := \
 	test-symmetric-id-float.sh \
 	test-symmetric-id-tcp.sh \
 	test-symmetric-id.sh \
+	test-tcp-nagle.sh \
 	test-tcp.sh \
 	test.sh \
 # end of TEST_PROGS
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e..290d6589e027 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -17,6 +17,8 @@ OVPN_FLOAT=${OVPN_FLOAT:-0}
 OVPN_SYMMETRIC_ID=${OVPN_SYMMETRIC_ID:-0}
 OVPN_VERBOSE=${OVPN_VERBOSE:-0}
 
+# Set to 0 to exercise TCP sockets with Nagle enabled.
+export OVPN_TCP_NODELAY=${OVPN_TCP_NODELAY:-1}
 export OVPN_ID_OFFSET=$(( 9 * (OVPN_SYMMETRIC_ID == 0) ))
 
 OVPN_JQ_FILTER='map(if type == "array" then .[] else . end) |
@@ -178,20 +180,14 @@ ovpn_setup_ns() {
 
 ovpn_build_capture_filter() {
 	# match the first four bytes of the openvpn data payload
-	if [ "${OVPN_PROTO}" == "UDP" ]; then
-		# For UDP, libpcap transport indexing only works for IPv4, so
-		# use an explicit IPv4 or IPv6 expression based on the peer
-		# address. The IPv6 branch assumes there are no extension
-		# headers in the outer packet.
-		if [[ "${2}" == *:* ]]; then
-			printf "ip6 and ip6[6] = 17 and ip6[48:4] = %s" "${1}"
-		else
-			printf "ip and udp[8:4] = %s" "${1}"
-		fi
+	# For UDP, libpcap transport indexing only works for IPv4, so
+	# use an explicit IPv4 or IPv6 expression based on the peer
+	# address. The IPv6 branch assumes there are no extension
+	# headers in the outer packet.
+	if [[ "${2}" == *:* ]]; then
+		printf "ip6 and ip6[6] = 17 and ip6[48:4] = %s" "${1}"
 	else
-		# openvpn over TCP prepends a 2-byte packet length ahead of the
-		# DATA_V2 opcode, so skip it before matching the payload header
-		printf "ip and tcp[(((tcp[12] & 0xf0) >> 2) + 2):4] = %s" "${1}"
+		printf "ip and udp[8:4] = %s" "${1}"
 	fi
 }
 
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index f4effa7580c0..30e49d1a5783 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -470,6 +470,22 @@ static int ovpn_parse_key_direction(const char *dir, struct ovpn_ctx *ctx)
 	return 0;
 }
 
+static int ovpn_tcp_nodelay(int socket)
+{
+	const char *nodelay = getenv("OVPN_TCP_NODELAY");
+	int opt = 1;
+	int ret;
+
+	if (nodelay && !strcmp(nodelay, "0"))
+		opt = 0;
+
+	ret = setsockopt(socket, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
+	if (ret < 0)
+		perror("setsockopt for TCP_NODELAY");
+
+	return ret;
+}
+
 static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 {
 	struct sockaddr_storage local_sock = { 0 };
@@ -606,6 +622,12 @@ static int ovpn_accept(struct ovpn_ctx *ctx)
 		goto err;
 	}
 
+	if (ovpn_tcp_nodelay(ret) < 0) {
+		close(ret);
+		ret = -1;
+		goto err;
+	}
+
 	return ret;
 err:
 	close(ctx->socket);
@@ -623,6 +645,10 @@ static int ovpn_connect(struct ovpn_ctx *ovpn)
 		return -1;
 	}
 
+	ret = ovpn_tcp_nodelay(s);
+	if (ret < 0)
+		goto err;
+
 	switch (ovpn->remote.in4.sin_family) {
 	case AF_INET:
 		socklen = sizeof(struct sockaddr_in);
@@ -1779,6 +1805,8 @@ static void usage(const char *cmd)
 
 	fprintf(stderr,
 		"* listen_mcast: listen to ovpn netlink multicast messages\n");
+	fprintf(stderr,
+		"\nEnvironment: OVPN_TCP_NODELAY=0 enables Nagle for listen/connect (default: 1)\n");
 }
 
 static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
diff --git a/tools/testing/selftests/net/ovpn/test-tcp-nagle.sh b/tools/testing/selftests/net/ovpn/test-tcp-nagle.sh
new file mode 100755
index 000000000000..e603181dc2ba
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-tcp-nagle.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2026 OpenVPN, Inc.
+#
+#	Author: Marco Baffo <marco@mandelbit.com>
+#
+
+OVPN_PROTO="TCP"
+OVPN_TCP_NODELAY=0
+
+source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032..d744c1a97d5f 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -67,35 +67,33 @@ ovpn_run_basic_traffic() {
 	local tcpdump_timeout="1.5s"
 
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-		# The first part of the data packet header consists of:
-		# - TCP only: 2 bytes for the packet length
-		# - 5 bits for opcode ("9" for DATA_V2)
-		# - 3 bits for key-id ("0" at this point)
-		# - 12 bytes for peer-id:
-		#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
-		#	other way
-		#     - with symmetric ID: "${p}" both ways
-		header1=$(printf "0x4800000%x" ${p})
-		header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
-		raddr=""
 		if [ "${OVPN_PROTO}" == "UDP" ]; then
+			# The first part of the data packet header consists of:
+			# - 5 bits for opcode ("9" for DATA_V2)
+			# - 3 bits for key-id ("0" at this point)
+			# - 3 bytes for peer-id:
+			#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
+			#	other way
+			#     - with symmetric ID: "${p}" both ways
+			header1=$(printf "0x4800000%x" ${p})
+			header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
 			raddr=$(awk "NR == ${p} {print \$3}" \
 				"${OVPN_UDP_PEERS_FILE}")
+			peer_ns="ovpn_peer${p}"
+
+			timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
+				tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+				"$(ovpn_build_capture_filter "${header1}" "${raddr}")" \
+				>/dev/null 2>&1 &
+			tcpdump_pid1=$!
+			timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
+				tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+				"$(ovpn_build_capture_filter "${header2}" "${raddr}")" \
+				>/dev/null 2>&1 &
+			tcpdump_pid2=$!
+
+			sleep 0.3
 		fi
-		peer_ns="ovpn_peer${p}"
-
-		timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
-			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-			"$(ovpn_build_capture_filter "${header1}" "${raddr}")" \
-			>/dev/null 2>&1 &
-		tcpdump_pid1=$!
-		timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
-			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-			"$(ovpn_build_capture_filter "${header2}" "${raddr}")" \
-			>/dev/null 2>&1 &
-		tcpdump_pid2=$!
-
-		sleep 0.3
 		ovpn_cmd_ok "send baseline traffic to peer ${p}" \
 			ip netns exec ovpn_peer0 \
 			ping -qfc 100 -w 3 5.5.5.$((p + 1))
@@ -103,8 +101,10 @@ ovpn_run_basic_traffic() {
 			ip netns exec ovpn_peer0 \
 			ping -qfc 100 -s 3000 -w 3 5.5.5.$((p + 1))
 
-		wait "${tcpdump_pid1}" || return 1
-		wait "${tcpdump_pid2}" || return 1
+		if [ "${OVPN_PROTO}" == "UDP" ]; then
+			wait "${tcpdump_pid1}" || return 1
+			wait "${tcpdump_pid2}" || return 1
+		fi
 	done
 }
 
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
