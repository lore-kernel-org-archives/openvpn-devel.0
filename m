Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96487C43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FQlXuclLYmEUO4M76PfA0J+2hLQst454HrXe9p1sU/E=; b=Ols68Bx3WEA/1cMZm9lqDHPbzb
	d2Mrf6bHczcbWg3wxS2MIh17JUJDqW7NK2XMO8VsDWzStU+GK6+niWFeHx9mqDuuZ9p+3MF0GoL8X
	riAhrPg/VlE2DhLM8KKwJDIX2+nbhoafLtXxeDIPxyhpge8CSkbOXCxPJWHj8cVPZfD4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wghao-0003Ji-Sv;
	Mon, 06 Jul 2026 11:34:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wgham-0003Jb-2Y
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HrheQwGnnmXTjE3E95q9a7x1dhjeCikJkANiXjR3w98=; b=MTZK3CtsdqEa08DZEvjorNULqa
 fQ/Cnd3FQ7gLDu7E7nl5E7pTxUmQlZC7sly1Xf0Q6y9UJM4PJY8HAJhqTKDF7OMxMj4mdsAsaCtvZ
 rhlsBMgHH2bV453Ms6i/f1lV8MxBxpRv5RfOvvzwJuPNPndWN8qawsmfDBZU2rxwTjOc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HrheQwGnnmXTjE3E95q9a7x1dhjeCikJkANiXjR3w98=; b=b
 WchyaPPfCDgQ8lT2hzPl7o4XSYQtT7+kuriRmLUuJj/pPUefo5hnUJ43gs9UNLINWUjZHL2qnyZvk
 ZtH/v60fbMZ+3/FWiWxNx0+dK9Udg4BXHIZ0tLlHUh8P6sZQyl5wwn49reYrTsDiCn7xnYH1EY4fd
 s3GEquBRqh8WodGA=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wghaj-0006jA-FG for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:28 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4gv2Lx2RkxzDsVk;
 Mon,  6 Jul 2026 13:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783337657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HrheQwGnnmXTjE3E95q9a7x1dhjeCikJkANiXjR3w98=;
 b=B2pgx52b+jRN0xksqqabZl1NDIVCNGlKLSb994rl1bJODrQh+S9pDhMGJIbc03YUDSPfP6
 UcZu8fmo9X+gYxULkGuwyBAwPcUDrKt0Jemf7HC54kN2QWblkLHEcjtaEBKAsQzoTcN3gC
 fKeAeIZnJDseOn/ayS4CpxRZKGLub4PMFQkV+vMqQFsVwqN8MqLWGEJtkFS+OHKDEyCyDp
 YbiPqX9PW1JzXtdTpjnQjimEPC7Ok0kqzWk7Or94NH+Dy4kjfm2gtolCiVRbzj3nUb+ORn
 WukoKDTwna4W7NGakEew8nAGBWI9+g7Isd7QDJSmMoebf80h2LgdD3cuYZRq1w==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  6 Jul 2026 13:33:58 +0200
Message-ID: <cover.1783336121.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wghaj-0006jA-FG
Subject: [Openvpn-devel] [PATCH ovpn net v5 0/6] ovpn: fix key and workqueue
 lifetime issues
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi,

This series collects the ovpn fixes we discussed around key-slot
handling, netlink key notifications, TCP initialization ordering, and
teardown of deferred work.

The first two patches were sent separately before. They are included
here again so the whole set can be picked in the intended order.

The last three patches fix lifetime problems where callback/workqueue
cleanup could continue after the reference that pins netdev/module
teardown had already been dropped. The series first makes crypto
callbacks finish their own cleanup before releasing the peer, then moves
ovpn work items to a module-owned workqueue that is drained during
module exit, and finally defers key-slot AEAD transform freeing to that
workqueue so crypto_free_aead() does not run from an RCU callback.

This series is based on top of these pending ovpn net fixes, which are
not included here:

  commit 746ed3312a64 ("ovpn: hold peer before scheduling keepalive work")
  commit 2e32df6613f3 ("ovpn: fix peer refcount leak in TCP error paths")

Thanks,

Ralf Lici
Mandelbit Srl

---
Changes since v4 https://lore.kernel.org/openvpn-devel/981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com/
- Include the NULL-slot and key-id notification fixes in this series so
  the whole set can be picked in order.
- Add the TCP initialization ordering fix before the teardown/workqueue
  fixes.
- Rebase the workqueue conversion on the pending keepalive and TCP
  deferred-work refcount fixes listed above.

Ralf Lici (6):
  ovpn: fix NULL dereference when killing missing key
  ovpn: use nla_put_u32 for the key ID attribute in
    ovpn_nl_key_swap_notify
  ovpn: initialize TCP state before registering UAPI
  ovpn: finish crypto callback cleanup before peer release
  ovpn: run deferred work on a module-owned workqueue
  ovpn: defer key slot crypto freeing to workqueue

 drivers/net/ovpn/crypto.c      | 25 +++++++++++--------------
 drivers/net/ovpn/crypto.h      |  3 +++
 drivers/net/ovpn/crypto_aead.c | 20 ++++++++++++++------
 drivers/net/ovpn/crypto_aead.h |  1 -
 drivers/net/ovpn/io.c          | 10 +++++-----
 drivers/net/ovpn/main.c        | 27 +++++++++++++++++++++++----
 drivers/net/ovpn/netlink.c     |  2 +-
 drivers/net/ovpn/ovpnpriv.h    |  4 ++++
 drivers/net/ovpn/peer.c        |  8 ++++----
 drivers/net/ovpn/tcp.c         |  9 ++++-----
 10 files changed, 69 insertions(+), 40 deletions(-)

-- 
2.55.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
