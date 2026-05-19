Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BC3CD4851
	for <openvpn-devel@archiver.kernel.org>; Tue, 19 May 2026 08:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cb7FGyjwbatfZAm89QP9HWu0fHFFFzINuiruOifUIH0=; b=F/p+TD5PEaOmTTgClzYji+58od
	ITzf2c4FZ+0/E0XfLGiUz77K3/qTuAHNdNkzcfaBATi9j5gN6DqoqjVIpOxM18C7rwuGdez4PikQ0
	jaeKcmM/pJ8U6gICl2eInd/THzTBRi542GLzWyNKrF5rIXfwgDYvHoUcytBXur8Atg0k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPFT6-0005u1-52;
	Tue, 19 May 2026 08:06:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wPFT4-0005ts-VX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 19 May 2026 08:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HSBrAxgg9TA8Nv4spPH/6U3Nb3eQ/75uJ75ANkxmx9Q=; b=UGfQNNFz0XmBLlK47nmZae2PoV
 aECa+YrdmskzlGSaW4yNq6a6O91Byecxzazndab8A3UR2HOfQ/QWgeUdWADuIExWfoq3IwfwEuwJk
 Z+gbue9q9nuMalMdD+NIl6UOY2F7evlt1DKp2TQSeJUjxfl/3SiY56IPxWX4XXg+2Ul4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HSBrAxgg9TA8Nv4spPH/6U3Nb3eQ/75uJ75ANkxmx9Q=; b=mFC3lLp3pbZwF7KUKMDk9OCSdI
 OiJa9FtpYkwEJzsL1PioaBm3RT4x94YbaEzB9mhxlNI+G7pg82s3h2x6Fo3dJiEAruARCamMvjbXL
 Mtgzc5sDHDUtr8k6IwvBUUHYen4ymqX1YzMa4HvLvKyDzpPoObL5SSaHPGJKMoLagvE0=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPFT2-0004AP-Or for openvpn-devel@lists.sourceforge.net;
 Tue, 19 May 2026 08:06:22 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4gKS0w2K3SzDsKV;
 Tue, 19 May 2026 10:06:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779177968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSBrAxgg9TA8Nv4spPH/6U3Nb3eQ/75uJ75ANkxmx9Q=;
 b=HtI/DDuMf3MaKaKeEQmyXZ43BMj8WZo4oIggmsMp6U8HlW+hiqA1Qv+9RPGtrdc9pPrSgo
 ivUpkNzC7dILfxEpM5YG76Q0MR1xXBIVWPfw8P8IST2ZkhE0hp1QX6YsPyohx691mhUPdo
 8rzVJzAT4etEAfoeJcZX0VZ58SZAWdyAL82IsWiurALEQyXtuhYAzg4Cf5Ip57A26RP/RO
 lMOG2S851Z/2VyWXdY0eM9p0DCF7W2wk3bVzwVc0yTDQ3oQoKKm0eBzl8Bo9AM+NX5cLBq
 4ereHf1xy06u9nzOcHMm/RRruRKvI4jtwPcjfx9CbYJJCutBVsVrK8q+uEbIyQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 19 May 2026 10:04:44 +0200
Message-ID: <20260519080500.120724-3-ralf@mandelbit.com>
In-Reply-To: <20260519080500.120724-1-ralf@mandelbit.com>
References: <20260519080500.120724-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gKS0w2K3SzDsKV
X-Headers-End: 1wPFT2-0004AP-Or
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 3/3] selftests: ovpn: add
 mssfix coverage
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

Extend ovpn-cli set_peer to pass the peer mssfix attribute. Use -1 as
the selftest CLI sentinel for leaving mssfix unchanged, so existing
timeout-only peer updates can keep omitting the netlink attribute.

Add an ovpn test stage that configures mssfix on each side of a peer
pair and verifies the MSS advertised on TCP SYN packets seen on the
tunnel device. This covers both TX-side and RX-side clamping, and also
checks that an invalid non-zero MSS value is rejected.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v2 https://lore.kernel.org/openvpn-devel/20260518085908.135570-3-ralf@mandelbit.com/

Changes since v1 https://lore.kernel.org/openvpn-devel/20260515075941.102225-3-ralf@mandelbit.com/
- parse mssfix into long before narrowing in ovpn-cli

 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 20 ++++-
 .../selftests/net/ovpn/test-close-socket.sh   |  4 +-
 tools/testing/selftests/net/ovpn/test-mark.sh |  4 +-
 tools/testing/selftests/net/ovpn/test.sh      | 75 +++++++++++++++++--
 4 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index d40953375c86..67351f33e7c8 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -10,6 +10,7 @@
 #include <stdio.h>
 #include <inttypes.h>
 #include <stdbool.h>
+#include <stdlib.h>
 #include <string.h>
 #include <errno.h>
 #include <unistd.h>
@@ -129,6 +130,7 @@ struct ovpn_ctx {
 
 	__u32 keepalive_interval;
 	__u32 keepalive_timeout;
+	int mssfix;
 
 	enum ovpn_key_direction key_dir;
 	enum ovpn_key_slot key_slot;
@@ -732,6 +734,8 @@ static int ovpn_set_peer(struct ovpn_ctx *ovpn)
 		    ovpn->keepalive_interval);
 	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_KEEPALIVE_TIMEOUT,
 		    ovpn->keepalive_timeout);
+	if (ovpn->mssfix >= 0)
+		NLA_PUT_U16(ctx->nl_msg, OVPN_A_PEER_MSSFIX, ovpn->mssfix);
 	nla_nest_end(ctx->nl_msg, attr);
 
 	ret = ovpn_nl_msg_send(ctx, NULL);
@@ -1730,13 +1734,15 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tmark: socket FW mark value\n");
 
 	fprintf(stderr,
-		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
+		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout> <mssfix>: set peer attributes\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr, "\tpeer_id: peer ID of the peer to modify\n");
 	fprintf(stderr,
 		"\tkeepalive_interval: interval for sending ping messages\n");
 	fprintf(stderr,
 		"\tkeepalive_timeout: time after which a peer is timed out\n");
+	fprintf(stderr,
+		"\tmssfix: TCP MSS value to clamp SYN packets to (0 disables, -1 leaves unchanged)\n");
 
 	fprintf(stderr, "* del_peer <iface> <peer_id>: delete peer\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
@@ -2166,6 +2172,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 
 static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 {
+	long mssfix;
 	int ret;
 
 	/* no args required for LISTEN_MCAST */
@@ -2307,7 +2314,7 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 		break;
 	case CMD_SET_PEER:
-		if (argc < 6)
+		if (argc < 7)
 			return -EINVAL;
 
 		ovpn->peer_id = strtoul(argv[3], NULL, 10);
@@ -2329,6 +2336,14 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 				"keepalive interval value out of range\n");
 			return -1;
 		}
+
+		errno = 0;
+		mssfix = strtol(argv[6], NULL, 10);
+		if (errno == ERANGE || mssfix < -1 || mssfix > UINT16_MAX) {
+			fprintf(stderr, "mssfix value out of range\n");
+			return -1;
+		}
+		ovpn->mssfix = mssfix;
 		break;
 	case CMD_DEL_PEER:
 		if (argc < 4)
@@ -2442,6 +2457,7 @@ int main(int argc, char *argv[])
 	memset(&ovpn, 0, sizeof(ovpn));
 	ovpn.sa_family = AF_UNSPEC;
 	ovpn.cipher = OVPN_CIPHER_ALG_NONE;
+	ovpn.mssfix = -1;
 
 	ovpn.cmd = ovpn_parse_cmd(argv[1]);
 	if (ovpn.cmd == CMD_INVALID) {
diff --git a/tools/testing/selftests/net/ovpn/test-close-socket.sh b/tools/testing/selftests/net/ovpn/test-close-socket.sh
index af1532b4d2da..091c0103bdba 100755
--- a/tools/testing/selftests/net/ovpn/test-close-socket.sh
+++ b/tools/testing/selftests/net/ovpn/test-close-socket.sh
@@ -41,10 +41,10 @@ ovpn_prepare_network() {
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
 			ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 \
-				${p} 60 120
+				${p} 60 120 -1
 		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
 			ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
-				tun${p} $((p + OVPN_ID_OFFSET)) 60 120
+				tun${p} $((p + OVPN_ID_OFFSET)) 60 120 -1
 	done
 }
 
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
index 5a8f47554286..11af23beea2a 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -54,10 +54,10 @@ ovpn_mark_prepare_network() {
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
 			ip netns exec ovpn_peer0 "${OVPN_CLI}" set_peer tun0 \
-				"${p}" 60 120
+				"${p}" 60 120 -1
 		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
 			ip netns exec "${peer_ns}" "${OVPN_CLI}" set_peer \
-				tun"${p}" $((p + OVPN_ID_OFFSET)) 60 120
+				tun"${p}" $((p + OVPN_ID_OFFSET)) 60 120 -1
 	done
 }
 
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index c06e3135fbef..a0630034351a 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -49,10 +49,10 @@ ovpn_prepare_network() {
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "set peer0 timeout for peer ${p}" \
 			ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 \
-				${p} 60 120
+				${p} 60 120 -1
 		ovpn_cmd_ok "set peer${p} timeout for peer ${p}" \
 			ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
-				tun${p} $((p + OVPN_ID_OFFSET)) 60 120
+				tun${p} $((p + OVPN_ID_OFFSET)) 60 120 -1
 	done
 }
 
@@ -142,6 +142,66 @@ ovpn_run_iperf() {
 	wait "${iperf_pid}" || return 1
 }
 
+ovpn_run_mssfix_flow() {
+	local filter
+	local iperf_pid
+	local direction="$1"
+	local mssfix="$2"
+	local tcpdump_pid
+
+	filter="tcp and src host 5.5.5.1 and dst host 5.5.5.2"
+	filter="${filter} and tcp[tcpflags] & tcp-syn != 0"
+
+	ovpn_run_bg iperf_pid ip netns exec ovpn_peer1 iperf3 -1 -s
+	sleep 1
+
+	timeout 3s ip netns exec ovpn_peer1 tcpdump --immediate-mode -l -p \
+		-vv -nn -i tun1 -c 1 "${filter}" 2>&1 |
+		grep -iq "mss ${mssfix}" &
+	tcpdump_pid=$!
+	sleep 0.3
+
+	ovpn_cmd_ok "run ${direction} mssfix TCP flow" \
+		ip netns exec ovpn_peer0 iperf3 -t 1 -c 5.5.5.2
+
+	ovpn_cmd_ok "capture ${direction} mssfix TCP SYN" wait "${tcpdump_pid}"
+	ovpn_cmd_ok "finish ${direction} mssfix TCP server" wait "${iperf_pid}"
+}
+
+ovpn_run_mssfix() {
+	local peer0_id=$((1 + OVPN_ID_OFFSET))
+
+	# peer0 will clamp MSS for packets exchanged with peer1
+	ovpn_cmd_ok "set peer0 mssfix for peer 1" \
+		ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 1 \
+			60 120 900
+
+	ovpn_cmd_fail "reject invalid peer0 mssfix for peer 1" \
+		ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 1 \
+			60 120 20
+
+	ovpn_cmd_ok "clear peer1 mssfix for peer ${peer0_id}" \
+		ip netns exec ovpn_peer1 ${OVPN_CLI} set_peer tun1 \
+			"${peer0_id}" 60 120 0
+
+	ovpn_run_mssfix_flow "TX" 900
+
+	ovpn_cmd_ok "clear peer0 mssfix for peer 1" \
+		ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 1 \
+			60 120 0
+
+	# peer1 will clamp MSS for packets exchanged with peer0
+	ovpn_cmd_ok "set peer1 mssfix for peer ${peer0_id}" \
+		ip netns exec ovpn_peer1 ${OVPN_CLI} set_peer tun1 \
+			"${peer0_id}" 60 120 901
+
+	ovpn_run_mssfix_flow "RX" 901
+
+	ovpn_cmd_ok "clear peer1 mssfix for peer ${peer0_id}" \
+		ip netns exec ovpn_peer1 ${OVPN_CLI} set_peer tun1 \
+			"${peer0_id}" 60 120 0
+}
+
 ovpn_run_key_rollover() {
 	local p
 	local peer_ns
@@ -259,11 +319,11 @@ ovpn_run_timeouts() {
 		# Non-fatal: this may fail in some protocol modes.
 		ovpn_cmd_mayfail "set peer0 timeout for peer ${p} (non-fatal)" \
 			ip netns exec ovpn_peer0 ${OVPN_CLI} set_peer tun0 \
-				${p} 3 3
+				${p} 3 3 -1
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "disable timeout on peer${p} while peer0 adjusts \
 			state" ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
-			tun${p} $((p + OVPN_ID_OFFSET)) 0 0
+			tun${p} $((p + OVPN_ID_OFFSET)) 0 0 -1
 	done
 	# wait for peers to timeout
 	sleep 5
@@ -274,7 +334,7 @@ ovpn_run_timeouts() {
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "set peer${p} P2P timeout" \
 			ip netns exec "${peer_ns}" ${OVPN_CLI} set_peer \
-				tun${p} $((p + OVPN_ID_OFFSET)) 3 3
+				tun${p} $((p + OVPN_ID_OFFSET)) 3 3 -1
 	done
 	sleep 5
 }
@@ -293,9 +353,9 @@ trap ovpn_stage_err ERR
 
 ktap_print_header
 if [ "${OVPN_FLOAT}" == "1" ]; then
-	ktap_set_plan 13
+	ktap_set_plan 14
 else
-	ktap_set_plan 12
+	ktap_set_plan 13
 fi
 
 ovpn_cleanup
@@ -307,6 +367,7 @@ ovpn_run_stage "run LAN traffic behind peer1" ovpn_run_lan_traffic
 [ "${OVPN_FLOAT}" == "1" ] && ovpn_run_stage "run floating peer checks" \
 	ovpn_run_float_mode
 ovpn_run_stage "run iperf throughput" ovpn_run_iperf
+ovpn_run_stage "run mssfix TCP SYN clamp" ovpn_run_mssfix
 ovpn_run_stage "run key rollout" ovpn_run_key_rollover
 ovpn_run_stage "query peers" ovpn_run_queries
 ovpn_run_stage "query missing peer fails" ovpn_query_peer_missing
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
