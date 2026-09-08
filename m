Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E63EC79F82
	for <openvpn-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ygYpd5KHq+dutZhNWdMw3xGOEEvNZzhenkHmH8DEmoE=; b=SWjg6uXI8XsyYjzz/svcx8HU+j
	u/Vb77hTxmLBfRQ/8jyiHiPlZQSsWENZaYndTXXRECDdrC8wN9Bcv32wV4i+uqbFRObDtKvIaOxBc
	DMGY4NlNsrUvKRTaoMzg58MKEy/1yAWabkbo+3kfbuDA8rvmjrQ7cUcgmc9rzEvWxYYY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3qL5-0005gt-NA;
	Tue, 08 Sep 2026 07:33:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x3qL4-0005gm-2E
 for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 07:33:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bm/yhFk1CGhezxaFxeB2P7Qv2PfmZK3rQLhsnkVvquU=; b=B1/Z9oNpRuEh8WVILXtzk0olkH
 dqs5c7625MRCCN6Q2ThIxn12eB/+3N3+eCvITTzrTWfAAHGOGS9waWndpPuHKKVWI10LqcNbnYk9D
 WCT4ADTaE/dytaaNY+4GraQ5NHC0vLvrH3jI8KvXJel8aCLGw6i6oFwQsDByCHkydki4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Bm/yhFk1CGhezxaFxeB2P7Qv2PfmZK3rQLhsnkVvquU=; b=A5SjH54uW6IbYLIKJHKArPhg3/
 oIM3pj0Q2cPzjPpZV/tJmQwjeuqX2NZ5NkSas8ddnpKwtUkkyGLbd1A3oaDCc9SUHeihftEQXMRwD
 I/b7C4SHcxxvrKbmeV44iZgLy7lGbinixRwxuY1Srj0Vo5QcVORdmM68BZsUdQMG/ktQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3qKz-0008Nu-7v for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 07:33:51 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6887XYdI063088;
 Tue, 8 Sep 2026 09:33:34 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6887XYih063087;
 Tue, 8 Sep 2026 09:33:34 +0200 (CEST) (envelope-from gert)
Date: Tue, 8 Sep 2026 09:33:34 +0200 (CEST)
Message-Id: <202609080733.6887XYih063087@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260907181754.13356-1-gert@greenie.muc.de>
References: <20260907181754.13356-1-gert@greenie.muc.de>
X-Headers-End: 1x3qKz-0008Nu-7v
Subject: [Openvpn-devel] [PATCH applied] Re: run-cppcheck.sh: Make it more
 configurable
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

"Looks useful" ;-)

Your patch has been applied to the master branch.

commit 28ec0f90fd5e4da73d9a0246fcb43d20150943ab
Author: Frank Lichtenheld
Date:   Mon Sep 7 20:17:49 2026 +0200

     run-cppcheck.sh: Make it more configurable

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1868
     Message-Id: <20260907181754.13356-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39000.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
