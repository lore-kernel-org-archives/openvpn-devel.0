Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD10CD8C9F
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=leBAnJUIi9rD9KyRR3JybJ6AjyDpYYeYbZ4+KEwFEEg=; b=N8v6icHx7MpEqHeJtxWpGYthV+
	cQgPZcz3K44zhupNL/s5bHnyNsNvi57wuUDws09Gzp/GhIcjjHhUKTWyWiCtl5B70wFKKXjLsIOBL
	gM6zGv3RSuf8yfo7HPS0iYCHCGpsovoL7px1w0YF2Nl2Kkez1MowtmMFGEgYovmIjdxQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWapZ-0004JC-1E;
	Mon, 08 Jun 2026 14:19:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wWapK-0004Ir-9j
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 14:19:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p2ep4QOdGvvdMIuXpQluKsQN1NTWE5lvVUKXMjesGK4=; b=jr3gYlvAN7ziD95lSo01l6Zqb/
 oMGdHAMMrkYga9TOFrl0/BTBG08TYDoTm2TL17NSJE2Z4nkc4L/I3QrEhccygFvJiiiei6s6n/hzT
 k4iWheYWvnewrVhIHnOlvsYzSvEN3PANQjafU2OYuC+hvoR5xBkNBqJ/mkLzbp8Da+ls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p2ep4QOdGvvdMIuXpQluKsQN1NTWE5lvVUKXMjesGK4=; b=XoegcnV1i9i7Wkg9Gd6WC6WBah
 NJbUH7E0vOmv3qX08q4W+7UjUSNgXLhgyWmZuSVuCB+spq6jHcoAf2RQVo1hUY71YzRf6EakeeMNl
 jVufx3xXl24fcSLrOJkLmK1jqq1737/gA0sK2QwB7bIZSB+BWiKW9FvRYUG6sSPuvRE0=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWap8-0001j0-1S for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 14:19:37 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gYvLF4dZyz9tZg;
 Mon,  8 Jun 2026 16:19:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1780928357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2ep4QOdGvvdMIuXpQluKsQN1NTWE5lvVUKXMjesGK4=;
 b=UF+gahQETDvKWTVBAJtgu4/gyncFuyHOQ8tfq637HfL7rrRQbucDVhRbZ+rqBD/RGrCQkw
 aXlHRklxB66qLZY6cOZH74PkeMZP1aC5ffvizbvI3X11PzYztLVW8DtqZ1H44X7WFVFU4S
 GkpIxmPCbwTq0ibiJH2BStnbuXJZXP1+4+sgSAGbvK7KyrHRQdTmx8w0AOQkJY1E+vwg36
 HKO8UrIzvXHyAG10mgb/+YDt+e/pyz866SzV6iRGbkSSiha+Mzoaw8S7kS/QDKJGZX7fIG
 RmYRGQV0OzYEm3GKwLNBleX/JnYQEuICVFSL3ktIqBz0LR08LN1w+lJ5k7x8AA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net,
	Marco Baffo <marco@mandelbit.com>
Date: Mon,  8 Jun 2026 16:19:14 +0200
Message-ID: <178092833777.3219682.2580839165890671462.b4-ty@b4>
In-Reply-To: <20260608140642.546546-1-marco@mandelbit.com>
References: <20260608140642.546546-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gYvLF4dZyz9tZg
X-Headers-End: 1wWap8-0001j0-1S
Subject: Re: [Openvpn-devel] [PATCH ovpn net] ovpn: use monotonic clock for
 peer keepalive timeouts
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


On Mon, 08 Jun 2026 16:06:42 +0200, Marco Baffo wrote:
> Replace ktime_get_real_seconds() with the monotonic ktime_get_boottime_seconds()
> to ensure the keepalive mechanism is robust against system clock modifications.
> 
> Right now, the driver uses ktime_get_real_seconds() to track peer timeouts,
> relying on the system wall-clock.
> 
> An administrative time adjustment or an NTP sync that steps the clock forward
> can cause `now' to instantly exceed `last_recv + timeout'.
> 
> [...]

Applied, thanks!

[1/1] ovpn: use monotonic clock for peer keepalive timeouts
      commit: 573bb65040d2b815888f56e8c96f58659fdfee9c

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
