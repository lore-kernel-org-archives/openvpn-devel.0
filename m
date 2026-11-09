Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC1606A321
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P1kE9ZFZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bscKEhJo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Dt9A4AO5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Y9/f+xZ73gKqandctTnN28crZQsIIUGQZMSSrcqKxpk=; b=P1kE9ZFZNiyCYf
	hlfzy+1xjve1cTV4aq4/5PFIi2hozABHWeyjyGm2OyWBQQE1IcwtMYWGPMXlk2ynlqI9sL1aZ7INc
	8EE5sqZI1zkZS5QefV8L6K/SdobXJGrvsZYPlrsV1H58lty1xqSE2biPN6AA7P9SFwOmktydmNrtv
	2W4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQO8V-000000003l9-1a6y;
	Mon, 09 Nov 2026 12:06:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xQO8U-000000003l3-15Z0 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:06:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AEiA1x50XYgCkATwQ7JSa7rOWke5lZnlwyIq2+LGl5M=; b=b
 scKEhJo1fRaA4K04jHvFuIC43tGaBhJ7+qGtNqeRbx2lRlhX4/s/CGIcpuUsSfU/qSq0Q4nDd0O4T
 pd01AEDNZSACIhyfPDR3mcdRFxdIGr9TEXLeivd/rnHSYAQBpj7EuamzZNBA5nhQsieBf772IrWvY
 iioDQ0fRvI+1DK0o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AEiA1x50XYgCkATwQ7JSa7rOWke5lZnlwyIq2+LGl5M=; b=Dt9A4AO5+eHFU53GwG3q4FLxUb
 VjyQJKO+QRkR5lqFoC0nz10kmWJZdRvGBGbDkfOdztZlxDdocLOV4yMroa3+xbg1VMm3GXnOm4PMg
 1fsyxxCzXl4ARpuTqa8O1nZgn7E8Me2da9NM1Kh3bjD6jqeDoaMfpyCdL5zLhKzDDORY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQO8S-000000004Gw-1V1S for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 12:06:06 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A9C5vP0015757;
 Mon, 9 Nov 2026 13:05:57 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A9C5vkA015756;
 Mon, 9 Nov 2026 13:05:57 +0100 (CET) (envelope-from gert)
Date: Mon, 9 Nov 2026 13:05:57 +0100 (CET)
Message-Id: <202611091205.6A9C5vkA015756@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261109091139.4816-1-gert@greenie.muc.de>
References: <20261109091139.4816-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xQO8S-000000004Gw-1V1S
Subject: [Openvpn-devel] [PATCH applied] Re: reflect_filter: initialise
 warning_displayed in the rate limiter
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

Easy enough - good catch ;-) - have only compile-tested 2.7
("BB compiles master, all green")

Your patch has been applied to the master and release/2.7 branch.

commit 672f39fbd0a88ce0b387d581da22a7b5d30b91d1 (master)
commit 04352e82138ebf44581cf30f8eac49f652c23166 (release/2.7)
Author: Lev Stipakov
Date:   Mon Nov 9 10:11:32 2026 +0100

     reflect_filter: initialise warning_displayed in the rate limiter

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2146
     Message-Id: <20261109091139.4816-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40963.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
