Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE25606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RzFiFCHO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kfHQxP58;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XA2hGXGk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KO3GbBPqhyG9z4scAoUBkCeGytwAVetO7HWbcdt8UBM=; b=RzFiFCHOIBZBOa
	tqYNp43sSIqbuF0O/7uMBVkreNSsEfUjV9BQomyIIqVCGmEcut7qKVQ7c7MvKavPStWsd/vBHoDbI
	S8MJX7WPU853N5/y97pNo0wETGR/yftca/IjkzI8Roq6AugdE9CnEdLeNmgg8hh3yGqArYtaImLyq
	hWE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTiJo-000000002Eb-2iCr;
	Wed, 18 Nov 2026 16:15:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTiJX-000000002EE-1sgH for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:15:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=c36VuP/R0SKeReoIWIO/KRrtmkly+DyfFPzR1BoxtzI=; b=k
 fHQxP58Tgxe3LiKOk7JOOG/NddhBvMpxSd/zTFUvTkAhnAMZtJDKHE6L9BVfO8wsKLOwtJq36EHfq
 9zDg+G9mSNrKrBA7f3CUycyZ3gHAKZ80QIDFtKwumjEnsDmQkPpwIsL6+gEs/Qr/EE/PIM5/nS1mo
 +icVNS1sWJM420Zw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c36VuP/R0SKeReoIWIO/KRrtmkly+DyfFPzR1BoxtzI=; b=XA2hGXGknvDoelGwdF7cV+gzM5
 U3WleopBni8nMFVrQFeVa1ShbJP7weme6DRY/Z30S1VLog2nuuzQf6dIxJQkb0KzCEUOJasPSVGr3
 2FK0N62Qz3SpvL8d5IqYJ/7sIylhbNb0MSbd1SEvcVjdnPvdQYfgosc5SeIvBfaN3GrM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTiJO-000000003e1-1QlX for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:15:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AIGExdg050348;
 Wed, 18 Nov 2026 17:14:59 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIGExho050347;
 Wed, 18 Nov 2026 17:14:59 +0100 (CET) (envelope-from gert)
Date: Wed, 18 Nov 2026 17:14:59 +0100 (CET)
Message-Id: <202611181614.6AIGExho050347@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261116172950.23858-1-gert@greenie.muc.de>
References: <20261116172950.23858-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTiJO-000000003e1-1QlX
Subject: [Openvpn-devel] [PATCH applied] Re: control_msg: Add a shared TLV
 codec and use it for early negotiation
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

So this is the ground work for the new and shiny OOB / server probe / 
new protocol stuff.

Since this adds a new file, I did a "make distcheck" (passes).  BB tested
the cmake / autoconf variations and is also happy.

The code got scrutinized by Razvan and Steffan, so I didn't deep-dive
into that - just a cursory look for anything they might have missed.
Since this is not just "add new code" but is also actively using it
(parse_early_negotiation_tlvs(), tls_reset_standalone()) I've subjected
this to the full t_server testbed - I'm fairly sure there is something
(master<->master?) that will excercise these.  Pass :-)

Your patch has been applied to the master branch.

commit cb48d4f77f9077bb3017b865b4e622bc0654399f
Author: Lev Stipakov
Date:   Mon Nov 16 18:29:44 2026 +0100

     control_msg: Add a shared TLV codec and use it for early negotiation

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1965
     Message-Id: <20261116172950.23858-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41473.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
