Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0BF606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CYCA2q7j;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=l7/3QgXL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XYhz/lSU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=c+NLWEdGKkz+0qvw3guwkFi9pCvUfN728ZaDajUv1Sg=; b=CYCA2q7jFLg09F
	QH/eb0t4XJYffFHE4iBjH/fpUUAnjSfID1mMHb4KqKIW+vtrRX2RsOW0ix5sJzYZT1EeAcIG+aZX2
	pQh6AdIKtTm0ZKrQULEPHPLaisUUWpFCPulPGo3JwPdB70ifb9kpqaHLFZF79ZiUkGZFPTAXeuGs3
	yOQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTN0J-000000003P3-3buU;
	Tue, 17 Nov 2026 17:29:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTN0H-000000003Ow-3Kmy for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HxFmUKTFrzZ9B/mCfwBbUkmyNr4NxB3nDeYbUHLEqNM=; b=l
 7/3QgXLMOAjJK9itr4BSr6MK1U2Em5eyOqZf0O+z1e1Kci8JtEMSG/zBv2wUkvq0cmp5XH9rq/hai
 9qbLtlAiJVK4GrOdElSMj3VbG9BdS0E7TH/Bd3nZTKlBsvJ7QECkYBGOYYzAyLqJzEwsy7smrCxae
 lUaQcePZj95vHfwY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HxFmUKTFrzZ9B/mCfwBbUkmyNr4NxB3nDeYbUHLEqNM=; b=XYhz/lSUq5UEuswynqarIgRb96
 BEcCH1UagqifYl8ndU/iiV7b0bLf1uNOoOhJ740FgL7l7GnDtBJcCA0B6jdoKARSxuAqvXypLstTy
 uq2tvxB42c6g6hkEtnyDQxrIYtGia1B66LXlUgi2tSPXlrmUlp9RzYJcR9Tfhc2bJopg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTN0F-000000004XG-40ay for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:29:57 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AHHTnKh028741;
 Tue, 17 Nov 2026 18:29:49 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHHTnSV028740;
 Tue, 17 Nov 2026 18:29:49 +0100 (CET) (envelope-from gert)
Date: Tue, 17 Nov 2026 18:29:49 +0100 (CET)
Message-Id: <202611171729.6AHHTnSV028740@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261110150210.17991-1-gert@greenie.muc.de>
References: <20261110150210.17991-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTN0F-000000004XG-40ay
Subject: [Openvpn-devel] [PATCH applied] Re: options: share the reset code
 of remove_option() and update_option()
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

Stared at the code change for a bit, happy to have the +2 from Marco as
"owner of that code".

Deciding on 2.7 was a slightly tough nut - the change is fairly large and
reworks quite a bit of code.  On the other hand it's new code in 2.7.0
that "needs to settle" and I assume that PUSH_UPDATE is not very widely
used yet - and all future bugs we find in that code will be very painful
to backport unless we have the code in both branches.  Also the changes are
nicely localized to "PUSH_UPDATE handling", touching nothing else.

Thus, 2.7 as well.

Tested both master and 2.7 on the t_client/t_server testbeds.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 7c1328aae934b27305168fe9a7e259f84c21690e (master)
commit 55f7ffd26ae42da7d5089b088b547c558e98a775 (release/2.7)
Author: Razvan Cojocaru
Date:   Tue Nov 10 16:02:04 2026 +0100

     options: share the reset code of remove_option() and update_option()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Marco Baffo <marco@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2164
     Message-Id: <20261110150210.17991-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261110150210.17991-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
