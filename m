Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC55C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y6ZG8HufGNFuzv4KbdMmmc+uki3k3ZL6y7H+1cVGCB8=; b=FUBJEUtXuTReAVpN7c3DNGjrx+
	t37Rg4bhfGi4LJ6ELUH42sHm/jR0ob1LSnjFoHH1tcYzCgVRPZ0JOBPsTVDdvPD8z+f8i9ISb1wMT
	WtUSCyd8AdDUK1PrZ0uDus3GBjZY+I2DuEXrERt4pFupJaSYewX5nPMcM+KS+0G2C9RI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp6NH-0006Xi-EU;
	Wed, 29 Jul 2026 15:39:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wp6NF-0006XY-TH
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uxFnNYWi9JqAYKRB0/CmXjoJavVFqxjWbA5wHRXq/xg=; b=ZbYl5XO1DR4yO36EfxZ/sDt34v
 zGrbD4+c8aVHSVBDYFak6I/QPuaQrOR6Cplj0feByGT6xUOmTXTr8dl3LQB+4xum1bKAkEMzpDnha
 mBA6cvMxb7cHKFwDja/c6hrJYK3WNy0LCgOHXfrOVIrRANs6aMdQF6CThzcFKTjZSCuY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uxFnNYWi9JqAYKRB0/CmXjoJavVFqxjWbA5wHRXq/xg=; b=gQtlLYpJTKOd0Vtrv7HYK8gFuf
 jQ3KVMMkDZtspXa8B+3KiLOQ265kstfjLlbii9o73fCvJlCRU5h8lCpItHhEu2LA+pg0GU1KQlmv9
 15LIESA3QcJBD0GnBX14o8VvROCrx0bFOpdm/lzv0NK9wiEcsti+z8XzwJaSxmLy+DiM=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp6NC-0002p7-Ck for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:39:14 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4h9Ghk4N89z9tFx;
 Wed, 29 Jul 2026 17:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785339542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxFnNYWi9JqAYKRB0/CmXjoJavVFqxjWbA5wHRXq/xg=;
 b=l96ppsA+yyQAlrdq5KNXB+0/de9k6N3X3o9b98jy+DtQlpHqISN0f9OstsRds2Fb/URD4h
 5VxKgVUYaS/j+eFYpfj4uYVTXpBksmT3Ew/OL5vzpjSmzct+m7eb6UC2j/ResZxdlAtIGr
 MH5yjDthXkM7n4MASeUi84EwNA6u9bc9C1ZmyaeA0lFwfBWoCsxyujATX9U6dpIuG2YJam
 qOTeeOT/vrZnXote2keQleZIYLrXsOjFwikr5U5OaraTjgv+xbSSwmFuIvj+cGAu2kGJvd
 vN1Oi9eW5kXNC6XIUFRURx+xuUAd9AU2o6RRMcuf6dxV4jAXacrzrMk/SzqGgQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 17:38:15 +0200
Message-ID: <20260729153815.2637139-4-marco@mandelbit.com>
In-Reply-To: <20260729153815.2637139-1-marco@mandelbit.com>
References: <20260729153815.2637139-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9Ghk4N89z9tFx
X-Headers-End: 1wp6NC-0002p7-Ck
Subject: [Openvpn-devel] [PATCH ovpn net-next v3 4/4] selftests: ovpn:
 validate target netns ID in notifications
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

Move one peer interface to a foreign namespace while keeping its transport
socket in the original namespace. Verify that its deletion notification
contains the expected target namespace ID.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
Changes in v3:
- Ignore unrelated events when validating
  notification target netns IDs.

Changes in v2:
- This is a new patch.

 tools/testing/selftests/net/ovpn/common.sh |  3 ++-
 tools/testing/selftests/net/ovpn/test.sh   | 25 ++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 4f2510fb6d7f..2b90b7bf8700 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -21,7 +21,8 @@ export OVPN_ID_OFFSET=$(( 9 * (OVPN_SYMMETRIC_ID == 0) ))
 
 OVPN_JQ_FILTER='map(if type == "array" then .[] else . end) |
 	map(select(.msg.peer | has("remote-ipv6") | not)) |
-	map(del(.msg.ifindex)) | sort_by(.msg.peer.id)[]'
+	map(del(.msg.ifindex, .msg["target-netnsid"])) |
+	sort_by(.msg.peer.id)[]'
 OVPN_LAN_IP="11.11.11.11"
 
 declare -A OVPN_TMP_JSONS=()
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 468dd7985c8f..52e482641016 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -270,8 +270,13 @@ ovpn_run_timeouts() {
 
 	ovpn_log "Setting timeout to 3s P2P:"
 
+	# The transport socket stays in peer3 when its interface is moved.
+	ovpn_cmd_ok "move peer3 interface to peer0" \
+		ip -n ovpn_peer3 link set tun3 netns ovpn_peer0
+
 	for p in $(seq 3 ${OVPN_NUM_PEERS}); do
 		peer_ns="ovpn_peer${p}"
+		[ "${p}" -eq 3 ] && peer_ns="ovpn_peer0"
 		ovpn_cmd_ok "set peer${p} P2P timeout" \
 			"${OVPN_CLI}" -n "${peer_ns}" set_peer \
 				tun${p} $((p + OVPN_ID_OFFSET)) 3 3
@@ -279,9 +284,29 @@ ovpn_run_timeouts() {
 	sleep 5
 }
 
+ovpn_validate_ntf_netnsid() {
+	local peer="$1"
+	local target="$2"
+	local expected_netnsid
+	local received_netnsid
+
+	expected_netnsid=$(ip -n "ovpn_peer${peer}" -j netns list-id |
+		jq -er --arg target "${target}" \
+			'.[] | select(.name == $target) | .nsid')
+	received_netnsid=$(jq -er \
+		'select(.name == "peer-del-ntf" and
+			(.msg | has("target-netnsid"))) |
+		 .msg["target-netnsid"]' \
+		"${OVPN_TMP_JSONS[$peer]}")
+
+	[ "${received_netnsid}" -eq "${expected_netnsid}" ]
+}
+
 ovpn_run_notifications() {
 	local p
 
+	ovpn_cmd_ok "validate peer3 target netns ID" \
+		ovpn_validate_ntf_netnsid 3 ovpn_peer0
 	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
 		ovpn_cmd_ok "validate listener output for peer ${p}" \
 			ovpn_compare_ntfs "${p}"
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
