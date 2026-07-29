Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF54C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=whstFDdDg4uWz+Vs9LcwKTFjN9SGin7M37P6uPw8HQc=; b=LlnClQLlPVy4RPEO9v7WCtTS5U
	P6F0tFwrQJNZJzam2CWSUui18wMz5npJK1Z1m2URp9fRo5MnnyJSdin9AjmOaV4BjYCKkSZ7tJePa
	Zg+OKOHLL8c/An/arZgNJyD2tYdvEcE7rd4XF7T79wHRf8CUbHEAx+88eWMvILlCKX5A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp5DK-0000ff-Nz;
	Wed, 29 Jul 2026 14:24:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wp5DF-0000fV-SM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 14:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QTXUN+35YqGZJ4ScikbTz6Mee1AcU03UYz450+i9tjg=; b=HXowx/M8SRbsuCYZV74k0QQGQP
 P0jC9J8GERUYSVlyzbSeynWBs/C2Q2oKo3oBpEufAB1vDgPjSd/Hc5w/Vper7/QwOWUyLWO3tJ706
 D+Z2CkljSW1MD4jaZVMnT53/pjtP/pkRWLV5324G3pFPP/ND4oxCl260liSurWiLvJnU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QTXUN+35YqGZJ4ScikbTz6Mee1AcU03UYz450+i9tjg=; b=BQ/ABRMno7QWyF68lwrTLkjqbA
 HRVT96hMl/2YgRQv84vpuJYCqKkA0oDtfNguFkb1C3VrMX/yhQcuiUjKohEQBsHYHK9LxYktWH++W
 HhTK486/Ai0BzLo50xbOYis3rZon7QVcgxn4MgWc9RO1hqePa8SGDoLDVbQrZrzMSXm4=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp5DE-0007wV-7N for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 14:24:46 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h9F2s2Z43zKry1;
 Wed, 29 Jul 2026 16:24:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785335077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTXUN+35YqGZJ4ScikbTz6Mee1AcU03UYz450+i9tjg=;
 b=czs5Q6IWXje9i6mtJN51g8vN7hUiqixS1Hnr9mjpxcmgGqCKBf7BZJDRIKJ8YYnaLlZdvH
 8eFgckfuL7yYImS2AF1huzOeDnA90xTkFtbmFhZ30ffZ+MmlR3JWAa+VGHrBl0RykYkX5y
 S3EZJjGHZWWKVyUr95T3Gj4IpgEzQlJW/L/FOLd2Auf8ES49UXo71OV3Lv2zdx5OHx4B8+
 1utYIJ5pa9ByUbpADYz7n49EdjiEAkP5ZHEZzOzWquNloKDCpCneL2S9WjPTYwD0mQK6+a
 qwyTcbe9OmQx8IY7oirDSxfrygMqcrc+JVgfaGuUQApunTXmQUNsBWXQfLs+yg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net,
	Marco Baffo <marco@mandelbit.com>
Date: Wed, 29 Jul 2026 16:24:34 +0200
Message-ID: <178533503835.3401193.9494255643214459842.b4-ty@b4>
In-Reply-To: <20260722044756.872870-1-marco@mandelbit.com>
References: <20260722044756.872870-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9F2s2Z43zKry1
X-Headers-End: 1wp5DE-0007wV-7N
Subject: Re: [Openvpn-devel] [PATCH ovpn net] ovpn: limit keepalive values
 to one day
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


On Wed, 22 Jul 2026 06:47:56 +0200, Marco Baffo wrote:
> Large keepalive values can overflow the delayed-work delay on 32-bit
> systems, causing the keepalive worker to be repeatedly scheduled.
> 
> A correct configuration should not require such large keepalive values,
> and an upper limit of one day is already generous and unnecessary in
> practice. Limit both the keepalive interval and timeout to 86400 seconds.
> 
> [...]

Applied, thanks!

[1/1] ovpn: limit keepalive values to one day
      commit: 702eea95f2dd2d4bee98c2d6c479f5ad1d8d0805

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
