Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E6CCD6E43
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 23:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+xPlPBmiEsXVUj9f+cMXoS6tjKKtSJTjscaY+BsBkNg=; b=CbYUblD3uiQ0jUGKren5ckszZk
	NhkQNFZxqRXeLPKfwueeXaViCrm/xwOgm1QrZySadbFUyy1utbikCKcM0L+otJ3mUxO/CPmFh+UHo
	MxURn6rekWnFMK+If17OvMIAaSKwk9i/je+HCXx8aGkuk/IXlGI5WQ9hb3vss3SOMZQs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wS13b-0004Yg-QV;
	Tue, 26 May 2026 23:19:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wS13W-0004Y8-To
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jfvmtc2kSSlcJjFihG7ze0JY2JBgrOhNx9LP9OMiTO4=; b=kKYzuHgUhDQ+hEe49WtCAm6O4U
 IVBEq1dC480Ug77fRmflz7Tp2g11kSR3NyiuDERJ3LWlDImM5TFYfEq6naltkOhuuitVgBspDekMu
 qZRVZ352aexk3YfwQs6o6PA3Paq4CH/+RPQNzDehby+zjead3vKETwsqzvhTtxOmCclI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Jfvmtc2kSSlcJjFihG7ze0JY2JBgrOhNx9LP9OMiTO4=; b=Mxa0pIpL1FlnNDiyzgqB/ml+dT
 F+nTWRq6P5KJsocLhWokqAfg0YL6rrYEwffm2dmLH0vuStintYr8QTW+emilGHZx0KBrusKw+HM6A
 kOVGuxMu6t7im11tAJJdTs8RW7i8X7sEDJEG2E6kc5MRJhhmxkfH6qE5zNUwgItz+VvU=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS13H-0000To-Jr for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:12 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gQ7wz2qmRz9tqn;
 Wed, 27 May 2026 01:18:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779837539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jfvmtc2kSSlcJjFihG7ze0JY2JBgrOhNx9LP9OMiTO4=;
 b=mXi2eBOTQGIOzimNYDJkzcRwq7MO+ZQ5PfAVBZtuzH1qNif7iZk7IGdEh9x5Cht4/VZ3SL
 OZUHuFub8eFUWh8ZNEMPkBewbZXkUrHC2n7YkP9WdudJ8YQ8+ZlyVUd0/cYX+nGwb+ZKNx
 RAb59MNAwJFj8CYM/hxfhe2HWQchwV1buTfBXF5GqjxKqGix1WpZ+aBlFoxzbH7lZ6hxpb
 vXFl1d75WtQ9asRQKNsI6vWC+kQZe6yb84mIPuLC4cehbjLpfHHeE1rnelEwieAu9fhp5f
 l4RbXkwmAF5Qy7IFHNEkkK5tc00Dd4+sLwQES40hVQ3Nm3Hejh0JkPdJJO6JLQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 May 2026 01:18:47 +0200
Message-ID: <20260526231850.2511369-6-a@unstable.cc>
In-Reply-To: <20260526231850.2511369-1-a@unstable.cc>
References: <20260526231850.2511369-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gQ7wz2qmRz9tqn
X-Headers-End: 1wS13H-0000To-Jr
Subject: [Openvpn-devel] [PATCH ovpn net 6/9] ovpn: zero-initialize sockaddr
 before learning a floated endpoint
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

ovpn_peer_endpoints_update() builds the new remote endpoint in an
on-stack struct sockaddr_storage that is left uninitialized. For IPv4
only sin_family/sin_addr/sin_port are written, leaving the 8-byte
sin_zero padding as stack garbage (for IPv6, sin6_flowinfo is left
uninitialized likewise).

ovpn_peer_reset_sockaddr() -> ovpn_bind_from_sockaddr() then memcpy()s
sizeof(struct sockaddr_in)/sizeof(struct sockaddr_in6) bytes - padding
included - into bind->remote. That buffer is later hashed with jhash()
over the same length to place the peer in the by_transp_addr table, so
the garbage padding lands the floated peer in an essentially random
bucket. Lockless lookups in ovpn_peer_get_by_transp_addr() build their
key from a zero-initialized sockaddr_storage, compute a different bucket
and fail to find the peer.

This is also a plain use of uninitialized stack memory in jhash().

Zero-initialize the sockaddr_storage, matching what the lookup and
netlink paths already do.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index bbb1946fa5b4..1d878c3e1514 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -220,7 +220,7 @@ static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
  */
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	struct sockaddr_storage ss;
+	struct sockaddr_storage ss = {};
 	struct sockaddr_in6 *sa6;
 	bool reset_cache = false;
 	struct sockaddr_in *sa;
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
