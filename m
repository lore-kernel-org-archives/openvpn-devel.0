Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF76AC982D8
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E397omWqNvYh1SM6sXSOP8HrAa+YiyIpcmO7a4qCOnY=; b=duUkpwQB2Rn8s3dyJjHqdW7JMH
	fX3yh8VF4PUVWuruK0PwfAMGEv8C/S/VG16E08yWwd/6hSO+MgZ60yxT5+gZidAgruGhyEv5NR8RC
	oaNBMRqecAJJlihQLATtsUvZWzjMcGcHk+EQJvP7lJeVadtxisc+7114msCBTqoFACCM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7aor-0007Lh-2r;
	Fri, 18 Sep 2026 15:48:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x7aof-0007LM-Va
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 15:47:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ra5/NJvlc6wVtFVVUgnOb4TtE6+NCkw4Fy7Z+WegkM4=; b=hlZw43sxldiLO6GQzpDxPeYWz1
 v1cantW7/7/1Vo8laxMW0yCM2mwhPSunDRSjONM4kCYiGlDrW5jlt643Vw1ssrvBrahmRfZVxooOx
 p9lZvn6JMs99U/Ii0aRMUMhqT824tJMXGtOLbGTiMnOPT1fE4JKBjoQtLxTDObxSWxys=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ra5/NJvlc6wVtFVVUgnOb4TtE6+NCkw4Fy7Z+WegkM4=; b=nUl/TnsK9O+5Qn4G58Y3uAURx1
 wQOSptEZE1P5MPqNk6zKlAuqQIZQRzc8q+W68ugYKL/Wi5D+lQ9n2f9YxZrirvq416epM5O35lRaK
 t0s/yzsXfTsc8ZysPCGAbbOZ6cDAzsDgJAFOP2CHhCcA2BQJgAYQgnFUoNghRGpzFIsI=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7aoe-0005c6-8Q for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 15:47:57 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4hmcTJ3KlrzKnY2;
 Fri, 18 Sep 2026 17:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789746468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ra5/NJvlc6wVtFVVUgnOb4TtE6+NCkw4Fy7Z+WegkM4=;
 b=12rfFCRnz9bif5rqHX712IYZz1UEgceh1h0v43frDgMDCtzRmR9NKV76c+/yWrpaDh58Nq
 OxyBNmBi85sItTSRN0u0Mw3971H4dxzlCyMagHa3ILMlahEWSxMWMGB5SyvaXUwz+nCt+C
 orNTUO6LIP8gFBDO+urCvVZ30zZ/VrcCK8KKaHP/JthoPvY41w1bIl5iJLHHsnkXS53+qp
 UEGRTjW1H8HsYxu+m6kgVlfcxqS97cZPE8iK48G5dQ0B3ioColW4gmXc30k3NJWtemEmFi
 HxcnPOiWgXLnNI+NrQbTYL9iRxYx44xywqbEPi2oAgbgKhou5QRiCPCxLA6ESw==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 18 Sep 2026 17:47:41 +0200
Message-ID: <20260918154741.1935753-2-marco@mandelbit.com>
In-Reply-To: <20260918154741.1935753-1-marco@mandelbit.com>
References: <20260918154741.1935753-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x7aoe-0005c6-8Q
Subject: [Openvpn-devel] [RFC ovpn net-next v9 2/2] ovpn: add broadcast and
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

Assign link-local addresses explicitly for the IPv6
multicast test so that ping to ff02::1 has a valid source address.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---

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

 tools/testing/selftests/net/ovpn/test.sh | 79 +++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032f..26f4e07fe4d39 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -56,6 +56,80 @@ ovpn_prepare_network() {
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
+	ovpn_run_mbcast_test "IPv6 multicast" ff02::1 \
+		'icmp6 and src host fe80::1 and dst host ff02::1 and ip6[40] == 128' -6 || return 1
+}
+
 ovpn_run_basic_traffic() {
 	local p
 	local header1
@@ -293,9 +367,9 @@ trap ovpn_stage_err ERR
 
 ktap_print_header
 if [ "${OVPN_FLOAT}" == "1" ]; then
-	ktap_set_plan 13
+	ktap_set_plan 14
 else
-	ktap_set_plan 12
+	ktap_set_plan 13
 fi
 
 ovpn_cleanup
@@ -303,6 +377,7 @@ modprobe -q ovpn || true
 
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
