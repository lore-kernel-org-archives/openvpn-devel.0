Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE55606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HShorz1q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lUGAwDzP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jUCnZjwK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/pkBEhNGSxWpWm1DL29+CeJDV9Tt9yYfgaUxn1XCMsc=; b=HShorz1qvRajkM
	YSI3i5aRJkGfHY3t5LxbI7jlFbReIGZFeqBXd9uXvmgzkreU7jDxhfzyGk558RUvxvWtB4ykXzTPL
	jvdTAzgdodlnmRPCRZYfdYOJpcxQGbowvwPXTCucjHglB2G0vgV/kR0Hi118WxA86eu+C3wA3Vk/Y
	+z4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJsgp-000000008Cx-358o;
	Thu, 22 Oct 2026 13:18:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xJsgn-000000008Cq-36jB for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 13:18:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=La8chld85h/C173gpaK/wlbTZAYhwO6l/AO855yhAcQ=; b=l
 UGAwDzPmyN8Fg5zK29Dxun+ZO33l6g6TCeMAWuD1IauRp4KCvuArqCxt+Wtz5hwx5rs3o0aLYFkib
 1ip2qjA+CdnX3X1/mEm39u/mlzOrLjJS9lPjxTFSihRbdDbi/aeZZzgvEFOyXwnNOBMvf4Lh3CP+1
 pXpF3PTitHn8puHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=La8chld85h/C173gpaK/wlbTZAYhwO6l/AO855yhAcQ=; b=jUCnZjwKgDApj51Rnb1bS0fufY
 edyBMY/su9ybCrqw6H8IlWdCSYpABExOpZoBe5OGN7EpyH16RJHgMNcpcOzmSD9jeIWPS9sH9ZM8r
 RKDpGvErx7aTxsma4EUFNMQNPC/tKPxjTe3OSy8/4BGVe0LuruTXjDTV9LmHheDJpax8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsgk-000000007hU-1Ksb for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 13:18:37 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69MDIRvj003851;
 Thu, 22 Oct 2026 15:18:27 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69MDIRQU003850;
 Thu, 22 Oct 2026 15:18:27 +0200 (CEST) (envelope-from gert)
Date: Thu, 22 Oct 2026 15:18:27 +0200 (CEST)
Message-Id: <202610221318.69MDIRQU003850@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261022123500.27256-1-gert@greenie.muc.de>
References: <20261022123500.27256-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xJsgk-000000007hU-1Ksb
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Call AC_PROG_CC
 before AC_USE_SYSTEM_EXTENSIONS
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

Lightly tested, seems to improve things :-)

Your patch has been applied to the master and release/2.7 branch
("build system improvements").

commit 74ba58631ae2b53668c2b5d372e4f7ed28e02223 (master)
commit cddfc8cbdc4d200e0540ed6be79fd23afb1ffe77 (release/2.7)
Author: Razvan Cojocaru
Date:   Thu Oct 22 14:34:55 2026 +0200

     configure: Call AC_PROG_CC before AC_USE_SYSTEM_EXTENSIONS

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2028
     Message-Id: <20261022123500.27256-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40092.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
