Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39137606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M7qZkDby;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BDSeA1lw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RxdZ9QpQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+BRLhFYexPeYCSHSgaO9GUwy+vsPFL0spg7/p7v0fIs=; b=M7qZkDbyCHzxl+
	tGW50dqax6Kds9px2sRDIz22T0MTLbVg1QlSI3gRrx29JSIvrpSIl3PrBe9uEwju/7paIIsrHrJD8
	epTduP75QOecY/EWaddk9YjeNhlhF8djE11rgD6O97mRUdiWgUhQGnDguD69Hnj/Vplkror4dJvlX
	0Co=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSYJc-000000000pC-0X5f;
	Sun, 15 Nov 2026 11:22:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSYJa-000000000p3-1IbX for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 11:22:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vYiSWSUQmcDpmydrnmidgJhCx5TmnBeC/Q0eB4TnyCg=; b=B
 DSeA1lwDzkladOB+wJS29iKDArk8Ae3wMkmHev3AACiPTzXq4yKkg3ik2DvD84ZweAICZKOWBsW38
 LYzMSxrBBFfoZHVK/++c0/jNH07K2QWWuxudrs1qtJr/TBnSrOdIpkEFpaZndbUreYJfllyhADhtH
 XBbTgz/bLaAHH8VM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vYiSWSUQmcDpmydrnmidgJhCx5TmnBeC/Q0eB4TnyCg=; b=RxdZ9QpQ3xnJCDrLkvMaRUsynf
 4HYRqA8JeGmq5QAp6mQ4AFO8HUN43GD1A9EonlzDBzeKKGYB/WBCI3yCSJvSETAlGTUPLj5/QFumu
 ARMhIOsMR9EmB6JwJufCFQr+VkB4rZy+Lgk4cDKMcYgFhsgC4EI8W7JZoxoJiUy6p9sU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSYJY-000000006aw-2uD7 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 11:22:30 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AFBMMuw041024;
 Sun, 15 Nov 2026 12:22:22 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AFBMLhF041023;
 Sun, 15 Nov 2026 12:22:21 +0100 (CET) (envelope-from gert)
Date: Sun, 15 Nov 2026 12:22:21 +0100 (CET)
Message-Id: <202611151122.6AFBMLhF041023@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261114162252.5144-1-gert@greenie.muc.de>
References: <20261114162252.5144-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSYJY-000000006aw-2uD7
Subject: [Openvpn-devel] [PATCH applied] Re: route: remove never-returned
 LR_ERROR
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

Quite an improvement ;-)  (and that original code *quite* predates
my involvment in route.c mogrifications...)

Your patch has been applied to the master branch.

commit 7697c2f1d978c6cf2a933c2cf543366bb719bae3
Author: Razvan Cojocaru
Date:   Sat Nov 14 17:22:46 2026 +0100

     route: remove never-returned LR_ERROR

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2129
     Message-Id: <20261114162252.5144-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41316.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
