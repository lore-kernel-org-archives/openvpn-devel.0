Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8216606A323
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PteESU9F;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EIxjaDws;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ICiRy6hL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zLzrEUN6bc7wNi03n9vE+KJePrfUmkTtdf2m2t1FMH4=; b=PteESU9FjepPrj
	BecWtAAKiw9XTEXvpI7rakd6SMpfy1nJlFM/nQ7rWt16SaoCE8Cncg1bHNgCu+0fvW5936xn++WFA
	LQWZ70kWXwTs7dB5BsYGJ1uIx842q8CmNr1r2MeSKClsxK9VBwBlFvx/kiwlFmk8fkkFTQ60OCTkc
	c9U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGTm-000000003H8-3a8w;
	Sat, 14 Nov 2026 16:19:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSGTl-000000003Gs-0Q1v for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:19:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aQaPX2CBfaFf3Kad48KZyoO+1aI7tD506kxUoY9w1LE=; b=E
 IxjaDwssGZ3ZhXWOQ0dQ7a9DQ0YJc7WkPuC3R9xcJ2fhKH/NtPmPzdXyb7rbFXlgeOpu4Qzpf9KcG
 2sDSpYysXtM+Ok0H34tASeP0LUh4ysgMmkode9nS8plYs93wVZYjkoRjydhf++T1oTN6/gOiMuHx4
 xoBKwS9jnV0g/UOA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aQaPX2CBfaFf3Kad48KZyoO+1aI7tD506kxUoY9w1LE=; b=ICiRy6hLc/eM8xjok2Q4VezSPG
 h9rQb7dTsPYXstIWB6AB3gy5zIxFkF/mlLcUjH8+0QzH8E5vQHrzW1qftveAvZal18t3i/9NZw8V+
 7f9qNmqWidweeDn0oz6Mio81s9ZCdZR2+ty7lh0Y+eRqF5IzmpmPBPpQYBzcmX7JxT8E=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSGTj-000000001fD-2YI5 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:19:49 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AEGJfj1088506;
 Sat, 14 Nov 2026 17:19:41 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEGJd5R088503;
 Sat, 14 Nov 2026 17:19:39 +0100 (CET) (envelope-from gert)
Date: Sat, 14 Nov 2026 17:19:39 +0100 (CET)
Message-Id: <202611141619.6AEGJd5R088503@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104122103.15637-1-gert@greenie.muc.de>
References: <20261104122103.15637-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSGTj-000000001fD-2YI5
Subject: [Openvpn-devel] [PATCH applied] Re: tls_crypt: print tls-crypt-v2
 client key hint before CRYPT_ERROR
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

Funny thing, this, with warning messages expected to actually show up
in the log... :-)

Just test compiled the 2.7 backport.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 3c687de340436e0c6d516df73379ee993782d13e (master)
commit 39904b62bbeaa88e55f07d6e3be606b1f4aec4f5 (release/2.7)
Author: Razvan Cojocaru
Date:   Wed Nov 4 13:20:57 2026 +0100

     tls_crypt: print tls-crypt-v2 client key hint before CRYPT_ERROR

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2117
     Message-Id: <20261104122103.15637-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40810.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
