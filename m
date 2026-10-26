Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC6606A31B
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ct0FEW70;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z43qioz8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FLlGBadL;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=V9qPy2mj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WriUvSZNeov06fERfXxBHGPJyIaUWKmdRDsjkfxuyIE=; b=Ct0FEW70DDrz8B
	gEAoNdJstVu78ifgfClJp32SnYReEzHw0JSbLlaPzAYr0hY9cqNmgL45BXORL7qXMA9l++gHmlZUv
	CJrYSoAKUzDki/hHH+e4DLtT9pms6xwvDfz+UV6o53iXAbMuQkl9ECSxSqOYeUBB8akD8pReoKAyD
	8Uw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLLKC-000000000w8-2XQq;
	Mon, 26 Oct 2026 14:05:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <marco@mandelbit.com>) id 1xLLKB-000000000w0-1gGi
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:05:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qrtk7Lyu9zhVotS1t8CVhf0tjSBrVaB7BEUgPsTLcMQ=; b=Z43qioz8gwS7jCNNit9Zo6W0sP
 J1Na462kSuyvM3RoNPj9vWtu6vRPEhWUTEGS391wWBLCM/5K3r+56wce/uBdjLxLK2rfuDp7cvTAv
 edzgqQdwba+n6k3NGlEn+vq4V+LK/zxos34VcR9D7aO5E2REkIl3unNIi02VR0mPzGAs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qrtk7Lyu9zhVotS1t8CVhf0tjSBrVaB7BEUgPsTLcMQ=; b=FLlGBadLRMUBm26kaEpuqs5VNe
 GhSi5ZzJgHpeEuJhWON+AseUA69J1Zt6I7Uxs1Qh7H8VQTiXAi6E2zP8zsVUyNf1uYgVZvP9pgGsU
 ZgR7kRj9zsua7okM6LGJdKIpkIEJmdQJ/kiFx8Ioz6/gzVcNY4EhKD87v3XcTf+uWHvU=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLLK9-000000002zX-0J6G for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:05:19 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jCwPK3cfpz3y38;
 Mon, 26 Oct 2026 15:05:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1793023509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qrtk7Lyu9zhVotS1t8CVhf0tjSBrVaB7BEUgPsTLcMQ=;
 b=V9qPy2mj6/3aU/19SHNqonaXcLhKDVAibuEHmsPVnd4fXcJZX1n6JWXNkP01PWeJqE2ILy
 T608KN3QfBBcT1bZK3j6fd9miqfWfVt1f8eGZ7aDGDWp0aBCKuuKiU70/FvFyPhXz+Sp2L
 Cu0h8ZfBiMZY71fj0CSwqUu+Ja3Eb0QNSgnsy1oGjys+WFFBiuOtthQQnCP1gzMpDMOhOa
 BX51gKqC/xAod+rQCrNyzL0uMoo6kM+4QhcUueVkHE1Q6QOH/BkLEBVWWmbKTyA+GMBPfs
 GPSuBAZdPlYDObyYRXjkntuM9mH6MPvlTdHlO003skhu5X0VBiogKmsF4qZr4w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 26 Oct 2026 15:05:04 +0100
Message-ID: <20261026140504.1786019-2-marco@mandelbit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026140504.1786019-1-marco@mandelbit.com>
References: <20261026140504.1786019-1-marco@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jCwPK3cfpz3y38
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLLK9-000000002zX-0J6G
Subject: [Openvpn-devel] [PATCH ovpn net-next v2 2/2] ovpn: add broadcast
 and multicast selftests
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test stage that verifies the ovpn module forwards broadcast
(IPv4) and multicast (IPv4/v6) packets to all active peers.

For each mode we start tcpdump on every client peer, send a single
ping from peer0 to the broadcast/multicast address, and verify all
peers captured the packet.

Assign link-local addresses explicitly for the IPv6
multicast test so that ping to ff02::1 has a valid source address.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---

Changes in v2:
- Shortened lines longer than 80 chars
- Changed ping -w 3 with -W 1 in ovpn_run_mbcast_test() to save time

 tools/testing/selftests/net/ovpn/test.sh | 92 +++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032f..ca222ff69b2c2 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -56,6 +56,93 @@ ovpn_prepare_network() {
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
+	# allow 5 seconds for startup, plus time to send and capture the ping.
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
+		while ! grep -q "listening on tun${p}," \
+				"${capture_dir}/${p}"; do
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
+		ip netns exec ovpn_peer0 ping "$@" -qc 1 -W 1 -I tun0 \
+			"${destination}"
+	for p in $(seq 1 "${OVPN_NUM_PEERS}"); do
+		if ! wait "${pids[p]}"; then
+			printf '# %s: capture failed on peer%s\n' "${label}" \
+			"${p}"
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
+	local filter4='icmp and src host 5.5.5.1 and
+	      icmp[icmptype] == icmp-echo'
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
+		'icmp6 and src host fe80::1 and dst host ff02::1 and
+		 ip6[40] == 128' -6 || ret=1
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
@@ -293,9 +380,9 @@ trap ovpn_stage_err ERR
 
 ktap_print_header
 if [ "${OVPN_FLOAT}" == "1" ]; then
-	ktap_set_plan 13
+	ktap_set_plan 14
 else
-	ktap_set_plan 12
+	ktap_set_plan 13
 fi
 
 ovpn_cleanup
@@ -303,6 +390,7 @@ modprobe -q ovpn || true
 
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
