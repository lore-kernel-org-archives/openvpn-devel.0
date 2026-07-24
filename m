Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99783C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GWopKbduRHcobxwX5qRN3UqgFT4BzL75DS9LuPdBqMg=; b=EiVD8RpabAWhFU16xO7myvDTmV
	/WqfnoJ0m9otoWF4BxSbVbLPeGSxovrRfl5AnBUSSG3rsLN7mZNybFd84H3CqY+Vf1VtkGCb8UPGw
	izEHPfnYJ0aiWY8ZiBsy2ki7U5JJJYS9JOtIaGSfeHEak5euezekXD4/jNJzcopediB0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIiM-0003Nl-U9;
	Fri, 24 Jul 2026 16:25:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wnIiG-0003Nc-Dx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Eim4QUxTH7c4CZVLxmIMntUdXpVoeOmq+ppySgplgFk=; b=JfxLIxYpJto7mi2uzH8xMbojV6
 PwrIokNUk53mmpsmgPE6TBJ3PQXohv1NP1+tf3B+q+wd1CuxAWPQA+FLXZxGArpxf6Rw9C5gtsqN+
 Z8Xjw1o08FBQSa7RW4v+TbAjX+p1O+2Q+yuaYy1UtpkwI18YdvzmTtdtLLWdT9JOujgY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Eim4QUxTH7c4CZVLxmIMntUdXpVoeOmq+ppySgplgFk=; b=JTTg5f63ZS8hQBpglMdVMSdv+b
 25C/XeKLEptMA6fwopWF8p+rmsBtx/9NYa+d4vC+NK0opBBgRLQb++6SYZs7m4AeWpWUHRF1swjYQ
 qWayly+vJ0kKuCKTkM1O3MB18VxScV+a8xIBO7VjxBtP7Tk6R7opK7w/m1UWDMiiPI5w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnIiH-0006lo-Uj for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:25:28 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66OGPJhI048652;
 Fri, 24 Jul 2026 18:25:19 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66OGPJpg048651;
 Fri, 24 Jul 2026 18:25:19 +0200 (CEST) (envelope-from gert)
Date: Fri, 24 Jul 2026 18:25:19 +0200 (CEST)
Message-Id: <202607241625.66OGPJpg048651@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260723180445.17392-1-gert@greenie.muc.de>
References: <20260723180445.17392-1-gert@greenie.muc.de>
X-Headers-End: 1wnIiH-0006lo-Uj
Subject: [Openvpn-devel] [PATCH applied] Re: Silence warning with gcc 15 and
 O0/01
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

We shouldn't generally compile with -O0 ;-) - but sometimes it's unavoidable
for single-stepping complex interactions...

Your patch has been applied to the master branch.

commit b66d266e2ce556b3364769361586ccac0f66afe5
Author: Arne Schwabe
Date:   Thu Jul 23 20:04:38 2026 +0200

     Silence warning with gcc 15 and O0/01

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1731
     Message-Id: <20260723180445.17392-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37816.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
