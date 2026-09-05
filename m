Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24917C624DB
	for <openvpn-devel@archiver.kernel.org>; Sat,  5 Sep 2026 09:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eCowq4kYh8mASPBkeUIuqxLuWggaSsT1Mz+WvBN6BM4=; b=ciNrVQD+Vl0CdeH0XeDFJPlYyw
	dX5TI2yjc3sS/QzTEyMrO7FJJ9yGJZGwHPcPbCiFTpxAKAuAzTI7UWVFxHXWmMDDrOtYTrYGzF14i
	E456iZ5iG1Wr8jqzDgQTU9ARKLKExxPlCluUEIGI60Q4JoIE90xkb1GIeiduNeX8H7hA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2mg5-0000Kn-Pd;
	Sat, 05 Sep 2026 09:27:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x2mfm-0000KO-OT
 for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 09:26:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YUVPbm9vZFTucdR4HYGJECbsWx8zXfpljreZt7xw6p8=; b=ekZ22yDAtncY649Iz3fC2bln/O
 HvmMnCD57fhROXWSLcNXWDwyrDk4Arm61rRDvxB0qtAlFxw1vQ4eXKHwyz4wfSOISidC8WfS4gR/E
 TObnkgV0/Lo4nzkhAdu5kv/JuM1x5er4Pz9yTRxyCrsrBoX8sui4kvkYdSNbo3Ny1XzE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YUVPbm9vZFTucdR4HYGJECbsWx8zXfpljreZt7xw6p8=; b=AjSpZ7SSJ0VzyZV15k3KNCs/Zm
 OAR/604WQGauxQxAD7sSSRI1JoJNc415evcpMVfblW2mR6Ub6xMu1mn+PLiZTRTvTZvNasqnBQBIu
 ya8cMEwBXJUk4dJFfJ1278Hl/KdSqtQjr5jHwyj/gc+yVyO+XbCzrs7iX6YqPCN4FDn8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2mfl-0001hc-Iv for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 09:26:55 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6859QkFs035603;
 Sat, 5 Sep 2026 11:26:46 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6859Qkg4035602;
 Sat, 5 Sep 2026 11:26:46 +0200 (CEST) (envelope-from gert)
Date: Sat, 5 Sep 2026 11:26:46 +0200 (CEST)
Message-Id: <202609050926.6859Qkg4035602@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260904160848.5553-1-gert@greenie.muc.de>
References: <20260904160848.5553-1-gert@greenie.muc.de>
X-Headers-End: 1x2mfl-0001hc-Iv
Subject: [Openvpn-devel] [PATCH applied] Re: reliable: add unit tests for
 ACK and backoff DoS hardening
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

More unit tests are always good, especially when we fix things and want
to know if the fix is effective - BB confirms that these failed before
we merged the CVE 2026-84732 fixes, and now succeed.  Great :-)

..
[ RUN      ] test_copy_acks_to_lru
[       OK ] test_copy_acks_to_lru
[ RUN      ] test_packet_id_window
[       OK ] test_packet_id_window
[ RUN      ] test_reliable_backoff_is_bounded
[       OK ] test_reliable_backoff_is_bounded
[ RUN      ] test_reliable_purge_ignores_forged_acks
[       OK ] test_reliable_purge_ignores_forged_acks
[ RUN      ] test_reliable_purge_legitimate_ack
[       OK ] test_reliable_purge_legitimate_ack
[==========] packet_id tests: 13 test(s) run.


Also, thanks for rewriting to avoid creating an extra executable (which
loads the GHA test runs quite a bit, with copying these around for
windows UT runs).

Your patch has been applied to the master and release/2.7 branch.

commit c9b8ca1795957f2e22dad1589479bd32faea4fc1 (master)
commit acd9702b6cdf94b173e78a6e310e408ffe33aec2 (release/2.7)
Author: Lev Stipakov
Date:   Fri Sep 4 18:08:42 2026 +0200

     reliable: add unit tests for ACK and backoff DoS hardening

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1894
     Message-Id: <20260904160848.5553-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38948.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
