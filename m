Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C34CA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JyPF6r0tSYJSZau076FCLdVasv+hAxUmRti1pxFdpvs=; b=ZA7EO7Vhmosf9SaowZuR9pF7D/
	uebyLJlKBg5IFkLsX48CL4ale8geW1A6EfCUCrtg2CK+DysaKviLi1C3Uq6xC9OfuFoAs5p8I8BiN
	n/jctk7UhHTECbLg6Di261fudL9dju2LIjPsKMjPAX6oQ5srJfGcKqOIt3kaJd8Xkhnk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDIFx-0002EU-Kq;
	Sun, 04 Oct 2026 09:11:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xDIFw-0002EM-GN
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:11:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zA/R7k2GF7y2e+Lj4+iqNW/jgDVbhcU0RozeSHSOM68=; b=YOOhG3hlVZzoErKMn0O0HSN/Rf
 qwpV4rYHAjXwyvl0MpPiy9ZPYo6wtU4mN1USDHm10I25BUq68IGxabWnQlXEn5O/mqmh+9yQQ54GD
 o9dP6WjkitIscrX6T5zvV31ZKEYDC1pNeeU0ffjUNpFx7clnB/Flc2Q5H9kv6zYWFdl0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zA/R7k2GF7y2e+Lj4+iqNW/jgDVbhcU0RozeSHSOM68=; b=KaxfsAdvVsDqmewbInJurz+xib
 yJDrVQhiQYDJPxzsKI0Xf8Zyj2z/FQIpe40VFlkKq7nBmFUmuRj1VhI2nv0+Gudp5kuSh3UKUvCkO
 bBSppx4gB6aNhF+NPrpuMJzFIjgewPU+RCoTVs3Yi7vltS166iBv8dmJVLBbUAjWWQv0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDIFw-0005Lx-AQ for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:11:41 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6949BQol087221;
 Sun, 4 Oct 2026 11:11:26 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6949BQNw087220;
 Sun, 4 Oct 2026 11:11:26 +0200 (CEST) (envelope-from gert)
Date: Sun, 4 Oct 2026 11:11:26 +0200 (CEST)
Message-Id: <202610040911.6949BQNw087220@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261003204151.19347-1-gert@greenie.muc.de>
References: <20261003204151.19347-1-gert@greenie.muc.de>
X-Headers-End: 1xDIFw-0005Lx-AQ
Subject: [Openvpn-devel] [PATCH applied] Re: Fix all occurrences of cppcheck
 invalidPrintfArgType_uint
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

Same as for the last one - looks good, +2 from Razvan, BB all green, and
I'll pay for applying patches out of sequence... ;-)

Your patch has been applied to the master branch.

commit 4864b83c900e615d2e8e2bd2d73d60474a0a1bae
Author: Frank Lichtenheld
Date:   Sat Oct 3 22:41:45 2026 +0200

     Fix all occurrences of cppcheck invalidPrintfArgType_uint

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1960
     Message-Id: <20261003204151.19347-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39677.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
