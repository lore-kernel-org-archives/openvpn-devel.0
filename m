Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD9606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Zlxx6EOH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L76FdWmA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=enVy7TVx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qvHq3Syo828Ss2qAoz7HbVXRj/43Q/B83V31N7tNzq0=; b=Zlxx6EOH29y4PX
	Q4qhzla2a2ZLyiYJNKYGx3EbfIfuKpF2OQGT2q3cjMNx2JtXLkoDJMNX2KKdl0Q/dBKiKI/I48fBt
	UgKq3r8J7Rn0sMQOp59UCflGM+dPbOuO5aiLmaolmFdFwcdRGCXQbv6yf0gIywn6dRgZxCwluyhYV
	dWM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRXY2-0000000045G-223b;
	Thu, 12 Nov 2026 16:21:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xRXY0-0000000045A-3SSb for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:21:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JiuGGxQE2tYbxonHsBOdQqBIQA11p0luujxTq7JBcOo=; b=L
 76FdWmAUj6VZMGLZWFhIpuLoFwkopIe/1Ioj1rXnqLhJ0KPMYM8qNVuOUZZeg0Ff8cZi0J3h10bKe
 jImeChnfCg/nldRck4Yr4jjYMisyOO/8SniJh2XQ1y7DRLQo/RKnDNkRocxoG3NLLwe8IKe1mB3B5
 Ao9bpv0TvDUGu5Aw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JiuGGxQE2tYbxonHsBOdQqBIQA11p0luujxTq7JBcOo=; b=enVy7TVx+VHQbuOfA/ng9WNdBF
 EKwUUU8bDuxa5jHKYlDOE6m3QofCIxZvM5aKzv+XLz3s0QDH4VHZ4JlVqouyT+ICl2UlllBDuLvaj
 ZnwgdlV9WvUKa5dS070QvfjmwPp7eEsH0JoSZ1oBZghBj85M59D9kmw86gYoLiaPoJwk=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRXXw-000000005rO-19bo for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:21:12 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ACGL1m5064754;
 Thu, 12 Nov 2026 17:21:01 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ACGL1NA064753;
 Thu, 12 Nov 2026 17:21:01 +0100 (CET) (envelope-from gert)
Date: Thu, 12 Nov 2026 17:21:01 +0100 (CET)
Message-Id: <202611121621.6ACGL1NA064753@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261110065945.5905-1-gert@greenie.muc.de>
References: <20261110065945.5905-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xRXXw-000000005rO-19bo
Subject: [Openvpn-devel] [PATCH applied] Re: Remove support for --secret
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

Out it goes!  It has been announced long enough, people have complained
about --but-I-want-it-for-real in 2.7.0, and now it's TLS time...

I have not stared-in-depth at the code change, just fed it to the t_client
testbed, and saw "test 8" go up in flames...

.. but the amount of code and branches getting ripped out here is truly
remarkable ;-)

Your patch has been applied to the master branch.

commit 9d2193b46759b071b5db6fc0a93e70c5510e9a8b
Author: Arne Schwabe
Date:   Tue Nov 10 07:59:39 2026 +0100

     Remove support for --secret

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2081
     Message-Id: <20261110065945.5905-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41047.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
