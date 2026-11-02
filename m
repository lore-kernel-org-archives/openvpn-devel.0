Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E8606A32E
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mMk/iSFE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=U9JsMP4Y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Fnn9dv9P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iLRHUPlNMvkpnNuF0YH2ZrKpV3qC7dvYzoO0M0VZ1oU=; b=mMk/iSFErM9syV
	yYt8yz23gBRb1Gy8IjcyeN7xk3s0hSU8p0qXUnZsY5Fz2AuOTZx+gFHSgOm8GnOlaESGkipmhWoog
	nd4vmcXhH0MhNmG3AnzMbATY/JHW8r06+V8qrPsp4ok0vOll+xdQDyNFvOBPE9Ws3ui8gOa+wdaci
	bLw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNpWO-000000000Ki-101G;
	Mon, 02 Nov 2026 10:44:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNpW6-000000000KA-0Zyf for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:43:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4JvkmMxpX9vqMH0MJ0wKgF/CvC6FKqt6pDnegX4I3MQ=; b=U
 9JsMP4Yh2fssA03djgmGN2h7pg2yo/dnIWbDCVBPDLHbDPKUfgN1Kh/Im7CmLMOz5kKF47Z5CmSnr
 UItii7ANUXNczP3Fa9HIN7eSPfH4JKNvjf5It5xRMXU5/SzKrgnCi2vwsMh3jBoIYwIZUhC42RSZC
 k/YqNRkEDBtKHD9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4JvkmMxpX9vqMH0MJ0wKgF/CvC6FKqt6pDnegX4I3MQ=; b=Fnn9dv9PB6oDPeTKHaVkEXxhuX
 ezEQsAqc3hwnkrv9Guv8pXiEY8S+Gt+AKDCFO6aGSPJ7j92RYu0iH3QZkrrkCySNbQZrI6rS6zN2C
 DfZN0RoF0eYT62q7HBtoP5pEaKCMS9BmiiMnBDASTASL1Ez7YtMGNhrVCjiXMMcZ94fE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNpW1-000000003ko-2bGw for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:43:52 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2Ahgd6053210;
 Mon, 2 Nov 2026 11:43:42 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2Ahgf8053209;
 Mon, 2 Nov 2026 11:43:42 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 11:43:42 +0100 (CET)
Message-Id: <202611021043.6A2Ahgf8053209@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Selva Nair <selva.nair@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261031074840.27546-1-gert@greenie.muc.de>
References: <20261031074840.27546-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNpW1-000000003ko-2bGw
Subject: [Openvpn-devel] [PATCH applied] Re: Increase the buffer size for
 alert-message in management user-pass query
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Technically this could have been squashed with the one beforehand, but
since it was submitted & reviewed independently, here we go...

Test compiled, not actually tested oversized usernames.

Your patch has been applied to the master and release/2.7 branch
(because the other one is in 2.7).

commit 35f40a2cb94317dc15dfbae82b7477c86a8d4219 (master)
commit e7113e89b84b468a4ba49b290dc9cc5b764287dc (release/2.7)
Author: Selva Nair
Date:   Sat Oct 31 08:48:34 2026 +0100

     Increase the buffer size for alert-message in management user-pass query

     Signed-off-by: Selva Nair <selva.nair@gmail.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2073
     Message-Id: <20261031074840.27546-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40361.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
