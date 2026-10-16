Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA6DCC6B38
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofKvi3L8sFpABez3c44Fd2fTW76yXyILsjQ04OP9SFQ=; b=kSGXB/Oey4t4vFrhe+JRYhl+Ui
	K6XMdfsglPI6JbPzgYttRrqVBMzqFizURfUncO8fdeXswfy4mklNNZlAVFJhD9dAT2iRkTpN35d4u
	RPQeAUGGuyFFsSf69RBuPZcLEcF6zmIg5wwI/ARu7oAd+GyMGuoMCzOgi6J+ffUqNWZU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHjdF-0001o4-A1;
	Fri, 16 Oct 2026 15:14:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xHjdD-0001nt-Mg
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 15:14:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h91jdBObocju20fdInCLTJUvk2Ap5uttGo2m9sT2EuI=; b=f/tnhPpwE89X8xi4wuFEVCwW/X
 qLwyu8Civ/ZJ+XokEfOOYnSrpNWLemYpEZITCQRhtn0q89ptCFAHnQactDDDnxXjUOZFdrfMvxuNP
 Hhf4Sri6gesyUwRc1DGDcc69jK9tlEMl6oB6LPfFuSGQxKtngKG8AXWxxelyCht6iDfg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=h91jdBObocju20fdInCLTJUvk2Ap5uttGo2m9sT2EuI=; b=k1mvrWTSK3ckrMKdgUumqYsYYz
 AxWoDjo5mFgGAe4hiKZU94S9PDucqk4bQRPmv5AFCgw1TAMIX6K1Bt6HJTMfbXJpHLtslB+lDCErf
 c+CT+75I2e4WxFXl8psXUT6m/OaHl44oUZMBYXPKs4TaSCUmLqTNRV3EPyleUJVgOLgY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHjdA-0000xH-2R for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 15:14:04 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69GFDied057918;
 Fri, 16 Oct 2026 17:13:44 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69GFDiTd057917;
 Fri, 16 Oct 2026 17:13:44 +0200 (CEST) (envelope-from gert)
Date: Fri, 16 Oct 2026 17:13:44 +0200 (CEST)
Message-Id: <202610161513.69GFDiTd057917@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261016080644.23188-1-gert@greenie.muc.de>
References: <20261016080644.23188-1-gert@greenie.muc.de>
X-Headers-End: 1xHjdA-0000xH-2R
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Add
 --enable-code-coverage
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

So - this is in, but I guess we need a bit more documentation how to
hold this "not wrong".  For me, using gcov (llvm-cov under the hood) 
the first steps work, but the last step doesn't...

        ...
	geninfo: WARNING: GCOV did not produce any data for /tmp/o2/tests/unit_tests/openvpn/auth_token_testdriver-mock_msg.gcda
	Invalid .gcno File!
	geninfo: WARNING: GCOV did not produce any data for /tmp/o2/tests/unit_tests/openvpn/user_pass_testdriver-test_user_pass.gcda
	  LCOV   --remove OpenVPN-2.8_git-coverage.info.tmp
	lcov: ERROR: no valid records found in tracefile OpenVPN-2.8_git-coverage.info.tmp

Your patch has been applied to the master branch.

commit dda75df387f83ae10741d74a516495466ca78964
Author: Frank Lichtenheld
Date:   Fri Oct 16 10:06:38 2026 +0200

     configure: Add --enable-code-coverage

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1592
     Message-Id: <20261016080644.23188-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39917.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
