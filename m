Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443E606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QcEeDwkC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TFpdZF+X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jr8Vj8UG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bt3DpCo3DOohZbIeli6F6ns1asL4wayByL0o6WL7Ygc=; b=QcEeDwkCCskJA9e4VX1exemyfI
	qR5RprDJ+VJw4rpT4nI9ntzWIJWmO171l9JVcZgykUlM7D7E207mpu9ENjphQveRuI4Jcteoq62LH
	f4WK8e8FU/+VV0shE6bLH6UThcRE892HpZAiyRmMc0Hkdnd+aJQ9eDhEJOURHFLg6LNg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJBHi-0002D8-Kz;
	Tue, 20 Oct 2026 14:57:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xJBHh-0002D1-Hl
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 14:57:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t4c4omXP5E8wD2cse6G20d6hb29SrKFnTMYQO+MfJ84=; b=TFpdZF+XdTiWAQ21nlXnZl/ep0
 4xM7bfXcWVwK1TXh7FBkoVWVN/yGS5JpBEpKe3S1ESvqwugzJIssw7V7d3TZ/0JRtsTxzFN7c4Im3
 N7Wgmkko5dNVfdw7vYFKq2KCgiGSQc/T+DKdgvB87DDbQoUGJpSJnfANV5Xa4PLnjarg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t4c4omXP5E8wD2cse6G20d6hb29SrKFnTMYQO+MfJ84=; b=jr8Vj8UGuhnnrfLJc/e0Nl2IAB
 njbCqv0gd1O7IUuN2DQaLabi9KVos+O+U2/ZC4BPuBov4mq/kRLTr+3U9R4uurnUfluMfPTwsYeAj
 1vbqPGUOdqSHnQIPCwL81ejMGSLhu18zJO+zPOJ4vcTvz3AN7ncSNg+li2yolbwn9DJg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xJBHg-0007Us-Cn for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 14:57:50 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69KEvWL6023882;
 Tue, 20 Oct 2026 16:57:32 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69KEvWn1023881;
 Tue, 20 Oct 2026 16:57:32 +0200 (CEST) (envelope-from gert)
Date: Tue, 20 Oct 2026 16:57:32 +0200 (CEST)
Message-Id: <202610201457.69KEvWn1023881@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261020131943.24892-1-gert@greenie.muc.de>
References: <20261020131943.24892-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xJBHg-0007Us-Cn
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Require automake 1.16
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This makes sense, and even our older or even EOLed buildbots ("NetBSD 8.1",
"FreeBSD 13", "OpenSolaris") can handle this just fine.

mail-archive.org is having issues again, so linking to lore.kernel.org
instead.

Your patch has been applied to the master and release/2.7 branch.

commit b50d336d00c93853ad542702516c1e0b99149fde (master)
commit 52ca8f2c38a9b551aac7f472722275a14e797c6c (release/2.7)
Author: Frank Lichtenheld
Date:   Tue Oct 20 15:19:36 2026 +0200

     configure: Require automake 1.16

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2024
     Message-Id: <20261020131943.24892-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261020131943.24892-1-gert@greenie.muc.de/
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
