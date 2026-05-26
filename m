Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707A4CD5BD5
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 23:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTLBxFYXRMCbF0c7rGK9YaBd1dVo4Ina2/gLRre0jSg=; b=mqnz6aC7q1zh42V7RzfeZueYsV
	NNW++VZAF9WXRK665kBTP5SkcgucfpgrgLU+hxuj40vvtljkzVNqhw+0EG6n3tGn1vLBcWo9Ho3tK
	FYZD8+vYJ6Ir05+3dlVMllUMqgu6kF5sfZEBTx0+Z6A8yCIUTkt9pCLdf+UkfmTQS438=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wS13a-0002rs-Ej;
	Tue, 26 May 2026 23:19:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wS13W-0002pd-RX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JuwX2RQyhLSm7JVnRRkQX1KUFPvFgIajoELZ+RUujMg=; b=JavLz1ntAPHIrf+FzGE/zJxGKV
 q0gvfQOzmmPx3W84uhoAQgtJo9UqnLZlfuFd1x3hf3BY6Rx+2MX56QkcvFv2lStOqoRu9mKIfp8RB
 1SmPhruAcgFkdszwP6orNrnkezvRwT3Hyowpwq3Zb7e3kV0yn+d8ivpjaR/AnM07AnpU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JuwX2RQyhLSm7JVnRRkQX1KUFPvFgIajoELZ+RUujMg=; b=cVN7XBXgmczOcS/9lGE5CyDLye
 BiRjZJBAlMWC2OCamNx148fxa82L5l1o+WxJa3jFvaokeqSQYMB14HPcSZnwoasFN7+ycae9yTi30
 qF2mdKxQBGAtJfPvAzpubwWPDa3HYZQr16ZfHtkqeIC2sTgD483p3gpLbCHpZLCapXU0=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS13G-0000TI-FG for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:11 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gQ7wy27pQz9thq;
 Wed, 27 May 2026 01:18:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779837538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuwX2RQyhLSm7JVnRRkQX1KUFPvFgIajoELZ+RUujMg=;
 b=hZpVZAxBkARsTAuZhNoforuDYhH2Si0rfNICFvCNIqbM/GS7dj93uA0xCPrLI1uSloH8e8
 yo+H00YS/uUwFXnh6T0/750MJir2kj53zLM6ldDmPY868Vl2xdg4cBPUeaddz8iR+qUL+L
 ziV+t0whQpZCF9Iu8iZfoSAn8KHvh8gdiYPKpnYfDRpjYgAhykXvYZobJNJ6BdAbFQ8F98
 momFHo43Xyb9Ul403Sri7vF528f9ny+eSXExvCIyd6qt1quMbRYdJDWAABo8in2K8aKMOt
 v2PUUpB/CWohdnlWukbIb+XKJWyLeGq+knuzwpBVK35et0AbdH7C46nEUrAiLA==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 May 2026 01:18:45 +0200
Message-ID: <20260526231850.2511369-4-a@unstable.cc>
In-Reply-To: <20260526231850.2511369-1-a@unstable.cc>
References: <20260526231850.2511369-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wS13G-0000TI-FG
Subject: [Openvpn-devel] [PATCH ovpn net 4/9] ovpn: ensure socket is owned
 by ovpn before deref sk_user_data
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
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
