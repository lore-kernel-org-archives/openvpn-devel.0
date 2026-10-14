Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E89CC6B24
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FySI0BTdG81M3sUc2bKGlSwqIHjMTaz8BrO3oL/KqK8=; b=Pr7V9CMhiB4vrsKsFvd2Nc+6CS
	gn9Na71OV3efeE+g1wBwx8kEME0sTNM2Z1z41YuJqsm1Sv+DTHthO0u/7HYALADF28JFwePh1iMz8
	QLvF7b1KDezqD7n7+JBs5rdbJoKyb4eOndVsCbwgpEOPYY9eb50F8bF6/FdBRW7XJJHo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGrly-0007x4-AL;
	Wed, 14 Oct 2026 05:43:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1xGrlw-0007wv-2s
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 05:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yllz3wSfJ88c9dRyDVXP8ClZXjNFqeN3nV5Pkpjh57A=; b=V4Y1EODwCC+CfhhYmoQ2E07qD8
 jZ0KxFl0sm0DFHnKeoNq6hJzqoAXDJgOMyFrZASvTS0u1TDb2PcWteQq8QhA0w8hJC3vkUrqJKiWP
 IeqhV8ftn4sn22oZtUs93Jjev7CsAPAdHZ21a65LNQlb77C5Y0v7epTW9SmxXkr10ZzA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yllz3wSfJ88c9dRyDVXP8ClZXjNFqeN3nV5Pkpjh57A=; b=RBw07dkTTVKu9rmSBZOHeqDtM3
 MskwS72ZvbLnKB6njjjwcL6P7F+A6cwm9Tm5nUy76FEDPO5vkRmX1129/36eBTo0nw1rrlw2AdNJW
 hrgpUaHKPHr14FMf+2lA6VC0B8sZ85PPpTuKHNP/2LHc6BqIXFcw8pAeLe70cKdDvND0=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGrlr-0000tS-Sg for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 05:43:28 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4j4Kql5M9kzLmHV;
 Wed, 14 Oct 2026 07:43:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1791956595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yllz3wSfJ88c9dRyDVXP8ClZXjNFqeN3nV5Pkpjh57A=;
 b=I37iby/XPgc+hYxtzZr0exte5dFzf9jMqSpcYB2HPo0Iow804rJgoKO2LfuWXLTsaGZrjJ
 K7JDEKo8s54ZY+eqBQ1oFZk2rLY1Dknjhjeahk9H8JzUbBgOvYGonG5hiQBy7JYNheJf+d
 4A7FRGoR7nlbsKq5FR59g4T4aAPTuFlWdxMquuEEC4UtBcEYJgC3aKGiGCpJSDjDlpA7+5
 3bp+OtJ3N9oRJT2EjWb6TXPqEL+3LbmCk24qr6CRQZKwy7u5QUqS7dAtskKZT+2/fqucYn
 KFoV7+eXJqJTdHaAXb20C5NAYA22dn1qTKTrV/t9EUSUPS/mvbb0lRRyvVoumw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 14 Oct 2026 07:43:11 +0200
Message-ID: <20261014054311.352210-2-marco@mandelbit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014054311.352210-1-marco@mandelbit.com>
References: <20261014054311.352210-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4j4Kql5M9kzLmHV
X-Headers-End: 1xGrlr-0000tS-Sg
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/2] ovpn: add broadcast and
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Add a test stage that verifies the ovpn module forwards broadcast
(IPv4) and multicast (IPv4/v6) packets to all active peers.

For each mode we start tcpdump on every client peer, send a single
ping from peer0 to the broadcast/multicast address, and verify all
peers captured the packet.

Assign link-local addresses explicitly for the IPv6
multicast test so that ping to ff02::1 has a valid source address.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 tools/testing/selftests/net/ovpn/test.sh | 88 +++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032f..8614a12a5f4a0 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -56,6 +56,89 @@ ovpn_prepare_network() {
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
+			tcpdump --immediate-mode -p -Q in -ni "tun${p}" -c 1 \
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
+	local filter4='icmp and src host 5.5.5.1 and icmp[icmptype] == icmp-echo'
+	local p
+	local ret=0
+
+	ovpn_run_mbcast_test "broadcast" 5.5.5.255 \
+		"${filter4} and dst host 5.5.5.255" -b || return 1
+	ovpn_run_mbcast_test "IPv4 multicast" 224.0.0.1 \
+		"${filter4} and dst host 224.0.0.1" || return 1
+
+	for p in $(seq 0 "${OVPN_NUM_PEERS}"); do
+		ovpn_cmd_ok "configure IPv6 address on peer${p}" \
+			ip -n "ovpn_peer${p}" addr add fe80::$((p + 1))/64 \
+				dev tun${p} scope link nodad
+	done
+	# ping sends echo requests without IPv6 extension headers.
+	ovpn_run_mbcast_test "IPv6 multicast" ff02::1 \
+		'icmp6 and src host fe80::1 and dst host ff02::1 and ip6[40] == 128' -6 || ret=1
+	for p in $(seq 0 "${OVPN_NUM_PEERS}"); do
+		ovpn_cmd_ok "remove IPv6 address on peer${p}" \
+			ip -n "ovpn_peer${p}" addr del fe80::$((p + 1))/64 \
+				dev tun${p}
+	done
+
+	return "${ret}"
+}
+
 ovpn_run_basic_traffic() {
 	local p
 	local header1
@@ -293,9 +376,9 @@ trap ovpn_stage_err ERR
 
 ktap_print_header
 if [ "${OVPN_FLOAT}" == "1" ]; then
-	ktap_set_plan 13
+	ktap_set_plan 14
 else
-	ktap_set_plan 12
+	ktap_set_plan 13
 fi
 
 ovpn_cleanup
@@ -303,6 +386,7 @@ modprobe -q ovpn || true
 
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
