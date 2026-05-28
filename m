Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD22CD6E44
	for <openvpn-devel@archiver.kernel.org>; Thu, 28 May 2026 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJDMLyXYtp/e7gmQYepnPUUimxs3SgwgrvsjMozNisc=; b=KlR150pBuJAfgSmAE/n5SHab0q
	LeIp6Jny2YVLnsmk3y4gZJ8DlspYiGaH7t7zcLGf1G1Tw55lmVgy2NxG4UYp0CF22fEo4g2U4ZrRs
	uNKXu2OmGgYCE7Y87aaXgRbKFmf56sJYHG2Lrn+mzQqRPEQDUcPxEAVlI1EWXWwC0gww=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSc8A-00072R-4Q;
	Thu, 28 May 2026 14:54:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wSc81-00072C-Oa
 for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 14:54:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=57jUF+lhhGxOOfHidCQJryhhSbNQrKky/44vvRdq5bs=; b=lc73RG5wrCLpyCa4SwVoF9RJAo
 QhvNlBuidEnHxOX6d3bilMdvGOIKSku2pvOOEh9hiF76ymxtqouUzZjpAGy8qDGq6A/jJnglyyPKz
 BFOhsUOOm8PsI00TIG++qKdAL0fK6MgRPKXC4+73mPwoQG0+BDWv6t5W8GrAtCxTd+tM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=57jUF+lhhGxOOfHidCQJryhhSbNQrKky/44vvRdq5bs=; b=KaWCrlpdufBsFBC1I1vUvoM/HE
 k7aEdEWnglWHrLvne1gdd8s1gDoIsE3CBZ5TvmeMgHLFuvyPvGMNEhTWwFRHaiBn1gZiLv5pTnYuc
 T0NUWnkabUiUSLRoVF7JjuPg+AfLJ3ugx4lfX8wJUfnHMdPMNxyG8UBPtT1CakNWgFMM=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSc81-0005bz-4J for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 14:54:34 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4gR8dm6P6tzDsBw;
 Thu, 28 May 2026 16:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779980060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57jUF+lhhGxOOfHidCQJryhhSbNQrKky/44vvRdq5bs=;
 b=PLCMtUKAyV5lZvowli1gJKWxIZDo/DrGMLbmMBJwfAdAYpdHoLVXsp27jHjpEzl4ZxZVXi
 CAzUYZyfnZtDAdAmjlzH4Q7GI5B2cCzc0vVei8dwYz4k230u/T08fdLhT7nMT+PA+G9n4V
 r5EPHyqua2GE/Gf1HVh0o6kJGWdpUbK16GbeCy7sn4uobs+6bIVyPqmO6Ye9FKg/zChHgj
 yu/Y1vGJbuBnisURU9lWc8sq6TFOZGqYsvi4r/0xisenFovloFAwTNioFkddapgCWTRh+i
 OLkdlVNGiM+AiGAzkRH8i1GV4ytyeAcUm8hq/qmLz7KJDywlR9EsozqBs0bi/A==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 28 May 2026 16:53:59 +0200
Message-ID: <20260528145359.3815261-3-marco@mandelbit.com>
In-Reply-To: <20260528145359.3815261-1-marco@mandelbit.com>
References: <20260528145359.3815261-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wSc81-0005bz-4J
Subject: [Openvpn-devel] [RFC ovpn net-next v6 2/2] ovpn: add broadcast and
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

IPv6 link-local addresses are assigned to TUN interfaces so that
ping to ff02::1 can select a valid source address.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 tools/testing/selftests/net/ovpn/common.sh |  1 +
 tools/testing/selftests/net/ovpn/test.sh   | 58 +++++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e..c0ca08171fa1 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -174,6 +174,7 @@ ovpn_setup_ns() {
 		ip -n "${peer}" link set mtu ${3} dev tun${1}
 	fi
 	ip -n "${peer}" link set tun${1} up
+	ip -n "${peer}" addr add fe80::$(( ${1} + 1 ))/64 dev tun${1} scope link
 }
 
 ovpn_build_capture_filter() {
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index c06e3135fbef..e485282025e8 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -56,6 +56,59 @@ ovpn_prepare_network() {
 	done
 }
 
+ovpn_run_mbcast_tests() {
+	local p
+	local peer_ns
+	local -a pids=()
+
+	ovpn_log "Testing broadcast:"
+	for p in $(seq 1 "${OVPN_NUM_PEERS}"); do
+		peer_ns="ovpn_peer${p}"
+		timeout 3 ip netns exec "${peer_ns}" \
+			tcpdump --immediate-mode -p -ni "tun${p}" -c 1 \
+			'icmp and dst host 5.5.5.255' >/dev/null 2>&1 &
+		pids+=($!)
+	done
+	sleep 0.5
+	ovpn_cmd_mayfail "send broadcast ping from peer0" \
+		ip netns exec ovpn_peer0 ping -qbc 1 -w 3 -I tun0 5.5.5.255
+	for pid in "${pids[@]}"; do
+		wait "${pid}" || return 1
+	done
+	pids=()
+
+	ovpn_log "Testing multicast IPv4:"
+	for p in $(seq 1 "${OVPN_NUM_PEERS}"); do
+		peer_ns="ovpn_peer${p}"
+		timeout 3 ip netns exec "${peer_ns}" \
+			tcpdump --immediate-mode -p -ni "tun${p}" -c 1 \
+			'icmp and dst host 224.0.0.1' >/dev/null 2>&1 &
+		pids+=($!)
+	done
+	sleep 0.5
+	ovpn_cmd_mayfail "send IPv4 multicast ping from peer0" \
+		ip netns exec ovpn_peer0 ping -qc 1 -w 3 -I tun0 224.0.0.1
+	for pid in "${pids[@]}"; do
+		wait "${pid}" || return 1
+	done
+	pids=()
+
+	ovpn_log "Testing multicast IPv6:"
+	for p in $(seq 1 "${OVPN_NUM_PEERS}"); do
+		peer_ns="ovpn_peer${p}"
+		timeout 3 ip netns exec "${peer_ns}" \
+			tcpdump --immediate-mode -p -ni "tun${p}" -c 1 \
+			'icmp6 and dst host ff02::1' >/dev/null 2>&1 &
+		pids+=($!)
+	done
+	sleep 0.5
+	ovpn_cmd_mayfail "send IPv6 multicast ping from peer0" \
+		ip netns exec ovpn_peer0 ping -6 -qc 1 -w 3 -I tun0 ff02::1
+	for pid in "${pids[@]}"; do
+		wait "${pid}" || return 1
+	done
+}
+
 ovpn_run_basic_traffic() {
 	local p
 	local header1
@@ -293,9 +346,9 @@ trap ovpn_stage_err ERR
 
 ktap_print_header
 if [ "${OVPN_FLOAT}" == "1" ]; then
-	ktap_set_plan 13
+	ktap_set_plan 14
 else
-	ktap_set_plan 12
+	ktap_set_plan 13
 fi
 
 ovpn_cleanup
@@ -303,6 +356,7 @@ modprobe -q ovpn || true
 
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
