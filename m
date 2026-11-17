Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F59606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Lv4MDRvM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ROSa/NJH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Z+h2y9+m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KJ3+e82/aNtuDILEdlEIWD80zsO40U8dpLIQKocohhU=; b=Lv4MDRvMON66FJ
	tJ0FKAayneb2nVvniWMrYjEy7B7CnZzjs+El+3t7eBHED3Nbs/+OAg+trS5Ti8I76iAMRlFONV27d
	BXnZu/riHThGVXG5xD5gxK9ZrY8LOiTnozcVJBlbDZ1zHKrv1iKn/rEQjYDsSmxFHUCwGUuiWgOih
	bRw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTJb0-000000006Jj-1fVM;
	Tue, 17 Nov 2026 13:51:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTJah-000000006J6-0ncH for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 13:51:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=77UUToTz0HYoMXpv3EZlhZRMgFkSqVyGEPajWMJuaC4=; b=R
 OSa/NJHZkBAUZjuGergZyx36o77K5zrqBhDdrjTaFZeZKcIZGxGHmP/yDOnpM8HccJf99UQVilE7R
 AQHgog08uMozPgOsHAQxTlHbosX2QFbMgB2p4OnTNgWNYTVKzu4uSWDfmlwpxjrglTLhFumDMnIWS
 HSPI+pjt/Lbour/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=77UUToTz0HYoMXpv3EZlhZRMgFkSqVyGEPajWMJuaC4=; b=Z+h2y9+mUcCXN6JA0aW5V6jzv7
 aMie43A6flJReFbLtIdFBzQttb3C7yLBi5DjZGdXFORp6hxJD14499Xj4lmiPEEYOK1ACvYe8lDx/
 cNOl0Jie/n16WduLYF/tpNFeN8Z60av1wzHrSFkoQtFXIUioYcNZCYydGMzoRnt99peE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTJaU-000000002tK-0Np9 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 13:51:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AHDoxBX021329;
 Tue, 17 Nov 2026 14:50:59 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHDowER021328;
 Tue, 17 Nov 2026 14:50:58 +0100 (CET) (envelope-from gert)
Date: Tue, 17 Nov 2026 14:50:58 +0100 (CET)
Message-Id: <202611171350.6AHDowER021328@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261116173725.24585-1-gert@greenie.muc.de>
References: <20261116173725.24585-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTJaU-000000002tK-0Np9
Subject: [Openvpn-devel] [PATCH applied] Re: crypto: drop redundant epoch
 assignments
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Well spotted and nice cleanup.  Nothing broken, though, so no need
to go into 2.7.

Your patch has been applied to the master branch.

commit 08f9865d6df33b9e4f253edf3a4152ca1cbdb803
Author: Razvan Cojocaru
Date:   Mon Nov 16 18:37:19 2026 +0100

     crypto: drop redundant epoch assignments

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2190
     Message-Id: <20261116173725.24585-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41475.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
