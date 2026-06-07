Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DE0CD8C89
	for <openvpn-devel@archiver.kernel.org>; Sun,  7 Jun 2026 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tDS8sG26hbN65jwwKiGeqxvDqXPHt0/mMSyin1vCw+c=; b=IdY9ye5oaagVBNAaBxpI7aml9k
	9S948Tw55PQALDqfT7XGUDz/LwsmWV0UqTPsQkqthZSTCv5NJvKxQM1NDYfOJPPFnsfmT8dZ73dNp
	K6NPpgAzR8hSc/0DUUP47r1+k+oEKyiujDtu4VtM9hCGf1BzvKVamyqHpQn66aQpF+PQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWGhP-0001zl-7T;
	Sun, 07 Jun 2026 16:50:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wWGhN-0001zd-5K
 for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 16:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MrssfShXwMi3qOVA06r49ywkOL15MsTTsYQlKtBwNZY=; b=aTDfXvJMF+VV/V2DYdCVEHRLfP
 Y1TfqAXJp+M5W4lrM3JCzWYLC+10rpG2xY9MxRTj0Ha6LtgE3FseRORXggxZ9bisq1ISTgmUwgp3Z
 KodySFLLnBKz7+LFLusuZGZRO/ZWNIlC+CpUO05G5R1SobJqTjz5X9dpe4ZlbSOsc6w8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MrssfShXwMi3qOVA06r49ywkOL15MsTTsYQlKtBwNZY=; b=PeJn1mHyjkNTqiGIHReYAYdZue
 ujoX8UlcfTWCqdxvbnPURKZ/CyusLVmNxJyvmnks442/ya++ElOU5G6rj8TyFQWhV06WfGHsPhuU7
 CPuWE4FO53vkJHQVI9E2V5hxCp+Kvt9lDGjtMtWYGJCzaFq6lOCbIucBJaSvENt7Z6Ko=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWGhL-0008U8-OM for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 16:50:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 657Go1ob004319;
 Sun, 7 Jun 2026 18:50:01 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 657Go0dg004318;
 Sun, 7 Jun 2026 18:50:00 +0200 (CEST) (envelope-from gert)
Date: Sun, 7 Jun 2026 18:50:00 +0200 (CEST)
Message-Id: <202606071650.657Go0dg004318@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Marco Baffo <marco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260605181053.3774-1-gert@greenie.muc.de>
References: <20260605181053.3774-1-gert@greenie.muc.de>
X-Headers-End: 1wWGhL-0008U8-OM
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: allow passing
 KEEPALIVE_TIMEOUT without KEEPALIVE_INTERVAL
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

On the userland side, this is fairly trivial and straightforward - when
deciding whether to call dco_set_peer(), take "ping_rec_timeout" into
account (which gets set by "ping-restart" and "ping-exit").  The more
interesting change is kernel-side, to decouple "ping" and "ping-restart"
settings (but that's a different patch for different people to review).

Stared-at-code, test compiled on Linux.

Applying this to release/2.7 as well, because it is very much non-intrusive,
and people have stumbled across this (so "mini bugfix").

Your patch has been applied to the master and release/2.7 branch.

commit d66de4e0a461c8cc5fff5a00ec14b41dd27fc365 (master)
commit 4b49192f980a7a8fb63c74b30c2be631aaa2eb38 (release/2.7)
Author: Marco Baffo
Date:   Fri Jun 5 20:10:46 2026 +0200

     dco_linux: allow passing KEEPALIVE_TIMEOUT without KEEPALIVE_INTERVAL

     Signed-off-by: Marco Baffo <marco@mandelbit.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1705
     Message-Id: <20260605181053.3774-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37070.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
