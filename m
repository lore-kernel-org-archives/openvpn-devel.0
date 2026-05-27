Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93AECD5BD0
	for <openvpn-devel@archiver.kernel.org>; Wed, 27 May 2026 16:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4rDUoo83ECJoRVY+uGzCy2Hr7RxZUJt2wggWwuOiei0=; b=LzSzY/6YOlsdWwQT6JFWAQty4Q
	gNmfAuQf2kVqbr3/GQxXz//l6BKah1+oZ52ySOVVofhRR2V1KY2KFKhIED50EZxI4o8CiCX1MBUL8
	AxJClJWNHxeJUio0bpcmQ4ecdtcJWs1jGNB5dFBJxc4M7k1aGvpg+XpEqtxmz6/GHpuU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSHXz-0008Dq-7u;
	Wed, 27 May 2026 16:55:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wSHXw-0008Di-R7
 for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 16:55:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MksbH5Dles64ehaI6w+cKa4fiGvt9dtvlvueQiVwB5U=; b=k1k04dPwRBSMEpP7WjulYZ8sDd
 WJLJff3ijWWN1pJjdfyGvavzSEd1FKe9lFIBEuITGcpx0u584tDT4Ad6SKSsyCT6MlqPwhwbdR6A7
 7wAG8QcEXVg80677nrcLrFWO+V7cm/I9GBNm3yRby1CN/O1qb3DTRRm25deLyp8zgNQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MksbH5Dles64ehaI6w+cKa4fiGvt9dtvlvueQiVwB5U=; b=Z
 Jc0lBlIYKfCM8Y6ObBrirQFac6GK6qMO2Fgq8ClnH/+lM6WuceUGBLQgURNGJCKA5NWw6SRFKYRsG
 o2fbPRrOhR9zIDlTwhPPF3Hp/q/6+Fxzg6f++6VQR8NnMBjxo632+pe7TNzTH8pAWyCIeLv13dC6p
 So4PvFiLBWnz5OZg=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSHXs-0006gF-HV for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 16:55:54 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4gQbNK0q3QzDs1F;
 Wed, 27 May 2026 18:55:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779900945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MksbH5Dles64ehaI6w+cKa4fiGvt9dtvlvueQiVwB5U=;
 b=fiqwCHcUZw8PNZld5ShNxkMrHwvKp5jddwgccrZs9UuT2s9sXSrJFfZkRpKz2mlmhaqYPy
 /GohUPsDecqWMumjZJ4eziqgG+yVuJlrBV+BwWjhMEh3REleKWdclQ/Y7wpDEQsgkyE9GG
 mvjMl52LGGdX0Kk/j7qgo+TaKQXYMbbjTQ9G64SWyMP+fwzSdI+BEetnKnvLh8KFX3RkNn
 Xu2qitmpfTyXWSYFIykrElXSJJDVciNx+DEQWurtQv223aUNJf7XQfNlUae52Uq0x0gcb9
 nbrWBsPcMcj2aXAw/0aFo1gLlRQPFtNhwGCMSwAoCwJK+5+vaZUZuS+H2B8H1w==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 May 2026 18:55:23 +0200
Message-ID: <20260527165527.24035-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wSHXs-0006gF-HV
Subject: [Openvpn-devel] [PATCH ovpn net-next 1/2] rtnetlink: pass sender
 portid to newlink callbacks
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

A newlink callback may need to identify the rtnetlink endpoint that
requested device creation. The source net namespace is already available
through struct rtnl_newlink_params, but the sender port ID is not.

Add the sender port ID to struct rtnl_newlink_params and populate it
from NETLINK_CB(skb).portid in rtnl_newlink_create.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 include/net/rtnetlink.h | 2 ++
 net/core/rtnetlink.c    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index ec65a8cebb99..d6844c5593e8 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -75,6 +75,7 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  * @src_net: Source netns of rtnetlink socket
  * @link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
  * @peer_net: Peer netns
+ * @portid: Netlink port ID of the message sender
  * @tb: IFLA_* attributes
  * @data: IFLA_INFO_DATA attributes
  */
@@ -82,6 +83,7 @@ struct rtnl_newlink_params {
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
+	u32 portid;
 	struct nlattr **tb;
 	struct nlattr **data;
 };
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6a5e9ace55a0..ed4918a1fc03 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3846,6 +3846,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		.src_net = sock_net(skb->sk),
 		.link_net = link_net,
 		.peer_net = peer_net,
+		.portid = NETLINK_CB(skb).portid,
 		.tb = tb,
 		.data = data,
 	};
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
