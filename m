Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41549C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ADxd2BW73gniQVu7ECwBLipNxFdOlz51rIdjvQSDDbQ=; b=ib9TfG/CGdCHKjiiLzvhvML9cm
	C8fSdbuG/xR12pJ5u2qjDZa3ajPA7TodmP1DUPFlwixADIB/ubRXlKxfVPYA9PE7B21y/rlrkni89
	f+NgCES3NhBePKO52Xlo/wWzLMJyJ/PIFEt4O0ZC1QEEa+oLnoj/ozbn+cASa8zxY4bA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrw1i-0000Ox-SI;
	Thu, 06 Aug 2026 11:12:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wrw1Z-0000Ol-65
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:12:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HT6HUmr/aPsyerLhB5ywu6Bidnrd53+dvXibXfYla8s=; b=NFieLhh84IZtoPGZzF40rJrptg
 m3dGF669nciPvWF13TNZBFPxcui8/FbnYVpb4Qw3VWvhCpi9H3m2wRESPXno5OCMRv3LhJYhBFkn8
 STqd1LV0C7wWBhZLudTVvM2Pxm3hofc4u/8yWyjitgrs93VVqESZLzu2tTuTdoJVCERo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HT6HUmr/aPsyerLhB5ywu6Bidnrd53+dvXibXfYla8s=; b=lpQAR4yFtqXZN8MNcdv9ZdndU0
 JKLnpZ6yqBV8BlbN2eqJWzkunV/iGXq1PhYqydYD2Jz44nyVm1pBGHKvnql96ICyL8bnvCqkiqmCW
 FAOgBd+BcZ0ckWUu8GdBA8v5+IHbQSz0ugu2+Ac7k1BvPPjeQ84VFXv8Ivt5UeO3g2mo=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrw1Y-0001bb-2I for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:12:30 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 676BCLfc067739;
 Thu, 6 Aug 2026 13:12:21 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 676BCLDp067738;
 Thu, 6 Aug 2026 13:12:21 +0200 (CEST) (envelope-from gert)
Date: Thu, 6 Aug 2026 13:12:21 +0200 (CEST)
Message-Id: <202608061112.676BCLDp067738@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260806102926.28206-1-gert@greenie.muc.de>
References: <20260806102926.28206-1-gert@greenie.muc.de>
X-Headers-End: 1wrw1Y-0001bb-2I
Subject: [Openvpn-devel] [PATCH applied] Re: Change hash iv to a be a fixed
 sized array
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

Part of the journey towards a more efficient hash function - and also
fixes the -Werror mishap I did on the last commit.

Your patch has been applied to the master branch.

commit d1106970f76e955b0a5fa19b566e97bba98d4c9b (master)
Author: Arne Schwabe
Date:   Thu Aug 6 12:29:21 2026 +0200

     Change hash iv to a be a fixed sized array

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1571
     Message-Id: <20260806102926.28206-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38162.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
