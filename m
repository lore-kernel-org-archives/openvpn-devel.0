Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC59C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0vrepyjMI9uhCbQHuHBkUVQiOSVzpPLhlRQmRZzVjAQ=; b=UGhjG3K89Dpc5O/iWlYDSZw4UV
	7rqK+8flID9GmZlvbaG/zaDrDZJ9pf4wpKdNDnY54oJtnQxh4lAbyGKzbehJ5hIHt8OB4V8VeKEA2
	lOFUhCANgkopBXEQ4SBMZYeIsKixvZbtty4GpIqjBc+PObEWKoC8sfk6GOSF5CZnLtKs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvKlF-0005rc-LM;
	Sat, 15 Aug 2026 20:13:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wvKlE-0005rV-92
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 20:13:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DqbWZwQax4eSjCaA3A2vxbB60adZu+yN93knGHSvZac=; b=Av65pI0j4PQaxxBlngz9xLU1q5
 EbHgQ+cfPpunaXwBpMGhNPj6H2NCNS8hRqQhwMelVD+jPFB88UUc1uBwFxcIR8SSWdUEKFVLjNkOu
 Egllc+dUhwtzfzO2C+lqRgEL5+1YuHGhF5+wL0IHLGlR1nsjgedg1EccR+09bxc0hISU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DqbWZwQax4eSjCaA3A2vxbB60adZu+yN93knGHSvZac=; b=CpFBCP3Ol6OMiQJauV5qZ4wehV
 cDOhdJeOKH1Yy1D+B3i2Hkmfmyh6F49PjHHyFqcXo5xuzt0cvhxLyrjqoPdoOD2fav7qj4eD/qwYg
 qOtnmNI85S4s5tJDQXOzuH2w+bsGMJ72Iyko2pkKHnIPlQ4zJAyumNEShwD/MNzckAt4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvKlD-0003IA-OR for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 20:13:41 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67FKDXkx077958;
 Sat, 15 Aug 2026 22:13:33 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67FKDXBa077957;
 Sat, 15 Aug 2026 22:13:33 +0200 (CEST) (envelope-from gert)
Date: Sat, 15 Aug 2026 22:13:33 +0200 (CEST)
Message-Id: <202608152013.67FKDXBa077957@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260815130008.19708-1-gert@greenie.muc.de>
References: <20260815130008.19708-1-gert@greenie.muc.de>
X-Headers-End: 1wvKlD-0003IA-OR
Subject: [Openvpn-devel] [PATCH applied] Re: Fix compiling with mbed TLS 3
 and cmake
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

We seem to miss having something that builds this particular combination
(GHA or Gerrit, with cmake) so it never actually failed - change makes
sense, of course.  Thanks Razvan for digging it up :-)

Tested via GHA build, which only does... tada... mbedTLS4...

Your patch has been applied to the master branch.

commit 4acebd72c1c6bc0a4a2ee2b4288c18214fead278
Author: Arne Schwabe
Date:   Sat Aug 15 14:59:38 2026 +0200

     Fix compiling with mbed TLS 3 and cmake

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1757
     Message-Id: <20260815130008.19708-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38406.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
