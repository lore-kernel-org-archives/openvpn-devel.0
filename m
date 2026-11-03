Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC7606A329
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MtN2yN+y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zyv0uKfi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B60+obeC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zHtrxK01gjcE4DNA1sZL6AuGqRp5RS9/WdNaqp+XSe8=; b=MtN2yN+yrwCWfC
	XlTnIdLy34gW2ohB9DmEbvWiUAA95uHOb2bqVuFA92rOw3VGR8jRmFxlTiJKb9lNvNmvXPaGsaX4x
	0DDDXGN+1vRoKClYiArjBD8x0BGems1dJkU2u1vIh2D/CBE1xhJpd+7TEbL1cHvTqHLp7rt8GMRzO
	dno=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOH7R-000000007Rx-3uAg;
	Tue, 03 Nov 2026 16:12:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOH7F-000000007Rf-3dTk for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:12:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hpD7996v4qm9n8JPF2X82dvCUTYCis/PK3HiH++asZ0=; b=Z
 yv0uKfiFQWnOZjehUqk5Y//hW0ZE3+SM89ISc572TyAVzbN3oS2j+oOH2ZPFsiVlz5GC/ApQT1mek
 N27l8SgMDMe+dTbtCjbwyw1jaGMtHnxEXWVZJBdGA07f3eLoKazZKMo75IcJxZ5zQ2hGTKgLIIWq6
 E7pP3r0WvvtAH2ho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hpD7996v4qm9n8JPF2X82dvCUTYCis/PK3HiH++asZ0=; b=B60+obeCoPG0Opljyr5KcLCWjM
 6usG8i1VPUJOdK58oN5bJuSq8AT0wg5ZdkGZ0tKuzND6ppDSKY5YxNmWiVwVq/OO004mpPDjCaovU
 iczlvonO3ws6F/1MoeG6ufyQIEzr1D+URqhamxoigP4pqNtssrUehOVJIhWyfnjwrnQw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOH7E-000000000qi-3EdH for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:12:05 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3GBw0X048289;
 Tue, 3 Nov 2026 17:11:58 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3GBwtq048288;
 Tue, 3 Nov 2026 17:11:58 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 17:11:58 +0100 (CET)
Message-Id: <202611031611.6A3GBwtq048288@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102141538.29830-1-gert@greenie.muc.de>
References: <20261102141538.29830-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOH7E-000000000qi-3EdH
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: wipe PRF master secret on
 failure paths
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

Well spotted.  As discussed on IRC, I'm keeping the ones to master that
only add cleanups to the (unlikely) error path - not sure I've ever 
seen a PRF failure, except for "your TLS library is stupid", in which
case both calls would fail.  But still, good housekeeping, just not
crucially important for 2.7.

Your patch has been applied to the master branch.

commit ccdcfa9df2cfafe0d6f4f04c0facbc46ee807ef3
Author: Razvan Cojocaru
Date:   Mon Nov 2 15:15:32 2026 +0100

     ssl: wipe PRF master secret on failure paths

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2088
     Message-Id: <20261102141538.29830-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40471.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
