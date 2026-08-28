Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73B6C61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KLSWxlOlqvv7KbGnTNG/TMwnqFebJi5lB9IZToT3gk0=; b=It7Z5wb3NsFQ73SDRnTZx5/NGi
	+rsATntmMLdy9CDGrBUXOp5OUUkaa2Gg7KKM9lRg3WGj4/cKyJ6ws+h8bEcu7mQ1Cgw2nAF6Z0Jk0
	7tmy+x3S1hVS4sqDc0H1NzUGTVwgmSyJN3Y7cLYn5eeNCHselk/kGbWfXzehY7yp7t4M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztto-0006TM-SM;
	Fri, 28 Aug 2026 10:33:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wzttl-0006TG-V3
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kdMnYRkSLr4YMsXaha8xQcUes4mA4pOFmLFzgJY/6lc=; b=WaxyprNlZ6dPoThDcxX3XaV7Eg
 /O3/d4+OJGYckUzik/oXdNiRO5WxQWM4ViJThrj31U9vbzllF7+z55uwNs74D68TrUT7UOv/VqrbQ
 WvLQGnULSfIu4f5aY6YIWSw1ysnLyWNR7N3T5plM+4s1GFDMEGb09YgLgMVOP3COFGB8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kdMnYRkSLr4YMsXaha8xQcUes4mA4pOFmLFzgJY/6lc=; b=BlMErAIbZITIPx/pOK+3WucSwA
 8QiuxpmOZ8XXA1Dh3vEX9rMrcFP6lwudWeBNwFcqLpp5Ozc/pdSC8sMEgrAD27GRc54WWUQuDuhXJ
 fHoy2iTmBQQoWIIoQWX+XLIoMinxBGgvKwini8lM8QqA/1bjXgJq5MP6O/6IUtWnJTxo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzttk-0001Po-Qk for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:33:26 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67SAXI1Y085768;
 Fri, 28 Aug 2026 12:33:18 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67SAXIsw085767;
 Fri, 28 Aug 2026 12:33:18 +0200 (CEST) (envelope-from gert)
Date: Fri, 28 Aug 2026 12:33:18 +0200 (CEST)
Message-Id: <202608281033.67SAXIsw085767@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260826185248.17995-1-gert@greenie.muc.de>
References: <20260826185248.17995-1-gert@greenie.muc.de>
X-Headers-End: 1wzttk-0001Po-Qk
Subject: [Openvpn-devel] [PATCH applied] Re: Add mock support for management
 messages
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

This "in itself" does not yet add functionality, but it lays the groundwork
to unit-test management interface stuff - which is very welcome.

Your patch has been applied to the master branch.

commit 269da702816e8ee9bce595b2444aa9997a34fc5c
Author: Arne Schwabe
Date:   Wed Aug 26 20:52:43 2026 +0200

     Add mock support for management messages

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1857
     Message-Id: <20260826185248.17995-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38745.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
