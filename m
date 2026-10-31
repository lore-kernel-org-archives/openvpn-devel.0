Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17340606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GCMwGMC6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IVfeqgQb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=adqdSyhg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0NE+vjLeWiNOj4QdJ7F7LkpmOAg0FTSyuO6Ay1HNQcs=; b=GCMwGMC6iRU4hM
	W5qGDXbFMO32OexzCmWBxxGgbLjzinfSqpqvSHHCqFxpwdkjXv6MP6mqm8nE2MAJXG5DMOwnggv2W
	nsbVxvd8uLhNq9ZqaOfmhHCBCqupq84giGlMXt6eMHxoCCIWi0zaTXWpNEQRQlkaUgHLlnENvQF94
	OuY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNBhc-000000003cH-2Uxr;
	Sat, 31 Oct 2026 16:13:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNBhb-000000003c3-1bIk for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ccgPqLeWl6ePjbcBUyF4PGqZQOhfG3NgAsupVj/LfVA=; b=I
 VfeqgQbqpGyr9vGkNqYsDAYLwfUHz5gKqKhOaMbZQONyeLnfPgQhhDXqMYZrKJmzj2jiok6yCh9yV
 0wskFGTdSQJp1HKPQU8kzFK+MJjIU+CiLzkf40AU2amDRRINATP98Tut3XLY+jBBP6NWJLVAIhvfb
 GxoKX4sJ8hUCwrUA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ccgPqLeWl6ePjbcBUyF4PGqZQOhfG3NgAsupVj/LfVA=; b=adqdSyhgHPJCFRgzupgkL13cCh
 b8Opt1uu3ow7IIVubAhWdD4WYNLHZsA1j9VdWEy4q3bg4ooG9HU8CcAJ+mhbdVfFQGF60sAep7kez
 SibsD20wwsF19OdluLPt//Y30PnxOJT/uNfgiynpL17U3aduREu+UrQJGja8RdABSMjE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNBhZ-000000003bg-2Wfm for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:13:07 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69VGCwsR091351;
 Sat, 31 Oct 2026 17:12:58 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69VGCwJ3091350;
 Sat, 31 Oct 2026 17:12:58 +0100 (CET) (envelope-from gert)
Date: Sat, 31 Oct 2026 17:12:58 +0100 (CET)
Message-Id: <202610311612.69VGCwJ3091350@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261028122226.3006-1-gert@greenie.muc.de>
References: <20261028122226.3006-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNBhZ-000000003bg-2Wfm
Subject: [Openvpn-devel] [PATCH applied] Re: Mark buffer invalid with
 username mismatch in server side float
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

This is sort of "obviously correct", if one looks at the check before
that (10 lines up) - msg("Disallow float"); mi->context.c2.buf.len = 0;

It's a bit of an obscure edge case, but a bug nonetheless...

Your patch has been applied to the master.

The code in release/2.7 does not have the "locked username" check.

commit ba6967b7f023651c42e32b0d4f4b5279692e0778 (master)
Author: Arne Schwabe
Date:   Wed Oct 28 13:22:20 2026 +0100

     Mark buffer invalid with username mismatch in server side float

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2058
     Message-Id: <20261028122226.3006-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40227.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
