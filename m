Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01D606A329
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AlN59duJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lUgkr51b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Paef6J0X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=epSLVL4MVyvhed9QQDGCfHqtSNvwaQ+xpVZ4+xva0Do=; b=AlN59duJiIwfcD
	oJs12ZncHwdodHREig3RYnYKO3xLwR5kssI9okIXZDlvglXnoNIx3IMu+Spy/J8v30qFtS/6Rff8/
	4cITGRgHietuk9AwkCpDpfMiMSvGFqVpt+ZIEnDtcIU/Y8V2jLRRzIbK52KCXYm3VHLmrwXDByTlM
	m7g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSt5P-000000006l2-2eoa;
	Mon, 16 Nov 2026 09:33:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSt5O-000000006kt-0bJw for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:33:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8VenHmZuyH6fxLbI3rypNCymMV0n4cw1k1ZRKmCp8TA=; b=l
 Ugkr51bmDtFWzn2E+pX1DMwgQBKuuiM+FH+sq7bDbDd44DPKLio4dgG0s/dMXTw63/0CHY6XdFvyR
 dP4fz9FlmUebgetV32039Foht2I/3eX2Qt6Y+6N9sThPI8iS5m9fyvxcojM7O4+OJeLv+nbuD1dXo
 tcF9PhT7aYmDn8kg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8VenHmZuyH6fxLbI3rypNCymMV0n4cw1k1ZRKmCp8TA=; b=Paef6J0XTU5Yyn9/GfAIR78clL
 wzKOrjPUWXqKyBDsNRtKMX9rxdMD9yxBFG7D9LG1Rg5aim/jZPAt9/qPO0wTOlhZGmXyVYWRctfxx
 ClpPrEjJxx15MvSN1+HEvDoJju+w9EjPGvvZIOlc0YTJpig6d7qxCANb006AnGWHfRR0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSt5J-00000000892-1TkF for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:33:14 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AG9X265066813;
 Mon, 16 Nov 2026 10:33:02 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AG9X2GU066812;
 Mon, 16 Nov 2026 10:33:02 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 10:33:02 +0100 (CET)
Message-Id: <202611160933.6AG9X2GU066812@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261112214027.13465-1-gert@greenie.muc.de>
References: <20261112214027.13465-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSt5J-00000000892-1TkF
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: reject a config
 file passed without --config
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The suspicion that this code path got broken was there in the merging
of commit 66faaa7a996c - but since our GUI never creates command lines
without "--config", pre-release testing for 2.7.9 did not show any issues,
so it was left dangling.

Thanks for taking this up and clarifying the exceptions in the iserv - 
always do full qualified "--config $file", never just "single argument = 
config file".  I think the code could be simpler ("check that sud.options
starts with '--', done") but this patch is already an improvement.

Since this has a unit test, pushed to my GH instance for a windows UT
run (passed).

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit ad4e3b4921c520e187a27d8014d953e8e294130d (master)
commit a1d2bab37373f9c680106ad229f00545dcc37b78 (release/2.7)
Author: Razvan Cojocaru
Date:   Thu Nov 12 22:40:21 2026 +0100

     openvpnserv: reject a config file passed without --config

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Heiko Hund <heiko@ist.eigentlich.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2159
     Message-Id: <20261112214027.13465-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41236.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
