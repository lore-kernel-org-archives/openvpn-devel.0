Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94003606A31E
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LriB1Yto;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m5RyYhXG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L57fRhzo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ljnbXS65DHClVqI0FjlPVPhz6wqE5l3cPhGQNBdrbbc=; b=LriB1YtoyuzNv6
	0ps5oTuya/UoW3QyZSJpz6eZUb5NCMq0TQ7zNLy4JcxjngyL4ws+k+Uz2l1u/4oXetZLSUeo8NHl7
	38DxYe90H9hY0hOiXl2H7gJY+7ZpSw8Q5fIBToxkfrCvt0ZQdq7E2YZBkMjYSZvvo5N0TgpEVx9rp
	Mo0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMs78-00000000114-49i0;
	Fri, 30 Oct 2026 19:18:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xMs76-0000000010w-3VFg for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:18:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6JYIO4hl2/ztcXK9FXRwjW5bzg3fvt/jAaAgC+hVx1o=; b=m
 5RyYhXGN49a/UnA6K1hfgpQYtYCLuZXGISVHOGPL3W1O7ocnSRWChstdf6Pd6GDdZIef6ldCVoXok
 JI+bAppOKqJXjrqvkj1uBzUUw8x0H1SPa6s6QUmq6dpIHq6CMGu5KyGhAwRSmygKGDbWDwvwQA8/L
 34DHnA3c3oOdWoJo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6JYIO4hl2/ztcXK9FXRwjW5bzg3fvt/jAaAgC+hVx1o=; b=L57fRhzo0f50auptpSI9oE3JDN
 S14rsfcitCKNsgePIrETGMwOvCVJaNs3rap88FMcUrii8nkNAGo0b2i1OaDC44u1gyn5O+xbSXeRO
 /y5EywOy7LzZpg5kHxM1eHpddgh94/eueLhEWVx4r8EWtQ+UbYuscWAZet37zCxiShbg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMs75-000000006am-3dEQ for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:18:08 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69UJHt1b052392;
 Fri, 30 Oct 2026 20:17:55 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69UJHtjv052391;
 Fri, 30 Oct 2026 20:17:55 +0100 (CET) (envelope-from gert)
Date: Fri, 30 Oct 2026 20:17:55 +0100 (CET)
Message-Id: <202610301917.69UJHtjv052391@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261027130054.2283-1-gert@greenie.muc.de>
References: <20261027130054.2283-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xMs75-000000006am-3dEQ
Subject: [Openvpn-devel] [PATCH applied] Re: win32: pass the buffer size in
 bytes to get_openvpn_reg_value()
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

Confirmed, according to microsoft documentation

"[in, out, optional] pcbData

 A pointer to a variable that specifies the size of the buffer pointed
 to by the pvData parameter, in bytes. When the function returns,
 this variable contains the size of the data copied to pvData."

Your patch has been applied to the master and release/2.7 branch
(bugfix).

commit 2509ba899f8753f7f1d74812214f2847f9e7daaa (master)
commit bc0351235810e6417e95d6d209c17e1026496677 (release/2.7)
Author: Heiko Hund
Date:   Tue Oct 27 14:00:49 2026 +0100

     win32: pass the buffer size in bytes to get_openvpn_reg_value()

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2038
     Message-Id: <20261027130054.2283-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40198.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
