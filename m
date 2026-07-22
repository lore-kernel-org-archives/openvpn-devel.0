Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A99C4452D
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6kyPGNpIF8nzLgELehr4/gMw5QdBLgeVub+sUsAihnE=; b=J9to6wJZoGEMkUmSbgH6KBxoW0
	1Leyl8vYCKoEBTOy3gNiyAAfF2jK39V+RoQkcOY9X07+lYhKWtoc1mBc+dFwpnYFT0xZeFPAsKB+Z
	ajSE7So/GGhmJswGXqZwyHr1RJVqPVR/v9Hdm1P/RunpP3RPurEiZLjfY1n7YhpZwBX0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmMCv-00018u-BS;
	Wed, 22 Jul 2026 01:57:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qingfang.deng@linux.dev>) id 1wmMCt-00018l-EI
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 01:57:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JLtLRoKFRx5lDX8JA7MpyCYkGwrphsvGUcvl4yquHA0=; b=HgDj9SJXXIHutcxf8zpj3Wzrbk
 N2MZEzAoY3oZHq2S1Fb/jOqnCeso9pqELYWrjkj+oOeQQa7LzI4czsG4osJpjZbqCEo7hZDyzegN6
 CKc/ufXIUqKtK9raKfjfcJ+HIG22mkBPg0AwZyoo6wMv1KtnPyYq1Oy6Lw/LsVKck33M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JLtLRoKFRx5lDX8JA7MpyCYkGwrphsvGUcvl4yquHA0=; b=i
 Ho6xhlslFeWRjoJiwrseEKeRInckd233TZl4O9ZNqAbGBIsEGBPc8ONxuvl6rdtA5GG1GdnAjdLdc
 mahrrKEGOVJCRvt0zqt0Aho8X1sDb39hlPJhCwVhw7KI2VvCTAsH7g5ExbzkDByaYFGqZVlqrsNB4
 rcv/krPbYGQ7+upU=;
Received: from out-188.mta0.migadu.com ([91.218.175.188])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmMCq-0002Tj-FG for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 01:57:12 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784685416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JLtLRoKFRx5lDX8JA7MpyCYkGwrphsvGUcvl4yquHA0=;
 b=ZeDQ2qwNwKnBRSWgX5i0uoCHuLzdkwBUxk22PgaxvDFc2VuMkPmlKBj9p7B2p1r/mN+Dr0
 yh70T4wR2OsMPBtLuwf2j54S06oWYrSut6k2lMRQeUZiS69/c4zrN82gJgjg4pg+yXx6jY
 0sn9xgL5OsZGE+n6YJd6CwzrAM6xIfI=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: openvpn-devel@lists.sourceforge.net,
 Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 22 Jul 2026 09:56:38 +0800
Message-ID: <20260722015638.1295-1-qingfang.deng@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1wmMCq-0002Tj-FG
Subject: [Openvpn-devel] [PATCH ovpn-net] ovpn: fix incorrect use of
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

rcu_access_pointer() should only be used to test the value of a pointer,
not to dereference it. Use rcu_dereference() instead. No extra
rcu_read_lock() is needed here, as the spin_lock_bh() above marks an RCU
critical section.

Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ovpn/peer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a09d61296425..8de737579112 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1164,7 +1164,7 @@ static void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 	}
 
 	if (sk) {
-		ovpn_sock = rcu_access_pointer(peer->sock);
+		ovpn_sock = rcu_dereference(peer->sock);
 		if (!ovpn_sock || ovpn_sock->sk != sk) {
 			spin_unlock_bh(&ovpn->lock);
 			ovpn_peer_put(peer);
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
