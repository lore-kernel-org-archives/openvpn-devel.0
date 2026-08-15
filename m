Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCE0C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Tmub4lTHiyThsEZR2w0ibp7QHEsNoKifNnjuaLlz8E=; b=EVFfTuQsBgSZepgFVp2ni0NDiu
	nC/D4O+qbBXTkAqWlH5DLP2u9NTDbjbxY6/f4DKlnZ0c5QQTw13sP6qqfn9arO4LRjdam3inluuqe
	a+SFWWCkUcCtSabZjzySOjo1+fV/j2ZyDjXKR2uNd9w5MqLLlUfMs7NUUp+pFPWVRNr0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvKRh-0005T8-C9;
	Sat, 15 Aug 2026 19:53:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wvKRf-0005T0-SS
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SHk0LwvBoow8CJcVaGlxJF9vj5MspcP9na7xhK5Rg2U=; b=VIG+D+QfPxFZj8t26RcoQxA5Xz
 jfgnEVeJI23gF1m3E9c2tfioqvoLtSWZoT5axXhrbGPGBHu0o7Qk1tyJE/TVIb0BICIEiVPoMjanS
 BUYmDbBssBhgksoYE9JQaZ1ybPB7F+SIzDaRHDYEaN8Z49jWjmHQj3VmajAwGKHulXD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SHk0LwvBoow8CJcVaGlxJF9vj5MspcP9na7xhK5Rg2U=; b=FoGKH1EjP3LZfMZ5VC57yW91NN
 DHvAWTEj2YeBh3qpX8pcb9oMBjuKqvWbpvKMsBvVb2oHZMgSMMR8q1fkPVISu/THz78CIYXceFeZt
 whCWDHvR2fMcQMlWCUTQ/GojxatmFuPuS+yYMLXWMt/7kfdUjx3ZxO9pVV267P/MC/c0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvKRf-0002kh-N8 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 19:53:29 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67FJrDf1076780;
 Sat, 15 Aug 2026 21:53:13 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67FJrD5s076779;
 Sat, 15 Aug 2026 21:53:13 +0200 (CEST) (envelope-from gert)
Date: Sat, 15 Aug 2026 21:53:13 +0200 (CEST)
Message-Id: <202608151953.67FJrD5s076779@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260815130619.20187-1-gert@greenie.muc.de>
References: <20260815130619.20187-1-gert@greenie.muc.de>
X-Headers-End: 1wvKRf-0002kh-N8
Subject: [Openvpn-devel] [PATCH applied] Re: platform: Add function to
 determine temp directory
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

Sounds like a good cleanup effort :-) - tests still pass on FreeBSD & GHA.

Your patch has been applied to the master branch.

commit ab630a14940faf45285473bb9f94ddf1f429ae7a
Author: Frank Lichtenheld
Date:   Sat Aug 15 15:06:12 2026 +0200

     platform: Add function to determine temp directory

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1780
     Message-Id: <20260815130619.20187-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38408.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
