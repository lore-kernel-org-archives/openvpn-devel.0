Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F029606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iknzfFq4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ABZMzUyu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CPpyD/lg;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=CFqVahjr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=ShuNJZRjYc80661OJFDOhsnH0bNZ02W2cbvPzsCsids=; b=iknzfFq4jv5mGEpMlPwNVrGIQ3
	oWiQUuoUe4H1AOvKqnBcPofmSnl5Wob8tg28Y/pXrYybH7/W8Wqq0CJjMJhzkHVMlN4WWAKIDuZN6
	NoC6KT6w8vc3TVCa9DrBDlefXNgjtWw1KwHp7w/cBHD3ovFlQgx4nF+7eXKfm4ZkxMTA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWajB-000000006Uu-40i8;
	Thu, 26 Nov 2026 14:45:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xWaj7-000000006Uk-2JcN
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:45:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I0dl1zbvAzHeljxy6OtTZrvHFzfgfvq+yA3MIle+DRo=; b=ABZMzUyurUmMOVmFZcE4QuvB08
 B/LxhhQ1JtatiBnVnPrBRur9P/Jy/nMhEyrrLmQelMipcaRXM0L4OwXj0Se77KY+KWrWM7IPd25G5
 J1WrVLI0tiTIJTAsOnL+JenPaZ/fJlsui0LsCTB+Ze80aB4a7CZvvpIMd6XYEO9OnXhM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I0dl1zbvAzHeljxy6OtTZrvHFzfgfvq+yA3MIle+DRo=; b=CPpyD/lgJGNNIJN7KGQpSc/Od5
 4WFXXNid11rh3JSp1e3/9rbBRZV3o2H4gAdRi0EKMCl6vTz2qrFT4L+1vzdEz+TH3nAZ/eAhjHH7X
 rnSJauYHsdOjB0CfJitVaOFf0ItwEbRcRW5cOkxK3LKZZEIw5oxorBJ0x4PhZZWcbKQI=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWaj5-000000001wf-2V8Z for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:45:33 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jZzqQ46HSzNlg3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 15:45:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795704322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I0dl1zbvAzHeljxy6OtTZrvHFzfgfvq+yA3MIle+DRo=;
 b=CFqVahjrNGg7Roi8A9lN9DueIKE1KWWHLLKIuDaCaQefi4JFRjYZ3jisLIdRXw9w2DLbTV
 sLjofyN4rBGug9Edh/kX31u8ZTQPVaw1QtEmDUc5yOwKv757qYA2NzPbV0OixKbFOv/XdO
 Al7GgVL8a3oGVyoUehRoBeGadUvV5V/ZQ1erqwqPyvWvniai1AXRomMaTa+xAN+BsX1kAY
 cd7V+alMssXQBPb9n/vTwwcDmiYKkm/WVGJT/xmCP03YqnnEs0hAtvITkPX140Ju3MI6oj
 3OyVR6rJ1rEBKlCuY9bfcHP1QrV+VFTgkaCxOPWHib6fHq9EY7bWy1OvikTv2Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 15:45:08 +0100
Message-ID: <cover.1795703343.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jZzqQ46HSzNlg3
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWaj5-000000001wf-2V8Z
Subject: [Openvpn-devel] [PATCH ovpn net 0/3] ovpn: fix issues reported by
 Sashiko
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

This series fixes a few issues that Sashiko reported while reviewing
earlier ovpn patches and that were still present on current ovpn-net-next
main. All of them are pre-existing problems, not regressions introduced
by the patches under review, which is why they went unaddressed so far.

Patch 1 resets the peer dst cache before publishing a new bind when the
remote or local endpoint changes. With the opposite order a concurrent
TX could pair the new bind with a route cached for the old one, and on a
cross-family float even get a dst of the wrong family.

Patch 2 drops the netdev reference from the peer RCU callback instead of
right after call_rcu, where the peer could already have been freed.

Patch 3 makes the duplicate VPN address selftests require the expected
error, so that they cannot pass on an unrelated failure.

Each patch links to the Sashiko report it addresses.

Thanks,

Ralf Lici
Mandelbit Srl

---
Ralf Lici (3):
  ovpn: reset dst cache before publishing a new bind
  ovpn: release netdev reference from the peer RCU callback
  selftests: ovpn: check the error of duplicate VPN address tests

 drivers/net/ovpn/netlink.c                 |  7 +++++-
 drivers/net/ovpn/peer.c                    | 15 ++++++++-----
 tools/testing/selftests/net/ovpn/common.sh | 21 +++++++++++++++++
 tools/testing/selftests/net/ovpn/test.sh   | 26 ++++++++++++++++------
 4 files changed, 55 insertions(+), 14 deletions(-)


base-commit: 7ccc5e05043b1bb84326b19a2b05938d8f7a2ae6
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
