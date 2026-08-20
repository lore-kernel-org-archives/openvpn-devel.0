Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67FBC5DF87
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h6M32bxCWHL4hR5xOCDyZHsANWnGPfcu1TC2D723uG0=; b=aAyV7uREzSKOT6Kz1pzNFwxfTS
	kWCin9ZBVXAKeI46wgk/ciOb9ucX2GCpKlI90EB6jyU1lgeUnA1HgrX654oR6VYu26KDtr9Peod3I
	cPYmZBHoBZUoYjlUjoMFKfWvhlDEvV61bfiqaYWrCMDvf+j3Oga+p9Y3JamCSXhdRFnw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx0SE-0005Lp-Ih;
	Thu, 20 Aug 2026 10:57:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wx0SD-0005Lj-Fp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:56:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+xMRnFPdtNtBonFqTee7e/znXlaXEpTIHWCg4Fj6QGw=; b=ZkAARBKO9pkNPtZeEEN7rJjpyo
 1wtQknElr6qCauO0gWD5IKTizuKD2roG7mFvUppe9gURIRwvQHx7tGbkhSHY7EhRCM5qB5nYndBKC
 DCF5QhSPAUnRkChJwT62afn/kPp1YezaOOwoNWYqCR8MhaxgBuZOhX9+xsKQ9rRlUK7c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+xMRnFPdtNtBonFqTee7e/znXlaXEpTIHWCg4Fj6QGw=; b=c14LY5gAqDci8jid1G0Sj5Y066
 hjCImxKQp0097t5faKlkXy5NEdDh440iowBUKSEvIdnhu3zq8G+IvpVIzQ0ouVOVnZRllOVwXYlts
 i5vm6NgZ2VKQ48Ucb0+Lx+qRk2O1mX1aelTgI704YjaS+vz5nryK7TK6wc6uxOIzRy+U=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wx0S8-0006OE-U7 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:56:58 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67KAughF062704;
 Thu, 20 Aug 2026 12:56:42 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67KAugkq062703;
 Thu, 20 Aug 2026 12:56:42 +0200 (CEST) (envelope-from gert)
Date: Thu, 20 Aug 2026 12:56:42 +0200 (CEST)
Message-Id: <202608201056.67KAugkq062703@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260820091615.4656-1-gert@greenie.muc.de>
References: <20260820091615.4656-1-gert@greenie.muc.de>
X-Headers-End: 1wx0S8-0006OE-U7
Subject: [Openvpn-devel] [PATCH applied] Re: reformat-shell.sh: Add
 --simplify argument
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

Interesting shell caveat here... I'm too old for $((this)) newfangled
construct, but it seems it's full of unknown magic :-)

The change looks reasonable, and the test scripts still work - seeing
t_server_null.sh still count instances properly is simple proof.

Your patch has been applied to the master branch.

commit ed427eab1683af3adf21553dd1c6b6e4b8b2f10d
Author: Frank Lichtenheld
Date:   Thu Aug 20 11:16:09 2026 +0200

     reformat-shell.sh: Add --simplify argument

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1794
     Message-Id: <20260820091615.4656-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38548.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
