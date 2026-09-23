Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF55C982EA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 06:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c5p78Q9wOlflN/O5Iyuv63jb49kMZ3QelP5uD06b5oo=; b=GV3rIsLLGS8NtJNIkqK09fp6Xg
	oRer3CEWrGXJyNRq/ZtZz2gxCDYssiYISLKh3QhRyHiwTJIPq0Ikq7QESCmbow1Svr6SSu8xkiDzt
	YK28MdcAvOMZ74nDu86bR+BKfosqdLj6ib7AklmwBIB3m2YS6s5GjhUivn1KUj3AtTEY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9GUb-0006Ru-CL;
	Wed, 23 Sep 2026 06:30:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x9GUH-0006QB-9h
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 06:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qCndnCdEnaFjDeVijU+XmMHMVWItFg+y7x71VJ1jPro=; b=dEhANQILJLmhHsWgZz4v7Nyj2N
 Ysgm45RaDrEpMWPMof3hVMxbs3A/wiavTZYzZzmluQuXYQcsfywFq3iRrTMIcQHOicef1rzBgkvZe
 yTkMhWStjT1qFkrfQYf2NSduzw0clSPnc/W/kWksZaeYiYpfVjPKIoQwPUICywfbnAQo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:References:
 In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qCndnCdEnaFjDeVijU+XmMHMVWItFg+y7x71VJ1jPro=; b=UdomOpqV1l9coUJwr0feg6mEn4
 wN5dAa4DIfRWS2TEIlkYPC4/q4rIsnLrL6LYkSuxygtBaVhMxx+z5Nkxxh/gg8pPsFGI/3SYSAjSD
 5TSBhKf8Nd83rG5AL+eZjsHbZmICnzOU+W4f2LN52u1quVZaMrCzUkR/MgGXBqo6RfPg=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9GUF-00057Q-6X for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 06:29:50 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4hqRrz1KwmzFr0t;
 Wed, 23 Sep 2026 08:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1790144979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qCndnCdEnaFjDeVijU+XmMHMVWItFg+y7x71VJ1jPro=;
 b=fcU1XBO3HDtPyr8VRjIwVdgmT8S2D4FEkmPQww2AvFUI4GyOlRKn2OO/CrNtdWIMI6UXMN
 dhY8wovC+XmZkL3A6R01mokKicTC+yyZYoseNWH/zuANe14lhY6b9jL3MnHKcAIfIqQxLC
 ggai2/thWYJFEswlrc3KKrnsAiJcafXh2sfwlL8B2bOZ+6P+ehcRmARC97sEobiw+n57Sj
 xaOJpgUagjECtnlRaY4QKgrxfcBoQ5lOBmQaOWRd8ER4WZZSvXOcyk4WkrOc3IdxOVFBpZ
 xvPU0q6etketXtjZGzaaJkPC9i3LUrQEkM2nHcLdjSiYee7ciXXNkzFBHoiS2w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
Date: Wed, 23 Sep 2026 08:29:38 +0200 (CEST)
From: Marco Baffo <marco@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Antonio Quartulli <a@unstable.cc>
Message-ID: <1053515644.17604.1790144978238@app.mailbox.org>
In-Reply-To: <arMHXj3loK6DgDld@krikkit>
References: <20260729153815.2637139-1-marco@mandelbit.com>
 <eac0bdda-628c-4c0c-82ac-9184c1d602ad@unstable.cc>
 <arMHXj3loK6DgDld@krikkit>
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: 4hqRrz1KwmzFr0t
X-Headers-End: 1x9GUF-00057Q-6X
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next v3 1/4] ovpn: support
 operations on interfaces in foreign netns
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

Hi Sabrina! In the end i opted for rtnl_get_net_ns_capable(),
if you want to have a look this is the latest patchset:
https://lore.kernel.org/openvpn-devel/20260922142505.3138388-1-marco@mandelbit.com/T/#t


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
