Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE76606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=O06zFv7f;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NLmK1G6i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a7QmdAlr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QIkJ3BMV7MFzUn2IdkJkxzHNglJIuSUplrTSt1hgDR4=; b=O06zFv7fcmYTtA
	zi8AyMX8KBE45PYuXb3fM4BQg7LKq4YfOv9EnFVEwsSQlXo/YodQ1z0rkdmw9MrprDFD0ZBY/Raa3
	uBvOSS929zFiQZlPOyiAfRfrKg08CRiRicK3W6DNnbAMcgvA8CkRmpiPkCFhS5Ez4gjsfwP6qQxB8
	xrE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU9Zs-000000006B7-36c2;
	Thu, 19 Nov 2026 21:21:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xU9Zp-000000006Ax-1aFi for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:21:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S5t1oNR4o5fN+WBiYXHolx43yHAmyPHQMP74PRg35FE=; b=NLmK1G6ij5jJgrAPy9rYK11nMD
 QEvzZ5oZO7P2/citK2LtZsnJ8t883L6qKNOu6mcilwoOmuHeEWfhpFi6X8/D1OQEHWIXmIFsuMm8Z
 DfRZt2PWTCg0gm5EqkA30HpJLdncJ/KVj5/NyqdcvdtpTPLsn5d5rKTFtbKl1rylk+9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S5t1oNR4o5fN+WBiYXHolx43yHAmyPHQMP74PRg35FE=; b=a7QmdAlrLSIhVA1qCzZGr8yEgi
 nkJGNfIv/KNL0ngrQiMdTJMqjOXkBrpQWHeASephrbEccIk4ty5KUpJVqxvgKc72lC9LPmYRkCEm3
 FVN+jvYF2gIa3PFqAdt62V53iAyJI2Xvkmry4GnwGiUurBmFnt89Q8FeltVy3jU4yP2I=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xU9Zn-000000004Mz-1RUm for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:21:53 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AJLLhjJ005430
 for <openvpn-devel@lists.sourceforge.net>; Thu, 19 Nov 2026 22:21:43 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AJLLhGn005429
 for openvpn-devel@lists.sourceforge.net; Thu, 19 Nov 2026 22:21:43 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 19 Nov 2026 22:21:36 +0100
Message-ID: <20261119212143.5413-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794830847000.Ifbd6badab31a48653fa0bca7f086db058f83f891@gerrit.openvpn.net>
References: <gerrit.1794830847000.Ifbd6badab31a48653fa0bca7f086db058f83f891@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xU9Zn-000000004Mz-1RUm
Subject: [Openvpn-devel] [PATCH v3] ssl_verify: remove script temp files on
 all exit paths
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

The file holding the client's challenge response was never deleted,
although the manual says it is removed after the script returns. The
--auth-user-pass-verify via-file credentials file was kept when the
deferred auth control files could not be created. Unlink both on every
exit path.

Change-Id: Ifbd6badab31a48653fa0bca7f086db058f83f891
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2191
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2191
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 8641d15..75cda97 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1372,7 +1372,7 @@
             "could not create deferred auth control file",
             __func__);
         retval = OPENVPN_PLUGIN_FUNC_ERROR;
-        goto error;
+        goto done;
     }
 
     /* call command */
@@ -1415,7 +1415,6 @@
         platform_unlink(tmp_file);
     }
 
-error:
     if (!session->opt->auth_user_pass_verify_script_via_file)
     {
         setenv_del(session->opt->es, "password");
@@ -1487,6 +1486,10 @@
         tls_deauthenticate(multi);
     }
 done:
+    if (tmp_file)
+    {
+        platform_unlink(tmp_file);
+    }
     argv_free(&argv);
     gc_free(&gc);
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
