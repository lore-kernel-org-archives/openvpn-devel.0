Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4003CC79FA0
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/kr8hZIeh/PY6EVNZKH6TlIJfM7OSgqpYl0ey46sce4=; b=bx2hA3HbkgYkc1EWLKss/nrE8E
	p3f3ig3YAajigVafwiRUDIzYMw2ULOLfRpHhZERgWSMh4GxMkVGlZtfZQR1s7aQkGVdTNFhdBz0oI
	7fspTh4TJ1h0N1+YtHRWmks1aVI92asFt0AO/yzZMgAE2enBmIzEmCgBFQltF1sD74CI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3aZm-0006FO-Al;
	Mon, 07 Sep 2026 14:44:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x3aZk-0006F7-Lu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 14:44:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FAe6DmkKbMr2Rhxefd5A4SDnpcibH/WwM5w1XtHLDVk=; b=UZe3e9w1NQh0wmujV8KB7IoQuT
 tULCth4TTbXievvCJBUwEk5NFGh0ertrttTXUstfPC5KiM4U1jRKJuUznbf/HUC255SgVd6nioP8G
 Risb7otuQ0QhoUdaDVBnokFnZR0BVztaZCuX+Giv4VAPMl57RaHlZoub9+O474Vs4s/c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FAe6DmkKbMr2Rhxefd5A4SDnpcibH/WwM5w1XtHLDVk=; b=lCXiOcyn2usSMMdLhxdQRvdfuv
 9NPBXoEUo5fL7tM7wfte3BVWsq2lQrV62F64kd/RxllNekGn3qoaUuG3qMnJBkJBXm1T3yCtVJ78X
 eHQY92EN/TvLyf3RmJwSCGZ7SXw/Z4jupGILDRyvhO6YL+yyuh36xFno+gbAYo7SA1zQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3aZi-0007jV-Gs for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 14:44:00 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 687Ehp5g022100
 for <openvpn-devel@lists.sourceforge.net>; Mon, 7 Sep 2026 16:43:51 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 687EhpvZ022099
 for openvpn-devel@lists.sourceforge.net; Mon, 7 Sep 2026 16:43:51 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  7 Sep 2026 16:43:44 +0200
Message-ID: <20260907144351.22085-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788431406000.I70dfdc70778458b78f80b8d0b0b786f18fe4fc76@gerrit.openvpn.net>
References: <gerrit.1788431406000.I70dfdc70778458b78f80b8d0b0b786f18fe4fc76@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x3aZi-0007jV-Gs
Subject: [Openvpn-devel] [PATCH v1] win32: stop cmd.exe from expanding
 variables in quoted arguments
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

Commit cf08504 quotes arguments that contain cmd.exe metacharacters, so a
certificate subject passed to --tls-verify cannot start a second command
when CreateProcess() runs a .bat or .cmd hook.

Quoting is not enough for %VAR% and !VAR!: cmd.exe expands those even
inside double quotes, and OpenVPN exports peer-controlled certificate
fields into the child environment. A subject that puts a quote and an
operator in one field (O=BREAK"&whoami&") and references it from another
(CN=%X509_0_O%) expands back into a quote and command operator after
wide_cmd_line() has already replaced the direct quotes, running a command
before the hook can reject the peer.

Replace % and ! in wide_cmd_line() along with the double quotes and CRLF,
so no argument can expand. This reuses two character classes that had no
users, CC_AT and CC_EQUAL, renamed to CC_PERCENT and CC_EXCLAMATION. Add
regression tests for a bare percent or bang, a closed expansion token, and
the reported subject.

This completes the CVE-2026-84256 fix for Windows batch hooks.

GitHub: OpenVPN/openvpn-private-issues#176
Reported-By: Darren Carreras
CVE: 2026-84256
Change-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4fc76
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1895
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1895
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 5ce2e39..5d00415 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -943,11 +943,11 @@
     {
         return true;
     }
-    if ((flags & CC_AT) && c == '@')
+    if ((flags & CC_PERCENT) && c == '%')
     {
         return true;
     }
-    if ((flags & CC_EQUAL) && c == '=')
+    if ((flags & CC_EXCLAMATION) && c == '!')
     {
         return true;
     }
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 4471697..0a02e94 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1660,8 +1660,8 @@
 #define CC_SINGLE_QUOTE  (1 << 21) /**< single quote */
 #define CC_DOUBLE_QUOTE  (1 << 22) /**< double quote */
 #define CC_REVERSE_QUOTE (1 << 23) /**< reverse quote */
-#define CC_AT            (1 << 24) /**< at sign */
-#define CC_EQUAL         (1 << 25) /**< equal sign */
+#define CC_PERCENT       (1 << 24) /**< percent sign */
+#define CC_EXCLAMATION   (1 << 25) /**< exclamation mark */
 #define CC_LESS_THAN     (1 << 26) /**< less than sign */
 #define CC_GREATER_THAN  (1 << 27) /**< greater than sign */
 #define CC_PIPE          (1 << 28) /**< pipe */
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 4e3819c..e2c8810 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -94,7 +94,10 @@
     {
         const char *arg = a->argv[i];
         strcpy(work, arg);
-        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, '_');
+        /* cmd.exe expands %VAR% and !VAR! even inside quotes, so a value like
+         * %X509_0_O% could turn back into a quote and start a new command.
+         * Replace those along with the double quotes and CRLF. */
+        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF | CC_PERCENT | CC_EXCLAMATION, '_');
         if (i)
         {
             buf_printf(&buf, " ");
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 5b6e26e..1fc73d8 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -271,15 +271,13 @@
         { "CN=a,b;c=d", L"script.bat 0 CN=a,b;c=d" },
         /* a space has always forced quoting */
         { "O=Ctrl, CN=y", L"script.bat 0 \"O=Ctrl, CN=y\"" },
-        /* cmd.exe operators */
+        /* cmd.exe operators that quoting neutralizes */
         { "CN=x&ver", L"script.bat 0 \"CN=x&ver\"" },
         { "CN=x|ver", L"script.bat 0 \"CN=x|ver\"" },
         { "CN=x>f", L"script.bat 0 \"CN=x>f\"" },
         { "CN=x<f", L"script.bat 0 \"CN=x<f\"" },
         { "CN=x^f", L"script.bat 0 \"CN=x^f\"" },
-        { "CN=x%f", L"script.bat 0 \"CN=x%f\"" },
         { "CN=x(f)", L"script.bat 0 \"CN=x(f)\"" },
-        { "CN=x!f", L"script.bat 0 \"CN=x!f\"" },
         /* a double quote is replaced, so quoting cannot be broken out of */
         { "CN=a\"b", L"script.bat 0 CN=a_b" },
     };
@@ -300,6 +298,49 @@
         gc_free(&gc);
     }
 }
+
+/*
+ * cmd.exe expands %VAR% and !VAR! even inside quotes, and OpenVPN puts
+ * peer-controlled data (e.g. certificate subject fields) on the command line,
+ * so these characters are replaced to stop a value from expanding back into a
+ * quote and command operator.
+ */
+static void
+wide_cmd_line__replaces_cmd_expansion(void **state)
+{
+    static const struct
+    {
+        const char *arg;
+        const WCHAR *expected;
+    } cases[] = {
+        /* a bare percent or bang is replaced */
+        { "CN=x%f", L"script.bat 0 CN=x_f" },
+        { "CN=x!f", L"script.bat 0 CN=x_f" },
+        /* a closed expansion token is replaced, so nothing expands */
+        { "CN=%X509_0_O%", L"script.bat 0 CN=_X509_0_O_" },
+        { "CN=!X509_0_O!", L"script.bat 0 CN=_X509_0_O_" },
+        /* the reported bypass: quotes in one field are already replaced, and
+         * neutralizing % stops %X509_0_O% from re-injecting them */
+        { "O=BREAK\"&whoami&\", CN=%X509_0_O%",
+          L"script.bat 0 \"O=BREAK_&whoami&_, CN=_X509_0_O_\"" },
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
 #endif /* _WIN32 */
 
 int
@@ -323,6 +364,7 @@
         cmocka_unit_test(argv_insert_head__empty_argv__head_only),
 #ifdef _WIN32
         cmocka_unit_test(wide_cmd_line__quotes_only_what_cmd_would_reinterpret),
+        cmocka_unit_test(wide_cmd_line__replaces_cmd_expansion),
 #endif
     };
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
