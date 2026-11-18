Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53146606A332
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MdSePEUq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QQzT4B9h;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HDpYBAhY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HxX2kVH1XJroYt0G18jLJxMBToRb0E2F5B9hveWyxRg=; b=MdSePEUqqxoE5G
	BMkvBrL5mCbLdxb1qyTX8FT0qwcrLNkCRq1EXQOCik/kGcUITjVSXSjyvlMMr1KFc177SUuBF6h8/
	tqhCGpVWwrqfvsKHZVd7qaphTuqKbYIKvgwsjzUxVGroIFdB1Dnb4MW+CPF+YAEW7yj+QhXRjNx+S
	jHg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTj7W-0000000059b-3BXW;
	Wed, 18 Nov 2026 17:06:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTj7V-0000000059V-02ki for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:06:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rfp0n1cIUfm2w6E2Caybc/uua2RfPW0xqNH/QvjFtJg=; b=Q
 QzT4B9huYLF/YjLwwaCPWnFr1tUDF+DBFKtRjEStAfYLNWIjSjzHGbeP5ZKENeGByehOB6hY18CPu
 +qz/5/6vZu5QRAQbS+fwf8c2HI7Fagz/s6Rw69LxOIuqVIeCLXsiDB3Oo10FnEsKVfX2VNU5J6JQc
 9he0asYhdpxkNBQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rfp0n1cIUfm2w6E2Caybc/uua2RfPW0xqNH/QvjFtJg=; b=HDpYBAhYVRrHsOAsAcspq/hFgO
 L+KazFj5ic202NponyY/09ZzFPDfBe5Mmn7A53wzCjILBFYsZ+ifXYG+hcf4swYKfKW8ycqc7WHgU
 gQmUSskcMTgudR7niOrydFA6a3t5tAn9lhhPYI7LF2p3bXwaWhp5O4h/l+vAHy2sDmpk=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTj7T-000000004xv-1GQl for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:06:52 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AIH6h6o052522;
 Wed, 18 Nov 2026 18:06:43 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIH6htN052521;
 Wed, 18 Nov 2026 18:06:43 +0100 (CET) (envelope-from gert)
Date: Wed, 18 Nov 2026 18:06:43 +0100 (CET)
Message-Id: <202611181706.6AIH6htN052521@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261117143617.25095-1-gert@greenie.muc.de>
References: <20261117143617.25095-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTj7T-000000004xv-1GQl
Subject: [Openvpn-devel] [PATCH applied] Re: options: drop impossible
 out-of-memory branches
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

Good cleanup :-) - BB all green, so I haven't tested much more.

Not relevant for 2.7

Your patch has been applied to the master branch.

commit ec5dd16a4a97622009da864f9f167a9667005cdd
Author: Razvan Cojocaru
Date:   Tue Nov 17 15:36:12 2026 +0100

     options: drop impossible out-of-memory branches

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2196
     Message-Id: <20261117143617.25095-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41542.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
