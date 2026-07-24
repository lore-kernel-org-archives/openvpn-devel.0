Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B6AC531D0
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XZYt3GYxOULJXu4Rtc6oi7cxjQ+1zVMIPhXM8JC11WI=; b=YWM2W76xPnU9jC4MNr+NBuWCNM
	oB7SU7NvR6HYYie0CM+XAHINde0Zf6H2+R9GnqFyJw6ZNwRokSaMya+7g2YW2o7xgihUOpGllSyi/
	tRFMqeCqUAYp0I0UHa6FEMSGIeF0MkbtwkpNhylMJ2laeJluj01/o8aleuF25Rd4GszM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wn53G-0006fD-4Q;
	Fri, 24 Jul 2026 01:50:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qingfang.deng@linux.dev>) id 1wn53E-0006cV-Fm
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 01:50:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5c4OvNGaZtH3rIpGU3wmibiDmqCdeKwggxfAKQdCr9s=; b=m1r+2BVL69C/3nbSABomqM55dy
 Lx7rgOYD19rvn2NYA98KVlloQ7kpHQKjY3R+4MoD1lZjLJM+8x0fhBg3uinp61KVbb+kdkP6tIA0W
 A3T7xWpANZsP36X5dRz4rDAHVrxhHG5d8hC4s+qyB5/y+WamhWhZcT5KJOMxkUFsnGe0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5c4OvNGaZtH3rIpGU3wmibiDmqCdeKwggxfAKQdCr9s=; b=k
 NZ9twn+gygoLb3n7EIMNNeTwcTehLheW7GNTs+SCIQCu/dPA1MSyku23+nE4/ILpEfwUoWnfel6wv
 mbVR0m4Uo4N/y97ih4g/Ggvave5IuTLYhpeRARYAoffienc9z9rWRc8lw4FtWt3gqRbURPhCIvcL+
 DTW6UGYjSXEbWGeQ=;
Received: from out-171.mta1.migadu.com ([95.215.58.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wn53A-0004ed-Ew for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 01:50:09 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784857801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5c4OvNGaZtH3rIpGU3wmibiDmqCdeKwggxfAKQdCr9s=;
 b=GxBxNr9sAmuE6LVrekGG+pw79IdExSIJKZ6r8eXhbgAyBcqtpWjR+adbLC62U8XUiEGTvt
 2Itbtj2lSnTXEqHvDiLhQCGDdC2LuFAIipY1PFy9PfkdNGuFokSfuC94bHTidoPzTs3IBx
 086wzQ12OxV5ZqtQCywYOrI+mpSbBns=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: openvpn-devel@lists.sourceforge.net,
 Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 24 Jul 2026 09:49:26 +0800
Message-ID: <20260724014926.102443-1-qingfang.deng@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1wn53A-0004ed-Ew
Subject: [Openvpn-devel] [PATCH ovpn-net v2] ovpn: fix incorrect use of
 rcu_access_pointer()
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
Cc: Qingfang Deng <qingfang.deng@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

rcu_access_pointer() should only be used to test the value of a pointer,
not to dereference it. As it's in a spin_lock_bh() critical section, use
rcu_dereference_bh() instead, avoiding an extra rcu_read_lock().

Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
v2: use rcu_dereference_bh() to make lockdep happy

 drivers/net/ovpn/peer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a21d02ac715e..bb3d409b9f1c 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1165,7 +1165,7 @@ static void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 	}
 
 	if (sk) {
-		ovpn_sock = rcu_access_pointer(peer->sock);
+		ovpn_sock = rcu_dereference_bh(peer->sock);
 		if (!ovpn_sock || ovpn_sock->sk != sk) {
 			spin_unlock_bh(&ovpn->lock);
 			return;
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
