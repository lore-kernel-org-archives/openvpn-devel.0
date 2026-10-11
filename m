Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF4ACA9ED2
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gFpcZ2m3IbK2TGsmb2t9rULDuEbcQ6hehtZGA1ie+G0=; b=IPJSP2kC3DZfkbba5SZUG3J/j4
	QvDi6U5nEA9wA2PYfexikVNtKX8Pa2iBPB2ejI4WWXZG4sGdkbR6fv3OJUOCbbWRT2kTNq1lDnQKx
	93d7dBkLXUSmE8HnwhCa5bbNzOz/sAEa4nDlc9CF02Zfk5ITpJsex6ahymijC2cfNihc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xG0En-0007IH-34;
	Sun, 11 Oct 2026 20:33:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xG0ER-0007HQ-3U
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 20:33:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z5EdIxSNE8nMRaGtvduNnec7+nLMc90KIOlLv2Wx4GY=; b=ihAib2gwgmtkqp/MV34bROSjs5
 u/bRmWYbTB/5ZlqzBXfBTftrnYVdaUumJY7o8+VN3IDuAr+YhlSr5gAHW6i2dXyH0Qu4ljnufM4Bn
 LVjXS8lLjgP+6SIVO94nWCBb5fvAIbA0h431S70BmdVPusx9nyWO3mHPwhg0CrZSm+ZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z5EdIxSNE8nMRaGtvduNnec7+nLMc90KIOlLv2Wx4GY=; b=bKlvDlYUr1C+npIz/f1yQTDp++
 zTyvRrEHZcJ9KmcrSWlxavs98J/u9wtmp2N0n6tvIGhFI+7/6cV1eyZ1i+G9gw03HVLkQANjIUelp
 zY3AGMWmazX4Wm4H+5PZD0sm6XzuHeWo+93Qa08heIYy3U9sWqrjeXSDObtnIQhWqblw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xG0EG-0003eg-FL for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 20:33:09 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69BKWrHA049465;
 Sun, 11 Oct 2026 22:32:53 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69BKWrEW049464;
 Sun, 11 Oct 2026 22:32:53 +0200 (CEST) (envelope-from gert)
Date: Sun, 11 Oct 2026 22:32:53 +0200 (CEST)
Message-Id: <202610112032.69BKWrEW049464@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261006142321.4601-1-gert@greenie.muc.de>
References: <20261006142321.4601-1-gert@greenie.muc.de>
X-Headers-End: 1xG0EG-0003eg-FL
Subject: [Openvpn-devel] [PATCH applied] Re: options: Introduce
 boolean_flag() and review usages of atoi_warn
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

Straightforward enough... let's see how many configs we break this time
(because someone put "2" there, or "false"...).

Stared-at-code for a bit, and ran local "make check" which does not
use these options at all (very sophisticated test!).

Your patch has been applied to the master branch.

commit 984a5d08e5838afd5db8987837327de731798886
Author: Frank Lichtenheld
Date:   Tue Oct 6 16:23:15 2026 +0200

     options: Introduce boolean_flag() and review usages of atoi_warn

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1151
     Message-Id: <20261006142321.4601-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39741.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
