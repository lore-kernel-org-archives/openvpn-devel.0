Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E744606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=irNt1Vj5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ma5tjz3Y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=abFJyOZv;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=aZbT0xEk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Bo04CzRrgCAs3mPyf0Dl+oxjIlf4oQzzfVMXf++nv9I=; b=irNt1Vj5HL8LXT
	cLkH+iO+7/na7DTrADi4FKlHPdBmH96Lx/vD9St5uceUcu+CPGwWzHhDSpKysqLXWuEukgAXUqM1y
	jSxMG6ikdwXYb+V7DgtmWZG8HF7aL+sNAIHiwrIfjJHDW0V5FGmLhycuo+jKK26xuFcbOSBzjrGCP
	gUM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWbCT-000000007I3-0ttI;
	Thu, 26 Nov 2026 15:15:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xWbCP-000000007Hr-1xxq
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lQ5dDrp/y2W4sEw93MnZc0JRBgQm7RyON3FOsU2ZdqM=; b=Ma5tjz3YRam/PASHBIFXfS6CEp
 lHlRVQ5WIXCKE96ICu16df2CWIyyLidnAqZaz15FDyVtqt9ExqUH0vHM4I0650zOWhuOXbk0wwOF/
 v+JvNul+JE46sfcTZZeQvc+PICuWbibpSQvARUDJ674zkKEwRFTJj4Jt4F8UnWrB2bk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lQ5dDrp/y2W4sEw93MnZc0JRBgQm7RyON3FOsU2ZdqM=; b=abFJyOZv8CDM4PNZ6sAvUnWOwe
 MpUAvrfZ9PZNrJxkZdCvBCe165S38P04mt8GHO4GB53CQEOEABT7wdEXrkU5fowF3MJKtr/FwW2N3
 G7LAf+ShwDhbcVoYwrx4QBPdBGPaDW+BGVDCG00MDgjZnSctAL323EU1CvwbC7lws61c=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWbCM-000000006YQ-1sqv for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:15:49 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jb0VK6y6FzcQ
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 16:15:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795706137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQ5dDrp/y2W4sEw93MnZc0JRBgQm7RyON3FOsU2ZdqM=;
 b=aZbT0xEke6PJDzsSY6Y+lReL+WfyrJqrk0j0s+b4GIJsnNeV2+raLO+VkDQmyTpYpAILQI
 WwKp1NRbaSHb8mefF0TYHmDZdsZ1CppsCV2JU9oPYJxGoVffjcGsXmpDFU/mEYdsAJs04v
 /NHD7j7/DqKMWsZJrwnLMY87VGLIZA8EdReOo0rtlwGQdu9Jbw2C/Y7uyCCkF2MEQ4ZIh2
 tyxgRXsD7nQcPY6gt3cLCbyySE2UdrfSXnkXeTOSrJth403SH2jE+PWlD9D4OpxFTOfL0N
 sWNjnrIuc5TYvoTN8+O71ihlBwoANhoaFQmV2UaFSWp/Libk/4+hbgqEoAcGrQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 16:15:24 +0100
Message-ID: <a47d1e68adb6c9dc6b34aa59c3ebad8c69298dcb.1795704654.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795704654.git.ralf@mandelbit.com>
References: <cover.1795704654.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jb0VK6y6FzcQ
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWbCM-000000006YQ-1sqv
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/3] ovpn: correct kdoc return
 statement in ovpn_udp_output
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix the return statement of ovpn_udp_output by stating that the skb is
consumed only on success, not unconditionally.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921102215.3599702-1-antonio%40openvpn.net?part=3
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/udp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 055cdb1bee13..422c1f6e0c76 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -407,7 +407,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
  * @key: route key snapshot used for cache validation and flow lookup
  *
  * rcu_read_lock should be held on entry.
- * On return, the skb is consumed.
+ * On success, the skb is consumed.
  *
  * Return: 0 on success or a negative error code otherwise
  */
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
