Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AF1C5AC67
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 23:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mFcSg3t6qTbRcMGqvvTwbT0nMQPtgOn56ZKlry8YpSo=; b=hTRxvcovlUhFmWsg2pg7HR7f9X
	s8YQ4tP/D9wtFKBKA3jQdVrWrKIXYhRqyZddiOP8sHSAeYle2jgklweQIazzJAvwjZlQCSBo0aCvK
	IAWgnV48vH7zEtk4iXkD2DdshjRKnTi7wKb3dIzvHCP9NbajboUxqWT8tICHQ/+/x7os=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ws7sh-0003at-3C;
	Thu, 06 Aug 2026 23:52:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1ws7se-0003ak-5e
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 23:52:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EeVQxvALINn4z22+lBcNL9f2LaeiCri7AVXl9MqTyKk=; b=cNRWE1EW3czPsiSCDPXsD6ZJaX
 XCePGhxm6B8KGF31KP3XIzw93I8IBnU/McH58UkSXzF4KOHLVk90geaCn9ELayydam76o4Dz8wi2b
 gSt39T7FcGvdoXBFs6KwzFQfHJvj1Lbghw2Ue6vXG3NCErgVHFZAg8iBMOVDl+baI7P4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EeVQxvALINn4z22+lBcNL9f2LaeiCri7AVXl9MqTyKk=; b=lrtK1IVCgBJuYIOkP180l0psIT
 dEfeQQjWvo9fMttwGvDuv/OLmth6qpOorSasCGZWAcL3eTKxvdTzJhH7G2kmBj9YQhOd57LgxsWy0
 WK+TQTgEL0KXdleyhfNqvHsxN4ywuXmvmmUnxILy0B7YABLWOTC2X8CX2Lq5Fn01GcQA=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ws7se-0000i4-Ct for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 23:52:05 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hGPFn3KV8zKn0p;
 Fri, 07 Aug 2026 01:51:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1786060317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeVQxvALINn4z22+lBcNL9f2LaeiCri7AVXl9MqTyKk=;
 b=UvmoDwNtzoQiE4nxMAzQCa49aGf2soWg9UYsN7zmrMDnZvjppfjJe/1+6Q/a3BJlbqkUMo
 2YMQDZruH0/GooSmqAOa0d/AY/Xo9Slw32PdfXcxkYjWfMV6k0Te5hT1tls2PPZ2SC80uu
 1TVpfDVh2AIUNLZuhE0AZhNJc81kvjCxRJartweQ8HcTK9eHfBrxtza10cVUS6IGka25Vf
 6/P0Uh8NPD8SURuqlAdiYBzr1W3FesvJtO+kWYSFmAm4ZPj+dU6BI8kxC5m6nYu3OKnn5a
 mRBsXggaVqY4Owuhdwewg0SP4+GopWfWfS1bO3JZwqFMTriQZt9Q0DW54lxwYw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net,
	Ralf Lici <ralf@mandelbit.com>
Date: Fri,  7 Aug 2026 01:51:52 +0200
Message-ID: <178606029611.1728075.9738818476482859007.b4-ty@b4>
In-Reply-To: <cover.1785318038.git.ralf@mandelbit.com>
References: <cover.1785318038.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hGPFn3KV8zKn0p
X-Headers-End: 1ws7se-0000i4-Ct
Subject: Re: [Openvpn-devel] (subset) [PATCH ovpn net v6 0/6] ovpn: fix key
 and workqueue lifetime issues
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


On Wed, 29 Jul 2026 12:21:40 +0200, Ralf Lici wrote:
> This is a respin of the series that collects various ovpn fixes around
> key-slot handling, netlink key notifications, TCP initialization
> ordering, and teardown of deferred work.
> 
> This version has no more pending dependencies and incorporates the
> changes discussed with Sabrina. In particular, patch 6/6 now uses
> queue_rcu_work for key-slot release, instead of adding a key-slot
> reference in ovpn_crypto_config_get.
> 
> [...]

Applied, thanks!

[1/6] ovpn: fix NULL dereference when killing missing key
      commit: eeb8f94b9b0fbd7f08ac81361d937c3d11d9df00
[2/6] ovpn: use nla_put_u32 for the key ID attribute in ovpn_nl_key_swap_notify
      commit: 1425d5ff5add800187371aef1519cb029f83959c
[4/6] ovpn: finish crypto callback cleanup before peer release
      commit: 0627b2c23ee28fe6f8e7ae1b62602b59831c6ec6
[5/6] ovpn: run deferred work on a module-owned workqueue
      commit: 0c377eff1548138430a6fd1a19f014e4aa87d1c0
[6/6] ovpn: defer key slot crypto freeing to workqueue
      commit: 217b85519877263bf59d38c2c00781d3fe93c676

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
