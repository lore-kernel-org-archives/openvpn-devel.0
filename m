Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BC2C61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JgrDyxWMAXQgiHQmQB8UaBAocNQkzHbzWP7l1Xmyyf0=; b=IPquXGBqnamGtSXIqMyyGvqSrC
	tt9li/oed3N1IuapYzigcMw8gu6ZAXmQNL1CWmCHyTPY9u8LY6LywSBgsgt/eHBGLEZ8iZ4fG2Mpg
	TbOPo5ukLwKPKcUrYUYaWtUMhgVVY3MlcXoaRCJWfwAsAyWTT5EnLUbWrmpXFa0lmaZ4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1Nis-0006UB-CK;
	Tue, 01 Sep 2026 12:36:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x1Nig-0006Ty-NS
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:36:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IZqg8NRHLMBcXfgw0ETIu62oKWTVHaLGWmGSJ/Pu0QI=; b=h4IUt1f+I42kPvJ5IsR9Aa8xd4
 KiohX+ak+eTBrGKcNaCe/l2yZHUAuoh/z/ejKLNckreKOTVeQEcUY/Xp7m5fovR51eYZLyX8qt/wg
 JQ01VvusJ+/8feWqMFkcZz2CiMUr/+E5gCJYJ7Bd/JCljfzOS8BNYsYhAzSr4Rw65m8A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IZqg8NRHLMBcXfgw0ETIu62oKWTVHaLGWmGSJ/Pu0QI=; b=Eoff2i7lDlzQKWtV2C2CVNKJ+r
 OByXhjkUMvnamB+YJULasU8emzjIOKzVHcHpEzBCKCs+qiuJL2D33EIHmLTe+zn1O8kRBjMG6wrl1
 ezFoEvt+j5oOapAJX7y+LkVzqhleHK9JHoOelVoj5jeNDqF4gkskrnHaq6P/LfPvUwNg=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1Nie-0000Fv-K9 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:36:06 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4hZ51m40NTzNlsx;
 Tue, 01 Sep 2026 14:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1788266156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZqg8NRHLMBcXfgw0ETIu62oKWTVHaLGWmGSJ/Pu0QI=;
 b=HTk6nmIYp3Su0N9yDKt1idd86libcMIopQTLiJu8ckf47rO3GyvqjjRz32A6zMS6kNfHmM
 3lkV7BfUqv9MwOhoen17sDlLhc450sPYdY6AxOtuc+f0azfLcPL0hbd32QNI0yh2EIxa6c
 BHqil+55z4iWo5hsgZk1YtdwQyu0mf3KQ8wrQtu9dUVzVU36YnrIjpWKgpgGeg77xusmIx
 AuZCBCTGgRLq/5q+Azuz8lPhNFG9jQ7bucC8oSXzXm14QwuVWDO3VtgOG72WV/FIv4gRhy
 nX7tkBz8WrEg8YWTTDpfU8kUR8J/V+1UizHVvlOP8BxR4mVdkI61KT9YlerKtw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Ralf Lici <ralf@mandelbit.com>
Date: Tue,  1 Sep 2026 14:35:43 +0200
Message-ID: <20260901123544.497811-1-ralf@mandelbit.com>
In-Reply-To: <20260814151239.610273-1-ralf@mandelbit.com>
References: <20260814151239.610273-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hZ51m40NTzNlsx
X-Headers-End: 1x1Nie-0000Fv-K9
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2 5/5] ovpn: avoid caching
 stale IPv6 dst after FIB changes
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
Cc: openvpn-devel@lists.sourceforge.net, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

On Fri, 14 Aug 2026 17:12:38 +0200, Ralf Lici <ralf@mandelbit.com> wrote:
> Ok, I'll drop this from the ovpn series and send it directly to netdev
> as RFC, rebased on the current net tree and including the ovpn user, so
> it does not depend on the other pending ovpn changes.
>

Following up on this, I sent an RFC to netdev to discuss whether this
race is already known and how it should be addressed more generally:

https://lore.kernel.org/netdev/20260901122501.482920-1-ralf@mandelbit.com/

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
