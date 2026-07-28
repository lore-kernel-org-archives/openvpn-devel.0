Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15152C54EFC
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Fhh3L9pbhCiklBWg0r1Dzla9WaiSd07ACMpz2wd+mrI=; b=cTNS1IFWhdxI7tI3/98wnc7EQ+
	yi+067u1ZXqTCTJgzQuna9cudfc2GTICL1sEqp+DTgPoSf/YTyugbVcPlVtNe0adUx5+rb3hM2mhk
	b+x7rwyXuRRXNITi+sDNfyNJDgM7GNBpbQeV1CwHfnz9lGSnZ0Eru7MN+5V1szOnwAG8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogJA-0005tJ-1T;
	Tue, 28 Jul 2026 11:49:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wogJ8-0005tA-Hy
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qGuiPAgXhpak0h6NKJEAHbmFnKiHeHnXPiTC1ioiUGU=; b=lK+Q4+RoPHUrMrDw+jkzqpg/Xg
 aIMh7TaZUZP+Ub2OgZzIvSl3Zt7eO3li7l1mjLTEe/1C4SS8KkmqSIALgY6MhBLqt3iYaiGvnK0wL
 ImSHTBCM5vOx+ejNtYmTpKjgLSdVxyf1UdoAYunyhnmuYHlkRI9mcls9lWjYxw5/6R9E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qGuiPAgXhpak0h6NKJEAHbmFnKiHeHnXPiTC1ioiUGU=; b=m
 dGFRwxiVK9WyUoGFhXw22XUSeee1vdbdk2/QKRIVi/QRQGRofF5Las9daE251EhrPoMij5IoWeR8N
 o0pG8KDnCoMQtd2fTRo83jjAap7Z+rH7OCtpJOa0fcVEN7yaU5uHixvUI4qMrYNQTpq+77bGKK40v
 vB2E5lRtBWtYZbg4=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wogJ3-0002uh-5Y for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:12 +0000
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h8Ydn1CPczMlGr;
 Tue, 28 Jul 2026 13:49:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785239341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qGuiPAgXhpak0h6NKJEAHbmFnKiHeHnXPiTC1ioiUGU=;
 b=N5TCA3S53rrOolEIZ9CkzuDSeHL5jXBsRMzHiQMbHgnjsHXED4KTNa4+H7J0jgu8+aaG99
 1cXfbpzTfHEgu6XExsnPMjRNlUGX69AlRePkvNo/fRuVh7CXNO3Zz0huOJ6vIioz4xxiCW
 2kav16FiW+r0LB0VpUrmEJ4jqkIWvvHG6iYQhPSjs6CiktfE/SyoWpD7T0+ux9zrVvAllo
 8svDK2LbHdgkNi2vE/mLm5C0DOsgCOMNEz1Qi7gq4UFXOyzPcVQm15BE0+lsXamYmHjwNl
 VFbWR2lCDCj9IBSXr4RPdFvosCqIWBzH8bTVQn9asu53obaPxwVFXmTn1OBtxA==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 28 Jul 2026 13:48:46 +0200
Message-ID: <20260728114855.1323861-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wogJ3-0002uh-5Y
Subject: [Openvpn-devel] [PATCH ovpn net v4 0/9] ovpn: assorted net fixes
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

Hi all,

This is v4 of the collected ovpn fixes for net, sent here for review
(and sashiko re-review) before submission to netdev as a pull request.

v3 got a sashiko review that flagged three new issues; this v4 addresses
all of them.

Changes since v3:
* "ovpn: zero-initialize sockaddr before learning a floated endpoint":
  build the floated endpoint with a designated initializer instead of
  zeroing the whole sockaddr_storage on every received packet, so the
  padding is still cleared without a memset on the RX fast path
* "ovpn: invalidate the UDP TX dst_cache when the flow key changes":
  - re-validate sport/mark in the post-lookup check as well: the TX
    entry check alone could let a slow resolver cache a route tagged
    with a sport/mark another CPU had already changed
  - compare bind->local against the value snapshotted before the route
    lookup instead of the FIB-populated fl.saddr, so caching is no
    longer skipped for a peer whose local address is not yet known

No functional changes to the other patches.

Thanks,
	Antonio

Antonio Quartulli (9):
  ovpn: skip rehash for peers already removed from by_id
  ovpn: rehash peer in by_transp_addr table on CMD_PEER_SET
  ovpn: fix data race reading cached local endpoint on TX path
  ovpn: ensure socket is owned by ovpn before deref sk_user_data
  ovpn: zero-initialize sockaddr before learning a floated endpoint
  ovpn: hash floated peer by transport identity only
  ovpn: disable IPv4 redirects on MP interfaces
  ovpn: ensure TCP vars are initialized first
  ovpn: invalidate the UDP TX dst_cache when the flow key changes

 drivers/net/ovpn/main.c    |  60 ++++++++----
 drivers/net/ovpn/netlink.c |  19 +++-
 drivers/net/ovpn/peer.c    | 196 ++++++++++++++++++++++++++++---------
 drivers/net/ovpn/peer.h    |  15 +++
 drivers/net/ovpn/socket.c  |   9 ++
 drivers/net/ovpn/udp.c     | 108 +++++++++++++++++---
 6 files changed, 329 insertions(+), 78 deletions(-)

-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
