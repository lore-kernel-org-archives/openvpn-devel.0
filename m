Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3A2C88E40
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CJ8EVGkkKjcG/5MKafnhOsJRr5OwqLxpRK4Zh4SeBzA=; b=QqxtrW5HA/IZ1Gbz3f9yaTV53Y
	4Qlhh5ZVpEoK4ksIAa+77LAuBePA1qtuPM6ufBPqHjPYx7y+Qm/2s7gorMtBH0XwJ2ARkKzAT2ZWl
	6rzA+sR3196IllXeXJeaUhP6eLWetSUlPDY1ORQRVBQydXV3ChCD8WFeueQ9nXdUUwPk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5gU6-0007F1-M9;
	Sun, 13 Sep 2026 09:26:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x5gU5-0007Eu-UV
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:26:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U8+A985VsvrgoiyMg/Rc+lH2oWA3O/d+gidesHvr4mc=; b=NyfAWT1hLGoF9ooSgLsq2iZ6n6
 3Pr3HNzrUp5gWIrsdkdjSNL/2YIXn9OUvzJKyMBeF7F3Z98OP5Dnl3um1fj3ikP3ukubo0Sl0gKqX
 m1ZjkfZ7amv7tQpUWj0n8JXIOa7yjnXH/WBs/eEfi8YEV9S/c1bxtFShBbHgmBXaT1hE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U8+A985VsvrgoiyMg/Rc+lH2oWA3O/d+gidesHvr4mc=; b=BSpyqzmyaJJP8cLEYTh09QgOEa
 rSSdanPXGYcYBrgDGwkxJ3k0OZotctlQqGagYQx5z5t3oRvnZtoz3xNlNMgNtzKLWOY4Dww0bP4gD
 49ahzU2RSEuY/NVoZf0mZ2tuVX0dTKJx/5gGJUv9yqFYdPzUBf5tLKwwWUc1ywtFEocs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5gU4-0004es-GR for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:26:49 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68D9QfKA084797;
 Sun, 13 Sep 2026 11:26:41 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68D9QfE1084796;
 Sun, 13 Sep 2026 11:26:41 +0200 (CEST) (envelope-from gert)
Date: Sun, 13 Sep 2026 11:26:41 +0200 (CEST)
Message-Id: <202609130926.68D9QfE1084796@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260912092917.27218-1-gert@greenie.muc.de>
References: <20260912092917.27218-1-gert@greenie.muc.de>
X-Headers-End: 1x5gU4-0004es-GR
Subject: [Openvpn-devel] [PATCH applied] Re: socket: factor out UDP socket
 creation and setup
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

I'm not really sure if this change *helps* understandability of the
resulting code - now we do the bind_local() thing for *some* sockets
in create_socket(), and for others in "...udp_configured()" - and ditto
for socket_apply_options()...

It took me quite a bit of staring at code to come to the conclusion
"for all possible variants, it should still do the same in the end"
(but I might have overlooked something).  t_client/t_server claim that
everything still works, though.

Also, reconstructing "ai" in create_socket_udp_configured() looks
just *wrong* if we have a perfectly fine addrinfo in the caller?  It
should not have any adverse effects, but still...


Your patch has been applied to the master branch.

commit af1f73dbe442b42b8a1addc614aa13c3485db266
Author: Lev Stipakov
Date:   Sat Sep 12 11:29:12 2026 +0200

     socket: factor out UDP socket creation and setup

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1910
     Message-Id: <20260912092917.27218-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39126.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
