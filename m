Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E05606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lbriyNm4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ESR7Auhq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Eua2Ta+b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uWsHHlxvNh0Sm/zntA9hMpqC+kO3tWzkrlVY6Wu2Y7A=; b=lbriyNm4/X8Y2l
	ADEGjFEXfczpBsr3MqSIK21dDfxUktJJKc2sGH+RTgVd3XzYW+igGArYpwjQWjS8c3KfaBzLb9m3M
	hXwFKmXSo98PwL01m2HpkexMSKtp1EKrlZqQ7T+QvKnlbLvJ0MO8eaetMabw0d40rVHnIzcrqXr6K
	bEg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWVQJ-0000000068j-1Lnv;
	Thu, 26 Nov 2026 09:05:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWVQH-0000000068W-14yi for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:05:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XPzOv/QJEZYwitETYvIHfRULk38lrTowdTh0tkdah1A=; b=E
 SR7Auhq49UWz7vE0J0PdRO5J2nVK4r09os9cl4vW+JQKRatLdDg8RgkwleZ6DZnb8mB0JbvnDrpHu
 vNgVWnZuaAgkl7S2fBGYBeP5IVAHGMSI2jou+m8oBlOVKhkbfFyaryyXvM8F3RHCTUcDJz7MRavK5
 hdz8LefMlLl+vMBg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XPzOv/QJEZYwitETYvIHfRULk38lrTowdTh0tkdah1A=; b=Eua2Ta+btJWOOyi/XR6JYFJmeL
 RPuGl3O/7FnjVvZx6SRFyDpq7fCmedpjfd6AyjYCjbyPt4d2dyjBHCVeJwhPnW0GAcJJd11y0nFPT
 swMtoeHgB0vGYPxjkelk6ANbbjfGG5AL3Wzaw8fDswmho2pTRRioyM6A4jzQO3RzJ/bE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWVQF-000000004Mv-07GU for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:05:45 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AQ95aNc007965;
 Thu, 26 Nov 2026 10:05:36 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQ95aFY007964;
 Thu, 26 Nov 2026 10:05:36 +0100 (CET) (envelope-from gert)
Date: Thu, 26 Nov 2026 10:05:36 +0100 (CET)
Message-Id: <202611260905.6AQ95aFY007964@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261125213012.15799-1-gert@greenie.muc.de>
References: <20261125213012.15799-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWVQF-000000004Mv-07GU
Subject: [Openvpn-devel] [PATCH applied] Re: Wipe auth token and PEM key
 copies before freeing them
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Yeah, good crypto hygiene.  From a crypto perspective, this is a bug,
so 2.7.  Test run the 2.7 branch on t_server with auth-token + tls-crypt
"just to be sure".

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit f043cea230691f41bb05367b871d3ebd3e17ef19 (master)
commit 01898e6021c9e16deadda0f0ccc21c7feda41c06 (release/2.7)
Author: Razvan Cojocaru
Date:   Wed Nov 25 22:30:07 2026 +0100

     Wipe auth token and PEM key copies before freeing them

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2206
     Message-Id: <20261125213012.15799-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41971.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
