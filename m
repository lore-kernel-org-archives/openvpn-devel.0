Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32C0606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j0ZvreNh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PrIVWEYY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DgW5hryh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=41Tx4Ts72aNvnU0nqWYmUd40v8k0NzDvTEdg5iD9FnU=; b=j0ZvreNh9Cx9MB
	g1JmsAjkXEUEDXBByjUf/Y3k6u4MOvzrcXWAcYcgeZg828Rc+aB+ckKeAG+H/1o9coZmps2C88EMT
	1uc1r+gBrlfs3b2QkChKV1CAW327BJUrkoiU39d+Et/HuGqPDZLUVBoi5YaC5Mi/7okAV7OMHMF9O
	eqk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMr8b-000000000vb-1ikX;
	Fri, 30 Oct 2026 18:15:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xMr8Z-000000000vT-1ar3 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:15:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tWAW4k4eo7RySnIEJB+finnTIlq9u9CwZ2AYgyYvxos=; b=P
 rIVWEYYmkxBobjRL4hp6+W+yfOBHyF34tnlgg9NeVXEEA+kilCSFywM/whhLL7DhY2A6B+fgetIu8
 L9SrbavaQQ8TLuPBo4Tad3Tc+AhEUaUWj31Myl4H06hjJGf4iHKJ4sDGbyetxrJfOxmAq8BAp3LPa
 5VnDNpHvBOaRXmEM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tWAW4k4eo7RySnIEJB+finnTIlq9u9CwZ2AYgyYvxos=; b=DgW5hryhIzNnLcZnJM2TmES0ze
 l9hZ0L36wFJVZOTcYzfdLSZKzHNcGK47sUQ/XRRyLfLmcagG8xZVO0aPZ5qUeZXtUY/SmhBdhrtZO
 Il3r2MlGTemgVZvaEgQgkbV9gsgxyK3z0ODUGHGs80d9vqJdV/ZBjP8ZUf6xDnx09GDc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMr8W-000000000i1-3t8Y for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:15:35 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69UIFPq4049414;
 Fri, 30 Oct 2026 19:15:25 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69UIFPIX049413;
 Fri, 30 Oct 2026 19:15:25 +0100 (CET) (envelope-from gert)
Date: Fri, 30 Oct 2026 19:15:25 +0100 (CET)
Message-Id: <202610301815.69UIFPIX049413@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261027130751.2950-1-gert@greenie.muc.de>
References: <20261027130751.2950-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xMr8W-000000000i1-3t8Y
Subject: [Openvpn-devel] [PATCH applied] Re: mtcp: make set_global_rw_flags
 TCP only again
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

Thanks for taking on the multi* cleanup project :-) - and thanks to Razvan
for reviewing so many of these already.

I have not explicitly tested it, but since the code change basically only
takes away "arming of UDP sockets" and BB tests confirm that t_client
and t_server still succeeds, UDP sockets supposedly still work.

Your patch has been applied to the master branch.

commit 538fc7862eb89213d5abd60b7641dc4f4efc6967
Author: Gianmarco De Gregori
Date:   Tue Oct 27 14:07:46 2026 +0100

     mtcp: make set_global_rw_flags TCP only again

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2041
     Message-Id: <20261027130751.2950-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40199.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
