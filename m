Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60073606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=To3kENtZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kVnhXSpP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KvkB63tN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AWdRAB4+L9/otxZhmaiuufUhDQsdSYDuEa3q3aXRdjQ=; b=To3kENtZMVYEMm
	VpPvwSful7tNNrZChh1X32ZbrxWH2Low4VE3ZFcodKpmtAIaytQqUhJbS5a2qzZvSQGyV/L7SaijF
	8x0rwYKPl1cHxnwG2iKnNUaI9ZN7OwmWJjZuFzsrSJgwVsumzGae4msSGf1531OWJu/Dsk2rqz4aa
	SxY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRzQG-000000008Pr-14eA;
	Fri, 13 Nov 2026 22:07:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRzQF-000000008Pk-0oV0 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:07:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mFF0ufNWeT+04Ibm2DDsBSS2eQUrjeHu9+hMreki5ds=; b=k
 VnhXSpPPfyzcrDp0vrwAWLQQfIy7YLo5ONnJX4vHZ25P9Kn1IIU/4bqwM226UWNT8cAf4M8NKtgGC
 Yr6iUi9i5+6nqs+PLOkMotNdmzY4FHW0MSZrkkLjjFooiMOdO3B70XtlOe9w3tAAzEvRYFDHog2rp
 wYn9fF6hs6CpmiMs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mFF0ufNWeT+04Ibm2DDsBSS2eQUrjeHu9+hMreki5ds=; b=KvkB63tNwXK9CAGExtWqTooudu
 Sm5DNrSIKsMQS7Z4doNVfeMUkJSYXhpuDbaG0YTyF5I2Byku1rCVIcL0j9vOKpSrs5ATJKvxxPR0o
 l8XyVUavlJnffjvIZ3eXuqWWQ17iKNI3gNIUXTWo6NZaxX1CeqPVGIUG58LKHGU+YpN4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRzQD-000000008JB-1vjz for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:07:03 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ADM6lLW031595;
 Fri, 13 Nov 2026 23:06:47 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADM6l0N031594;
 Fri, 13 Nov 2026 23:06:47 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 23:06:47 +0100 (CET)
Message-Id: <202611132206.6ADM6l0N031594@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261112174213.23832-1-gert@greenie.muc.de>
References: <20261112174213.23832-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRzQD-000000008JB-1vjz
Subject: [Openvpn-devel] [PATCH applied] Re: Enable -Wsign-conversion
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

As before, add lots of #pragma, and then go forward and fix them one
by one... keeping the number of changes and conflicts manageable.

I have not checked whether this is warning free on all platforms
(but BB should do that), but I have double-checked that all
changes are #if/#pragma/#endif plus build tools (in one case, the #if
is intertwined with LIBRESSL_VERSION_NUMBER... ugh)

Your patch has been applied to the master branch.

commit 132cc1ada4e28af5a7b49e2de44184ff500daca6
Author: Frank Lichtenheld
Date:   Thu Nov 12 18:42:07 2026 +0100

     Enable -Wsign-conversion

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1186
     Message-Id: <20261112174213.23832-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41216.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
