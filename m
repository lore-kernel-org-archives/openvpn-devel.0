Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3019CD8CA4
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l8fGk1I8AL+5t7q+8MNefe0dIQfsR+24R4ygHRMi+/Q=; b=luywCCPSK8qmzfyGWwQ6PzWM1q
	oGkx67xoWScyTRqWeGOZEmdOXu75hSDP7VVXP/WGf3ivPc0/OkBJoGiHkD6p/NcLa8flF1AqfoohV
	qqCbsmV4DDDcu2FpDUSdgGSUr98OkmrXuWV6Y6cGYS4Tq+kLR4krvRQmT26g7dUtp9Mw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWapY-0002Dn-NY;
	Mon, 08 Jun 2026 14:19:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wWapJ-0002DQ-Ip
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 14:19:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Av6l/Wn/XQsYd5vWheRXPPXFOM/JhWutqFFKzNm/kY=; b=fdRmC84p5uzPJ+Ib37uLL5sDEk
 dD24sTwpP7qWxqJ5PhU1ygggclxRembSfqY3QU6I3Tvcf7hVr/8KauEn9OfWi0YHkZ2RZWvlSJbNX
 1/6elkukmpoB3t2ZVIEblPNDls3o+sexFWiOBQo1D2cog8JhBT/fd7j3wiQkWdJr4MwQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3Av6l/Wn/XQsYd5vWheRXPPXFOM/JhWutqFFKzNm/kY=; b=D4eroyROoK21+S5+sMAgECyyk8
 7Ildp6sMMBjTDgS1XZV393FUQqkOssRgKs/3b/XiidlprJDoGQAdDr0tBrYnt626r1HMkKBu0herw
 VdfCY5ZLNqPqnoGxrftI50TznayiQhzBwsMg23/H5iHTM9P04Y6ip9/NKxRT9qOfLSIA=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWap7-0001iy-2S for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 14:19:32 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gYvLD563Tz9tSn;
 Mon,  8 Jun 2026 16:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1780928356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Av6l/Wn/XQsYd5vWheRXPPXFOM/JhWutqFFKzNm/kY=;
 b=uGCEaITmuKtoBwmnDeo3f3wrGHMusAupPJCHD6bK8a5onLcWkI9uXK2/l4UD0aMbw+h4Zq
 YxmUPzDc1x/AjjFg+pcaPIOovGKOgLlkYrOD1VzgNpKsxJk6WFdiUDLy/EV8lIrboMyPP1
 HYkTJt9KUc62RcjuMdJ+vVkjiJqfsDPUBJPu3CZPSZYPRJafMFQn1IawcCkEoTYjIOQhyt
 Y7c5iftyntPOFb7yVEnhRMWIkdDbK9G2ITgpNMsYi/UwtuXKkKH986HdnfZIhzocrJ8Sod
 lohYjFCuLiV0DDEHN28amQ1Cf69v3B253gnSya45EK+D3ThY9XpWKdnSYDrx3w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net,
	Marco Baffo <marco@mandelbit.com>
Date: Mon,  8 Jun 2026 16:19:13 +0200
Message-ID: <178092833773.3219682.7592366542484695731.b4-ty@b4>
In-Reply-To: <20260608140446.546040-1-marco@mandelbit.com>
References: <20260608140446.546040-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gYvLD563Tz9tSn
X-Headers-End: 1wWap7-0001iy-2S
Subject: Re: [Openvpn-devel] [PATCH ovpn net] ovpn: fix use after free in
 unlock_ovpn()
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


On Mon, 08 Jun 2026 16:04:46 +0200, Marco Baffo wrote:
> unlock_ovpn() iterates over the release_list using llist_for_each_entry()
> and drops the peer reference inside the loop body via ovpn_peer_put().
> 
> If this drops the last reference, the peer is eventually freed. However,
> llist_for_each_entry() reads peer->release_entry.next in the loop advance
> expression, which runs after the body. By that time the peer may have
> already been freed, resulting in a use after free when advancing to the
> next list entry.
> 
> [...]

Applied, thanks!

[1/1] ovpn: fix use after free in unlock_ovpn()
      commit: b53407df27741dc81a85e1aec63fefb1da19ee8d

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
