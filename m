Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA16AC44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pzxmmfn5qgy6MpiQl0b3A1p4ckxOq3coQDT/11Oz77E=; b=LS4tCwrU3DKwoajnh7frKmXc+R
	RTg5FN70V+pi4kMDQMBj0IhX7FVTl4flGgNBIQFFdOEJLL6+WtzlhVcqdEdGlk/NdRQjMVyQN14TU
	SG0sigj3HnkDJm8ALdaBJAQGkOGnreBwDA5FGaM8UYr/A/eLeP+u6mc9yXKcA2Iz6OrQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk3YF-00031Y-7s;
	Wed, 15 Jul 2026 17:37:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wk3YD-00031S-Km
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 17:37:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QnXAreh8GjBSxWBdtEEKCsFICSn1rvPHppz9OLamlpE=; b=BW42GJr5QJ/6mtDWYKvFSAJSb9
 ZE1h4dY8uYn7hTaIwZBhgj+nMDe2OL5STkmBLJQvKfcQDyeDoFoCihxNePZR6t1cVmzQmhJZl0Jqn
 ffJVmPoKVrV/c9oPDL9gADm+RmMbR8xdd0YYCA5v8JsXQTvxmP7qNLcXmgDbU3TA25p4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QnXAreh8GjBSxWBdtEEKCsFICSn1rvPHppz9OLamlpE=; b=nCt6NbaO9JKyOWPS/y2uCNu63n
 B0h+CHniO7gcoiYrCip6Fgq7sH7zaA868cG/7XW0DoUWWCn+VlsT6WoTuvAcfGnvPQQXZdHdhCU+K
 c7hASB0SuAoZoOZcXvzygll3QFRADuZZLYR+8x8QzG+muU0/u5j1k09oxMTAQGZEChto=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wk3YA-0007Zu-2K for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 17:37:42 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66FHbQXC089207;
 Wed, 15 Jul 2026 19:37:26 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66FHbQqF089206;
 Wed, 15 Jul 2026 19:37:26 +0200 (CEST) (envelope-from gert)
Date: Wed, 15 Jul 2026 19:37:26 +0200 (CEST)
Message-Id: <202607151737.66FHbQqF089206@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260708153107.60809-1-frank@lichtenheld.com>
References: <20260708153107.60809-1-frank@lichtenheld.com>
X-Headers-End: 1wk3YA-0007Zu-2K
Subject: [Openvpn-devel] [PATCH applied] Re: Replace strtok with strtok_r
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

"Code proofing for the future", or so.  After a bit of discussion it
was decided that this only impacts -Werror on Android, and the Android
app is only built from master, so it does not need to go to release/2.7
("for now").

Passed all BB tests and a full t_server run, plus good stare-at-code
and a "make distcheck" (= new files added tend to be forgotten...)

Your patch has been applied to the master branch.

commit 27df276eabdf87ad97ab88e8e84cc53d2bbc59c8 (master)
Author: Arne Schwabe
Date:   Wed Jul 8 17:31:07 2026 +0200

     Replace strtok with strtok_r

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1679
     Message-Id: <20260708153107.60809-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37538.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
