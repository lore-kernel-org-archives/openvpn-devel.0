Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBDBC54F55
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MwQgd9got00wHlhrV53CT4w4al0uuUpnTo79rg8BRDw=; b=CYTi3rBuXu/0pK2FTQYA2uYif7
	lrKg6tukfXvfWUEKqykqYtlzv8I6jR2dQYhhgTUAC1sDNik9vZtBIrjre71sNlXt0snOdFAhLCo5m
	lVsu3l/nJVsnRLi3BeqgVvw3QGVoUX6uf8+XEark5yh5LJhq2FWKYHHnqZJVhFUdgjCM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogJC-0005td-C9;
	Tue, 28 Jul 2026 11:49:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wogJA-0005tQ-LV
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j4K0CryDDnvcfv4cinY40LKzzK/Yzm1HDYN5nMvZdnA=; b=Iwtaj1ej5ZXhMy6nmNfwp2qPii
 zpL5w4YVPCncQNri3IU2pj8KglZSr589sMFwmXTBhji0QQPBC5pNzO/eqtueML3Q9bfGJCe6SEiYb
 /KQN7g7qmvOU/mRfUq3yVKyG5miBlVsTOkjWcuHm3oPQmskO0zmjAVjYNe7mdDaCXOr4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j4K0CryDDnvcfv4cinY40LKzzK/Yzm1HDYN5nMvZdnA=; b=B5W/Xr433YQK+UdKEHA4CFmmmm
 VdtkGGsKlchaPJYl4BtWesgVmO4nTfJVT42qwy4Kjzk8SwetHNZT3Fn5ZvKoEcc4yBvOqATQs29Oe
 Pg7Kmvc6+OyKlx3QTtuo+H0GnDH3N3LLJN72ybJAAnFU4pqbWBTC3JSjYeaZZ/TZAkIA=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wogJ7-0002v1-Jj for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:14 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h8Yds6wRwzMlK5;
 Tue, 28 Jul 2026 13:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785239345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4K0CryDDnvcfv4cinY40LKzzK/Yzm1HDYN5nMvZdnA=;
 b=C+d8hzx2amUKvJC+3mCNuzpbl81zptRIlteIlerx011raepKGqYsPsZJhaoHymh15aeXRv
 KywapRm4PVW/LHiEqU3ompG9qQkxIEAxn9zEgK8b0KCgvjJLXKWNQwEGyo0+lBRp5GkS1N
 YQKYu5J7RsaN6HMk6AlKLfi0sYS6ywL0JMMYI34wJwbYoVrkZ9GW8nkdsF3aq3VzrcNvlX
 xKGTOJfOVjM0nzzK0GU2Q8F6aatqHMHBUTAIRusT2j5+9Lp2W/6XrpVVG1MpSmliupkJ1E
 8FFAOKCWvJhZ/Y9O4jY3PdeJLLpgpVLxBv4d1fLuZn6b9r2S7DzQYmeW1qBy6Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 28 Jul 2026 13:48:54 +0200
Message-ID: <20260728114855.1323861-9-a@unstable.cc>
In-Reply-To: <20260728114855.1323861-1-a@unstable.cc>
References: <20260728114855.1323861-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h8Yds6wRwzMlK5
X-Headers-End: 1wogJ7-0002v1-Jj
Subject: [Openvpn-devel] [PATCH ovpn net v4 8/9] ovpn: ensure TCP vars are
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
