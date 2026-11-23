Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526F606A31E
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gMbNPglH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S1stqKf9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MnoMsGMc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vyFgJRK8TwKPydDs6bbR41JhgaXTHZ0FCR6fd0WmaDo=; b=gMbNPglHIcND2Y
	vzZoq4QNBwPTuU+qkzycKuzntFTMJ2VqpoB8iN+FeYWRyHeSJYWI9daGrwgMW52sdT0Jcofnqf61q
	SEuxMW4Of+l2rNQo5o7wy2fIGdEDY7Ld3ApAHfmmkbQj+A078E8NOXS50V82QpJoFZlT6MPjTolGU
	HTY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVVr3-000000007MV-0FpR;
	Mon, 23 Nov 2026 15:21:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVVr1-000000007MM-0GMO for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 15:21:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZPRx2ryVGkseohmh92SfnQZUnI2Nb40/lQVX86ms9ik=; b=S1stqKf982MHlmtByYOUQkYgmO
 3b4v0p2sdGWBK7ugKe3eylC+bunGz9BXzNKiFSFzFPlLVOF/pyeEvPS/NVjlo5uJdyOkDOWNE+z2r
 Q7qV5Q5lCg87FvIlgxr864JcXbXvalpVziDRTjidFk/V3bcFnUoNZmU6a//z/aR77ZrU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZPRx2ryVGkseohmh92SfnQZUnI2Nb40/lQVX86ms9ik=; b=MnoMsGMcBc+8/g7FTaQBlFzEdO
 9mmTEbvBQednG2KdODE270GSAKCd0QOBxlplhnlJe3ULhRBUlBUphYM4Qkc5g717X9JLA73aRd8Vz
 WWw2qGAkQ5bjNJaz3PoqTG2g+P+QQtCtAQvXYyu7Fnj3C5Xwhc0Q575WYF+GgR/zKmk0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVVqz-000000006P3-1fZJ for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 15:21:14 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ANFL6BZ009149
 for <openvpn-devel@lists.sourceforge.net>; Mon, 23 Nov 2026 16:21:06 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANFL6pF009148
 for openvpn-devel@lists.sourceforge.net; Mon, 23 Nov 2026 16:21:06 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 23 Nov 2026 16:20:59 +0100
Message-ID: <20261123152105.9130-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795445611000.I9b2ed331b92212cf517568b0a0acecf5a97b2d36@gerrit.openvpn.net>
References: <gerrit.1795445611000.I9b2ed331b92212cf517568b0a0acecf5a97b2d36@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVVqz-000000006P3-1fZJ
Subject: [Openvpn-devel] [PATCH v1] ssl_common: drop unused
 key_state.acf_last_mod
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

Added in 47ae8457 and never read or written.

Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2330
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2330
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 436770b..cfe3fea 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -263,7 +263,6 @@
     unsigned int mda_key_id;
     enum auth_deferred_result mda_status;
 #endif
-    time_t acf_last_mod;
 
     struct auth_deferred_status plugin_auth;
     struct auth_deferred_status script_auth;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
