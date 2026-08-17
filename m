Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC42C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gt/WpyNWksqQMbA7oClJRbhVSuSZLlREw2BkNramWDc=; b=eGkZ+D8y63DJRn+KzqxlcT6idE
	z0wD7jDCCfLqLVusLol0ocJYBo3QMyVtx4aunTcwFfnh5MxJ5Cl2ImkU7edvPXnHlpQTVG7BeN1RU
	LuxbrjFFP5EJw3BX2SZwFoKTareXWX+dh+4ieYvsiWYjG9S1vzaVfrEwg/hZipHkQNB8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ww0fV-0002V1-Et;
	Mon, 17 Aug 2026 16:58:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1ww0fR-0002Uu-W5
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 16:58:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7hbysKQipj77N8QXDIAT2YCjxynQEINs4c1vt3oODqE=; b=AuOovRNBQCZlLzFEhkJnYpfnL4
 k+TBq+ZfFqQ64/yavz0sfHdVSd72pODXLjn5S/hG49/b+5OKq0CTNGCPApgjxGgdyFfnayz859hUg
 Gem8PNuRfWeX6lhN3iqbx4TCN9sNFnaBtyjE1lHMbXyqobptxu9WR3z4ilAXUdlYTd5c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7hbysKQipj77N8QXDIAT2YCjxynQEINs4c1vt3oODqE=; b=b5W8u68pnexUGSpWcz/1NTYi+s
 8DrowlbCvU9fOA04Kd3V7D9cOtP1xx4wp7jXu0oC0OEREEiFgZnTdKl0kZy1PyG5yDBHYp05PzEn1
 qLTmBbZVdc7hq8FSfWL7z3LnMTFfdrdusUSiNRSbdk94BrItqP4MWnJwXGkxVqmGohI8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ww0fU-0008Ky-6C for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 16:58:34 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67HGwI29034082;
 Mon, 17 Aug 2026 18:58:18 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67HGwIPB034081;
 Mon, 17 Aug 2026 18:58:18 +0200 (CEST) (envelope-from gert)
Date: Mon, 17 Aug 2026 18:58:18 +0200 (CEST)
Message-Id: <202608171658.67HGwIPB034081@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260817161831.8322-1-gert@greenie.muc.de>
References: <20260817161831.8322-1-gert@greenie.muc.de>
X-Headers-End: 1ww0fU-0008Ky-6C
Subject: [Openvpn-devel] [PATCH applied] Re: Start a new document
 CODE_CHECKLIST
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

Complete documentation on what we expect from committers and maintainers
is definitely a big plus.  I'm keeping it in "master" only, as that is
really where the development happens.

I've read through it and it all makes sense - except that I missed the
typos that the Kernel AI spotted (well done), and thanks to Razvan for
the more thorough review.

Your patch has been applied to the master branch.

commit cc7950b4188b6776f637a5abc29b45182df682a6
Author: Frank Lichtenheld
Date:   Mon Aug 17 18:18:26 2026 +0200

     Start a new document CODE_CHECKLIST

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1776
     Message-Id: <20260817161831.8322-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38465.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
