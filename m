Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDABC61DE1
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q4fLbwNp/dhebfdW9+ZBYUUMOl8jUuwF/H7Zh7RD2qg=; b=Hjt+qwYqGZ+szsO4TNlOFwh5T1
	fBQxfe9aoC200OmRl9VKRzaiGYrr10ZRi7xIWOagWa60lpGebRvszJYN1hRuzPPBDRLzWwNieLuZp
	sxUT6nUAoYHadrlTOZITXJ5XhkwWz4PZwG0RyhfxShF+1t0HjO4Z9ACk83TMRPffBc+I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0icx-0001in-SD;
	Sun, 30 Aug 2026 16:43:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x0icv-0001iW-PE
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:43:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m5U1qTvxQ8fmXBTe5hGNIh9qE7apKnwbmlBWpCKE0lg=; b=AAYsLS1fGccbhIHlDTGo81yilg
 slSDPy7ZExJ3p3BKs2Nvr3k0lkz3PffU2z8MGvBADgpDHKsqbAXRIaoGbDKJVeMWWRPq8RlueD1M0
 0kiAizNQPOF3gMhQU9SuJqnjJQraVVwArAP8Uqf1P4ssRryPjmY2NVwhLbYMyfCylWkI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m5U1qTvxQ8fmXBTe5hGNIh9qE7apKnwbmlBWpCKE0lg=; b=jLHss5PPGXJGL4n9Jds7hkMGsR
 EkGSrn2H31TBvITvvuWYtVSVIKhBdrPlDubnsWxSHXVBuEyevFc9QQbYCUlbxhxCQZr8OArA4o6EP
 hu53ii3ghq5oyyKZXT9+wcxW4jMuQT431fIOIw/VTSexIj64XvolSrt4o19Lh2dLEjj8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0icv-0003E2-0s for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:43:26 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67UGh8XJ075966;
 Sun, 30 Aug 2026 18:43:08 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67UGh8xt075965;
 Sun, 30 Aug 2026 18:43:08 +0200 (CEST) (envelope-from gert)
Date: Sun, 30 Aug 2026 18:43:08 +0200 (CEST)
Message-Id: <202608301643.67UGh8xt075965@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260828201757.744-1-gert@greenie.muc.de>
References: <20260828201757.744-1-gert@greenie.muc.de>
X-Headers-End: 1x0icv-0003E2-0s
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: Work-around bug in
 mbedtls 4.1.0 and 4.2.0
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

Thanks for that... :-)  (I have no idea what is the bug here, but it fixes
the mbedTLS 4.1 self test failures, so it must be good :-) ).

Tested via Gerrit/BB and GHA (mbedTLS 4.2.0).

Your patch has been applied to the master and release/2.7 branch
(long-term compat).

commit 5f6f272a11b64cf93513a54ef8b07d34ff2bd89e (master)
commit 2c825c240ac1fba639258bc304ee5c019c5a0b1c (release/2.7)
Author: Frank Lichtenheld
Date:   Fri Aug 28 22:17:50 2026 +0200

     mbedtls: Work-around bug in mbedtls 4.1.0 and 4.2.0

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1849
     Message-Id: <20260828201757.744-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38802.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
