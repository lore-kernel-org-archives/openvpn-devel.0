Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7C5C5AC7A
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6kUFSBN54qNbGslGe8Qjo1CopPWqg4cpCTTYW70yJT4=; b=TiQVa+TxQZJIx/vnLHVWfRWgiU
	8aEKLmkKB4OuJ28BRrvSUo7mTbQqGuuekBn2w8lBO/6UaPd8IwUwJna/npT9b9Fhp8+cyD8DqrQ5Z
	6N6l7yYa0lGzTNOcN9u8D5AwdcUYlYA6mZtRB+9I4BvSlWqLLnsIJewfbD2PCi9cgNMo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsES8-0000yN-Oe;
	Fri, 07 Aug 2026 06:53:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wsES6-0000yG-7d
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 06:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YaEqWqzsPU9EDtSX7rm8CZUyPtfuusAVa2QxCf7C4sY=; b=FGz0hKKhcD5QM/KwzzwFxH0cKf
 Swl+1TU5LnmokbfqfvaaDdpR0Qs1xFlu2pzRxYl8pt8I4Jmtm4uAgeGhZXKbezGBbBKgh8ig4PUsL
 tlnb58NWqcIFZDKezq9n7b6JHsfdbx00zMWSJTePq/96KbrJr/rBCBxUmyob0trMcGoM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YaEqWqzsPU9EDtSX7rm8CZUyPtfuusAVa2QxCf7C4sY=; b=bwZPEseTDSQmHz9mFdzd78SeiH
 1W2wkXmEkuGhp2e4lcbHYctQA6big2ySODFVPZEPKsP/7UtNZC7JBcaT3MNjjupHX92eXaLoRd2dP
 /tGDRcxCj8g+0LJa9/0RQjjV5mQomzQGCFibFmW9LVP8J5aC81acYwofITJX/BMzqSkI=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsES8-0002Ff-Qu for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 06:53:10 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hGZbc6ZzfzLllD;
 Fri, 07 Aug 2026 08:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1786085580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YaEqWqzsPU9EDtSX7rm8CZUyPtfuusAVa2QxCf7C4sY=;
 b=JSqCFZMFR54CzwdZHYHtr/Rmo+nGDdI1OPRma/LjBF1QgarVEbTI0ikOONe8mwFZXIeuIJ
 j4p9o/TxXuohV5tPt3ipgMp/YKvafX9kVzmk6n5EESqlw5e6SzgQE8m2gxt98VtYGrec2t
 IrY/g3fe4GyjJ/QjvivO9uDjZI6v1pUOEuNWmNG3BjoY/w15MT3+hheCJRBIs3UWZPflVg
 Q9xvOC/fCjB+uzB8SzS0mCKKc5omciKzsCsFhL3yGiC2zi1TFeOizVX+TcJdDLpA8Qv4iB
 4x85VJcTS98KcA9P8w8hje+Z8x+rM5Ux6kx2M9DiOg3gNkaX4jpdyzK2zQTOyA==
From: Ralf Lici <ralf@mandelbit.com>
To: Antonio Quartulli <a@unstable.cc>
Date: Fri,  7 Aug 2026 08:52:52 +0200
Message-ID: <20260807065253.73909-1-ralf@mandelbit.com>
In-Reply-To: <21e52998-7f7b-43e9-b04a-cce269d658ed@unstable.cc>
References: <21e52998-7f7b-43e9-b04a-cce269d658ed@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wsES8-0002Ff-Qu
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: ralf@mandelbit.com

On Fri, 07 Aug 2026 08:36:20 +0200, Antonio Quartulli <a@unstable.cc> wrote:
> Hi Ralf,
>
> On 29/07/2026 12:21, Ralf Lici wrote:
> > ovpn queues several work items whose callbacks execute module text.
> > These works currently run on the global system workqueues, so module
> > exit has no driver-owned drain point that guarantees the callbacks have
> > fully returned before the module text can be freed.
> > 
> > Object references protect the objects used by the callbacks, but they do
> > not prove that a workqueue function has returned. In particular, a
> > worker can drop the final reference that unblocks device teardown while
> > it is still executing ovpn code.
> > 
> > Add a module-owned workqueue and queue all ovpn work items on it. During
> > module exit, unregister rtnl and netlink first, flush the workqueue so
> > ordinary ovpn workers finish, run the final RCU barrier, and destroy the
> > workqueue last. This keeps the workqueue available for cleanup work
> > queued from RCU callbacks, while ensuring no ovpn work item can outlive
> > the module text.
> > 
> > The per-device delayed keepalive work remains explicitly disabled during
> > netdev teardown (disable_delayed_work_sync in ndo_uninit), since
> > flush_workqueue does not flush delayed work that is still only pending
> > on its timer.
> > 
> > Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
> > Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> > Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> > ---
> > Changes since v5 https://lore.kernel.org/openvpn-devel/d530ecfc3719845075fbddd0cd7c34752bc2ce16.1783336121.git.ralf@mandelbit.com/
> > - Update the module-exit ordering for the queue_rcu_work-based key-slot
> >    release: flush ordinary ovpn work before rcu_barrier, then destroy the
> >    workqueue after RCU callbacks have queued their cleanup work.
> > 
> > Changes since v4 https://lore.kernel.org/openvpn-devel/6edfcc51e0855bfd34286b86d4e7f26bb3bcd3f7.1783099626.git.ralf@mandelbit.com/
> > - Rebase on the pending keepalive and TCP deferred-work refcount fixes,
> >    preserving their hold-before-queue and queue-failure put handling when
> >    converting schedule_work to queue_work.
> > 
> > Changes since v3 https://lore.kernel.org/openvpn-devel/49f38f89340e18ed30543d3990a7a7e20595b6af.1783080055.git.ralf@mandelbit.com/
> > - Replace the RCU-deferred peer netdev reference release with a
> >    module-owned workqueue that drains all ovpn work callbacks before
> >    module text can be freed.
> > 
> >   drivers/net/ovpn/main.c     | 19 ++++++++++++++++++-
> >   drivers/net/ovpn/ovpnpriv.h |  4 ++++
> >   drivers/net/ovpn/peer.c     |  8 ++++----
> >   drivers/net/ovpn/tcp.c      |  9 ++++-----
> >   4 files changed, 30 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> > index 5093a3b5aba6..80d10f9ef7d8 100644
> > --- a/drivers/net/ovpn/main.c
> > +++ b/drivers/net/ovpn/main.c
> > @@ -12,6 +12,7 @@
> >   #include <linux/module.h>
> >   #include <linux/netdevice.h>
> >   #include <linux/inetdevice.h>
> > +#include <linux/workqueue.h>
> >   #include <net/gro_cells.h>
> >   #include <net/ip.h>
> >   #include <net/rtnetlink.h>
> > @@ -26,6 +27,9 @@
> >   #include "tcp.h"
> >   #include "udp.h"
> >   
> > +/* module-owned workqueue on which all ovpn-specific work is queued */
> > +struct workqueue_struct *ovpn_wq;
> > +
> >   static void ovpn_priv_free(struct net_device *net)
> >   {
> >   	struct ovpn_priv *ovpn = netdev_priv(net);
> > @@ -237,10 +241,16 @@ static int __init ovpn_init(void)
> >   
> >   	ovpn_tcp_init();
> >   
> > +	ovpn_wq = alloc_workqueue("ovpn", 0, 0);
>
> This is triggering:
>
>
> workqueue: ovpn is using neither WQ_PERCPU or WQ_UNBOUND. Setting WQ_PERCPU.
> WARNING: kernel/workqueue.c:5852 at __alloc_workqueue+0x1cf5/0x2060, 
> CPU#0: swapper/0/1
>
>
> Can you fix it and resend this patch only please?
>

Sure. Apparently the development tree used for this series predated
commit 21c05ca88a54 ("workqueue: Add warnings and ensure one among
WQ_PERCPU or WQ_UNBOUND is present"), which now warns when the selection
is implicit.

I'll resend this patch, explicitly selecting WQ_PERCPU to preserve the
existing workqueue behavior.

>
> Regards,
>

Regards,

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
