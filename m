Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3F606AFCB
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=By6t45se;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=M5prQxH6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hv+3EPDH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wGni7gy20FpPIHbeKbYIfgjD4aVpOxJyMgi7vWTZ5ok=; b=By6t45sem+zDjB
	E6lKqJOJNESvzMpfTxkMIqBDOFE1NOfx6WsZ9neau6wzPmm95KIQq9PVej48YoxUhbei6AFLAj0oh
	d93FRsEwr8gic4IW3ApkBnqYRC4Cx8vv0oXMXq1Xbsylnw+oOL+7v4CVpeFVBcNrw50zyCoU8xZWi
	YvM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQUA4-000000004In-03FS;
	Mon, 09 Nov 2026 18:32:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xQUA2-000000004Ih-062X for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 18:32:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=73yn9bagjZF+YdlOVx9Z3B1SX6w2cBgbm3HAoCZ4pSo=; b=M
 5prQxH6/1Ww4eIULb5sHtA1i7sWzZEvUnVeyY6k9lpeMPmX3AYlI6rv6a3XfUZXV7PL9bvox8Agux
 uhH5gcb3N6h5kYaTIR3sTD4jkFgYHUTddSw+6Ce1kYxcnyf6y/zdyK5XTEYNiWfT1dxeMvyqr7p+0
 NtWm4263yKwespiU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=73yn9bagjZF+YdlOVx9Z3B1SX6w2cBgbm3HAoCZ4pSo=; b=hv+3EPDHWyPULz4CzDDv3bgJ5c
 fM8OhlSDPts6wa/ZPsj1T4HHEeEETFKWA+D1HqBnYc7ssYNz/ua+z9vrLwLrCmHLMbOCmwGIQJPM6
 55xq6jOsXQNYMN1Zd4gJf3aUg7PaXiKPZv8oR1yzkaU2Rk9Iy7PPWZrplPOI8bzGSmfA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQU9y-000000005dU-3th8 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 18:32:05 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A9IVuXh034814;
 Mon, 9 Nov 2026 19:31:56 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A9IVti3034813;
 Mon, 9 Nov 2026 19:31:55 +0100 (CET) (envelope-from gert)
Date: Mon, 9 Nov 2026 19:31:55 +0100 (CET)
Message-Id: <202611091831.6A9IVti3034813@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261109124623.26716-1-gert@greenie.muc.de>
References: <20261109124623.26716-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xQU9y-000000005dU-3th8
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unused gc_arena variables
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

This is an easy one again - just verify that it's all "- gc something" lines,
and see if it still compiles :-) - and no backport to 2.7.

Your patch has been applied to the master branch.

commit 83c988d49fddc7e0ad9c40741ab6f391f236ed45
Author: Razvan Cojocaru
Date:   Mon Nov 9 13:46:18 2026 +0100

     Remove unused gc_arena variables

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2149
     Message-Id: <20261109124623.26716-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40981.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
