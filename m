Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2C0C53209
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MwQgd9got00wHlhrV53CT4w4al0uuUpnTo79rg8BRDw=; b=ZPPRxsyfD+3vNg8+Zix8Yi/R9P
	FowRsnAmCKAs5EaP81JbjBpq/q/5ME6B9gHKD9ssErjKQEiOEMCAJeocMel2g0NRu0X0Y4SG8sluB
	8b+bUK7n3NYpyKjHD7LInq9y9jvNtDc6hqAnUlcbV4QGWikbU8UyowmYUGMMRgPFeAXc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woRbp-0008ME-MZ;
	Mon, 27 Jul 2026 20:07:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1woRbl-0008Lm-Iz
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 20:07:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j4K0CryDDnvcfv4cinY40LKzzK/Yzm1HDYN5nMvZdnA=; b=gzR4m/0KiiK92eCv3hWQJecbv9
 huu4gBo9FWPyXkP5dcg8psIlOCSBixS7BSS8ZMAlRVDPvt956FM9qul2c5bGxN0U3Nx8wukY3I0Dc
 IMQ4JfILgNeHB3yGKQkeJaiFkiroxxbseK86gHW0b7SJ3EcbTyzBNQUzWw2zUGqF3aiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j4K0CryDDnvcfv4cinY40LKzzK/Yzm1HDYN5nMvZdnA=; b=k+xRhFpheFdQRbK7fYEWTv5yTC
 FGLrVYrHYZXwjH0ynogr6OpHXFPcI72LFl2eeILIaHr1x26nCa9Rq3AlfljPzZTFk0gTP6FkumBV+
 XWVY4DbUPmBSBaMiMqxnGw0RX/meHNI22zqMz9R67VtKtHEu747bIkHcp541YSbiqp/4=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woRbh-0001PN-KQ for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 20:07:27 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h88l95vs4zMlP0;
 Mon, 27 Jul 2026 22:07:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785182837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4K0CryDDnvcfv4cinY40LKzzK/Yzm1HDYN5nMvZdnA=;
 b=kGEsLO6qDCoasEG/prSuCCPap8MvDAZWCG8wjELyW1qwuwhcNeob0fUdEyXy1fNYmDIxFe
 5J8iHkDb12Lxhx6biM0rZmzyqO2kPTad/X/RHeYhFSAn63vZPQQxoqqh9R6EpIX+JRqrgF
 m6jcNhn05xpc33MgmXAUiirB3y69NRqpemh4Mf9ub6vtA6KhP1DUvZxoahLySQ8e/QY9w8
 iYZJAfe90z6C5MN97SgbKEjWZqsWcBSK60uyyBJE2nenJV5NJ8GUc8DFMpb0Yhbmf4UPUL
 5HUfFgs8bBOJH4fcr35mC9eiJn0+x7804Vo9uVGuqueFuAqt49RN+dUenAcepA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 27 Jul 2026 22:07:04 +0200
Message-ID: <20260727200705.869169-9-a@unstable.cc>
In-Reply-To: <20260727200705.869169-1-a@unstable.cc>
References: <20260727200705.869169-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h88l95vs4zMlP0
X-Headers-End: 1woRbh-0001PN-KQ
Subject: [Openvpn-devel] [PATCH ovpn net v3 8/9] ovpn: ensure TCP vars are
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
index c4e775250727..f8ae64612951 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -253,8 +253,14 @@ static struct rtnl_link_ops ovpn_link_ops = {
 
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
@@ -266,8 +272,6 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
-	ovpn_tcp_init();
-
 	return 0;
 
 unreg_rtnl:
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
