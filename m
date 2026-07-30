Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E1EC5516D
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uZeHfUnsy4qGdnNaNyj1nRAhajc2pr9YCZs9oQ30Tak=; b=FD5hw1rODVK8WykxTOBLvE7ubU
	+YEuz+VgSJV/afP5qcW1NMW+StbAwFKrdKVE7qeCaVDlOLcRLlLXliRr8iKOICy2B9wm5Kns2M3qZ
	z2h6+Kf/RKxcRD+N22Aaz/8y+c0HBC/dCH4Y6D4E9rGu9tb3CC2YgWJkPn40CB6QGcCw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpXVc-0007hF-Gg;
	Thu, 30 Jul 2026 20:37:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wpXVa-0007h9-RT
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:37:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T3LRjufub5edv75qGnRbjz0yDxZ4bSiLrrtIs1THv28=; b=gnGYxMbwzZJC2ogI8CfCY4loHV
 JeePo54jVTdeVJK855jcOeDcY2jUGvJyouBz0zMiOM3Z9qLYNSSMWzsvVW8Bewp/tQqZ9Z0ozgmUF
 HE2JxJZwwN5lV5LqDYKUwalWmGxIn7K40+3UjZTHeWI4Lsf4pKEqVIOEviGoGGXc/8fY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=T3LRjufub5edv75qGnRbjz0yDxZ4bSiLrrtIs1THv28=; b=fzD5HJSx4yIaM3OnvDPhu8PaC5
 BeC5lAEtAETsu7EpHbQS+IGmlFZoauNNEJequ5Lu3mjvRSbuowEj8DMjLB+0LIHllhqRB8bbdbN3T
 te1igkf8L/nVE7rt9F8AzlYD4B2dhhGX3Lmg4faOuqL57SXfzIPtkBqJE4X20C6a0PjA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpXVZ-0006wn-L4 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:37:39 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66UKbMGF074506;
 Thu, 30 Jul 2026 22:37:22 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66UKbM3p074505;
 Thu, 30 Jul 2026 22:37:22 +0200 (CEST) (envelope-from gert)
Date: Thu, 30 Jul 2026 22:37:22 +0200 (CEST)
Message-Id: <202607302037.66UKbM3p074505@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260728063652.10456-1-gert@greenie.muc.de>
References: <20260728063652.10456-1-gert@greenie.muc.de>
X-Headers-End: 1wpXVZ-0006wn-L4
Subject: [Openvpn-devel] [PATCH applied] Re: Drop support for OpenSSL 1.1.0
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

This looks all reasonable, has a +2 from Frank, and GH confirms "nothing
breaks when compiled with all these wild SSL library versions".

The t_server test in BB also succeeds - which is important here, as 
"drop support for openssl..." could have an impact on "old TLS stuff"
(clients on 2.2, 2.3...) - nothing breaks!

Your patch has been applied to the master branch.

(This falls under "refactoring and dropping old stuff" so it's not going
to release/2.7 by default, and I see no strong need)

commit b3dc8c8a7b2c3fc5ac737337ad241ea261f218c5
Author: Frank Lichtenheld
Date:   Tue Jul 28 08:36:47 2026 +0200

     Drop support for OpenSSL 1.1.0

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1821
     Message-Id: <20260728063652.10456-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37922.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
