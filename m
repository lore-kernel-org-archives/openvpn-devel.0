Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9EEC61DB6
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LLUZhJRp2KNGEnBUgH3yGjNuSjoI7VA4N2AYIl9B4Uo=; b=b9nIBfxqTAdYzT9ZtfVEzuDlQT
	Rdl6GcIE0z7FCMsNCjKzzbhuJnMLbhxXzNkolEGb1RHlSqqid+wkGtgf5tjWeNILl9ttcEjvKfM3z
	EBO+nJy/iUdSCFOcMd0AowUBnBvK60iUA7pIj21QT281FTWP3O46scn2L9Ty2Q84dRcI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wymBC-0003wA-Is;
	Tue, 25 Aug 2026 08:06:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wymB5-0003t5-TK
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:06:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WxSBRtjLE45e9LO9J67KoyYiy5Ilae0dQ9Yv/wJWvmY=; b=hWIBzd+tww+aStiNBT0OaWQhbs
 Gn2tea5mXwOFbPpYYyUPJzeU1/96Qq9AGDo9BiXAHZe6RThwdCk2lF1JtQ5aUnPZdbmEX7jnz14Ba
 DfwdF0y5r8KnZk9bJIqBpyEps5betZ+L9zq9qZYnQkCN8HoiK+eqcv1wmwzPDf6Rw1gQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WxSBRtjLE45e9LO9J67KoyYiy5Ilae0dQ9Yv/wJWvmY=; b=ZDvKzwoBm3acKMfkaAs3XPKEMu
 80bCganSqHCp+0z+NwTGmJm1GV+rSZB8fucsVuDzdZumI/C98KU0hDTyyYvFgJCyVkZyUJok0TZT5
 mdbZ7WShOX3GMvEN79CgPfV5xVN77Kp2B4deup4nbizSx8jamIlYNK6Vi5EyqUpI/kvU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wymB1-00008M-AP for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 08:06:37 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67P86K35064410;
 Tue, 25 Aug 2026 10:06:20 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67P86K20064409;
 Tue, 25 Aug 2026 10:06:20 +0200 (CEST) (envelope-from gert)
Date: Tue, 25 Aug 2026 10:06:20 +0200 (CEST)
Message-Id: <202608250806.67P86K20064409@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260818142252.27227-1-gert@greenie.muc.de>
References: <20260818142252.27227-1-gert@greenie.muc.de>
X-Headers-End: 1wymB1-00008M-AP
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Remove some useless
 casts on BLAST returns
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

This one is easy enough, and had a +2 "weeks ago" - but it needed the
big const patch (1661) as prerequisite.  Now and on we go... ;-)

Your patch has been applied to the master branch.

commit 1d818506d565af43c394ce0f5ba2420806401642
Author: Frank Lichtenheld
Date:   Tue Aug 18 16:22:46 2026 +0200

     buffer: Remove some useless casts on BLAST returns

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1845
     Message-Id: <20260818142252.27227-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38485.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
