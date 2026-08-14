Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0219C5CFCF
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E7iHYNCBdd5o1aGBK2SoVYec2YA6ASN9k7guVqnDLHU=; b=fKmFSH1V7Vf2kwuWWn3R9qTCNB
	yZthgLSVbi26TxCLSSRihsQn369s8n1E4EhjCRmb5MvKtiOR3uQChfwHokCbmyw3VmSUH6jl0jpCC
	ECKf8DUJRUzP/jvLI2Y3mcrBfbBinI89RGfblNnpwhmQCmXyCG0pP3d+CNDARNzkeDZU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wutal-0005vN-DT;
	Fri, 14 Aug 2026 15:13:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wutah-0005uv-Pe
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:13:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fnOzcq8ArXVsZnoCSWk0TyEJT+4ZIXePmdQAZtoIp/I=; b=cAVU0ZLou/wi6kG5UVOPKUvZnc
 vlisEGg4sknFMppul+Qd+L7BJ0talD13OvIHLe/SKzs+e4SOMx0kFaJdIxmwoVRRp+jZ2waTQbriI
 COPIQmkklIxZNzXVBHi6sBx54zVHrLpluBQDpg7jd+5LX0bAzhEx3K0EN6nKlMLRbl48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fnOzcq8ArXVsZnoCSWk0TyEJT+4ZIXePmdQAZtoIp/I=; b=LDYTBwSHuqwdeWQm/WZ3WrC1o1
 DEsZ8L+dLwVep9/M0BZaTsHW93xdidORoIWNRaR8awhUGSrCQrqpdqC63TDxJ/l1QbHpBEoccArr2
 10AkvGppYCmox0U104ujSBW3i1Q0BsNyzta/BEaUDZ0bWK4Y6czlfjrmsp7+UkX1O3CQ=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wutag-000530-Sv for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:13:01 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4hM5M72vfXzNm1G;
 Fri, 14 Aug 2026 17:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1786720371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnOzcq8ArXVsZnoCSWk0TyEJT+4ZIXePmdQAZtoIp/I=;
 b=hSvwpiq+8ng0m4GyItLnThXRgCl7b4MG9XzC4+HMmESayH0SW884A0kZNEWPPkR+PYVXen
 ZeAY7MVdRwkfkjKwOCtEEAMJb8jLOBaBPyHzaCrPeay5xG/eDvhC3LspK/Zq9szmM5kOay
 yoFwyOoYyrlJJsP2f6izSi4bGf5eMnbG582Cz/BdZkDSnPtdEnUQLwEWyW7xtAWfhwBYX7
 FKjczvzfIF0ocCbwaxtiLhj5FtMsPlzdxWc4nQnUVVH7Q9U99GjzS1baqblZHJGmsk58fk
 eeyl6n2XuLX4paAfrhIwoX9t38pImI26uU1hvHFXy+9xctFrYLFbvZ4HH+Tdew==
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Date: Fri, 14 Aug 2026 17:12:38 +0200
Message-ID: <20260814151239.610273-1-ralf@mandelbit.com>
In-Reply-To: <an3-RStpF4RmkkSt@krikkit>
References: <an3-RStpF4RmkkSt@krikkit>
MIME-Version: 1.0
X-Headers-End: 1wutag-000530-Sv
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2 5/5] ovpn: avoid caching
 stale IPv6 dst after FIB changes
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

On Thu, 13 Aug 2026 19:26:29 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2026-07-29, 09:20:36 +0200, Ralf Lici wrote:
> > ovpn stores the IPv6 route used for UDP transmission in a per-peer dst
> > cache. IPv6 dst validation uses a cookie derived from the route itself,
> > or, for routes without their own sernum, from the associated fib6 node.
> > 
> > If the IPv6 FIB changes after ip6_dst_lookup_flow returns but before
> > dst_cache_set_ip6 reads the cookie, ovpn can store an old dst with a new
> > cookie. Later dst_cache_get_ip6 can then consider that stale dst valid
> > because the stored cookie matches the updated fib6 node sernum.
> > 
> > Sample the IPv6 FIB generation before and after route lookup, and only
> > populate ovpn's peer dst cache if the generation did not change while
> > the lookup was in flight. Also add a dst_cache helper that stores a
> > caller-provided IPv6 cookie, so the cached dst carries the cookie
> > sampled from the lookup result instead of one read after a concurrent
> > FIB update.
> > 
> > The current packet may still be transmitted with the route returned by
> > the lookup if the FIB changes before TX completion. This patch only
> > prevents that potentially stale route from being preserved in ovpn's
> > peer dst cache and reused for later packets.
> > 
> > Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
> > Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> > ---
> > Changes since v1 https://lore.kernel.org/openvpn-devel/d6c941fe19455b940dd24019e32b121f332fdc95.1785253480.git.ralf@mandelbit.com/
> > - Add smp_rmb barriers after the initial generation read and before the
> >   final generation read to avoid reordering around the lookup on weakly
> >   ordered architectures (Sashiko).
> > 
> >  drivers/net/ovpn/udp.c  | 50 ++++++++++++++++++++++++++++-------------
> >  include/net/dst_cache.h | 13 +++++++++++
> >  net/core/dst_cache.c    | 16 +++++++++----
> >  3 files changed, 60 insertions(+), 19 deletions(-)
>
> I think you should submit this one to netdev for review (as a patch,
> not as part of the next ovpn pull request), since it touches code
> outside of ovpn.
>

Ok, I'll drop this from the ovpn series and send it directly to netdev
as RFC, rebased on the current net tree and including the ovpn user, so
it does not depend on the other pending ovpn changes.

> I also feel like there should be a better way to do this. Modules
> doing their own cookie comparison seems wrong.
>

I agree, and in fact I was quite surprised when I first realized this
race. Initially kept the fix local to ovpn because a broader fix does
not seem straightforward without changing the existing IPv6 FIB
synchronization model.

Specifically, commit bbd63f06d114 ("ipv6: update fn_sernum after route
is inserted to tree") establishes the writer order as route-tree update,
barrier, then fn_sernum update, paired with a barrier after the reader
samples fn_sernum. Thus, observing a new serial orders subsequent
route-tree reads, but cannot associate that serial with a lookup which
has already completed.

After looking through the tree, I found at least 11 other call sites
which perform a lookup and later let dst_cache_set_ip6 sample the
cookie. There are also several persistent caches which store
rt6_get_cookie separately after obtaining the dst (for example
ip6_dst_store, including the tcp_v6_connect path). I haven't really
verified every user but structurally they appear to have the same
window.

The difficult part of a generic fix is that the node whose serial should
be sampled is only identified by the lookup, whereas the synchronization
contract wants that serial to be read before the authoritative
route-tree observation. I'll describe this broader issue in the RFC and
use ovpn as the concrete user, so that the IPv6 maintainers can advise
whether this should instead be addressed in the routing core.

Thanks!

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
