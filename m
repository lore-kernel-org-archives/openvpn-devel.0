Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DB7CA5FD4
	for <openvpn-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYEFXhlrmesiN5fMdjO5uuS5HD2HNc1YxtIiz96mPts=; b=HGs3YmtW+NYuBkmDxgg9Vd6tvV
	dVveeAgBql7Qn1pKjHbY01yt38gd+7i1vq970muqM7bUK81+mMAsbSNg/o7e8wFJDQkxE9YpxsNCJ
	IvxAa540dk8rvKMy5DzJhMyR3dd9Y62CM5CbgLcYU7OBNgDvzpYK7yW519Tacgy0S+DY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCbRj-0006rC-U7;
	Fri, 02 Oct 2026 11:29:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1xCbRc-0006qQ-4E
 for openvpn-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 11:28:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uF1mk1B4BZXzYk56kuQWoZIQS9rdOATgnC1fXA9jbQk=; b=Ir0HhP3PtedJwTfZKkBVukt4AD
 26RmrJJzuOKcI5Op8AHM3/B13IeIjLGhUW8SHdikcS8suwooCtm40kP4qabqQeEaaMHDwKwUwZ8IF
 sIZbfDenJtYdLNqWquEVMqPhywP7P25r7czY3+3Ra+A7cLotSX6reNAyxjG3zcML2h4U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uF1mk1B4BZXzYk56kuQWoZIQS9rdOATgnC1fXA9jbQk=; b=Pi6a4fNCq2DtOBia6ia/eOyXL7
 wXJPjwOxZpqPPU+1CxgI1WHx3OGDdQty1QrM2xU8sn6wBZGeJQTelHo/bwOq8EKEy/753ORkhRKLb
 q/Wvyad1jolfMxh6romH5dFATaCeAl7RCruNPX/CyDkHVXQ/uUhfHgTOOGMPYi6d3e4s=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCbRZ-0005RU-Vj for openvpn-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 11:28:52 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hx63s6xVBzLm1F;
 Fri, 02 Oct 2026 13:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790940521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uF1mk1B4BZXzYk56kuQWoZIQS9rdOATgnC1fXA9jbQk=;
 b=rcwNWLTIb0Yc4MB7RkowFc9Jax/oM27YegH+FE/duDwFl4zXMAO8PvQbfTPqJfmalWsXjF
 gvtKgJjh6aoVzlQ1zuaoCi2Ki3Nj58h86mJap1+Is5NphPZ3sIS+hhkqvXONb3PlvphshW
 G01rJR3pfxDRMcEXPLZhNbyA0Xgf0/8io5L92CEN6d7C5Ut5uPbQ//LCzOo52zqB9m7X2T
 K+fwlpTag3XH2BN9xHu0cqM0gpKwqtF0shFNPhZOQ6t092rhrYejBtGFF3V5aN7/0T3zI1
 6gndIGD06gYuEXzPhKpDIgLfOd5ACftXKaQx1ncAkACWcFuwzAzD/338X2lCpw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  2 Oct 2026 13:28:36 +0200
Message-ID: <20261002112836.1056585-2-marco@mandelbit.com>
In-Reply-To: <20261002112836.1056585-1-marco@mandelbit.com>
References: <20261002112836.1056585-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hx63s6xVBzLm1F
X-Headers-End: 1xCbRZ-0005RU-Vj
Subject: [Openvpn-devel] [RFC ovpn net-next v10 2/2] ovpn: add broadcast and
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

Changes in v10:
- Added comment to explain that ping echo requests do not
  have IPv6 extension headers, so we do not account for it.
- Added teardown of the fe80::N addresses after ovpn_run_mbcast_tests
  to keep the stages isolated.

Changes in v9:
- Restrict broadcast and multicast captures to incoming Echo Requests
  from peer0 with the expected destination address.
- Add nodad when assigning the IPv6 link-local addresses.
  
Changes in v8:
- Moved the disabling of automatic address generation to the previous patch.
  
Changes in v7:
- Disable automatic IPv6 link-local address generation and assign
  addresses only for the IPv6 multicast test, avoiding background
  traffic that affects the mark test's packet counts.
- Replace fixed startup delays with bounded tcpdump readiness checks.
- Consolidate capture handling in a shared helper with timeouts,
  per-peer diagnostics, and process/temporary-file cleanup.

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
