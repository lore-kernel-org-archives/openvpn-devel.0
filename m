Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC522CD6E7B
	for <openvpn-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bfY5nPUyyg646QHAr9MbT6jmUDdgvU0MHVyGgMp+lB4=; b=Dxx8PBobx4Glhs/pv1XU/Jh2s3
	gYx5n7VfrxAT2FKSvQ7nWJeHe/2KqnwJ1Hy9jtDznJuFLUVxXpw3F2Q4zPTn0HdBWKIA0GkIjc96F
	alSLf4MBpUX8BeH62Wj4+wRUn0NK3jY2OkkRn1Vd9K0VOAObuZK7pc1dvmnhfYzTv6GA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wVZ0Z-0001XT-KJ;
	Fri, 05 Jun 2026 18:11:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wVZ0Y-0001XM-0Y
 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:11:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Mm/2HnpmTe7Z6wTub6r20O8ge+OD8RHXVbl1CpO0ZU=; b=T5ulTHVC26+HPj2saHVbDIKizZ
 7rI9itmztzqEVc1XoOviyPYl/b/TkZzRnirYFN3h45ttLzIf9A+Ax3By11GYXe3OtuD0/xwgXmbMo
 IuQTkUZOCgH0Ve2FuyXaDPm89b6ZkVkhL8aIf6yhmpXiPaEa1WzO3FPGxlDuoJ1iJGuA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Mm/2HnpmTe7Z6wTub6r20O8ge+OD8RHXVbl1CpO0ZU=; b=Gv0gz4mvLH+iFTO0hfH5VA5MJo
 N5EFihIwqHrtnnVgdmst+tebnVJdD7MXyONwoBDAtvo70HcAc6ulUxiP4Z+mscn5TyVtLFVJwIzK/
 aY0IixtwSL5zGJUaWCp08p1J+Zln1m0t5huxvH28NJCRD1q65Pui+4CjrDeAYqvM23m8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wVZ0V-0002cW-L9 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:11:01 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 655IArOb003793
 for <openvpn-devel@lists.sourceforge.net>; Fri, 5 Jun 2026 20:10:53 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 655IArcr003792
 for openvpn-devel@lists.sourceforge.net; Fri, 5 Jun 2026 20:10:53 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  5 Jun 2026 20:10:46 +0200
Message-ID: <20260605181053.3774-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1779896625000.Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5@gerrit.openvpn.net>
References: <gerrit.1779896625000.Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wVZ0V-0002cW-L9
Subject: [Openvpn-devel] [PATCH v1] dco_linux: allow passing
 KEEPALIVE_TIMEOUT without KEEPALIVE_INTERVAL
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Marco Baffo <marco@mandelbit.com>

Depends on: https://github.com/OpenVPN/ovpn-net-next/commit/67f453e3146a646ef5f811e5a85c610537d80521

Closes: https://github.com/OpenVPN/openvpn/issues/911

Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1705
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1705
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d332359c..0998bd6 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1623,9 +1623,9 @@
 
     if (dco_enabled(options))
     {
-        /* dco_set_peer() must be called if either keepalive or
-         * mssfix are set to update in-kernel config */
-        if (options->ping_send_timeout || frame->mss_fix)
+        /* dco_set_peer() must be called if either keepalive, ping, ping-restart,
+         * ping-exit or mssfix are set to update in-kernel config */
+        if (options->ping_send_timeout || options->ping_rec_timeout || frame->mss_fix)
         {
             int ret = dco_set_peer(dco, multi->dco_peer_id, options->ping_send_timeout,
                                    options->ping_rec_timeout, frame->mss_fix);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
