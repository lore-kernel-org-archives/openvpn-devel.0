Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D554C5DF81
	for <openvpn-devel@archiver.kernel.org>; Sun, 23 Aug 2026 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aWIal7At7XMAu6HlMowbsPyh2OaTobCxpNrpU6t7ygM=; b=Jm5UNkb8R4AQed4ZsCeDnWnVIQ
	p8GhcfkIq4TEmmNAYx0UezixL30JULj9rLzWbcfD2YFXha+OCtlsnmkH5hCrPUVeoO/xK/zHE/ASM
	BA7M1ZJV3UIw4OPt9OQCAc8qA0tGXQsKIGGgHmcy8RO3xX6YYFsq5dBHGbBNKQ3hW1yI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyDkl-000469-1X;
	Sun, 23 Aug 2026 19:21:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wyDki-000461-Vu
 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 19:21:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9P6nRNwqvIIl/o1mFip2+YtKfXc8K8pGCDUusYNasGY=; b=j4UYgiKQOjualLGDRBlQ4Z/HKM
 vxL5nNAAeNzw/ul0oLUxpOZNSnoyruGJrYi4MJ+k4cZgN22sEcKIhOsZyrxADuAIgvLsvbUKk+X4r
 TD2Blhz9StFb67LhmXitCTThgumhGDBwevcJRr9zpfaO0Sw4GHJW3UwqpWGI+HzyDQoU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9P6nRNwqvIIl/o1mFip2+YtKfXc8K8pGCDUusYNasGY=; b=RJGgTsZPbF3Nz7b3lhbMzOwS6J
 kMgKu5i7TNd3I7uJ1tijyb3H3POAot6p0CcGgBxJjyWRwNfSAcVf3FMG0JiBCDaAQ149Iw0NogDHI
 QkoqpRDlJxbr0u5PwvUMZvNRdCOyWcPL3CJoTsbTcNcfhfFx4nBHP5KaMhFEfh9olu5k=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyDki-0006gb-53 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 19:21:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67NJL17C010985;
 Sun, 23 Aug 2026 21:21:01 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67NJL1h5010984;
 Sun, 23 Aug 2026 21:21:01 +0200 (CEST) (envelope-from gert)
Date: Sun, 23 Aug 2026 21:21:01 +0200 (CEST)
Message-Id: <202608231921.67NJL1h5010984@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260823145533.25183-1-gert@greenie.muc.de>
References: <20260823145533.25183-1-gert@greenie.muc.de>
X-Headers-End: 1wyDki-0006gb-53
Subject: [Openvpn-devel] [PATCH applied] Re: Make pull_permission_mask
 return uint64_t
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

If both BB and Razvan agree that this is the way, I'm happy to go along :-)
(did not test, just glanced over the change - interesting hack on defining
OPT_P_DEFAULT, though)

Your patch has been applied to the master branch.

commit be582b2d2688966335a6485479ce3b2cc4a19320
Author: Arne Schwabe
Date:   Sun Aug 23 16:55:28 2026 +0200

     Make pull_permission_mask return uint64_t

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1851
     Message-Id: <20260823145533.25183-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38599.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
