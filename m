Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3625606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l2XxlI0R;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZJ3taddH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M/vZIL+G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Fk+LB6FCujTlQPX7u6STXMyBOrXYXqUdL4FtGjtiRgM=; b=l2XxlI0RlAOtPC
	C62t4yDW3j/gUO6/vGo0B5g2yQwST4F/oIx0ILnox+WKFuz2Nxz0TuDbiMcX/WOD9WqHpCTOdQUuQ
	FebU08E6yvupcIvr/v7od4Y5wXmyHyNgpg4rT8HmRpvFsPPiESo9hWrdgHfEA5414bW1F7OIZ5K8s
	QZE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX4Rx-0000000014z-1oDR;
	Fri, 27 Nov 2026 22:29:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xX4Rv-0000000014s-3dwW for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 22:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9SUyhj0pk+puCLObFEPjzjIpiQUlCtc6Ocy7YUHNlG8=; b=Z
 J3taddHh9hTjzOgEykvFJx+fAkqER+pd91mfzil94Ym1pmTNOwrUF7YAaI0QMCBrPElEO+6YT0bVf
 HW03lt/qnwJr84cmzmKcp6e1QCOZ7j0EVmY++m/gEJh6BWEWsGWW20U+64S4M+rSaal5JUlgz1hbh
 rkBsRFnX7p34xPpI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9SUyhj0pk+puCLObFEPjzjIpiQUlCtc6Ocy7YUHNlG8=; b=M/vZIL+GiFqsxWyWG+KTl6W3Sc
 9rDBEhGDc2gRrKbceH4f6wUTf3TcyIh/R3FGcu6BfsOhcVAg7GHW0L6Fy4VvsROWialHpgCAjxYQ7
 lXSHTQPVOVQqdOZ83/OPIU2biB9pOLFvR8fD16m9QaDQn0ESpvxbxZ1+G+MyXBjfo4ZI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xX4Ru-000000004MQ-1zUM for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 22:29:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ARMTdTL087340;
 Fri, 27 Nov 2026 23:29:39 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ARMTdQg087339;
 Fri, 27 Nov 2026 23:29:39 +0100 (CET) (envelope-from gert)
Date: Fri, 27 Nov 2026 23:29:39 +0100 (CET)
Message-Id: <202611272229.6ARMTdQg087339@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261119130414.20274-1-gert@greenie.muc.de>
References: <20261119130414.20274-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xX4Ru-000000004MQ-1zUM
Subject: [Openvpn-devel] [PATCH applied] Re: control_msg: Add P_CONTROL_V2
 and the probe request and reply TLVs
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

Stared a bit at the changes, and ran a full t_server/t_client run, just
for the sake of it.  As the comment says, this isn't sending or replying-to
probes yet, so this mostly excercised the unit tests...  (and
double-checks that the opcode_is_reliable_control() change is correct).

Your patch has been applied to the master branch.

commit 418d24e158329342b385c65d9b0bab14dd645d91
Author: Lev Stipakov
Date:   Thu Nov 19 14:04:08 2026 +0100

     control_msg: Add P_CONTROL_V2 and the probe request and reply TLVs

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1741
     Message-Id: <20261119130414.20274-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41678.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
