Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE01606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gQfpTXrD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=P/+CFJG0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HFwdGKQd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gSg54ga54pRVJhHaADAp6/tYvj9CxGKq62lqg3oc/lc=; b=gQfpTXrD3ary5j
	7iDI53/lPhYnXx6DsrEshFupTL67iA+zydzY45O2l7PFTnKQxttAm5eLXNoespCp67AAkRgjQ6Ij/
	y5F+Eft6/xttu83SQG2ix9EgodYKwLhtL9G1B6BPxKM/N4JpEM00T7VMuEDB+nDRSNuPDCwe3Vdl1
	6Hs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTgkB-000000007Bs-3ybQ;
	Wed, 18 Nov 2026 14:34:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTgkA-000000007Bg-3TMt for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:34:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Prqplzl0AI1VCHkhLrMNRyOx5NIuMY+3zJ0EkkZSOk4=; b=P
 /+CFJG0USDMHuGURyHzoc3+sZZyB8Q8APTJjCrxPKJJ1bZ1+6O/T315B3WG7stS35VMHEOvhlEDuW
 hCu/0AOFHJQ6DVa+IgUE/FLEYJ11pcDs9YN/mQC4Hrjn2xv70zkxmeiS4yObh21gQlEd1YQw4DlMv
 14GpxX0lXPxXHN8M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Prqplzl0AI1VCHkhLrMNRyOx5NIuMY+3zJ0EkkZSOk4=; b=HFwdGKQdptoL6Pzx7NTpf8O0GZ
 biPJsguhCNxlSyHPmxfjcFUhaa0ivf2W82SQqOdwQC2RFKz+BsLua6hSSWVXTa1Z5v+7FByima0WF
 XbtEKsWg9RWJLcaXAnEoQclMnaO4L0obqh04KYBbma2uw2tR/5Hl/gpaz2nu79beqORY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTgk7-000000002w0-470V for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:34:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AIEYT8G036838;
 Wed, 18 Nov 2026 15:34:29 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIEYT8i036837;
 Wed, 18 Nov 2026 15:34:29 +0100 (CET) (envelope-from gert)
Date: Wed, 18 Nov 2026 15:34:29 +0100 (CET)
Message-Id: <202611181434.6AIEYT8i036837@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261117175605.14945-1-gert@greenie.muc.de>
References: <20261117175605.14945-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTgk7-000000002w0-470V
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: remove obsolete
 preprocessor guards
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

Every #ifdef gone is a good #ifdef... :-)

Since this is cleanup, no functional change, master is good enough - and
BB nicely tested that for us.

Your patch has been applied to the master branch.

commit f4b0e57369874b634cbf9b402e05e5be2520c77b
Author: Razvan Cojocaru
Date:   Tue Nov 17 18:55:58 2026 +0100

     ssl: remove obsolete preprocessor guards

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2189
     Message-Id: <20261117175605.14945-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41577.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
