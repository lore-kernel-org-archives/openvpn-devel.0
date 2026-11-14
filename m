Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF639606A327
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Dnd4qL1j;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PKvjNYrK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Mef8W5Mr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IUzOcu7aI6sXolmQbCR6mIRV9O2dR0nF+u9drMuqqAc=; b=Dnd4qL1j94fFda
	RYTXb5pILAlACClhs0ry5r9XRkvHfR4g1+w+q//Ns5yIbsa1CgwwP0VveFrlTGgUzjjb+X/YQvdnn
	yqhEXp0z2dtiIG3cBYRIpCr3BUnWYXW3V+169aQ2X7yOMhK4aGJ+XfSDVaId7PlCr5FrgMuXToptx
	tG0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSFPS-000000006F9-3BYK;
	Sat, 14 Nov 2026 15:11:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSFPR-000000006Ez-2RbX for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:11:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JE1nDv+N57k3P4m/vF/ckutpMEqmoJgvrFA1jWYuZXE=; b=P
 KvjNYrKMPsL0d81yhFJsZ5ZdM6rpoK/YF0WNcDOsNqzsbirTOfwCgdcIMXDriyEiPXcwDuJUQJaYl
 dqXwaqsJIlGD0RQn2WfTHLN6tR/X0xoqEpN34JNTwAAQ8Xv1KHBsOPlTwAW+1H00GBGmcbjU8++ai
 ReRgNI0l8Wy50jI8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JE1nDv+N57k3P4m/vF/ckutpMEqmoJgvrFA1jWYuZXE=; b=Mef8W5MrAja5DmMRD5zHtKMF6r
 qitwYjbhw/dpSAc3xcu2VvkIp2AAeEJrbXrWiXOXdge7SIwX8mjC325I74N1iSgvpF61SbAk+RY/9
 5wQ/5mIGESStA0IB68rNEDsO17MBP272pMjrCK5fUZWJftOj1Jj4ZNPtlpEBTnME/VCQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSFPP-000000000Xc-1eq1 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 15:11:17 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AEFB0QL079697;
 Sat, 14 Nov 2026 16:11:00 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEFAxEP079696;
 Sat, 14 Nov 2026 16:10:59 +0100 (CET) (envelope-from gert)
Date: Sat, 14 Nov 2026 16:10:59 +0100 (CET)
Message-Id: <202611141510.6AEFAxEP079696@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261110123659.4683-1-gert@greenie.muc.de>
References: <20261110123659.4683-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSFPP-000000000Xc-1eq1
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Change return type of
 buf_forward_capacity_total to size_t
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

Actually getting rid of some casts is most welcome ;-)

Your patch has been applied to the master branch.

commit 400d7e59c82b7835c64e00ae45db2d55d4895c93
Author: Frank Lichtenheld
Date:   Tue Nov 10 13:36:53 2026 +0100

     buffer: Change return type of buf_forward_capacity_total to size_t

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2165
     Message-Id: <20261110123659.4683-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41077.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
