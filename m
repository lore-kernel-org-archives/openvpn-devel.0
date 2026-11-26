Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9A606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DbgbBMrf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j/Q5VBxS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QjlQzy4n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pcKmk3Ox7TyLUJ7fGwm4SWlSJaGJnw2KQvD3zIL08x8=; b=DbgbBMrfPmmIeO
	y5WYD4Smqs1bR8xXk6kTuyhcqKXQ0/w0hQeZmdjI2/x3CuZFi9q/2nompInUXs/Zx6HXeyBueGKgh
	+z+Tc1eTAUA9eUR8+Y9NBhNTzMDiojhwlzyb6pCIEGxw5skYtaHhbY3f0RyNX1020hpV5EKH0IDxY
	nic=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWWrA-000000001Jc-3wiv;
	Thu, 26 Nov 2026 10:37:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWWr9-000000001JT-3dUc for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:37:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+ptu0ZgEk0qn8rYKuA+PWj/CQ79ZdzBdLMDjWAEgKI8=; b=j
 /Q5VBxS/aauUESLkJ3NVKiXW/cnsti5gimEO5rmqE9bwNoJ1BTWK7tvKNbpO/1Pd5rddkmxrkxpz0
 jHGyGxAavEJQRo9ExjbPS11qxzKq6DKjyfbe6CnGXQ1KIXAdhtf1l69gYe3dwFEOYl4j8OGUd5vbS
 jTvMhPh+bB5HMCoc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+ptu0ZgEk0qn8rYKuA+PWj/CQ79ZdzBdLMDjWAEgKI8=; b=QjlQzy4n/gjg6c0bc0NkUSdfK7
 EImowDlPYq5ZIFphnw8Z2pmbYyV73jeKM9NH+21Ond9LNyLOwUfa2Md4R61VMCI1A4/8p8o8tyeZa
 xx6ujW4lD6igrzok0b0cgGFeNgYTsZr28fggTwDgTib6eUI/SgN+eXEpL9XGgne/0f7Q=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWWr7-000000007Dg-4AA1 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:37:35 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AQAbRLY011346;
 Thu, 26 Nov 2026 11:37:27 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQAbRWo011345;
 Thu, 26 Nov 2026 11:37:27 +0100 (CET) (envelope-from gert)
Date: Thu, 26 Nov 2026 11:37:27 +0100 (CET)
Message-Id: <202611261037.6AQAbRWo011345@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261120080412.4368-1-gert@greenie.muc.de>
References: <20261120080412.4368-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWWr7-000000007Dg-4AA1
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: check for a
 leading non-option in the startup data
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

Much simpler this way, thanks.  The linux manpage for wcsspn() is actually
a bit confusing, but the unit tests cover all variants, so fine.  And the
unit tests do pass ;-) - tested GHA on the 2.7 backport ("followup to
a bugfix in 2.7").

Your patch has been applied to the master and release/2.7 branch.

commit 85d36443381a87c68a2573b90d01fad8af807f8f (master)
commit 6dd103effe2a2b9c6de3febdf806da1f505072bc (release/2.7)
Author: Razvan Cojocaru
Date:   Fri Nov 20 09:04:04 2026 +0100

     openvpnserv: check for a leading non-option in the startup data

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2188
     Message-Id: <20261120080412.4368-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41709.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
