Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790E606A327
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MTizIuyR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CAp54Y81;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ai8QLuwq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=A+LQP5EqH/5uixkvU6N3P0Kk+rM5hmqNmmFNRNVl4rw=; b=MTizIuyRhojZel
	g3yUTlqIbn6hmGV3PYDkwBtQFjEyhXDnzwt+B2CUYEoqGEKEQGa6DkrQmyVEjskBMXFVSs6tgeqUg
	sDa+hyFBpWwpDoIJG84jNWc0OkSuSfdWWnq4vRzWisiZDIVH1T63KrP7SDKyUMM8Et2Ss3fxsukTK
	GlM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWHZW-000000003Au-2zot;
	Wed, 25 Nov 2026 18:18:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xWHZV-000000003Ao-2TK4 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:18:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6lR83c8IWZifrfBV8YUDO7N4BrjSiarxJH+ljG3QylM=; b=C
 Ap54Y81umni+Qo0RkfOl7HVT+n22Bbef9yOtcA1KxIXL5fgJZzdTNkQzLeN6SOS1E7UuN6C3RidIz
 gx2Y9zRYUXx3PinYAfkSQa+Pav/evmpY2+LVZUbNRNsHxVHiWqeuubo8Vh1NjC40fX7Ixp239JAYA
 JebB/evmwz9JaZTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6lR83c8IWZifrfBV8YUDO7N4BrjSiarxJH+ljG3QylM=; b=Ai8QLuwqlS0Nyws9iU7DIbKIqN
 XayQt8w2u5wPlDGbjR5i23vZgtePTcLkNN18yAv97/OORX2Wj/oP2rJ3m4L8LyM/urJlhFg65l7EH
 LllKZ0u+HQQ2uJFHqQKPzoCx30uLWBZH5yIqBwHIEv8XissVvEhVPQSsMJRmCRs3WgdA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWHZU-000000006tU-2a0t for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:18:21 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6APIIC5H079358;
 Wed, 25 Nov 2026 19:18:12 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6APIICLv079357;
 Wed, 25 Nov 2026 19:18:12 +0100 (CET) (envelope-from gert)
Date: Wed, 25 Nov 2026 19:18:12 +0100 (CET)
Message-Id: <202611251818.6APIICLv079357@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261124122448.8407-1-gert@greenie.muc.de>
References: <20261124122448.8407-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xWHZU-000000006tU-2a0t
Subject: [Openvpn-devel] [PATCH applied] Re: openvpn: make the context mode
 an enum
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

This is part 1 of the "stop mixing CM_ and MODE_ defines" set...  ;-)

Cleanup, not fixing an actual bug, so no need for 2.7

Your patch has been applied to the master branch.

commit d16c9874876d4718be83284a7eaaa2051d18438f
Author: Razvan Cojocaru
Date:   Tue Nov 24 13:24:43 2026 +0100

     openvpn: make the context mode an enum

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2333
     Message-Id: <20261124122448.8407-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41882.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
