Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A3ECCF2DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wq/ojOc/dL9lW01AXj49ejOlUwl5Z4G5e/kK5ijvwj8=; b=W1GxAdQaiPzbGBW+jeYspDg6sO
	+O5bCijl9YzIvtV7W5bNyOTM5Dv1jHviRXWEWHz+LPu1m9sjbU0norjjWlKDIqeBpK8WMGzRddpk2
	l2+471QQu0WyFqcpIDXFh+Kugo+hH9f1AY704eYiZgk0y7uF7FOPGVn8xKmd1o1M4LPw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIn16-0004Hv-EL;
	Mon, 19 Oct 2026 13:03:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xIn15-0004Ho-Ml
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:03:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k9dFOfxLSx5x5W1K4gAaVMHWxG6Wd7M9b74RChZ71go=; b=jdAD/fy3ut1ybYJArt4XSbIvU+
 +p9uQK23CICx3Po6WolVGE65rNzG3F584Oltk2H/oNnvaaBeHvTtXtlP7vlM8GFL0Czxz5tdjKt06
 32QWr4oUKw+HGl22tCU/+wyjdTuXp1v6qhMArCkNxaw4RrVxg2PjYq+kdZHyMqiaupPg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=k9dFOfxLSx5x5W1K4gAaVMHWxG6Wd7M9b74RChZ71go=; b=e0bSdfxgywzTqB+i6qVmcbI/T4
 OgqA8a/pNl5cvCqDXWodA7v8tGFOx1mZXYPyBGfWM7jYjrR3rAo+U4l7HJuHrWXVwRAA1u9f3HsPI
 PB/Zete+j6+zMjfWSEKYoYTT9Blem6C2fyUhOjb95z+XyP6i1+SPUxQgNFCUnqtWLPNA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIn13-0002C3-Hm for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:03:04 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69JD2kOL055827;
 Mon, 19 Oct 2026 15:02:46 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69JD2ktE055826;
 Mon, 19 Oct 2026 15:02:46 +0200 (CEST) (envelope-from gert)
Date: Mon, 19 Oct 2026 15:02:46 +0200 (CEST)
Message-Id: <202610191302.69JD2ktE055826@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261018153738.23274-1-gert@greenie.muc.de>
References: <20261018153738.23274-1-gert@greenie.muc.de>
X-Headers-End: 1xIn13-0002C3-Hm
Subject: [Openvpn-devel] [PATCH applied] Re: misc: Avoid conversion warnings
 in parse_auth_challenge
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

Discussed this with Frank - it has one actual functional change, work_len
is now the "real buffer size", given that this is what buf_parse() expects.

Besides this, just integers :-) - BB green, Razvan happy, in it goes.

Your patch has been applied to the master branch.

commit c005931524986bdab3e4f82b8b41756d49c24950
Author: Frank Lichtenheld
Date:   Sun Oct 18 17:37:32 2026 +0200

     misc: Avoid conversion warnings in parse_auth_challenge

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2004
     Message-Id: <20261018153738.23274-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40030.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
