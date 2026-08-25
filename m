Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F715C61DB6
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4pdUs6BDCgGd47b6f9YFhfdzpnIXEmk1ZVv70WpGmvw=; b=XZTWDmScrlCMxPGKmJOZhxHZTA
	AxBgMLeeU9DoBQ2mArlGRfvxhptZpxLCndOj3MGMEQ9co+/CYAJG7n7MjXuzFq4I0gIW7hqwlSmUl
	kifz0oo5Usq/PO2UEmROtJ0WDB12Ohm9zGIwRAu6sYPCc9bI/jY0mFbEmm8Fq6i00Cr4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylh5-0004DK-Lc;
	Tue, 25 Aug 2026 07:35:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wylh3-0004DB-KL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:35:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2iUF8p0jG2PEgJlJ1eQdcqiAlzq8O/hhcXLUdbBW+OE=; b=k5kL4OTCVdrWvmr/ECjJBqIGW8
 lUy0Va5oPTC7MtJjNqEUf0hSEfrI/hAedC1n3AXS1sXKkANeIX+fE7s3kLWfVApZAFI6JYIprTotL
 b7ngoYwja5qe46zCXGcNfVYLHf57HfKSgfiIP0tLGxNGi6UPDzoyquSuirv+GChcKPcs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2iUF8p0jG2PEgJlJ1eQdcqiAlzq8O/hhcXLUdbBW+OE=; b=Z5xX4DZMGJVbieUOdXY/P/0yBR
 lJDxsdS3k/x3l0864ieVqXlhEjytrGO21DkWFd1eTqyoiWwEqfhkG4IwJnqvsanWgTWkvgbj9MmLO
 zyrIv4B/VXBiXL8a86mk04eMcsErQR34rQbopZC2ox05zJ7f7tsSVO0iic9oeBKisKAI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wylgv-0000UY-Kz for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:35:33 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67P7ZG4V055434;
 Tue, 25 Aug 2026 09:35:16 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67P7ZGMn055433;
 Tue, 25 Aug 2026 09:35:16 +0200 (CEST) (envelope-from gert)
Date: Tue, 25 Aug 2026 09:35:16 +0200 (CEST)
Message-Id: <202608250735.67P7ZGMn055433@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260824161743.2156-1-gert@greenie.muc.de>
References: <20260824161743.2156-1-gert@greenie.muc.de>
X-Headers-End: 1wylgv-0000UY-Kz
Subject: [Openvpn-devel] [PATCH applied] Re: mroute: Remove unused functions
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
Cc: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Another one... and out they go ;-)

Your patch has been applied to the master branch.

commit de5381481584165cf83a0b8b423e2efab40ebd9f
Author: Frank Lichtenheld
Date:   Mon Aug 24 18:17:38 2026 +0200

     mroute: Remove unused functions

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1866
     Message-Id: <20260824161743.2156-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38645.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
