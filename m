Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC8606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MBDa+KUr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GDm10anZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fq+xZa2b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7jjWPx29Vkx4z23oEC+rn3aHcHFGo+w1tkbUaKmZtOY=; b=MBDa+KUrbgPXZV
	JN941db2jNu7Ge0npjSQhuTqb4/VGaInFkL76moiJfozgCCivbpx3vDHiyAgAMsRFKV/1aBNndNRz
	YnnAELE4ku9U+eAUVJtQNOa6G6NZexeeFxqkY7V0X36sL0SCZL2977yL3G1pJDRcTIDsTzegIA/CK
	HPU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPNp2-000000005U1-35I5;
	Fri, 06 Nov 2026 17:33:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xPNp1-000000005Tu-2cKs for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 17:33:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AfW67c+TPC7xtoa0pu6YIAXuLkLPiDlqm9ZAlxjD5eA=; b=G
 Dm10anZ4S/oRvUCCUb7CZsspYFFu3k3wDCsRf4LpMdRpNpIA0a4P0mu7+puZw2bVgJa5soDVicc7+
 R+rLpgfXtovCC20TOIVX7RX2aP2WGBqQvldzI9ZA/T+cVDG23lPT12HNcRXFGynbSldvXAj9e9bSy
 VEv0Mvw08FT1ZnR0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AfW67c+TPC7xtoa0pu6YIAXuLkLPiDlqm9ZAlxjD5eA=; b=fq+xZa2bY1pMMRWqWvu3oakdT8
 3uktchtk1oBhzDUPBZmrjEQC2ZxKtRvbOW8qj3YAMdEFF8Suic+6g7Tjqf7kcmy44iTXu54PbuylR
 dX6NNrUJzjQQkiLWZrwT+hR4zixHXv4IXJCy2N8WB1zMJHC68KvAh7Dm0gtNJn6WbdNw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPNoz-000000003x6-1SFD for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 17:33:51 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A6HXgY5095036;
 Fri, 6 Nov 2026 18:33:42 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A6HXgwX095035;
 Fri, 6 Nov 2026 18:33:42 +0100 (CET) (envelope-from gert)
Date: Fri, 6 Nov 2026 18:33:42 +0100 (CET)
Message-Id: <202611061733.6A6HXgwX095035@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261106131044.16659-1-gert@greenie.muc.de>
References: <20261106131044.16659-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xPNoz-000000003x6-1SFD
Subject: [Openvpn-devel] [PATCH applied] Re: Move gc from openvpn_net_ctx_t
 to local variables
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

Having a central gc in the ctx was definitely less overhead than 
create/destroy a local gc for every single call (v1) - but using the 
already-existing argv.gc is a nice way to circumstep the whole topic ;-)

Tested via t_client on a Linux build with --enable-iproute2, which
nicely excercises all these code paths.

Definitely not a bugfix or user visible enhancement, so not 2.7.

Your patch has been applied to the master branch.

commit 612c2203b19d58de952b65d0a1860487dc7e00c6 (master)
Author: Arne Schwabe
Date:   Fri Nov 6 14:10:39 2026 +0100

     Move gc from openvpn_net_ctx_t to local variables

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2105
     Message-Id: <20261106131044.16659-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261106131044.16659-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
