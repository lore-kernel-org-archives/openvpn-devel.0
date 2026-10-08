Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEF5CA600D
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D4PxSNB1IQZtUgXc/+lW90rvNuFtIotZnMP73eEPXgY=; b=ID9PJeS/tnYAHb4A9xw9ou3omc
	uFxlUbVq/GipOr5O6EVBh8jR/dwbEyKStmjyV7Cok9jJvOzxL9c4qASw2Bm9nYxQe7hiF6KqtAANv
	cT8Y5+Kra99Zns5YkW7MXo+HWhDpCQwtOkCm51yaRrppRJOGLJkbXfblmlRxvgDfxoC0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEtMc-0001wz-6U;
	Thu, 08 Oct 2026 19:01:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xEtMa-0001wt-CP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 19:01:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R4KX77irxlvkVPgacrfy3x7ZAnsr5ZQ4o1zlAyY0zJs=; b=O3nyUATZerKOjgCcozL5QGa9Bb
 cHG6mM7GB9vlLWpNpcJM2M8Xdm8qUX7G5647LW71zTkNaLVNmpA8leKbM1z3u1tKa2iGSKSSuNFnR
 cwSzzwqiN3JEvZshiNooMrWP7LZqZED0CJtejuIMuwcrNfNxdCKekEJTMTDinLmv7VYY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R4KX77irxlvkVPgacrfy3x7ZAnsr5ZQ4o1zlAyY0zJs=; b=Goa0vCinwYviNBz+yb7yEvHdiY
 sa0RIDDAsyWUZwcXdZ37Api1SQ/C4g4ILJYpItQSDiLhERLMrdzw283AObkBSxBV1fOx+pUYA/2P8
 LXBIyToVxzARXtKquQ1kaJ4NZDCWabOyemOOlqgmLaTn2n+e1FkYDSn0nMpt7iQUFV9g=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEtMV-0003D0-G6 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 19:01:08 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 698J0jG0085686;
 Thu, 8 Oct 2026 21:00:45 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 698J0jg7085685;
 Thu, 8 Oct 2026 21:00:45 +0200 (CEST) (envelope-from gert)
Date: Thu, 8 Oct 2026 21:00:45 +0200 (CEST)
Message-Id: <202610081900.698J0jg7085685@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261008161329.32304-1-gert@greenie.muc.de>
References: <20261008161329.32304-1-gert@greenie.muc.de>
X-Headers-End: 1xEtMV-0003D0-G6
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Clean up
 rm_trailing_chars
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

New code makes (lots of!) sense :-) - and unit tests pass.  Off we go...!

Your patch has been applied to the master branch.

commit ec55ca56e7abe9c3824ca37c0f5939d758163db7
Author: Frank Lichtenheld
Date:   Thu Oct 8 18:13:24 2026 +0200

     buffer: Clean up rm_trailing_chars

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1987
     Message-Id: <20261008161329.32304-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39789.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
