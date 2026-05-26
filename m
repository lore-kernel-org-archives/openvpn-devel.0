Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F06CD6E44
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 23:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rUWQF8SNLD3wFAs7D7NWrVe1YnReAFzszAGiE/rgB48=; b=VeTEe0BTksIrftzeh3DLTvdLvh
	yxjA+sxj+mPefYK3E+nhtFFCLo2eYh1BnveFJaWxkDtBBOyQ5P2wBnUUcwx9REs+O5YHqhkRk9CRO
	FeBJZ3/+o48XkJa48MHht093Phnu+P0IOzAdnQmCuftRBIYpSTlXY8ggoVeYsioYZlvg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wS13a-0007Kg-81;
	Tue, 26 May 2026 23:19:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wS13X-0007K2-Do
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oUrXqBhmSv6hUIjm7a15fhpW2j0ChPArt7p7zWguUEE=; b=HvhZs60FU17S2c42nQjwaT511x
 IyLH38ljvMTfP35NcMfNXp7jl/KFayb0zxkccw6ZrBHocz9SBj+uHitEq1GXaNn2T7O3xJwp/wu4H
 vLdxQDwsE2VoBM7uYB/EnkZchB1P38XswTuBeHxA6DlBshJyMTI3eywn8Un9AI6wrZAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oUrXqBhmSv6hUIjm7a15fhpW2j0ChPArt7p7zWguUEE=; b=eymmkGIPiPSA/qKOCkleg5FezI
 cSFb/k8s72wPnA2xL/u1sAIkOzQfbMtr0EagVptwzpLpxYM9RHSarGnrd+1A9YNVt4m6v+fmdryjz
 31QL+DJTUwzfUv0JDxdY7ee0cYqm1gUcjjCvxXmsVDgnAuITcSvSgisEt2uB2Lj1YHi4=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS13J-0000UV-A2 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:15 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gQ7x06trGz9smp;
 Wed, 27 May 2026 01:19:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779837541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUrXqBhmSv6hUIjm7a15fhpW2j0ChPArt7p7zWguUEE=;
 b=OtRg6AOpKkFzWqoW1pQXdCq/aZ/m/Bei2aEOK6PRO1fqIB0KWmfyJ9tDJKOHP+sg3JkPo/
 lDOliRBaXLLFKDM6PkDizoRXdYhei4yl8AF9Ga3/agkPIwKgy10n5c9ny5qdiSYWH58PAC
 OHZ20QtO25AQzMroAwOZ5qMWw9+WOOgdnV67oQir4EpZHVpVFcg/AcVADTxZpjhojD/TtP
 GFYoBz5/kUxoFnOkCBMaB+i80GR/JmVg8uwbIbdVG2hf/lEijKsqtdaGOKJ6jX1opoEWf5
 3ZbLGKpYgdz5D0zYwLtZ9oZpx4TRBcz17flCBccRmlrcH+6rZKejCO0NdFwP6w==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 May 2026 01:18:50 +0200
Message-ID: <20260526231850.2511369-9-a@unstable.cc>
In-Reply-To: <20260526231850.2511369-1-a@unstable.cc>
References: <20260526231850.2511369-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wS13J-0000UV-A2
Subject: [Openvpn-devel] [PATCH ovpn net 9/9] ovpn: ensure TCP vars are
 initialized first
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

Netlink calls may access TCP global vars (i.e. when attaching
a TCP socket), therefore we need to make sure the
latters are initialized beforehand.

For this reason move the global TCP initialization at the top
of the module init function.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index a881510aaac0..0a88ca6bbf97 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -244,8 +244,14 @@ static struct rtnl_link_ops ovpn_link_ops = {
 
 static int __init ovpn_init(void)
 {
-	int err = rtnl_link_register(&ovpn_link_ops);
+	int err;
 
+	/* init TCP first so that any subsequent netlink operation
+	 * is ensured to access initialized TCP global vars
+	 */
+	ovpn_tcp_init();
+
+	err = rtnl_link_register(&ovpn_link_ops);
 	if (err) {
 		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
 		return err;
@@ -257,8 +263,6 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
-	ovpn_tcp_init();
-
 	return 0;
 
 unreg_rtnl:
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
