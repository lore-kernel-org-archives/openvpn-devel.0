Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01FF606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YEA+eLaO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GRJcN9I3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Kb/QqlH/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=dt11oQOIkmZ5ogLiI+CKtsee3j5KbzLum5n1f5yQHs8=; b=YEA+eLaOsdsM2H
	CyDqfDBCv2sRrrOnmjJZtuhUkTg+oYTm2mJ5hFbd4jPV+N9rpG0C1LZoFmk/apyB7Tk4x9x++uEyp
	b77Mw0dkOXlzWsXLty/cxOXwHXDtkr/CPbOM0lGxKnnyKTkb+cW2hc+yZjIrTYHINn+oVeQkYTOeN
	9AA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOtv3-000000004eM-24Y1;
	Thu, 05 Nov 2026 09:38:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOtv2-000000004ds-3e1R for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 09:38:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mv/XGzd843ndctLjk47Rh1LkW7qtfWXpgRzh1F2552o=; b=GRJcN9I3Dq+SyUj/zi/Q/ZRiMH
 Z4ld3WTfNWRNSYKUUWeTOYRfw6e8Ci4APBITtQ//rqCE6d8SUmn+cy78jCOx1WZIkidemd86tS086
 9+JqL1tDZDphVVQ4ndoZbdwcLJ/FhfDiXys7Tbbn9+AM+nHOWprR884OmCbmxdMS5bac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mv/XGzd843ndctLjk47Rh1LkW7qtfWXpgRzh1F2552o=; b=Kb/QqlH/IQ7vQxkBh04t03RshZ
 8S0r9m836MSR5YmtAIndoptk4xQkeQcszf/UfdOi0HiUcOHkDePexw811Od23hn+eoNdeCIHSR4Ky
 tMxmtjIhE/1MVbWSHQcHgoozUMQvP6rNOcvM0vfoA0u6e1wdTrqCxc70UnTkUIfUiWMc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOtuh-000000006ZU-2Dwz for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 09:37:44 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A59ba8V011856
 for <openvpn-devel@lists.sourceforge.net>; Thu, 5 Nov 2026 10:37:36 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A59baRO011855
 for openvpn-devel@lists.sourceforge.net; Thu, 5 Nov 2026 10:37:36 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  5 Nov 2026 10:37:30 +0100
Message-ID: <20261105093736.11814-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793580377000.Ic4243377c96a3b460d69050386cddcb30535de27@gerrit.openvpn.net>
References: <gerrit.1793580377000.Ic4243377c96a3b460d69050386cddcb30535de27@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOtuh-000000006ZU-2Dwz
Subject: [Openvpn-devel] [PATCH v1] crypto: Wipe the struct key_parameters
 copies after use
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

From: Hansaem Wi <hansaemw@gmail.com>

init_key_ctx_bi() and tls_crypt_v2_init_server_key() convert the key
into a struct key_parameters on the stack and return without clearing
it. init_key_ctx_bi() sets up the data channel keys (when epoch keys
are not used), tls-auth, tls-crypt and static keys, so the cipher and
HMAC keys stay on the stack after every key setup.
epoch_init_send_key() and epoch_init_recv_key() already clear their
struct key_parameters after use; do the same in these two places.

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: Ic4243377c96a3b460d69050386cddcb30535de27
Signed-off-by: Hansaem Wi <hansaemw@gmail.com>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2078
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2078
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 3d3ab0c..a5d4a38 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1075,6 +1075,9 @@
     init_key_bi_ctx_send(&ctx->encrypt, &send_key, kt, name);
     init_key_bi_ctx_recv(&ctx->decrypt, &recv_key, kt, name);
     ctx->initialized = true;
+
+    secure_memzero(&send_key, sizeof(send_key));
+    secure_memzero(&recv_key, sizeof(recv_key));
 }
 
 void
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 23c7975..1ac25ce 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -359,6 +359,7 @@
 
     init_key_ctx(key_ctx, &srv_key_params, &kt, encrypt, "tls-crypt-v2 server key");
     secure_memzero(&srv_key, sizeof(srv_key));
+    secure_memzero(&srv_key_params, sizeof(srv_key_params));
 }
 
 static bool


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
