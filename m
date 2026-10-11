Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9573CA9EBD
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 15:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gibuA3cVM3k/qHxnVs9Qxbo8+W5Dup2YOWKUEoS0mH8=; b=TyOu0UF/9flYevBVqjn8DNlJju
	lAPFrKghIwQCz2lT81WgLWWy65Bfo0MUcZDf6RHkvV2DNfp9Y0Jjef0mWN000kgE2M7CPzDu7ILdB
	/2D5V3XGhZY5+mGH5FUJWRLAABnYrhcua1M7foSgOeKbZeD/I1uRDmiEFnqEA+NDt3aQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFvwi-0007a9-OA;
	Sun, 11 Oct 2026 15:58:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xFvwh-0007a3-4C
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 15:58:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e+3zzrpel5s7bSFPDQOmqltmH+bAij38BFfuLCYcvfo=; b=SOiLKiwEf9aj3rBfG3mcEtC1ar
 w8sDsfnDFLKeiD0GROe6EsmLaKDe/KGN6v4ZWP+vn5lFna9Zpw7pjxlRJWoXUpDkBkmPFabwITVSI
 kyHlAK1wcZqpIGiNfdYijQk9JEKxSpYV+xmsnK9g6M8eYDHEjMDUcLgBG5sAyWlUncqY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=e+3zzrpel5s7bSFPDQOmqltmH+bAij38BFfuLCYcvfo=; b=czIt+hDLJh8Zm0+sQ+khL6vPkO
 FQC/brcoE2eso8L+gOB8Ljb/XZrKEOmiv9xniKw8E/3r0F0z90/la8ZVdptPpZvYifd5SsNfGJWcX
 QJOmzzdOVzF3JFTqZ9Iliw0jRGM3Za3PFeuKIIfc9QH54q8BHnW7L9Ym3oEgYc5PvnEY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFvwb-0006vy-GY for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 15:58:40 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69BFwUH0036125;
 Sun, 11 Oct 2026 17:58:30 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69BFwTl4036124;
 Sun, 11 Oct 2026 17:58:29 +0200 (CEST) (envelope-from gert)
Date: Sun, 11 Oct 2026 17:58:29 +0200 (CEST)
Message-Id: <202610111558.69BFwTl4036124@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261008205143.28452-1-gert@greenie.muc.de>
References: <20261008205143.28452-1-gert@greenie.muc.de>
X-Headers-End: 1xFvwb-0006vy-GY
Subject: [Openvpn-devel] [PATCH applied] Re: reliable: drop the half-space
 packet id comparisons
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

I won't claim to understand this reliable sequence space thing, but it
has unit tests (thanks), and the new code supposedly simplifies it and
makes it more understandable (thanks!).  Arne understands it and has +2ed
it ;-) - and the unit tests pass.

One caveat this brings is that 2.7 and master diverge more and more,
which is why "fixing bugs related to this code" could possible now
require two very different patches - but that's the cost we have to
take if we want to modernize the code.

Your patch has been applied to the master branch.

commit 2318e3366392d0d066c2a8cfa1b3d1f332935334
Author: Razvan Cojocaru
Date:   Thu Oct 8 22:51:37 2026 +0200

     reliable: drop the half-space packet id comparisons

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1900
     Message-Id: <20261008205143.28452-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39796.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
