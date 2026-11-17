Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09059606A32A
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EalBBy7H;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=J6mLCzCR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mFPaWFHv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bYez+/L0/UIKOy0QyP6WHAVACpYlqvHjBMN+fHiiRj4=; b=EalBBy7HWX0vfA
	bpTZkTjad/+1O4OqSXBBXAWNKcwYVYTZKhILs+GNUf8DeypQflKu+sB9wdUbg3MVM2VEgoITYHqNW
	gNqVgwzpz2cVDzjezSxw3INh0ITMG0iobmu7buSyKZTOMJUIrY5HaRMijng4TD8qgffP8nA0AMmUQ
	SOw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKne-000000003AH-2Nh4;
	Tue, 17 Nov 2026 15:08:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTKnd-000000003AA-0dui for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:08:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YESoq7YuFzGQQv8aVYunJ716PaAQPmjUmD9NAtq3q94=; b=J
 6mLCzCRsDIfskzmkaBrtAK1MqrXLkx4/+16oBIE4mvDTE844UdjNO+8PKv6oNoglqmVLVhFC8KyzK
 K0aGzJtLN1c1e2nXXf+4uulb6QFcNH9FuISeP4sV36bDEylV+ood46JQsRCn5OH5SWKw7ZLXIRUmN
 JJLaO/NJrPDQjbQk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YESoq7YuFzGQQv8aVYunJ716PaAQPmjUmD9NAtq3q94=; b=mFPaWFHvlpVa5dr1ulAbNCjcY4
 QvB9inBbGQkzGdRda6cJX9VmtTovIciGbDci/iF3JnAT0+G02FE8C63XdvINiby9ui+0qvtaqe+Mb
 vSafbbyg8A4PgOz62LgCxQdVeC82H6t0swGs6cYQ9vRzgE9+kZ6X4fE5HbPhmFVMPpso=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTKna-000000000zr-1AAI for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:08:45 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AHF8Z1V024177;
 Tue, 17 Nov 2026 16:08:35 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHF8YK0024176;
 Tue, 17 Nov 2026 16:08:34 +0100 (CET) (envelope-from gert)
Date: Tue, 17 Nov 2026 16:08:34 +0100 (CET)
Message-Id: <202611171508.6AHF8YK0024176@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gert Doering <gert@greenie.muc.de>
X-Patchwork-State: Accepted
In-Reply-To: <20261115164331.8511-1-gert@greenie.muc.de>
References: <20261115164331.8511-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTKna-000000000zr-1AAI
Subject: [Openvpn-devel] [PATCH applied] Re: DragonFly: bring things back
 into a working state
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

Razvan, thanks for the review :-) - as requested, I have fixed the
loose #endif /* platform */ comment in tun.c, and have also added
a GH reference to the dragonfly dports issue.

The tun.c change applies cleanly apply to 2.7, the lladdr.c would
need more work (because Frank rewrote this all for master) - but easily
solved, really.  I do not really feel like "2.7" - it's been broken
since a long time, so it's not really a "bugfix", more "bring in a new
platform" which would be "master -> 2.8" then.  But their ports tree
carries local fixes anyway, so they can easily take this commit and
apply it to 2.7...

Patch has been applied to the master branch.

commit 727e2463939d5b4118b2b19f4445493597484718
Author: Gert Doering
Date:   Sun Nov 15 17:43:24 2026 +0100

     DragonFly: bring things back into a working state

     Signed-off-by: Gert Doering <gert@greenie.muc.de>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2170
     Message-Id: <20261115164331.8511-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41373.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
