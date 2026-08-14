Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96152C5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:Subject:References:In-Reply-To:Cc:To:From:Message-Id:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3I/AdfFXzyJ/+yWVQDmsW9PPabMlga94/pK7FKzXUIc=; b=e8iubKkrH8p7COwfmpH+6qNGo5
	htUzo+Pv+HaFVIZWJzs0ZGKmHCNuKfHEmx6wK53AP1qciOOzqCHWln+GqOlESltaT1whx3plj204P
	5FIPi7KQknBJxUDkhZDsvKtZg59arzE+bqHh3z8t4eloXZmNEqS87i3tMZ37Y2uKb4xo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupba-0003Cn-Ve;
	Fri, 14 Aug 2026 10:57:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wupbM-0003Bf-AX
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:57:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/QzJjpst0YnhGPTJzbxZ+R4Yis3pebGb+UrUYghnrFs=; b=ChIkHIB5W6D6CeOD37yjMgeC++
 6V7iQ3t8+qKaMyEvlcmEypoZidavH9a3BtjlBKw2ShNgDVzbdM2cfN67xypYpiV842DwC7MfJafeZ
 PxLqZNguDRa+VvWiAv9sxs6uhTQcgqupaQUMuLByeYOFtYWUBqZveptTtc2A6rznJqi0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/QzJjpst0YnhGPTJzbxZ+R4Yis3pebGb+UrUYghnrFs=; b=Wn6EiDALz1mm9jNv3SPRnoa9/W
 lNlGAyCi3KBo0QWzj0+Qlb+1w250EzgWe30ijRckHDFPQOFHT0YIEvSV34P8RYbZXfQtqNGdN1Xup
 wUUQKt0G7l+WNnOHEHc3hvi1de17flY5xpHa9duNylwR3ZjL1gw1PWRNXcnivoxbpuBc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wupbP-0003nf-6J for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:57:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67EAvLxN017549
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 12:57:21 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67EAvLDt017548;
 Fri, 14 Aug 2026 12:57:21 +0200 (CEST) (envelope-from gert)
Date: Fri, 14 Aug 2026 12:57:21 +0200 (CEST)
Message-Id: <202608141057.67EAvLDt017548@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: openvpn-devel@lists.sourceforge.net
X-Patchwork-State: Accepted
In-Reply-To: <20260812140515.107442-1-razvanc@mailbox.org>
References: <20260812140515.107442-1-razvanc@mailbox.org>
X-Headers-End: 1wupbP-0003nf-6J
Subject: [Openvpn-devel] [PATCH applied] Re: buffer.h: Fix
 buf_substring_len() documentation
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Your patch has been applied to the master branch.

commit 9b114749d9db9918fa951814cf2d8f4827b3947e
Author: Razvan Cojocaru via Openvpn-devel
Date:   Wed Aug 12 17:05:15 2026 +0300

     buffer.h: Fix buf_substring_len() documentation

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Message-Id: <20260812140515.107442-1-razvanc@mailbox.org>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38289.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
