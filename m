Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41E1CD98CC
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/QdVmJEN8lxZoEOGqIj9Lud33qtslGtxpsDejVdg8lY=; b=QD+tziLpAaCukIC+ucthpErJOW
	D8c08rJZDVALGhysx+1OHUr0BHgHKPXBF5iRKd2EKUYDe2QhwhFIuVnEN0uOpSAbz/YaGUELZxOl2
	Z0OpGbLbruwgnZI0/CgRWQEri+sSyde/SVYgOEgcRGw+ZG3Bo6Bh99bVFyvu60F0QHY0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXPmp-00085r-0g;
	Wed, 10 Jun 2026 20:44:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wXPmo-00085l-6J
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:44:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OEeRk18Q1B+GJzRyATgETKnODk4HwK5T1cJcQvxgJHc=; b=EECl4HH5FHJ3u+W8p5TsJdTfPr
 rGgJULHmE8GYENWJXd5cfAsazlibPqpLCrbClZYA2ZCAjOU8y92GLkh2d4EEPi04SC0/n67HHkvaC
 bOEE3QhhweReyhr1e5XQ6YZaGWk+ViY1vVpFyeHQCFzShfJLVuOoK+XXJA9aME82D03o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OEeRk18Q1B+GJzRyATgETKnODk4HwK5T1cJcQvxgJHc=; b=g227SagcdNEgDIC9ytjMZs/xQI
 WJtMVKyZXOMPR5dCDzkg3uc/8OCwk028SqvnqkM0z9Ugd/z41FxRTySEuuBc4ZZZBxzgrSGRrw6lj
 rj9JXpkACTwoyrs6xgmWPM4bVx5F6tkEQpzwDF/2rdoVhZolAbQY3RD3Dpa/buw/dG28=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXPmk-0001SD-8P for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:44:30 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65AKiET4006741;
 Wed, 10 Jun 2026 22:44:14 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65AKiEZf006740;
 Wed, 10 Jun 2026 22:44:14 +0200 (CEST) (envelope-from gert)
Date: Wed, 10 Jun 2026 22:44:14 +0200 (CEST)
Message-Id: <202606102044.65AKiEZf006740@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260609155211.30747-1-gert@greenie.muc.de>
References: <20260609155211.30747-1-gert@greenie.muc.de>
X-Headers-End: 1wXPmk-0001SD-8P
Subject: [Openvpn-devel] [PATCH applied] Re: AWS-LC: Use
 openssl_stack_size_t for declaring stack size
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

This is seriously ugly... (why can't AWS-LC just not do type changes?!) -
but I guess this is the least ugly way if we want to support AWS-LC with
full sign checking.  Meh.

Tested via GHA (the OpenSSL part doesn't actually change anything, and
GH has AWS-LC tests).

Your patch has been applied to the master branch.

commit c9b5f9ea2e9cf29a1880a7f7c3775c4b359d913f
Author: Arne Schwabe
Date:   Tue Jun 9 17:52:06 2026 +0200

     AWS-LC: Use openssl_stack_size_t for declaring stack size

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1627
     Message-Id: <20260609155211.30747-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37144.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
