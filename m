Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1294F606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dLV0wFPa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CJBpOo2H;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W1XjNmoD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fR2LjIScAzdOPLTy9F1LzQXjLipt7/t2Coj0t+cAsb8=; b=dLV0wFParnsDQ6
	srIxB8GVBpa4EwbPwfwlQF89BNUsdaEy/NAWL7AMB7g9EBdhSscmPaWK1XBGu5WUQCqFErAogRu7b
	vQO57var1LSF7Qel1Q981ncetJWtrTPyFUzP4UEF1vJaKGEuF6A6P4li8ierSCA+tKQUev6kl6SMF
	klQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWw74-000000006Qt-1x9I;
	Fri, 27 Nov 2026 13:35:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWw72-000000006Ql-20FV for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:35:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PGWn0Pb8uFwYa23D9lM7Wfkao/378O6MipBJmWBabNo=; b=CJBpOo2HaZYAMLYpCBvBeWolKs
 RQ0gEUsOk4LrZvog7OyMiOFAPj0InzfUyjV4x/N1Q0wjt65xxtGsI5E5ZYqzIUbL/awiL1fygJUtE
 LKptSRFJCdxqSwudWAdOAhV8niY8n7wNDrB+d2U5jKXO5rHcj/qf+lKXXHdUMmPzrpVM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PGWn0Pb8uFwYa23D9lM7Wfkao/378O6MipBJmWBabNo=; b=W1XjNmoD/xBmWO+Zx6UcDBnP9/
 pmM5F/zZ9fiMmq5baLppRWTnkqQPusRCiLIkj2OhaktaDxRvDBc64uxPnra2SHQEViojI3y7cJ+QI
 aRz0g4K4tUOUBQyMvxrM3agfxDL4Fopac4B0mnIGY6liOW1cZQ6E4IK1yC31Hl7wWVqA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWw70-000000001ei-2JDV for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:35:40 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ARDZV2U030250
 for <openvpn-devel@lists.sourceforge.net>; Fri, 27 Nov 2026 14:35:31 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ARDZVGq030249
 for openvpn-devel@lists.sourceforge.net; Fri, 27 Nov 2026 14:35:31 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 27 Nov 2026 14:35:25 +0100
Message-ID: <20261127133530.30238-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
References: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWw70-000000001ei-2JDV
Subject: [Openvpn-devel] [PATCH v2] options: preserve --dns-updown across
 PUSH_UPDATE
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

From: Marco Baffo <marco@mandelbit.com>

Reset DNS records without clearing the local DNS up/down command
and flags when PUSH_UPDATE replaces or removes DNS options.

Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2360
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2360
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1e0b4d8..c35740d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3619,8 +3619,16 @@
 static void
 reset_dns_options(struct options *options)
 {
-    gc_free(&options->dns_options.gc);
-    CLEAR(options->dns_options);
+    struct dns_options *dns = &options->dns_options;
+    const char *updown = dns->updown;
+    enum dns_updown_flags updown_flags = dns->updown_flags;
+
+    gc_free(&dns->gc);
+    CLEAR(*dns);
+
+    /* --dns-updown is local configuration, not pushed */
+    dns->updown = updown;
+    dns->updown_flags = updown_flags;
 }
 
 static void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
