Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99CAC43458
	for <openvpn-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bSBhfsFUZowmcHUuviu3aOepF5xLLUyzmSFJrz028N4=; b=amgX4oVSkmPXIcZoejzhTXJnWP
	QqmxPDaFm/90xmBYEX41eHzdMOyGndA+zGjudnYggOflF3/t5YKW1CqNeNjxmi/HVci7TvECm1G4a
	PW71N7OUg96FuVuQSqUUhxokr+3rBvln1hQrv+7W4PXrlIFW2J4XwOLL0ynHq8l8uGCg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfXEK-0005G1-0T;
	Fri, 03 Jul 2026 06:18:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfXEI-0005Fs-Dm
 for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 06:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jIhf5rxLYyBFLm8fb6Nucu0yAHBduIkw8MK1cbgZU9A=; b=c2NjKvfCIugC4HnlR9s3DTiCYZ
 /kDAPhCN9oRllBXKbSuP9gGmcVZSAycjst0Q/VkTQnbgG6HcYFTynXnFxAYyiY+elHGviLaNwegqy
 yKStYd4u3wHRuuMBxJqDpHXMaOYP0bgufMbPOfdt4ngWHbNrS2uv+mjkGHM8C1QUePGo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jIhf5rxLYyBFLm8fb6Nucu0yAHBduIkw8MK1cbgZU9A=; b=R
 LVNTc0kuMIdIdC/+8NIIT8RCVjSCkeBXq5bIgsu5s9P62xEg6YBibgx6LmFsiGS5/Z+ljKP4l70ny
 MM/5ur6lBSh0ZBbhgqNvHQAYuYGrSMnaomkzfm4Va5ZDZVsDuoC3YhDs1GGRDxAsGL9DSbsQRzp3I
 KWPSLAaP7qka14YI=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfXEE-0004gI-Qn for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 06:18:23 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gs3Tg2MplzDsFg;
 Fri,  3 Jul 2026 08:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783059495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jIhf5rxLYyBFLm8fb6Nucu0yAHBduIkw8MK1cbgZU9A=;
 b=NPfkxFMci2H2wksh6RT712PMqpUQf3wXxii1+xAaBUsvaDXLtgrfSo8PI9zJ2yCB/Zkjns
 kx6XCaz1+sfO7V0ApCSiczfEBrLn4+9y/7SkutcrpkfBHMN6IR/jr8VLho/FdwJAdCtt4V
 e9Oz9FI/UdxyzdE+oFkdFU4WSlxViGk7FEupeHyWWoLlzMPWC5R66h5Q2JPKgIrcZavpGp
 M6iD8lrjSn2ripeV8M4c/kG/Cih8Fy8JrSewPK3oRwmgvU0wx74ftsMpBK/AxrVWss6cR2
 vvIYZiUFwdytmyaLpeIEFolz1ik2D2mhbim5BZUnvZPtYYf0MThOfWxIlUXBNw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  3 Jul 2026 08:18:01 +0200
Message-ID: <8577555cc95646d0bd58a5b78e59c7e6a9b1a0c6.1783058844.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gs3Tg2MplzDsFg
X-Headers-End: 1wfXEE-0004gI-Qn
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: use nla_put_u32 for the key
 ID attribute in ovpn_nl_key_swap_notify
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

Currently, in ovpn_nl_key_swap_notify, the OVPN_A_KEYCONF_KEY_ID
attribute is packed as a 16-bit value despite being defined as a 32-bit
u32 attribute in the YAML policy.

Fix this inconsistency by using nla_put_u32.

Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4c66c1ec497e..abf038206a62 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1335,7 +1335,7 @@ int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 	if (nla_put_u32(msg, OVPN_A_KEYCONF_PEER_ID, peer->id))
 		goto err_cancel_msg;
 
-	if (nla_put_u16(msg, OVPN_A_KEYCONF_KEY_ID, key_id))
+	if (nla_put_u32(msg, OVPN_A_KEYCONF_KEY_ID, key_id))
 		goto err_cancel_msg;
 
 	nla_nest_end(msg, k_attr);
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
