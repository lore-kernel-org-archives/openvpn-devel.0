Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AB4C5DF7D
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZgQ2B/33YAZul7hWcPyu/7myVuE+PHgaJzEt6BV9Njg=; b=H7GXLviE98E49sEK8d4E2RSZcd
	m90aJhK2b+GjG46Lc51SzHHosO8GH9IwtHiu9mex4xwIYFXsQoGAESwV5hJQzU/3Qq917iaKtrk1l
	KXuyoha9lYw3hf6ZlRe3uisPMvjFXYEiqKxUrvYqB+JL43lK4SzZNQLk71kA5wE9Zgnk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwKTL-0005vV-T5;
	Tue, 18 Aug 2026 14:07:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wwKT2-0005tz-Pb
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:07:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/OspGvBtINQRIwS/PjIRiyKNGNk8VEQ8EODW5j327+s=; b=aJLXIGUIjCoUg0PYI7+s7G8Gb7
 O+wPfoeG7yn3rkWUHZDmoeKTnzyW8+acxuxt7ENb1emrfpTx5kCXmwKaeHiTR1u68sWU+gOnclvzF
 A9RA9ZIxNGv4RADHXn23FIAjhIJkySiq9pa5hRcFCTLwaUQkRaINcpE7M6t/l3iOikkM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/OspGvBtINQRIwS/PjIRiyKNGNk8VEQ8EODW5j327+s=; b=K6EX5hrwTZOA/4UwvGgJg7QtBf
 nGGicIYklVWvBAFsxY5/pH/KxLYbAM7W3ybwd1rKDFUM1HnENoioACcKtOZdbAoaftNhuMr4lYlBr
 5ZRPshNn0kyrVuZbsKzMmx/mK4i2b+fJ1TF3RWLKF0URJ4J1V7ZaaOeLBJ2/ceznd0Pc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwKSt-0005AA-5X for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:06:58 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67IE6fgb071964;
 Tue, 18 Aug 2026 16:06:41 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67IE6f1f071963;
 Tue, 18 Aug 2026 16:06:41 +0200 (CEST) (envelope-from gert)
Date: Tue, 18 Aug 2026 16:06:41 +0200 (CEST)
Message-Id: <202608181406.67IE6f1f071963@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260817131536.21559-1-gert@greenie.muc.de>
References: <20260817131536.21559-1-gert@greenie.muc.de>
X-Headers-End: 1wwKSt-0005AA-5X
Subject: [Openvpn-devel] [PATCH applied] Re: m4: Add ax_code_coverage
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

This one does not do anything yet, just imports a m4 from a known reference
(verified against github/autoconf-archive, savannah is not working today).

Your patch has been applied to the master branch.

commit 4f81de14de7c9f7ca371236f5d30e0d6ba9d6449
Author: Frank Lichtenheld
Date:   Mon Aug 17 15:15:31 2026 +0200

     m4: Add ax_code_coverage

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1591
     Message-Id: <20260817131536.21559-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38448.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
