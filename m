Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C4606D837
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AKuNEZLn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Wg3Cp3CT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=g/bMqx11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rNomNCeYXFjSuJunkuDbaXwiGNdot0THyuY0XkD7LSQ=; b=AKuNEZLnPopYcC
	khbByBh9ybrJ+YJXUASBOfBENpbo4edYg/dhqPIZpTTewmtyydAo1qjPTu24QAzDOO+zaJ9RLZykB
	7Agl3ki25PO9onnGn97lU0B+C1RHEiZNQoEmUMPjZy0SvTipWSgIWogrNFKbFgolW/gKUnlc3mosU
	bu0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeIm-000000007J5-2RmJ;
	Wed, 04 Nov 2026 16:57:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOeIk-000000007Ix-3tRZ for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:57:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Uec9IuzrVZ8bb1sNjxFEY2eWreS34pEjvQya5iurHro=; b=W
 g3Cp3CTpAbegaJ6K+s5wjCVzsQC6eA/xHXu8tKgFYNU8ufLYAkH0sJKK3/UILhfsGaaKEzSTyiCbI
 NyUcZPKPr/75LGFzXtOLxV80MpzNpZLbb4zfVZ9wiHLryAe2Tt8hHYAxVNWcthuBn0gm51NRZxE5j
 fUgWnrX76YHHJ3mM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Uec9IuzrVZ8bb1sNjxFEY2eWreS34pEjvQya5iurHro=; b=g/bMqx11CfQiYqpemirbTmygMX
 I9dJEO7gdWfhm/Gr3chdMlWvYjxKa5du8SVbVkw7zppcXTY9c+2Qt5WNYqlY5fKODUGd5NNhKjR0t
 sAsZtdLQPiS58YqQt59B0R8k1AqRNSDu9/OysnVkQhERq1S8g6U/Er95kj1aJST1/6Hs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOeIh-000000007Ky-3QOw for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:57:30 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A4GvLLj097365;
 Wed, 4 Nov 2026 17:57:21 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4GvLtA097364;
 Wed, 4 Nov 2026 17:57:21 +0100 (CET) (envelope-from gert)
Date: Wed, 4 Nov 2026 17:57:21 +0100 (CET)
Message-Id: <202611041657.6A4GvLtA097364@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104105531.7096-1-gert@greenie.muc.de>
References: <20261104105531.7096-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOeIh-000000007Ky-3QOw
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_mbedtls: remove empty
 tls_ctx_personalise_random()
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

Nice and easy for in between, and no bug, just dead wood...  and BB
confirms "all mbedtls builders are fine with it".

Your patch has been applied to the master branch.

commit ca879870516150ba6c853a4edb268b5549c11e3a
Author: Razvan Cojocaru
Date:   Wed Nov 4 11:55:26 2026 +0100

     ssl_mbedtls: remove empty tls_ctx_personalise_random()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2122
     Message-Id: <20261104105531.7096-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261104105531.7096-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
