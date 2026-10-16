Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882D7CCA464
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sCzipjV5eL8yzoTildpw/wqWxeGMGsQ7Gi9O0K/2LPY=; b=Z8jY20eXz9wB99UFZjKo/RsgL7
	sZN+YI5ET+ScQPK8CZA1w9S/vbuQZvjmI0XbO0yBUrloJLtkhRANOYOvcgNE03JYm0K9TxE5xPrTG
	+olvAm4ytippztc1hsZIMaZBIvKjIDvFD3SUmrY5sDm5CxMopcQcptQ95XsQYPupB2Jc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHgFF-0006yY-Eu;
	Fri, 16 Oct 2026 11:37:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xHgFD-0006yR-K6
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 11:37:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iwlUK65s7HpAGymNJuPXY+Jq9LjxnP4Df8CWw6If11w=; b=XJhDw+idkrgzUGn5Db8MGUtvqk
 IQMwt/jvb8yMb0cjDaAp6yP03H037RFAMLltWRX0RRqOo6nZpMyw3FHM6vhwsRMgktF+sBEChYNjh
 RfGMDqBs8AtE8Qy3t3R+cNat9acg1uNhOgIbT/47dTtADVA1znr78PmvCtQdcoTsDmh4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iwlUK65s7HpAGymNJuPXY+Jq9LjxnP4Df8CWw6If11w=; b=VOu/caeJmBvCOzOpFV0PPOChnz
 OJUvABxLSTARMuXnum43mKoAoKEGaQTxwccKifdBhHN3ItB3GUoL1HckHYWiERMSsdrZpYmdRo56n
 VuN8MIM7jMpCI5NI+/DOHZNe9eJV6hryvGQ5r0g6D1GwUe1gRY2NFhQvvptr+aNJONR0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHgFB-0004QA-Da for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 11:37:03 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69GBal3F042452;
 Fri, 16 Oct 2026 13:36:47 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69GBalxM042451;
 Fri, 16 Oct 2026 13:36:47 +0200 (CEST) (envelope-from gert)
Date: Fri, 16 Oct 2026 13:36:47 +0200 (CEST)
Message-Id: <202610161136.69GBalxM042451@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261016085833.27514-1-gert@greenie.muc.de>
References: <20261016085833.27514-1-gert@greenie.muc.de>
X-Headers-End: 1xHgFB-0004QA-Da
Subject: [Openvpn-devel] [PATCH applied] Re: compat: Add strlcpy and strlcat
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

Reading the manpages for strlcpy() and strlcat() (and comparing to
strncat()) I agree that this is the direction to go.  I would not 
do this for 2.7, as it's the sort of "we clean up old stuff" thing
we do in master (-> 2.8).

Sanity checked via a GHA build run (all green, BBs as well).

Your patch has been applied to the master branch.

commit f659b6ecffccdca4469c2a20a819d7a29fc3c7c0 (master)
Author: Frank Lichtenheld
Date:   Fri Oct 16 10:58:27 2026 +0200

     compat: Add strlcpy and strlcat

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1994
     Message-Id: <20261016085833.27514-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39916.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
