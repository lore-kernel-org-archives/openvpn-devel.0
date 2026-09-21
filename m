Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CCAC982EE
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oC/vE6DQxqo68cuZZlnib+G/xuEA8ehQ0cAtkkgqEhA=; b=IxO7PqKRIfAfOnjK9cuZbR3R7+
	PtLmO/W6jskqmZN/WDuQCESY7oh968SN0UvP7eI4HCOvw7R9hE9i8ftORyTMDQJvS1jaFV8dpLC9m
	69pQ7jhkW+RfBk6KB/F7H0C4/I+bQVfqTU4g97hgq64jtZiwgdjvpaEGumL5jPfY2Xyc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8cGy-0003lU-6F;
	Mon, 21 Sep 2026 11:33:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1x8cGw-0003lM-VD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 11:33:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BKmLxOD6QRqKqYIQijMgqQzcGFrq6BIlkPmtHBGge3g=; b=QlymMqVYAdgwlfh+8TvzsTf+5n
 cuS+XGKtNEu+bDJk6StAT/x5yVrMYj2brbJ85NJPKxqpGTquz8WcnA0hJyGXRy2SYuaCR17CiypLW
 UOjmgNkxWRG7vUY0XxBtugztV7QAn3xGUz25yOtt+aixy3ATNTbOZm8DUMc16aQ8iqWI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BKmLxOD6QRqKqYIQijMgqQzcGFrq6BIlkPmtHBGge3g=; b=Zu3t0phAlvuX/Id9RCdJJDni0O
 XMNTsu8mqwTSrW+xAgO3XOkeXeciSczQkA7+8W/pH/RIJx1PNNOwaEqJVK07YdcGtCUqLreGAkYO/
 mgGuR320TnPMQ6K878TWYkoGDDchtxxWlqpo4nGVP1zaA0fokBDdV+qfMmPU/noVGl8w=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8cGv-0000VY-5o for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 11:33:22 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hpLh850ZRzMlBT;
 Mon, 21 Sep 2026 13:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1789990392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BKmLxOD6QRqKqYIQijMgqQzcGFrq6BIlkPmtHBGge3g=;
 b=h9HAwNpyRSlnVnxzYoKqjkmUHQNk+oYYOihNquHpFu8uEP00lBnGZCW1lNGEiU1ckHJCOp
 fNmn7Bp2+einMb6oATgo2uCUtpyfu/MhEMLKk13OUdTwfRoLZgLQt6E30+roKnfOwshqDp
 c15nXkf2UPZD1rYHj6ibLtVOU119oTCpzA1Ha3I6wFz5oBBA7jy7SOemqPu/36KXcnFzvh
 eOcT1k98wohWIyIG1xW1BfjMfJ9hDfxrymZRyd91WEO63niyvwSuyXGY5Eb83L4Ee2DBkv
 Ay3p9YvSehtWBw24xmXN8t5y13ykAwKqZFcchDzU6C4KUe+CWhwZERb8V1ediA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net,
	Ralf Lici <ralf@mandelbit.com>
Date: Mon, 21 Sep 2026 13:33:08 +0200
Message-ID: <178999035963.3738901.1834650482099915353.b4-ty@b4>
In-Reply-To: <cover.1787925761.git.ralf@mandelbit.com>
References: <cover.1787925761.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hpLh850ZRzMlBT
X-Headers-End: 1x8cGv-0000VY-5o
Subject: Re: [Openvpn-devel] [PATCH ovpn net v3 0/6] ovpn: fix UDP route
 cache and endpoint handling
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


On Fri, 28 Aug 2026 16:50:21 +0200, Ralf Lici wrote:
> This is v3 of a net series that fixes several related issues in ovpn's
> UDP endpoint and route-cache handling. This version was rebased on top
> of net and includes suggestions from Sabrina. The former patch 5/5 was
> dropped from this series and will be sent as RFC on netdev, where it is
> more appropriate since it involves changes broader than ovpn alone.
> 
> This series preserves IPv6 scope IDs supplied through netlink, handles
> unspecified source addresses correctly, invalidates cached routes when
> mutable socket route inputs change and avoids in-place updates of
> RCU-published peer binds.
> 
> [...]

Applied, thanks!

[1/6] ovpn: preserve IPv6 scope id for netlink peer endpoints
      (no commit info)
[2/6] ovpn: skip UDP source validation for unspecified addresses
      (no commit info)
[3/6] ovpn: track UDP socket route key for peer dst cache
      (no commit info)
[4/6] ovpn: validate peer state before caching UDP dst
      (no commit info)
[5/6] ovpn: replace bind when learning local endpoint
      (no commit info)
[6/6] ovpn: replace bind when clearing stale local source
      (no commit info)

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
