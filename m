Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21D2C79FB6
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=muBjtgfcyeXPmDM3mD5CMFOHVsjoqZ/rsF5ZgzA/CTA=; b=a+FaHxDfDP6+XFpPlCjvNRnzq+
	o7UhR5xmv2O4ENt/LWVhDqyr3VUprM6X65rrR3i3V1cBJ4jzR6oOFUuqVUMcdWYu7d1uMzOBObhXK
	pZPsfu2YteG6yiWgHdLyvw3veeOs8McbzSSCTBhFv64Y7sXB4jOb6jwXRQoMsL95jWmg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5MaE-000129-O4;
	Sat, 12 Sep 2026 12:11:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x5Ma8-000120-OQ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 12:11:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o3oXZSs0N4z8rxT5g/Pz+PNe4fmO1itKhKIQCFsQddc=; b=GrUYBLr5hzNlUwSkSVGkYSoQaS
 IorH3++463xp5zoOtSnJct4Vef9ZUpYH98Qo/8m8xafOrURA2Ucj+VgIfmboQ67DXmKgDVp0KKC3b
 0V1/IzXnQ5YF/OdCvOhtexZGIbAm3gmgcQklMSN36szb2zH3O7ssVXCuzp6uR5/k/5EU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o3oXZSs0N4z8rxT5g/Pz+PNe4fmO1itKhKIQCFsQddc=; b=lDBO0CQxhGag4zAgiY6aFachbt
 l1b6HNDJkPhLyqsHJsW3x2sVkKsGdnBJcml6HVCFSlHv8l2KohA4DyHuXF9CkJFrkfHL4UnTpLOFQ
 vUyhCxgJxWEUZuvs9CdLyPordJVQOmf27VUsxp7Eu4tmad+zP/cRI1dpkbsN5/y3Ksu8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5Ma7-0005ZL-Bn for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 12:11:45 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68CCBSFe046594;
 Sat, 12 Sep 2026 14:11:28 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68CCBS5s046593;
 Sat, 12 Sep 2026 14:11:28 +0200 (CEST) (envelope-from gert)
Date: Sat, 12 Sep 2026 14:11:28 +0200 (CEST)
Message-Id: <202609121211.68CCBS5s046593@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260911204545.15750-1-gert@greenie.muc.de>
References: <20260911204545.15750-1-gert@greenie.muc.de>
X-Headers-End: 1x5Ma7-0005ZL-Bn
Subject: [Openvpn-devel] [PATCH applied] Re: management: Remove management
 argument to functions that do not need it
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

Nothing magic here, just getting rid of "we might eventually use that
for something" parameters... (and creating backport challenges wrt 2.7
and older :-) ).

BB says this compiled fine on all platforms, we were just plagued by
spurious connectivity issues... (re-running tests = all green).

Your patch has been applied to the master branch.

commit 9689f4ebb5d6c6689fe07b32c7f20ecf78946e16
Author: Frank Lichtenheld
Date:   Fri Sep 11 22:45:38 2026 +0200

     management: Remove management argument to functions that do not need it

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1903
     Message-Id: <20260911204545.15750-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39109.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
