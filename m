Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90B0CD4F26
	for <openvpn-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=78K4h4GxLuQaoxT4RO7RTn1I8/CNQY2BvBFRXfZg4dU=; b=A3h2BtbTRDgoKC7iaBs+RcC9St
	Q0qkqbujdkYueMw6c4XJNPDlY/S2UryI9J+AtoMoeSAvh4mFRyFMEDOFsn7VB7k0DrO+nRkVCymlO
	W8HvktSv9kBRuRE4heYR95nq5shxVjr8SsYvgIe6QcMBUivLyNy/M7kTzT2ducNryZiA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wd0y0-0001T6-Ps;
	Fri, 26 Jun 2026 07:27:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wd0xk-0001RS-A0
 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 07:26:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U8c8iF7oHCRQJjpwhsQc+mOeq7IXPs3krcGjtIDwWWA=; b=EP4B3nD31lloJgvb8ryT1iU54n
 oDrOxvHUKtqCTgZ6R5mOlPxZ8b1wXp6xEdopUH+nigOj69L6918J9Z+tx6M8vn9ot3gk2RUPO46xL
 03W1KrIxQfyTdAhGQlP2Qi5hgm0qheBGjRxdQZjBvkmb5BL7Q2W99JOWPRDO42I6pdjc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U8c8iF7oHCRQJjpwhsQc+mOeq7IXPs3krcGjtIDwWWA=; b=SA5Szex4RcHjyzVs/xZcsg3IJd
 Kzqp7ztyZBky0FPTxEcYnXbZlYbgqt0kaTBYhUhBWtIVNfb9XR2+H3AaKGZEUCsYCOpEKfvOgeNbk
 5n5arpLQxE8+J7vfzSkcoDu+sbzam7P+o7qXbyw/UzSseychZkmG9WvnxlRfIzXgd71c=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wd0xh-0007fy-4e for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 07:26:56 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4gmnKx1MkGzB1c6;
 Fri, 26 Jun 2026 09:26:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782458805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8c8iF7oHCRQJjpwhsQc+mOeq7IXPs3krcGjtIDwWWA=;
 b=VzQuAxUQjOi0ULYJCroChyDH6+1+i8TFrRqgjGsQEIyR34RZUjXAl/EnYRtQgZG2U0ZLEk
 /vcdEZJXeDv1rR0HmHh6U5LjgzL+7ydJyYgHXzYNBypTo/P5mI/2X0TYCAZSwA/66bDUCs
 veGo8mAPFYsXN4D7AIL7e41OzJmt/V1oz/GU2Mop/7oJT3vg9QwSHN2PzTI2IQmQ4HdSXw
 rWowrlZq/+jVDkDN+5EkmpObkOOJ0SixC/lWHh0B1K/3UksAlAQpQmw0TldHk17LCNQ0v8
 D2JhC7uQp2DOe1/pryXHaCOzMo1mNAS1BiUmkl+C1nDLI7qfyyyhMxY9K+cjBw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Gert Doering <gert@greenie.muc.de>
Date: Fri, 26 Jun 2026 09:26:35 +0200
Message-ID: <20260626072636.61221-1-ralf@mandelbit.com>
In-Reply-To: <aj4VX2asgQgzp5d1@greenie.muc.de>
References: <aj4VX2asgQgzp5d1@greenie.muc.de>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gmnKx1MkGzB1c6
X-Headers-End: 1wd0xh-0007fy-4e
Subject: Re: [Openvpn-devel] [RFC] Backport request: 7791f535 (#919 fix) to
 release/2.6 ??? DCO peer-table desync
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi,

On Fri, 26 Jun 2026 07:59:59 +0200, Gert Doering <gert@greenie.muc.de> wrote:
> > In any case, thanks so much for the clarification! I will adapt the debian
> > bug report I created to instead cherry-pick the commits from the 2.6.20
> > branch instead of concocting commits of my own monstrosity like I did.
>
> I think this commit and the one before it (876a8cf5fd, "dco: port
> core/context infrastructure needed ...") do qualify as bugfix, so should
> be backportable according to debian rules...
>

Just one small addendum to what Gert said: if cherry-picking specific
commits, please include adece45628f7 ("dco-linux: enforce ifindex only
for DEL_PEER notifications") as well, since it fixes a Linux-side
regression introduced by e78a8af2f5ce ("dco: backport immediate
notification processing on Linux and FreeBSD").

Cheers,

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
