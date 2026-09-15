Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634FDC982C7
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M3PB1cpR5yNXvv7aiyMdxy5KG/Axpf2I/f1JibhhqgA=; b=QXDsfIR+HkOWkD6+o/TZXVJg+5
	5ErGO4GG791gubcp1k+KipDcDe5H+V974QKFvaulzSTlEvoQMOz8TDjXMUw360EdCWa7DoOdCqFWA
	g3q2xRvAKGvr7faQdHh4eQePMxXd6AdWVwN5oFNa8F3yakCGAFd+ARAQ+Bi/6BmexMgE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6V14-0007nx-Lu;
	Tue, 15 Sep 2026 15:24:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6V11-0007nf-DX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o9W4pDvJ9io69rJOOxuI0GNmg1jeYxH8IuHtkDjaxDs=; b=b9EouZ7q2MpffNlJRWDKhxh4Ea
 kh6NcE6BDVYvmaJnYCQcpWz1mTHstwBFjH55OIXbiBD/2s4xLgQZ4I8WoG/C4JxKIJ/WgvTdxW9gf
 zCfMeI1jdPRlMhbhBQiVHtUXwOoMfEU4p1/jSe91V+H/jDUykDK6FvJF3/XXftTvLKpc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o9W4pDvJ9io69rJOOxuI0GNmg1jeYxH8IuHtkDjaxDs=; b=V
 0X694ipGDun7Rw6Uo9rYJtJlZXYQf1y3dhdvlro5LkPovZB49WpVehKPH0ht/X/U5QIDFhzittHFv
 zmeZdESFfP3IH4CYqljvmgvfGUj6bl8FSz5mXfTsU25uzqD/flSlF4znFNEysMoKYM4iIp7AAm3bO
 81aKVhQ/Ct1OUO0c=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6V0y-0003bL-JG for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 15:24:12 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hkm5F0gGvzLmCv
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 17:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789485841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=o9W4pDvJ9io69rJOOxuI0GNmg1jeYxH8IuHtkDjaxDs=;
 b=A0NfsbNTggWQTfSoNumgZVfFVNoWwga6749xmae5mxKkwSV0s+svnL+tYYVfPm/Owsc/tY
 Pwjbosird25QHQgj84OnDYYPjkzUm1RzxQSnUXZ01YCmqQvQ84dgMeP3MyhJOh1Kstil+y
 40Ckqau0NG929qm72+lN2XUZ4HkFzzj0Mp+6N9kl1zX2YD+MmN3vjgaH0MS8dx0DK/UYt+
 x0WsPQGR6DOp0jfm2r1lFfxvcZOdbgI/6vIumtEazm4nr6g0H1PV+xDyl1qqhC2StUeQ3U
 Fpy4eQwK5giqz+63p1vAb2nmum6/Dp5Yyxv+92cmZEzJHrMdkYxrDs5eb6F/eg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 15 Sep 2026 17:23:48 +0200
Message-ID: <cover.1789485693.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hkm5F0gGvzLmCv
X-Headers-End: 1x6V0y-0003bL-JG
Subject: [Openvpn-devel] [RFC ovpn net-next 0/9] ovpn: preserve GSO and GRO
 batching
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

This series adds support for preserving GSO and GRO batching across
ovpn, including forwarded TCP traffic. The transmit patches let GSO skbs
reach ovpn, complete each inner packet's checksum before encryption,
and, when the layout permits, put the encrypted records into a UDP GSO
skb. Ordinary packets and frag-list GSO children retain the existing
in-place path.

On receive, ovpn uses UDP GRO to collect compatible encrypted records in
a frag-list and then decrypts them individually. The series also
includes an AEAD helper refactor and small transmit and receive prefetch
changes. The patch messages contain the measurements.

The final patch adds an opt-in direct GRO mode for discussion. Unlike
the default full-stack mode, it consumes DATA_V2 records in the GRO
callback and bypasses parts of the outer receive stack, including TC,
netfilter, socket XFRM policy and normal UDP accounting. Its advantage
over the prefetched full-stack path is small in my latest 100-Gbit/s
tests.

Direct GRO also depends on a generic GRO ownership change in the
preceding patch. That change, the skb_gro_receive_list export and UDP
tunnel GRO callback accounting touch broader networking code. These
prerequisites would need discussion on netdev before any merge (this RFC
is first for feedback on the ovpn design).

Thanks,

Ralf Lici
Mandelbit Srl

---
Ralf Lici (9):
  ovpn: advertise checksum offload for GSO packets
  ovpn: accept frag-list GSO input
  ovpn: refactor AEAD encryption helpers
  ovpn: convert GSO input into UDP GSO output
  ovpn: coalesce UDP data records with GRO
  ovpn: prefetch encrypted records before GRO batch decryption
  ovpn: prefetch GSO segments before in-place encryption
  net: gro: honor skbs consumed by protocol callbacks
  ovpn: add opt-in direct GRO receive mode

 Documentation/netlink/specs/rt-link.yaml      |  12 +
 drivers/net/ovpn/crypto_aead.c                | 182 +++++++---
 drivers/net/ovpn/crypto_aead.h                |   4 +
 drivers/net/ovpn/io.c                         | 281 ++++++++++++++--
 drivers/net/ovpn/io.h                         |  17 +-
 drivers/net/ovpn/main.c                       |  20 +-
 drivers/net/ovpn/ovpnpriv.h                   |   2 +
 drivers/net/ovpn/proto.h                      |   4 +
 drivers/net/ovpn/skb.h                        |  27 +-
 drivers/net/ovpn/stats.h                      |  16 +-
 drivers/net/ovpn/tcp.c                        |   4 +-
 drivers/net/ovpn/udp.c                        | 314 ++++++++++++++++--
 include/net/gro.h                             |  19 +-
 include/uapi/linux/if_link.h                  |   6 +
 net/core/gro.c                                |   1 +
 net/ipv4/udp_offload.c                        |   3 +-
 tools/testing/selftests/net/ovpn/Makefile     |   1 +
 tools/testing/selftests/net/ovpn/common.sh    |   4 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   |  38 ++-
 .../selftests/net/ovpn/test-gro-direct.sh     |  10 +
 tools/testing/selftests/net/ovpn/test.sh      |  65 ++++
 21 files changed, 899 insertions(+), 131 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-gro-direct.sh


base-commit: b8e9e7d82e7eefd5d2d528469d94ec20e96b38c3
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
