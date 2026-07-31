Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6ABC5516F
	for <openvpn-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NDWNJQCpO42i6UsDVjuNlUmN/zfrAog7btw1GlbPf+4=; b=IaAuRDZlHS6a/kO18bv2CbkLb3
	Ey4JZSoGPXVMrVmErVq5CLzb3LWE3u5wKSnrtex7kLs1DMSBmIrEU1kDenj26+8o1Vi6DaPza+1il
	hJflUwxrC4tkvDLuVj2OE3XDyJfYrUkSK6jSTwKCvqAp+cLlPL8MZsem1nuxVmlkHm+k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wptY6-00060d-Ox;
	Fri, 31 Jul 2026 20:09:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wptY4-00060V-Mh
 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 20:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RAcRUwX0e4Fiu5RMyd1LMB1B90P4z1tMQFH5ttEjHnQ=; b=axwHs7wqwM0OH24ycxTkENisSB
 TU/YDqeLGPvqYpqB4qD044024rRcFkk3a4Jqu2tYSnGssE/krjvR7lS0DM5u7gjFmYZ4hl5D6fFlZ
 fhNr0oPl9cm50ZHnJOnElzrVSL6q+iiXBTwwdcDFxjjRmWRfH8vfSJwU8Ts851DySYCQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RAcRUwX0e4Fiu5RMyd1LMB1B90P4z1tMQFH5ttEjHnQ=; b=SIqliADCnNJhACh3IAWLk7Ltuu
 UFCcXwzuKJxt48N65gWHXuhHs7bLkVDj5xXkFZMJCBKZQTDAKIVBWiedk6T2R79GPg/kJlgSa6Zkp
 /2Z2ib5gdqCaslAAey2VehlbzttZorgQO+rCjNDlpGtbUCr3bglfMYY/k7hPaipoOYDQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wptXz-0006Mk-To for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 20:09:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66VK9KP1025612;
 Fri, 31 Jul 2026 22:09:20 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66VK9KBT025611;
 Fri, 31 Jul 2026 22:09:20 +0200 (CEST) (envelope-from gert)
Date: Fri, 31 Jul 2026 22:09:20 +0200 (CEST)
Message-Id: <202607312009.66VK9KBT025611@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260731114605.11596-1-gert@greenie.muc.de>
References: <20260731114605.11596-1-gert@greenie.muc.de>
X-Headers-End: 1wptXz-0006Mk-To
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: Ignore hard reset packets
 with a non-zero packet id
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

Applied this to my t_server testbed, and it nicely displays how the
server ignores the misbehaving client (patch in #1831)

Jul 31 20:02:56 gentoo tap-tcp-p2p[4964]: TLS Error: received P_CONTROL_HARD_RESET_CLIENT_V2 with packet id 1 from [AF_INET6]::ffff:194.97.140.21:14610 -- 0 was expected, ignoring packet
Jul 31 20:03:18 gentoo tap-tcp-p2p[4964]: TLS Error: received P_CONTROL_HARD_RESET_CLIENT_V2 with packet id 1 from [AF_INET6]2001:608:0:814::f000:21:33270 -- 0 was expected, ignoring packet

.. and all "9" instances (p2p tcp tls) are now succeeding.  Great :-)

Your patch has been applied to the master, release/2.7 and release/2.7
branch (bugfix).  Not backported to 2.5 as it's annoying but not very
critical.

commit d1e67f419f1ea9121d44fa4b91c59e7209785e57 (master)
commit 6d7685f41b0d3efad549543eae7081a1aa9e57f2 (release/2.7)
commit 6ad370fa03806a7bf73eda8384131bc6175e4e09 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Jul 31 13:45:54 2026 +0200

     ssl: Ignore hard reset packets with a non-zero packet id

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1832
     Message-Id: <20260731114605.11596-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38098.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
