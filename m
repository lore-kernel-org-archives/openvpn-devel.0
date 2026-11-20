Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06930606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GisxpO+l;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eFQhtrFf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=C1AnoRjV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZxEdSRWNnb87jprEy2iN6JJgwCINSW/e2mWeqZUVIF0=; b=GisxpO+ly8BVsR
	x8GYyHWsQc/81oYnOgJXSpOH/YOJC0tz4a0CeXCYY5ZJRp8KIghVl9h7PbhNqi79/vncwvW2wEGH4
	weygy/34n8HXpyAV6qCpuPz2B6l+7nUAEHgLwo7tJE/PsByzW/A1EO5VqHyXJCngsM7p1p84ZTyz7
	S88=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMBh-0000000007n-1jZ8;
	Fri, 20 Nov 2026 10:49:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xUMBf-0000000007T-3QXB for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:49:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5Wqmx/SNglqG2XIwQ/goL3K6XbBDL66xi9i8jdWAx5c=; b=e
 FQhtrFfLshhbedyknZbo0e0kknVULE7c8Ef4m5MD4Y+59MK6ViUDgFi8dreXtmqH4al5QN57wKsCO
 eFVyftSIV9HZ3FUSyTL2whX1AWnEFgMP5q/Fsmq/6h/dnMsGlLtfRNMYBu3Xa3TroTOIhaPCb80fr
 pNnq21bpw+v/dqzw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Wqmx/SNglqG2XIwQ/goL3K6XbBDL66xi9i8jdWAx5c=; b=C1AnoRjVEgTldsTSXGpi2W1YLP
 ey6oG8jWZ/Bhl/vNBmJNJYvU1k7pKU1UmcCWZKJ0QHWEkx3veCm1LYdBw097ZK2n73pkoLHl0JVwT
 mPQh+9LhDQdgmsYmPLmLOIDjquwsFMtGk8FRqjokbyOFq1gPogNzp2vg+cLedti8qWvQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUMBb-000000004GR-3FOG for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:49:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AKAnbUq031854;
 Fri, 20 Nov 2026 11:49:37 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AKAnbDi031853;
 Fri, 20 Nov 2026 11:49:37 +0100 (CET) (envelope-from gert)
Date: Fri, 20 Nov 2026 11:49:37 +0100 (CET)
Message-Id: <202611201049.6AKAnbDi031853@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261119074802.20392-1-gert@greenie.muc.de>
References: <20261119074802.20392-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xUMBb-000000004GR-3FOG
Subject: [Openvpn-devel] [PATCH applied] Re: Remove .svncommitters
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

That was an easy one ;-)

Your patch has been applied to the master branch.

commit 0ca53540fa64bb63774326550341be33ab1c1def
Author: Razvan Cojocaru
Date:   Thu Nov 19 08:47:56 2026 +0100

     Remove .svncommitters

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2221
     Message-Id: <20261119074802.20392-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41661.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
