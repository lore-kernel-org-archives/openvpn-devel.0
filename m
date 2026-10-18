Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9DECCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S7gPScorvcw409P6BAWBC8uXtpsNWe1T8Zdad2GRICY=; b=ktBMFx5DZK98IAII1CM9ujUnbB
	3uPSd9tOR07c4zAu3lWuk6gHf705ATVlGftrExAEHCViJ5IDItatdBnbei7Jb4/9K4D3SUKQhZhYw
	s6YrzfNiFd4hf8jesTVjCCzuULFeYeNGdTWwPwQUlrhr5lh2gEJKURW7djmIxh+ybYPk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xISW3-0001SJ-43;
	Sun, 18 Oct 2026 15:09:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xISW2-0001S6-0k
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CFvfdkAlMshmkHaKqcvrnl1Fb37d4vV18HxluQUen50=; b=UQystLhsNfXH0UVDMi3FNke3ih
 25aJVZh0jb6tDwEtdZR+FZy7FlrCddrLej9JTfOylmJEjZ/r4a5Y8oN8/i0uMBErmwyfsE0iVI1he
 Ida91X93uDDANHMjFhGoP0DAE6/r3owvQF+OQZfyl/yuDZcFZb40e87XAGin6cp1lEfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CFvfdkAlMshmkHaKqcvrnl1Fb37d4vV18HxluQUen50=; b=RF321AKr7xpJRiUZ/m7NRYpiaS
 5buGO+HXgSpUGkkRU9TM3qJtTjknFJDKMq/e/mab0JL5vuD7joFBetPg3cV+FyuwO75TqUCSibWcC
 36D05S67fu8AXgzYHz2alD6sFdwCwSqV5PD8ROS5AFFgrpZ8fP87gmDFxtv1LW/MHEV8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xISW1-00013l-4I for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:09:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69IF9UWT034133;
 Sun, 18 Oct 2026 17:09:30 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IF9Uuj034132;
 Sun, 18 Oct 2026 17:09:30 +0200 (CEST) (envelope-from gert)
Date: Sun, 18 Oct 2026 17:09:30 +0200 (CEST)
Message-Id: <202610181509.69IF9Uuj034132@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261013194518.30653-1-gert@greenie.muc.de>
References: <20261013194518.30653-1-gert@greenie.muc.de>
X-Headers-End: 1xISW1-00013l-4I
Subject: [Openvpn-devel] [PATCH applied] Re: Move check_session_buf_not_used
 method into the method that free the buffer
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

This is the 2.5 backport of a long series of backports :-) - Steffan has
looked long and hard, and it survived a "make check" t_client run!

Your patch has been applied to the release/2.5 branch.

commit 592ee5036d5931e0aefa536cb3e5494d8a2b9dc3 (release/2.5)
Author: Arne Schwabe
Date:   Tue Oct 13 21:45:13 2026 +0200

     Move check_session_buf_not_used method into the method that free the buffer

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1893
     Acked-by: MaxF <max@max-fillinger.net>
     Message-Id: <20260903061209.12599-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38913.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1985
     Message-Id: <20261013194518.30653-1-gert@greenie.muc.de>
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
