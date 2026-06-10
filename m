Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E60DCD8CB9
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MVkL5AZIcpFagbApGhghr1zW+NDNoydixiP0kx9odW0=; b=fE0uoT3xl2fqjFFWYlN7KbPiO0
	j7kXJYcwebSA7OsH3LemVoWj0KA1MQbdvyxtPFSrzqPSCJbHE9XnmUZTKnitzdgXFvoa762/vVv+E
	1J3UlTqeoeghMbrDGbO5VWDVjXMaYDgV0EMT0Nrsb2AI5erWx2JZKy7sbYSC9RWcoNeU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXMSL-0000AN-04;
	Wed, 10 Jun 2026 17:11:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wXMSI-00009w-0N
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:11:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wYtaPob5qxHyj1B9J2SzScztH9Huw122hx1VYSTNIoE=; b=PH9UzKSgsq8Dwvzy+/2z+Ole8U
 F75BIu7NS1vx/zApMkehcuDYI35QphLO8m7jAIQW6yqOccHB0BGxRgfHSqTVmeLz3eZ2gFIgfeU1y
 JANe4iV40LueswiFKkd6rOsaerHkHjPESUAwLkx/D/OxFNErOnqVvcOhXOYzPV4zr7yU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wYtaPob5qxHyj1B9J2SzScztH9Huw122hx1VYSTNIoE=; b=elE58eeBANan/2ls6Kx4p3MXFv
 wltR3zoh6FZ163NY4NElYN+N1o5ff7veD4I/7MMTtLz/rZ02Apr8/Ju9me+UTfQMu7YeYPr1b28B1
 C4x2J3Iv9koERriHzZ8vT9ZtCp2Fxn4L6JQoITAu3R/o0L6+aTvj7ddp0Wz27l61a3y8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXMSC-00077Y-25 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:11:06 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65AHAkuB002746;
 Wed, 10 Jun 2026 19:10:46 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65AHAkuE002745;
 Wed, 10 Jun 2026 19:10:46 +0200 (CEST) (envelope-from gert)
Date: Wed, 10 Jun 2026 19:10:46 +0200 (CEST)
Message-Id: <202606101710.65AHAkuE002745@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260609152045.27384-1-gert@greenie.muc.de>
References: <20260609152045.27384-1-gert@greenie.muc.de>
X-Headers-End: 1wXMSC-00077Y-25
Subject: [Openvpn-devel] [PATCH applied] Re: renovate: Fix typo in regex
 manager
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

I won't pretend to understand what this does, but it's not directly code
relevant (refreshing dependencies in the github magickery), and if Arne
says it's good, fine with me :-)

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit e02ca9a487ba04c5f2da28421795e74b9b5b71e0 (master)
commit b9989b5c8494a5c04aa77186571471e2ac531f14 (release/2.7)
Author: Frank Lichtenheld
Date:   Tue Jun 9 17:20:38 2026 +0200

     renovate: Fix typo in regex manager

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1709
     Message-Id: <20260609152045.27384-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37137.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
