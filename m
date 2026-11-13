Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C14606A32E
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TRcUdey7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Q4n8aZ6k;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OF8V6RFk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uJ/x0vsNfiyPZEBXXGOZJFuZU7GCb8AAw8F0E3pnkdo=; b=TRcUdey7bzPAO0
	0zTqKNBsr8zOP7saQ5BlTLLSNveh4wGBnd4+b9K0TcmnChrSB1ql0LVtKCiPj9LR1OmMx2Y1r8dgt
	5/WG1myCAcMN8Y5Zp+JMpygeVHdaYlQzBWkMKiKHauBiiepWW0JgVfNoURnidRlLAuMaVowndSuIj
	y5I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRzdc-000000000t3-1kdV;
	Fri, 13 Nov 2026 22:20:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRzdC-000000000oy-1gk6 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:20:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NcsOs/oGLQqs0gZlzInAeDs7A1TDXbX3KMZaSJUeUQ8=; b=Q
 4n8aZ6kbCH4d10ozfGbXBBfGuNHaIs/V6WVy/KwV8MQpvulvAgXtK5OGWSei/JdCf7ZPI9AMG3x2h
 lhAjRs74fzxgHsGTkaewBVzlY0AZn1BClUVkjxH1Orp1uWTWLIgIrCxYjMD9blwRVwuhgGCB3DMkK
 ItSty2DFxWDr2weA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NcsOs/oGLQqs0gZlzInAeDs7A1TDXbX3KMZaSJUeUQ8=; b=OF8V6RFkThdu2+CTaq9WLea0lH
 gpTcH8P5jMrE1huKdYBWR4qEtLqbt4jGpsa09P0KpgjImoNRW5c6/jv0KnEuFr4CYGoo57D42y1ZR
 RFBMomIOSteO71yN8SGukbP5UjRewBywQnP+5VEl05yL4lXC8KLY9XNT2RUSP2xuig5o=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRzdB-0000000005o-2Al5 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:20:26 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ADMKBBL044712;
 Fri, 13 Nov 2026 23:20:11 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADMKBD0044711;
 Fri, 13 Nov 2026 23:20:11 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 23:20:11 +0100 (CET)
Message-Id: <202611132220.6ADMKBD0044711@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261111183144.18676-1-gert@greenie.muc.de>
References: <20261111183144.18676-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRzdB-0000000005o-2Al5
Subject: [Openvpn-devel] [PATCH applied] Re: crypto*: Avoid sign conversion
 warnings by using defines directly
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

Makes sense, does not improve or worsen the affected lines notably
(well, "mac_len" is shorter and somewhat more clear on "what is this for?"
than "OPENVPN_AEAD_TAG_LENGTH", but if you touch this code you should
know what this is about anyway... and if we only have one possible
mac_len there anyway...)

Your patch has been applied to the master branch.

commit bf7c8d16730fd21ac290ad508404f6efcbdfc8a4
Author: Frank Lichtenheld
Date:   Wed Nov 11 19:31:39 2026 +0100

     crypto*: Avoid sign conversion warnings by using defines directly

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2158
     Message-Id: <20261111183144.18676-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261111183144.18676-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
