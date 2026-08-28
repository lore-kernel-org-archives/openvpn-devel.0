Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859DCC61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GM+eVjAu3EatiRe1r/CbbPG5euq9tE6pAJKVn7tFf/o=; b=c0OQ1EnXaM4uQhcZpPNx5rTHIt
	WxNx7R+LB9aKSoCqKpghPnX4sG2Afa/EuYyYLn1U+D9plFg6ClQuf7jLA3syT4feLfEnXh0H0QaXN
	KXOVH95T5uaU+Z0mzflcrrriTFRt7Qu9TAkC2aw2fcOX18bRd17YkzIzFy/7e3QtnhYY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztrP-000196-Dj;
	Fri, 28 Aug 2026 10:31:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wztrO-00018x-Id
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:30:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d9f0HEivdXaZasGY2VOUjcoLCu/Nme7g0hZkPy71zAk=; b=jTdH3iOnkHa6sUg0EZRKM/dbS+
 VhK2zM0OH19Tn/77rqw+wbGkgismZ4s3bPPCCoeyKz3A+L4Sivo+5EzNFqLDm7vQ+1oEIzwudpcLV
 RyDIS5MAyHhNIuDLMZm+/vKZwf8J7OHDANBCvEXJCrL4GVq2sF72mXNaoPGn9yC7GEeI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d9f0HEivdXaZasGY2VOUjcoLCu/Nme7g0hZkPy71zAk=; b=PZzyaV5TxmuOVDVAyZCA3XQrrp
 C/KSmHSiuW3SBC8tD0cj6eLEYHy888ywM0Zhnfpd4wT5oQShqOvHwAJeVjlXizeyfE3nTxzYdmq+O
 uM19Xn8AULam7FTqxbd7hqSXDSdCLwWfO8yz7wtqo6T2i20W2hcT/nloPja8sgzHa5X8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wztrN-0001LY-FV for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:30:59 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67SAUodP085591;
 Fri, 28 Aug 2026 12:30:50 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67SAUoXU085590;
 Fri, 28 Aug 2026 12:30:50 +0200 (CEST) (envelope-from gert)
Date: Fri, 28 Aug 2026 12:30:50 +0200 (CEST)
Message-Id: <202608281030.67SAUoXU085590@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260826185309.18083-1-gert@greenie.muc.de>
References: <20260826185309.18083-1-gert@greenie.muc.de>
X-Headers-End: 1wztrN-0001LY-FV
Subject: [Openvpn-devel] [PATCH applied] Re: Factor out
 lookup_session_by_mda_key_id into its own method
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

"makes sense"... ACK from Frank, all green from BB, etc.

Your patch has been applied to the master branch.

commit e9b9f6c0b61a3aaaa4c696ac3c091c4ee580a305
Author: Arne Schwabe
Date:   Wed Aug 26 20:53:04 2026 +0200

     Factor out lookup_session_by_mda_key_id into its own method

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1854
     Message-Id: <20260826185309.18083-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38736.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
