Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F2606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AF1QmUa5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RlXNnWvS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gTWaWHGQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=s2AYonEJ6nF2ZW3ZGIOcWZXTaZi3nphqRtz3Imfktfs=; b=AF1QmUa5e4DK5P
	4PtR4aaL2h9UkO3sR+s50vj/cCP3aUbmc0tdwCIy7Hw850+gIhovz7P5A9gA6nNFR5vqjZSvFRNJi
	mAGLlWyVvU1R7ogKUz74+oGBgSiVLSmyX9P6yYCS4AHEbtrVnbzDsXPkwI7g3Fqlj9zHPWNWrpRVF
	V1w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTIOS-000000006IO-498a;
	Tue, 17 Nov 2026 12:34:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTIOA-000000006G6-2ACy for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 12:34:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yEMVz4U27pBL/3456G9IKHDJ04zxgWdErV1x/VEkjzY=; b=RlXNnWvSQRVPXhJW1fdKEBS4YC
 iriAFDwrIFp4VESeHrrdjmE7YWrpRjb9XQ59gdjDm/9pRteQHCjwt+J68rGWDUuy6wN0yX6lQM931
 8EKD/QoxgorKi9ZfFlbZwLmgEslCOYp64C/3oS6hQ1k3TFjbK9IqgqZ1N4Nb6hvmszP4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yEMVz4U27pBL/3456G9IKHDJ04zxgWdErV1x/VEkjzY=; b=gTWaWHGQ6+gJcq+ffWy2FHLJhU
 67NXevSQTOxEGcXoGqrFnXL0jk+0L77esuZK/dvG8ihu2/Vjz7usdnr8kJdEDLr3Sp+2KFiQos8pl
 GN4zT0XLDYLsSbok0vrOXh/U22OFxD6WkxifpYX0sE8ciuYGOlhddEMS0hnjc8c9vRVg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTIO2-000000000vN-1REw for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 12:34:12 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AHCY3GG012538
 for <openvpn-devel@lists.sourceforge.net>; Tue, 17 Nov 2026 13:34:03 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHCY3R9012537
 for openvpn-devel@lists.sourceforge.net; Tue, 17 Nov 2026 13:34:03 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 13:33:57 +0100
Message-ID: <20261117123402.12520-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794853507000.I388a52d19633d0604a1610fbfba31cfff7f518ef@gerrit.openvpn.net>
References: <gerrit.1794853507000.I388a52d19633d0604a1610fbfba31cfff7f518ef@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTIO2-000000000vN-1REw
Subject: [Openvpn-devel] [PATCH v2] mudp: drop unused addr parameter of
 do_pre_decrypt_check()
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

It was passed by value on every connection attempt and never read.

Change-Id: I388a52d19633d0604a1610fbfba31cfff7f518ef
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2202
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2202
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 217b299..0e1e21d 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -113,7 +113,7 @@
 /** Returns a verdict if this packet should create a new session */
 static enum pre_decrypt_verdict
 do_pre_decrypt_check(struct multi_context *m, struct tls_pre_decrypt_state *state,
-                     struct mroute_addr addr, struct link_socket *sock)
+                     struct link_socket *sock)
 {
     ASSERT(m->top.c2.tls_auth_standalone);
 
@@ -259,7 +259,7 @@
     struct tls_pre_decrypt_state state = { 0 };
     struct multi_instance *mi = NULL;
 
-    enum pre_decrypt_verdict verdict = do_pre_decrypt_check(m, &state, *real, sock);
+    enum pre_decrypt_verdict verdict = do_pre_decrypt_check(m, &state, sock);
 
     if (verdict != PRE_DECRYPT_NO_ACTION)
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
