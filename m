Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E31FC88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CE6dyjFrhwuRiH5tVem6aSxZGK3UBa39UWaLS/qywDE=; b=Vi8WEYJcewb3O41W9VGjHQKDlZ
	gY5POZBT01RbKv3f4SLoNi8oeuEibT1F7NEu6Q3ON3akyXxZFfBvmdqRhwBf2PSpUm3pA6cT0Icfs
	SyHqarEi0P4TJk/dBg4WomXhZQUUfV6bNiMy1nx74hOp7zfhFYvC+whOKr3G/7gI2QOQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x79kd-0004Cj-O1;
	Thu, 17 Sep 2026 10:54:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x79kb-0004Cd-3d
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 10:53:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FxQxiq5tqzZGivXLQvS/lYVXB17jdBAJSm+QMTq33/I=; b=cYvmajNQdgLSnmY36EiHDNoSZq
 RYLID1ho4wtlLkBiuVldjKYvLWA0g72grczY+UU/UAiwDE3U2rFT+N2OmLxhDf/i+26QBOWgamDVa
 ZLOg/JgChG30vrJwpxEnvVD1MdvjJgOgc9KvcJW+xLXhI3LIJbbj0IiS6SO3t1YpIgnk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FxQxiq5tqzZGivXLQvS/lYVXB17jdBAJSm+QMTq33/I=; b=jJ2t+B38CtuuSX65beiDPfkLgb
 qZAzBbSr89H2HdNtEUgqFA7LSi4z7mgjzhhnGMe0UJn1Yn0/4gzdSpi1+NMKghfDmySlN6akq1y8P
 fo4V9y0uvR0F5pWQ6A6xAuaKy2KjJUat0cgUE4JzJT5P8aa4tshgwcIPHTTblZZ1hHs0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x79kZ-0003Mo-IK for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 10:53:57 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68HArmC1064723;
 Thu, 17 Sep 2026 12:53:48 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68HArm7h064722;
 Thu, 17 Sep 2026 12:53:48 +0200 (CEST) (envelope-from gert)
Date: Thu, 17 Sep 2026 12:53:48 +0200 (CEST)
Message-Id: <202609171053.68HArm7h064722@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260916203425.21448-1-gert@greenie.muc.de>
References: <20260916203425.21448-1-gert@greenie.muc.de>
X-Headers-End: 1x79kZ-0003Mo-IK
Subject: [Openvpn-devel] [PATCH applied] Re: Improve auth token related
 comments
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

Yeah, valid changes ;-) - and indeed, a password string should always
have the format of a password, no?  - anyway, thanks for noticing & fixing.

Your patch has been applied to the master and release/2.7 branch.

commit 17f6cec06fbced967cb64338c83e902e949ece95 (master)
commit 4bdbf2f1f95e32c60897eabe68bfad3ae6dcca64 (release/2.7)
Author: Arne Schwabe
Date:   Wed Sep 16 22:34:19 2026 +0200

     Improve auth token related comments

     Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1918
     Message-Id: <20260916203425.21448-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39269.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
