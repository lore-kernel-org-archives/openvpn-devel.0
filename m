Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09242CD98C7
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=suOVEziAFhTg7dxD0/P2kjZm9ZyEaGRUTCW2WCz51KU=; b=cOTGWurkDeTWrEOyqUJDfLqhUl
	M5y6OkQpXg6xD29G/dnRvZ2vIOBylnc+oYB8Xn6irGmbgl9ubhRxxVNe/81KThm5J1GfHN/L3PjuY
	2Klc43nNQRWVro+IhfJS8LM8bBT2qUN45MraPoRiDquuefQYZaSJIoHcx2c/YAkpfDhw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXPSX-0002A3-Ht;
	Wed, 10 Jun 2026 20:23:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wXPSV-00029w-UL
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:23:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n7lvzgdgzW7c9beqphgiAOiDfl4qh+4wOqmatQyKDjA=; b=A4pPQz98G5a792AEwMx3LW4rJt
 Tosph4y+XXZJPFvKF9sBKle9T+eWIWn3Yt7AMERRuyixDux5bsJXrPhZMy5XDdybJ+bbdL9HmmEZt
 z2PZBeVWsPybEn3Sz9BmPHIfzYVA93xoJFmReqGzd/oqaO88T7XumKdsgj3L8tgdDlxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n7lvzgdgzW7c9beqphgiAOiDfl4qh+4wOqmatQyKDjA=; b=Yo5UBX8iSn3MAuKB3h6QFL5EeC
 9W6SJBVZmJBT6ZqdjoSnbD1MhXjxU115lUebZz5sKeb/tm82a8upsnGVMtv8MQKUoT3arDUVjxnYi
 8wj+exAmMgMXzBaNg9MwwW8ZUFWZGoom+CvqSxI+7L83h26uvw4aLEm63i6BNKjyolsM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXPSP-000086-FA for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:23:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65AKN5BK006200;
 Wed, 10 Jun 2026 22:23:05 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65AKN5L2006199;
 Wed, 10 Jun 2026 22:23:05 +0200 (CEST) (envelope-from gert)
Date: Wed, 10 Jun 2026 22:23:05 +0200 (CEST)
Message-Id: <202606102023.65AKN5L2006199@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260609152123.27460-1-gert@greenie.muc.de>
References: <20260609152123.27460-1-gert@greenie.muc.de>
X-Headers-End: 1wXPSP-000086-FA
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Switch to using VS 2026
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

Again, no code change, just CI/build infra...

Tested for obvious build fails in my GH repo.

Your patch has been applied to the master and release/2.7 branch
(long term CI infra maint).

commit 90499e51237cd11f813206371b7ba5176d8eb5ef (master)
commit 60e2866255a1f7362776860fd3c7b735e9e6a9ed (HEAD -> release/2.7)
Author: Frank Lichtenheld
Date:   Tue Jun 9 17:21:17 2026 +0200

     GHA: Switch to using VS 2026

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1711
     Message-Id: <20260609152123.27460-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37139.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
