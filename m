Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04236606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UHot1lxz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iqYGU4lJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bpDMkYdf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nkt/HVzyLwhzNtVDd5FiSCEq7D+cv8ujNznYsXsqPTE=; b=UHot1lxzAd84Zx
	nZU8tCMi9LNAnb1Cu4YeL3TLvGiRYMfZB0sG8pVsJ8z1EwxLiNh1Y8rInAszRb//2V94w5vvgygnz
	7qMW4m2ngOCcGlkS7oBmTYwE58dMgnJ8DTJ+Pdn+LRL3BBcSZXhjwzxqXePGIhy0jIQIYFbouMuyy
	Ht8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODS5-000000000GH-1U9I;
	Tue, 03 Nov 2026 12:17:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xODS3-000000000GA-3HKE for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fkXg0WiiftI99w3Oby8NP+vkO7JE02npWmNbcfBN7ig=; b=i
 qYGU4lJP6vd2so8A68n4VykOMDAEEp5vYn0S2e3PH1kJk86XYELD2XVpHmNRCj6EkOY9wd45e6W7U
 3IhXtS+Y0b8eCh7Gnx+YXaAmXP1YewIq1HKn0yJfXpu6vLZf/0pWN+BvZnwJpjHWDGHUvDMUtA0Gm
 F4sVCFNdKwI04TcQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fkXg0WiiftI99w3Oby8NP+vkO7JE02npWmNbcfBN7ig=; b=bpDMkYdfBjg7eWVC19kjUCFbff
 WTBBr4EAQEL2Ex8gpFZwohJy5NcFGcIa5byQnB3mczV4h6TH7P2VOvxP+96Sxfy1zDKWtQR6Z6SOq
 VaxV4HKhxnGdq5QeaYhkHsk/xb5RUzUy1sS5VX7ciMUN8AQbm3Ko+NcM/skU0Zlf3rls=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xODS0-000000003C3-3o6K for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:17:19 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3CHAVo028974;
 Tue, 3 Nov 2026 13:17:10 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3CH9FK028973;
 Tue, 3 Nov 2026 13:17:09 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 13:17:09 +0100 (CET)
Message-Id: <202611031217.6A3CH9FK028973@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261103100955.20917-1-gert@greenie.muc.de>
References: <20261103100955.20917-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xODS0-000000003C3-3o6K
Subject: [Openvpn-devel] [PATCH applied] Re: Introduce
 get_key_by_management_key_id helper function
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

Infrastructure, needed by the next patch (1858)...  tested (t_server,
though that does not really excercise this particular end of things)
plus stare-at-code, plus "can we please have this dangling %u rewrapped"
(thanks).

Your patch has been applied to the master branch.

commit 6b617486ada6b9b936e0076081ca878ba493a3a9
Author: Arne Schwabe
Date:   Tue Nov 3 11:09:50 2026 +0100

     Introduce get_key_by_management_key_id helper function

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1856
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Message-Id: <20261103100955.20917-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261103100955.20917-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
