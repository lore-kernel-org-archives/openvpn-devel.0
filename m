Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E52C5DF94
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zlrZnr7cqr+5adjUhAs92HSoPhQZYh4Dw3+IeFbfYwM=; b=gqr9Gly0lVP7v3YZ+KfXkANj7v
	jrrDes57bQ8/zmzGwjgTz2v1w3Hzu+2s2sAklnDr7X7903IqHztjdwmkqWyW2nerl1gIYgQk2Sd0S
	K75ftDdgK2Iu5D07a6rvdJP04prLTtIP34WkKv/xghBbx8v3l95kF376uDeR7fg/PKcA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylfZ-0002Ef-Em;
	Tue, 25 Aug 2026 07:34:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wylfX-0002EX-Cd
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:34:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aqKEFCl4uOqbTbfPGhoGpKQRgbPzGu5e6DJx2ixDZ9c=; b=jTYsLmsbb5623h9NvLJ63ZYRot
 KXP1fK9l7qj0gbhgMeyzsxrqBzM7Y71EatVpJ+MLikGy4YqvdGUqh9WM+ntYvdG6oAsFIlNI8+aNV
 014mb2Uyq6U1rnOeBf035lRQrU02PLYiOrd0jZrxH9UfrlPX3MeZ8lY79rJVYaIlIQ/U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aqKEFCl4uOqbTbfPGhoGpKQRgbPzGu5e6DJx2ixDZ9c=; b=hUeh4Jlt/0rtCva55/oFeW/O4O
 WgX5DnUfJM11u3LLuSz5F8VDl97QNbRiLwDjO3dE69TDndbYMMMxH/3u2dws9FOFmCsBuIrriVaVy
 1tKDN7+8bFh+VktdFuIrkcuBlR0/+mmBebDS/yn6dvuQxcJg/J8DNhUhvWpMp9KXOzO0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wylfW-0007Gc-Gp for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:34:04 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67P7XmEB055180;
 Tue, 25 Aug 2026 09:33:48 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67P7Xmtg055179;
 Tue, 25 Aug 2026 09:33:48 +0200 (CEST) (envelope-from gert)
Date: Tue, 25 Aug 2026 09:33:48 +0200 (CEST)
Message-Id: <202608250733.67P7Xmtg055179@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260824161431.1639-1-gert@greenie.muc.de>
References: <20260824161431.1639-1-gert@greenie.muc.de>
X-Headers-End: 1wylfW-0007Gc-Gp
Subject: [Openvpn-devel] [PATCH applied] Re: route: Remove unused function
 print_routes
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

These functions look like they could actually be useful to print stuff,
but if they are not used, *and* are IPv4-only, to make them actually
useful would be a bit of work - so, out for now.  If we want that, bring
it back, v4+v6, and all the newer flags (route-table, etc)...

Your patch has been applied to the master branch.

commit 47ec9ef53cfaaaa119724bfb03d152b5f98bd269
Author: Frank Lichtenheld
Date:   Mon Aug 24 18:14:25 2026 +0200

     route: Remove unused function print_routes

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1865
     Message-Id: <20260824161431.1639-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38636.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
