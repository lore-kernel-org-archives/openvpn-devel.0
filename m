Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7212606A329
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d0IhLdAb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GVW7EtOz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IdzRtET4;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=byICDLmr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=y0jJO60RI4cS5oQpxrOLRC0EDcFhSXenx8DVYJrvkiE=; b=d0IhLdAbArKfpdgKRd19DeCKEv
	tMxj+Zf9P+rTQ5iK8FBVn2cF04ZahfUSeCJ7+sN+kk/Tya2oyFbI70w2Wc+xDeYCWebYz54GoBy5J
	32T9ii6k/VVEWk5NG3DuX4dGKfigsuTOyQAW+zeQnnBMZ4erP7FcXr8XoDrM5KEjgMy8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTJu5-000000007Dm-19TL;
	Tue, 17 Nov 2026 14:11:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xTJu4-000000007De-0Tms
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=toVNx3Jt+2HYxiSKTV/0p0r8WGVzsTLqmPqWmPOVKY8=; b=GVW7EtOzsN9yfOtTTYtmWqKj2V
 3XWfGsAQ1+Ynj1B5+7kq6I/ZvLPrN70xhSBZ6wX7i4eyk7oAYWrIzwvUQKxo5lTp1x6k5ksGam2U0
 sh/cJ8+KvB2O13ggBY324qqDcbj91iyZzfDG1MomKYiPqg2k/qo2zjjtR55+lGMTV8OI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=toVNx3Jt+2HYxiSKTV/0p0r8WGVzsTLqmPqWmPOVKY8=; b=IdzRtET4WVCnjyJHwaA0c7A8ly
 8/vXmMFpC8v6G/rcWvleUolAGoG85yePeccZGc7K/TK1QAQt8F53VSU1dBQILyNuRO2in8WEhRFmp
 72TbC6daKU1nn3Ean+bn1M08SOaHbFLzq3GgfXp9OX/b9+l+tlOFAg1YcV1yfHJvV/J4=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTJu1-000000007sp-16pg for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:11:20 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jTRV51NFZz5wVw
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 15:11:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794924669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=toVNx3Jt+2HYxiSKTV/0p0r8WGVzsTLqmPqWmPOVKY8=;
 b=byICDLmr/5Zh5J/wrqKr4c8bhoE3G7t3dw2fb8W8viP11Gx/awbqmLVf7RnIobpcAtqWTu
 JZmGvFnasS9D+jd9ST6kBE4dRW+895SVP8Ip2d8fO/v4nCrfnigS8boQ8Zl1ADJlyTHqid
 YMF53PJLl/UPvs3kWWjwPyb5zkoWmMsy7bSuLRKaItIknPn2NbfSYZbvDLIxoFh7201Xhe
 ZySrWQV+PTqCQcvhls36ITh57hz5RG1Qdwk0jBKBj/Bw6ark4tcwl1drJ1eWGmP1txfOlb
 PsjsX9An6/03rf7aggYaanfLSPiuol0evzPueHhSnbl/MC6AEdi32Y80BhLwDw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 15:10:57 +0100
Message-ID: <cover.1794922487.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jTRV51NFZz5wVw
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTJu1-000000007sp-16pg
Subject: [Openvpn-devel] [PATCH ovpn net-next 0/4] ovpn: select physical TX
 queues from the outer flow
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

ovpn keeps the inner socket as skb->sk on encrypted UDP packets, so that
write accounting and TCP Small Queues keep working. As a consequence,
netdev_pick_tx selects the lower device's TX queue as if the packet
still belonged to the inner flow: from that socket's cached queue, from
XPS according to the transmitting CPU, or from a recorded RX queue. When
several inner flows are sent from different CPUs, one outer OpenVPN
flow, which carries a single packet-ID sequence, is spread over several
hardware queues, and the resulting reordering can exceed the receiver's
replay window.

Patch 1 adds an skb bit which makes netdev_pick_tx select the queue from
the packet hash instead, and patch 2 sets it in ovpn after clearing the
inner hash, so that the lower device hashes the outer tuple. Patches 3
and 4 let ovpn set that hash directly from the flowi it routes with
instead of dissecting every outer packet, which requires restoring
__get_hash_from_flowi4.

Patches 1 and 3 change net core code (include/linux/skbuff.h,
net/core/dev.c, include/net/flow.h and net/core/flow_dissector.c) and
need review from the core networking maintainers when the series is
forwarded to netdev. The series also applies cleanly to the current
net-next.

With one peer between two directly connected mlx5 ports and four or
eight inner TCP flows sent from different CPUs, the outer flow used five
to nine TX queues and the receiver rejected 2000 to 4800 packets per
20-second run because of the replay window. With the series, all runs
used a single TX queue and no packet was rejected.

Thanks,

Ralf Lici
Mandelbit Srl

---

Ralf Lici (4):
  net: allow selecting TX queues from the packet hash
  ovpn: select physical TX queues from the outer flow
  net: restore __get_hash_from_flowi4
  ovpn: hash the outer flow from its flowi

 drivers/net/ovpn/io.c     |  1 +
 drivers/net/ovpn/udp.c    |  9 +++++++++
 include/linux/skbuff.h    | 31 +++++++++++++++++++++++++++++++
 include/net/flow.h        |  1 +
 net/core/dev.c            |  8 ++++++--
 net/core/flow_dissector.c | 16 ++++++++++++++++
 6 files changed, 64 insertions(+), 2 deletions(-)


base-commit: 7ccc5e05043b1bb84326b19a2b05938d8f7a2ae6
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
