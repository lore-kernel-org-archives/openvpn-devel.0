Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C0ACA5FFF
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 21:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yyX2H+TAuXLF2SyV5nGIGyPcYA2mjFDvhSBa7AVqW5w=; b=KUnlZLFDIQXfTvkCxWSPZuTbGG
	SjVCkmXCQz+RTrgZRCJVxHnwAMzSkTHWx20+PcMCeMOduFg5cRR22+5SQpKJLJV72Tb+154ClTMAR
	tiXqQIveDBy8eoqk2pimb+biIpxNk6OWo/Y5bq/zM0dW5r9ZkhT0zGgUIw4oYUlbcewQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEZI7-0001lw-Vq;
	Wed, 07 Oct 2026 21:35:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xEZI7-0001lq-5s
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 21:35:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mN4OAsUz1Dj9pSRA92wC63ohQBqjExp3IyRZbqd8PwA=; b=JmOrlPqAL2B0lPX4PBDZtU6AEG
 Dh0JFf7JnZk4qLWK9+xL/F+moTYUoKimK23bCXSu2/8r3Din930D5ciIiDWjkzBMU0SjjIBxO9Pak
 foWLLmRqMKXIR6FyMQQXpXGV0Rful4xhF4AQM95kQftc36UImNqFwzl3mMJ/o3Pb3D+E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mN4OAsUz1Dj9pSRA92wC63ohQBqjExp3IyRZbqd8PwA=; b=MLcfjyTslhWDxZ+AWUJhA9uJ3d
 kwzfrR0dQay2gwuD37LNn2f//01eeOgGJRbNOjQDGv0j8TmwvJfM1C1gjOudid+/4m9Acf/6CSGiN
 VxYqNZKoAaMF0VyBP2pQlg/eW5YV690uZSvRzdd5G+k76JLgn8CH+Akvv2l9BaRMBGqg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEZI5-00021s-Mn for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 21:35:11 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 697LZ3sJ043902;
 Wed, 7 Oct 2026 23:35:03 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 697LZ2xG043899;
 Wed, 7 Oct 2026 23:35:02 +0200 (CEST) (envelope-from gert)
Date: Wed, 7 Oct 2026 23:35:02 +0200 (CEST)
Message-Id: <202610072135.697LZ2xG043899@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261007172007.23382-1-gert@greenie.muc.de>
References: <20261007172007.23382-1-gert@greenie.muc.de>
X-Headers-End: 1xEZI5-00021s-Mn
Subject: [Openvpn-devel] [PATCH applied] Re: reliable: characterize the
 packet id comparisons before rewriting them
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

Having unit tests in place before the grand rewrite of the code in question
is more than welcome :-) - they pass, Arne is fine, so in they go (since
this is in preparation for a rewrite, "master only", I'd say)

Your patch has been applied to the master branch.

commit 3a78bd3912607e5a62dad0453d5fc8bc37619073 (master)
Author: Razvan Cojocaru
Date:   Wed Oct 7 19:20:01 2026 +0200

     reliable: characterize the packet id comparisons before rewriting them

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1899
     Message-Id: <20261007172007.23382-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39760.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
