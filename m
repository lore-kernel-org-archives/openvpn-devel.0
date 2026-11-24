Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F94606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mIA8nBzS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ef5Jx9F8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=afO8nzkK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XUJSyBJFZbPqFqKCY+d7yWoXYHKxOBUmq2KjNRUShNo=; b=mIA8nBzSX85mFU
	f5Vntz7ZFvtHyHoMDtGEFLPEDqQE/aQGmZ2nSYUBKgFs6z93jxIQv9FHnYmeep68fL3LWQt7sVDWo
	cJPNxCjzv2XMSB6xn8uSxHFXnad3KNscjsAGXIGl1hSuX1g+poIY2g2dun5gTp4PbaOkSc1p8IDQj
	5L0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVovg-000000006ON-1tC0;
	Tue, 24 Nov 2026 11:43:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVove-000000006OH-2rqX for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0997n5dyHWGlqrBZLwGmSIn9OMR+SUcaX58kT58aB7Q=; b=e
 f5Jx9F85Tj6AtHCBnaY1bboGP6FKhSYir7k34hImoGvS2w9USvnvtvxF/ECZtHc8uMg1kefwyahEr
 j/J7IqbZKYzWu/wOrXX4ef5b1EA0vbAeTb3rY8VnR0oFKr8vs1C4cXGEpIbm4hbhAuUs780W4K6M2
 wsPrnWZLlRrmJ9D4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0997n5dyHWGlqrBZLwGmSIn9OMR+SUcaX58kT58aB7Q=; b=afO8nzkKOBzJ01TOiCzlsRJdmj
 y/znjsDaqDR991LhhSuz0Khm8TJwGAlSdvEJZ0n3Srtu2JIH/OcwMhFPK/hw59YGnTPyKTZ6/XQPD
 x75S+otaOxd2QOjTfg4WoNIUpUt/rPgth7lqJL5Hls+eYQYAaqHx09c/3ygI/j0mPrAk=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVovd-000000008Rs-3HLW for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:43:18 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AOBhBrN021393;
 Tue, 24 Nov 2026 12:43:11 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOBhBkC021392;
 Tue, 24 Nov 2026 12:43:11 +0100 (CET) (envelope-from gert)
Date: Tue, 24 Nov 2026 12:43:11 +0100 (CET)
Message-Id: <202611241143.6AOBhBkC021392@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261123103742.10589-1-gert@greenie.muc.de>
References: <20261123103742.10589-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVovd-000000008Rs-3HLW
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: drop duplicate remote
 address check in tls_pre_decrypt()
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

Now this is a convoluted function...  but I agree with the assessment,
"new_link" is initialized to "false" and not changed until the code
reaches the first check (it's set to "true" in the first large if(),
and the removed-check is in that "else" branch) - and the other
check is also in an "if (new_link) .. else" branch, which then can
not be reached.

Out!  (But this is cleanup, and Arne is busy rewriting the whole
function, so "no 2.7").

Your patch has been applied to the master branch.

commit f195766e8196bca6deccc1d157b4fb458aa4a399
Author: Razvan Cojocaru
Date:   Mon Nov 23 11:37:36 2026 +0100

     ssl: drop duplicate remote address check in tls_pre_decrypt()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2240
     Message-Id: <20261123103742.10589-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41806.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
