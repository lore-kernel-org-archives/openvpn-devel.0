Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE86CD4F2C
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r0hF6OCJkC5Gw2FE/Df5IPfwCdHaj80vrgHNlOkvdHg=; b=bZpyke+IRu/OQNoEEJeMbTVdzj
	OsIaLyaHFyUSeu/lcL09ODurQ6s+eOtJdO7DBHCWFLirig6Hl6jR5/0/I8z3sPSddmMivetSaHrF+
	IEMr+CRWMilmy04/E83DhbsZ/Uo2VqBEeOvS4OYXQ80dGuBkz7nURpmNZRn6j7NHty1U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXxV4-0006h4-Ny;
	Fri, 12 Jun 2026 08:44:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wXxV2-0006gx-54
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:44:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Efj8D31kK/Y3dLz7bmptJITZ+YoFLmQt0bto5eZZx4A=; b=Y2znjWD+Z2UH7FL1Dap43UEcIk
 ZIKXBt9Yc5vEWudN3Wn+wB5llXZ2+/UQOGgeaNgsUtmHWaAxAZJviHo1TlPz1aj6SovK+0/hwFgCK
 L5RB4iKqmSA+62LYUxRpODUBySjiiVB8iX1uU1VDWwpRgVyqQyAkZB5uYjk9i6UCfBlI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Efj8D31kK/Y3dLz7bmptJITZ+YoFLmQt0bto5eZZx4A=; b=UZ0CT3lmCIzQAU+fOCIKwth1xa
 C79xfkAVlTarrTZTVaR+4egj7kE6Wu1x7mTYp11gFJADNM/O/dbHyrqfbBU/1FZDK76hDZmInZSgU
 TOyEWpUozmlmMagpstuHYhdmZ3nPATkCEdpz8xmbNDb53BctfExQsGjByE7pxJiHxLQQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXxV0-0006Up-2p for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:44:24 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65C8iAfL071344;
 Fri, 12 Jun 2026 10:44:10 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65C8i9Sw071343;
 Fri, 12 Jun 2026 10:44:09 +0200 (CEST) (envelope-from gert)
Date: Fri, 12 Jun 2026 10:44:09 +0200 (CEST)
Message-Id: <202606120844.65C8i9Sw071343@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260609155226.30827-1-gert@greenie.muc.de>
References: <20260609155226.30827-1-gert@greenie.muc.de>
X-Headers-End: 1wXxV0-0006Up-2p
Subject: [Openvpn-devel] [PATCH applied] Re: AWS-LC: Add casts and
 openssl_opt_t typdef to allow AWS-LC with -Werror
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

I really dislike these "libraries claim to be compatible but aren't"
adjustments needed in our code... but what shall we do.  *sigh*.

Tested (especially the GHA adjustment) with a run in my repo.

Your patch has been applied to the master branch.

commit fe72bbec92decbf15984163bc7852f8e6dab7de7
Author: Arne Schwabe
Date:   Tue Jun 9 17:52:21 2026 +0200

     AWS-LC: Add casts and openssl_opt_t typdef to allow AWS-LC with -Werror

     Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1637
     Message-Id: <20260609155226.30827-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37145.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
