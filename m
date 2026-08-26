Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05764C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPekAu/pQwqypAm/oFrwhdn6z0q1shRLnX7n1L7TDuk=; b=cwhLIE+Ws0JDF7ymNsx+mzdgNe
	H8EXJiK975w5/Xtvxq/VVZbUVqCgPERduGQMkZxaKij5utQIcgNm5mc9Nxp9KMW6rLUq3ZRabhVNE
	cbqb5fBMXY6kJfr6FuMUMyAHXQc8yWD18EA0fMXkePd+65On2dD+8S2OhsVYVn5oFPPM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz73y-0006TY-2n;
	Wed, 26 Aug 2026 06:24:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wz73r-0006Sl-HS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=22WzQOE4RO60bYDL4zoAkPD75NmQnI4M8owxfD4Kz0w=; b=YIrx9ka8w1esrg0hDrwvRkgzj4
 RrBbhRd89XcNgOUpsuFpb3xT77iBP7gvsUEcv0hjX8F97GWLr5/o2u6mvcyDt3/dZ8QvUGB6378qe
 +EdVG23nHSXoIDK8AqXOcyF6VOfY3J+ji/D924qH4Poyf4kNkaueI7dk6wW+wQWzyqTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=22WzQOE4RO60bYDL4zoAkPD75NmQnI4M8owxfD4Kz0w=; b=OBoETBGWyHwi2tXdEubAzfroIo
 j89+fhalos4q5mLAHpiYhBsZfkLhruWkP5ffxkLEjJXg8pzPWf3mqyQM2Lx1ejlkjpYo04Ny2E/Z6
 fepb1H6pcw9osInfldnkAbH74WVLaUzr/Od2MsWVHJ2yPz439iAyAB+COBe1ailOnCKo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz73q-00071H-Fn for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:24:36 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67Q6ORWp004208;
 Wed, 26 Aug 2026 08:24:27 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67Q6ORBu004207;
 Wed, 26 Aug 2026 08:24:27 +0200 (CEST) (envelope-from gert)
Date: Wed, 26 Aug 2026 08:24:27 +0200 (CEST)
Message-Id: <202608260624.67Q6ORBu004207@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260825165028.9823-1-gert@greenie.muc.de>
References: <20260825165028.9823-1-gert@greenie.muc.de>
X-Headers-End: 1wz73q-00071H-Fn
Subject: [Openvpn-devel] [PATCH applied] Re: doc: Update doxygen references
 to removed tunnel_server_{udp, tcp}()
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

Documentation update is always welcome :-)

Your patch has been applied to the master and release/2.7 branch.

commit ee3d1df7429486b78445a5caba37f8e16a5ecbd7 (master)
commit ec2b4007ec5a120d63cb8c3ded38c28dd2773e95 (release/2.7)
Author: Razvan Cojocaru
Date:   Tue Aug 25 18:50:22 2026 +0200

     doc: Update doxygen references to removed tunnel_server_{udp, tcp}()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1850
     Message-Id: <20260825165028.9823-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38687.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
