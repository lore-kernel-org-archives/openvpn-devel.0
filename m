Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79224606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FwMNtuYL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cvTaahzu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=F8NENXUU;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=BKmaDFdc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9sxKb5/6kWVbYGCn4VcHHXnFWSRJ3wWLxGxtA055vrk=; b=FwMNtuYLkbwTaq
	4QLe0fAiqgJxv22WTL4CMd+zw0VryjYbv+cTO1izup/hA5AOZpKVtg77a7Ft8SIQxcDcyR1xH3TLR
	YTHZHrtRlcyRsqvW2qF9JJSn2aJlFGh15jC/TjmDfvnEXnJtq5ECZMQ9aYyxCGhx9nEXqUjyRd9Zw
	TIo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWajA-0000000026I-1QPj;
	Thu, 26 Nov 2026 14:45:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xWaj8-0000000026A-3MAK
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:45:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dvjJMThrQgVrj8I/heGGh11qur/Laj/reaj7pGoI8tQ=; b=cvTaahzuAcTnfZqfLGTcxr2fbb
 GhCK95a1k1Ybf/YQGHJOw0jU9dDPTTAelPHKOZr7iKXFZTOHzK3NQqNkRrHC2VLkcU0tPtk6Ild4i
 acJwnodiqpEmgYTrl5OIJ/c5hQ5hgF38aFtOwkH1BNhHcCaSIufw08LD3UIr3carsO68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dvjJMThrQgVrj8I/heGGh11qur/Laj/reaj7pGoI8tQ=; b=F8NENXUUeZ9YJKgdSrRYq72O3r
 1ZWY8CSGJvCiZutBuGuerwOD2KTrRMeyL0THxDIPSiTxSn03zxZ/LKCgDNjGqIdQaoTVH4ZGl+VjO
 fZepEWXqJJ33XWjeEhuT/K0m5tdeUAonZ3aFLRrA7ytBbzf7oGOed8YXk5VfHLbJJP7k=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWaj6-000000005s0-25pX for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:45:34 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jZzqR6hMgzNlc8
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 15:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795704324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvjJMThrQgVrj8I/heGGh11qur/Laj/reaj7pGoI8tQ=;
 b=BKmaDFdcIWEZDvGgxeNuJmOHphES8W2k1znoyK2xfd9FSEQPZzx95P/qF9Wqce3xI0hE4v
 VFQ74OD3VjT/lI+5gCHwYzTsWMZG8+hJMmGqfxeYERBZBI3V1jToj3+Y9TBkDM+6OCZtdP
 nobHuaUzFDdpSGq21HbgKN5dBpHFQDDU8Br5R6f3o/JGi+T+XecQPJDnO5JHqnBdUIU1Ji
 /rmeG5oKYFwXNWFdq2tGrd7iZoDuHNxbsCXoIA3umLYOL8Jr8vVcNOO83bn8vlhFXhyZj5
 t8Fu/wOxbCyRSDkJndaLkAi+KriEM9pFruqzrGqEkuVPRjFYUaNjE38Z6wQKGw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 15:45:11 +0100
Message-ID: <4941179e211663717b4a91a7462238d6d7cbce95.1795703343.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795703343.git.ralf@mandelbit.com>
References: <cover.1795703343.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jZzqR6hMgzNlc8
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWaj6-000000005s0-25pX
Subject: [Openvpn-devel] [PATCH ovpn net 3/3] selftests: ovpn: check the
 error of duplicate VPN address tests
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The duplicate VPN address checks only verify that the command fails, so
they also pass if it fails for an unrelated reason.

The creation checks use OVPN_NUM_PEERS + 1 as the new peer ID, but the
UDP server loads the whole peers file regardless of OVPN_NUM_PEERS.
When the variable is overridden with a smaller value the ID is already
in use, and ovpn_peer_add_mp fails with -EEXIST before looking at the
VPN address. The update checks use peer 2, which does not exist in TCP
mode with OVPN_NUM_PEERS=1, and would fail with -ENOENT.

Use a fixed ID that never clashes with the peers files, skip the update
checks when peer 2 is not configured, and make all of them require
"Address already in use" in the command output so that they only pass
on a real address conflict.

Fixes: 006208026819 ("selftests: ovpn: validate peer VPN addresses")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921102215.3599702-1-antonio%40openvpn.net?part=11
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 tools/testing/selftests/net/ovpn/common.sh | 21 +++++++++++++++++
 tools/testing/selftests/net/ovpn/test.sh   | 26 ++++++++++++++++------
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index da732c64ffea..7c8bf260a588 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -65,6 +65,19 @@ ovpn_cmd_run() {
 	fi
 
 	case "${mode}" in
+	fail:*)
+		# The mode is "fail:<msg>", as set by ovpn_cmd_fail_msg. Strip
+		# the "fail:" prefix with ${mode#fail:} to get the expected
+		# error message and look for it in the command output.
+		if [[ "${rc}" -eq 0 ]]; then
+			ret=1
+		elif ! grep -qF "${mode#fail:}" "${output_file}"; then
+			cat "${output_file}"
+			printf '%s\n' \
+				"${label}: expected error \"${mode#fail:}\": $*"
+			ret=1
+		fi
+		;;
 	ok)
 		if [[ "${rc}" -ne 0 ]]; then
 			cat "${output_file}"
@@ -100,6 +113,14 @@ ovpn_cmd_fail() {
 	ovpn_cmd_run fail "$@"
 }
 
+# like ovpn_cmd_fail, but the command must also print the given error message
+ovpn_cmd_fail_msg() {
+	local msg="$1"
+
+	shift
+	ovpn_cmd_run "fail:${msg}" "$@"
+}
+
 ovpn_run_bg() {
 	local pid_var="$1"
 
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 0762fa83e4b5..5bfa3c8a5fc2 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -74,7 +74,10 @@ ovpn_set_peer_vpn_addr() {
 ovpn_run_vpn_addr_validation() {
 	local addr
 	local peer1_addr4
-	local test_peer_id=$((OVPN_NUM_PEERS + 1))
+	# must not match any peer ID in the peers files, regardless of
+	# OVPN_NUM_PEERS, as peer ID conflicts are checked before VPN addresses
+	local test_peer_id=100
+	local eaddrinuse="Address already in use"
 	local test_peer_addr6="2001:db8::2"
 	# Do not include 0.0.0.0 or :: here. They are invalid on creation, but
 	# clear one address family on update and are valid if the other remains.
@@ -98,7 +101,8 @@ ovpn_run_vpn_addr_validation() {
 			ovpn_new_test_peer "${test_peer_id}" "${addr}"
 	done
 
-	ovpn_cmd_fail "reject duplicate IPv4 address on peer creation" \
+	ovpn_cmd_fail_msg "${eaddrinuse}" \
+		"reject duplicate IPv4 address on peer creation" \
 		ovpn_new_test_peer "${test_peer_id}" "${peer1_addr4}"
 	ovpn_cmd_fail "reject clearing the last peer VPN address" \
 		ovpn_set_peer_vpn_addr 1 0.0.0.0
@@ -108,15 +112,23 @@ ovpn_run_vpn_addr_validation() {
 			ovpn_set_peer_vpn_addr 1 "${addr}"
 	done
 
-	ovpn_cmd_fail "reject duplicate IPv4 address on peer update" \
-		ovpn_set_peer_vpn_addr 2 "${peer1_addr4}"
+	# peer 2 only exists when at least two peers are configured
+	if [ "${OVPN_NUM_PEERS}" -ge 2 ]; then
+		ovpn_cmd_fail_msg "${eaddrinuse}" \
+			"reject duplicate IPv4 address on peer update" \
+			ovpn_set_peer_vpn_addr 2 "${peer1_addr4}"
+	fi
 
 	ovpn_cmd_ok "add peer IPv6 address" \
 		ovpn_set_peer_vpn_addr 1 "${test_peer_addr6}"
-	ovpn_cmd_fail "reject duplicate IPv6 address on peer creation" \
+	ovpn_cmd_fail_msg "${eaddrinuse}" \
+		"reject duplicate IPv6 address on peer creation" \
 		ovpn_new_test_peer "${test_peer_id}" "${test_peer_addr6}"
-	ovpn_cmd_fail "reject duplicate IPv6 address on peer update" \
-		ovpn_set_peer_vpn_addr 2 "${test_peer_addr6}"
+	if [ "${OVPN_NUM_PEERS}" -ge 2 ]; then
+		ovpn_cmd_fail_msg "${eaddrinuse}" \
+			"reject duplicate IPv6 address on peer update" \
+			ovpn_set_peer_vpn_addr 2 "${test_peer_addr6}"
+	fi
 
 	ovpn_cmd_ok "clear peer IPv4 address" \
 		ovpn_set_peer_vpn_addr 1 0.0.0.0
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
