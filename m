Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9DBC61DC2
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V9b3LsA8k7K+bsjozuOwIbZWPewiylk4YByd2Gwrwqw=; b=bsmeaDKybNb3tThOZnMt22fArC
	p9WjTAPNiofUgqnlUxUKdVgKJIkKPXBFwUTPUKdA+13+hx5lw9eOI75phualZYGwp+t+TWgb8bI76
	/gPLCLKLTv5oHw78VYwOtnObJlHdTMXKuwbr3NkLFtWLjyYdk2epDTOSkH/a1QgLhjl0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz7Yh-0004qA-5u;
	Wed, 26 Aug 2026 06:56:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wz7Ye-0004q2-T2
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T1+ygAk0ExgWqIkqv2iCS0foKhFVuulUSC+C44gG/4c=; b=LEOi1xODHF974skQWButd6q1ad
 sAU89avBRVnndwY0J1RgYJyvBsbg8U85vhQGXAoblSX8bBfw8qEIHZZujHtlCAiMfdXwaz/qvVfVr
 GpIXnNrCBYh8dNZOWCurCHU1qWW527iCAmJZzO8z6AHd3lTnnAAy8KyeuyLNpazJUb6s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=T1+ygAk0ExgWqIkqv2iCS0foKhFVuulUSC+C44gG/4c=; b=Hi0aclbkBN3XHbdJOQuQRFR0Pv
 k6HXvst5oS+kRKG/HjVeOudDxZL4SHnvWGvFNX0hP3mTEllTWfMwK+8+PEnCIGq4OLZmBGf2Q8U+s
 lYU9iXYJJlTN0qWg/SLlFHnZjDSNvK1369nrtpnurE3wLXilxsTAkn43VPUOfe7DWp7M=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz7Ya-0007ls-2Z for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:56:21 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67Q6uBYZ005725;
 Wed, 26 Aug 2026 08:56:11 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67Q6uB1S005724;
 Wed, 26 Aug 2026 08:56:11 +0200 (CEST) (envelope-from gert)
Date: Wed, 26 Aug 2026 08:56:11 +0200 (CEST)
Message-Id: <202608260656.67Q6uB1S005724@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260824180454.12181-1-gert@greenie.muc.de>
References: <20260824180454.12181-1-gert@greenie.muc.de>
X-Headers-End: 1wz7Ya-0007ls-2Z
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: fix log lines
 format string
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

Interesting find.  On most systems this will never fire, as interfaces
tend to be "Ethernet 3" or "OpenVPN TAP Adapter" or such, with no
non-ASCII characters... and even then, if there is no error message,
it won't hit these branches either.

Test compiled on Ubuntu24.04/MinGW.

Your patch has been applied to the master and relase/2.7 branch (bugfix).

Release/2.6 does not have the InterfaceIdString() function, so whether or
not to backport the bugfix (given that we do not intend to do more
windows releases) is moot here :-)

commit 4f4b0771574e85787b15dd45a85a889ce66c16f9 (master)
commit 840db527fa2ce3823d70c54e72568f8e83bd5f9e (release/2.7)
Author: Heiko Hund
Date:   Mon Aug 24 20:04:48 2026 +0200

     openvpnserv: fix log lines format string

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1861
     Message-Id: <20260824180454.12181-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38650.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
