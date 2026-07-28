Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A79C53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oj8Z5EuLMRxrE2iZMLlUC+4BrcJM5h7LPIlkZgChsak=; b=Z9ASxpMo+VhFi/W9NAu9+ZBP6V
	0fMwymfJVM0RXBKKWxhZX8CCTMjUt71uM/IdEyMqA5AiRoJSDgdDTPLyUELuP2ZrbSURbmDmY+phB
	KY3LZdjVQfun6S3WaZ9azKGGpXqri79V2cmAbOiENQPi1GaeqWM+m/CUh1TcJ+EDNpPY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogJE-0005u1-MR;
	Tue, 28 Jul 2026 11:49:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wogJC-0005tm-Kz
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ixElgIOpjex/L7zdwx7lUWOiWK5w4EbBc2Uvh57Z4fI=; b=RfR/lFoExguXPt5pDF1Q2td/Qi
 KXwTsYRt0Jd0eV8G3fUiSI4hQsJS7KoXEFkpISs9YoMJP3Kun0udLtk6rvcqEOnG6JmgtTd1ROLDL
 o0yI9KkcRgkXBVNbbWGgARSgO+AY6MRR9zICObKyscZQffIwKVbjgEW4CatofjuqYIwA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ixElgIOpjex/L7zdwx7lUWOiWK5w4EbBc2Uvh57Z4fI=; b=c/nMSEP1+ykwDqu/hqhwdbj4dv
 FlwYidV1RDpkGlynJnbwLZbbWdCQtA3vjQ1FpnwqyVCKBPMO4QXrtgNUT6APwEANK1I6HWMyGO3Vo
 /4Kt/S7hn3DlXActe+aCWtq96CAKSSGFS8IgLEVeivLzA44WiT7xGIppWboVp+gfBhsE=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wogJ8-0003Bm-OM for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:16 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4h8Ydq5DD0zKnVJ;
 Tue, 28 Jul 2026 13:49:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785239343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixElgIOpjex/L7zdwx7lUWOiWK5w4EbBc2Uvh57Z4fI=;
 b=innx1MXgJawRmiOXavFrlkBE5FebLjSyZKJY4RAsQkqB98DHfAecbvYD+M6xw2ingIfiDr
 yuV34c/XEj2xPeEXMLjqi5xcqDpQ0+KaDnjicLkLdvUq8nY4Fe5m/HHvoLD9BHmPv4klHV
 cooyMUrhbQdsqyaf0y2LvaHkN1PO4RiW10Vy470VDGTkms8ZtWJewHt47n+a4HD9wEUAmB
 dhi4kZ8HVBvBFqZDx9jbQrGK/othnHKJUxPTxO3grByEpH3E41Ou+IHc4SnWhqZeqbkRmR
 nhsU3G2vHa15NB/3dpctLWNxBdGGIQyRbJMKwKDiatae6B9rJK6qm+g5kAlGsA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 28 Jul 2026 13:48:50 +0200
Message-ID: <20260728114855.1323861-5-a@unstable.cc>
In-Reply-To: <20260728114855.1323861-1-a@unstable.cc>
References: <20260728114855.1323861-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h8Ydq5DD0zKnVJ
X-Headers-End: 1wogJ8-0003Bm-OM
Subject: [Openvpn-devel] [PATCH ovpn net v4 4/9] ovpn: ensure socket is
 owned by ovpn before deref sk_user_data
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

From: Antonio Quartulli <antonio@openvpn.net>

Some subsystems, like BPF SOCKMAP, set sk_user_data without
actually setting the encap_type.

For this reason, we must make sure that the type is the
one ovpn expects before dereferencing sk_user_data.

Failing to do so may lead to out-of-bounds reads.

Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/socket.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 517caa64a4fe..6cbeb2caaeec 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -162,6 +162,15 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		rcu_read_lock();
 		ovpn_sock = rcu_dereference_sk_user_data(sk);
 		if (ovpn_sock) {
+			/* something else filled the sk_user_data without
+			 * setting the encap_type. Reject the socket.
+			 */
+			if (!type) {
+				ovpn_sock = ERR_PTR(-EBUSY);
+				rcu_read_unlock();
+				goto sock_release;
+			}
+
 			/* socket owned by another ovpn instance, we can't use it */
 			if (ovpn_sock->ovpn != peer->ovpn) {
 				ovpn_sock = ERR_PTR(-EBUSY);
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
