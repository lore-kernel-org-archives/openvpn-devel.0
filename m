Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E581BCD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MTnA4WlS5tTyefKiacJztgxLDRFSEOD1nEMbHGBfLUQ=; b=JNsDuX1bLDs4aaeKZf0smTLHEM
	FWq7O4vVy+scj6cNbazG3Owo729dyuDyB8od367tEi25fj3QvN76/6p4k1RQ0yTTf9KjLT/DhexGC
	/Euon6HZUgyYh9L/ns2BUHqcyMxL2aeGF91XMmAmvTbryhwsahM1s5f+XjH7UKA/A8oo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxJK-0003BX-4q;
	Tue, 09 Jun 2026 14:20:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wWxJI-0003BL-Tp
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:20:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gWRd6mN55ppSInlhGSmACaNObs8RAiW8SfTvw2JStXs=; b=lt1xmC42XtD1HytO0nsC/Saa1C
 0aGYPLfG7H0sSu+odtIhNODW7m7NtUkgw9ey6UFSLuIElGY2HJAEVBjjQLjw0HGgjccEiZSu3VObl
 ka7Nth6aBv9/JlYCis8UUv53w9u8fRR09iYe5Zy0mq3BX+w7b5SvyyVzmM2KYdb3gnG4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gWRd6mN55ppSInlhGSmACaNObs8RAiW8SfTvw2JStXs=; b=i/W7l3XLju86ZFXJsAJfCc5D7X
 3b/pOZfi/CvnK57DCvLi8yVM7qz98sPQoiM+FnL0BjkVdrlavKrThk87mag/IymMVA9hFfmP3wnVB
 ZOeShcA7crNm184wIq6HXrDj1PUrKPq2ZzZ+mi2ty5vCso0/upVIQcmk0m6cLiNpf7TM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWxJE-0001CE-4p for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:20:06 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6598i8o8049703;
 Tue, 9 Jun 2026 10:44:08 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6598i7a8049702;
 Tue, 9 Jun 2026 10:44:07 +0200 (CEST) (envelope-from gert)
Date: Tue, 9 Jun 2026 10:44:07 +0200 (CEST)
Message-Id: <202606090844.6598i7a8049702@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260520101152.17453-1-gert@greenie.muc.de>
References: <20260520101152.17453-1-gert@greenie.muc.de>
X-Headers-End: 1wWxJE-0001CE-4p
Subject: [Openvpn-devel] [PATCH applied] Re: Fix: port-share and
 multi-socket interaction
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

Tested this on master without the patch.  A config with two "local"
statements, one UDP, one TCP, and "port-share" will always fail with

   Jun  9 10:26:19 gentoo tun-tcp-p2mp[19994]: Options error: --port-share only works in TCP server mode (--proto values of tcp-server, tcp4-server, or tcp6-server)

(the order of "local" statements does not matter).  With the patch, it
will happily bind both ports and portshare works...

   2026-06-09 10:36:17 us=623614 tcp6-server:[2001:608:4:0:62e9:965e:fba9:3fef]:50046 Non-OpenVPN client protocol detected

The code change is also quite straightforward - instead of checking only
"ce->proto" (which might be anything here), we need to walk list of
sockets and see if there is "any tcp socket".  I also tested "2 TCP 
sockets", and port-share works on either of them.  Good :-)


Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 0d7ea983e4c92d4c2caf5077ed8e868744c72512 (master)
commit 06e71f0c5fb3e8bc5980ca10e062b0c571b9b071 (release/2.7)
Author: Gianmarco De Gregori
Date:   Wed May 20 12:11:44 2026 +0200

     Fix: port-share and multi-socket interaction

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1680
     Message-Id: <20260520101152.17453-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36986.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
