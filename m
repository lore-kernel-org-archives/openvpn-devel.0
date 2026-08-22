Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C90AC5DF9B
	for <openvpn-devel@archiver.kernel.org>; Sat, 22 Aug 2026 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q6yAmhloPi7MYAxv9lQdQJHJH7k1eDz9OgGQQRZf/Cc=; b=Xum67ilAsyrcSiq1joTNAOMBF/
	bWmPGT4undf9NCN6c/ORjyBASeEfhj7i8Pa0d1iwcCfBxV0XpoCifPCg4Eg2MlLzUNfDUssndEEV1
	J3eeBmm2x+tYlc1mcc8StXoStMhNyF8PGbUq6fl04xeWuVcDQ7IbLakdqooRMzWn8cEw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxo4K-0006ik-VT;
	Sat, 22 Aug 2026 15:55:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wxo3z-0006i9-KL
 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 15:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+TqX9hahOfC8SnU3aMyPu8ig6AhbSKi2VTPzNhJghqI=; b=YxTh7PUssf9XCkzdqZF6zxy8e7
 zerNiJUh9k9vwuTr4Ky3y4qq49oF6FmYI6PtTbF6YnTe5zeHzmrSzSy5/nLF66ykI40VnxqjtBVDU
 72prP0mS3709NoZVZiHDUqLI31s51Uq8PJQ9i6mEYzSyTQ3cJ1XZ7K/F4P407gNPXb8k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+TqX9hahOfC8SnU3aMyPu8ig6AhbSKi2VTPzNhJghqI=; b=iTitqrzLDhisNMPFR2W0lV8tCx
 Veuwp7EAd+197vz51lGE5Bd3EI0Ksk85xdWCkkNhYcLFS6amtbOXIJab+r6QZnGEvgiFzCrTSXFBM
 sTrFLZCb3iRFsYcEeXRtgAY9Pqqu8YIZKJcAqbRRK3TIXV4OomE/gwc8XpE0lxjREJPs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxo3l-0003HM-U6 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 15:55:07 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67MFsw8N056355;
 Sat, 22 Aug 2026 17:54:58 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67MFswut056354;
 Sat, 22 Aug 2026 17:54:58 +0200 (CEST) (envelope-from gert)
Date: Sat, 22 Aug 2026 17:54:58 +0200 (CEST)
Message-Id: <202608221554.67MFswut056354@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260821182442.13542-1-gert@greenie.muc.de>
References: <20260821182442.13542-1-gert@greenie.muc.de>
X-Headers-End: 1wxo3l-0003HM-U6
Subject: [Openvpn-devel] [PATCH applied] Re: clinat: do not adjust UDP
 checksum if zero
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

This is technically correct.  There are caveats for IPv6 (namely, 
zero is not allowed and a receiver is expected to drop packets with
such a checksum, RFC8200 8.1).  If we don't drop, but also do not
modify the field, we're not violating this rule.  On transmission,
the 0x0000->0xffff still needs to happen, so this code is correct
for IPv4 and IPv6.

I have not actually tested this, just stared at the code :-) - and we
have +2 from Razvan (thanks).

I'm applying this to release/2.7, as it's clearly a bug fix.  I am not
backporting to 2.6, 2.5, 2.4 etc as it's not a security issue, and the
first report we ever had was in May this year - so it seems to hit
infrequently enough (plus --client-nat is an edge case anyway).

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit c797db6225755e6d7144d433ed55d3992d8ff141 (master)
commit e1d0005ec1a15fffbebc14fcf42ad36332e3a36a (release/2.7)
Author: Antonio Quartulli
Date:   Fri Aug 21 20:24:34 2026 +0200

     clinat: do not adjust UDP checksum if zero

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1681
     Message-Id: <20260821182442.13542-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38581.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
