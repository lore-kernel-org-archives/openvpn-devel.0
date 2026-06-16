Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F201CD98E1
	for <openvpn-devel@archiver.kernel.org>; Tue, 16 Jun 2026 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DmKmEZBmaLLZIy6SkTwA8a0VMdtnhvjov9fkK8xzZQA=; b=SDmWA29KzXjgQ5SOTvYP84g3Wc
	23d/YMlyeWuVFrxxMP9W4zxYApFZbuX1A5S1eQvj2c8hZQt3TgDeZ7J7TuQMGyt0jStS0lhtO/5En
	skvgPEnit9G7/r0ZIJWf76gJy7dz2EFuJwPtXxcl5dZ/oMRGQLiytbiEEAk4eIKFSqSs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZaHI-0008Cn-30;
	Tue, 16 Jun 2026 20:20:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wZaH8-0008Cc-Jd
 for openvpn-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 20:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eGU6FDSYEbPyh+IhtwD7HheEzGrJUGtASXSRbwuq+78=; b=L7BiUs2Kd0F3Nj/dB7qrpopBy6
 sKOQ1vPF+HCeL4VqAnIIaN9qjDbVKtgjOl4dT0YL4N/06TpB666IOgKfC7b7KseW1NtTJ7Fp2Rb+c
 r/BklU7JptWmXfC6BYPB5Q+/0m7qTEWKbtDRk+3q44Rhwo39a5w37oYcPPg7lP1sL+oo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eGU6FDSYEbPyh+IhtwD7HheEzGrJUGtASXSRbwuq+78=; b=HoLx/RsN8pdSYWVpVlB+HIqVqu
 FDASg1/wD9oHg4l7N2mEq5XKOuh1TAIMKx6P22/8YWtmCwg+gBR8nvKf9CI5itJkXV86TYUVPPJ+r
 Qr4rTpHTcZglOnyyRxSzeqNL68oOxoGUQOgvI6W48PolprAa9m08yIYU55T4+cHnyk4w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZaH6-0000Ip-0k for openvpn-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 20:20:46 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65GKKWUY053088;
 Tue, 16 Jun 2026 22:20:32 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65GKKWWY053087;
 Tue, 16 Jun 2026 22:20:32 +0200 (CEST) (envelope-from gert)
Date: Tue, 16 Jun 2026 22:20:32 +0200 (CEST)
Message-Id: <202606162020.65GKKWWY053087@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260616162129.28519-1-gert@greenie.muc.de>
References: <20260616162129.28519-1-gert@greenie.muc.de>
X-Headers-End: 1wZaH6-0000Ip-0k
Subject: [Openvpn-devel] [PATCH applied] Re: Multisocket: use event engine
 rwflags for UDP I/O
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

So there was this function that looked slightly odd after the multisocket
event changes, and in the process from v1 to v7 in this patch, the offending
code ("udp_flags = ES_ERROR") got thrown out completely ;-)

I won't claim I understand most of the event / flags magic here, but this
part seems far more understandable than before now, and it seems to do
the right thing dealing with a socket array, correlating "we have a 
pending multi instance" with "what socket to send the packet out?".

Some further surgery to p2mp_iow_flags() and multi_io_wait() might
make this even better :-) (include the first in the caller, and get
rid of the has_udp_in_local_list() outer check) - but this is future
work.

*This* has been tested across multiple version on the t_server testbed
(and everything works), and I understand Gianmarco has fed it to the
gremlins and nothing crashed either.  This is about as good as it gets,
I think...

Your patch has been applied to the master and release/2.7 branch.

commit 1281d264a259bf8e95695bbb831737a4778d4afa (master)
commit ae5083017d70c695813cd7974d1fabbf0eb7307a (release/2.7)
Author: Gianmarco De Gregori
Date:   Tue Jun 16 18:21:23 2026 +0200

     Multisocket: use event engine rwflags for UDP I/O

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1635
     Message-Id: <20260616162129.28519-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37198.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
