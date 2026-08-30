Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B547C61DE1
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3mB4OZMGRjJBB2u7kAAtyEgDyIRxc0c6+wJfk9R3IdA=; b=dRYqzlPpyGsnSLdmIKgcczviiE
	GrbWMOZCAPBvmFV+pRIqcdNtFvlqBkUIYpaiYXo6XK6jy5PK5SXyKCAEWAhEILQQHAgUxv82+6Kqw
	etwozzT65GCeLqm9qQvhCCElElLc1Z04x8NF7ZuLR98VACfVoZcQPUHTQPHYos1iEx84=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0igv-0004VF-19;
	Sun, 30 Aug 2026 16:47:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x0igu-0004V9-5L
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:47:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LofIo3PTjPstDClj0HwsURUxBgRj6QE7uYnsSsxoLpI=; b=lRwcw69onUlirxUFILV4/Nd43E
 GZOVR7b3AKcP1wWxuU9V4BCNM/b6BQ0I5EWy/YU9eXUmUkX1KXZ/R33OcHSyG5bim7KADSEHTIVP8
 vNhKOPyGakMO1xclNR03oBbsJUtHwIVnPo+jaeRpGhP04P+vxxmmuiXwBslN2tKZx5DM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LofIo3PTjPstDClj0HwsURUxBgRj6QE7uYnsSsxoLpI=; b=eRC/u2O/xIwkyxraQsqPy3HMxz
 lAa/3Sh4YSyHPPWuS79fyrsep6/qzq7vj5wI3mpi8MtRKRy4scppl7shkthtEjQ8ElV4ldeXj3SE4
 z4bVIeEG1WcI2itC7u3CWCsFnHRxuj9ZYrzzjYKHxGDxyxUbf0L0L3QGaowl0HlKdSpY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0igt-0000m8-9k for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:47:32 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67UGlO5g080328;
 Sun, 30 Aug 2026 18:47:24 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67UGlOMV080327;
 Sun, 30 Aug 2026 18:47:24 +0200 (CEST) (envelope-from gert)
Date: Sun, 30 Aug 2026 18:47:24 +0200 (CEST)
Message-Id: <202608301647.67UGlOMV080327@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260828103517.13327-1-gert@greenie.muc.de>
References: <20260828103517.13327-1-gert@greenie.muc.de>
X-Headers-End: 1x0igt-0000m8-9k
Subject: [Openvpn-devel] [PATCH applied] Re: Add helper method to extract a
 field from a buffer
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

Infrastructure work... not actually used yet, beyond the unit test
(which passes).

Your patch has been applied to the master branch.

commit 37527755efdcfd7d7b2d2092f6a5fda6143ae332
Author: Arne Schwabe
Date:   Fri Aug 28 12:35:11 2026 +0200

     Add helper method to extract a field from a buffer

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1855
     Message-Id: <20260828103517.13327-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38770.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
