Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F05CA5FCE
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z3jjVl/8nodIcm3ZplsMM0iLi1UFDTDzY3QW0v5/A2M=; b=DY/OXtHZW4EcIsqwDrWnY7taNo
	uDwWtQ4NQ5bzgXfY6rHqOpegK6F9eZGi551Uxlr/1VfUnInEmzC4RpI7R8wKCLV6afeYVcN9VZNA4
	YaUpQO9Hmn78pyB0QskoJfM72D8Q3RW1FWPUxOBoomVfUmIr1Hwr7NTdYnKp7Hd/4frM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDJHG-0001gw-AH;
	Sun, 04 Oct 2026 10:17:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xDJHF-0001gq-4J
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UNWCEYCXWX8v6+Sk2OAgtVDayE0YbyvkCK+wWAzRfXo=; b=YJb5jKwPZamVHrN8d68tQvbgfO
 uL7dyCbkH9ZEBYymf0SfLZssCo9imtujlPb//OQjPSLYwO+ckuDc0/PR0wKUTmEf6EINAYFY/v4bO
 7K/oohsc0YV6MKCeQVVdgCIsrnpFYLemlQygO/43CmPbw9SZxK6WO1fWXzpJZVU4bOwM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UNWCEYCXWX8v6+Sk2OAgtVDayE0YbyvkCK+wWAzRfXo=; b=jRP9ZQCpLQ4opC/j+FLWHX7Bjm
 tSalx2Evgmc3CidkavbBY18hQC+fm4P/lz2w7bu9sMa2yj8dZ06Mp5njYTWDA7pu8ESFHOyZEowiR
 qx4XKFHQ1lJXJ+jY+LmDMUNg/aJdtPVQyZ9ZRO4iVaR5fzZKkblSdeRM2ZSLx1DlfM14=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDJHE-0006M4-2Q for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:17:05 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 694AGuDu089420;
 Sun, 4 Oct 2026 12:16:56 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 694AGunl089419;
 Sun, 4 Oct 2026 12:16:56 +0200 (CEST) (envelope-from gert)
Date: Sun, 4 Oct 2026 12:16:56 +0200 (CEST)
Message-Id: <202610041016.694AGunl089419@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Sarvagya Chaturvedi <sarvagya0624@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260921134208.54064-1-frank@lichtenheld.com>
References: <20260921134208.54064-1-frank@lichtenheld.com>
X-Headers-End: 1xDJHE-0006M4-2Q
Subject: [Openvpn-devel] [PATCH applied] Re: doc: document optional message
 parameter for management command client-kill
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

Thanks for that.  Documentation improvements are always welcome :-) - that
it took so long to get merged was due to other distractions ("crash bugs
in DCO" and such stuff ;-) ).

Your patch has been applied to the master and release/2.7 branch (docs).

commit c53ed7dab126ebe110520e461c6e482e9a136fa2 (master)
commit 779cd934714237473fda39cc1d1042d7f8fe4b4b (release/2.7)
Author: Sarvagya Chaturvedi
Date:   Mon Sep 21 15:42:08 2026 +0200

     doc: document optional message parameter for management command client-kill

     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Signed-off-by: Sarvagya Chaturvedi <sarvagya0624@gmail.com>
     Message-Id: <20260921134208.54064-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39365.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
