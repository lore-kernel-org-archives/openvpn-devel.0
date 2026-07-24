Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1153C531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yjy/uGNu8iCUOt6U9WgqJffBDPQ9gwWbQ3bWHBck/wE=; b=Ryzjro9lpR5BTU/7Q3TK0COT0P
	bJ2If0uQlmin0z7TmHdNXcDN+5fGAq2NKmcrppX+2pRV6pt8UDwb9DjVPQXChwhXRCMeySgdr1aIy
	oaQoltIi20iqEAUNGsHGrrGApPXGJjAULx8nbR6b1wLwMhNQfOkSW4/GaxC5B7t0z7B8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIzE-00070f-Kr;
	Fri, 24 Jul 2026 16:43:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wnIzD-00070X-QK
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:43:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RU0RVtJBUOgRENVzOf3O5KeRXpPzIWmzjvvC/mWqqhw=; b=lN/5f1RKkWMwi2+llCCi8ynCX7
 YvbeZu8bKUf12ilCaHciF70vAI4GPz+jsAEhdw952CvN5onxu3EF0uejKIMOspgL6QBVwbyRG01hF
 GpNbmoeAod5TJ/CfRb/hx53HnrRSFohmQlfzBH49AQviQ1T/AqJ6Mrdf2Mx+7OLiS5eY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RU0RVtJBUOgRENVzOf3O5KeRXpPzIWmzjvvC/mWqqhw=; b=h+jMBXyEdQVy8BXwrldZeoFUvL
 Ul6laxtMlMHxQGIoFMr0CyPstu24NyWOLqmPQzMt1iYaiJCnWyvOHNqfbyye38Po51TMxfLQRDbrt
 Q6JywNrnPfVY7AIBfSPXtWnkt4V0cFSbyH11CCnZhmQ0XcBmlSG4C2+yp7GnKMZv2aWo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnIzG-0007N3-UU for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:43:00 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66OGgqAA049556;
 Fri, 24 Jul 2026 18:42:52 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66OGgqPV049555;
 Fri, 24 Jul 2026 18:42:52 +0200 (CEST) (envelope-from gert)
Date: Fri, 24 Jul 2026 18:42:52 +0200 (CEST)
Message-Id: <202607241642.66OGgqPV049555@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260724055529.1376-1-gert@greenie.muc.de>
References: <20260724055529.1376-1-gert@greenie.muc.de>
X-Headers-End: 1wnIzG-0007N3-UU
Subject: [Openvpn-devel] [PATCH applied] Re: options: make 'tun' the default
 for '--dev'
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

This is nice, as it reduces the amount of stuff really needed in a client
config even further... :-) - and it's really minimal, most of the patch
is documentation / example file updates.  BB says this works across
all platforms, even better.  I just tested linux (unsurprisingly, works).

Your patch has been applied to the master and release/2.7 branch
("mini feature, non intrusive").

commit a6537f7549f70f16bb2efd5c0683e0e94a236f0c (master)
commit c2a1de5e3b88049692a00560a88418f4eb35ba0e (release/2.7)
Author: Antonio Quartulli
Date:   Fri Jul 24 07:55:23 2026 +0200

     options: make 'tun' the default for '--dev'

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1537
     Message-Id: <20260724055529.1376-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37825.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
