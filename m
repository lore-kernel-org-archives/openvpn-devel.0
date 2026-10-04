Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8279DCA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NVeRz9t9xtD3JQ4abPjqggAElR1zmIap0pFuhJR1Kdw=; b=XgL9kX6LAcGL+EmYehSQze8mR7
	+bDuPdVzwoj0FiEY6tUSG4Ozdyuds8KRM4eITDfmh7Fn/gyv6wKBgCFoFV0J8QOWjh5QEV9sCdI5T
	dFgKWMsUp5Ii6SvUGhk2hZ7M9I0U3tXiGT8F/j7w3/voa3yAT5zdWAv+ZGnwDV5qCawo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDI1a-0007Dm-HL;
	Sun, 04 Oct 2026 08:56:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xDI1W-0007CF-Kz
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0rF3CJBMipyJem8q/Rtbl08ozHfsmZVe8faU2olZ7TM=; b=dkDCVuZ7Wcf4Vslmdyd74plTcQ
 cwA+lOfdO2CHrT80YBy4nrXX7r48a7J03u9SWRN6Iu911mLeRm4GJD4jbEDeHJvTeHI5x3jNOID8B
 7uMcFHbURE0ICmrzCi8SrKtQNe7S6Db2j7h12wlnFPAoeD78/dnA4Jr4HnFPt3NWOyqs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0rF3CJBMipyJem8q/Rtbl08ozHfsmZVe8faU2olZ7TM=; b=CvpTXGzHlFVCYynx/l2MhG7KDw
 cnjD1wa2p50oWNbbid5AUr7hfJczBbh7NWkjX8rNu5uHOrCw7fSbJOKIcT//otBweDR8dHzJZ/d6q
 5JeXihfUOYVheLcrMGae5DT5E+8rHOGQde0qEanYUm19wAs0RnDL5bEXNAYDsdZuCzAo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDI1T-0002Vz-A1 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 08:56:44 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6948uTVU086206;
 Sun, 4 Oct 2026 10:56:29 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6948uTkD086205;
 Sun, 4 Oct 2026 10:56:29 +0200 (CEST) (envelope-from gert)
Date: Sun, 4 Oct 2026 10:56:29 +0200 (CEST)
Message-Id: <202610040856.6948uTkD086205@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261003175718.6544-1-gert@greenie.muc.de>
References: <20261003175718.6544-1-gert@greenie.muc.de>
X-Headers-End: 1xDI1T-0002Vz-A1
Subject: [Openvpn-devel] [PATCH applied] Re: Build against Windows 10 API
 and remove some backwards compatility code
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

I'm not the windows building expert, but this looks reasonable and has
been +2'ed by Razvan.  Plus BB agrees that it does not break anything :-)

(Also I like the simplification of win32_get_arch() a lot!)

Your patch has been applied to the master branch.

commit 624f08b120a119ac730ce6e09c2abc59495c069d
Author: Frank Lichtenheld
Date:   Sat Oct 3 19:57:12 2026 +0200

     Build against Windows 10 API and remove some backwards compatility code

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1955
     Message-Id: <20261003175718.6544-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39673.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
