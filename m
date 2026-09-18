Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A186AC982D7
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mY1oDj5AbTTHObOzwezSOkmp24Gd8m9zsp9t+/qBpz0=; b=RWQBRLFVC1ow659W71bfm9qy8g
	1zTVKSwKX6628FdwE4NNGeGOaVanY/L1fZ7pYzUI5qYCpGrieAwUN0T797TgFplzIve2XznxQUt/w
	f9/bcTD6mK7nj4Q6XKVjilYR/cvkRvGMuX69E0k69kVqh25DilZ+WvHpUxaTshg4ubeU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7S7b-0006HZ-TN;
	Fri, 18 Sep 2026 06:30:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x7S7a-0006HG-Al
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 06:30:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TyH5zyjUsvaMUwHKlaz2nQNOySt0PPEdyfJ/nfen30c=; b=j6IWDf1GgK6OpR8uBYXHE6ycJJ
 vS1oOAuemVlULUV7S+1P/CfH36t6zn/TwnKYPmD6tFoArekiE/vvZhukaSBRe/PAdv6XlelNuWnna
 5kKjDAANS2F1mPbyArN4l23mxuFP7CXsDRWja0sVXxNV6NkFZxYewxnSb9ET7U+TH7QA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TyH5zyjUsvaMUwHKlaz2nQNOySt0PPEdyfJ/nfen30c=; b=MuYraX79ZHXFXOxQSAJu6R9ONZ
 6nd5HLlhNRMjxLhQAT/88N3iCtGMwqeFh9sxW3FxRJA36tHxZVpmWOSwV/uj5S/koEtPw582wl/Oz
 viwic7auNXxcIbNc/uuBkWo1ztCBPs8ggLFsb6nrMOb+50sO9b/qbTthQoWiRpE8gwWk=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7S7Y-0000c1-3N for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 06:30:55 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hmN6W68PzzLm3d;
 Fri, 18 Sep 2026 08:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789713043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyH5zyjUsvaMUwHKlaz2nQNOySt0PPEdyfJ/nfen30c=;
 b=uCrm/gQPf3FXFtggYGy4LchlRdZcIJMYlBjU3YHmRgvOp7GztNPcQVbXwDbyKslLIE9019
 pY3mE1OrO1Z5QptkpG44SDxxiWxxhbcpDwrQXaX9mxS68uWzzdylknWlebaOBgG6kFI4oa
 czgo6amKuKX2XSaF/NW1KG3NvoX9zsTuQ1UzuAv2WO9AKkIH1gpA51wkAyLI1CS5MZPa0X
 /tAWQQVPsNtwfQE6zK+YnyV0zung+quKxVtrtulBHXSfrszQjSjwqZd5SU98jJd3MoI3yG
 727MWPp8j9545EQ1Y8CiWi8NDjxgEKrSC4mYxHFfCVDrOAqYbZlIGI2fnyExpg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 18 Sep 2026 08:30:36 +0200
Message-ID: <20260918063036.1588046-2-marco@mandelbit.com>
In-Reply-To: <20260918063036.1588046-1-marco@mandelbit.com>
References: <20260918063036.1588046-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hmN6W68PzzLm3d
X-Headers-End: 1x7S7Y-0000c1-3N
Subject: [Openvpn-devel] [RFC ovpn net-next v7 2/2] ovpn: add broadcast and
 multicast selftests
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

Add a test stage that verifies the ovpn module forwards broadcast
(IPv4) and multicast (IPv4/v6) packets to all active peers.

For each mode we start tcpdump on every client peer, send a single
ping from peer0 to the broadcast/multicast address, and verify all
peers captured the packet.

Disable automatic IPv6 link-local address generation during namespace
setup to prevent background IPv6 traffic from affecting the mark test's
packet counts. Assign link-local addresses explicitly for the IPv6
multicast test so that ping to ff02::1 has a valid source address.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---

Changes in v7:
- Disable automatic IPv6 link-local address generation and assign
  addresses only for the IPv6 multicast test, avoiding background
  traffic that affects the mark test's packet counts.
- Replace fixed startup delays with bounded tcpdump readiness checks.
- Consolidate capture handling in a shared helper with timeouts,
  per-peer diagnostics, and process/temporary-file cleanup.

 tools/testing/selftests/net/ovpn/common.sh |  3 +
 tools/testing/selftests/net/ovpn/test.sh   | 78 +++++++++++++++++++++-
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e3..be319b3c42660 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -173,6 +173,9 @@ ovpn_setup_ns() {
 	if [ -n "${3}" ]; then
 		ip -n "${peer}" link set mtu ${3} dev tun${1}
 	fi
+	# Configure IPv6 addresses explicitly in the multicast test. Automatic
+	# link-local addresses would generate traffic that affects packet counts.
+	ip -n "${peer}" link set dev tun${1} addrgenmode none
 	ip -n "${peer}" link set tun${1} up
 }
 
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032f..11a0bd92c2827 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -56,6 +56,79 @@ ovpn_prepare_network() {
 	done
 }
 
+ovpn_run_mbcast_test() (
+	local label="$1"
+	local destination="$2"
+	local filter="$3"
+	local capture_dir
+	local deadline
+	local p
+	local ret=0
+	local -a pids=()
+
+	shift 3
+	capture_dir=$(mktemp -d) || return 1
+	trap 'kill "${pids[@]}" 2>/dev/null || true
+	      wait "${pids[@]}" 2>/dev/null || true
+	      rm -rf "${capture_dir}"' EXIT
+	trap 'exit 1' INT TERM
+
+	ovpn_log "Testing ${label}:"
+	# Allow five seconds for startup, plus time to send and capture the ping.
+	deadline=$((SECONDS + 5))
+	for p in $(seq 1 "${OVPN_NUM_PEERS}"); do
+		: >"${capture_dir}/${p}" || return 1
+		LC_ALL=C timeout 10 ip netns exec "ovpn_peer${p}" \
+			tcpdump --immediate-mode -p -ni "tun${p}" -c 1 \
+			"${filter}" >/dev/null 2>"${capture_dir}/${p}" &
+		pids[p]=$!
+	done
+
+	for p in $(seq 1 "${OVPN_NUM_PEERS}"); do
+		while ! grep -q "listening on tun${p}," "${capture_dir}/${p}"; do
+			if ! kill -0 "${pids[p]}" 2>/dev/null ||
+				((SECONDS >= deadline)); then
+				printf '# %s: capture not ready on peer%s\n' \
+					"${label}" "${p}"
+				cat "${capture_dir}/${p}"
+				return 1
+			fi
+			sleep 0.1
+		done
+	done
+
+	ovpn_cmd_mayfail "send ${label} ping from peer0" \
+		ip netns exec ovpn_peer0 ping "$@" -qc 1 -w 3 -I tun0 \
+			"${destination}"
+	for p in $(seq 1 "${OVPN_NUM_PEERS}"); do
+		if ! wait "${pids[p]}"; then
+			printf '# %s: capture failed on peer%s\n' "${label}" "${p}"
+			cat "${capture_dir}/${p}"
+			ret=1
+		fi
+		unset 'pids[p]'
+	done
+
+	return "${ret}"
+)
+
+ovpn_run_mbcast_tests() {
+	local p
+
+	ovpn_run_mbcast_test "broadcast" 5.5.5.255 \
+		'icmp and dst host 5.5.5.255' -b || return 1
+	ovpn_run_mbcast_test "IPv4 multicast" 224.0.0.1 \
+		'icmp and dst host 224.0.0.1' || return 1
+
+	for p in $(seq 0 "${OVPN_NUM_PEERS}"); do
+		ovpn_cmd_ok "configure IPv6 address on peer${p}" \
+			ip -n "ovpn_peer${p}" addr add fe80::$((p + 1))/64 \
+				dev tun${p} scope link
+	done
+	ovpn_run_mbcast_test "IPv6 multicast" ff02::1 \
+		'icmp6 and dst host ff02::1' -6 || return 1
+}
+
 ovpn_run_basic_traffic() {
 	local p
 	local header1
@@ -293,9 +366,9 @@ trap ovpn_stage_err ERR
 
 ktap_print_header
 if [ "${OVPN_FLOAT}" == "1" ]; then
-	ktap_set_plan 13
+	ktap_set_plan 14
 else
-	ktap_set_plan 12
+	ktap_set_plan 13
 fi
 
 ovpn_cleanup
@@ -303,6 +376,7 @@ modprobe -q ovpn || true
 
 ovpn_run_stage "setup network topology" ovpn_prepare_network
 ovpn_run_stage "run baseline data traffic" ovpn_run_basic_traffic
+ovpn_run_stage "run multi/broadcast traffic" ovpn_run_mbcast_tests
 ovpn_run_stage "run LAN traffic behind peer1" ovpn_run_lan_traffic
 [ "${OVPN_FLOAT}" == "1" ] && ovpn_run_stage "run floating peer checks" \
 	ovpn_run_float_mode
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
