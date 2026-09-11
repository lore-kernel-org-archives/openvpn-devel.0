Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0D7C88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mz4Cmv2I/jppz0gNdCVAOnVyHABCV1b6klJY6hnIHyg=; b=ZU7dhYGUASV2xphExOfmT2a2TW
	Nv0NO3L7rToxNyKAqyWnZFa7XdfnPO+iyxeoXwR7hod+10HceZ0i4rlhfocf15VJrJf3hrFEu6j/S
	Qub4I2awzl58U5MJKDVdDX7O9d0nuJNWafJmiKDIimL6pOIPUO0CD51LtIH7tMrBuASs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x52yT-00080s-DO;
	Fri, 11 Sep 2026 15:15:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x52y6-0007zZ-M1
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:15:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H4ehLxeVYunnHcLYwnSw53lQU1o1Qi5daU+jhV6PtZ8=; b=LFtUP0rvUA61K+2P2IiHqR9TmR
 YOTgIga4Js63Xioa2HTXncI6KjLcihf5EgSD54uV9iSTsEPjCrw6r9VzK8XG+ALsnNQo6eoOYaeLA
 qUd1IxmqTV3x23uAn6dEELM8QNXEsBdN4mxFRBvRH5EsSkfr4ibcPkgaySad1pB7x1/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H4ehLxeVYunnHcLYwnSw53lQU1o1Qi5daU+jhV6PtZ8=; b=eW/PfxtzIFDQOaBePbI+3Zuj3A
 ca6U0L4Fre+Jr/RYg/TYd+RrmpQ75qcBvX/ihIul9rJpJD9q8nOleFqFM68b+dRFod7QafAT5QM0r
 H+GYYm3m3kKRvbTPV4LtzPR1C8HghbBPtjxm2/D9Qv77KrWp7MSBiO6EJKLXqJaUB98w=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x52xq-0007LF-Sh for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:14:58 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68BFEm2N006820;
 Fri, 11 Sep 2026 17:14:48 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68BFEmFT006819;
 Fri, 11 Sep 2026 17:14:48 +0200 (CEST) (envelope-from gert)
Date: Fri, 11 Sep 2026 17:14:48 +0200 (CEST)
Message-Id: <202609111514.68BFEmFT006819@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260910085046.30817-1-gert@greenie.muc.de>
References: <20260910085046.30817-1-gert@greenie.muc.de>
X-Headers-End: 1x52xq-0007LF-Sh
Subject: [Openvpn-devel] [PATCH applied] Re: Ignore acks for packets that
 cannot be outstanding
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

Fairly direct cherry-pick, taking whitespace differences into account
(uncrustify vs. clang-format), plus the extra review from Razvan to
check for git artefacts.  Tested on the 2.6 t_server test bench.

Your patch has been applied to the release/2.6 branch.

commit bd90ce85020a61828b01c77f6eb5f178279192db
Author: Arne Schwabe
Date:   Thu Sep 10 10:50:41 2026 +0200

     Ignore acks for packets that cannot be outstanding

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1909
     Acked-by: MaxF <max@max-fillinger.net>
     Message-Id: <20260910085046.30817-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39048.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
