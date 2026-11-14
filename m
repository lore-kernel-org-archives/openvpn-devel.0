Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81CF606A323
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ST1VMdyn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ow+W7SP3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hAYgXLYH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fT9xb16QDQPyrngPTEX9bTB1Lex3uLJqNSQet6g7+kg=; b=ST1VMdynLw2Tfy
	SIJsV+Pq1hLm4u768JFNacocTLsjd8P6kO6U8b1aF1hrfYWWo9h6+9SFA45EDpcY0VRGn6bjXlqd3
	dYLvvLVVwvPS8s59WOl7BTbJVExIUPLfwWeBrjV2H3zSJ8tlE/Iv85IRySzRaagv/t+o7XNlhCkI5
	Okc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGG8-000000006JB-3tX9;
	Sat, 14 Nov 2026 16:05:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSGG7-000000006J3-20B6 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Gouw+gUm9B36uWY26dT9LezDNS0LzdpozYx1W93wNNw=; b=O
 w+W7SP3p1g4kNll+4lSF6kLlYhFL1bTnhgw4/FhEJNP7jcasfu4RZr3J4HNI9Q0LzQ+EfLJJSlz4S
 HAHLQTqLwxp7zC6HztuL/Y56P0adbXVRYQTuXRI7574WHcCOv5mnu/j42inJMpjbgj1EUx7y7S5ez
 WTI7DR3eOoio1diw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gouw+gUm9B36uWY26dT9LezDNS0LzdpozYx1W93wNNw=; b=hAYgXLYHqSYTUkw6isvaJ4eWIx
 vb0xp8Z7P2fKoJG/KOGwbqUN14tWA8gYmTAyL4mc+Io5uAf/LIDR2Tn9jQnvPBzWyfC1qk/3XW/Rk
 TiacbzSv6rvSik81tE2gV/fNiVQs3CKemu/qVBY+5OZDqu0XolCQMv6l8JpBAxb/Nxx0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSGG5-000000001Tu-3QN0 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:05:43 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AEG5Z3f082666;
 Sat, 14 Nov 2026 17:05:35 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEG5ZEa082665;
 Sat, 14 Nov 2026 17:05:35 +0100 (CET) (envelope-from gert)
Date: Sat, 14 Nov 2026 17:05:35 +0100 (CET)
Message-Id: <202611141605.6AEG5ZEa082665@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104105431.7011-1-gert@greenie.muc.de>
References: <20261104105431.7011-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSGG5-000000001Tu-3QN0
Subject: [Openvpn-devel] [PATCH applied] Re: route: remove unused max() and
 gc from BSD get_default_gateway()
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

Good find, and obviously correct ("it compiles" on all plattforms, so
says BB).

Your patch has been applied to the master branch.

commit ab8f651b98261d61ecfe4dcf194fec348d4beee0
Author: Razvan Cojocaru
Date:   Wed Nov 4 11:54:25 2026 +0100

     route: remove unused max() and gc from BSD get_default_gateway()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2123
     Message-Id: <20261104105431.7011-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40674.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
