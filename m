Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70516606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FMkY7ycG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gBbIyqt7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mHl+GgYo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/MXPsdfrlMQbzgA9Mtn7/HQjuj+fLC7ZZXB8kiKZRSY=; b=FMkY7ycGWpUiLD
	ywd4EYULTEafR3SWeNqnes8hQSNavEyZUhhfjQI6adPpFMwBUIsKR8wtiTZGBgtCOLYS1DNz2ERJl
	I/Yo5fuKuFGav74ERFE02juK+AXcr3CROHyW0WAvdZWKdz3n9DCS3gPJp1CFciiSo7bletRV83BPG
	zk8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWG6j-000000005A2-1fKi;
	Wed, 25 Nov 2026 16:44:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWG6h-0000000059n-3Din for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:44:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HAl5b072+XPpHJ3XDtcZNWsF5sKJ/zmcbXe+L89e0z8=; b=g
 BbIyqt7IJWFf0lGTCc8t5PCeO279tqofJNSusxaeB13MDZyz4SGA+ahtKT3hn38cazsnEbcCjc75I
 HS77S+3ZtPaBFm+CAG7Z/7Q+e71YprJ9006pqZo7NmBnNbf6isXh0NS/l8VUbJ+zVwpLgxjoZATou
 AbQpECdHK+NKtd7M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HAl5b072+XPpHJ3XDtcZNWsF5sKJ/zmcbXe+L89e0z8=; b=mHl+GgYo+hY1sCfui8xhIgENcl
 zDSPH6cyQ0byhwLia8rnXf/vnr8pR+p4tLyS9pGydYqeZBhDbP4d4yN4an9ucKgSIeBZe9pMvpCGN
 d8VXbq2SUcWs2kQ/+hVJ2yPOuhxpyB5lkYMyzuhXYds7Z8l9XY8UmIzlLdHHxrVsaFfA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWG6f-000000004n5-3L4v for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:44:31 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6APGiMOZ076187;
 Wed, 25 Nov 2026 17:44:22 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6APGiMWF076186;
 Wed, 25 Nov 2026 17:44:22 +0100 (CET) (envelope-from gert)
Date: Wed, 25 Nov 2026 17:44:22 +0100 (CET)
Message-Id: <202611251644.6APGiMWF076186@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261124142352.20244-1-gert@greenie.muc.de>
References: <20261124142352.20244-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWG6f-000000004n5-3L4v
Subject: [Openvpn-devel] [PATCH applied] Re: list: drop redundant check in
 hash_iterator_next()
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

Nice find and removal of redundant code.  Not needed for 2.7 ;-)

(Interesting train of thought, though... "if b->list is not NULL, assign
to hi->elem, and then verify that hi->elem is *still* not NULL"... ;-) -
must have been a very early AI...)

Your patch has been applied to the master branch.

commit c73bdd7387f097c1ffb421456a21a923fcb01f8d
Author: Razvan Cojocaru
Date:   Tue Nov 24 15:23:46 2026 +0100

     list: drop redundant check in hash_iterator_next()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2337
     Message-Id: <20261124142352.20244-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41884.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
