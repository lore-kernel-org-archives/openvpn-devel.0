Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD93606A886
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AjUHvH2A;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Q48NTuFr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k74cdGBM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=r04j1nVs0BcGT5D1ty+qjlbr5eq/vzAsJvpljzLjy8Y=; b=AjUHvH2A6c+nCJ
	HlEB9qbZYMN9Fz9ahjPVuzCHsf2tKPVq+kM+iG7QQ6E8DE77qa05yHl3vRnH3prDa+/TGl/Z4PKZy
	cHS/w8ngvg+QZULKMJyUNVEWQQS/0rm/Hj3SWrE68vYziA12Ihcc0lcbg2xntaxd9Ng7iR22vWcZQ
	sEw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xStzR-000000005bF-2TJU;
	Mon, 16 Nov 2026 10:31:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xStz7-000000005aH-0idH for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:30:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YLg6b5E1R09d7OE9g3wocQqktkSnhhGMwxHvmOMcg4s=; b=Q
 48NTuFrJpwmo5Pn6hERhKszu0X7XiXnnkFBxE29XZMZ0m2OiEp6Pu+QZQR9eGu/Bx4eZq9iO78y6E
 E60+qJTkwpIl9VjZDnrrcWahslfa5aUSulxJmcV5wcSlbVu4a2A6VrIhL8K6OP/UOs9anvreHbq/K
 5KryzLRQtdBjCAOI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YLg6b5E1R09d7OE9g3wocQqktkSnhhGMwxHvmOMcg4s=; b=k74cdGBMv+Ku8Mfd3v6hhp2srj
 Ia60CR3hKhezXNKNOW8bWYAEA0Sdk8uHjbaS4GTE2UYKdhP2pLC3FioZXTSgy3oM2YUEnsIucWpwF
 DLHjhGAcxvRIk979Lm8+aoYQj77azwqBPnPesRFKvHJwXwnsGB3gsxZp9xdOX5HffEug=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xStyz-000000003Eu-3fs6 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:30:42 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AGAUZsA069087;
 Mon, 16 Nov 2026 11:30:35 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGAUZGd069086;
 Mon, 16 Nov 2026 11:30:35 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 11:30:35 +0100 (CET)
Message-Id: <202611161030.6AGAUZGd069086@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261112181513.27212-1-gert@greenie.muc.de>
References: <20261112181513.27212-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xStyz-000000003Eu-3fs6
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: keep IPv6 name
 servers in NRPT exclude rules
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

Bug, even if rarely hit, so 2.7...  build- and unit-tested via GHA.

Your patch has been applied to the master and release/2.7 branch.

commit 2d1014eaf4112c9d3d002523ab40671cf32931c7 (master)
commit 88b586dcbb8c224e80ff1fbdf9e667fe63327181 (release/2.7)
Author: Razvan Cojocaru
Date:   Thu Nov 12 19:15:06 2026 +0100

     openvpnserv: keep IPv6 name servers in NRPT exclude rules

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Heiko Hund <heiko@ist.eigentlich.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2162
     Message-Id: <20261112181513.27212-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41227.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
