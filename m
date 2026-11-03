Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CDD606A32E
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AiSEFemo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IL26poPE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iaa0sABr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2WAL6rLT2TWxmXDJ9k0eDmxS6aWZ2nice0ishTwJ5xI=; b=AiSEFemoo1Qu5z
	B//a2c8J+I5Hfk0rdUcLZOJKaU96k5NAFI1ChUJDfVQcL93PWh7JtmfZc+gcCs6m1P2O7b7+Bilqz
	GEStZrhIS76yft0S1Ctz0yA/RcgzsVq4Qsn4+iZDlH39ltxPhNqKQEP/4F28Un2LAeHVqKWdo6xyb
	79Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOJIS-000000001lf-2x6y;
	Tue, 03 Nov 2026 18:31:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOJIR-000000001lZ-3Mf2 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:31:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fEfqdElggosvAsCXQSRXAjTLRk+TnRMXr/wWbvk94Fg=; b=I
 L26poPEEsCNAPans83AtZrS5zdPxmq/VuDvIUMsMkZS6w4TBFhEikcNluoed3a1TvFM0tkJnp0VpC
 KgJWtSjVdABFnZPgsnh+jdPv3tBoUUF/0VmB0Ob87KEnJIG2fqkalwLzizOPchbeiSoOeZs6EiMjU
 xc/P2GUsCRQ1PIyw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fEfqdElggosvAsCXQSRXAjTLRk+TnRMXr/wWbvk94Fg=; b=iaa0sABrPUdPY5RlJUkeAJvY5C
 JcDscNkNGFKJSXHMB10wyA4/Yx5KhiXt4x/Sj5N7+N4NGjNL1fx9JTS31VppsuXtjidSdhp3zX0Bi
 Ri5pu9mpnDdY5EoZr3yu+YxubPxW9FOIT02Fin+D3PkDhadLlE/VYydD0imU2+1RxbeE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOJIP-000000004uS-2vBO for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:31:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3IVd5x053850;
 Tue, 3 Nov 2026 19:31:39 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3IVcMr053849;
 Tue, 3 Nov 2026 19:31:38 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 19:31:38 +0100 (CET)
Message-Id: <202611031831.6A3IVcMr053849@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261102170238.111437-1-frank@lichtenheld.com>
References: <20261102170238.111437-1-frank@lichtenheld.com>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOJIP-000000004uS-2vBO
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: fix inverted
 inet_ntop() check in GetItfDnsServersV6()
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

Our test coverage isn't good enough :-( - this is one that we should have
seen ourselves...  (some of the unix buildbots test --dns / --dhcp-option DNS,
but this is windows specific code).   Lev, Heiko, are you listening?

Since this one is a bug that can break the regular path, it needs to go
into 2.7.  Compile-tested the 2.7 version on MinGW and GHA.

Your patch has been applied to the master and release/2.7 branch.

commit 09cc40a6ff9e1d81db463a7769c464dd2baecf1a (master)
commit 542bf14970907c2a7d11890a09bc4209f02045ed (release/2.7)
Author: Razvan Cojocaru
Date:   Mon Nov 2 18:02:38 2026 +0100

     openvpnserv: fix inverted inet_ntop() check in GetItfDnsServersV6()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2090
     Message-Id: <20261102170238.111437-1-frank@lichtenheld.com>
     URL: https://lore.kernel.org/openvpn-devel/20261102170238.111437-1-frank@lichtenheld.com
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
