Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680D3CA9EC7
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mMkQM8FVG1xTyQjoB4FBmSIH7J0q1cz4cZB+uPBq53k=; b=MFzjd87znV7IUUjbeEJL4fTT8X
	ojmarwPgJ958JBqyo1rLg4UEWEmcFPz1xTSouyrYo/SfMeTQGr7RtFhDctrMSCI7/Xj9xlDvfOX6B
	zuKvvgIo7+9XDsqj+Z+pBeb6MDBATJYjg6EPXK4XHj5xNqEyBaKBpCWcQSaY7S6Uef8I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFw4V-00053p-DK;
	Sun, 11 Oct 2026 16:06:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xFw4E-00052L-4z
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OBKxcXfSY8GnFiYErNrfn0EpTHRAple3K1zTDwInmf4=; b=hMRfrvHKrYgk+AVCV/Cw/M2/mK
 S9uITapLnC31+mEbiSfuWY5SRtaYfS8aoOojBthQkIWwOKZxQgkBAZwO0LOXGEe+x5iFIog9w/UqC
 99wzaRs9q7UhmeJ3AChaAwIXf1rHRKA3BrZG0bWuuLmA+xIRbxmBn3fr/6KVF09VCDjo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OBKxcXfSY8GnFiYErNrfn0EpTHRAple3K1zTDwInmf4=; b=WnnQ/f509pCwLUVxog+pJ75hDD
 CM+M66mkEQEpVlWU1LvG5Rz1m3+V/ko/a3WFpBQYgdtwkcVl+Tsx+4PhS3UKCyIfF/8Ad14/7k39S
 eib4csxKw5fUdebWzeFj32r5YSJcW8eMv5hsH/x1Y3iLEy/jxLjPuu17fGqbwRsNWUM0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFw4D-000780-8h for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:06:30 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69BG6Mfr039564;
 Sun, 11 Oct 2026 18:06:22 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69BG6MQN039563;
 Sun, 11 Oct 2026 18:06:22 +0200 (CEST) (envelope-from gert)
Date: Sun, 11 Oct 2026 18:06:22 +0200 (CEST)
Message-Id: <202610111606.69BG6MQN039563@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261008205045.28233-1-gert@greenie.muc.de>
References: <20261008205045.28233-1-gert@greenie.muc.de>
X-Headers-End: 1xFw4D-000780-8h
Subject: [Openvpn-devel] [PATCH applied] Re: reliable: fix the send window
 width
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

Amazing find :-) - thanks to Arne for verifying and +2'ing.  I just
verified that the unit tests still pass (and glanced a bit at the code).

Your patch has been applied to the master branch.

commit 01619660cc1c1c56c999c8ec8de1b23c63580a9b
Author: Razvan Cojocaru
Date:   Thu Oct 8 22:50:39 2026 +0200

     reliable: fix the send window width

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1901
     Message-Id: <20261008205045.28233-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39795.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
