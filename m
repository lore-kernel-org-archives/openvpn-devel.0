Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E58C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kMNkgUjNrDHWjhafr/m2PoOCq5FcztEQ3XSBKmeFVzk=; b=AGVKeG4yM0+P3kB4PguHMr3Osl
	QYs+f0fvknZuttvmMlpJ2B0CeIgrH6hC/4wsQwfVE9wIy4oUwzqxX9B9M/111vccZlPKMkuOBVnY2
	xXq5q1SDLZWzXf/PUaxxfUoClaB/cA1eEIC9cvi6mvRVzdIV5JQiVJqO79X7yaAwmeOg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp1Qe-0002o7-9C;
	Wed, 29 Jul 2026 10:22:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp1QP-0002nc-WF
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s7mKFePLkVlKhOpo7ibGf89xR4bksuWw337+41qyzQA=; b=ZpZkhczZJnGm/hVneSf9J9FTD9
 NiUG3fWIhKIK2zf3DBbmOTS7B8aV7SUS/IYXZvmm5XF6dzeDTI37Rb5KKSbrDwgfqQxAP3vifYrNs
 dvuwW9VYxWk/s3B/gVgCk/Vnx+vPTRndS+/dhkMwJW1IV8NxQUYu5TmRQEeRg5saoas0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s7mKFePLkVlKhOpo7ibGf89xR4bksuWw337+41qyzQA=; b=bnjGu8J6GR36wys6XvYp6G/HHA
 +NUv5FmoE1wPxqKehnQWl9cFnsm4MHWHALwabW/rx5Ge6bfjJvlW7I14Xb6kNKlKkWOpLc4dks7i/
 QhMcbnbFTzreTZzXXTfrgo3DO+Nb1qt++eBrzO1MksHWhk+EA1yFFw7vP79QCClVxyGw=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp1QO-0002fC-Ru for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:07 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4h97fs0SLHzNkMP;
 Wed, 29 Jul 2026 12:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785320517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7mKFePLkVlKhOpo7ibGf89xR4bksuWw337+41qyzQA=;
 b=OuckQJ77/xY1Ohkm5e9wVza5iH7JcnwFEVUISPpIojZ+rGkeH9Qy32kSnOAzlbkwiy83q2
 5dGwJtGyqRd/uJyylqi/3tVf2hUulSdDlb8HBQ82iYTKfF4UeTvMS816riWDdrxJRmiggP
 9Bt1Hdo19zRo9HZ8sQX+b1JKd0fYBHk/16K9VKWSgKvlstMXKPoHYjWW0ig6KKNjt6M9tz
 oA9QjAx2ahsrUskyJ1QNXEEZxpkz4Tomycb4e11fQfWAQhsUrdkIvFQDG81SlAtaZWtR97
 AvSMbrvbtjE0gooT0tQCg9Y4UdOfQeBDteO380YhmXpwLBxtjCYOTw6h+0MD4w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 12:21:42 +0200
Message-ID: <f8c5e9a662db2c47c3872b1ff3b9c8a09386b89b.1785318038.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785318038.git.ralf@mandelbit.com>
References: <cover.1785318038.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h97fs0SLHzNkMP
X-Headers-End: 1wp1QO-0002fC-Ru
Subject: [Openvpn-devel] [PATCH ovpn net v6 2/6] ovpn: use nla_put_u32 for
 the key ID attribute in ovpn_nl_key_swap_notify
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
Cc: Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Currently, in ovpn_nl_key_swap_notify, the OVPN_A_KEYCONF_KEY_ID
attribute is packed as a 16-bit value despite being defined as a 32-bit
u32 attribute in the YAML policy.

Fix this inconsistency by using nla_put_u32.

Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v5 https://lore.kernel.org/openvpn-devel/6e44855f0fcd704da43dd83b42a1236cb804c76e.1783336121.git.ralf@mandelbit.com/
- Add Sabrina's Reviewed-by tag.

Changes since v4 of this series https://lore.kernel.org/openvpn-devel/981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com/
- Add this previously posted standalone fix to the series so the whole
  set can be picked in order.
- No changes since v1 of the original single patch
  https://lore.kernel.org/openvpn-devel/8577555cc95646d0bd58a5b78e59c7e6a9b1a0c6.1783058844.git.ralf@mandelbit.com/

 drivers/net/ovpn/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4c66c1ec497e..abf038206a62 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1335,7 +1335,7 @@ int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 	if (nla_put_u32(msg, OVPN_A_KEYCONF_PEER_ID, peer->id))
 		goto err_cancel_msg;
 
-	if (nla_put_u16(msg, OVPN_A_KEYCONF_KEY_ID, key_id))
+	if (nla_put_u32(msg, OVPN_A_KEYCONF_KEY_ID, key_id))
 		goto err_cancel_msg;
 
 	nla_nest_end(msg, k_attr);
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
