Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB43C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LLH9BeGF60eSdXF0eQCG3yZhaenTI5+Y46ggOPPMv2E=; b=lHmGoWkV4GdU09CBcrd/XF5tTo
	S5SmXWwmzonK0XJ+3s1WOjVA15/yhttVKHCvlnvlVLaXJPC6FxJPwE5IH5UmRXXO4CBMifyD59RCE
	y24baNBccK7IXdR9PdpSTpHexABId5pJ9B7cyjkSoCJCDeA0KGHmcvQNBjBlTT9PafuI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp1QY-00083O-9c;
	Wed, 29 Jul 2026 10:22:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp1QJ-000832-L4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=es3O/66CwWCWLwP2V1o2o2CtE8ZYG6VJrMc1FiZtBuw=; b=LoSpJlX3N/W4BrmP6McwIdzNCt
 E4gZKsJrlHoi6/vfrWxFdMSr9XrJduOHYowjFkeAKQPIBqaGNcjDA4/c+9PzDFEUR6tZjLRjI0cmK
 nc+xyYBkP1Bjo13N1iN8fsxccnyHJNaXXgZe/3ejVo6NSdYsR6dTpEEIZco8gCa6ugHA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=es3O/66CwWCWLwP2V1o2o2CtE8ZYG6VJrMc1FiZtBuw=; b=D
 BXtrRiu2Q1c0ZNg/XmZgesq76uMUUy2I10t4aLcp96utLP3v6Lwpu9z5Ubgg9aAyfS7TBa8TFtYES
 08Sb2hxYgiKAXyQ5bGfvBESvnREwFJOdaZzieCw3rXSblSvOhwKKyH9OVox04h18HCYwvL5Pqj1O5
 DRo8uCovPBliU7d8=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp1QM-0002fB-Er for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:04 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4h97fq0nvfz5wlw;
 Wed, 29 Jul 2026 12:21:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785320515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=es3O/66CwWCWLwP2V1o2o2CtE8ZYG6VJrMc1FiZtBuw=;
 b=e0pjHPxDKUBAsFZShO31eA2FWA2ji77qgVAzOJe8To8v4geUuchHrGj/7paT/CyYsBbA8k
 URigSJda4ahkZVDH/yLx00qnwmQ1/PngHzxPwOwNR26XRETpW0mQuytuaH8lMSoYu/m5oC
 3W333QDETWD8JZ2v92h61/8pUM8d3YeuhZdffMFKMfaIb4CLfPUAqy5Zu4Gk0lk2zwzYxT
 7EozOz0L+WVwHnSGCNIfE5AplGMiChawfgpxlT5yUVe+LbM97UxRRMJafWGfGkJtYc62aL
 6mMxU7vbmAGhKlBJftu5Worvqk4sxfLFg9ByTGsdwkG75OLjZeey2WB3j/al3A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 12:21:40 +0200
Message-ID: <cover.1785318038.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h97fq0nvfz5wlw
X-Headers-End: 1wp1QM-0002fB-Er
Subject: [Openvpn-devel] [PATCH ovpn net v6 0/6] ovpn: fix key and workqueue
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

This is a respin of the series that collects various ovpn fixes around
key-slot handling, netlink key notifications, TCP initialization
ordering, and teardown of deferred work.

This version has no more pending dependencies and incorporates the
changes discussed with Sabrina. In particular, patch 6/6 now uses
queue_rcu_work for key-slot release, instead of adding a key-slot
reference in ovpn_crypto_config_get.

The first three patches fix independent correctness issues: a NULL slot
dereference in the key-kill path, the key-id size used in key-swap
notifications, and TCP template initialization before the generic
netlink family is registered.

The last three patches fix lifetime problems where callback/workqueue
cleanup could continue after the reference that pins netdev/module
teardown had already been dropped. The series first makes crypto
callbacks finish their own cleanup before releasing the peer, then moves
ovpn work items to a module-owned workqueue that is flushed during
module exit, and finally defers key-slot AEAD transform freeing through
rcu_work so crypto_free_aead does not run from an RCU callback.

Thanks,

Ralf Lici
Mandelbit Srl

---
Changes since v5 https://lore.kernel.org/openvpn-devel/cover.1783336121.git.ralf@mandelbit.com/
- Rebase on top of OpenVPN/ovpn-net-next/main to include the missing
  dependencies from v5.
- Rework the key-kill NULL-slot fix using the slot-based shape
  (Sabrina).
- Add Sabrina's Reviewed-by tag to the key-id notification fix.
- Reword the TCP initialization fix and drop the extra comment
  (Sabrina).
- Use queue_rcu_work for key-slot release and update the module-exit
  ordering to flush ovpn_wq before rcu_barrier and destroy_workqueue
  (Sabrina).

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

 drivers/net/ovpn/crypto.c      | 26 +++++++++++---------------
 drivers/net/ovpn/crypto.h      |  4 +++-
 drivers/net/ovpn/crypto_aead.c | 19 ++++++++++++++-----
 drivers/net/ovpn/crypto_aead.h |  1 -
 drivers/net/ovpn/io.c          | 10 +++++-----
 drivers/net/ovpn/main.c        | 26 ++++++++++++++++++++++----
 drivers/net/ovpn/netlink.c     |  2 +-
 drivers/net/ovpn/ovpnpriv.h    |  4 ++++
 drivers/net/ovpn/peer.c        |  8 ++++----
 drivers/net/ovpn/tcp.c         |  9 ++++-----
 10 files changed, 68 insertions(+), 41 deletions(-)

-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
