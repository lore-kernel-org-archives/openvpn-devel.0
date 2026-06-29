Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049D7C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mnvGklY0tcp3eWeYyTDaqn7plPE4y4ooToi+S5osGGE=; b=Ma4Ij219H+g+qea1dw55VbHyxz
	Msz3yLdAGZWA8nckJc+qXbPkYfm5HWgv4r4sWSs3yTPGWDFu5AdomRsX8/npwJNTRsy0f7MaoqTSd
	L7FqawCb3IMads78+94US9WLTzOztOAycHYmK/+Wx1ydUq/SKLcOSriVzfwgi5U9nBCw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we5vs-0003Wi-NK;
	Mon, 29 Jun 2026 06:57:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1we5vr-0003Wc-63
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 06:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K/CwAVfYdvF7la5mpUGWXodbclMB/bdlHwJI6sWStpc=; b=Cv4H2IHElJze3HKBFWiveDofDC
 0EiRmLdhmIAQU8zR6shcoC11pEGAoH7X2Z/uJ0utnPbRja+h9vYTsdMOVjmqZupimCaRA51093B2h
 yq7f1OrldQF6WI0mdlLmkyPv2A7Iq5HWkTjmNVlRt7Blsb08CxNDYWf7L1wBAwJlaoE8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K/CwAVfYdvF7la5mpUGWXodbclMB/bdlHwJI6sWStpc=; b=ermkUwySK3r2xisfVL0PYxX6vp
 bOviuqewqzg+nEG9ZDnabybqPJaJffPrwMhhF/RbkrDhkrCkqRoEf4JqqnX0XmenIlyisni0BoDMo
 xkP5AgKC5Qa7a4BRV/eqBSqtGvOw6OB9+y8RLsfIx7AK1kXtTWdqekXywr9FncpDuvLc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1we5vo-0004W4-LA for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 06:57:27 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65T6vDJ0009915;
 Mon, 29 Jun 2026 08:57:13 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65T6vD5R009914;
 Mon, 29 Jun 2026 08:57:13 +0200 (CEST) (envelope-from gert)
Date: Mon, 29 Jun 2026 08:57:13 +0200 (CEST)
Message-Id: <202606290657.65T6vD5R009914@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260628210033.4583-1-gert@greenie.muc.de>
References: <20260628210033.4583-1-gert@greenie.muc.de>
X-Headers-End: 1we5vo-0004W4-LA
Subject: [Openvpn-devel] [PATCH applied] Re: Change hash values in our hash
 map from uint32_t to uint64_t
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

Good morning,

another patch in a long series of code overhauls on the way to 2.8 - I
did not consider this "urgent", but merging 1572ee902f brought in one
piece of new code that assumes 64 bit hash values, creating a (false 
positive) integer conversion warning - so merging this now, to make
-Werror compiles build again.

As this is refactoring / future work, master only.

Your patch has been applied to the master branch.

commit d8536b34d39507a878db107a2098846faf932778
Author: Arne Schwabe
Date:   Sun Jun 28 23:00:27 2026 +0200

     Change hash values in our hash map from uint32_t to uint64_t

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1570
     Message-Id: <20260628210033.4583-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37349.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
