Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E3F606A31E
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CqNRb39h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Hqg1ve3J;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cGZdplXO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6nl5uSWokztbEhavIhKALUF2Iz3XWqDBL8oyy6JoHi8=; b=CqNRb39hMmu4IY
	ONYqoL+Ml5K0j2+oukCc3y9kRv1JfeBj6Wm8a6rwSWYsPx9eK8TsWu7/0WpxMfTZ/0qSD5NYRZ5Y2
	xoLWNxqr8+71iByVGc0yP8gyzkwGgpfQPoAMb0Rbz/kOPCGc9XlHqdgpyXHQSVG6bsv4qIW+2ORov
	RcY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX237-000000000yc-3rvj;
	Fri, 27 Nov 2026 19:56:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xX236-000000000yM-11FT for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:56:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O5fykZ8eZD98bt2akl3l1I8iNLMpYBGIoNqHYt9WhQY=; b=H
 qg1ve3JwkYirbzZg98i8nEIaE6v3/AjbzWO1iK72CnZcEJD/T7FilS/RwAHB2ON2ngFDsFok508sd
 vZGf3tx77LEw3LIs4FzC9kS7SmnFfemMIwt5/nPlCQs7EFxKD3psjyNvmMy1Dg/zTRxFKpMtXBlyL
 YT2iX4QiXYU6dfRo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O5fykZ8eZD98bt2akl3l1I8iNLMpYBGIoNqHYt9WhQY=; b=cGZdplXOBFNJOU+d6b6C3rc9Ve
 oDsmzuDM83IeQEz7qgOX9rBBTU/E1grfjNgdtUaqDlFqGtRMQNgUqE2AJyrqKqMUuoC0yPQxyJV73
 ZcEI6pNQuyVXRQciXNUiLoMQ5inYNm5cyZk4yj+EEiQyxVWc2cybbDp5rfzSTsuvRZZQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xX235-000000004Vb-1NjS for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:56:00 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ARJtkaO073298;
 Fri, 27 Nov 2026 20:55:46 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ARJtkb0073297;
 Fri, 27 Nov 2026 20:55:46 +0100 (CET) (envelope-from gert)
Date: Fri, 27 Nov 2026 20:55:46 +0100 (CET)
Message-Id: <202611271955.6ARJtkb0073297@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261126192127.18879-1-gert@greenie.muc.de>
References: <20261126192127.18879-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xX235-000000004Vb-1NjS
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Avoid sign
 conversion warnings related to string conversion
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

This one should be fairly conflict-free and seems to make sense :-) -
stared at it and gave it a mingw compile.

Your patch has been applied to the master branch.

commit dd4fcd29480665a4857a9261637d061a44f57bae
Author: Frank Lichtenheld
Date:   Thu Nov 26 20:21:22 2026 +0100

     openvpnserv: Avoid sign conversion warnings related to string conversion

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2357
     Message-Id: <20261126192127.18879-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg42064.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
