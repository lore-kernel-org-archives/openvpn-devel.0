Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A05AC531F9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EQDZgP4S0mcLSwP7RseE69AHsIS/DeBKQoXthKajRXI=; b=CuGeV5tphwde/ixofgR7Za8UYY
	qMPynTQGcqX6DE+Ldq1bzQvThT0LR3HjGLRYp2woPl7YhwSFlHdy373XkDaxrFspNXsVaeIzo+KMw
	g/RS8xrnBm4fXdcIoXe87k7iwuE3cyS5Oe8HRdEaLaW1M/65cz17o7YDkyRJ02CBGVOY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wn9cc-0001Vw-9G;
	Fri, 24 Jul 2026 06:42:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wn9cb-0001Vp-Cr
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 06:42:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vk7UL3eB+WDAr/Aa3ifh383TSIGwEwf1eXqS/QANvQM=; b=IqbY+ZE/sEdFGRYEBAhiuVt203
 dIhYW6BzELpBSlGjfk+aoiRRz1654ZJK3xLVj4SQdPfYfstSVC/1895t4zx5bSxLpBELwCxbbWuoI
 AzZZ5MQ8WIWtT73LChdCwIyKJCzZ7CLwmpEBRqo3p6J2B80dQMLi6HTyJY0BX8avI9fU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:References
 :In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Vk7UL3eB+WDAr/Aa3ifh383TSIGwEwf1eXqS/QANvQM=; b=b6HMC/xYw/Eh777jIvXHCaU+Bc
 gnJs/Aw08Z79i5nffXpihY+k31qIOSvzuGPcbDmNAgysi5Y6bpD56ZkbSuyBMtNuy0Xet72j5FaTL
 BUNZaRjAYfKrJ0VWevA5eHo6RaFC8+bW9H9TxrC0pSLszoneuk/yub6OO1GHWUw5i8bk=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wn9ca-0003bK-Ei for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 06:42:58 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h5z2J5hZpzMlGd;
 Fri, 24 Jul 2026 08:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1784875369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vk7UL3eB+WDAr/Aa3ifh383TSIGwEwf1eXqS/QANvQM=;
 b=GhKHmUAKIPKnGexzD2MDJcP5hZMVTA1TYIiUHGsw82mT3t7600GU0tMWqwbUmhZ9nMwOD5
 qt6MO0oegjX7CZ0TtEyjeWmap4kG3dpswH6Ev1NAWse5FbeYw0UqrF49D2ujsVNeLtw6Df
 5UbaVeA1hDjkwo0NVPYWNOtKwByjL8Zg+CT+A8yd9xXqCS5MzaLZKV2VBe9ty2uwf/jd2f
 losdx0BrJlBIifgnLCeeUFD5sehytxglyAKnncHPvEiFtKSypncZ1DcRiVZ5Izv7MYtsNS
 x35BBgwVBL+CReHkmI04E8JCNhMBsQAunlNeZfai+7sJ3pZozLm+yx4vbEJhzw==
Date: Fri, 24 Jul 2026 08:42:46 +0200
From: Antonio Quartulli <a@unstable.cc>
To: Qingfang Deng <qingfang.deng@linux.dev>, Ralf Lici <ralf@mandelbit.com>
In-Reply-To: <b6f20704-8463-4b20-a2ba-abc8800d9867@linux.dev>
References: <7141b546-fa56-4bcc-8ed5-3ffdb0728e25@linux.dev>
 <20260723075913.101036-1-ralf@mandelbit.com>
 <b6f20704-8463-4b20-a2ba-abc8800d9867@linux.dev>
Message-ID: <7DF3B941-0E29-4DFD-B799-651720A0828D@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wn9ca-0003bK-Ei
Subject: Re: [Openvpn-devel] [PATCH ovpn-net] ovpn: fix incorrect use of
 rcu_access_pointer()
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
Cc: Antonio Quartulli <antonio@openvpn.net>,
 openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

hi Qingfang,

When resending, please split the subject as "ovpn net" so that our patchwork can pick it up correctly.

Thanks a lot!

Il 24 Luglio 2026 03:20:51 CEST, Qingfang Deng <qingfang.deng@linux.dev> ha scritto:
>Hi Ralf,
>
>On 2026/7/23 15:59, Ralf Lici wrote:
>> rcu_dereference relies on rcu_read_lock_held to check that the caller
>> context is valid. However, ovpn_peer_release_p2p does not hold a normal
>> rcu_read_lock section, it relies on the BH-disabled section established
>> by spin_lock_bh instead.
>> 
>> rcu_read_lock_held does not consider BH-disabled context, so it will
>> return false here. In contrast, rcu_read_lock_bh_held explicitly
>> recognizes BH-disabled/softirq context.
>> 
>> So I think Sashiko is right: rcu_dereference will trigger its RCU
>> lockdep warning with CONFIG_PROVE_RCU enabled. This should use
>> rcu_dereference_bh instead.
>
>I read the code, and found that you are correct. I'll submit a new patch with your suggested change. Thank you.
>
>Best regards,
>
>Qingfang
>

Antonio Quartulli
Edited on mobile, please excuse typos and brevity.


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
