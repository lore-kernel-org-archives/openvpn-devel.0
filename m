Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFBFC43602
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SvHBQAVmQXmvFxq3mto7giY5m9xN7B6IUURA++0PdYA=; b=Wzbins9eJf7SLuuQsH9pkO/18J
	GERprg9TMmoE+wQZhsxHZ3VTMyH6WmZRYnN58JN8/zdP1jn4Ljva5CpUGb8TFZUZG+DE22FqS+c36
	yBeNtaS2615abbWRtfQG5icblqKlMr35n4znIrEMEzsPIKpE/HR3x8NiKKZ9WL7os0yU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weBQ1-0003bc-EM;
	Mon, 29 Jun 2026 12:48:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1weBPz-0003bV-Gu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:48:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=744jOQAYI6IEOlSewyqWF3X7ipksS5+FMrXXbnARLC4=; b=ZkkxawGKKXanIH5SgiA4c8Hpl1
 FIB2jggKialUNSpgTTGWrKoM+4cyYit8ggI2OGE87ksqPxDNN/Rewb+UQgWlqwYI2ycYA6I4mrPNg
 KoiBr5ayXOlBs3b05raDI0dLPBinw5NPn8XaDGdkNeKFSsjDI2Ij2CAZMqRomdf5NmJM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=744jOQAYI6IEOlSewyqWF3X7ipksS5+FMrXXbnARLC4=; b=czk6ValBC/EC5FeY+NYDeFki3S
 dAV3rsz9elpPoqZQ+Ca0B6xrC0Y/DEbG0DAwh7MMLvmiQjOiLTAwG9IyPbfhHVXB6ox8GkhDGrTIo
 iZ8Twv2P/qXsQkx9yk7zRUKiNaTo8lluws6x6n+krFDeCnSeEths0lX0WApXzeX39WEY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weBPv-0004FE-54 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:48:52 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65TCmdPd032471
 for <openvpn-devel@lists.sourceforge.net>; Mon, 29 Jun 2026 14:48:39 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65TCmduq032470
 for openvpn-devel@lists.sourceforge.net; Mon, 29 Jun 2026 14:48:39 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 29 Jun 2026 14:48:34 +0200
Message-ID: <20260629124839.32433-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
References: <gerrit.1782556099000.Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1weBPv-0004FE-54
Subject: [Openvpn-devel] [PATCH v2] win32: fix plugin trusted-dir check
 prefix bypass
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

From: Lev Stipakov <lev@openvpn.net>

plugin_in_trusted_dir() validated the plugin path against the trusted
plugin/install directory (and the system directory fallback) using a raw
string prefix match via wcsnicmp(). When the trusted directory path does
not end in a separator (e.g. the plugin_dir registry value is set to
"C:\openvpn_plugins"), a sibling directory sharing the same prefix
("C:\openvpn_plugins_evil") also passes the check, allowing a plugin to
be loaded from outside the allow-listed directory.

Introduce win_path_in_dir() in win32-util.c which performs the prefix
match but additionally requires the match to end on a path-component
boundary, and use it for both the plugin/install directory and the
system directory checks. Add unit tests in test_misc.c.

Change-Id: Ib7f9c9ce5ed778190445cc4cfaa8f3cd5d1110bc
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1736
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1736
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 6fc3be4..209e34e 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -175,4 +175,30 @@
     return tmpdir;
 }
 
+bool
+win_path_in_dir(const WCHAR *path, const WCHAR *dir)
+{
+    size_t dir_len = wcslen(dir);
+    /* dir_len <= 1 guards the dir[dir_len - 1] access below and rejects a
+     * degenerate single-character directory (a normalized absolute path is
+     * always longer). */
+    if (dir_len <= 1 || wcsnicmp(dir, path, dir_len) != 0)
+    {
+        return false;
+    }
+
+    /* A plain prefix match is not sufficient: if dir is "C:\foo" then
+     * "C:\foo_evil\bar.dll" shares the prefix but is not inside "C:\foo".
+     * Require that the matched prefix ends on a path separator, i.e. either
+     * dir already ends with a separator or the character following the prefix
+     * in path is one. */
+    if (dir[dir_len - 1] == L'\\' || dir[dir_len - 1] == L'/')
+    {
+        return true;
+    }
+
+    WCHAR next = path[dir_len];
+    return next == L'\\' || next == L'/';
+}
+
 #endif /* _WIN32 */
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
index 6636cf3..4849ea9 100644
--- a/src/openvpn/win32-util.h
+++ b/src/openvpn/win32-util.h
@@ -42,5 +42,17 @@
 /* Find temporary directory */
 const char *win_get_tempdir(void);
 
+/**
+ * Check whether @p path resides within directory @p dir.
+ *
+ * Unlike a plain string prefix match, this requires the match to end on a
+ * path-component boundary, so that "C:\\foo_evil\\bar" is not considered to be
+ * inside "C:\\foo". Both arguments are expected to be normalized absolute
+ * paths. The comparison is case-insensitive.
+ *
+ * @return true if @p path is inside @p dir, false otherwise.
+ */
+bool win_path_in_dir(const WCHAR *path, const WCHAR *dir);
+
 #endif /* OPENVPN_WIN32_UTIL_H */
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index b2a7331..ca08ead 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1587,14 +1587,13 @@
     }
 
     /* Check if the plugin path resides within the plugin/install directory */
-    if ((wcslen(normalized_plugin_dir) > 0)
-        && (wcsnicmp(normalized_plugin_dir, plugin_path, wcslen(normalized_plugin_dir)) == 0))
+    if (win_path_in_dir(plugin_path, normalized_plugin_dir))
     {
         return true;
     }
 
     /* Fallback to the system directory */
-    return wcsnicmp(system_dir, plugin_path, wcslen(system_dir)) == 0;
+    return win_path_in_dir(plugin_path, system_dir);
 }
 
 bool
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index ccdfdee..fc9840a 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -38,6 +38,9 @@
 #include "test_common.h"
 #include "list.h"
 #include "mock_msg.h"
+#ifdef _WIN32
+#include "win32-util.h"
+#endif
 
 static void
 test_compat_lzo_string(void **state)
@@ -445,12 +448,48 @@
     mock_set_debug_level(saved_log_level);
 }
 
-const struct CMUnitTest misc_tests[] = { cmocka_unit_test(test_compat_lzo_string),
-                                         cmocka_unit_test(test_auth_fail_temp_no_flags),
-                                         cmocka_unit_test(test_auth_fail_temp_flags),
-                                         cmocka_unit_test(test_auth_fail_temp_flags_msg),
-                                         cmocka_unit_test(test_list),
-                                         cmocka_unit_test(test_atoi_variants) };
+#ifdef _WIN32
+static void
+test_win_path_in_dir(void **state)
+{
+    /* plugin/install dir without trailing separator */
+    assert_true(win_path_in_dir(L"C:\\openvpn_plugins\\foo.dll", L"C:\\openvpn_plugins"));
+
+    /* the bug being fixed: a sibling dir sharing the prefix must NOT match */
+    assert_false(win_path_in_dir(L"C:\\openvpn_plugins_evil\\foo.dll", L"C:\\openvpn_plugins"));
+
+    /* trusted dir with trailing separator */
+    assert_true(win_path_in_dir(L"C:\\openvpn_plugins\\foo.dll", L"C:\\openvpn_plugins\\"));
+    assert_false(win_path_in_dir(L"C:\\openvpn_plugins_evil\\foo.dll", L"C:\\openvpn_plugins\\"));
+
+    /* forward slash separator in the candidate path is accepted */
+    assert_true(win_path_in_dir(L"C:\\openvpn_plugins/foo.dll", L"C:\\openvpn_plugins"));
+
+    /* comparison is case-insensitive */
+    assert_true(win_path_in_dir(L"c:\\OPENVPN_PLUGINS\\foo.dll", L"C:\\openvpn_plugins"));
+
+    /* the directory itself (no trailing component) is not "in" the directory */
+    assert_false(win_path_in_dir(L"C:\\openvpn_plugins", L"C:\\openvpn_plugins"));
+
+    /* nested subdirectories are still inside */
+    assert_true(win_path_in_dir(L"C:\\openvpn_plugins\\sub\\foo.dll", L"C:\\openvpn_plugins"));
+
+    /* an empty trusted dir never matches */
+    assert_false(win_path_in_dir(L"C:\\openvpn_plugins\\foo.dll", L""));
+}
+#endif /* _WIN32 */
+
+const struct CMUnitTest misc_tests[] = {
+#ifdef _WIN32
+    cmocka_unit_test(test_win_path_in_dir),
+#endif
+    cmocka_unit_test(test_compat_lzo_string),
+    cmocka_unit_test(test_auth_fail_temp_no_flags),
+    cmocka_unit_test(test_auth_fail_temp_flags),
+    cmocka_unit_test(test_auth_fail_temp_flags_msg),
+    cmocka_unit_test(test_list),
+    cmocka_unit_test(test_atoi_variants)
+};
 
 int
 main(void)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
