Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B0606A325
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XeuaYEo7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=arc4jJyC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AzaeOI5e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=alxeHc+yfpFYck4E+HzEnqTNjJsZCY0V8kjJUMojp50=; b=XeuaYEo7BUM2IQ
	7e39EkKcrM99AcOg9RI3ITFY5jtzoqGlEMleDLXCMEPbMnPBtk7We3gk7M/sBK1/e0K1z3+8mlndR
	VFMo2xcSLcRu2LG54GOoMbXy2GrJtWeEHvQPH2KAEAyEz+GiAtB/MwYclbSzPx0rN5c4GN3WztJ6S
	h9U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUJbb-000000004sc-29x9;
	Fri, 20 Nov 2026 08:04:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xUJba-000000004sR-16K8 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:04:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BTramBUuvm+0/g+3ehnBB5bqg0cDdzo3MD8m7WQ0K5U=; b=arc4jJyCdIHPBz7rmQx+d6O2kD
 H1SdYR6oPKYiAjUC9WY+a4PD6YfeMRTOEQXRPj7V6SaK6rirSOacUdnp2gsdHjXcn9Dlb/RYJPGNq
 y1PoTi1cniQHvlIVqZppA/yv0Lhq51zwtuigibajrIUPYxd0TLquDLvAn1YHAtLf/AEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BTramBUuvm+0/g+3ehnBB5bqg0cDdzo3MD8m7WQ0K5U=; b=AzaeOI5eyaDiza8oQYHh8g6Sx7
 kUb08d3gUpy7pCgj+E5BppgeK6s6hxOMw9DbAquN4mu3KrsTAtOPZbmrfCSBwIudHW7Y+GgXTvsQc
 sL1ACi7B9Qm3DL9AI9YO6STuURkJXq2G8UcAkpshlPu41QMN3E4r98lEC9W6GSvfo3IE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUJbX-000000007X1-0aD8 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:04:22 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AK84CeX004415
 for <openvpn-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 09:04:12 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AK84CZf004414
 for openvpn-devel@lists.sourceforge.net; Fri, 20 Nov 2026 09:04:12 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 20 Nov 2026 09:04:04 +0100
Message-ID: <20261120080412.4368-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
References: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xUJbX-000000007X1-0aD8
Subject: [Openvpn-devel] [PATCH v3] openvpnserv: check for a leading
 non-option in the startup data
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

Check sud.options directly before doing any other work, instead of
building the openvpn.exe command line and parsing it back. This also
rejects empty options.

Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2188
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2188
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 354fe09..f0078ac 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -357,24 +357,17 @@
 /**
  * Check whether the user options start with a non-option
  *
- * openvpn.exe takes a lone argument as the config file only when there are
- * no other arguments, and takes non-options after the --msg-channel handle
- * as its extra parameters.
+ * openvpn.exe takes non-options after the --msg-channel handle the service
+ * prepends as its extra parameters, not as the config file.
  *
- * @param  cmdline  openvpn.exe command line built by the service
+ * @param  options  user options from the startup data
  *
  * @return BOOL to indicate if the first user argument is not an option
  */
 static BOOL
-StartsWithNonOption(const WCHAR *cmdline)
+StartsWithNonOption(const WCHAR *options)
 {
-    int argc;
-    WCHAR **argv = CommandLineToArgvW(cmdline, &argc);
-    /* "openvpn --msg-channel <handle> <arg>..." */
-    BOOL ret = argv && argc > 3 && !IsOption(argv[3]);
-
-    LocalFree(argv);
-    return ret;
+    return !IsOption(options + wcsspn(options, L" \t"));
 }
 
 /*
@@ -3639,6 +3632,14 @@
         goto out;
     }
 
+    if (StartsWithNonOption(sud.options))
+    {
+        ReturnError(pipe, ERROR_STARTUP_DATA,
+                    L"Options must start with an option, pass the config file with --config", 1,
+                    &exit_event);
+        goto out;
+    }
+
     if (!InitializeSecurityDescriptor(&ovpn_sd, SECURITY_DESCRIPTOR_REVISION))
     {
         ReturnLastError(pipe, L"InitializeSecurityDescriptor");
@@ -3883,14 +3884,6 @@
     swprintf(cmdline, cmdline_size, L"openvpn --msg-channel %" PRIuPTR L" %ls",
              (uintptr_t)svc_pipe, sud.options);
 
-    if (StartsWithNonOption(cmdline))
-    {
-        ReturnError(pipe, ERROR_STARTUP_DATA,
-                    L"Options must start with an option, pass the config file with --config", 1,
-                    &exit_event);
-        goto out;
-    }
-
     /*
      * Only authorized users are allowed to use any command line options or
      * have the config file in locations other than the global config directory.
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_tests/openvpnserv/test_openvpnserv.c
index 7db61f7..d07fa22 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv.c
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv.c
@@ -304,15 +304,18 @@
 static void
 test_starts_with_non_option(void **state)
 {
-    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 foo.ovpn"));
-    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 \"my vpn.ovpn\""));
-    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 foo.ovpn --verb 3"));
-    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 foo.ovpn bar"));
-    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 \"\""));
+    assert_true(StartsWithNonOption(L"foo.ovpn"));
+    assert_true(StartsWithNonOption(L"\"my vpn.ovpn\""));
+    assert_true(StartsWithNonOption(L"foo.ovpn --verb 3"));
+    assert_true(StartsWithNonOption(L"foo.ovpn bar"));
+    assert_true(StartsWithNonOption(L" \tfoo.ovpn"));
+    assert_true(StartsWithNonOption(L"\"\""));
+    assert_true(StartsWithNonOption(L""));
+    assert_true(StartsWithNonOption(L" "));
 
-    assert_false(StartsWithNonOption(L"openvpn --msg-channel 1 "));
-    assert_false(StartsWithNonOption(L"openvpn --msg-channel 1 --persist-tun"));
-    assert_false(StartsWithNonOption(L"openvpn --msg-channel 1 --config foo.ovpn"));
+    assert_false(StartsWithNonOption(L"--persist-tun"));
+    assert_false(StartsWithNonOption(L"--config foo.ovpn"));
+    assert_false(StartsWithNonOption(L" \t--config foo.ovpn"));
 }
 
 static void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
