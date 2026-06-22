Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F95FCDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T3rLBu/KAGkR2gxmG2m1GT1JXvN+Gn3BhZRiQsNUt3A=; b=KqvJ5mVqx9YFBgtk1ZTWZa9eke
	eksGzK5VmZGhIX2qXfACBvMceJsO1CaFOQyylAvrrTf9rlLCEpQ13EgeJ0gdnC6CgriLN3VZFP6pZ
	YjUTV7XfMaEs0haOariApKL9OUz1qsnSbfBl7zgJ7b/w/lW/d69lcQ1DIqoiq3T9uBEc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbfqg-0005Bo-S0;
	Mon, 22 Jun 2026 14:42:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wbfqM-0005BK-1r
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vX76wVceksV8w0fnhiFUzYRn6Pwr6lLhQuvp8pqbVcg=; b=m4XjCocacXL5/zL7rXLoqsMddS
 KWQMhTE2FVhGvPv1x0FZp5oP8+UiaD+RJOslqVoas1OCSDBizVzuCsV07mzRKlZaUutPPE2MN+7qN
 /+G+tFoYmxu5Q5qa1fXpav3npRB554bTshMNfYWbLKzWVE+vEqMb4hzzCtgDmbqtUVZc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vX76wVceksV8w0fnhiFUzYRn6Pwr6lLhQuvp8pqbVcg=; b=gMi3iMsAOOKjyrKfRT5Ff4+xvE
 hqcqaMT65IFmcVKtP9zaHY23uasS1J+jqw/K4YL9s6HIqCNlkpOhhXWqYM0UMM7LFltLHRnXhnHx9
 7oS8/RTvNtAqjfBE1Cs6wOaiafVy1DQHw0J94d1O4s2uGv3SENeLFFZEbcLSmNnFq85w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbfqJ-00051T-5z for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:41:45 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65MEfVCu071640;
 Mon, 22 Jun 2026 16:41:31 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65MEfVYu071639;
 Mon, 22 Jun 2026 16:41:31 +0200 (CEST) (envelope-from gert)
Date: Mon, 22 Jun 2026 16:41:31 +0200 (CEST)
Message-Id: <202606221441.65MEfVYu071639@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260622120856.21586-1-gert@greenie.muc.de>
References: <20260622120856.21586-1-gert@greenie.muc.de>
X-Headers-End: 1wbfqJ-00051T-5z
Subject: [Openvpn-devel] [PATCH applied] Re: options: fix use-after-free of
 DNS options on client connect
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Thanks for digging into this, and thanks Arne for the review - all these
GC-and-option-copy-magic is not exactly where I feel safe.  Anyway, this
said, I can confirm that it fixed the issue on OpenBSD, and passes my
t_server setup (which has multiple clients connecting...) just fine.

Your patch has been applied to the master and release/2.7 branch (bugfix).

The offending code is quite different in 2.6 (no copying around of
DNS and DHCP options) so I think the bugfix is not needed - at least I could
not reproduce the double-free()-assert on OpenBSD.

commit 97ec63372ab354ad48c89e73d1e37715679370ba (master)
commit 40a3bc951f64c6afe69c55afff9ff7a855b69097 (release/2.7)
Author: Antonio Quartulli
Date:   Mon Jun 22 14:08:51 2026 +0200

     options: fix use-after-free of DNS options on client connect

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1715
     Message-Id: <20260622120856.21586-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37230.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
