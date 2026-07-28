Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20857C54F4D
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lVbIoqkmrCTYYkgrlwmPDH74W3S60Pnq815blCsyP58=; b=JvXkg9sMPNggf7gZdXvWdy4AmF
	xrzNnot5IJSxL7FXcw/dsTukulIs9yHvHYsAG+WV3W6ZQYJ2PUapwhbIPgfTYTdKEz5xnD4ae/8og
	UoHTC3KRICL+mIPJ0wknQnAQyMhIGIfLVaad/HnWjSvhXDFzgRRMedZMoUu8dt+znfwI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wok4o-0005rM-NB;
	Tue, 28 Jul 2026 15:50:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wok4k-0005ql-Op
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:50:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pM5g0jU02z5/bTvDLfoNW8nSxhGdiiVY9ZoCRT8rvJk=; b=c9KyMXFCNwkbrBMh/UTkJoy1kQ
 W2HaTkR56/kGlLm1FK4B3ddoeCAnOaYSuQorVp+oa9rVgEFq8dH+DT7sbcHZSf+j9g+4vx+VIRM/d
 gDpZ0+54DbYnFaJ7ByFM1zG/tIEyXfAXFsFFP0rcytfXMQ42J2D595oe1n9Xu+r/9t+I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pM5g0jU02z5/bTvDLfoNW8nSxhGdiiVY9ZoCRT8rvJk=; b=L
 hkB5sjcATclD/Ll1T6V/Fg60xbq3eGDAU4zJTn5vdnf7O92Iqm0j9SgzktHp3oAwxZZ7Dm9/THuW3
 bE6B9PIrc+cjLQvEdRdV+6AWeHdY9FUSEWpcdO9y0cZqPYsMVxI093kqGYegsb0vxhQsW+luNXorL
 A8iKt69+zi8h4qbU=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wok4j-00027K-TH for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:50:39 +0000
Received: from smtp202.mailbox.org (unknown [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4h8g0P4tzfz5wrL;
 Tue, 28 Jul 2026 17:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785253829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pM5g0jU02z5/bTvDLfoNW8nSxhGdiiVY9ZoCRT8rvJk=;
 b=Xm3kgGvZI4qQr3Js88V+k2z/0LpxQfA1hb8q7cGvallymZWNU+wYfg/mFiNUyW8YnX9T9+
 UEptJ/jgQ8LKg9q9kJq1Omi9qYU6UvWr9COqlws9Syx3V/d5TpGxYSiRZpcWKXYg+pDfdx
 bPDwQ7Zrko9ziBJBGp6b5SX9U8MkoBG+KxY8nBI08NCEzNnpvA3aRD/0m3IU0GuQJDhZCI
 Ls/m6TbzPNDS2hUKekTZXFx749WzCDUGjPW6hG1K5tZtGdxwCgfeiRP/0l71W4lfgfbBXe
 h2JusVxMe9a/EKG85q/Pt3tHdVqAaNiXW8GJRuycH0g1R2vA5F5XIZ5J9fKh2g==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 28 Jul 2026 17:50:10 +0200
Message-ID: <cover.1785253480.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wok4j-00027K-TH
Subject: [Openvpn-devel] [PATCH ovpn net 0/5] ovpn: fix UDP route cache and
 endpoint handling
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

This series fixes several related issues in ovpn's UDP endpoint and
route-cache handling.

It preserves IPv6 scope IDs supplied through netlink, handles
unspecified source addresses correctly, invalidates cached routes when
mutable socket route inputs change, avoids in-place updates of
RCU-published peer binds, and prevents stale IPv6 routes from being
cached across FIB updates.

Support for honoring UDP sockets bound to a device or local address will
follow separately for net-next, after these route-cache fixes are
available there.

Cheers,

Ralf Lici
Mandelbit Srl

---
Ralf Lici (5):
  ovpn: preserve IPv6 scope id for netlink peer endpoints
  ovpn: skip UDP source validation for unspecified addresses
  ovpn: track UDP socket route key for peer dst cache
  ovpn: avoid in-place updates of peer bind local address
  ovpn: avoid caching stale IPv6 dst after FIB changes

 drivers/net/ovpn/netlink.c |   6 ++
 drivers/net/ovpn/peer.c    |  37 ++++---
 drivers/net/ovpn/peer.h    |  19 +++-
 drivers/net/ovpn/udp.c     | 212 ++++++++++++++++++++++++++++++-------
 include/net/dst_cache.h    |  13 +++
 net/core/dst_cache.c       |  16 ++-
 6 files changed, 248 insertions(+), 55 deletions(-)

-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
