Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED36606A333
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T36YHjQM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LIaKafdU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=S2Cm3QWZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gcp3KTDtIqgri7ReBBcY8LCXLVzcNXdAx6X7ZdpLP+Y=; b=T36YHjQM1xF3VI
	IQ/VdS64Kr6TNpID0d6iB/2dEjlUpH2orYkS+q25WRRxAROsP3oLXG39uzw0jm+hG6dwiOE7YyRUQ
	9nFhQuzSAcnjSc8EEbYhU41A2ib3xRFZGGoPn6/CiMSFf2wM9epJEWva5vrw6rvwyVvi9CZE4sbCJ
	P1U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTHAa-000000006YZ-0YVN;
	Tue, 17 Nov 2026 11:16:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTHAY-000000006YS-1Fh5 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:16:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jnN8eHrT83ZheyolOxkxdoYGlPXoSD24pwmBwaBoKBY=; b=L
 IaKafdUgx1DXWsWIYw6gPZKRIIYgbw3BJ/sxYAsNbbch67zwaqabiLUJ5VyCFgNgvFAZ+Ace3ttp8
 eP3VazqIN2xO3uYeMPhiL1Ank8mqRpik8rNtHh9kteyvvEUpGeOjCCSzpfaT1C4mezIayZVQCEDdO
 5xBxZO4KXCjgT+H4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jnN8eHrT83ZheyolOxkxdoYGlPXoSD24pwmBwaBoKBY=; b=S2Cm3QWZQdtTyStj6DGaiysRIP
 Zl3lUWiRDL7xh4F51qgDB47zdItPCBnT3kIcC1O68TpEXJwOe8JY4a/7h6XB0VwgOrmyaCNGDwY2w
 ajKM0ElNnlzIQDSROukdmf7VJsZL0iDnlHHZRqXofWggSMumLO83WI0QG+QgmazCzDuw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTHAV-0000000039s-43dY for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:16:10 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AHBFqMO016698;
 Tue, 17 Nov 2026 12:15:52 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHBFqbt016697;
 Tue, 17 Nov 2026 12:15:52 +0100 (CET) (envelope-from gert)
Date: Tue, 17 Nov 2026 12:15:52 +0100 (CET)
Message-Id: <202611171115.6AHBFqbt016697@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261117101909.30743-1-gert@greenie.muc.de>
References: <20261117101909.30743-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTHAV-0000000039s-43dY
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Switch
 buf_forward_capacity and buf_set_write to size_t
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

.. and all of a sudden, all BB instances are green again :-)

Your patch has been applied to the master branch.

commit 823653286f82e2fbcd1ff1687a8a01b3fb6302e6
Author: Frank Lichtenheld
Date:   Tue Nov 17 11:19:01 2026 +0100

     buffer: Switch buf_forward_capacity and buf_set_write to size_t

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2198
     Message-Id: <20261117101909.30743-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41509.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
