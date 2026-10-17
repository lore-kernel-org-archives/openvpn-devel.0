Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36B8CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ixlYWrl472vYOUNySwM8uvQ1Lh1lFaPuz+faL3Mwlc8=; b=HjIvAYphNzNlVyJ//WSwqssJzW
	/GcEKpZRKJ+TLXkRW+JAWnGANTygXqdju2emQTWWSTkdZGFz3V7jzw9t4K2yuhzBsoBF+THxME0MB
	2KZIPwR7W9vqmF2R1+AvG11DXbTV1DGNVEcw5zI70PQQ0HRymLXj1naUF4df6LPj2aSc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI49P-0001AU-5h;
	Sat, 17 Oct 2026 13:08:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1xI49N-0001AB-0F
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 13:08:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2BnZ/6hVZ6YNVqJbTyGwNNm0cRNfsh1NlKTupcRqUXg=; b=C98B5v5ko2hHKxxeQOK020QkBs
 ZiMXsf/NvxZBVJ8n1ivyWcSeVrU3KGlIxC7LcZOvG1OKdHGztMkjRTU+aYUQpPzsSeR5T/MYwgJlJ
 Mn1TSm76O65zknd+SnGTRXZXxN2ile5ArbFBO8EqfW+v6Hqm1YsmkAAjhGLId8PgEMQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2BnZ/6hVZ6YNVqJbTyGwNNm0cRNfsh1NlKTupcRqUXg=; b=kbf9fvI1aTXp93TF1BhsJJxVGD
 G+Op51wbN2OofYIMqY5ToZABB6gzDDiaeyw5yPuwTFdAIyrPzb5a+aXeEQj0q5fj95uDtUxfxPKZR
 4iYanLGjde6fuh9sPi+9KVkXfUgdnEMO4eSdWGSOG9jC+PCwAlyKFPpImgLJAwHK3Pf8=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xI49M-0001yY-2f for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 13:08:37 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j6MZ32rb1zKpCp;
 Sat, 17 Oct 2026 15:08:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1792242507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BnZ/6hVZ6YNVqJbTyGwNNm0cRNfsh1NlKTupcRqUXg=;
 b=fvtesNg/G4Hz1lCaDhU1vvGcK4U+DOCWWHutEMx35JgJdWlt4j8wKh1bYLDVco+uGeBVky
 +K7qs8VQVOQoPcVzMjgIGHI7xA9+e19lyR+LrBXkBl5sE9AU9+xWYCRv7sLV5CX5kpJdTY
 WIlNYDIyJ4hvhHWaR+baFOM3lCpC+1xioQcUXCq9vNbfADmQK8fqlZpSejiKFjHtY7s7ao
 LyVFQAwossJMpzrvAplfzwVyDp7kj64DqRS8tSngh6/35FtdCAcyz6OEIHdI8EtMcYoqvs
 UY2nGCuYVGvUcFlPfnso6EsG44I2EKoTMLm6A9u+0SeD148hO1Wnp7NLEEx04A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <eba2bbbc-ac1a-453a-a46e-1fad8e664b35@unstable.cc>
Date: Sat, 17 Oct 2026 15:08:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alejandro Pacheco <alepacheco99@gmail.com>,
 openvpn-devel@lists.sourceforge.net
References: <CAB8Pm=y=qDzUMhAA0-FVL8gce-2can1tkXTU8GFozZXZD58mQQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <CAB8Pm=y=qDzUMhAA0-FVL8gce-2can1tkXTU8GFozZXZD58mQQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4j6MZ32rb1zKpCp
X-Headers-End: 1xI49M-0001yY-2f
Subject: Re: [Openvpn-devel] [PATCH RESEND] Keep the outgoing control packet
 in a buffer owned by tls_multi
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

Hi!

First of all, thank you for switching from GitHub PRs to emails :-)
Much appreciated.

On 17/10/26 2:45 PM, Alejandro Pacheco wrote:
> Resent: the first posting of this patch
> (<CAB8Pm=zZCRoNH8ZkbOWbawmvHUd9+AgY+yas5p_5N6695weFTQ@mail.gmail.com>)
> reached the list with its long lines wrapped, so it does not apply and
> patchwork did not pick it up.  The patch is unchanged.  This time the
> diff is attached as plain text so that it arrives intact; git am takes
> this mail as it is.

Normally people send patches using `git send-email` which makes life 
much easier and all these line wrapping issues just disappear.

This said, we basically do not use patchwork anymore (it is there for 
legacy reasons, but nobody looks at it these days).

We now use gerrit.openvpn.net which you can also use via GitHub login.

Once you have logged in gerrit at least once and added your ssh key, you 
can then "push" to gerrit and your patch will show up there.

This said, sending emails to the mailing list is also fine for initial 
contributions.


Cheers,

> 
> 64fae9d8 ("Ensure that buffer of freed session are not used") and
> 2a881d73 ("Move check_session_buf_not_used method into the method that
> free the buffer") call the check_*_buf_not_used() checks a band-aid that
> a real fix would replace with more refactoring.  This patch does that for
> the to_link buffer only: it does not remove TM_INITIAL or change how
> sessions are moved.
> 
> Tested on an ASan/UBSan build with OpenSSL 3.5.4: all unit tests,
> t_lpback.sh, and t_cltsrv.sh, whose loopback configs renegotiate every
> 10 seconds with tls-auth (22 renegotiations, no sanitizer reports).
> 
>   src/openvpn/ssl.c                   | 169 +++++-----------------------
>   src/openvpn/ssl_common.h            |   8 ++
>   src/openvpn/ssl_pkt.c               |  20 +++-
>   src/openvpn/ssl_pkt.h               |  25 +++-
>   tests/unit_tests/openvpn/test_pkt.c | 103 +++++++++++++++++
>   5 files changed, 178 insertions(+), 147 deletions(-)
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
