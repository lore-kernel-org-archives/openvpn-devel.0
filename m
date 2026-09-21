Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6B2C982E6
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O48j4KwzIjxszgOhwMj+bPjYPK4q7nPqe/44UvzPaRM=; b=Q8jjPY6vzicFqwFlFR1fNBx4IN
	9bEgSh8AmrpWBub534YY01GbskjnuhvVh37rR7GxrhDaum+Kr7Bl6bQVSvvCtnZzXe/wG2f0zDrwA
	8uk+D+HYACpAe56FeOJtaPNtxmrJGFdfQ25VDVKQX5f24BXGf5mC9ZSV8Wv6XycO2obI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8nnB-0001wZ-7l;
	Mon, 21 Sep 2026 23:51:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1x8nn9-0001wQ-3Z
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 23:51:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SkuP/d6Ut1ZBhaVWNwacp8gCV7vMvPLq15j98J5mrMY=; b=mbzJa6QTu6njupjoD3ihJn/F66
 oaX+18EXJ64ART93uyCbN4SBWq34KIwrt91PEdGFn1WvYlQxFGYLhlLe7xrdDz42T1pCJeF4lHgAo
 ZlJdkEnHn0xrHxh9PbH0NxEl9BhNwIb2gssE+RWDOHmQgZdls2RYrBnXuRrIRhlDp6SA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:To:From:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SkuP/d6Ut1ZBhaVWNwacp8gCV7vMvPLq15j98J5mrMY=; b=d0DxmKK6esmRIHHLv9u3Wb6jVW
 Tqx74b3akzOorTNvyklmWCKyc5WPVhZlLMGgcyy+G57km/bRyNvUNw3VuCSZCI5XvwW7wkcbFVfRD
 VzgcCXnzuYY0nFTQ6mfmMPExZ6lk3JqWsCnt/gtwEYHs31BTaHGDRGD9Y9K+UexcKZoE=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8nn9-0004MD-8X for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 23:51:23 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hpg3l1TkszKn9c;
 Tue, 22 Sep 2026 01:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1790034675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SkuP/d6Ut1ZBhaVWNwacp8gCV7vMvPLq15j98J5mrMY=;
 b=rneh81qQfPhozw9cGSmd+XH5HlIvoGnRP2dKX22e3k+eeZIG5+Yy8v944tL4mrIx60IyIy
 1nvbMU9lOFEsimMNLGr4y9lCsZzwoQZQK6+A/dngcrIJ53OTSp0S9PQ63zomykc8pIzGhJ
 5SYmtBnV4LIb9npsJqHTnbcznY/tlS6Az9g3oWukHw1Of0ofnzFnZAZCcjVZKHCZFyaf/v
 OOJVGr9CE1Zpyu57Wm0Xbc6xRZmq8j0TGNXFSs6iI2RNvfIYi4FTzTTGLgyB279MHRXn4D
 K6DANiYvSrxKH6/WKWHhosykLH/JBoVoI79U4aYPfsKIzkhxw19Tebzztx6GWw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <d052d158-6539-4a43-8374-fa1d535db271@unstable.cc>
Date: Tue, 22 Sep 2026 01:51:13 +0200
MIME-Version: 1.0
From: Antonio Quartulli <a@unstable.cc>
To: Marco Baffo <marco@mandelbit.com>, openvpn-devel@lists.sourceforge.net,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20260729153815.2637139-1-marco@mandelbit.com>
 <eac0bdda-628c-4c0c-82ac-9184c1d602ad@unstable.cc>
Content-Language: en-US
In-Reply-To: <eac0bdda-628c-4c0c-82ac-9184c1d602ad@unstable.cc>
X-Rspamd-Queue-Id: 4hpg3l1TkszKn9c
X-Headers-End: 1x8nn9-0004MD-8X
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

On 22/09/2026 01:40, Antonio Quartulli wrote:
> Hi Sabrina,
> 
> I hope you're doing well!
> 
> Do you have any strong opinion on this patchset?

FTR - there is a v4 of this patchset.

This is not the last version on the list.

Regards,

-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
