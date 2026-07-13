Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE160C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/3qvhW5bYR0Pvk0zrET/kML5ruZjmHgRx+kpqhO4wA=; b=SPwF5E6ZewHXdE+FwV/1IdBJ8K
	yTeFBf97tsyhl1NwHWh0bpzZ4e59ebZVg99yqoqPMT063Sa9q9rV1CtfpSst3Ouv8XNmUM8WlO98E
	97HDUXOQycYyjkDKEXTGkUAx4luaP/85Z5lBa4jWnopFh1zbPsUTfLNnvO2+sCa3Cb4s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjIzQ-0002X3-4J;
	Mon, 13 Jul 2026 15:54:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wjIzO-0002Wv-Gd
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iv0ZNAeriGgQ8oaaiV6Ktju+sOLu+qt9ze0esSkpegg=; b=K9ngM8DtirFoutKkmQB3U7m8a6
 GNgUKl+P/WkReTuT6TNxjkj5C5FkNWB71td3dBnPxqEuNLbYdkOL0Z7qQJV4Dhqksk0M/1ibL5u1H
 vbcW1OEPkM6YdXatKHCaIGvRXzpcADL29+7ajec9eKwSONEyprbPUzMSeuf94e4WBro0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iv0ZNAeriGgQ8oaaiV6Ktju+sOLu+qt9ze0esSkpegg=; b=l04gJ2A213WhTl981ObWDgFZCE
 ckOdBmb3U0HZrlIfMkv2lY9botGpr2g3GaZMhtRXrUya8h8mo08rSGVAJuXvWeqDGkf40C1i+ePau
 vweWQ9A3WBUTxoDJCjMedx1QnYEJQPbu0WVHcpd7T3wibIuYFEwwXttrQT//zyt5tG4A=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjIzN-0004HZ-AM for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:54:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66DFsPr6078053;
 Mon, 13 Jul 2026 17:54:25 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66DFsPae078052;
 Mon, 13 Jul 2026 17:54:25 +0200 (CEST) (envelope-from gert)
Date: Mon, 13 Jul 2026 17:54:25 +0200 (CEST)
Message-Id: <202607131554.66DFsPae078052@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260709144240.61362-1-frank@lichtenheld.com>
References: <20260709144240.61362-1-frank@lichtenheld.com>
X-Headers-End: 1wjIzN-0004HZ-AM
Subject: [Openvpn-devel] [PATCH applied] Re: CMake: detect cmocka_version.h
 via include path, not by linking
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

"Build stuff, for the unit tests", so not directly code affecting and
not scrutinized further - if Lev and Frank say this is good, make it so :-)

Your patch has been applied to the master and release/2.7 branch
("build environment / testing improvements").

commit 2c2fec4a965cf046b3d71b3250f8d84f6af81b89 (master)
commit b6b6af3d7c70f56a3a51f042ba7fe57f8d96e345 (release/2.7)
Author: Lev Stipakov
Date:   Thu Jul 9 16:42:40 2026 +0200

     CMake: detect cmocka_version.h via include path, not by linking

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1739
     Message-Id: <20260709144240.61362-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37552.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
