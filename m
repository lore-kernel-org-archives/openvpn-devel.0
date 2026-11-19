Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D14606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Zx4bdrmh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QK6aUYup;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lf8UIEHz;
	dkim=neutral header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=tLQ+/XQp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Date:To:Message-ID:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=xDE+toaxTqcvx2SxzQ6MoV7eov5nfRZx4oa7s4mgFJI=; b=Zx4bdrmh60esaVIiUn5XE9eDrl
	5Pu2we873PQmnC+lbq9UyIzQi26yK8zNjzoGOP60DZdnu9lTgXLtqO4G+Z3LXH+cfk/sXY6/gpC4b
	71haL0qeg5AB9+ZzdKALrQb92cCAi77HWTUZY6QePwrzZUdbXhARDN3jec7rCrAYtV3I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTtwc-000000000Tc-3CwM;
	Thu, 19 Nov 2026 04:40:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <979504756@qq.com>) id 1xTtwa-000000000TW-29UG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 04:40:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject
 :Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s4UjmGAja4Na2Agz89VB7BPgQ6DIhnT7UuqhwEyN1FE=; b=QK6aUYupnEtkhfXkPq3zqDJQeN
 8JXUHAF+3LqpkxDtKMQ3kS2utR2UeReesXfgdE4SIDv94pd+dHUB5St6TSEfM1Q0qLKraZk9D5/Db
 gCRizNOvlRDt2qlAtAbgMbGbFgjuKoucQF6o05rNARmSVWocJKTrA7HHzAraorFLi+V4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Message-ID
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s4UjmGAja4Na2Agz89VB7BPgQ6DIhnT7UuqhwEyN1FE=; b=lf8UIEHz8w1j0e0SzFMGCqxvU0
 X/JvAJZbJvD8/GTzy/51Esbvxt6MMGUibOVQ74k77J4OLOx9XfSv2uoTWw8j03Y38SjzIrwpByBN6
 fLalFxmr5w+mHKifKWZ7RerMOcxDUaz5k9eYWwNpHLrC7hz5SLhN4B8nDAaAk051au6k=;
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTtwZ-000000003TI-1DtE for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 04:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795063209; bh=s4UjmGAja4Na2Agz89VB7BPgQ6DIhnT7UuqhwEyN1FE=;
 h=From:To:Cc:Subject:Date;
 b=tLQ+/XQpJCi7A3sl+dEx8WJyD6XpwFhd95fTxKvPzpBmktdvOpTvDnN3ymT315Sy/
 4xBkRCQcd5EWE4X9JubXj+DnTSYEIKY0E5vP/7poQ8PPYx5fqlE2m+sYTpYIyci1yA
 pcbv7MIFJSRIe1oOQv4iuuLno0Gc5skxa0DEqm/g=
Received: from VM-0-17-ubuntu.. ([124.223.3.35])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id A0804E4C; Thu, 19 Nov 2026 12:40:08 +0800
X-QQ-mid: xmsmtpt1795063208tdyhqva0v
Message-ID: <tencent_DB0ADABF741A42D32620ADE82AF77005FC09@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9X8Aya9sZPzOzJXi3wQae8u+tPKLi1oS8Ftu45bmt3LNlHpHJ8sl
 OYjiTfxme3gk45X0OLxZhAgZMQlDyFVsMWK2vMP1eOujrA3B6bxMZv5VFQUZZlhI3cJcZ+vuZGan
 8GwxFc90wC91tfdHfECSnCgnjgcVxaxhszGV9aWP35c/7/bCGYdqcEb9fenK9KnfjHVFeY1YNl5R
 F1nXQ7/Gx0w6du5WVRybzzWUGiK0mJN3Zikl1zN42eKYz/Qv7jaH6aaYPIQSB5NZW4ACWqIKGE6u
 EqqvH/+fGgRoUQUwRaQTYQR1MmnfYAGPNqbh8p1pmQdYNON2rfHmhuIKuf7TQZNWrQRd31XynNHP
 Q9xWikxn25cZLjDrJ9Pay40Bjm0wq0cGx/D5X38A4MfVUVEO/Qi6LryBAUbzlhFmyDnkiJvOH9T8
 PGulyimBluTeH+6Zt8m46K8waDpVD3dknRqmfDZ3qsGi2Uop429TPGJ1m7mo+n6N6pCMDVV6D6rc
 B5oHd6Hs2q9GIfUc3LYbZkNWmuFnnV4t+iW9PWgFLNjskhihEsNEoFgh5h+O4knYXdiKbzbilmWq
 KEX19Yx/B4aUCUmN5Efmb4K3gPtr/nszgQfO6QTqG8bthDnflVrFWDLqnDb9BR8sWcqseQOS37Lc
 R77TMeAGdN+AzQhubvvqaIQ3SylintxQtOYkf+l+ebr3f1hO9f2Ky1udLB07gdaR9ZqTY3n6nSwp
 5brtmzgS8/eFRvDpWvAeQtOroc6MeoejHFiIs/ayZc0y5yWsITmSkH9bGTQGuFMx0D+PnF9XV0OS
 vifmpimmFaIPIU/spqqE/gjcmKF67p72Ko/955DiCkRqupT0dh67HQ3VUUUv99lDRN4Nen10eayY
 BEalGnQ9X6Wmyr2Sdty/JNRcaenkA3DaDLY+lMiRCLEeM9Sd47yRaoxucfj/LLfFGxkobBBhj3FT
 PFUg0WPjtAfRT1Jyp3wt7NcE7qkbNgBx+G3EdPztwC12mPxCJ6BGNiG2G5eIjfcx+bIdZKrFDfS4
 Zf/1vBitT/RSZ5Zv9UpB5AudDVofI9OC/wA4d+TQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 19 Nov 2026 12:40:08 +0800
X-OQ-MSGID: <20261119044008.3579348-1-979504756@qq.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xTtwZ-000000003TI-1DtE
Subject: [Openvpn-devel] [PATCH] ovpn-dco: fix IPv6 VPN address comparison
 in peer lookup
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: Liu Chong via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Liu Chong <979504756@qq.com>
Cc: antonio@openvpn.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In ovpn_peer_lookup_vpn_addr6() the word-by-word comparison uses
'continue' on mismatch, but it only skips to the next word of the
inner loop, not to the next peer. The comparison therefore has no
effect and the first holdable peer in the bucket is returned even
if its IPv6 address does not match.

In multi-peer mode a packet can be sent to the wrong peer whenever
two IPv6 peers share a hash bucket (with a single peer per bucket
the bug is masked).

Replace the broken loop with ipv6_addr_equal(), like in the IPv4
lookup path.

Fixes: 94581f0cb760 ("ovpn-dco: restructure code to allow supporting multiple link to peers")
Signed-off-by: Liu Chong <979504756@qq.com>
---
 drivers/net/ovpn-dco/peer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn-dco/peer.c b/drivers/net/ovpn-dco/peer.c
index cecbbb4..aee9f11 100644
--- a/drivers/net/ovpn-dco/peer.c
+++ b/drivers/net/ovpn-dco/peer.c
@@ -355,14 +355,11 @@ static struct ovpn_peer *ovpn_peer_lookup_vpn_addr4(struct hlist_head *head, __b
 static struct ovpn_peer *ovpn_peer_lookup_vpn_addr6(struct hlist_head *head, struct in6_addr *addr)
 {
 	struct ovpn_peer *tmp, *peer = NULL;
-	int i;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp, head, hash_entry_addr6) {
-		for (i = 0; i < 4; i++) {
-			if (addr->s6_addr32[i] != tmp->vpn_addrs.ipv6.s6_addr32[i])
-				continue;
-		}
+		if (!ipv6_addr_equal(addr, &tmp->vpn_addrs.ipv6))
+			continue;
 
 		if (!ovpn_peer_hold(tmp))
 			continue;
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
