Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8EC606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z/tEv1Xk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jQDWDwet;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k6Q2DO7j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tGnAVYrNI5Nfu6tUOOv+gIUm9b/srmkBxU5IMvpPEwk=; b=Z/tEv1Xk3uZksb
	FpKe4Yvt/iAixD9kWYN7n3FC4c+gxwn3mn7qJDFp2r2LCTrGclEZHw54++egBpFPCVpqa89E65sy4
	dyG/wW3fqD68Eq0xeqcR4Fs2uAn56EgiNbIMWcWvnnJuG9pTYqnXTxNDlLHLDWA9KMNXIVt4noJ8M
	xRs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRcX8-000000002rD-0QeM;
	Thu, 12 Nov 2026 21:40:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRcX6-000000002r6-3vMw for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MdR2X8xFxiO8KhYrhktQePWxkN8vp5RbiAJXb+0W+yk=; b=jQDWDwet4l/I/NWWUBWA9243qH
 qyBXOcjpY2HyeWGm55MCKegHCKqbJHTvq2QEAqAVrgQLBdQX8l0jVffPrfxNGt1yo3nF50STh3qW2
 3Pb36vAFfGCx9vyEeHuVqdJhQdLgxwA+0Lx+YoL3Fn4FFOXuxXvvZW2ZnhLe3lihWrmE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MdR2X8xFxiO8KhYrhktQePWxkN8vp5RbiAJXb+0W+yk=; b=k6Q2DO7jCQsYtJ1AbJKm05PrZm
 k3NFeF+MkKhngz6c1P8Baj4u+nG0WfTFNUFZnkWQf9mvj0p6X8UkEk+UXncnwNJFluTYXx8kAtta2
 1dEEvEMhIQ4/8ymF8915f9N+xTwLoKbhpfZg0lCIkC9ePtiUub1MduWLvn+Bt3T9NhIk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRcX4-000000005JE-3spO for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:40:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ACLeSxG013485
 for <openvpn-devel@lists.sourceforge.net>; Thu, 12 Nov 2026 22:40:28 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ACLeSfd013484
 for openvpn-devel@lists.sourceforge.net; Thu, 12 Nov 2026 22:40:28 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 12 Nov 2026 22:40:21 +0100
Message-ID: <20261112214027.13465-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRcX4-000000005JE-3spO
Subject: [Openvpn-devel] [PATCH v7] openvpnserv: reject a config file passed
 without --config
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

openvpn.exe takes a lone argument as the config file only when there
are no other arguments, but the service adds --msg-channel. Since
c139e82d openvpn.exe takes the config file as an extra parameter of
--msg-channel and ignores it. ValidateOptions() treated it as the
config file, but only ever returned FALSE for it, with an empty error
message if the path was fine.

Return an error to all users when the options don't start with an
option, and drop the lone argument special case in ValidateOptions(),
so that a lone option is checked against the white list.

Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Heiko Hund <heiko@ist.eigentlich.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2159
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2159
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@ist.eigentlich.net>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 81205d6..9de747e 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -354,6 +354,29 @@
     ReturnError(pipe, GetLastError(), func, 1, &exit_event);
 }
 
+/**
+ * Check whether the user options start with a non-option
+ *
+ * openvpn.exe takes a lone argument as the config file only when there are
+ * no other arguments, and takes non-options after the --msg-channel handle
+ * as its extra parameters.
+ *
+ * @param  cmdline  openvpn.exe command line built by the service
+ *
+ * @return BOOL to indicate if the first user argument is not an option
+ */
+static BOOL
+StartsWithNonOption(const WCHAR *cmdline)
+{
+    int argc;
+    WCHAR **argv = CommandLineToArgvW(cmdline, &argc);
+    /* "openvpn --msg-channel <handle> <arg>..." */
+    BOOL ret = argv && argc > 3 && !IsOption(argv[3]);
+
+    LocalFree(argv);
+    return ret;
+}
+
 /*
  * Validate options against a white list. Also check the config_file is
  * inside the config_dir. The white list is defined in validate.c
@@ -396,20 +419,6 @@
         goto out;
     }
 
-    /*
-     * If only one argument, it is the config file
-     */
-    if (argc == first + 1)
-    {
-        WCHAR *argv_tmp[2] = { L"--config", argv[first] };
-
-        if (!CheckOption(workdir, 2, argv_tmp, &settings))
-        {
-            swprintf(errmsg, capacity, msg1, argv[first], workdir, settings.ovpn_admin_group);
-        }
-        goto out;
-    }
-
     for (i = first; i < argc; ++i)
     {
         if (!IsOption(argv[i]))
@@ -3839,6 +3848,14 @@
     swprintf(cmdline, cmdline_size, L"openvpn --msg-channel %" PRIuPTR L" %ls",
              (uintptr_t)svc_pipe, sud.options);
 
+    if (StartsWithNonOption(cmdline))
+    {
+        ReturnError(pipe, ERROR_STARTUP_DATA,
+                    L"Options must start with an option, pass the config file with --config", 1,
+                    &exit_event);
+        goto out;
+    }
+
     /*
      * Only authorized users are allowed to use any command line options or
      * have the config file in locations other than the global config directory.
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_tests/openvpnserv/test_openvpnserv.c
index 20fb1af..7db61f7 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv.c
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv.c
@@ -301,6 +301,33 @@
     assert_merge_result(L"", L"", L"");
 }
 
+static void
+test_starts_with_non_option(void **state)
+{
+    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 foo.ovpn"));
+    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 \"my vpn.ovpn\""));
+    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 foo.ovpn --verb 3"));
+    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 foo.ovpn bar"));
+    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 \"\""));
+
+    assert_false(StartsWithNonOption(L"openvpn --msg-channel 1 "));
+    assert_false(StartsWithNonOption(L"openvpn --msg-channel 1 --persist-tun"));
+    assert_false(StartsWithNonOption(L"openvpn --msg-channel 1 --config foo.ovpn"));
+}
+
+static void
+test_validate_lone_option(void **state)
+{
+    WCHAR errmsg[512];
+
+    assert_true(ValidateOptions(NULL, L"C:\\OpenVPN\\config\\",
+                                L"openvpn --msg-channel 1 --script-security", errmsg,
+                                _countof(errmsg)));
+    assert_false(ValidateOptions(NULL, L"C:\\OpenVPN\\config\\",
+                                 L"openvpn --msg-channel 1 --persist-tun", errmsg,
+                                 _countof(errmsg)));
+}
+
 int
 wmain(void)
 {
@@ -311,6 +338,8 @@
         cmocka_unit_test(test_append_search_list),
         cmocka_unit_test(test_remove_search_list_tokens),
         cmocka_unit_test(test_merge_openvpn_environment),
+        cmocka_unit_test(test_starts_with_non_option),
+        cmocka_unit_test(test_validate_lone_option),
     };
 
     int ret = cmocka_run_group_tests_name("openvpnserv tests", tests, NULL, NULL);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
