Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E780C43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DloSsKR8VqCaWPSFvkUMpWgOs46pS1qoWzHAwe+2iA0=; b=RIppAwYdF1pH7BZoZslph16Y8T
	UFeNeMocxBzXTOjJlB+uUou/94nZG9mnmr9XhP1eGzoKuuHFnEinl/H99EJrb34n1zmwCL/nthUGo
	weB17SyPsp0o+UL1g3WN0d55EBuBPrB13DJ8sLa5zf0WNjORjN8P3pIPTo+k1MRrtoxE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wghaw-0003K7-6v;
	Mon, 06 Jul 2026 11:34:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wghau-0003Jy-17
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SN6qKq3nUv1NvP40f2gUOtp7ZmlmgEK8Y53JvCU9ukc=; b=BBI/RL2tPoKS2sjtDFyzjTX9td
 4/MIsOK3/DEyDuMt0R+EtgXUtXUo409zFpqG7KhDdSbtmyG2lEY0OPSWjEwKUEm/EniDvr3Ty2pcT
 uVVUzetpLVE2LvgOcMcYSrM7iw5Dr0xWCoMcM1avxLJ5c5Sr0GrLxV4z9rAUHdV97R6A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SN6qKq3nUv1NvP40f2gUOtp7ZmlmgEK8Y53JvCU9ukc=; b=ZRSSw2mOCgY97ZGRvKAk3fIKif
 HJlyFd6VX2LB5QTqUTfJsixZxGkxwrg0DAAqWzglC1DElvN35n7JzwniZky2kM8hVC14MqSEN1O5j
 XHtxweolIT0Y1MeAgA696GgYQ29LTVexT1VAhkC3uFFBQt9WkAKZzT0glRqMsxX6zdUg=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wghar-0006m0-OC for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:35 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4gv2M202grz9xlp;
 Mon,  6 Jul 2026 13:34:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783337662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SN6qKq3nUv1NvP40f2gUOtp7ZmlmgEK8Y53JvCU9ukc=;
 b=boMrpmP8Zi4NhoROntn1Ysak8gX5dVw9PGf7vuzZst5DxkwZQcSS67d1F6xELg8XhZ7K4J
 1z6iAB1p7mKwl5uO6w5Lnsp4Gp6Ne7eY13uhLdAAH9oE9L8pkEm4H+9UYrHVcoz52NdAyk
 PI6f/q0ZkwAsbDw5MiW4zSA0DAQJGv0/qaiIOmmiontFluUWJfJ/3zSzs4GoZQcZtddssH
 ZlezvZPFRO5ECnxwVTepSvE70gOHm1DyFtY1oRgnGhgJ65+XQwypaFGeJBWCxLOoi1PXVK
 WEsKAE29sQ6LqxWv56SCYIHoYGiXh1YBUHyWr9VZog5XhAoWfRrr0OLSTz4XKQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  6 Jul 2026 13:34:01 +0200
Message-ID: <8f7261c5719fd67b8f0da4d0e89f2c4517fa8168.1783336121.git.ralf@mandelbit.com>
In-Reply-To: <cover.1783336121.git.ralf@mandelbit.com>
References: <cover.1783336121.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wghar-0006m0-OC
Subject: [Openvpn-devel] [PATCH ovpn net v5 3/6] ovpn: initialize TCP state
 before registering UAPI
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

ovpn_tcp_init initializes the TCP proto and proto_ops templates used
when a TCP socket is attached to an ovpn peer but ovpn_init registers
the rtnl link ops and generic netlink family before initializing those
templates. Once either interface is visible, userspace can create an
ovpn device and configure a TCP socket while the TCP templates are still
zero-initialized.

Initialize the TCP templates before publishing the rtnl and netlink
interfaces, so externally reachable setup paths can only observe
initialized TCP state.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
New patch added in v5.

 drivers/net/ovpn/main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 9993c1dfe471..c2c3af0c3c55 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -233,8 +233,14 @@ static struct rtnl_link_ops ovpn_link_ops = {
 
 static int __init ovpn_init(void)
 {
-	int err = rtnl_link_register(&ovpn_link_ops);
+	int err;
 
+	/* initialize the TCP protos before the module is exposed through rtnl
+	 * or netlink
+	 */
+	ovpn_tcp_init();
+
+	err = rtnl_link_register(&ovpn_link_ops);
 	if (err) {
 		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
 		return err;
@@ -246,8 +252,6 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
-	ovpn_tcp_init();
-
 	return 0;
 
 unreg_rtnl:
-- 
2.55.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
