Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CC5606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=O6otXZf8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a1ronMVG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LQShjqxQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FN/Ux+35ZCLuV9KGXUH/inLonxtcRwQg4M/IRhqLApo=; b=O6otXZf8WVDdDV
	gbQGbcQWUyeFjl/+KvPRQktNA7eSJ7nCnAP03YJyygGsD/kNeKpZbmtooJX/xmicLaer8buhPxF4/
	7bF8dvYYbORPdX6uaUtuCWiH9rz1Bbd6qlVi8TNVfsjcHJ5AI7lUE7UJ3ONOMy6U4Cbg7FtI3CF9H
	+WM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRpQg-000000003ca-4AUs;
	Fri, 13 Nov 2026 11:26:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRpQc-000000003cO-1tGo for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:26:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=90X1VrvL/iCJoETS6WfvZz7625aJLp6eD6GwFQcu54I=; b=a
 1ronMVGUrmx9Kst4oLfVqDelmhp/JH3IIC9HUFnQM5Ko/4opJdJJmPtHhWxth9j8EDskYsL/9GeDR
 b8yHxvtO9VgJqZ9gVJiGIF/vy/mdbqOO+La4r5OV2k5cMYumtHGRCiBXrblgJ9gg7af88TZf9uLKC
 7ImCz2Wo0F1M+RBU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=90X1VrvL/iCJoETS6WfvZz7625aJLp6eD6GwFQcu54I=; b=LQShjqxQ8mZlw3h0e5mA5N3Gth
 tHhSNqaL/b0inIct+SUS/q7qGUrEeeUkX/vBzdCTGkPhTDfLFHWYexwxStIwezYM97OJIgftTYtCi
 b9BS8/2Oa8PpEEo64l7AZLH+49+r2yy5CuBI9NetchuIWObeTlK43cZZwon0hl/ptC1Y=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRpQT-000000002I5-3l9l for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:26:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ADBQVZW011269;
 Fri, 13 Nov 2026 12:26:31 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADBQVP8011268;
 Fri, 13 Nov 2026 12:26:31 +0100 (CET) (envelope-from gert)
Date: Fri, 13 Nov 2026 12:26:31 +0100 (CET)
Message-Id: <202611131126.6ADBQVP8011268@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261111140934.24057-1-gert@greenie.muc.de>
References: <20261111140934.24057-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRpQT-000000002I5-3l9l
Subject: [Openvpn-devel] [PATCH applied] Re: Extract
 tls_pre_decrypt_verify_opcode from tls_pre_decrypt
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Best viewed with --color-moved=zebra" ;-)  (and a bit of extra stare).

No benefit in bringing this back to 2.7.

Proof-of-concept test run done on the linux t_server testbed.

Your patch has been applied to the master branch.

commit 1c960855fd63dced713252698131d99f789a0bb3
Author: Arne Schwabe
Date:   Wed Nov 11 15:09:28 2026 +0100

     Extract tls_pre_decrypt_verify_opcode from tls_pre_decrypt

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2169
     Message-Id: <20261111140934.24057-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41159.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
