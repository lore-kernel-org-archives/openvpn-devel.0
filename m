Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F64CD5BD0
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NcB/GYAJIqIUEn4DvVLZcJdn5No74vChzLplo8DG3qM=; b=TNuhLnI+chS34Xu5ijAxGBV4oj
	H5ipVCOLuSNRSdcoQWKONAcTuYcYC+0k0o6dZl8JnOSCRYT9eLuciGFUZM3vXZVt2y/8xMXRxVcNM
	JJW4x3nYR619i0Dyw6eCyzOtuoYRPKThbbSOj6jHt3b/ocNnDS/YuvCnWj4wcwqsaNkg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRnvA-0002zo-1M;
	Tue, 26 May 2026 09:17:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wRnv8-0002zd-D8
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 09:17:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7p9JX26C9NapC5RTfUih1QEJ3Pe1niFjy9nYFefLa/c=; b=O+yqBf4sTyEXYzGUsHD91qtbJt
 kYOENVtfY1RR/IplcJiZ4GGTUdgLgTV7pOqeit2UWS5tdrhgmVnFqpeXTM0B4fmDaab5nSz8qT0vo
 MyNj2r8eMJX21qczwmUyZQR/bCBIWkwaTQxINldFRqEYfuud9FdbA8383slKgDz0mJ9k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7p9JX26C9NapC5RTfUih1QEJ3Pe1niFjy9nYFefLa/c=; b=MMFweOihNQbHL+0g1ydsHFWxAH
 /M3RuWbUvDs8kW6UjdfifEqq5SwXlTEMswWPHjyHP6HDMODuAdPBJ+T/DGIe2i7pCvbmua/xUZoN9
 UcGEG47Ktb/qfV/YZrpOm27PHMD7hFT+kMODKjaCY7NFprOik2AwIWyCjoLdDJbD2jEA=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRnv6-0004v2-SG for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 09:17:55 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gPnGD26K8z9sWm;
 Tue, 26 May 2026 11:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779787060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7p9JX26C9NapC5RTfUih1QEJ3Pe1niFjy9nYFefLa/c=;
 b=ykWQ/pwP9vkzZlU6ygMIQRYI4e+io5Gcxb4lm206jqz44HXb9Inh+M7wsETZAj4Fxc/S3L
 sQrW5j7wf2Xq4u1jklGJnDyZDK3KCuNp1K+h0DKeXfcvP560ZnCRglNAUJMCPi1LhytV/z
 m6y7A22ESFfv/nWtyFbUoP5cl/PL5F3dVXKCmjzifiJQ6jbnjEwbBPIiEruB47JMKxiJXO
 1DYotKY2iM0xHqN9jNLkwvWW4/R00CS37mP/zO9aF2TgWYI5OFZMZ7xRRfRdxOnB07LgM/
 rWDwB/+fb71TyCJ/wk3UFs7JA+GlmVRXOv8GpMzp+laGFK4iGk1+KfwYYwk0xg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net,
	Ralf Lici <ralf@mandelbit.com>
Date: Tue, 26 May 2026 11:17:36 +0200
Message-ID: <177978704512.1785501.8613384082307437319.b4-ty@b4>
In-Reply-To: <20260520091613.158891-1-ralf@mandelbit.com>
References: <20260520091613.158891-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gPnGD26K8z9sWm
X-Headers-End: 1wRnv6-0004v2-SG
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next v4 1/3] tcp: factor out
 TCP MSS option clamping
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


On Wed, 20 May 2026 11:16:10 +0200, Ralf Lici wrote:
> xt_TCPMSS has local logic for scanning TCP options and lowering an
> existing MSS option without increasing it.
> 
> Move that scan-and-clamp logic into a TCP helper so other networking
> code can reuse it without duplicating TCP option parsing. Keep xt_TCPMSS
> responsible for the policy-specific behavior of adding a missing MSS
> option.
> 
> [...]

Applied, thanks!

[1/3] tcp: factor out TCP MSS option clamping
      commit: f62a8f47516cc37c7fe6341c59d7ad57ad001d46
[2/3] ovpn: implement TCP MSS clamping
      commit: 83e7a11e96f65b24d3a6268b852dea7cf1c5fd74
[3/3] selftests: ovpn: add mssfix coverage
      commit: 7b12a026c24f04c40a2664fddcc39c8e8176b67b

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
