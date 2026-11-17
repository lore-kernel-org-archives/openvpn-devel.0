Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EDE606A335
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mXrrczaU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=C+wBxXhI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Cpaa0f1e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sm5kzLka9bEV093oIdx5Xae9La+z9qmPmivA0QfG93A=; b=mXrrczaUq61WN/
	3KTOzP/2vhM517eJFuFsj2v9S8oigTWY8RpLPeJoi9EG3NL85EXXNA0e5fLc6r+24Ln1s5X/kT52+
	ou6VGXG2I9EhFHcuG3RvS9nSAHGZPbvRaeTTblUSS4CYDWnN4UllRSZaKES8DCVZhVlcEUAZs0sdV
	WYA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNKw-000000006kg-3dfY;
	Tue, 17 Nov 2026 17:51:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xTNKe-000000006kD-3NJ8 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:51:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Gs/LZc0tKlIhmuafTuWg7ZZ5FMYvVmgHG8HFVJstoIk=; b=C
 +wBxXhIkSsKL4Qeas+wULLLuAd8K3AvBjMA++VfOVCEAqfceYz4RX5aR9WqF8kWMR6nL/XOU+yoj9
 HZv1sC0aT1r7Gh601iSd2fcQ6nBaPj8Nef9UHMOAZwSyR1e2Gz629TSLYixxlVYKA+8XOV5tFjkoa
 trY4kK/T/JW1gS0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gs/LZc0tKlIhmuafTuWg7ZZ5FMYvVmgHG8HFVJstoIk=; b=Cpaa0f1etyhANUcreVkO/99fjk
 Hta28KG//Kmj8vy0KsCxjK6esOXgpZHKg1eMvwRmyc8quXx81TCRjZWh4w6Q1cFSwwJX3sQPFrTLu
 kaPrw+CY9Cgov7fyeLsUOhRsJnm8GWjE2cNsKwXN75dvNFhwS2eKiJ4+PL2jEAWUUECU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTNKZ-000000005Cn-297U for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:50:57 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AHHonRc029788;
 Tue, 17 Nov 2026 18:50:49 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHHonng029787;
 Tue, 17 Nov 2026 18:50:49 +0100 (CET) (envelope-from gert)
Date: Tue, 17 Nov 2026 18:50:49 +0100 (CET)
Message-Id: <202611171750.6AHHonng029787@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261117123402.12520-1-gert@greenie.muc.de>
References: <20261117123402.12520-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xTNKZ-000000005Cn-297U
Subject: [Openvpn-devel] [PATCH applied] Re: mudp: drop unused addr
 parameter of do_pre_decrypt_check()
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

Leftover from the old days where incoming sessions where looked-up by
(ip,port) in m->hash.  Out it goes.  Stared-at-code, asked Arne, and
BB all green :-)

2.7 actually uses this parameter (old lookup) so this can't go there.

Your patch has been applied to the master branch.

commit 18483720191ddd0420de73ca7454296977a28808
Author: Razvan Cojocaru
Date:   Tue Nov 17 13:33:57 2026 +0100

     mudp: drop unused addr parameter of do_pre_decrypt_check()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2202
     Message-Id: <20261117123402.12520-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41526.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
