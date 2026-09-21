Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F43C982E1
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9izzokwR64lF7SSLXcjUZ/2sp4RhErRQrAl45dYVuc=; b=eNPWrj3pVtdTCVvxcPsui69/Lf
	2eSMs9d/o9T1O/M9NQN2PX6p6rg1MGB69XEavoWvlanS9kFhqqFnGn86MwOYwd0xttOMqQoMPN0qN
	paaGhcySNOE1yUYvF7Xl3UNKrqvQTntQoR/WlW7YgPHH5KaqPz4rSHojOhliVHc7E1BA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8cGx-0004BM-AW;
	Mon, 21 Sep 2026 11:33:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1x8cGu-0004BD-Hy
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 11:33:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3LEfMJ7QksYmJMtntfWSNiuuYidg+gxOyvNM2pH7728=; b=SS7SheIKiUFyevlgUoZX/aLy7h
 OOi9w1E/T1CiPVISxonv7NrcYgh4r9Vv53dhH56KrIsFzWWrfOSwtUI36LuHs5PTsMdfz8r11ghBx
 YmZXvY8stvdzdGBkah6DRRieYpEQWBDEVeDxXnP/5WozOkpI/vfsd4cMiUUVgv/MXl3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3LEfMJ7QksYmJMtntfWSNiuuYidg+gxOyvNM2pH7728=; b=CkSz2o8Pf2EKl90jhIB8mN7lem
 dOAtoDB2x66YbS7GlBaVQkSavz8KD7mBEjFCwt0KvBDTZN7qlOJ+sFT0ZJWoRwVA6iKBZGcC9bTKk
 icuog7p4jYI9ExV5QJ3mDcMZQErq9N0IOKJluUwWHuFrttA9r3Doju7L4zxwSu5pl080=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8cGt-0005Cd-AW for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 11:33:21 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hpLh72jdMzKm7p;
 Mon, 21 Sep 2026 13:33:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1789990391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LEfMJ7QksYmJMtntfWSNiuuYidg+gxOyvNM2pH7728=;
 b=jQ7KGfVu8eh2WNYv87rc7X6o5T9spSZXf6n2HVIrkAbsju5V2gbM4Atom16sTB7XVchxmT
 FfuZmRJK+S6riLFSPESiFygB4uUOJ1CJvPsKuEcFaEEDrtiB5bzahzykwAJGO9w+PYDoO7
 b4mJKzV8EmmPEZ7AOCjb0KEvNRyUGz0mJe2JKBEdPxZrjDD2ijgzaHgytWBHLo2VYOoT+R
 NkbcCdGj3Utq4qlP5p29YEieXvIdK4sKjZx+byKjWhPAgSu2qScTZmCdeT76mhaP7GHAH5
 cDTHIAUMoVHWj1DuJh9IpyqI2NFXjzmqehhRSC0RIKZq5/+9wt/rGpLqQBw4wQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net,
	Ralf Lici <ralf@mandelbit.com>
Date: Mon, 21 Sep 2026 13:33:07 +0200
Message-ID: <178999035967.3738901.15536528256513516840.b4-ty@b4>
In-Reply-To: <cover.1787919082.git.ralf@mandelbit.com>
References: <cover.1787919082.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hpLh72jdMzKm7p
X-Headers-End: 1x8cGt-0005Cd-AW
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2 0/5] ovpn: validate peer VPN
 addresses
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


On Fri, 28 Aug 2026 15:00:05 +0200, Ralf Lici wrote:
> This is a respin of the series that enforces explicit policy rules for
> VPN addresses, taking into account Sabrina's suggestions.
> 
> In MP mode, ovpn uses peer VPN addresses as lookup keys when selecting
> the peer for an outgoing packet. The peer configuration path should
> therefore maintain a few basic invariants around those addresses.
> 
> [...]

Applied, thanks!

[1/5] ovpn: always unhash old VPN addresses before rehashing
      (no commit info)
[2/5] ovpn: reject duplicate peer VPN addresses
      (no commit info)
[3/5] ovpn: reject multipeer peers without VPN addresses
      (no commit info)
[4/5] ovpn: reject invalid peer VPN addresses
      (no commit info)
[5/5] selftests: ovpn: validate peer VPN addresses
      (no commit info)

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
