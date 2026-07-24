Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75819C531CC
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 01:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xwzg2C7MMoRn/+joGwmpq9G/ZPxnhmXbMgq4OLMeCCY=; b=elrIaIW4d1FN4ZdkSe/fqTVWAW
	zyrsVDcuMiPiD74whg1IJtnzknuy14QMCpXqknOEWzrqkyuAs45DM5K9qVmY5L0wyv/Yu0/PFkWui
	pKcbcdYVOxt72RIUEiPzbWPbTN/twXLevhwq/o9TpWkTj4WzjGKgOpT8soUciH97L+Xk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wn4b9-0002zl-Ne;
	Fri, 24 Jul 2026 01:21:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qingfang.deng@linux.dev>) id 1wn4b6-0002zK-5y
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 01:21:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9se8yg+bLXIg9/dhMFqQQbIXvFQeXAkzeeBE0xJijIA=; b=YLHfBcmbkQBy1xfmN7rSav9s9C
 uF1SjY83GpwMsL8ndZxLu/Ni7AYIWYcgfP5REAr3YoOdncoruz9hFzTvluT2b8v7gmGSVbiDkljM7
 OhL8MB2jwgGNNqJ2PpK/pNg+Q90uB12b5HFp9Mas2fOSbTHpR8TXuWAr31is8KQdaG4o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9se8yg+bLXIg9/dhMFqQQbIXvFQeXAkzeeBE0xJijIA=; b=Vqe82LQcJTHiy16Y/0ip3kbigj
 /BjXUUoM1n4/Lg+jYQwKigfYb2YAwM623XDt+ZFoJddG6jBLec5QHs02cnSXPify37uaC2OSNaRNo
 An3/V5WT2NJAQ+S3v/5mVudrho92TVAPPcQO4HejRGgcbuHitoZs1vUyXfsCUuACkMo4=;
Received: from out-189.mta0.migadu.com ([91.218.175.189])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wn4b4-0003rh-OW for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 01:21:08 +0000
Message-ID: <b6f20704-8463-4b20-a2ba-abc8800d9867@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784856058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9se8yg+bLXIg9/dhMFqQQbIXvFQeXAkzeeBE0xJijIA=;
 b=iYRFtg8evMppzDidnFj3JVUhOMrU0RghBG8uOp0UOxIz3GcWskRPOqoq/hfECVFPjlchty
 9qI9rfPeOowdoqjPNo+h/bFYqd1sv2Prr6qUQqQs/ZGtj623B8sKE9e37ZybY9iYivo1Oy
 oM8BQc8OgBjTsSi9kXG3mTvFcqmE64Y=
Date: Fri, 24 Jul 2026 09:20:51 +0800
MIME-Version: 1.0
To: Ralf Lici <ralf@mandelbit.com>
References: <7141b546-fa56-4bcc-8ed5-3ffdb0728e25@linux.dev>
 <20260723075913.101036-1-ralf@mandelbit.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260723075913.101036-1-ralf@mandelbit.com>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1wn4b4-0003rh-OW
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
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@unstable.cc>,
 Antonio Quartulli <antonio@openvpn.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi Ralf,

On 2026/7/23 15:59, Ralf Lici wrote:
> rcu_dereference relies on rcu_read_lock_held to check that the caller
> context is valid. However, ovpn_peer_release_p2p does not hold a normal
> rcu_read_lock section, it relies on the BH-disabled section established
> by spin_lock_bh instead.
>
> rcu_read_lock_held does not consider BH-disabled context, so it will
> return false here. In contrast, rcu_read_lock_bh_held explicitly
> recognizes BH-disabled/softirq context.
>
> So I think Sashiko is right: rcu_dereference will trigger its RCU
> lockdep warning with CONFIG_PROVE_RCU enabled. This should use
> rcu_dereference_bh instead.

I read the code, and found that you are correct. I'll submit a new patch 
with your suggested change. Thank you.

Best regards,

Qingfang



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
