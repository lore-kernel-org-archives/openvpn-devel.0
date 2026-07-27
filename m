Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D292C53219
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=28jZLIl3JKZCxzNL73I3QJV4YuPdNr6Ptc63IzhzYcw=; b=DDnL+nvQFf5pkcmE6n5Na2iaih
	2Qf7VhDRkTaOivFq1OwJf1BnAqmfHuzPjTAqagnszLIc39n4Nglmp8Mjmv2QkJ513ZvtBZkU3TYqf
	cUF0EI9dw20/Jhm4d3n1cp5NMp08unaotYpuavhwqRGSU5NSJTbk8ynpj4BDzyVBgv1I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woRbe-00062l-40;
	Mon, 27 Jul 2026 20:07:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1woRbc-00062S-Ca
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 20:07:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nsHIO0arQKEWQI+lR5bWjye+hHkud+o0HonrHazduCs=; b=m1XAyvwz9b116TFQnge+j7NcGM
 7ilIzw6kR5E+V9+PG1FiuUmQDhLoa7XYDdWS2dQFVw5FC1nYhilJkWA7fQgUUk8gjXEET57KmCxjD
 IHv2ev5ohZsrvslPNUgAQpBXnI0SkJ53dSLrWTD+Q/8EQqvMX0gsR7y+RvWAzeS8FWYQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nsHIO0arQKEWQI+lR5bWjye+hHkud+o0HonrHazduCs=; b=A
 s/h66MaEX/xjYkXfBcFtq5cwHcAGF2xVAw2N+fvhMy5BY6r4Jf4ZyUvlsGUfj8GFA2ZNs7lOUlVyK
 Y+VMVPQqRzJqikzLbBXwoTKDvtoRiHO3XouDQt20S02rDEMZr0yLOqWFmLJYTAFlm4MoL5+aSVvwJ
 JmDEKAmQ1bE3q/4c=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woRbc-0001P6-Ho for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 20:07:21 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h88l44fRnzKw2c;
 Mon, 27 Jul 2026 22:07:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785182832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nsHIO0arQKEWQI+lR5bWjye+hHkud+o0HonrHazduCs=;
 b=WwpNOA3s7ZDKniZLnIdkCIkQF/0s0yt54E4Ojg9CoMoYs5LWJ+61X4EZvQC4f53jh2uD/h
 KaRB3H1qwmT6FaY2Z6pJ1AsQ70E+knHMxcqLAcGIBwBHKBUwV5o4nB2tg/jKV5SB2ckHE6
 KSy4iGKD4wzd8nwihOqa5D59xKpyGYqvS7+LDGXnuIjd5CJDgeBeAQZ3RBV3EJTzlOSaT6
 UkaaUV1mfFkAJPWQGcOXxjBcf53MVggCOX2ZC4vQNy6KZuXZYhea2rmz1sv/wcAGKP8kiD
 Hczp/CPOj4WO8nnur00CkMDxwIp++CCGdev4TGaUfT1x8NE91Y047/kjO3we8g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 27 Jul 2026 22:06:56 +0200
Message-ID: <20260727200705.869169-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h88l44fRnzKw2c
X-Headers-End: 1woRbc-0001P6-Ho
Subject: [Openvpn-devel] [PATCH ovpn net v3 0/9] ovpn: assorted net fixes
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

This is v3 of the collected ovpn fixes for net, sent here for review
(and sashiko pre-review) before submission to netdev as a pull
request.

Changes since v2:
* dropped "ovpn: tcp - fix peer reference leak on deferred deletion"
  (v2 5/9): the deferred-deletion reference is already taken before
  scheduling the work in the current tree, so the patch is no longer
  needed (the v2 version also introduced a TOCTOU race)
* added "ovpn: invalidate the UDP TX dst_cache when the flow key
  changes"
* "ovpn: rehash peer in by_transp_addr table on CMD_PEER_SET":
  restored the peer->ovpn->lock and peer->lock acquisitions that the
  __ovpn_peer_hash_transp_addr() refactor had accidentally dropped
  from ovpn_peer_endpoints_update(); without them an MP float hit a
  lockdep splat and a double unlock (panic)
* "ovpn: disable IPv4 redirects on MP interfaces": moved the
  SEND_REDIRECTS handling to ndo_open() so it is re-applied on every
  bring-up and survives the IPv4 in_device being recreated (e.g. after
  moving the interface to another netns)

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

 drivers/net/ovpn/main.c    |  60 +++++++++----
 drivers/net/ovpn/netlink.c |  19 ++++-
 drivers/net/ovpn/peer.c    | 167 +++++++++++++++++++++++++++++--------
 drivers/net/ovpn/peer.h    |  15 ++++
 drivers/net/ovpn/socket.c  |   9 ++
 drivers/net/ovpn/udp.c     |  87 +++++++++++++++----
 6 files changed, 286 insertions(+), 71 deletions(-)

-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
