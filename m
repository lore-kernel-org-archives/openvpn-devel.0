Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A006C624D0
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8HUBAYZ0wYr0TcSa0SdVkqqM/8TLlIWW6RFPRNODNk=; b=S0ycKSUoOx+KPPFqmJJ+RXI/NG
	PtmU34sBGUaima8m0KHNZJGccO01odfomD7mZCNewmP+9sQMRLQhPCFssTAbag7AFyaOdwGCNAv/z
	6irqIBvP5yQI93ab2tpt3WmWMXkMxRwIjiTFMQxAN/fDjTAiGozFP2DiUiYnhgh5zsSA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1jrU-0007Hq-AM;
	Wed, 02 Sep 2026 12:14:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x1jrS-0007Hj-V6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 12:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mZPcupRE4uZbgjAg0AoHORZ0/TPeorAKSySZ3QD2gL8=; b=MYCmn3IWP6oW/cnk5AKbyPD4Cm
 MT6i9gq9grKphyXNqcxwTxQx1S7HkmnboAUEgPy2cDAAzv0iKSophHJqvpYPiq3Br9FpSiX3kQwtf
 oIm/SYOf0X2vMcnIjUtoGZdmDiLK8yI6ldNh9ta3NUShjrgwlf/tkLBCVmASDiAv1D1I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mZPcupRE4uZbgjAg0AoHORZ0/TPeorAKSySZ3QD2gL8=; b=DfmrlAjUbCl7K+gMFnf1LOizpv
 b4O+3N434Dtrs+7JltVNv78OZAGOqeKNRrmuxcXRwVE7q4/8qDhtxQaCQYu2GgbhdDSqGJefQzOh9
 0U3j8vN2qA7T0zpcUkuR4llVLwcABkXXMAgtMWEjh/Gy0OcEgeXNyE2tU0JRSYjwKADo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1jrO-0003GR-Ps for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 12:14:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 682CESen007095
 for <openvpn-devel@lists.sourceforge.net>; Wed, 2 Sep 2026 14:14:28 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 682CESWX007094
 for openvpn-devel@lists.sourceforge.net; Wed, 2 Sep 2026 14:14:28 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  2 Sep 2026 14:14:22 +0200
Message-ID: <20260902121427.7079-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788295708000.Iba66235cbad52692da542abd47e9f51810b0ed66@gerrit.openvpn.net>
References: <gerrit.1788295708000.Iba66235cbad52692da542abd47e9f51810b0ed66@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x1jrO-0003GR-Ps
Subject: [Openvpn-devel] [PATCH v1] win32: unit-test the CreateProcess()
 command line quoting
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

Cover which argument shapes wide_cmd_line() quotes: plain arguments and
the batch delimiters , ; = stay bare, a space or a cmd.exe metacharacter
forces quotes, and an embedded double quote is replaced so quoting cannot
be broken out of. The first two cases pin the compatibility guarantee -
they are what a later "just quote everything" simplification would break.

Move wide_cmd_line() to win32-util.c next to wide_string(), which it
calls. The unit tests already link that file, so nothing else needs to
change to reach it.

Change-Id: Iba66235cbad52692da542abd47e9f51810b0ed66
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Heiko Hund <heiko@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1892
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1892
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@openvpn.net>

        
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 209e34e..4e3819c 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -45,6 +45,73 @@
     return ucs16;
 }
 
+/* special to cmd.exe, which CreateProcess() uses to run .bat/.cmd (VU#123335) */
+#define CMD_QUOTE_TRIGGERS " &|<>^%()!"
+
+static bool
+argv_element_needs_quotes(const char *str)
+{
+    for (const char *c = str; *c != '\0'; ++c)
+    {
+        if (strchr(CMD_QUOTE_TRIGGERS, *c) != NULL)
+        {
+            return true;
+        }
+    }
+    return false;
+}
+
+WCHAR *
+wide_cmd_line(const struct argv *a, struct gc_arena *gc)
+{
+    size_t nchars = 1;
+    size_t maxlen = 0;
+    size_t i;
+    struct buffer buf;
+    char *work = NULL;
+
+    if (!a)
+    {
+        return NULL;
+    }
+
+    for (i = 0; i < a->argc; ++i)
+    {
+        const char *arg = a->argv[i];
+        const size_t len = strlen(arg);
+        nchars += len + 3;
+        if (len > maxlen)
+        {
+            maxlen = len;
+        }
+    }
+
+    work = gc_malloc(maxlen + 1, false, gc);
+    check_malloc_return(work);
+    buf = alloc_buf_gc(nchars, gc);
+
+    for (i = 0; i < a->argc; ++i)
+    {
+        const char *arg = a->argv[i];
+        strcpy(work, arg);
+        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, '_');
+        if (i)
+        {
+            buf_printf(&buf, " ");
+        }
+        if (argv_element_needs_quotes(work))
+        {
+            buf_printf(&buf, "\"%s\"", work);
+        }
+        else
+        {
+            buf_printf(&buf, "%s", work);
+        }
+    }
+
+    return wide_string(BSTR(&buf), gc);
+}
+
 char *
 utf16to8(const wchar_t *utf16, struct gc_arena *gc)
 {
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
index fb83762..c2ad64b 100644
--- a/src/openvpn/win32-util.h
+++ b/src/openvpn/win32-util.h
@@ -24,11 +24,15 @@
 #ifndef OPENVPN_WIN32_UTIL_H
 #define OPENVPN_WIN32_UTIL_H
 
+#include "argv.h"
 #include "buffer.h"
 
 /* Convert a string from UTF-8 to UCS-2 */
 WCHAR *wide_string(const char *utf8, struct gc_arena *gc);
 
+/* Build a CreateProcess() command line from argv */
+WCHAR *wide_cmd_line(const struct argv *a, struct gc_arena *gc);
+
 /* Convert a string from UTF-16 to UTF-8 */
 char *utf16to8(const wchar_t *utf16, struct gc_arena *gc);
 
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index d527160..80ec7e8 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -936,73 +936,6 @@
     }
 }
 
-/* special to cmd.exe, which CreateProcess() uses to run .bat/.cmd (VU#123335) */
-#define CMD_QUOTE_TRIGGERS " &|<>^%()!"
-
-static bool
-argv_element_needs_quotes(const char *str)
-{
-    for (const char *c = str; *c != '\0'; ++c)
-    {
-        if (strchr(CMD_QUOTE_TRIGGERS, *c) != NULL)
-        {
-            return true;
-        }
-    }
-    return false;
-}
-
-static WCHAR *
-wide_cmd_line(const struct argv *a, struct gc_arena *gc)
-{
-    size_t nchars = 1;
-    size_t maxlen = 0;
-    size_t i;
-    struct buffer buf;
-    char *work = NULL;
-
-    if (!a)
-    {
-        return NULL;
-    }
-
-    for (i = 0; i < a->argc; ++i)
-    {
-        const char *arg = a->argv[i];
-        const size_t len = strlen(arg);
-        nchars += len + 3;
-        if (len > maxlen)
-        {
-            maxlen = len;
-        }
-    }
-
-    work = gc_malloc(maxlen + 1, false, gc);
-    check_malloc_return(work);
-    buf = alloc_buf_gc(nchars, gc);
-
-    for (i = 0; i < a->argc; ++i)
-    {
-        const char *arg = a->argv[i];
-        strcpy(work, arg);
-        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, '_');
-        if (i)
-        {
-            buf_printf(&buf, " ");
-        }
-        if (argv_element_needs_quotes(work))
-        {
-            buf_printf(&buf, "\"%s\"", work);
-        }
-        else
-        {
-            buf_printf(&buf, "%s", work);
-        }
-    }
-
-    return wide_string(BSTR(&buf), gc);
-}
-
 /*
  * Attempt to simulate fork/execve on Windows
  */
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index b1e3261..5b6e26e 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -14,6 +14,10 @@
 #include "buffer.h"
 #include "test_common.h"
 
+#ifdef _WIN32
+#include "win32-util.h"
+#endif
+
 /* Defines for use in the tests and the mock parse_line() */
 #define PATH1      "/s p a c e"
 #define PATH2      "/foo bar/baz"
@@ -248,6 +252,56 @@
     argv_free(&a);
 }
 
+#ifdef _WIN32
+/*
+ * An argument is quoted if and only if it holds a space or a character that
+ * cmd.exe would act on when CreateProcess() runs a .bat/.cmd target.
+ */
+static void
+wide_cmd_line__quotes_only_what_cmd_would_reinterpret(void **state)
+{
+    static const struct
+    {
+        const char *arg;
+        const WCHAR *expected;
+    } cases[] = {
+        /* nothing special - must stay unquoted, or existing scripts break */
+        { "CN=user1", L"script.bat 0 CN=user1" },
+        /* the batch delimiters are deliberately not triggers */
+        { "CN=a,b;c=d", L"script.bat 0 CN=a,b;c=d" },
+        /* a space has always forced quoting */
+        { "O=Ctrl, CN=y", L"script.bat 0 \"O=Ctrl, CN=y\"" },
+        /* cmd.exe operators */
+        { "CN=x&ver", L"script.bat 0 \"CN=x&ver\"" },
+        { "CN=x|ver", L"script.bat 0 \"CN=x|ver\"" },
+        { "CN=x>f", L"script.bat 0 \"CN=x>f\"" },
+        { "CN=x<f", L"script.bat 0 \"CN=x<f\"" },
+        { "CN=x^f", L"script.bat 0 \"CN=x^f\"" },
+        { "CN=x%f", L"script.bat 0 \"CN=x%f\"" },
+        { "CN=x(f)", L"script.bat 0 \"CN=x(f)\"" },
+        { "CN=x!f", L"script.bat 0 \"CN=x!f\"" },
+        /* a double quote is replaced, so quoting cannot be broken out of */
+        { "CN=a\"b", L"script.bat 0 CN=a_b" },
+    };
+
+    for (size_t i = 0; i < SIZE(cases); i++)
+    {
+        struct gc_arena gc = gc_new();
+        struct argv a = argv_new();
+
+        argv_printf(&a, "%s %d %s", "script.bat", 0, cases[i].arg);
+        assert_int_equal(a.argc, 3);
+
+        WCHAR *cmd_line = wide_cmd_line(&a, &gc);
+        assert_non_null(cmd_line);
+        assert_int_equal(wcscmp(cmd_line, cases[i].expected), 0);
+
+        argv_free(&a);
+        gc_free(&gc);
+    }
+}
+#endif /* _WIN32 */
+
 int
 main(void)
 {
@@ -267,6 +321,9 @@
         cmocka_unit_test(argv_str__multiple_argv__correct_output),
         cmocka_unit_test(argv_insert_head__non_empty_argv__head_added),
         cmocka_unit_test(argv_insert_head__empty_argv__head_only),
+#ifdef _WIN32
+        cmocka_unit_test(wide_cmd_line__quotes_only_what_cmd_would_reinterpret),
+#endif
     };
 
     return cmocka_run_group_tests_name("argv", tests, NULL, NULL);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
