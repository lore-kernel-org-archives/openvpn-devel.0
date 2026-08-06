Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30A5C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wAvfv2k+pDjgtcayINU24oMhSFKPqycmqfAYTBzK7dM=; b=SbbkXWtZNLBUqEhb7XH5GXi1ZK
	5A8KAd+IMtBc5EE3Lo3WZKDPqlTOit74+hzaNE+PCNkEknZbdiCLoQPJ6gkUVutRmktPyp2CM1ttj
	KAO3qicg52l5IzrYL/Q17QsG/tXkJXDaamNIr85H7wB6mnmtgaLrF0psPOMGBBVbiaek=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrsLd-0006UQ-E1;
	Thu, 06 Aug 2026 07:17:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wrsLX-0006U8-I7
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 07:16:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iENtAfb+ZLWYu4JSNz340TsPQdckajM2DDWvfp+ojaA=; b=B/+rGqJsPzrAoNVnnrcMmUGyrQ
 YCz992fEnPqoDuIzJQjJNY52y+nVQJF9dAO9Dgrb3CbG4m2FZVnRag48CYyXDZwcmBSV/xey/IFTc
 2nFEBxgKhuEV2rjecGH19CXSt4NAkUaAWB7M8X6fMfIRLYpo9Y1aGi9UqLwXIFa4QBag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iENtAfb+ZLWYu4JSNz340TsPQdckajM2DDWvfp+ojaA=; b=M
 pZ8co0Ef7r9pljAWp5cMKFj5nawpTLr48577azlnFtrkWmIXpX5+aBPUUOG7RhiFFbfJn3oohw4rf
 pJ12R2lXJ9eTMu75icWrEdx4kA+iFi8jjEUqGkjVBNfHUrTuMeti/cPnlvJh8SFDUUTbfvX1mPfqi
 JFuX7x47VeSPELc0=;
Received: from [195.10.208.47] (helo=mout-b-107.mailbox.org)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrsLY-00016A-PM for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 07:16:55 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4hFz9T46TDz3y4H;
 Thu, 06 Aug 2026 09:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1786000605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iENtAfb+ZLWYu4JSNz340TsPQdckajM2DDWvfp+ojaA=;
 b=VjjzyTz9Wb78ezCmckiVIVU0Jlb5CQv7t0GEcjT/pTOGfbh7fEhsBX/wwEM/Mwy2/dl8KG
 gAZRGKlIyFroSIuwhyqkmBaCKrX5m9WplJHULqabUkPjqd7wrrzMBTWNvKTuxDG65w8LeS
 UDG3tGQD3KzIGnib3SaAK+FoMcyHM5JJERsz95xtFjzEu1SfYkeUs9cTTdbUTmPoMmIspi
 eGShNMctG12i28pWWFd+wEoM6MP2Uns8ROGIE+SVtjXgkatxr52+O3GoPy7vekaGfZgTWD
 uooX3gx0OLv4ZPKzOlC/UwA+kDjOrQh5O7H0mFI65LNZYGAXs05sXbYuOU6+zA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  6 Aug 2026 09:16:36 +0200
Message-ID: <20260806071636.621632-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hFz9T46TDz3y4H
X-Headers-End: 1wrsLY-00016A-PM
Subject: [Openvpn-devel] [PATCH ovpn net-next] selftests: ovpn: enable
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Userspace now enables TCP_NODELAY by default. Enable it for
ovpn-cli's TCP sockets too.

The TCP peer ID capture assumes that every TCP segment starts with an
ovpn length prefix followed by a data header. TCP does not preserve
record boundaries, and enabling TCP_NODELAY makes this check unreliable.
Restrict the capture-based peer ID check to UDP.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 tools/testing/selftests/net/ovpn/common.sh  | 20 +++-----
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 22 +++++++++
 tools/testing/selftests/net/ovpn/test.sh    | 54 ++++++++++-----------
 3 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e..de96d333ee2b 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -178,20 +178,14 @@ ovpn_setup_ns() {
 
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
index f4effa7580c0..6b458a654a33 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -470,6 +470,18 @@ static int ovpn_parse_key_direction(const char *dir, struct ovpn_ctx *ctx)
 	return 0;
 }
 
+static int ovpn_tcp_nodelay(int socket)
+{
+	int opt = 1;
+	int ret;
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
@@ -606,6 +618,12 @@ static int ovpn_accept(struct ovpn_ctx *ctx)
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
@@ -623,6 +641,10 @@ static int ovpn_connect(struct ovpn_ctx *ovpn)
 		return -1;
 	}
 
+	ret = ovpn_tcp_nodelay(s);
+	if (ret < 0)
+		goto err;
+
 	switch (ovpn->remote.in4.sin_family) {
 	case AF_INET:
 		socklen = sizeof(struct sockaddr_in);
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
