Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D6606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EedkvUte;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CAv+48nQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MAeAHhLa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YgUWFFeoDf2xxuJXnz0ZNAeVW8MAV7jHpC15qFem4EI=; b=EedkvUtemXdTIu
	29WDu1G83ccMhchaFZlNpXDyTBQvxbl3f4p9tFQhZq/jk4PCIcHxGCzc+67GQq9sKSF9bk7Xddqen
	P0dt9voqaakh3BIlIkRpjPSbm4PPXCD/ZOJbXgv2ifNElZruTeMz/ra8UIHZ6Be4pnXdwtLKxWcS3
	NWo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xStMX-000000000tJ-1Hj9;
	Mon, 16 Nov 2026 09:50:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xStMW-000000000tD-2peL for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FilvKLS5yANU1ZEVHuE+HKoKM5sMoYxtRuoRwhhKgCQ=; b=C
 Av+48nQ0cLS//81AYkXxrcJPzGU7XxwN6SRnFMLF6gC7NrWiNkwm0DKuaJRngNoVmtw+uVdgMzi1r
 zcO7Ja/7g7S7+ca6KZfDpV6hytOTTvexAiIUYeGVN4AMxG7l/idDeJfS/BIqA8C4wrhz5Rot6P0cM
 iXD8Wa1DtdQARoFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FilvKLS5yANU1ZEVHuE+HKoKM5sMoYxtRuoRwhhKgCQ=; b=MAeAHhLa0VLozEFDW99oN/h9LQ
 ZtiFLCXPGygE16Fb+P5Zp4st8puO9sV51wP529pKCwZHWzJOPzUTDPUzLabc+OKjcwYzLUkQPGWdz
 yPWSI9P/zD74efhpwww2B0mEKjLqPquo0C0S3Ovw5Wx1QzOk+KibgrsZtDdjmHA/KyfQ=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xStMV-000000002GK-1l8o for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:50:56 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AG9omav067585;
 Mon, 16 Nov 2026 10:50:48 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AG9omOB067584;
 Mon, 16 Nov 2026 10:50:48 +0100 (CET) (envelope-from gert)
Date: Mon, 16 Nov 2026 10:50:48 +0100 (CET)
Message-Id: <202611160950.6AG9omOB067584@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261112141839.5147-1-gert@greenie.muc.de>
References: <20261112141839.5147-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xStMV-000000002GK-1l8o
Subject: [Openvpn-devel] [PATCH applied] Re: auth-pam: wipe and free partial
 responses on conversation failure
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

I don't understand much of this PAM stuff, but I can see it contain
security relevant information, and "num_msg" is the right upper bound
for the loop - so, makes sense.

Since this affects "leak secrets onto the stack/heap in the production
path", it gets to 2.7 - test compiled 2.7 on linux.

Your patch has been applied to the master and release/2.7 branch.

commit b94220584e03a56507d568c6030e31b360322cfe (master)
commit 4303ff627d205c30a4074b4a28444826917d433c (release/2.7)
Author: Razvan Cojocaru
Date:   Thu Nov 12 15:18:33 2026 +0100

     auth-pam: wipe and free partial responses on conversation failure

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2179
     Message-Id: <20261112141839.5147-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41194.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
