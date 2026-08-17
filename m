Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AECC5DF7D
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pSTNXN3hq8iH1TDigGQIMVTV3bRNkbY5J4x0c8ov1o4=; b=RklFp5IwPZQJBxtl27gfz6VCsb
	zzkwRN+5UsW9JHhSLbkBybyBixy8JmixqFPr8DZByjzDdFC++ZU78mxetv5VcbcHH/JYgOVu29nBX
	ZTrdJaXbaz7q5LdAaAx/6ySNVjHiRNcom6UDg4MM/It/Nbqa2niqAPRQ8M7zdqdD9va8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ww4K7-0001So-7l;
	Mon, 17 Aug 2026 20:52:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1ww4K5-0001Si-I9
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 20:52:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fxZARZjRKH0YYlGm29mc4GwRwgLorjWu0HgOdiYvJZo=; b=DrJZbi17nRw5T4Yv/MZ5TUIwTs
 Y1hwsRhCyrJCgou6m/S4/PNX8KkdHCTn4caTtdxbTkx92lOn8SEt21APKk+NpFCl4WfQ1erhia2g8
 toyCXbzaG5gJ1E4+d+eQK/cRBFkpuAUG8klLviFSYVDmjKEofOOYwRG78DPmWS1vbELg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fxZARZjRKH0YYlGm29mc4GwRwgLorjWu0HgOdiYvJZo=; b=SYThnweprpoC6qD1GRHbEtR9dD
 Y3Fk7nOM2LT17blGfXVXTONT/b28gP0UTrJmyYaUPLJdd6Q5n42Tajk4vDlAMIHCDFVn6/jUeHGxr
 ZRxZ2c0zyU+vJgs1epXmzeJ/J8xfcJB2WhgqS4AF1nwjqbSYw0mPg8/6bowkT9MpygZQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ww4K8-0003t5-BC for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 20:52:46 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67HKqU9i040867;
 Mon, 17 Aug 2026 22:52:30 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67HKqU7i040866;
 Mon, 17 Aug 2026 22:52:30 +0200 (CEST) (envelope-from gert)
Date: Mon, 17 Aug 2026 22:52:30 +0200 (CEST)
Message-Id: <202608172052.67HKqU7i040866@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260817161852.8376-1-gert@greenie.muc.de>
References: <20260817161852.8376-1-gert@greenie.muc.de>
X-Headers-End: 1ww4K8-0003t5-BC
Subject: [Openvpn-devel] [PATCH applied] Re: options: Factor out options
 display code from options.c
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

I agree with the sentiment :-) - and "git show --color-moved=zebra" agrees
with the claim.  BB agrees that nothing got broken...

Your patch has been applied to the master branch.

commit 6d18f2ce2df00f9de37edf752391d2f462c9068f
Author: Frank Lichtenheld
Date:   Mon Aug 17 18:18:47 2026 +0200

     options: Factor out options display code from options.c

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1772
     Message-Id: <20260817161852.8376-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38466.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
