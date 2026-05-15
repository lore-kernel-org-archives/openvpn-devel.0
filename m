Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C6CCD343F
	for <openvpn-devel@archiver.kernel.org>; Fri, 15 May 2026 08:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Qr2Wu5iq+IHC5bs7pSjh39C+IXfqdIGEtDBrP0yNvc=; b=UnOKge5sQ43PvnLhGj7W4hFcYG
	nrKSqA+v9L8oMYhVJqLbutD0YakufvObEUIEPDvWLf0vAOg8mEd4wtP1IbmQu9A0nLr3iQ4U4vvAn
	1DZRjomAPqhqYJsSvwEWh4CDYw+3vwC007ijTGXCOUvrkfyU7UEL10QLMnI7IMSXAMgE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNnTe-0006Vq-Si;
	Fri, 15 May 2026 08:00:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wNnTa-0006Vb-1e
 for openvpn-devel@lists.sourceforge.net;
 Fri, 15 May 2026 08:00:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=40y7XnMkkeXrf07K1VSPgkl2+LDrg9qNQQfiNfet+Rs=; b=QEfkJKOxjsgiG3fO1wGbWaxxyz
 tSGvtuhsM+tkhL1vPwKZzTv0HTCQ+MBNpMCX+UElRwt7dA9Y0Cglv404Z1B1PTwIJ7ijZdbRcTay5
 TMo5h4SfP94K7SoYKLV1pNeiEk1al/GnGp/jJ952lvx37RYXns5d1XA7kNRVmtTPX1Kw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=40y7XnMkkeXrf07K1VSPgkl2+LDrg9qNQQfiNfet+Rs=; b=AQ+z347A+RYqS6v2NwNsd8hnT6
 dVDZ9+am823n8lof4uWSY1SiPR/uME1kxlfFZil8VoFZAaEWZ17DgJ0glX9Oy4ZEpeEPMfU4D/0Rj
 G9qm99SBmw4zJZdMiwSdf9rm+pU9+qGyC5MsSMvywQFcnW6EWUu+Y4paMpSCx2aO6WFk=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNnTT-0004EK-Ij for openvpn-devel@lists.sourceforge.net;
 Fri, 15 May 2026 08:00:53 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4gH04K423LzB0bP;
 Fri, 15 May 2026 10:00:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1778832033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40y7XnMkkeXrf07K1VSPgkl2+LDrg9qNQQfiNfet+Rs=;
 b=yYxXXkejhpV4DEiPgg0IldCmlTzIsk650IjBkY2DUkucFHWUIaQjIfQ9KzXdOtzDaJJd8A
 Y41dAL0C1M3NJSC6hy4/nzpRWxB2VioRwBt33a7Z7008BxKWZ5JXNpdK1aB9gRYdRLc4ft
 t1pPTdq7rNLsnvFKvBz3cAWr4etYoVu5KnHiEDXV2S4/hXOfMh90c6P53UYShNqH6I7WbC
 cR1OFD7nEPiKOPCXER4a0enkk0X+jt0938qRCSADaUy0989F7X9P/Nfy295SFGok9FAahG
 SzJjEjXp9yDTBJwI0KqpyVAlT2K2thyxnaIS4bbZcupUCFuqmJ45pnqEZlnj/Q==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 15 May 2026 09:59:39 +0200
Message-ID: <20260515075941.102225-3-ralf@mandelbit.com>
In-Reply-To: <20260515075941.102225-1-ralf@mandelbit.com>
References: <20260515075941.102225-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wNnTT-0004EK-Ij
Subject: [Openvpn-devel] [PATCH ovpn net-next 3/3] selftests: ovpn: add
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
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 19 ++++-
 .../selftests/net/ovpn/test-close-socket.sh   |  4 +-
 tools/testing/selftests/net/ovpn/test-mark.sh |  4 +-
 tools/testing/selftests/net/ovpn/test.sh      | 75 +++++++++++++++++--
 4 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index d40953375c86..ca992a7cee3d 100644
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
@@ -2307,7 +2313,7 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		}
 		break;
 	case CMD_SET_PEER:
-		if (argc < 6)
+		if (argc < 7)
 			return -EINVAL;
 
 		ovpn->peer_id = strtoul(argv[3], NULL, 10);
@@ -2329,6 +2335,14 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 				"keepalive interval value out of range\n");
 			return -1;
 		}
+
+		errno = 0;
+		ovpn->mssfix = strtol(argv[6], NULL, 10);
+		if (errno == ERANGE || ovpn->mssfix < -1 ||
+		    ovpn->mssfix > UINT16_MAX) {
+			fprintf(stderr, "mssfix value out of range\n");
+			return -1;
+		}
 		break;
 	case CMD_DEL_PEER:
 		if (argc < 4)
@@ -2442,6 +2456,7 @@ int main(int argc, char *argv[])
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
