Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A083EC531CC
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PZj9BTqUPBfLcofMp/S49Rcv37DPDuVQXW/ubYBXLVs=; b=a1lLLI2RGzDfDZtSsjGgZyGKvd
	h5xbx16x+BtkhOBUstAoDwZ4tLL9CgUviS+nDfTDgoHGi1cbpL07/7N14mv9MZTKHTD6F2BpDpusF
	LeWFu2+Je+hHfmAUWKvtKCBN48Mml2HpOF50GuiyW8lxtFEanvnz7hlbHfv92Yw7Vm8o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wn0Gb-0000DF-Sc;
	Thu, 23 Jul 2026 20:43:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wn0Ga-0000D9-U2
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 20:43:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UDqMHP5RwC6fKQiZvrWbg+ObUptBuzq8whDSsfCeVZc=; b=Tl5pDshQbbS8RfVfk5h0ICJRv4
 DuiogDux1lQLI/fevPF0nbayNeaI16D212kn8j31PdQUDkZcdFKiBsNgA87qqsx8gr6WkP9PYdsUO
 FI11lNkVMYvJVkTmqFcBUF6Sx8eE1AvmxIuwNabG2C7ZAcnN2WGszfwRpHgyXj/ikzz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UDqMHP5RwC6fKQiZvrWbg+ObUptBuzq8whDSsfCeVZc=; b=Xd50d9OxRf+IoDdwuABJGu80zo
 UAl/uiTC7oW20CqwEHPbs9KwMpQktTxFDO/xyrPhaKpkneEwp0+IwEoo5T9K+63hL0QFgeFsBdE8Q
 M87zVicKdq2QJyV77rIgew182MEtwP9opGo7hwQNaKea6hkIIqTSINySu80Fk7Fj2ig8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wn0Gd-0007VW-EB for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 20:43:41 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66NKhViH012252;
 Thu, 23 Jul 2026 22:43:31 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66NKhUgh012251;
 Thu, 23 Jul 2026 22:43:30 +0200 (CEST) (envelope-from gert)
Date: Thu, 23 Jul 2026 22:43:30 +0200 (CEST)
Message-Id: <202607232043.66NKhUgh012251@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260708185659.10219-1-gert@greenie.muc.de>
References: <20260708185659.10219-1-gert@greenie.muc.de>
X-Headers-End: 1wn0Gd-0007VW-EB
Subject: [Openvpn-devel] [PATCH applied] Re: mingw: avoid C99 hh scanf
 length modifier
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

I find the whole explanation behind this highly confusing, and I find it
even more amazing that we have no "parse_hex_byte_ex()" function in all
of our codebase and have to resort to scanf()... - but whatever, the
new code is not much uglier than before, the scanf() actually more
readable (because no macro involved), and it works on all MinGW versions...

parse_hexstring() comes with a unit test, and that still passes, so
"tested well enough" :-) - also compile tested with whatever MinGW
version I have here + GHA.

Your patch has been applied to the master and release/2.7 branch
(long-term compat)

commit 035a88f97b1ffdc88497faeaa0aeb8a72e1eaf4f (master)
commit 326bd05d3db9be075091cd12b7a7c7c798ef9a7e (release/2.7)
Author: Heiko Hund
Date:   Wed Jul 8 20:56:53 2026 +0200

     mingw: avoid C99 hh scanf length modifier

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1733
     Message-Id: <20260708185659.10219-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37544.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
