Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5238CD8CB2
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3gDaaagcr80axZiyIlKeh4c2Op6h+Baz27VZUGzkpaw=; b=Cex45LFTdOHrGriunUr+NIo9kt
	W062BqnACXTv9uu5UEt7o/V6Wf1coAqbfpXiIYDVX+RMGcot4DS1RvZyCFZCjsPRAXZ7POUCssohP
	ppMd2mcW58/Te/YRNc84LdUq9htcaOsSKycddYBrVfahXbTiBSCH7PZHsGwkBI1BKNMk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXM6p-0006lZ-ST;
	Wed, 10 Jun 2026 16:48:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wXM6l-0006l4-HJ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 16:48:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FxwBgwJKrOoZErxmyL2xdDdHtK1yoJBJG+MQEgYpSik=; b=dklZ6uMg4Sz9kpDXzs7VhDAAO9
 rpwwRbJ+UDBct4VWgF0Vgd6GCna4J/ua+KgT3kdbSDph8Xi+B601fuF1FB/D8TcsyNKHg3CTwlpXA
 xrKjKH+iDyJ2IzrekoB4FLkyj9ZxK5HdZmePZtOW5rB2VbpLTnLIR7cb5exo0MaCxIO4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FxwBgwJKrOoZErxmyL2xdDdHtK1yoJBJG+MQEgYpSik=; b=GeZjgPwjdPhw4eKv2Bj1SP8KMH
 swrcFkCdMuc7MyUdxOAihfWA6Cyr6ti0YpucoG+WhhXbXzy5XxiUEkeAuIn60OLoA5pOLqv97kWWW
 DXha0opFi/TT84YRXCN/0olIn7g3qu99Nn1qBZyb9X0wMzZ6mRpOzHMrwRXYVee6Ck6s=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXM6j-0004Jn-FN for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 16:48:52 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65AGmcdU001930;
 Wed, 10 Jun 2026 18:48:38 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65AGmcXu001928;
 Wed, 10 Jun 2026 18:48:38 +0200 (CEST) (envelope-from gert)
Date: Wed, 10 Jun 2026 18:48:38 +0200 (CEST)
Message-Id: <202606101648.65AGmcXu001928@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260609075413.17380-1-gert@greenie.muc.de>
References: <20260609075413.17380-1-gert@greenie.muc.de>
X-Headers-End: 1wXM6j-0004Jn-FN
Subject: [Openvpn-devel] [PATCH applied] Re: mudp: send HMAC reset reply
 synchronously
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

So, the need for this is "not directly obvious", because, "everything
works fine", no...?

Discussed this on IRC with Antonio and Gianmarco, and the finding they
made is that basically this is just working by accident, given that the
event handler does not work really well for setups with multiple UDP
sockets having activity at the same time.  Gerrit#1635 sets out to fix
this - and uncovers that our "initial packet reply" code is misbehaving,
so if you have multiple sockets receiving RESET packets at the same time,
replies get sent to the wrong address.  Very bad.

Now, to trigger this, you need to actually have multiple sockets at
the same time, *and* lots of concurrent connection activities - which
is not very typical at steady state, but after restarting a busy server,
this might get hit.

I have stared at it "and it seems to make sense", and also my t_server
testbed passes all server side tests just fine - so it's not breaking
anything ;-) - also, Arne had a close look and since he understands the
initial handshake bits best, if he's fine, so am I.

(v2 differs from v1 only in comment and msg() placement, the
actual patch is the same)

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 9bad30f6d9884d48db57106ce078bfd7b2a73df9 (master)
commit dd26557a8f88cc324e4c10915536687549a50283 (release/2.7)
Author: Antonio Quartulli
Date:   Tue Jun 9 09:54:07 2026 +0200

     mudp: send HMAC reset reply synchronously

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1702
     Message-Id: <20260609075413.17380-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37117.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
