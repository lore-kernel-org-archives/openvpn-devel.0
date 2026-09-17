Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C82FC982D9
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RjbOgVN2jD0hO2qppD1xYaq857xqUVarzlljS0AMLjc=; b=Xq/zF1vLUvfmET+lExX01qyX75
	yGCSwoJYa5wWHP8KPmfSL5bI5kqWkbNe+HbCJrcZrOEMV0g3PkNx39BT0OmUEyra3lhx2zQI0ym9J
	sAucQqKnRj+j0zRw8HXncEUlFHDn1fTYTJshAwxo28UpkWiboiL33qYsRGUA5L8x62VY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7E4A-0003gg-IF;
	Thu, 17 Sep 2026 15:30:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x7E47-0003gX-Qt
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 15:30:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ft9zvP0DKGz2b8hx+GzjzacYzy76KbyxWGbo9aEIQRM=; b=BwQh/RwqN4NoiSG8pMEJQD6y+l
 RlRHdoeYZv6oVf0VlS2VPoSV4MGejmfOZfRbiX9uuzKG0xXmbS59mRz7Kp3lh/DftH79z5XvPhjwC
 bbkJpAV9Ut+UnQe2f5RlBliWjM+MnmyTzKlDeefdWB7WqH6r0bHDi6gymgEgUPDqk+Ho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ft9zvP0DKGz2b8hx+GzjzacYzy76KbyxWGbo9aEIQRM=; b=U
 46v5sLJS3F0dIe3pRkaFuUoO4PA3+mDv2Yp0WF3w2S5t08xEeMgeqosGUjwxfhSJOnHOqnnWqzAJ1
 ivMfnpGJfkqWw5eFWe3hTEDdZTtjTj00nGKWPlfdzTtbQzHxmNReGXdVXKEb+6ygoOKOe7tIIUM2w
 JhivqFy+wDmB9540=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7E41-0005Yj-0W for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 15:30:21 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4hm07P0VY9z9sYv
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 17:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789659009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ft9zvP0DKGz2b8hx+GzjzacYzy76KbyxWGbo9aEIQRM=;
 b=wXQzJIeNwXV6NX7JZMgHoQKPHYwXyAm/GIQFhTmnTAu3egUHMdbb7yBKrMzvLa7RV0YPFi
 zYA5re5CR81ig2di79vXgCW0opTOxbMuhdLlDSeP7SozpIaOrNiXyvkk2BgLRFcVDhy1HX
 FXNo1WUJPIzW+u//s47jKI708zNyazzMPieuLdZg6H+cYoKtLj9+a9OSYdfV/aln6o67Hj
 FjKNuVgWvNEuHBT1G+CYg22qKhoWxMMetGROA8vDK+/58qGNq2+5BG+grdwQ2cibIotURy
 8mBMsuwB55LfGVf1RGjZE5r9/S3H10/osiTa6+gcSfWDI5IrFu3Mj7bo5z+Efw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 17 Sep 2026 17:29:54 +0200
Message-ID: <cover.1789658051.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hm07P0VY9z9sYv
X-Headers-End: 1x7E41-0005Yj-0W
Subject: [Openvpn-devel] [PATCH ovpn net-next 0/2] ovpn: reduce
 reference-count contention
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

Currently ovpn holds peer and key-slot references while packets are
being processed and until asynchronous crypto completes. With traffic
for one peer spread across CPUs, the shared kref cachelines therefore
become contended even though both objects are normally long-lived.

This series converts both references to percpu_ref while preserving their
existing RCU-delayed destruction. The individual patch messages describe
the memory cost and cache-to-cache measurements.

The test used one peer, one AES-128-GCM key and 32 TCP streams on a
32-logical-CPU Ryzen 9 9950X with a ConnectX-5 hairpin. The encrypted RX
flow used one source port and one receive queue, so only TX exercised CPU
fan-out. perf c2c showed that each shared reference cacheline disappeared
after its respective conversion.

Thanks,

Ralf Lici
Mandelbit Srl

---
Ralf Lici (2):
  ovpn: use percpu references for peers
  ovpn: use percpu references for key slots

 drivers/net/ovpn/crypto.c      | 14 +++++++-------
 drivers/net/ovpn/crypto.h      | 15 +++++++++++----
 drivers/net/ovpn/crypto_aead.c |  7 ++++++-
 drivers/net/ovpn/netlink.c     |  6 +++---
 drivers/net/ovpn/peer.c        | 32 ++++++++++++++++++++------------
 drivers/net/ovpn/peer.h        | 34 ++++++++++++++++++++++++++++++----
 6 files changed, 77 insertions(+), 31 deletions(-)


base-commit: b8e9e7d82e7eefd5d2d528469d94ec20e96b38c3
-- 
2.55.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
