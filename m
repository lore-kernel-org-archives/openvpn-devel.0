Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97391606A320
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bad0ddLk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=k2Hq0tam;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JBeF3kLt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6blnXhuyodL3n219jODfXtZtCp5wSYscgv3Io2TMvpg=; b=bad0ddLkNwhF2p
	E1uvrFRWQTy6VR9qiOm1gjw7I3LELbRI7F+lJGgQcS7Tf008nJUvt8umkRZt7vyoAfMLit+PCgy4J
	FO6Y14MlkGH4qdeqk/aJemBCmurzTB2HiUJKdl9sztFS9p23if2cGAvUYjI0XolLganwqGQYM4BqM
	heA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjCX-000000000m9-0G5J;
	Wed, 18 Nov 2026 17:12:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTjCN-000000000lK-3koK for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:11:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EKsIPRAAn7goiz3EEUCYPAW2JHzAqTtANIl0YqNHXDM=; b=k
 2Hq0tam2s7mAuUqoP0ry4f9xNn5gxBMdBKmF4Fya+hdbFV087xc1FvW60GOtR1GQoKOwCjn3V3R/1
 YNeMUVYIoCH5ItG23Dqlbq9jId20iPLsSX9jbdtU4iCXeZCKaR/Bh7dU1wqZRDDGkFOQmPTw+5cOX
 VQ3zb09VGynQhUxk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EKsIPRAAn7goiz3EEUCYPAW2JHzAqTtANIl0YqNHXDM=; b=JBeF3kLtK3XBm02a5obIV01pEY
 0AQ+Scg+v33kO0vTWXVkM+7WHSvR1FcqNq5LHPYxGzWXPkQ9FccgSszl8Jz3jWapyuoLAYj4STXOL
 LljpgiQzNefVSrjW+YnAZOv1FoTuyCGcff4Yw/OThRmL1TNI9/Pq7HZRarluoIYopPYg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTjCM-0000000056N-3xGb for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:11:55 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AIHBfME052879;
 Wed, 18 Nov 2026 18:11:41 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIHBemH052878;
 Wed, 18 Nov 2026 18:11:40 +0100 (CET) (envelope-from gert)
Date: Wed, 18 Nov 2026 18:11:40 +0100 (CET)
Message-Id: <202611181711.6AIHBemH052878@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261117102414.31377-1-gert@greenie.muc.de>
References: <20261117102414.31377-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTjCM-0000000056N-3xGb
Subject: [Openvpn-devel] [PATCH applied] Re: manage: Switch all sleep
 methods to unsigned
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

This is wild integer stuff, so I'm happy that Frank +2'ed it... ;-)

(This is more than "just integers", it's also cleaning up weird 
conditions... even with the signed "sec" before, "expire = now + sec"
would have achieved the same as the "start with 0" dance...)

A bit of (size_t) change that isn't strictly "sleep method" related
snuck in, but that is fine too.

We do need management interface tests...

Your patch has been applied to the master branch.

commit d0b779bd20b6c6da7510f24ecba66afa73bbbb40
Author: Frank Lichtenheld
Date:   Tue Nov 17 11:24:09 2026 +0100

     manage: Switch all sleep methods to unsigned

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2200
     Message-Id: <20261117102414.31377-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41512.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
