Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506E2C54FCD
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e89kIFnmwRNssbGxBGgtnZI1ArLKDVAoiXXXoiSuFq4=; b=WiqyKvS0otuwRGPlgRirUX+kje
	PUI0k/dAq+mapnu6nkTOrrLr8F+7mF0qPlmLwOnVCT9VH19hEfG0KVBagNJTxgqHS0GJ/Q5pKMEy4
	WuKFY1/f+vViS5QSU3Dw3cZfE6cL9MoXWzpjutbsekYR6HbpHk3BhIwSD8rxzKYiyaBA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp1Qa-0000Pn-09;
	Wed, 29 Jul 2026 10:22:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp1QN-0000PC-6E
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cVEdZ3i3t9wUqjfdfrCLPyF3EcQBf+QdLVZrCqcZubg=; b=Xq4sKBC8OERBnxWA68nn0XuGQ5
 zsFyTmCAQOHBHC3y/M6EFhQ//C3LREbc9CzOUU84j2uco0Xy0VbhbwqN8URyi120krda8t1yZKTUz
 K9AnNixLyeH/cvWTLyyNlqbNovj9m2W/nwZOyP6kO2yBqjG/AKc28ASaZpJkBGzZW2wE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cVEdZ3i3t9wUqjfdfrCLPyF3EcQBf+QdLVZrCqcZubg=; b=emncrh/NuDge0AV7hLSytyVGQx
 P2TByKyAq0FQMlkC5V2e+knhJa2w35FxN/QB6cqQWRwl1zFcpY7F1TYeekOMS+i3F4k+njMJ12hQZ
 hdw62Jb9vi3n4ViB8/ZYdMt0cA40W4rUGENdGPLQbpjCvP3003C9FQO5jDmwHgPsaFxQ=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp1QM-0003Uc-4v for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:07 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4h97fs5Yc4z9smZ;
 Wed, 29 Jul 2026 12:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785320517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cVEdZ3i3t9wUqjfdfrCLPyF3EcQBf+QdLVZrCqcZubg=;
 b=G9cWrdJg84cU6ROy0emz2fUmeZbkRmkkzWPIOe462T4X3zOZhlPQ3UEgrYFxA1A1uVPZS+
 PIsWBPNr+I5oNmYOe6R8jocIwy/C2dTdc2GUaANHDPpRKbipij36h7C43S/gRuALCamAr3
 wCM9hAk4FjNp5pjQJubM2pGakNjerer5smVWYGHa64O8p9EOsqkdhmkJM4sk3j7mGGvdWI
 Y2XQ1wd8HErwMepRVsBRKVB7vIOqXNWxfiF/jiZpjtP/ZjZk/wdhD4b2qYEjRiq6TjAa7b
 oPSVqXWqJUzvtFRM67sSGu3DS8if4bvyCcDWOWUn/d+5PyHEMeNdqMpjRSazXA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 12:21:43 +0200
Message-ID: <e7af10c8c2e2ece17a3861d03959336238205fe4.1785318038.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785318038.git.ralf@mandelbit.com>
References: <cover.1785318038.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h97fs5Yc4z9smZ
X-Headers-End: 1wp1QM-0003Uc-4v
Subject: [Openvpn-devel] [PATCH ovpn net v6 3/6] ovpn: initialize TCP state
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
when a TCP socket is attached to an ovpn peer, but ovpn_init registers
the generic netlink family before initializing those templates. Once the
family is visible, userspace can create an ovpn device and configure a
TCP socket while the TCP templates are still zero-initialized.

Initialize the TCP templates before publishing the netlink interfaces,
so externally reachable setup paths can only observe initialized TCP
state.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v5 https://lore.kernel.org/openvpn-devel/8f7261c5719fd67b8f0da4d0e89f2c4517fa8168.1783336121.git.ralf@mandelbit.com/
- Reword the message and drop the extra comment in the code (Sabrina).

New patch added in v5.

 drivers/net/ovpn/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 9993c1dfe471..5093a3b5aba6 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -233,8 +233,11 @@ static struct rtnl_link_ops ovpn_link_ops = {
 
 static int __init ovpn_init(void)
 {
-	int err = rtnl_link_register(&ovpn_link_ops);
+	int err;
 
+	ovpn_tcp_init();
+
+	err = rtnl_link_register(&ovpn_link_ops);
 	if (err) {
 		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
 		return err;
@@ -246,8 +249,6 @@ static int __init ovpn_init(void)
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
