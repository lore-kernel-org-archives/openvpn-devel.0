Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077D606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SbQRv2tX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dne64Ob1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XM2mDHlx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nJWkNMrThQLbD9YObbMOSgWmvprtu/lbGpinHChcrVk=; b=SbQRv2tXAhbTKc
	w8pWrAKDtqEgRipWPdcH2elTdt4i7Y40pmxAOZQ0OMpzPeSeMY7IOt8FIWDl2meqhhu3QgylEv4So
	nn6QPV4LURpwWCH7SEF7LuovD29OtWiHHmN72+FgeRoVDMCmHD400dEZcgmXXlwJstQQr/oNPsauF
	iAw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOf1k-000000008R1-2iPg;
	Wed, 04 Nov 2026 17:44:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOf1j-000000008Qu-09sn for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xrrfwMGgjOR1sb03Ad7yqIG8JhXacrpXL2sqQnYqeBQ=; b=dne64Ob1xmuvJ101slck6WqQju
 Jo9nCFPKWeCtG5CpiK6CWiSoLetz0njOZFQIJRBnkKqKU8sF3atTthzPuXxEGwCVUnfrn05yhXjT6
 dX5iXibmXcS39p9aJTChpKuXPq9aJyhvVWAvvOwfsAS7NnGWfzOIeQr+k7RSWUhypAcE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xrrfwMGgjOR1sb03Ad7yqIG8JhXacrpXL2sqQnYqeBQ=; b=XM2mDHlxGGYgOW+fLxlkM+4mcV
 uDuCzvhRsvNjPLwni9wcN6t5eeTyFjYx2QsUOAnO2jpBB8L9wPM5htOoJj6nGQD0zZ/j6MQmwv24P
 768hj1JTO5UeBPlggZ8AbDHlw1RXu6F2GZ910e503k6j/f9Z7UtkvixQaqAyVVzeck3E=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOf1h-000000000P1-03Dv for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:43:58 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4Hho8E015285
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 18:43:50 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4HhoL7015284
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 18:43:50 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 18:43:44 +0100
Message-ID: <20261104174350.15275-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
References: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOf1h-000000000P1-03Dv
Subject: [Openvpn-devel] [PATCH v2] ssl_verify: drop the return value of
 verify_user_pass_management()
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

The function cannot fail since a4eeef17 ("Add function for common env
setting of verify user/pass calls") moved the username check out of it,
so it always returned KMDA_SUCCESS and man_def_auth could never become
KMDA_ERROR. Make it void, track only whether deferred management auth
is enabled, and drop the KMDA_* codes.

Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2118
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2118
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0cdec1e..f5af932 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1521,18 +1521,9 @@
 
 
 #ifdef ENABLE_MANAGEMENT
-/*
- * management deferred internal ssl_verify.c status codes
- */
-#define KMDA_ERROR   0
-#define KMDA_SUCCESS 1
-#define KMDA_UNDEF   2
-#define KMDA_DEF     3
-
-static int
+static void
 verify_user_pass_management(struct tls_session *session, const struct user_pass *up)
 {
-    int retval = KMDA_ERROR;
     const struct key_state *ks = &session->key[KS_PRIMARY]; /* primary key */
 
     /* set username/password in private env space */
@@ -1545,10 +1536,6 @@
     }
 
     setenv_del(session->opt->es, "password");
-
-    retval = KMDA_SUCCESS;
-
-    return retval;
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
 
@@ -1613,12 +1600,7 @@
     ASSERT(up && !up->protected);
 
 #ifdef ENABLE_MANAGEMENT
-    int man_def_auth = KMDA_UNDEF;
-
-    if (management_enable_def_auth(management))
-    {
-        man_def_auth = KMDA_DEF;
-    }
+    const bool man_def_auth = management_enable_def_auth(management);
 #endif
 
     /* enforce character class restrictions in username/password */
@@ -1706,9 +1688,9 @@
     if (!skip_auth)
     {
 #ifdef ENABLE_MANAGEMENT
-        if (man_def_auth == KMDA_DEF)
+        if (man_def_auth)
         {
-            man_def_auth = verify_user_pass_management(session, up);
+            verify_user_pass_management(session, up);
         }
 #endif
         if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
@@ -1736,11 +1718,7 @@
     bool script_ok = script_status == OPENVPN_PLUGIN_FUNC_SUCCESS
                      || script_status == OPENVPN_PLUGIN_FUNC_DEFERRED;
 
-    if (script_ok && plugin_ok && tls_lock_username(multi, up->username)
-#ifdef ENABLE_MANAGEMENT
-        && man_def_auth != KMDA_ERROR
-#endif
-    )
+    if (script_ok && plugin_ok && tls_lock_username(multi, up->username))
     {
         ks->authenticated = KS_AUTH_TRUE;
         if (plugin_status == OPENVPN_PLUGIN_FUNC_DEFERRED
@@ -1749,7 +1727,7 @@
             ks->authenticated = KS_AUTH_DEFERRED;
         }
 #ifdef ENABLE_MANAGEMENT
-        if (man_def_auth != KMDA_UNDEF)
+        if (man_def_auth)
         {
             if (skip_auth)
             {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
