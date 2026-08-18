Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4A1C5DF7E
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CECs7/7KsJ2VtDw7DwoOaK0NoYkIFqnoha4m5NJeev8=; b=VuEEglGJ1Ad3EmLoLQs88cqfp2
	NhZUSrDXaMChBknRoFZWkn1mTRVD6g+l83xtO77O959K0+2lIxSOKFNbrPkIRzSJZ16XfK2GrBgpH
	SMQKa3RieoKR+vHkorZ5Y34af8ycy5Tmz4k9L2sBaAWUoCZSr7pyPBhHaVvNhqOdBPeU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwIug-0006nk-GC;
	Tue, 18 Aug 2026 12:27:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wwIud-0006nQ-TL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 12:27:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tC2GIu4igt9IOD3CEKTkKAI9GA7Crst/KBWIDZ445GA=; b=FyLI1wbemzPSAp0Q2QlFqBgg0G
 4bV+IAJZhQW2abhC6CDiIjYH06BBvxOzh1D2x1ngShiR3EsVo9np4QO7GOlbE9+Cv6FNzBGAAT0N0
 74Yqctqr4nr8C4zmEco0hh3/m0Cjn8bn9t9E0C79xFY2vQB9HmN+E57b68MSxaNaShxI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tC2GIu4igt9IOD3CEKTkKAI9GA7Crst/KBWIDZ445GA=; b=JXk7NJBjmldeMu/snD2QZ+KYks
 Qp3o5MDTAastjWiSi2UUkPpscuLy9GCn/yMnkk+/GjI5lSo2+GR0nsSVzfMPEbY/z6+rjByYJ8eq3
 Zi5V1Fj5TAqd1GJWThblzlQsMjD+P10hHm6AHwNoqlGa676rTeVfGtrMe7hviYm8L7Io=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwIuf-00047B-Uw for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 12:27:28 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67ICRJLY068868;
 Tue, 18 Aug 2026 14:27:19 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67ICRJC4068867;
 Tue, 18 Aug 2026 14:27:19 +0200 (CEST) (envelope-from gert)
Date: Tue, 18 Aug 2026 14:27:19 +0200 (CEST)
Message-Id: <202608181227.67ICRJC4068867@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260817142115.28993-1-gert@greenie.muc.de>
References: <20260817142115.28993-1-gert@greenie.muc.de>
X-Headers-End: 1wwIuf-00047B-Uw
Subject: [Openvpn-devel] [PATCH applied] Re: Reduce number of future epoch
 keys from 16 to 4
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

The math behind is non-trivial, but the resulting patch is simple
enough.  BB and my local tests confirm "things still work" (and the
number of epoch-key lines at "verb 4" are nicely reduced ;-) ).

Your patch has been applied to the master and release/2.7 branch
(bugfix).

commit 360e3c1ad00e7b88371933e5196386af3e9fa74a (master)
commit f7196ed4a02e751e9b16043589a9bef160727136 (release/2.7)
Author: Arne Schwabe
Date:   Mon Aug 17 16:21:10 2026 +0200

     Reduce number of future epoch keys from 16 to 4

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1844
     Message-Id: <20260817142115.28993-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38459.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
