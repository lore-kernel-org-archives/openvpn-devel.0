Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB09CD8C9D
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTLBxFYXRMCbF0c7rGK9YaBd1dVo4Ina2/gLRre0jSg=; b=Y8fH67F+2CqDG8rn3fd9hf1fwy
	ktekRn09SbaK6YRbHN14flvWZDbc/5INSbuhUV9QXtQtBNbJ9mNxMchL44m54vWg+9GyzAVMnXitL
	ONj/VyHR3AbThYuWpCagZNJ9Wjgk3t5aUpuDwkZahUVJxPgEddW0dj7fg7+5k6B43Rvw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWa6I-0001vz-0d;
	Mon, 08 Jun 2026 13:33:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wWa6G-0001vr-4W
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:33:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JuwX2RQyhLSm7JVnRRkQX1KUFPvFgIajoELZ+RUujMg=; b=k3dCvDW65I0eZ2QuO2pIhrq3ZZ
 /oKGbicI2FS4hGtxBKldMFgrhSdRxJakzQ/Szo6wYy2LvW+qI9V4g7Ue5A2Q4SZ9m1dtP+yPxIJZk
 hypvqBy8PNCHuSL8CAccUzuQH/93pTEp/7dmc6vSPxDpGzafDTcidVTvZICXzqJpn/T4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JuwX2RQyhLSm7JVnRRkQX1KUFPvFgIajoELZ+RUujMg=; b=M4HYmlqdoHtwk6VwXKb29A7kxy
 PgWFjQvh1TCncCfU9axZtmaJkjkWAZJ5z5FWJ9wLQSIJCb5qDpUhBZHX5hVTt23zhI1WHwsZyOZ9t
 DiHHKB/xrV0tlkAtOQKsC1xAYCB8NpK/PR9Rj6TVbbVfetZdPbio7twD+ayFj1c2OIjI=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWa6C-0004wM-BD for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:33:05 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gYtJm730Xz9tQF;
 Mon,  8 Jun 2026 15:32:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1780925577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuwX2RQyhLSm7JVnRRkQX1KUFPvFgIajoELZ+RUujMg=;
 b=Z+vhfPoSg9oTHeZKx3rbi9oiPmcIzA4VRq6bE36c9d3dRoBMKA+KmwsU2xJS5SfMBSYGeB
 i7SsdmSGb9+KRVByoh0YysdGzVAiYMXx6q+8v/GbK/gXCATkJjtv6vSTxQk0z0PIxANZY/
 FGC6BNrRrRzMnHZga1vBEOd32HUBOLzBBGrSqbiCkBw0IBAgdZ28sCBVNVf1DpxGVBEa4A
 49dMl46Pf36PAdi68EVHW2epObdlWNG1tIciF3Y2qF3jWD2hJPjrv3C1t989N/W50qIzId
 6c6Lhx09SNzsIyW6un8frBFWJbZb9dGTiwQMxuIszcUPbZnEdYnMAbVmZkYaMw==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  8 Jun 2026 15:32:46 +0200
Message-ID: <20260608133251.3128542-4-a@unstable.cc>
In-Reply-To: <20260608133251.3128542-1-a@unstable.cc>
References: <20260608133251.3128542-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wWa6C-0004wM-BD
Subject: [Openvpn-devel] [PATCH ovpn net v2 4/9] ovpn: ensure socket is
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
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
