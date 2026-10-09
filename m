Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5A7CA6019
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9UpAa4CfBhItlHtXYPs7kr/mjcb2IZdTvz8EIqDCP0s=; b=kl6v2xpstrzbv+h7pS3TIKFLXf
	Kxu6W0Q6v6SvfjcOnASsRzd9mcQRiByHfUyLhK7GLmsUO/fGhbuIhLfLeNFY3x7roQ/QuApDis0KP
	eGVFx87pVaDKCDWjpGubkMEcH4E2kMxPEGgX9zXArUDAApKju4Az8ohz/IDTdkGcb0ZY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xF7fc-0006WO-KB;
	Fri, 09 Oct 2026 10:17:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xF7fV-0006Vz-H6
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:17:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JRJixLXcLQNv1/Zong+e6sEUQLblrziFX4NO+TGUtCY=; b=bTOsJx5FdGTnxMcfVhAG0yBFFM
 cpFB/eNVxNyjREMYXlgJoJSsIrc7K0V9HIEQhjrTRJDYE/r31U7sAYxmliFWVAEzjT/41w+lshYT+
 2UwP4e/SFhasoDU40JRCp4YGkNUSbzvikR1MvobQTulWoTfWWlD8qOdGb4usfzhKO/uA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JRJixLXcLQNv1/Zong+e6sEUQLblrziFX4NO+TGUtCY=; b=T8Evg2dL1COuutjZFYDtRgtDYO
 hmqxlqLYSd2Bzc/Y6r/ZITK1yghB+NzEGgz9v862IjJPrIlMNGD+bpVbtdbDtxuPZk9MEw6FLtSv8
 BOMkZEEtzjN9bWFfSvJkV9qv3UcWQ8ifrhOHSyfjSV8k9R3sfQJqLPigh/omHP5d1HFA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF7fR-00049H-0c for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:17:34 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 699AHI9i015059;
 Fri, 9 Oct 2026 12:17:18 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 699AHI19015058;
 Fri, 9 Oct 2026 12:17:18 +0200 (CEST) (envelope-from gert)
Date: Fri, 9 Oct 2026 12:17:18 +0200 (CEST)
Message-Id: <202610091017.699AHI19015058@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261008205006.28086-1-gert@greenie.muc.de>
References: <20261008205006.28086-1-gert@greenie.muc.de>
X-Headers-End: 1xF7fR-00049H-0c
Subject: [Openvpn-devel] [PATCH applied] Re: config.h.cmake.in: Fix issues
 with string functions
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

I wouldn't know anything about cmake, but it looks in line with the 
other "cmake induced" results...

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 1c7812a580e7d118f1a6ece8e08edae3b98bd208 (master)
commit 25702f5a718b89473f3105a3b2d5e6dfafbfe974 (release/2.7)
Author: Frank Lichtenheld
Date:   Thu Oct 8 22:50:00 2026 +0200

     config.h.cmake.in: Fix issues with string functions

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1986
     Message-Id: <20261008205006.28086-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39794.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
