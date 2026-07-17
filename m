Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C30C44515
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EAfjlYPypxO0x+DcWeW1s/Gi3OhGi71DL/ZMfHPpRYY=; b=cIIx/TfSS/odXyLgSGxIXTa1da
	YVbTOvELn5PSTnInpjSfk7DRtGM6/n318s37NZeLF1undaom7wM0vr3zz9jNJAsx1+SiP7MPDBuiF
	PsnV+CbSdELyEcmt1jtqRqekeYpKw7J5zH7PNxLsOwZM4zOxHhWNeCVN4wwrAygxLwd4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkmuZ-0007He-Hb;
	Fri, 17 Jul 2026 18:03:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wkmuX-0007HX-TV
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 18:03:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0m733TySBVKSIK7yrIUuPa1P8h8BjN7mhTH0GVw3kNk=; b=dJoDXNOV/RBw/uDvjBrk6qzlEu
 ZD5tZ+UoB59dANtv7qwVf1hVZCFZh21b2lxvp5UPPDvxz7gpxu0dwb5erctvqTTCvWxPqO7VNEGQW
 KJwhMS5A6cWD7coGnH0D8Zm18Zn9kDOzB7Zb6Uq+BgqkuWK//xMknkWR6HqLz54Sqdmg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0m733TySBVKSIK7yrIUuPa1P8h8BjN7mhTH0GVw3kNk=; b=VAKaXj4ydkEUOvyWbfoiOyL2pf
 X5l+m/2WXxv+/2eA2ndfO6f/7JN/1MTwyUd4nGg5KFe6C6AMNQjzgSno8UR8Xwqv/A9orijEvXetf
 O6f/DITBx2k02KQH9KOpgUjn/cFJPYMivWvKV8A9PReiBkhCScuWAXmr4PVjUpsrfYWE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wkmuW-0007Kp-5S for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 18:03:45 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66HI3bFP087316;
 Fri, 17 Jul 2026 20:03:37 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66HI3bvE087315;
 Fri, 17 Jul 2026 20:03:37 +0200 (CEST) (envelope-from gert)
Date: Fri, 17 Jul 2026 20:03:37 +0200 (CEST)
Message-Id: <202607171803.66HI3bvE087315@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260717141442.22943-1-gert@greenie.muc.de>
References: <20260717141442.22943-1-gert@greenie.muc.de>
X-Headers-End: 1wkmuW-0007Kp-5S
Subject: [Openvpn-devel] [PATCH applied] Re: Move incoming data processing
 in its own method
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

"git show --color-moved=zebra -w" nicely shows that really most of it
was just moved out of the caller into multi_process_incoming_link_data()
(or vice versa, the calling part was moved upwards in the file).

t_client + t_server tests are happy enough :-) - and these really excercise
the code in question.

Your patch has been applied to the master branch.

commit 27a39d7c0b2ca7f9fc8b7dae0ea3570369f6ae25
Author: Arne Schwabe
Date:   Fri Jul 17 16:14:37 2026 +0200

     Move incoming data processing in its own method

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1722
     Message-Id: <20260717141442.22943-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37674.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
