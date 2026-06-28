Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F03BC43458
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/1T6ZmtGOojIRNsffcyzxNHwxh5jHbcwXvDcLNo6TU=; b=DitkeeThOtAruhgjXbEcUfucB7
	BSK9kRr9GCUkXu5tLEp6jjYb+D7FGozV3UGad+rYF0Mz1ZwwhNVvO6V0FIw9if95uK8gw7ytLOD7N
	NthkUFGbSWymjq9S9QqcmiXsQimYoiiTjYvhj4It3dQhtNGnfLlstk6kmyQKUGeadXGk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdqwi-0007Hv-R6;
	Sun, 28 Jun 2026 14:57:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wdqwM-0007HF-V0
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 14:56:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BBgDU7+28KnsD6e47ucN59Lyp5pOFDcK7OoKZTsmOCU=; b=Vt7XAObZAjBivkkOGBNpsc39yE
 HzV2toOUfpjp+QvHY4s9Fhss+YlFzxmXZAB5MDtPGi0uNzW/Mf1YHuzYZpG4xok74StIUjcdXTUEo
 6OLshmLPEj2eMiYA+uzCHRTzS3cYaljMDCscHFghGrWBskvZv3B+KqQTuRv4LEYDyJ+4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BBgDU7+28KnsD6e47ucN59Lyp5pOFDcK7OoKZTsmOCU=; b=T++YGMqM6kOmzYNFEBTSR+zT2U
 hhKlvC5w+7B4JDb03zysdb40/pdElqs0eSq3yM4muRz0NbWVJT6CpCJSFfKY6taiKNynPzq6QqAYQ
 3ciX9q36UMX5nnhos2lSjPf/QeXcW3kfhobi6jOY7F1snzvBb2eQQzTt+dtRomxgvcuo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wdqwD-0006FM-DO for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 14:56:52 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65SEub8C008517;
 Sun, 28 Jun 2026 16:56:37 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65SEub8m008516;
 Sun, 28 Jun 2026 16:56:37 +0200 (CEST) (envelope-from gert)
Date: Sun, 28 Jun 2026 16:56:37 +0200 (CEST)
Message-Id: <202606281456.65SEub8m008516@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260628130500.26086-1-gert@greenie.muc.de>
References: <20260628130500.26086-1-gert@greenie.muc.de>
X-Headers-End: 1wdqwD-0006FM-DO
Subject: [Openvpn-devel] [PATCH applied] Re: Extract
 handle_connection_attempt from multi_get_create_instance_udp
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

Basically, this is "just split out a large chunk of code to a separate
function" (trivial enough) but "git show" is not smart enough here to
see that ("--color-moved=zebra -w" *should* but isn't?!) - anyway, stared
at the code for a bit, and ran t_server tests.

As this is "refactoring" and not acutely needed for any of the pending
bug fixes, I've only applied it to master.

Your patch has been applied to the master branch.

commit 1572ee902f1d1ad75c1ad621ddcdc8bc80a5d522
Author: Arne Schwabe
Date:   Sun Jun 28 15:04:55 2026 +0200

     Extract handle_connection_attempt from multi_get_create_instance_udp

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1720
     Message-Id: <20260628130500.26086-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37336.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
