Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6718606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iT9kEmrX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OWQ+Y9GU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ep9MM8EO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jnnR10kfqujrxBryNmnQnASaXVNVMSq8N1XiUAlvu04=; b=iT9kEmrXHoDd/A
	W5NN4kaRJZzH3OazKFTTKMRcb6KfL8t5MBM/kP0nNBuz/Q9nk53w3S+u0wI9eywrQbx1ihkMKefUI
	S1rJJiGFd/xwpdot/v+EgS8gLyFeGHN1WsuybnWpl7OI4y5/z2yFmVuoT1I8NnTzt+QbENM7zKYEY
	CEw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeNM-000000004zq-0Xun;
	Wed, 04 Nov 2026 17:02:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOeN9-000000004z5-26C1 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:02:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vMVjeGseDfivZdsihvGIZi4iehnWX7x7ufhtHmzrMYg=; b=O
 WQ+Y9GUwxQjgVMLODaHc2T3RjSiT3KYP7WAhYj9WGauL7frrI9sHuNxuSU6qiPK3rIhmyxEOZHBzR
 ei6WiZKaMMzWLPkEh0L1whYc6UefwAWmvvx405Cg3GAtC5uEs9PmFCnFBGDWpTSEYSEmNz2WUBYWH
 iRjVquYXuaZ0ghdE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vMVjeGseDfivZdsihvGIZi4iehnWX7x7ufhtHmzrMYg=; b=Ep9MM8EOsGy3etXJYX76DAf4hE
 3SmrTwNRFiqmxtgB4dMXZKtU42+mBBK8PQ7E4u4UpmlpObHIjIjN+H6uxkrpai8ghXerwIFR+lsg2
 mXsijrnaYGK95AOsoEcYKuI6QQ8rocel19wXZ8klLJLXdV0s8wuL/WbDDVAJ1/ROEGKI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOeN7-000000001dM-1oaJ for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:02:03 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A4H1slf097724;
 Wed, 4 Nov 2026 18:01:54 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4H1rmq097722;
 Wed, 4 Nov 2026 18:01:53 +0100 (CET) (envelope-from gert)
Date: Wed, 4 Nov 2026 18:01:53 +0100 (CET)
Message-Id: <202611041701.6A4H1rmq097722@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104124931.18525-1-gert@greenie.muc.de>
References: <20261104124931.18525-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOeN7-000000001dM-1oaJ
Subject: [Openvpn-devel] [PATCH applied] Re: tun: log the actual error in
 Windows tun_read_queue()
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

I'm a great fan of logging useful error information :-)

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 719f5c2c19037262a0758dc2f7e504ff7958b23e (master)
commit df8b6936ddc93465684d3f666840b3ec23119812 (release/2.7)
Author: Razvan Cojocaru
Date:   Wed Nov 4 13:49:27 2026 +0100

     tun: log the actual error in Windows tun_read_queue()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2120
     Message-Id: <20261104124931.18525-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261104124931.18525-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
