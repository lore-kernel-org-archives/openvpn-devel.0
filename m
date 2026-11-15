Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452AD606A31E
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M2M48hpX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cuuyHmXB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=df1PRRMp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wMwLJr7b/tcpeHFZf5lFiqpdkpudE5aQHT9Zc4IY5wE=; b=M2M48hpX/krvhE
	Y6Ll1wmI18lHU3ytZghYh0ZY9kxO3kc2sB39Zc7jr0CsSWg0GwUC2KgTya1T9VUYLsdlTMpuU0KXz
	XKnB8sXYoFO1JcgdHPOGNx6ywS29LkiGzK0i04k02v8Q9/JPopetWx23niZJsrHfZ2gWg0qd2v1c5
	B5I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSaye-0000000082i-34f9;
	Sun, 15 Nov 2026 14:13:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xSayd-0000000082c-2hMj for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:13:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HPTMllO/ZcIjb2ZBZX/Adsw08eDcuZnMZvaEUb+mnSQ=; b=c
 uuyHmXBDhI6rNmNB9MlDb0Xv+fGmAY6PJRBvLtvgaxUtFM9TNAxIMUu28YGJBnpR9yJO1ib+87SIU
 WzdglPdtVfKKevZ74xfgt1v4FllZSw5/rOJL/qIOHOylfOCtokvt2/O3rKbjtdTw3dMhZT0wjqDUk
 LM+NkjnvGyrNagIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HPTMllO/ZcIjb2ZBZX/Adsw08eDcuZnMZvaEUb+mnSQ=; b=df1PRRMpWv8xmzjphGc29Oy8+x
 G7gkYGsx+F9qmS2DAhHoOpcL8sj0iNz64WJXBRtBfKZ4Bkw0w+iClocvi7XBw6VvebaqBJi6C1T3S
 ccZA4sYLb+CpHL0WgsC1crCq/7vx+ezcekNEHPNyBM9cmjgHIdCnQMhjGK33CK2ycUWM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSayc-000000001rB-016A for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 14:13:03 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AFECte0046877;
 Sun, 15 Nov 2026 15:12:55 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AFECtHB046876;
 Sun, 15 Nov 2026 15:12:55 +0100 (CET) (envelope-from gert)
Date: Sun, 15 Nov 2026 15:12:55 +0100 (CET)
Message-Id: <202611151412.6AFECtHB046876@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104124859.18417-1-gert@greenie.muc.de>
References: <20261104124859.18417-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xSayc-000000001rB-016A
Subject: [Openvpn-devel] [PATCH applied] Re: manage: drop unused input
 parameter of management_query_multiline()
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

Funny code, this... have an input/output parameter which is then never
touched in any way.  I wonder who committed this in the first place...
(no need to ask, I know).

Since this cleanup and no user-visible bug, no need to go to 2.7.

Your patch has been applied to the master branch.

commit 5bd4216b44b523efad1af3176dad40ecabbcfe14
Author: Razvan Cojocaru
Date:   Wed Nov 4 13:48:54 2026 +0100

     manage: drop unused input parameter of management_query_multiline()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2125
     Message-Id: <20261104124859.18417-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40679.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
