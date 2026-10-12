Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747CACA9ED2
	for <openvpn-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36TmgVHQyu4kP5wMQIX0PTMtsQO17lKJ34QErgLukHo=; b=GWenVXOtvtGRTo83zXBOB62Hmw
	9a4asFK7vmdUB4ajMVVOYBQdyUEeVVR157Jl4TDlHEIFfLNF2muygi+ZbypCxWZt19jS0pd2D7ZkG
	x5qKAeCA2izurp3aHSD3nn8umOlpvyVpk02xSqb9+7waazqZ4fAE+Sa7bx6LyvxCwMa4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGMCt-0001K1-Bu;
	Mon, 12 Oct 2026 20:01:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xGMCs-0001Ju-5g
 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 20:01:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ThGenG8WaRT7uYsrmdUvlI2I8IfOYnNOLQ20xLg+Va4=; b=X9wvQ123CYCs1/qukgeSH7wuOT
 ziUrnAVTDe5uKUK9IAiNnOuGEzIfBK2CMpFrhp3a876gtgQi9MQuXsZXnzyEpRKd/umhRZ24SyVkR
 Zd+Smf71ywq0vnLxvUBd8eJNU6UF/+gRL1Dqg9r4IcuJP+h2Pfd6lVGF9GP1fAX7X+xc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ThGenG8WaRT7uYsrmdUvlI2I8IfOYnNOLQ20xLg+Va4=; b=DE3eoe07yflOa5Gc4OeEv394UV
 uwBDddpLoVEeAHNw8CF5iYwhqVv4KnwGlYe5yepoeMSKiZvRz3u9w6PaFaOhqyJ36bJBYwJnpwZGy
 5MSgXysOjui5MVCHRK1yZ0ksZss4C0cccOjjHZvgE5Tk2mlyLOVDQZRMhNznpEvu9aFg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGMCq-0004Sf-CW for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 20:01:10 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69CK0xdW072071;
 Mon, 12 Oct 2026 22:00:59 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69CK0xKa072070;
 Mon, 12 Oct 2026 22:00:59 +0200 (CEST) (envelope-from gert)
Date: Mon, 12 Oct 2026 22:00:59 +0200 (CEST)
Message-Id: <202610122000.69CK0xKa072070@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Drew Blokzyl <drew@linuxkids.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261012102657.13611-1-gert@greenie.muc.de>
References: <20261012102657.13611-1-gert@greenie.muc.de>
X-Headers-End: 1xGMCq-0004Sf-CW
Subject: [Openvpn-devel] [PATCH applied] Re: Make CRL reload EOF detection
 independent of stale error queue entries
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

Thanks for cleaning these bits...

I have only stared lightly at the patch, and it seems to do "the right
thing" here.  Razvan and Arne have stared harder :-)

(I'm applying these out of sequence - this will now trigger the warning
message as "the other part" is not in yet, but it should still fix the
EOF detection problem)

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 15a1465f981bb3f1950056a8f82b91dfe5f3fdbc (master)
commit 51b87233cc315a51c0a612902928886985da1b1f (release/2.7)
Author: Drew Blokzyl
Date:   Mon Oct 12 12:26:47 2026 +0200

     Make CRL reload EOF detection independent of stale error queue entries

     Signed-off-by: Drew Blokzyl <drew@linuxkids.com>
     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1990
     Message-Id: <20261012102657.13611-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39839.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
