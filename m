Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2810BC61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gZNuLQaKRSyxvQH1wL0op7BGIuFYSrA32/3ujy5feMI=; b=SSResdRp9WJJNsaMWplbx4E7XZ
	GGHrW7lPvwSoN58ciYFVcI06GbjPPeoJMR+KRREgYxEMOZCKR57drDWpBqwCg2rH9T7KrEdInbiLg
	pM51YbLE5yhbS8J+UfBd8V/PQ0jpB8zeNR8VRafPF3KfWVrsorIyP0L6zlAK3Ols9PAA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztoP-0006IR-A5;
	Fri, 28 Aug 2026 10:27:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wzto6-0006Ht-RY
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ERIzL4mAOqba7Tz5akUwc2fxO3fJDoXpdMzpgo6CCAM=; b=Y+vZEa2jTZDarEK7EwSFqEPG1N
 8o52Alv7O6Z/v7uQnGsf49xuM6jA0Iq+TcMcq6z8KYt18S0P9SGHM7NyoeqGqo1u7vLax+3r7943i
 UtkhNjf7jEKNv9GTw/SQhXl9D+LimaHwP24GQuU+xV4uh/nWA4smqEUBiPLr2wkjX98s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ERIzL4mAOqba7Tz5akUwc2fxO3fJDoXpdMzpgo6CCAM=; b=h16PmPo9AMO7ZILJPYH6UJDNdq
 iWNkKk7pQL02OupOZWUPITgEk/i++F6c4dzj6ECAP/0Sff59sblydQ5ANBS+XMfu2yOHmjOTnkfz5
 XR0BtfbxG9hf8ybXtxPdSxJ4ERl3f2uF80iM/eaXldvXewdvxOSExA1Xcyj2fOHOmAF8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wztnw-0001Fw-N4 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:27:26 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67SARI7P085296;
 Fri, 28 Aug 2026 12:27:18 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67SARIv5085295;
 Fri, 28 Aug 2026 12:27:18 +0200 (CEST) (envelope-from gert)
Date: Fri, 28 Aug 2026 12:27:18 +0200 (CEST)
Message-Id: <202608281027.67SARIv5085295@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260826185329.18177-1-gert@greenie.muc.de>
References: <20260826185329.18177-1-gert@greenie.muc.de>
X-Headers-End: 1wztnw-0001Fw-N4
Subject: [Openvpn-devel] [PATCH applied] Re: Move mocks from
 test_push_update_msg into its own compile unit
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

This makes sense and has a +2 from Frank :-) - not very much to test
here, except "do the unit tests still compile and pass"...

Your patch has been applied to the master branch.

commit 79f5dc97f643d5157d5b9eebd1481af6960b3aab
Author: Arne Schwabe
Date:   Wed Aug 26 20:53:24 2026 +0200

     Move mocks from test_push_update_msg into its own compile unit

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1853
     Message-Id: <20260826185329.18177-1-gert@greenie.muc.de>
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
