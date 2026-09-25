Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A73C9832A
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CaVj1XFvku3g/N89VwCVOtFSzKWHi72Ekwcbm6sLvmI=; b=Okn+j/TET77/T1roqS0sO51wbx
	x3tjj6XrKg3IHwcvsRx0KF7HJkoIMKVg+vSEI+1KrWrGaqfIKNzuu1tSM3Fl/JdkKtYkH2TaNufON
	p2EIwmgPCGD5TvHYN0mepZsMzQyKt71QSsmY74XvQ0neJmrWyR/31RcgVFUaYpT0EkV8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xADth-0001jR-Ld;
	Fri, 25 Sep 2026 21:56:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xADth-0001jL-6W
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 21:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JM2ZVE2R4BWDXwgp4NKjI4CAQTe0dcieAwS7+jYFnHs=; b=c1C2cLNY6HthfZ/tdkHp6LqZY7
 LJCdskG0Y/sA/6Gzsfl4+PE4r081pDWSzoEcRvveqYOOZSX3VMiB/Ccy0KsNZGF0ACMaNq+8Votlf
 fRUZIbpeaD+qdn6xQ7HtMgfXwck0RERVnabtTZZu+upV2gmHLYaRIR7phlrNL5w3K3t4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JM2ZVE2R4BWDXwgp4NKjI4CAQTe0dcieAwS7+jYFnHs=; b=L62SfCFW7g+xgzCis/go1Gwx8l
 N0YDFqmn//QVDEtQL1ZxhioiME+BDV6J2cQDrrJeGZYb88REhPtP15t/UcD2NLsEtpJeJbzJ85Ee7
 RLXQFtPprMACawdvCQz4I2f5yi8hF3vOHrQ0JmXz8V3cNLNvYXm4/8jyaqZ7YS5yiijE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xADtg-0000s4-1Z for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 21:56:01 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68PLtrdD027902;
 Fri, 25 Sep 2026 23:55:53 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68PLtr4k027901;
 Fri, 25 Sep 2026 23:55:53 +0200 (CEST) (envelope-from gert)
Date: Fri, 25 Sep 2026 23:55:53 +0200 (CEST)
Message-Id: <202609252155.68PLtr4k027901@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260925131830.10902-1-gert@greenie.muc.de>
References: <20260925131830.10902-1-gert@greenie.muc.de>
X-Headers-End: 1xADtg-0000s4-1Z
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: drop the
 now-redundant __is_locked re-entrancy guard
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

Indeed, since the previous patch has resolved the concurrency issues
by splitting request/response and notification socket, locking against
a recursion "on the same socket" is no longer needed because it can no
longer happen.  Simpler code, less surprises ;-)

(That said, the split of ovpn_nl_recvmsgs() and ..._report() introduced
by 1737 is now obsolete again, and could be reverted...)

Tested on the DCO t_server testbed, with "well behaved" clients, and
with a gremlin horde.

Your patch has been applied to the master and release/2.7 branch
(considered part of the larger bugfix).

commit e6670b335b99bed5810cf2d0465279e208d14462 (master)
commit 028acc7ccb3a1385f5c067cab0c58fec8f1fccf4 (release/2.7)
Author: Antonio Quartulli
Date:   Fri Sep 25 15:18:24 2026 +0200

     dco_linux: drop the now-redundant __is_locked re-entrancy guard

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1738
     Message-Id: <20260925131830.10902-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39499.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
