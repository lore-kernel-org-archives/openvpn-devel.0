Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ADECD98DE
	for <openvpn-devel@archiver.kernel.org>; Thu, 18 Jun 2026 06:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=56HKXxVefj6m0BBuPrXM+vKDZV3pWBLJUS0O3doLtjI=; b=lF6r3DthWqndD5BcOTBQsr7ipB
	i5sOD0LKVn591WJUTZULXeGlFQk63+raHRzYgIEHLN1A1zCNOQc9Eyk8clyf3tNupflP/yB+BTa8r
	ez/Mv+DV0ib5ucpmbZaseR/SnJca/4QrqS9AvsSiR9EkHuX4RBSl9RK8I3ER1nnA7Pzg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wa65V-0004r4-LW;
	Thu, 18 Jun 2026 06:18:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wa65T-0004qv-KT
 for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 06:18:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VYj+b6z3x+oQVS8urJIiABGYBZ1wCYn7iZWAOuz5bgw=; b=Vcf844BNFSEKc71nw1kJcNeI4F
 CF0Cf3y3mEDaUYUQR8PDiQpUbBq+tzxXH94YqjxSCT4xkFQDLGl5V5Uf3+afYutIzKExXkTzJCCBV
 HOmHGwCVVK35BaZRgP7J+lhkUp/qIox0/yqxNoY2C2bGMdStOCL1lqIfbMiHz736qZa4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VYj+b6z3x+oQVS8urJIiABGYBZ1wCYn7iZWAOuz5bgw=; b=Vx2n+xu6vZc6y07IlQI/NUY2Ld
 +mhPUrpTm6YJt5LDNMQ9tBXmKhNp7dUApRzcQoGlZbdkwB0xjSFAbYnR3NbsQDtvEXataYSpYmQuy
 17+Tdme4p/VBib+TT7K7lzkWOdGHpwfXvje+a7yjzB7QDSzz6Bd0yH8dlIE8DTRgkMAA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wa65R-0002Cx-Ct for openvpn-devel@lists.sourceforge.net;
 Thu, 18 Jun 2026 06:18:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65I6IbWv016491
 for <openvpn-devel@lists.sourceforge.net>; Thu, 18 Jun 2026 08:18:37 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65I6IaxC016490
 for openvpn-devel@lists.sourceforge.net; Thu, 18 Jun 2026 08:18:36 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 18 Jun 2026 08:18:28 +0200
Message-ID: <20260618061835.16448-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
References: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wa65R-0002Cx-Ct
Subject: [Openvpn-devel] [PATCH v2] dns: Fix memory leak in
 dns_server_addr_parse
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

From: saddamr3e <saddamr3e@gmail.com>

When the DNS server's address count is already full (exceeds the
limit of 8), the function returned early without freeing the
successfully resolved addrinfo struct. Fix this by checking the
limit before executing the DNS lookup.

Github: OpenVPN/openvpn#1055
Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
Signed-off-by: saddamr3e <saddamr3e@gmail.com>
Acked-by: Heiko Hund <heiko@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1712
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1712
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@openvpn.net>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 954ed52..1465cdf 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -114,13 +114,13 @@
         addr = addrcopy;
     }
 
-    struct addrinfo *ai = NULL;
-    if (openvpn_getaddrinfo(0, addr, NULL, 0, NULL, af, &ai) != 0)
+    if (server->addr_count >= SIZE(server->addr))
     {
         return false;
     }
 
-    if (server->addr_count >= SIZE(server->addr))
+    struct addrinfo *ai = NULL;
+    if (openvpn_getaddrinfo(0, addr, NULL, 0, NULL, af, &ai) != 0)
     {
         return false;
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
