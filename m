Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DA3C982C5
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tdCVvfzn+bn6rCCO6Bn1GZG/VmePncj1iw+9f8cZnI4=; b=dhF2iN9ASDUTra4J+0JkWaeQ7w
	DnxR+5Ij02rZece+XDEDL45WeJ3v8b2gtNf0DkiU+rg59RbK2GPlk6YcZB2bmUuooXcE7mhEMvRyN
	pWo72ybU5tlCqlg+vWApB17iubJMMKw+tpREY1S6jT85NqkYcUWeoE6V84gRSOiADDdE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6jW6-0008EI-3f;
	Wed, 16 Sep 2026 06:53:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x6jW0-0008Dq-Ib
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 06:53:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g6q8AJH+BfyXnBjI+hBtiax7CnCKx6hy8T7atAyQOrg=; b=MaSEuRJniEWQfuRaSUmyKTXhso
 sD288xZiF5rjPVEPUxoa3K0Alp/HyHSlEfzdIJj4iqUjpZwFunVxbG2QdjIvMqER/t9cDA+W9PlYm
 ufqiRzNBCRXNo7YZ10LqcPWYBMGyKkapZ27oUUFKwwF/gpIw3AHGc5wH6aial5Mi346w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=g6q8AJH+BfyXnBjI+hBtiax7CnCKx6hy8T7atAyQOrg=; b=Q
 rz7R4eCS/aWQyKrYT1KSK/SGDQ6fllvSrvJdk6UHgoD3BqhzNwFzpxuMzwLIMAfzxHD68H+NfYo2Z
 l58CuO+iR2pARwCn7316MiZ3gaZRCPeSogSf+yjZJahclsAtRjPFk2p5uDYZeuppVdF42zVJFFzJM
 2nATWf0WYTfjIcuc=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6jVy-0001sa-6z for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 06:53:08 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4hl8j55BKTzNlZM
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:52:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789541577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g6q8AJH+BfyXnBjI+hBtiax7CnCKx6hy8T7atAyQOrg=;
 b=uKL38V4JztFnU/Ty+Ladx39GXacCfazkNhEh7gCQlsgTnLgjmzUnBbJ5WX61X+Cq1FfnZo
 KFYEfdfi3BVRDZbXafHBrCHa0teNx2uYH5hnOPfUMlalfXUsrazxNpkTTrRvVmrBfhfJsg
 KK2lso75d5ErrH+XwIC/e/QxDWuXsrN44eTutv44uR6BLR+S25dez+aWbKwgkNv4uTl2Gl
 oxwvaP7WCCQXyP+jFIycOUdxIt5WrusvzdMDqe/XNp06iKXi0Oltb21eRA5N/Ib6/0dZpT
 VTnMf9Mjliw54rlKgax0RKrnOp28BzkZmLXMJd4QGfOksLYKPIjS1JxTZ84GSA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 16 Sep 2026 08:52:41 +0200
Message-ID: <cover.1789540779.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1x6jVy-0001sa-6z
Subject: [Openvpn-devel] [RFC ovpn net-next v2 0/9] ovpn: preserve GSO and
 GRO batching
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
Changes since v1 https://lore.kernel.org/openvpn-devel/cover.1789485693.git.ralf@mandelbit.com/
- Fix a couple of wrong assumptions in 5/9 ("ovpn: coalesce UDP data
  records with GRO"). (Sashiko)

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
 drivers/net/ovpn/io.c                         | 281 +++++++++++++--
 drivers/net/ovpn/io.h                         |  17 +-
 drivers/net/ovpn/main.c                       |  20 +-
 drivers/net/ovpn/ovpnpriv.h                   |   2 +
 drivers/net/ovpn/proto.h                      |   4 +
 drivers/net/ovpn/skb.h                        |  27 +-
 drivers/net/ovpn/stats.h                      |  16 +-
 drivers/net/ovpn/tcp.c                        |   4 +-
 drivers/net/ovpn/udp.c                        | 321 ++++++++++++++++--
 include/net/gro.h                             |  19 +-
 include/uapi/linux/if_link.h                  |   6 +
 net/core/gro.c                                |   1 +
 net/ipv4/udp_offload.c                        |   3 +-
 tools/testing/selftests/net/ovpn/Makefile     |   1 +
 tools/testing/selftests/net/ovpn/common.sh    |   4 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   |  38 ++-
 .../selftests/net/ovpn/test-gro-direct.sh     |  10 +
 tools/testing/selftests/net/ovpn/test.sh      |  65 ++++
 21 files changed, 906 insertions(+), 131 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/test-gro-direct.sh


base-commit: b8e9e7d82e7eefd5d2d528469d94ec20e96b38c3
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
