Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C21CCF2E4
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NWc0VKeqnwQSS93/oSPncRQcHDETbUkEPzfwe0OBMa8=; b=eKFyIwelXzA6o3aGWGo/9mr5o5
	ln34Xr8Kr7JsqyAgjpZpm/emPprULWPdj8u3gqdfXbBq1hnc2Ihyz6xWXYE/XteQ5QRfC0g6gALNB
	Ed9+DMt6R7H3hzUo5sq7hTwXrjVb+q/u6XCXyVcPGieuKBn/tqnnApX2JO1wo23HlS1o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xImoZ-0005b2-Ab;
	Mon, 19 Oct 2026 12:50:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xImoX-0005aj-Do
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:50:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V9QgN4w2dSuO4rjniHa6PiEtNEIGXVRWGTN2RMuwFnY=; b=TKbMKfkwDEVclD9jz3RuoSDde7
 kLzqaFOVzspZ5t09n1PGci+28dJHwDRoqa2uFrAFFgXqfT9UG61+zEx8Mb66RjEXoRpliKVfL5vVh
 XCyhzvrV4AadqbJEXK3rcqNsbnbuNSQWN3bsqapB2i0JfMOOP5BhOdFdB08fO/BMqrMw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V9QgN4w2dSuO4rjniHa6PiEtNEIGXVRWGTN2RMuwFnY=; b=FBvUiQMFNvnWIaEMVOMENLZzSh
 mB7oryxGEj79D0gwwA4IRkdaicaxOQ0Ufb0xMrxWM40lCIyYFj5dYBo6tAItuNGw25UKZ/ka6Kd9C
 vgaVbYqh1D/MqDd/IuG4qVzG+W/4OBSga7HdFU3Ccy9L5DTyEyFgbw5ifi5qycdLeXeE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xImoR-0007AC-Gj for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 12:50:02 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69JCnhww055064;
 Mon, 19 Oct 2026 14:49:43 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69JCnhi3055063;
 Mon, 19 Oct 2026 14:49:43 +0200 (CEST) (envelope-from gert)
Date: Mon, 19 Oct 2026 14:49:43 +0200 (CEST)
Message-Id: <202610191249.69JCnhi3055063@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261018154151.23586-1-gert@greenie.muc.de>
References: <20261018154151.23586-1-gert@greenie.muc.de>
X-Headers-End: 1xImoR-0007AC-Gj
Subject: [Openvpn-devel] [PATCH applied] Re: push: Avoid conversion warnings
 in send_push_options
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

Straightforward enough, one set of #pragma gone, BB all green...

Your patch has been applied to the master branch.

commit 4562a9e5953eda34ce8540814be797dc1407676f
Author: Frank Lichtenheld
Date:   Sun Oct 18 17:41:45 2026 +0200

     push: Avoid conversion warnings in send_push_options

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2005
     Message-Id: <20261018154151.23586-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40021.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
