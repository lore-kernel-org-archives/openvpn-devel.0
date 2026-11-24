Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5489606A32E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E+XhkNo/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hNZxw5//;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=N1V8emq5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6fP91nMYPYwmbARH/ubFsp58zJYW30lvULUlHpx8Mn0=; b=E+XhkNo/U4IB03
	lIjuaANNEUmHqBoqnSXpMeRIUnXf/cq11+50ODKuusU5AbPGkrEsFAZZhT5Sd9U8xAMURW6y0ruMD
	/MMMs6pdaifWGXI3X/TEznBPj7rkP4Ky/yL0WDrPdAdWksJJ2fXmyP9MT9+1+6amuZw98seDw6Pr5
	f74=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVrS0-000000007Jt-1S0t;
	Tue, 24 Nov 2026 14:24:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVrRy-000000007Jf-3FtU for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:24:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6FLE3QfFbLrbeuA9wla6bJNh1BglLE1NsOjxrSc1Src=; b=h
 NZxw5//QF0XwyKdWyLLkAqiIZutfBBxuUERApqgYaGsDZOsPjdfz/16mccSJP0WuzdclEXvm6ifOn
 HmW8q/Or9Gjwv1STxeFCmJ6px/T1BCkY4AWfMIdroLQF0Qo8nfU9VejjgFw2drJfHhrdfMHooTFwK
 oANBFV+n8yy9vzAA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6FLE3QfFbLrbeuA9wla6bJNh1BglLE1NsOjxrSc1Src=; b=N1V8emq5D5jiVsuTIdnmKAqF6N
 /zRwEbPaJuvVYQC7Tpo3jImerHXnJ0pkGAFX931C2FWVwQV55irUP3az5/22keXgClopVrG5BG9C1
 Tqq0FCopVapMrsI7ZQPox2QEdKPJ5Sa88QC3j3dq/F34qukDXP28IEuoq1WcS5MS2JSY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVrRj-000000003eo-2l3Y for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:24:37 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AOEOOAt026856;
 Tue, 24 Nov 2026 15:24:24 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOEOOEZ026855;
 Tue, 24 Nov 2026 15:24:24 +0100 (CET) (envelope-from gert)
Date: Tue, 24 Nov 2026 15:24:24 +0100 (CET)
Message-Id: <202611241424.6AOEOOEZ026855@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20261118181613.2865-1-gert@greenie.muc.de>
References: <20261118181613.2865-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVrRj-000000003eo-2l3Y
Subject: [Openvpn-devel] [PATCH applied] Re: options: let the interactive
 service add routes again
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

"Unexpected side effects"... supposedly there's reason why being careful
with what you "fix" in the middle of a release train... (but I applied
c139e82d, and didn't expect surprises either).  Whatever - this is how
it should have been from day one, not relying on a particular order
of options.  Plus, we want all these '--route-method's gone anyway.

I have not tested this beyond "does it pass GHA builds on 2.7"
(plus a bit stare-at-code and the GH issue)

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit d159055ede16e322548e46d154523e2fc31ccf74 (master)
commit 9709f262c385c1513484ca7073385c3ecb10cdc9 (release/2.7)
Author: Heiko Hund
Date:   Wed Nov 18 19:16:08 2026 +0100

     options: let the interactive service add routes again

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2219
     Message-Id: <20261118181613.2865-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41648.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
