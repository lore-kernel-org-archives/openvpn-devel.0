Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A3606A32C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jh6T8r1q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a5CIAUu5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dvqjB61D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ruxZ1zR3KDk1U0Ex3XZabX1VbOhOuFt7t/C2Iwb1Yic=; b=jh6T8r1qQ/lcS2
	B81XPJQfZDiqbEZuZS61CRzPoe/QHeAbqcGpzph5trVaHioZ+5c07XqBgmqKdBT4OhSMLMqBOGvGI
	BYWOB+KUuA8c5/GFA28L31mCrDVJkrvVdHd6NgMdDKzJGT3HRelxG+GEjK8WenCvFRhygqDyKsWUF
	qlM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWVaS-000000005tO-0AoT;
	Thu, 26 Nov 2026 09:16:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWVaR-000000005t9-09qc for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:16:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JrRlyOlaY/L5Jtd1d0IZezLYt5/GmJeNwpP8vgOUR58=; b=a
 5CIAUu5clqoZmJunE+iw4ev/9HRxkxQvqo5iafOTu20Z51c15oZ+WqhP/6nSEWTarI/7yBATdi43Y
 10yRliHD14RDkdCJICcXRcr5t+92EABHk9kgUl+dSO7VJjQUTMIPNTY5TSKYdlBlliWHBJixeYY4B
 Ftyi88F0DL1rGTYY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JrRlyOlaY/L5Jtd1d0IZezLYt5/GmJeNwpP8vgOUR58=; b=dvqjB61DNiRLu7INHvBZTI01DV
 2zyBSqtIvnOHY/pZQSqxhC1ovsV8iGxolApZTh3Y/R5G7sIxpFzWfugt/mNOUQgQ0Yla6pZ7p46A5
 GFRWg27dxEmILE6ejozAs5oxbFOLFmOpbrShsdlqB8FYleELOjOSTYDEUBNYf5THwVHw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWVaO-0000000051u-0kpH for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:16:14 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AQ9G5o7008477;
 Thu, 26 Nov 2026 10:16:05 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQ9G4sP008476;
 Thu, 26 Nov 2026 10:16:04 +0100 (CET) (envelope-from gert)
Date: Thu, 26 Nov 2026 10:16:04 +0100 (CET)
Message-Id: <202611260916.6AQ9G4sP008476@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261125171133.21392-1-gert@greenie.muc.de>
References: <20261125171133.21392-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWVaO-0000000051u-0kpH
Subject: [Openvpn-devel] [PATCH applied] Re: push: remove dead code
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

Getting rid of dead code helps code readability ;-)

Not fixing an actual bug, so no 2.7 for you.

Your patch has been applied to the master branch.

commit 2f930baf5b0846f745efd99b510533ceeaadb662
Author: Razvan Cojocaru
Date:   Wed Nov 25 18:11:28 2026 +0100

     push: remove dead code

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2344
     Message-Id: <20261125171133.21392-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41963.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
