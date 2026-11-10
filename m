Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5E60A2615
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Elaf4EV+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hLia+/WG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AzBV5s+t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=E/Vn+SjiOHXCd0RuvzPhpVOn9ohT8LhC/O+br4lhA1k=; b=Elaf4EV+eVOrWA
	uv+Kf5GKhQ9nTiikNBtu7NawvAx/wjGCf9DE4g/buuPt49kx4FG/RxCc5r/7B/hMEhZz2YU3K8o9J
	qGtTUIT7wL5eNupkcnTAWOKnSOAX/utek+60rlEkxy3tbqymZ8/h7C/tgAWC5I8dEljtr/s8hUx6d
	+2U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQnKx-000000004bh-2Zpf;
	Tue, 10 Nov 2026 15:00:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQnKw-000000004bR-0I7w for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 15:00:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pf6zI1TwFz7sFfjmfWRJmysjY6zgWoelfXjNWV2SfH0=; b=hLia+/WGByOwyPzBTC0bU88JuF
 HH3zgRopcECkrt9SOTYnDmaosn9D0ZmCgc9VKBIlgc7gST2a1WixCM0XG2gXz9BaiLWNLy5KsAmJ2
 LEnY4qZUWkowCIL1VDB5wFhP7K3rI6XsE6Qe00QAVTzI81xISpO+zE4IoIRtqwSd7k5k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pf6zI1TwFz7sFfjmfWRJmysjY6zgWoelfXjNWV2SfH0=; b=AzBV5s+tOYtnE5CJBh/lRAvT6p
 BXrsMYCvUgqphdjlutneqLOlEWeKvPTlMm20ogDbcxi8UZXPWrADWJnIwXDte+/7QKUPLawUb7rA+
 qcuR9/qpCUzeR8DLfG1P7iIl6Vwj1iJmVxCZLUyiB3FWEtteUrz95RNyG8B4U8Ts9ZFE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQnKs-000000000wN-2jLu for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 15:00:38 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AAF0RN8017757
 for <openvpn-devel@lists.sourceforge.net>; Tue, 10 Nov 2026 16:00:27 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AAF0RJI017755
 for openvpn-devel@lists.sourceforge.net; Tue, 10 Nov 2026 16:00:27 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 16:00:22 +0100
Message-ID: <20261110150027.17743-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794321442000.I1c87faefd3adc2d95b5318437d097c3970a120d3@gerrit.openvpn.net>
References: <gerrit.1794321442000.I1c87faefd3adc2d95b5318437d097c3970a120d3@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQnKs-000000000wN-2jLu
Subject: [Openvpn-devel] [PATCH v1] console: Switch response_len to size_t
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

From: Frank Lichtenheld <frank@lichtenheld.com>

We need some casts either way since the system
APIs are just too different. But overall it feels
cleaner when using size_t.

Change-Id: I1c87faefd3adc2d95b5318437d097c3970a120d3
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2168
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2168
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index a4e2809..05c4e30 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -576,9 +576,9 @@
  * like buf_null_terminate, but operate on strings
  */
 void
-string_null_terminate(char *str, int len, int capacity)
+string_null_terminate(char *str, size_t len, size_t capacity)
 {
-    ASSERT(len >= 0 && len <= capacity && capacity > 0);
+    ASSERT(len <= capacity && capacity > 0);
     if (len < capacity)
     {
         *(str + len) = '\0';
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index ae6dcb7..541f0bd 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -872,7 +872,7 @@
  * @param capacity  Total size of the character buffer in bytes.
  */
 #ifdef _WIN32
-void string_null_terminate(char *str, int len, int capacity);
+void string_null_terminate(char *str, size_t len, size_t capacity);
 #endif
 /**@}*/
 /* End of string utility functions */
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 78f445b..358b9ae 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -53,7 +53,7 @@
 
 
 void
-query_user_add(char *prompt, char *resp, int resp_len, bool echo)
+query_user_add(char *prompt, char *resp, size_t resp_len, bool echo)
 {
     int i;
 
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 89550ce..94b1032 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -32,10 +32,10 @@
  */
 struct _query_user
 {
-    char *prompt;     /**< Prompt to present to the user */
-    char *response;   /**< The user's response */
-    int response_len; /**< Length the of the user response */
-    bool echo;        /**< True: The user should see what is being typed, otherwise mask it */
+    char *prompt;        /**< Prompt to present to the user */
+    char *response;      /**< The user's response */
+    size_t response_len; /**< Length the of the user response */
+    bool echo;           /**< True: The user should see what is being typed, otherwise mask it */
 };
 
 #define QUERY_USER_NUMSLOTS 10
@@ -57,7 +57,7 @@
  * @param echo       Should the user input be echoed to the user?  If False, input will be masked
  *
  */
-void query_user_add(char *prompt, char *resp, int resp_len, bool echo);
+void query_user_add(char *prompt, char *resp, size_t resp_len, bool echo);
 
 
 /**
@@ -115,7 +115,7 @@
  *
  */
 static inline bool
-query_user_SINGLE(char *prompt, char *resp, int resp_len, bool echo)
+query_user_SINGLE(char *prompt, char *resp, size_t resp_len, bool echo)
 {
     query_user_clear();
     query_user_add(prompt, resp, resp_len, echo);
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 0353ade..8206d3d 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -41,11 +41,6 @@
 #include <termios.h>
 #endif
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 #ifdef _WIN32
 
 #include "win32.h"
@@ -62,11 +57,11 @@
  *         exit event is signaled.
  */
 static bool
-get_console_input_win32(const char *prompt, const bool echo, char *input, const int capacity)
+get_console_input_win32(const char *prompt, const bool echo, char *input, const size_t capacity)
 {
     ASSERT(prompt);
     ASSERT(input);
-    ASSERT(capacity > 0);
+    ASSERT(capacity > 0 && capacity < INT_MAX);
 
     input[0] = '\0';
 
@@ -110,16 +105,16 @@
             return false;
         }
 
-        status = ReadConsoleW(in, winput, capacity, &len, NULL);
-        WideCharToMultiByte(CP_UTF8, 0, winput, len, input, capacity, NULL, NULL);
+        status = ReadConsoleW(in, winput, (DWORD)capacity, &len, NULL);
+        WideCharToMultiByte(CP_UTF8, 0, winput, (int)len, input, (int)capacity, NULL, NULL);
         free(winput);
     }
     else
     {
-        status = ReadFile(in, input, capacity, &len, NULL);
+        status = ReadFile(in, input, (DWORD)capacity, &len, NULL);
     }
 
-    string_null_terminate(input, (int)len, capacity);
+    string_null_terminate(input, len, capacity);
     chomp(input);
 
     if (!echo)
@@ -191,11 +186,11 @@
  *  @returns Returns True if user input was gathered
  */
 static bool
-get_console_input(const char *prompt, const bool echo, char *input, const int capacity)
+get_console_input(const char *prompt, const bool echo, char *input, const size_t capacity)
 {
     ASSERT(prompt);
     ASSERT(input);
-    ASSERT(capacity > 0);
+    ASSERT(capacity > 0 && capacity <= INT_MAX);
     input[0] = '\0';
 
 #ifdef _WIN32
@@ -238,7 +233,7 @@
         restore_tty = (tcsetattr(fileno(fp), TCSAFLUSH, &tty_tmp) == 0);
     }
 
-    if (fgets(input, capacity, fp) != NULL)
+    if (fgets(input, (int)capacity, fp) != NULL)
     {
         chomp(input);
         ret = true;
@@ -294,7 +289,3 @@
 
     return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index 8fc7f72..f0ca7fa 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -53,13 +53,8 @@
     return (sd_booted() > 0) && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) == 0);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static bool
-get_console_input_systemd(const char *prompt, const bool echo, char *input, const int capacity)
+get_console_input_systemd(const char *prompt, const bool echo, char *input, const size_t capacity)
 {
     int std_out;
     bool ret = false;
@@ -91,10 +86,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  *  Systemd aware implementation of query_user_exec().  If systemd is not running
  *  it will fall back to use query_user_exec_builtin() instead.
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index 5bc1d2a..54b3617 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -47,11 +47,6 @@
 }
 #endif
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 bool
 query_user_exec_builtin(void)
 {
@@ -65,10 +60,6 @@
     return mock();
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 management_auth_failure(const struct management *man, const char *type, const char *reason)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
