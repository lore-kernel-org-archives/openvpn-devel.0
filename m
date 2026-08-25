Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790E3C61DB6
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0KzI4KNyvI8F7dvx7E2due4aDwJClrJsLJIR4xomE+o=; b=hxAqIBzc0v7oSQ2iItkar2/2+O
	EgINlQw/gZfrjvy29/FSM4jfUYTu4RRbjBgY3EELMBpbi2EzrdpfVWsBf+MljMuPi0esJS9hWxnP5
	Q5LSnpOyPSCgen+rXIaOfbbWh3mry6uIw6faHRTcolIZSEtiHD4ho60Qf8oujQf5DsnU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylaM-0006eK-IT;
	Tue, 25 Aug 2026 07:28:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wylaL-0006eD-7s
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:28:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0uwSpt4xLxJwlUGDkUP7eRR/F9pWwu8BCgx9nm5lhZM=; b=JNN5MtRbn2rzRs+GLVZ3OAyIl5
 yZdYvax9of9R85D6jHUZ9lIaJ7ifPgQsi6/fPgaghr+3HQ6jRnAuxvFqkFBc/a0orxiP4gq2hR3YG
 uTrPfF6CHLdQwwWDOaAcym1swQEn224ZhVkEO6yNtPUbr13mKlP3k7WmRn/iSU3zVUUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0uwSpt4xLxJwlUGDkUP7eRR/F9pWwu8BCgx9nm5lhZM=; b=Ri1wJxLhMjUqMlPZ3j6H5rH9fh
 lVgH8CLk25xH350xirG4JCJa9SmXw8v6Y/rOw98zBF4mzVcMDEPZLUBbz83LESkbv6n0U3FO9DMAr
 C7i4H96ROq5i82ib5eU7O/lqlLGKKoxUh8qzkQCnm2AHoJYOs9q7A5zvRmzIB4nI0BWg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wylaF-00073b-Tu for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:28:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67P7SMRM053532;
 Tue, 25 Aug 2026 09:28:22 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67P7SMKS053531;
 Tue, 25 Aug 2026 09:28:22 +0200 (CEST) (envelope-from gert)
Date: Tue, 25 Aug 2026 09:28:22 +0200 (CEST)
Message-Id: <202608250728.67P7SMKS053531@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260824161640.1971-1-gert@greenie.muc.de>
References: <20260824161640.1971-1-gert@greenie.muc.de>
X-Headers-End: 1wylaF-00073b-Tu
Subject: [Openvpn-devel] [PATCH applied] Re: interval: Remove unused
 usec_timer functions
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

Straightforward, and BB & git grep confirm this is really not used
anywhere...

Your patch has been applied to the master branch.

commit a0598f56bf21aa241d303a02d47912b71749d66b
Author: Frank Lichtenheld
Date:   Mon Aug 24 18:16:34 2026 +0200

     interval: Remove unused usec_timer functions

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1862
     Message-Id: <20260824161640.1971-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38643.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
