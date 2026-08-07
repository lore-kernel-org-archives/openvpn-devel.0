Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AF2C5AC7C
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zOai7Wx1oQdyafw3EFamAYvvhlTP/uRy9kZOKzYzxG8=; b=VkuxPkghreSh8QQfTvOhtXjVN4
	BM6LyVdE53SAvRc1YobaFHOBGlmTIhgN/yx4AvF3TruywrA/F03A2dcWiU5LizKalT4uofJnHl5hi
	bUVR/tyWEk5nwywubP3fAKnpJUkYSvAVY0zVzp0pfuEUw6FPjU5lcZi6122D50xTYonk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsEC5-0003pe-JT;
	Fri, 07 Aug 2026 06:36:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wsEC4-0003pX-DR
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 06:36:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OsKvWwOY55sTTnzGeMn4E7UHREzZDYyqPJFCzkzm/xo=; b=GiytKd/2nJ1TIaBHi2OWT+q7CZ
 CTPVDdE1AtrojoyTo1xh33G5K+OE96RUO3CiLi7/gCUpeWGQfdqf8Akx674G/OTjpAMJ+OmedoBnZ
 6AZTkqHMwI9kI/gLevX5KY0TMsugYcSJQvbEm0ElZk01lvnWkfXrCwTeJRjspjEYdsIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OsKvWwOY55sTTnzGeMn4E7UHREzZDYyqPJFCzkzm/xo=; b=DPN46pwmZ0R8FabTmo8llb19RT
 3uJL1/qS03ukE8f5lfcIBJd3Zj9sN9R6hurDl9rtwchgMPymCvOfoz4Wv3pJHo5T1wPWTcZDfoN/k
 1s90Qn5FQ4UlVrovWjQoIzoADqUzdyBsFZWy8oIu64RUDOGfmC+3HX3ViTZCKbkaeiYU=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsEC3-0000pW-8r for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 06:36:33 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hGZDR29CTzKrd6;
 Fri, 07 Aug 2026 08:36:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1786084583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OsKvWwOY55sTTnzGeMn4E7UHREzZDYyqPJFCzkzm/xo=;
 b=DEulxEI9tcHePJgpUr0iQKNb4s4EgYqPZBCpMOzHv/sN3NTiIpcbJZlc1KbrQWynn32PWi
 Ppe4Kve+wN9dysUM5ZE+if6Zfj/gvihj7TcuZ2I/53GGlZ5k2Xq+NNoW/DEbKp9HCmGIaN
 B0awU4PUV567kZs2RhfO2bTgq6+t9OkG3L1qLSTHYVTUBBlsX2JsW6Ux4G80hoX5ci7NIq
 vlX8kBDnDH5BWSGojxP/KlClX+5es8j+HryYrTxr8NJ35b8R5SDGJLZ+fcdEoefYruYCYl
 a0LB9zcvNFraJd5hg/BJExBGH+7Gc0xiIMaqGOTYVWru6FezUlxLuyymuUqGSA==
Message-ID: <21e52998-7f7b-43e9-b04a-cce269d658ed@unstable.cc>
Date: Fri, 7 Aug 2026 08:36:20 +0200
MIME-Version: 1.0
To: Ralf Lici <ralf@mandelbit.com>, openvpn-devel@lists.sourceforge.net
References: <cover.1785318038.git.ralf@mandelbit.com>
 <51a8febf0da1fe17e5fc0b857e8d0a8797002ea2.1785318038.git.ralf@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <51a8febf0da1fe17e5fc0b857e8d0a8797002ea2.1785318038.git.ralf@mandelbit.com>
X-Headers-End: 1wsEC3-0000pW-8r
Subject: Re: [Openvpn-devel] [PATCH ovpn net v6 5/6] ovpn: run deferred work
 on a module-owned workqueue
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

Hi Ralf,

On 29/07/2026 12:21, Ralf Lici wrote:
> ovpn queues several work items whose callbacks execute module text.
> These works currently run on the global system workqueues, so module
> exit has no driver-owned drain point that guarantees the callbacks have
> fully returned before the module text can be freed.
> 
> Object references protect the objects used by the callbacks, but they do
> not prove that a workqueue function has returned. In particular, a
> worker can drop the final reference that unblocks device teardown while
> it is still executing ovpn code.
> 
> Add a module-owned workqueue and queue all ovpn work items on it. During
> module exit, unregister rtnl and netlink first, flush the workqueue so
> ordinary ovpn workers finish, run the final RCU barrier, and destroy the
> workqueue last. This keeps the workqueue available for cleanup work
> queued from RCU callbacks, while ensuring no ovpn work item can outlive
> the module text.
> 
> The per-device delayed keepalive work remains explicitly disabled during
> netdev teardown (disable_delayed_work_sync in ndo_uninit), since
> flush_workqueue does not flush delayed work that is still only pending
> on its timer.
> 
> Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> ---
> Changes since v5 https://lore.kernel.org/openvpn-devel/d530ecfc3719845075fbddd0cd7c34752bc2ce16.1783336121.git.ralf@mandelbit.com/
> - Update the module-exit ordering for the queue_rcu_work-based key-slot
>    release: flush ordinary ovpn work before rcu_barrier, then destroy the
>    workqueue after RCU callbacks have queued their cleanup work.
> 
> Changes since v4 https://lore.kernel.org/openvpn-devel/6edfcc51e0855bfd34286b86d4e7f26bb3bcd3f7.1783099626.git.ralf@mandelbit.com/
> - Rebase on the pending keepalive and TCP deferred-work refcount fixes,
>    preserving their hold-before-queue and queue-failure put handling when
>    converting schedule_work to queue_work.
> 
> Changes since v3 https://lore.kernel.org/openvpn-devel/49f38f89340e18ed30543d3990a7a7e20595b6af.1783080055.git.ralf@mandelbit.com/
> - Replace the RCU-deferred peer netdev reference release with a
>    module-owned workqueue that drains all ovpn work callbacks before
>    module text can be freed.
> 
>   drivers/net/ovpn/main.c     | 19 ++++++++++++++++++-
>   drivers/net/ovpn/ovpnpriv.h |  4 ++++
>   drivers/net/ovpn/peer.c     |  8 ++++----
>   drivers/net/ovpn/tcp.c      |  9 ++++-----
>   4 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index 5093a3b5aba6..80d10f9ef7d8 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -12,6 +12,7 @@
>   #include <linux/module.h>
>   #include <linux/netdevice.h>
>   #include <linux/inetdevice.h>
> +#include <linux/workqueue.h>
>   #include <net/gro_cells.h>
>   #include <net/ip.h>
>   #include <net/rtnetlink.h>
> @@ -26,6 +27,9 @@
>   #include "tcp.h"
>   #include "udp.h"
>   
> +/* module-owned workqueue on which all ovpn-specific work is queued */
> +struct workqueue_struct *ovpn_wq;
> +
>   static void ovpn_priv_free(struct net_device *net)
>   {
>   	struct ovpn_priv *ovpn = netdev_priv(net);
> @@ -237,10 +241,16 @@ static int __init ovpn_init(void)
>   
>   	ovpn_tcp_init();
>   
> +	ovpn_wq = alloc_workqueue("ovpn", 0, 0);

This is triggering:


workqueue: ovpn is using neither WQ_PERCPU or WQ_UNBOUND. Setting WQ_PERCPU.
WARNING: kernel/workqueue.c:5852 at __alloc_workqueue+0x1cf5/0x2060, 
CPU#0: swapper/0/1


Can you fix it and resend this patch only please?


Regards,


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
