Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E25606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dy1CVBCS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WE3vnGzX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cWmpwMnn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vq0V22Mh24vcSzS3n4MUUtZbr7kzXQuAHUfG7wStF1w=; b=dy1CVBCSNO4t/r
	S0ImpCTt8wpuFgBijC5azvQ8liHQBrjZ2nTwS2Az9c/cK0CBAT3q2qQ4upC2NfqTm3z0mraXW4RCt
	hL/t7J70RB3YlVVZs+ydRYRF4Ckw3waPSylgQ59x4PNlPbVWsBWqcBcaLtCdxUoftOC/GFUpUkghJ
	J60=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX4pO-000000001VI-3FVA;
	Fri, 27 Nov 2026 22:54:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xX4pO-000000001VC-0WDz for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 22:54:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uCwkOusITkaXaR5wPChtqs3lzA5bUF3gsPQ3eN+qOcY=; b=W
 E3vnGzXx+aizhBPAhI0VR8XuouIT3FXvlMVv7wD/xAPkK1izlUaoX9XWVmOtegp33evCBnB6qV3TJ
 K4CMgTTJdSFNMdrAUd3lsxhB8oV3Untpm6sKaFTAK74t31MvN360o7Nb+Rhxnd8z9JRPxPvEHCjwN
 K3zs9B0vXuobXvXE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uCwkOusITkaXaR5wPChtqs3lzA5bUF3gsPQ3eN+qOcY=; b=cWmpwMnnOI6O8zW7LQzY39jv2Q
 y3y6By3yVCdVNplB9A2xm4JeDyS1yN1gq+Y5JwvIPxS7uGUqiAPNiTqcn5J+T73I568wK6d668ivX
 kSWZ/3UZ4oRlhRnqMuuXYga8usC6UFbOXeptONwJY0iKACEGhjgpTEOg3qFYBzUuTmFc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xX4pM-000000004ss-3Uun for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 22:54:02 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ARMrnSK088152;
 Fri, 27 Nov 2026 23:53:49 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ARMrnUP088151;
 Fri, 27 Nov 2026 23:53:49 +0100 (CET) (envelope-from gert)
Date: Fri, 27 Nov 2026 23:53:49 +0100 (CET)
Message-Id: <202611272253.6ARMrnUP088151@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261126102421.29800-1-gert@greenie.muc.de>
References: <20261126102421.29800-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xX4pM-000000004ss-3Uun
Subject: [Openvpn-devel] [PATCH applied] Re: dns-scripts: don't re-evaluate
 collected search domains
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

Magic shell quoting beyond my pay grade... I guess one could do that
without including $domains in the actual eval for \$dns_search_domain_{$i},
but I think I do understand what is happening... but to be sure, I've
just tested (gasp) the OpenBSD variant.  The change is 3x identical.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 88d49b64f6f56f6c4a4057249b69a02b9a2c4a27 (master)
commit 77b8520204cdf9a374f0d6f52738b0eb49e1d8c1 (release/2.7)
Author: Heiko Hund
Date:   Thu Nov 26 11:24:14 2026 +0100

     dns-scripts: don't re-evaluate collected search domains

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2347
     Message-Id: <20261126102421.29800-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg42061.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
