Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A25C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YbHZCVIwTJRODeIedQ/IOh2JFgs+GIiki8x3Yxdu+Y8=; b=SspLMCxGUyxS6OY/b06u1wUJqZ
	wTNkUH82qnfO0dnksSlNHHJT2qOlj2HFvpz/u1sAKB/pJzfSumXrTiZcsBP+YzbtVYFP6B0uFL0Np
	OtaEki0Pv0QOdyfF3jlpSRgc8tTJDK4Emebn6PaVSlVxbADk6yeSfpGTYCcenobm2xr8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wumNL-0007U3-Vz;
	Fri, 14 Aug 2026 07:30:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wumNK-0007Tx-SD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:30:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DH2Jb/GPXv5TcV8CtXCC+BDJch3jCeWwhWXY9N8L7c8=; b=FCpRqUu1Lk2NHfYDkqSsIWMZzy
 OhD15Go0R98Hpr0F5EWxakcpaxKUgr8C/28dsuZbEebwYBu5qlmI5YcIVt5X7w9cotZZ2FiAHoue6
 7j46vSynOHgtK19g1NSvxDkbR9TQbp7ktCm2SQkEaqv/20MkTBwsGQ1dVuWHl5871QJM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DH2Jb/GPXv5TcV8CtXCC+BDJch3jCeWwhWXY9N8L7c8=; b=TZPQAC0fcFiBg6tBLnbqVs8J5l
 kl+4N/SgVTCkcPOBQ35GhpX91lzQ+GwSYgaCFOfdwFDGAQIMEY1NiidU+6oOyORgj2lFSV5HESo7m
 HR1++hUGTRszEZQEf6xMCqxumynNqvMjD9ieXeerkrchaOQVKHHYIbTY2zladH1VTEpQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wumNL-0002yp-1m for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:30:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67E7USAA011104;
 Fri, 14 Aug 2026 09:30:28 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67E7USPc011103;
 Fri, 14 Aug 2026 09:30:28 +0200 (CEST) (envelope-from gert)
Date: Fri, 14 Aug 2026 09:30:28 +0200 (CEST)
Message-Id: <202608140730.67E7USPc011103@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260813180856.3208-1-gert@greenie.muc.de>
References: <20260813180856.3208-1-gert@greenie.muc.de>
X-Headers-End: 1wumNL-0002yp-1m
Subject: [Openvpn-devel] [PATCH applied] Re: reliable: Avoid conversion
 warning in reliable_send_timeout
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

After quite a bit of time, another integer, and another #pragma gone :-)

Your patch has been applied to the master branch.

commit 96dc5b7d2416e588ef9599d46b91a29fb1e0791b
Author: Frank Lichtenheld
Date:   Thu Aug 13 20:08:45 2026 +0200

     reliable: Avoid conversion warning in reliable_send_timeout

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1480
     Message-Id: <20260813180856.3208-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38329.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
