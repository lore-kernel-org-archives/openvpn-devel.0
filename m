Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7F8606A889
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HsQVU2L+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CBxldM+v;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CRlpNcf6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ot0nNKJV9ICXV5gj8ZHkhaInHbdRuETPj5c/K5i+HBk=; b=HsQVU2L+LoFalO
	omGoe8Zp3zLHjHP7wx/r64WrYUE8SBJXS8/CbgacVIWHTBCT1WOb5RTC5U4fVDDV39jBq075B/qoy
	2FnkiVNbo2eqKnKbjFo7CvSmpuddEeuGj1k1MQCSAwxiwCuOdP1P/2R6edmrTLDto2a7lEjPjFrLT
	WjI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYp0-000000004Sh-12OM;
	Thu, 12 Nov 2026 17:42:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRYos-000000004SX-0ZOM for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:42:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IpIfCh10OVfGwFTExG8xc4SEH9+ilOGCQD6Dq2FTIE0=; b=C
 BxldM+vvLgKD/zIYGvWBh9SGAbfwpASfHLPSBKgU52/JoFx7Fhtd1upkF7uhSrPlbhVlTc4mDaJZC
 WZQ8x50ldVV0jw7Vd0KIntb07pQ7w7lhDGExWp/WcJpT5G5jxhnM/r+PYqChIOEbshJ3LVMP2aPpk
 11CpFcloQmIiBq7M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IpIfCh10OVfGwFTExG8xc4SEH9+ilOGCQD6Dq2FTIE0=; b=CRlpNcf6YrQFzNiDapvad5csYM
 RgSC/3dpGLStbCcU/xLSkW3RiSqXAQU3z42YALU+2pW0ea1Qr7K9HsC2rlAsW9ry36ieeV5jOChzW
 GI5BJo/Z75HJKmM0wokh7DHNF0g6mR3128URDHTDoKbyTDKHw8u5m2JTZfDyxcNlkXRs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRYoq-000000003oQ-0AZP for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:42:42 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ACHgXlR076809;
 Thu, 12 Nov 2026 18:42:33 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ACHgWsQ076802;
 Thu, 12 Nov 2026 18:42:32 +0100 (CET) (envelope-from gert)
Date: Thu, 12 Nov 2026 18:42:32 +0100 (CET)
Message-Id: <202611121742.6ACHgWsQ076802@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261110112059.30832-1-gert@greenie.muc.de>
References: <20261110112059.30832-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRYoq-000000003oQ-0AZP
Subject: [Openvpn-devel] [PATCH applied] Re: sitnl: clear inet_address_t
 locals with CLEAR()
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

Well spotted (and sorry for ruining your 1-line v1 of the patch) - while
this does not look as nice, it's definitely more well-defined for union
types...

Ran client-side tests of the 2.7 backport on Linux.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 2a59209487d37e8d28ee4394bfa4de6e011a3c05 (master)
commit a095e4e82b3251fcc4f9d23eb2c2131b193b348b (release/2.7)
Author: Razvan Cojocaru
Date:   Tue Nov 10 12:20:53 2026 +0100

     sitnl: clear inet_address_t locals with CLEAR()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2163
     Message-Id: <20261110112059.30832-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41061.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
