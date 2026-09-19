Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE46C982D7
	for <openvpn-devel@archiver.kernel.org>; Sat, 19 Sep 2026 19:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pd+121AAqPzZ3wkWlgGOnX9S5XIDDM25tMPCFoE4OHA=; b=Axf+bDxQ2p+1aMrKcI02pfelpb
	GIf/bi5bbzofjHHyK9Dk06DixhCEQmQ1pHfvwGr4y2VnGyjD3Q/kbslWncxnl3JLLnoL640jff7Ex
	gDm1d2ulBOToN3eVPwB1Vlt7tHOWHCrklSqhDCimNUgTjmXSRNI/fcQlFPw2laqW97g0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x80Ux-0006xA-Kj;
	Sat, 19 Sep 2026 19:13:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x80Uv-0006x3-T5
 for openvpn-devel@lists.sourceforge.net;
 Sat, 19 Sep 2026 19:13:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gNa3whh3EUNkZFhvMV+9kf5b989QPHzEznX4AmDO0NQ=; b=FmewglcIWnGQZ9hoZDgd8yMqXx
 24KQ61K0TkiSLnNAAZnwMTldbJeBs7fbRu3idmiqF3Zg9EmCyo6ociCccakLxbl0b/t7z+j9wq9pl
 XucV6LyJa/4DJ8emlihVnAotmzfYeBa4B/fjXOyE9XjNzdPRChSUzczZew2u5bEIVokM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gNa3whh3EUNkZFhvMV+9kf5b989QPHzEznX4AmDO0NQ=; b=QJVwwsg3jE5GUo3vMTByYM3ECc
 J+3FQV89GSpZwk7UNuiYVlwznOycgwzeJ/zZgEEAJ8M5D2neZVLXKYJLtHG5tse4fcW0azO6Wacb0
 DBZ0V9UO8KDIXI56Sp+OXUfuGrRbRqWv97Y3J+gRRP/Kluls2+i2aQiWPzilmYx8ivHU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x80Uu-0004BA-Ae for openvpn-devel@lists.sourceforge.net;
 Sat, 19 Sep 2026 19:13:17 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68JJD9ed082493;
 Sat, 19 Sep 2026 21:13:09 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68JJD9B4082492;
 Sat, 19 Sep 2026 21:13:09 +0200 (CEST) (envelope-from gert)
Date: Sat, 19 Sep 2026 21:13:09 +0200 (CEST)
Message-Id: <202609191913.68JJD9B4082492@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260918180507.26425-1-gert@greenie.muc.de>
References: <20260918180507.26425-1-gert@greenie.muc.de>
X-Headers-End: 1x80Uu-0004BA-Ae
Subject: [Openvpn-devel] [PATCH applied] Re: dco_win: report per-peer ioctl
 failures instead of exiting
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

Reasoning & patch makes sense.  Have only stared-at-code, not ran actual
tests.  BB is all green now - it reported errors which were not cause
by the patch but by network issues external to us.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 11a37e7733ab8b98add5fe168ae25497f89b3873 (master)
commit e02ceb9d45d616dd276d34bfef1813bd2dc6500c (release/2.7)
Author: Lev Stipakov
Date:   Fri Sep 18 20:05:01 2026 +0200

     dco_win: report per-peer ioctl failures instead of exiting

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1920
     Message-Id: <20260918180507.26425-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39349.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
