Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7685E606A32C
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JNqJR4ny;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ycu0hS/L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BkNmW4JU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aXslvAwbEE0jgnWu0eIFpbC+JgZcUG/yHo5t0NNGFkU=; b=JNqJR4nyEllSxG
	4kyCqH4JJt0yGU7pve5JHpMGO0bWhzpi4oGL0tRIXR+exOrJrWfllBjNNthVoCOvsVEcpY9j30TfD
	neNkplKgWlyCaI9QtqB1pZhlUxRe7iC1r50Yz7tmIQgKNNTsBk8xTWFxdn3jjOKSLPCPUPb18NRw5
	kcQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKFV-0000000035g-3Wbc;
	Tue, 03 Nov 2026 19:32:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOKFU-0000000035a-3XdC for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:32:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6vkVljGIBHgPRCrW9/mqhkxFip3Wwb8+qeQnto4D6Z0=; b=Y
 cu0hS/LphjQ0LiTRORI8vJlTyuDxKu8VRQrR0II+Sxw/9MaKnABFBNxdSTfiCqo/tTsaoP5FT/sT4
 L9ZY99d/nJDYDAAvdeY5bfhU6o/fgWMP8oHIQW6uznA0ZuxmPyp98yxJH7DEjQ8TFdFr84P8GWbT5
 lyddTunLOGn3GSJ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6vkVljGIBHgPRCrW9/mqhkxFip3Wwb8+qeQnto4D6Z0=; b=BkNmW4JUGD6c9G3pERA98ys1Lc
 c+TVxEbVQGbmGzhGPP9MRHLg/r+kNGNE4cJ+9eWM7IjYqrrSqkih1tRdGbERH9oVbJrO7vnme/BK8
 Ulxj0J4lgB1KAAs11LPIJVVIw1OULcdkwNjwbuTG2FdTNYmrVRarjMzBmI9HWjUWflD0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOKFT-000000004Wr-2SIv for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:32:48 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3JWfBM055854;
 Tue, 3 Nov 2026 20:32:41 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3JWfHV055853;
 Tue, 3 Nov 2026 20:32:41 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 20:32:41 +0100 (CET)
Message-Id: <202611031932.6A3JWfHV055853@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102171317.113895-1-frank@lichtenheld.com>
References: <20261102171317.113895-1-frank@lichtenheld.com>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOKFT-000000004Wr-2SIv
Subject: [Openvpn-devel] [PATCH applied] Re: tls_crypt: append cipher final
 output at buffer end
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

I know nothing about this crypto API thingies... but Arne +2'ed it,
and also requested backport to older versions ("in case one of the SSL
libraries change their inner workings, it might trigger one day").

Your patch has been applied to the master, release/2.7 and release/2.6
branch.  The code is almost identical, so it cherrypicked just fine.

Ran the 2.7 code on a t_server setup with tls-crypt + v2 in use, and
the 2.6 code on a t_client setup with tls-crypt (v1).

commit e48597a63e7ba1d003f834cf3605b965d64a6e29 (master)
commit 7f5ace11bcab4815f85b01e749b9ab46ffbbf3b7 (release/2.7)
commit c719e20ec424b5bad41ec1f5d3d0d5a0912bbb96 (release/2.6)
Author: Razvan Cojocaru
Date:   Mon Nov 2 18:13:17 2026 +0100

     tls_crypt: append cipher final output at buffer end

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2083
     Message-Id: <20261102171317.113895-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40536.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
