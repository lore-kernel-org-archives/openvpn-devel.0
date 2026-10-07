Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0EFCA5FFC
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ey6EhlqrFL0NChOiV7DcD6Fy77FT+HPYfJ4pUyms9BU=; b=TCv3loOrqVsYjBQa3H+U8+KJJP
	sN/C0VjN8S1foWFMi9nMugsVjvQMMkE7LdUtxiq7NmAbp0mCOCvSGqnLItSRZr3LGFyA9tVREVbDE
	MnI4DrIcTB918Xa1HM+WiuAgQFHz0GRVJTiJ0XuXy27jmoLofzXr2Qz/N1STIngDwqzY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEVGn-0004eK-7a;
	Wed, 07 Oct 2026 17:17:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xEVGl-0004eD-VA
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=grnooD1WBhrrF9OTMpNzFuNg3ikrIQUszgGvTwESl+U=; b=OohqahgiNljxKXAfH3p4STitZG
 XANM/cBn43zreAFL2s1De/J/GcD7CqQqh2aJ0MG4R4t2TEl9rd0t3Jioc8jJtyYhXiQ85BLJaasl6
 WyoNUcf70Q8n9VW/58a39q6hNbRrVYXfqT5R0UljQzEQhCTbTajPwm3k0gebqLbYbRyI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=grnooD1WBhrrF9OTMpNzFuNg3ikrIQUszgGvTwESl+U=; b=FoWWsqBoWh4Un8pft968dgE7SU
 YESd9Hcrcue4sHESkyWlErxwM+/oF4WbNX7z/tLQKAcbJ38QWsZfXMM9oE2yTU4aQerj8ZWlCMiZY
 qN/Khh/oZiZCXRYfNEJnUhn95yKfG8SxQD0LjxkkZAuiQ2+2keTpkFT3vWrs3gW3/ogg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEVGk-0004d0-Ky for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:17:32 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 697HHFa8029776;
 Wed, 7 Oct 2026 19:17:15 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 697HHFdA029775;
 Wed, 7 Oct 2026 19:17:15 +0200 (CEST) (envelope-from gert)
Date: Wed, 7 Oct 2026 19:17:15 +0200 (CEST)
Message-Id: <202610071717.697HHFdA029775@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261006132012.30845-1-gert@greenie.muc.de>
References: <20261006132012.30845-1-gert@greenie.muc.de>
X-Headers-End: 1xEVGk-0004d0-Ky
Subject: [Openvpn-devel] [PATCH applied] Re: Add missing includes for C
 files and their own headers
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

Uh, yes... :-)

Your patch has been applied to the master and release/2.7 branch.

commit a1c4187364f14dc267becbcbdf60f16354d9d70b (master)
commit b7a7f1c2e7a5c00ac082321e22fdabde252b1059 (release/2.7)
Author: Frank Lichtenheld
Date:   Tue Oct 6 15:20:06 2026 +0200

     Add missing includes for C files and their own headers

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1984
     Message-Id: <20261006132012.30845-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39737.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
