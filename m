Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B51CC6B39
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+cUS9dOYhgRbmC24Q14A9orXK8fYtlDAluVskmUSO/s=; b=HxWCClGJ4ujtV8R1gnyd//0coK
	3tuXeHeR+RPHw5fbMWp+F/briqxn7F7NT0EJQY6yXeoQiUaO9rotVWqgQlOCBYQTg4INPfYUnepiq
	kSytUrRIc2QtAz1eKE1vE+UPD6h63j7DxUx2vn0rFgWJiME+x+teOJUeVo4b/pTU4894=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHNNE-0007Rf-DP;
	Thu, 15 Oct 2026 15:28:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xHNNC-0007RS-V6
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:28:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z3/gv58sC4phi3T6PlXta0NutogI3QQs1EY0j0kVZJ4=; b=h8Rz+e9/27lAN97qCMT3r1RrQG
 q3By6K6QXmZdK7m/k0MaUlSMbYIRe7yJLo01PNeVirH3f4zlMQjLILkU+LpaFpKUmND+QBJpcNv/U
 M5oPfwFJNujDP9vzZr9rxPh4cKCYxemdHHvLWhNChRsFrpYmNT8pVms8GHxBE3GqZhXE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z3/gv58sC4phi3T6PlXta0NutogI3QQs1EY0j0kVZJ4=; b=JXqAlDcdR4XxcSSpX6Ugvifepa
 4yN2iMd6w64MxlfEZ0FqATdkwK6yAVjzPrqAwq/fKRMwQKplqVy1A9uLQV5PGFnjuZXwZZbWmfWO8
 cJsPVcTr9/QIW4+oEA56mC/PBRsXqs/EOWaA38FPmDC5U5NWvN5Q0DTdKG2Wf5lVo150=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHNNB-0003rs-OT for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:28:03 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69FFRkfS000919;
 Thu, 15 Oct 2026 17:27:46 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69FFRkSY000918;
 Thu, 15 Oct 2026 17:27:46 +0200 (CEST) (envelope-from gert)
Date: Thu, 15 Oct 2026 17:27:46 +0200 (CEST)
Message-Id: <202610151527.69FFRkSY000918@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261015113218.24245-1-gert@greenie.muc.de>
References: <20261015113218.24245-1-gert@greenie.muc.de>
X-Headers-End: 1xHNNB-0003rs-OT
Subject: [Openvpn-devel] [PATCH applied] Re: Remove instances of
 constParameterPointer cppcheck warnings
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

This is quite a bit to digest... - but if cppcheck & buildbot & Razvan
agree on it... :-)

SF list -> mail-archive.org seems to have spamfiltered this, so referencing
lore.kernel org.

Your patch has been applied to the master branch.

commit 571caa34e2fe134029a57769df8182b1c31e33a4
Author: Frank Lichtenheld
Date:   Thu Oct 15 13:32:13 2026 +0200

     Remove instances of constParameterPointer cppcheck warnings

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1663
     Message-Id: <20261015113218.24245-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261015113218.24245-1-gert@greenie.muc.de/
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
