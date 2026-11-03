Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506B606D83C
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PmyILtXO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HtkkRPXS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PKO8j/l2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=thfC+a1os/3ReGeuXdQgPSR4stcTy7LudZRtIXBoud4=; b=PmyILtXOMP6IKb
	u0mcldGRFm4CJVcZ1+26/pmjxPQ0IRkZ69tk/1hqp1wVvvZnxzP9/qHj0lLBa/hrc+C7NDe/tTc9m
	uzjQeRdecghhRlIKnsg69tQWzcBkySfZbIiB3EUtDBWG7VtNwMsnrb4W8lvx0GCxo9tzVHtvD3kT0
	OIA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHve-000000008Ll-2ziD;
	Tue, 03 Nov 2026 17:04:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOHvc-000000008Ld-3brO for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:04:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=exQdBtyUb3bpGyzMFWsqGkkbpDYa9guF4NuBjwKrSyA=; b=H
 tkkRPXS8slPEx+a1fcS5EYB/lPjNjy11HtswvB/d3FWgxb/+C98hGWmWVJBGzxmfeFcpaM7Dg+WaF
 k2d18qEqbwPsAjEZkR14tDrqDkG9LVfrbSfKcr2M83oOlBZmn3B7yUZoaok0V8MzvB+Zy4HYNbaU8
 /+z555iNcQR8s/jw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=exQdBtyUb3bpGyzMFWsqGkkbpDYa9guF4NuBjwKrSyA=; b=PKO8j/l2Pse4z8GAoLxX+0Jeuy
 kNBFMJxRC9pWWyRYtXjj77BVkvvUZZjmN9wt0bdgdNQHlUbdufobN59WRkQhk12PRm4o2U27Nc8Bq
 Czf4lGLr4hahq0oUASO5RHU1Q1vk4iW2ck/D/y0ClBEcbv2Ct9V6B25OIQ091hDVLRpE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOHvZ-000000002Nr-2QEO for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:04:08 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3H3xmE050654;
 Tue, 3 Nov 2026 18:03:59 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3H3wYM050653;
 Tue, 3 Nov 2026 18:03:58 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 18:03:58 +0100 (CET)
Message-Id: <202611031703.6A3H3wYM050653@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102142000.30467-1-gert@greenie.muc.de>
References: <20261102142000.30467-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOHvZ-000000002Nr-2QEO
Subject: [Openvpn-devel] [PATCH applied] Re: route: print net_gateway info
 instead of unset rgi/rgi6
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

Another nice finding... testing this on FreeBSD, with --verb 4, I get
"no output regarding gateway at all" (so it's not really obvious that
"something is missing here").  With the patch, I have them back...

2026-11-03 17:57:59 us=291394 ROUTE_GATEWAY x.x.x.30/255.255.255.224 IFACE=vtnet0 HWADDR=bc:24:11:bf:7a:d4
2026-11-03 17:57:59 us=291493 ROUTE6_GATEWAY 2001:608:x:x::ffff IFACE=vtnet0

Backporting to 2.7 needed a bit of manoevering around ENABLE_DEBUG :-) -
but the actual offending line is the same.

Your patch has been applied to the master and release/2.7 branch (bugfix!).

commit 791eb227d912a77713245f33854bcfe84a2dcc9b (master)
commit 54ab191c5171c52e13243af8cae5a850e83e7da6 (release/2.7)
Author: Razvan Cojocaru
Date:   Mon Nov 2 15:19:55 2026 +0100

     route: print net_gateway info instead of unset rgi/rgi6

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2086
     Message-Id: <20261102142000.30467-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40495.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
