Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6DCC61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZdbTjMHJO2IGwpsWfKYeV43xpmDP0KtkaTwivRCOlc8=; b=cuHjLUnyW6kRekTwavqNHVOw5r
	IeISMn5IVAF/34HLU+MHZKsRU64JBpGtOg9vlkRSsu794C15LzM9gzrKJYNRLYqxuJKyV87pIsmNu
	MrKXbM6bDAk71C9MhWt3VDcEyn0XK7quG7eAPMzte34khW9wJfvze3u3JySQLPEikhCA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzxuv-0000qR-8Y;
	Fri, 28 Aug 2026 14:50:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzxur-0000pw-Ru
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A16aCKWV5NvBdTNR2ZaJArt24deyRlaROb4XtlrbbAk=; b=UVjjWo/87OwwDVtdli3DkeWgWn
 p9O13kRCkcbUGMS5mrX+EGQlXIah4UcMrGujQ6ZedG0PuLZ5ZP65BICDqsHofqZ8oca+4qytVlW54
 bPdTNzkoqcf3c0ZUbd9gb7KJWZYL04wly4sH3JhMLSmfPffKulmSgfgX9F1H0ZtNienc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A16aCKWV5NvBdTNR2ZaJArt24deyRlaROb4XtlrbbAk=; b=k
 T/uw8YwiR1niRYvJP36eEXWg9VI7i9AXKG8NjORJMZPsVUZ9O8TkX2aqxdO+tXSQx5ORkHR96euR+
 UCZpSB13RDAtgGH5RTCJbkBvbMXVGGLxK0bi7GkquV1N9FHs5xnyBZkfs1pZ3n/nSncPNyp+NlvIb
 8LnKmbVpJlfplJSU=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzxup-00085w-Ig for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:50 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4hWhC315NczFqqM
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 16:50:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787928639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=A16aCKWV5NvBdTNR2ZaJArt24deyRlaROb4XtlrbbAk=;
 b=mKzQ5OaBglWla44kWEuAEwDYCS03iNVVEJ2DvVMp6IiDJta1y3cNiUS8OZNIGvkbXcrRWb
 6zB+Mtpaxa7YRF+Io5wUE1SIac+XjmU92OOZ4JLx8/L0ISKtUw34L9Zv1xoCm8rMEkVGMM
 TxbUu08lWnPT+ET+OqbWpPdepUZll4n3ErA/XXDkQsKKU2+pjERzqy2B5PdJMPlFuQHDRn
 9UMVmlFzZm5TaB/jIk0NDFJ+vh8Wtg6UPoMVQA1K3Nkg68ro1YLa1e3t63WGUJSvoZDTCm
 xHWVN2547/iZcfAreVpA2eh4tASvoonGKLgNqqLm0bXckZJGxRbyBfsEug4CmQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 16:50:21 +0200
Message-ID: <cover.1787925761.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hWhC315NczFqqM
X-Headers-End: 1wzxup-00085w-Ig
Subject: [Openvpn-devel] [PATCH ovpn net v3 0/6] ovpn: fix UDP route cache
 and endpoint handling
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

This is v3 of a net series that fixes several related issues in ovpn's
UDP endpoint and route-cache handling. This version was rebased on top
of net and includes suggestions from Sabrina. The former patch 5/5 was
dropped from this series and will be sent as RFC on netdev, where it is
more appropriate since it involves changes broader than ovpn alone.

This series preserves IPv6 scope IDs supplied through netlink, handles
unspecified source addresses correctly, invalidates cached routes when
mutable socket route inputs change and avoids in-place updates of
RCU-published peer binds.

Support for honoring UDP sockets bound to a device or local address will
follow separately for net-next, after these route-cache fixes are
available there.

Cheers,

Ralf Lici
Mandelbit Srl

---
Changes since v2 https://lore.kernel.org/openvpn-devel/cover.1785308184.git.ralf@mandelbit.com/
- Split former patch 4/5 into three separate patches. (Sabrina)
- Dropped former patch 5/5 from this series as it introduces IPv6
  routing changes and needs to be discussed as an RFC on netdev.
  (Sabrina)

Changes since v1 https://lore.kernel.org/openvpn-devel/cover.1785253480.git.ralf@mandelbit.com
- Patch 5/5: add memory barriers around IPv6 FIB generation reads to
  avoid reordering on weakly ordered architectures (Sashiko).

Ralf Lici (6):
  ovpn: preserve IPv6 scope id for netlink peer endpoints
  ovpn: skip UDP source validation for unspecified addresses
  ovpn: track UDP socket route key for peer dst cache
  ovpn: validate peer state before caching UDP dst
  ovpn: replace bind when learning local endpoint
  ovpn: replace bind when clearing stale local source

 drivers/net/ovpn/netlink.c |   6 ++
 drivers/net/ovpn/peer.c    |  44 ++++++-----
 drivers/net/ovpn/peer.h    |  19 ++++-
 drivers/net/ovpn/udp.c     | 193 +++++++++++++++++++++++++++++++++++++--------
 4 files changed, 206 insertions(+), 56 deletions(-)


base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
