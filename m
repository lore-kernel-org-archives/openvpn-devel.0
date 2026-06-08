Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B68CD8C9F
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GfmXQHt6f+QvPhtTUnx2p2GsM9TrMkqeoAv5HU6wY4I=; b=jau2S2ZDiSLJqmeCWxElrvQED+
	sd1JCYI3Pr9m72k54g1DOGzdPpbA78j+pWbZ3HP/tQW2qecXAa/EQRWxyd7h/EkH4585/6PV97Lq2
	HygkPjzG2kh2Z7XAh2cfBcdsOr6sbeNQxATZRlCRvgLfZaUKQm+rgzk+EszthiJKNATs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWa0p-00013r-5p;
	Mon, 08 Jun 2026 13:27:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wWa0m-00013i-Rx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:27:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gd91U5/iv/cLeVZWs+SbM/giY7oURa1gzxFzEIEhwjI=; b=aoiwA8C8L+r67D325GeBYlGAsB
 RGAJKzoBAmP9G4RNvfr5qiqRlS8lzTk2s3INbu5a210pXoKsOJhHiULfBxewwomcpyqMXojKUs3SG
 sJoEQuOM0HyvXqB2CB2E3UmVEUe7/BXOWPbzOW0RdCzcLTh9v/Sa3vyZnjjWaAsf8d/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Gd91U5/iv/cLeVZWs+SbM/giY7oURa1gzxFzEIEhwjI=; b=kpQ+mobvyKPq613920DHJWnN6N
 WCpxHIKbgnc3IaNGfMHYwuxUdIAZ7mmdCL/0BxCw1GwTc9no3TmDgNeJmTGj+IlZaOE5K2G6B8W9t
 Nk1F50YE9kjy3uhzib3aig5Cz2AUDAL3sPC38hbqfomnpwc1Oq/xuoZ88aQt2y91vFqo=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWa0l-0004Ni-2A for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:27:29 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gYtBB3Lb2z9sSR;
 Mon,  8 Jun 2026 15:27:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1780925234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gd91U5/iv/cLeVZWs+SbM/giY7oURa1gzxFzEIEhwjI=;
 b=ttCJiQGFny4DZf12I8j72PiuRq040z/JaoH2yGTg2Gm6xbeCQcCvzRX3AeoSos+4VRSqeO
 IspTFPfFe2UiMNA6QJe22XHWv3pwgaWnR0cuOn0drp9M+K66JD4PonZIz3j4ggp5xoqnLE
 ge2X4IDc9Ttv5tSrwwzy7q3FCc5aJyJCMbPNX5O1A04GXR9SoxL6u0B8dXhqaRMsDxHqFe
 jeNEnlg1jR1kK07fQKjUmPII0xtuZuhx3wf/7eJyGD9YUOQypqcDtFsg3rq+MaerBCVChb
 xyGY0dl4YvKX8eDDzJn2PxXCTWuvATGasLIsyi8yW/5Vfzi7ffunoUc1cj3bvA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <8b53b8ad-313b-45c1-bc27-f98ebd4f202f@unstable.cc>
Date: Mon, 8 Jun 2026 15:27:12 +0200
MIME-Version: 1.0
To: Marco Baffo <marco@mandelbit.com>, openvpn-devel@lists.sourceforge.net
References: <20260529131501.3923068-1-marco@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260529131501.3923068-1-marco@mandelbit.com>
X-Rspamd-Queue-Id: 4gYtBB3Lb2z9sSR
X-Headers-End: 1wWa0l-0004Ni-2A
Subject: Re: [Openvpn-devel] [RFC ovpn net] ovpn: use monotonic clock for
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi Marco,

On 29/05/2026 15:15, Marco Baffo wrote:
> Replace ktime_get_real_seconds() with the monotonic ktime_get_boottime_seconds()
> to ensure the keepalive mechanism is robust against system clock modifications.
> 
> Right now, the driver uses ktime_get_real_seconds() to track peer timeouts,
> relying on the system wall-clock.
> 
> An administrative time adjustment or an NTP sync that steps the clock forward
> can cause `now' to instantly exceed `last_recv + timeout'.
> 
> When this occurs, the driver artificially expires healthy peers. Depending on
> the OpenVPN user-space configuration, this triggers a premature tunnel restart
> (if --keepalive or --ping-restart is used) or a complete disconnection of the
> client (if --ping-exit is used).
> 
> Signed-off-by: Marco Baffo <marco@mandelbit.com>

This looks good. Please send it as PATCH so that I can queue it for 
sending to net.

Cheers,



-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
