Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD4BC61DE1
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 17:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2IQbfpt1tyMemngWonaaXmsFnqFVVgEKeXz0khjdjxs=; b=DlnVDhTpGiO860sl4sj/j2Fo1L
	I2+RUMEl2LhNk4qvLqibyD8xwU2SpqucNfB2NsT+KRkohL5JfV42/P8/tZ3QQRek0ALTo66g9O9wk
	406kfy7Y52YVTWyrE0fAgOFLyfy6pBgX/QWaAxJvhz7tuZxqki6ZI4kuevlyFk09TfXs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0jJU-0004nY-Io;
	Sun, 30 Aug 2026 17:27:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x0jJS-0004nL-ID
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:27:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=agxUaTSH1Ma9gAIcyMcNiJ8caf8fv7eiIAB9CDB/jb8=; b=XVmUAsXKjgMRAMQl+6TJ0IKm9A
 a0ciAVZg4c++0Yhu0muWI8+NHG3XL3q3mfdgtR+CjX8aPb9/gDSnGyLB8DWSt3ZZ42M67KZWATFC5
 Qk4HuX8JMHSCv8kAaec3Oz3nKP5ihH3nY5NA2KoHvm8vI6pmD1Ah8fGWN1/AYHl5iQts=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=agxUaTSH1Ma9gAIcyMcNiJ8caf8fv7eiIAB9CDB/jb8=; b=IeMjLCRDDq3SmojAKK9K3oRVbp
 MpvS95LgZly5Kn7ZR/tmgdZfar20uiuztompk9Hi5382vyZxy4fVrysQIEz9hMWweH3VJrIDn10vk
 c8zkKuvc1RW6HIjk6W4L541lXrWH5dr+pTkFLtHdYQtEsEM38jfzj8kb4I4BmnybBPdM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0jJS-0001aU-CL for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:27:23 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67UHR89c081949;
 Sun, 30 Aug 2026 19:27:08 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67UHR8KB081948;
 Sun, 30 Aug 2026 19:27:08 +0200 (CEST) (envelope-from gert)
Date: Sun, 30 Aug 2026 19:27:08 +0200 (CEST)
Message-Id: <202608301727.67UHR8KB081948@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260827170326.13161-1-gert@greenie.muc.de>
References: <20260827170326.13161-1-gert@greenie.muc.de>
X-Headers-End: 1x0jJS-0001aU-CL
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh.in: Add ability to
 filter by test group
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

Mildly tested ("I did a test run with TEST_GROUP_NUMBER=4") and stared
a bit at the code.  Not sure how to make most use of it, but sometimes
this is just what I want ("run all the udp instance 2 tests now, because
I fixed something server-side"), so, nice addition.

Your patch has been applied to the master branch.

commit af6a79c6a83739ca9542e52a02a3449a2f292758
Author: Frank Lichtenheld
Date:   Thu Aug 27 19:03:20 2026 +0200

     t_client.sh.in: Add ability to filter by test group

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1777
     Message-Id: <20260827170326.13161-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38757.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
