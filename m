Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC56DCD4851
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lFeiR7WG6HmKhHmXhv8sQRlU8FEuyKOxyRUvNXH5tdM=; b=Ol8+mNDiwuxtooT0yGptgiTB7w
	neroLCHZQpqBN1dAbFVXaQY5uWpySRjv70I6fk9/GrS61adfyhaYE+t/uxYjIIPtCvpbSUCjNC1cm
	kl8CgKqlbwuanoIHWV4R7GnQcDk8vwzuXkFy/TrZkmcXGQuXpq1jVumtBI814CswfMSk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMnVf-0002NW-Cl;
	Tue, 12 May 2026 13:50:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wMnVd-0002NO-H4
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 13:50:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6vFehSdP3XLYoXk/yDNtOEXsXDGroxjzycv1ls08JxU=; b=CNPPvb0DWcyrFCBZe63mqRxqSU
 38KmZPaJ12tA8IyWG7xez1V+UrVauHzmq9wVqMwRkSz1+RVo5XMjlUeHIullI6hKXmYv8iqTV2GMb
 89gMNwN3qb0A0DTRrLXLGGwvx8SH8Mp4d4QrAfnIO5m8t+n7XXZBICXQoCvreqVJhz6M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6vFehSdP3XLYoXk/yDNtOEXsXDGroxjzycv1ls08JxU=; b=Q+IPPlm5H+UZZ09PjEgl2bxhBL
 NT3bS/PU239ypfDF/jWIOVNXU3T1pQeTp56sb3fe0HqMLMhl8Zccbj5utmOhhDDw8emwnwUjZQl4i
 Nx26yKWaglFlfVv1K/RpaiDcxB1wvvt5AqUyZKapV9OslKpP+zZLHXRnfAeK5LM6wmdE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMnVZ-0003CU-RP for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 13:50:53 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 64CDoPf4059134;
 Tue, 12 May 2026 15:50:25 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 64CDoPtW059133;
 Tue, 12 May 2026 15:50:25 +0200 (CEST) (envelope-from gert)
Date: Tue, 12 May 2026 15:50:25 +0200 (CEST)
Message-Id: <202605121350.64CDoPtW059133@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260511200645.24711-1-gert@greenie.muc.de>
References: <20260511200645.24711-1-gert@greenie.muc.de>
X-Headers-End: 1wMnVZ-0003CU-RP
Subject: [Openvpn-devel] [PATCH applied] Re: route: Clarify operator
 precedence in a & b ? c : d
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

Thanks.  This is not actually fixing a bug, but improving readability,
so very welcome.  As it's not a bugfix, only applying to master.

Test compiled on MinGW.

Your patch has been applied to the master branch.

commit 9beebd0a80663550b187c6e2f54d8b2f6bfaaf25
Author: Frank Lichtenheld
Date:   Mon May 11 22:06:39 2026 +0200

     route: Clarify operator precedence in a & b ? c : d

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1668
     Message-Id: <20260511200645.24711-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36880.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
