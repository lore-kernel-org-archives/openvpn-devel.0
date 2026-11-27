Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208C606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NRLjAPSo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZqrOXg8+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VcwXEuv/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6oVReDzZlVD9kNR4De59GfpReYefj4hCJ45tyCXPMb8=; b=NRLjAPSoK//dmg
	jL4CTp595F/FNyrgaYbeVdYbnU+44tlsVKI4y7UzUcTib/Fc57YSqEI8kLiRgvAhEuxvJ4xa+SEga
	eIOH1TVrc2/FCNbLGUhtJ/8c7ZrqUro+Fx7w6f7KFjH9Dqy2RyNdhW2LS92WXjOOrViIF4TDu0+Hk
	M7w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX2U9-000000001il-0M8l;
	Fri, 27 Nov 2026 20:23:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xX2Ty-000000001iT-1e1F for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:23:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hh7Fhh1keFmO+Y/3dndaLsoLVp3j3UKt4rfBiVsw/EQ=; b=Z
 qrOXg8+FUGHQ0br/PI1WCfW9IWQ6ryejDDyeeKow6HHAnLRZq6MbLTyza/0PiXq5oZzeSfbbKOvtb
 bjIBNfpyPZWc+4OzBCzjJw2LdC+dvYAnAKnzyo+GlW5ETwrdHMQi0aVxegt0Qi4TGVz6Ft2sPcm2Y
 mOIe85lgz3n4isVY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hh7Fhh1keFmO+Y/3dndaLsoLVp3j3UKt4rfBiVsw/EQ=; b=VcwXEuv/OrIuh0VPDM40K3zalF
 sEZGHFJJYPBl7XApZ/V2Zs2HGmbhSilGVpTtPGgwcRS0H7pGZkk9hsshlaxfU7tisLP4AX9VwjR/E
 XQO7nfETYg69KJ89r80xKhITOaiZiyQu6Xqw7Nen260viqqSk5HW9UqbCr2E75+HPClc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xX2Ts-000000004yp-0rc4 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:23:42 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ARKNXKi074429;
 Fri, 27 Nov 2026 21:23:33 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ARKNXTH074428;
 Fri, 27 Nov 2026 21:23:33 +0100 (CET) (envelope-from gert)
Date: Fri, 27 Nov 2026 21:23:33 +0100 (CET)
Message-Id: <202611272023.6ARKNXTH074428@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261126115908.7374-1-gert@greenie.muc.de>
References: <20261126115908.7374-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xX2Ts-000000004yp-0rc4
Subject: [Openvpn-devel] [PATCH applied] Re: resolve: store the address
 family in --preresolve cache entries
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

Makes you wonder how that ever worked...  trivial fix though :-)

Cherry-picked with a bit of manual help to 2.7 (resolv.c -> socket.c),
compile-tested via GHA.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 537906c2ff7caa7ba20483dc4a59adfb5f9ab27c (master)
commit 6bcf44064092b0b5a88c6082edb1e601c78a2266 (release/2.7)
Author: Razvan Cojocaru
Date:   Thu Nov 26 12:59:03 2026 +0100

     resolve: store the address family in --preresolve cache entries

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2181
     Message-Id: <20261126115908.7374-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg42012.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
