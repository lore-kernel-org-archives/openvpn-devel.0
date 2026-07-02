Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95B1C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IDayFtxtQKU5AdM+cvgsFsBpRyqu7GMPpvXk0TEY8rg=; b=ipw2js7Wo4BtFoMnqY7KbsHB5U
	cILkQF89fCGBU1ZuUyIfmz2Y43fllWGw4euhL/+m0lmG5NGqQevImtNui6szMijyR1tIK7HLKkfgw
	LZdxP5zBOXahytaOIzF2csW4iyi488Nk5hNJLqZjsQk/2Fhse0sxDeriC9GSZMp66iVE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfDsx-000722-Jm;
	Thu, 02 Jul 2026 09:39:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wfDsd-00071Z-Th
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 09:38:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UEmOFjz/vh/h27ZQYCKXilTIXx9WRq8pglaYAmRpyf4=; b=kszDo9UObiyhPgXvpHIK6M2jq0
 ng39OCzLMgJoeMXUu1zPVVMjjFxq5be9sJju+DzfUHV3kUTMR871lsxE0ylmwXvPvJdxK2IhDHUJY
 QxSyYJUl/F7eTJ3VBfm22IIkNz9o5ORs+LkfBOWvZzhAxH/+YBzAYHc7gPmOjvGSjrI4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UEmOFjz/vh/h27ZQYCKXilTIXx9WRq8pglaYAmRpyf4=; b=jdUf0CyrNqZ4eUGhQZZ+B+csrl
 uguvznqzhKLMXGd9TflYKIEloOFjPk6n73yvGesVKbdxrSbnFdAmnOZaLmOb3brawbsZzq9SXd8VL
 Tgkh6TmWgIZRBAsIcWbQcEVl18wRYSaU5dxqdaodZZWpNjbD2z0XkOacpQP/jCRdtlU8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfDsb-0005lP-PM for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 09:38:48 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6629cQxG051873;
 Thu, 2 Jul 2026 11:38:26 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6629cQQq051872;
 Thu, 2 Jul 2026 11:38:26 +0200 (CEST) (envelope-from gert)
Date: Thu, 2 Jul 2026 11:38:26 +0200 (CEST)
Message-Id: <202607020938.6629cQQq051872@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260702074746.3129-1-gert@greenie.muc.de>
References: <20260702074746.3129-1-gert@greenie.muc.de>
X-Headers-End: 1wfDsb-0005lP-PM
Subject: [Openvpn-devel] [PATCH applied] Re: test_tls_crypt: Fix issue with
 temp file name on big endian systems
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

Thanks.  Confirm that it works on FreeBSD/64.  Couldn't test on AIX,
as that test needs working ld --wrap and it wouldn't work "as is" for
me on that platform.

Your patch has been applied to the master and release/2.7 branch.

commit 7141f625c6114e08e40696464bfc36d5c5743683 (master)
commit c3d929cbfde012fbacae7d447e1755b07f64b464 (release/2.7)
Author: Frank Lichtenheld
Date:   Thu Jul 2 09:47:40 2026 +0200

     test_tls_crypt: Fix issue with temp file name on big endian systems

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1761
     Message-Id: <20260702074746.3129-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37454.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
