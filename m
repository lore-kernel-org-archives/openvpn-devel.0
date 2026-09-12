Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB964C88E53
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 20:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HvTE4iMi3+urjNkLySuy1aJeeWATFEcTjghrh/1mNLk=; b=cLU8FkfTEB+iJEQAfVr6QLWRCO
	kVWHVicKWHHL5OYcGB/FxjJSB/X+BHtdyMb2EWlLjUJVu8hivvBeQijunkyxp4x2HgzawJU+UVfLD
	P+N1R65Y+NQTiv0/E5xWi22njaLR+v4UeHUsRznR7VjbluQz2cFmJCTtOyMLpK0ZSFdA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5U13-0002WB-Qs;
	Sat, 12 Sep 2026 20:07:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x5U11-0002W2-FD
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 20:07:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PHtH1ectGb9265RtYTzsmdhWtbAQaIhDlrxRqgKv7PQ=; b=FIJL4BVOu1JtLgJRJq/jrUKTDB
 aTLJ8hEOGsUETgWw6XOcxWv+YwbtRT94icC1KKW0ZJXr0kU1mr0Xftu2Su7r8JOyk+XfnTvrxJWNp
 va4aQT4XPJZ8KUaf+4c4nX0UFD7ykca0UU/saTBPsyBvzyD3ZK0g67JYoAa5SPYM+GFE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PHtH1ectGb9265RtYTzsmdhWtbAQaIhDlrxRqgKv7PQ=; b=k5iaPcgpmQMPVWFSSTVozCyl+1
 nGQTbhLiH/5ucSzZsl/vRi04m44zLDbPlPhzmbs74dvTGdxE6i7zUagHAT8kwD+XWrrFLwmWvqr+p
 QHs8rtMa6aN/syeWZPhJR8BhfSclmkWLnS8IjYHIN+0Hhb1JHHgcsz6U7lX3Z1e3fDCQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5U0w-00038c-Mn for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 20:07:56 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68CK7lCF026726
 for <openvpn-devel@lists.sourceforge.net>; Sat, 12 Sep 2026 22:07:47 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68CK7lrU026725
 for openvpn-devel@lists.sourceforge.net; Sat, 12 Sep 2026 22:07:47 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 12 Sep 2026 22:07:41 +0200
Message-ID: <20260912200747.26711-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x5U0w-00038c-Mn
Subject: [Openvpn-devel] [PATCH v21] Remove various useless assignments
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

From: Frank Lichtenheld <frank@lichtenheld.com>

The values assigned by these are never actually used
for something.

Identified by cppcheck.

Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1617
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1617
This mail reflects revision 21 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index e1ffe37..299d7a3 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -5,9 +5,6 @@
 constParameterPointer
 invalidPrintfArgType_sint
 invalidPrintfArgType_uint
-redundantAssignment
-redundantInitialization
-unreadVariable
 unusedFunction
 usleepCalled
 variableScope
@@ -74,7 +71,7 @@
 # IGN: strlen(NULL) is not nice code, but seems to work
 nullPointerRedundantCheck:src/openvpn/init.c:301
 # FP: cppcheck doesn't understand ZeroMemory
-redundantAssignment:src/openvpnserv/interactive.c:203
+redundantAssignment:src/openvpnserv/interactive.c:204
 # IGN: We reuse the same variable name due to macro usage
 shadowVariable:src/openvpn/options.c:1948
 shadowVariable:src/openvpn/options.c:1966
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 2a9f3b6..9c8d72a 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -192,7 +192,6 @@
 static bool
 get_console_input(const char *prompt, const bool echo, char *input, const int capacity)
 {
-    bool ret = false;
     ASSERT(prompt);
     ASSERT(input);
     ASSERT(capacity > 0);
@@ -200,8 +199,11 @@
 
 #if defined(_WIN32)
     return get_console_input_win32(prompt, echo, input, capacity);
-#elif defined(HAVE_TERMIOS_H)
+#elif !defined(HAVE_TERMIOS_H)
+    msg(M_FATAL, "Sorry, but I can't get console input on this OS (%s)", prompt);
+#else
     bool restore_tty = false;
+    bool ret = false;
     struct termios tty_tmp, tty_save;
 
     /* did we --daemon'ize before asking for passwords?
@@ -258,10 +260,8 @@
     }
 
     close_tty(fp);
-#else  /* if defined(_WIN32) */
-    msg(M_FATAL, "Sorry, but I can't get console input on this OS (%s)", prompt);
-#endif /* if defined(_WIN32) */
     return ret;
+#endif /* if defined(_WIN32) */
 }
 
 /**
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 8bbc566..e5ad31a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1204,8 +1204,6 @@
     struct buffer work = alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer encrypt_workspace = alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer decrypt_workspace = alloc_buf_gc(BUF_SIZE(frame), &gc);
-    struct buffer buf = clear_buf();
-    void *buf_p;
 
     /* init work */
     ASSERT(buf_init(&work, frame->buf.headroom));
@@ -1242,8 +1240,8 @@
         prng_bytes(BPTR(&src), BLEN(&src));
 
         /* copy source to input buf */
-        buf = work;
-        buf_p = buf_write_alloc(&buf, BLENZ(&src));
+        struct buffer buf = work;
+        void *buf_p = buf_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
         memcpy(buf_p, BPTR(&src), BLENZ(&src));
 
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 45826a2..a887fc7 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -408,8 +408,8 @@
 openvpn_errno_maybe_crt(bool *crt_error)
 {
     int err = 0;
-    *crt_error = false;
 #ifdef _WIN32
+    *crt_error = false;
     err = GetLastError();
     if (err == ERROR_SUCCESS)
     {
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index ad43d40..83cd113 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1746,7 +1746,6 @@
 process_outgoing_link(struct context *c, struct link_socket *sock)
 {
     struct gc_arena gc = gc_new();
-    int error_code = 0;
 
     if (c->c2.to_link.len > 0 && c->c2.to_link.len <= c->c2.frame.buf.payload_size)
     {
@@ -1821,7 +1820,7 @@
         }
 
         /* Check return status */
-        error_code = openvpn_errno();
+        int error_code = openvpn_errno();
         check_status(size, "write", sock, NULL);
 
         if (size > 0)
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index c301687..d57339d 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -916,10 +916,9 @@
 static void
 man_remote_entry_count(struct management *man)
 {
-    unsigned count = 0;
     if (man->persist.callback.remote_entry_count)
     {
-        count = (*man->persist.callback.remote_entry_count)(man->persist.callback.arg);
+        unsigned int count = (*man->persist.callback.remote_entry_count)(man->persist.callback.arg);
         msg(M_CLIENT, "%u", count);
         msg(M_CLIENT, "END");
     }
@@ -3742,7 +3741,6 @@
     struct gc_arena gc = gc_new();
     int ret = 0;
     volatile int signal_received = 0;
-    struct buffer alert_msg = clear_buf();
     const bool standalone_disabled_save = man->persist.standalone_disabled;
     struct man_connection *mc = &man->connection;
 
@@ -3754,6 +3752,7 @@
 
         *state = EKS_SOLICIT;
 
+        struct buffer alert_msg;
         if (b64_data)
         {
             alert_msg = alloc_buf_gc(strlen(b64_data) + strlen(prompt) + 3, &gc);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 25a3746..15f2fcd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4157,8 +4157,7 @@
 bool
 key_is_external(const struct options *options)
 {
-    bool ret = false;
-    ret = ret || (options->management_flags & MF_EXTERNAL_KEY);
+    bool ret = options->management_flags & MF_EXTERNAL_KEY;
 #ifdef ENABLE_PKCS11
     ret = ret || (options->pkcs11_providers[0] != NULL);
 #endif
@@ -5697,7 +5696,6 @@
             if (streq(p[1], "FORWARD_COMPATIBLE") && p[2] && streq(p[2], "1"))
             {
                 options->forward_compatible = true;
-                msglevel_fc = msglevel_forward_compatible(options, msglevel);
             }
             setenv_str(es, p[1], p[2] ? p[2] : "");
         }
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 8b06fd0..d7dee97 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -80,6 +80,9 @@
 static msglvl_t
 _pkcs11_msg_pkcs112openvpn(const unsigned flags)
 {
+#ifdef ENABLE_PKCS11_FORCE_DEBUG
+    return M_INFO;
+#else
     msglvl_t openvpn_flags;
 
     switch (flags)
@@ -109,16 +112,16 @@
             break;
     }
 
-#if defined(ENABLE_PKCS11_FORCE_DEBUG)
-    openvpn_flags = M_INFO;
-#endif
-
     return openvpn_flags;
+#endif
 }
 
 static unsigned
 _pkcs11_msg_openvpn2pkcs11(const msglvl_t flags)
 {
+#ifdef ENABLE_PKCS11_FORCE_DEBUG
+    return PKCS11H_LOG_DEBUG2;
+#else
     unsigned pkcs11_flags;
 
     if ((flags & D_PKCS11_DEBUG) != 0)
@@ -146,11 +149,8 @@
         pkcs11_flags = PKCS11H_LOG_ERROR;
     }
 
-#if defined(ENABLE_PKCS11_FORCE_DEBUG)
-    pkcs11_flags = PKCS11H_LOG_DEBUG2;
-#endif
-
     return pkcs11_flags;
+#endif
 }
 
 static void
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index b6c1624..69c5a50 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -384,7 +384,6 @@
     if (certificate != NULL)
     {
         pkcs11h_certificate_freeCertificate(certificate);
-        certificate = NULL;
     }
 
     /*
@@ -400,7 +399,6 @@
     if (openssl_session != NULL)
     {
         pkcs11h_openssl_freeSession(openssl_session);
-        openssl_session = NULL;
     }
     return ret;
 #endif                                                          /* ifdef HAVE_XKEY_PROVIDER */
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index fcc5411..0213041 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -99,7 +99,6 @@
     }
 
     char *str = gc_strdup(s, gc);
-    size_t i = 0;
 
     while (*str)
     {
@@ -112,11 +111,11 @@
                 /* if no commas were found go to fail, do not send any message */
                 return false;
             }
+            /* copy from current position to (ci - 1) */
             str[ci] = '\0';
-            /* copy from i to (ci -1) */
             struct buffer tmp = forge_msg(str, ",push-continuation 2", gc);
             buffer_list_push(msgs, BSTR(&tmp));
-            i = ci + 1;
+            str += ci + 1;
         }
         else
         {
@@ -130,9 +129,8 @@
                 struct buffer tmp = forge_msg(str, NULL, gc);
                 buffer_list_push(msgs, BSTR(&tmp));
             }
-            i = strlen(str);
+            break;
         }
-        str = &str[i];
     }
     return true;
 }
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7f39268..73871b2 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -753,7 +753,7 @@
      */
     socklen_t remote_len_af = af_addr_size(act->dest.addr.sa.sa_family);
     socklen_t remote_len = sizeof(act->dest.addr);
-    socket_descriptor_t new_sd = SOCKET_UNDEFINED;
+    socket_descriptor_t new_sd;
 
     CLEAR(*act);
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0b01634..7cfe9f4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2283,13 +2283,13 @@
     }
 
     int typeid = EVP_PKEY_id(pkey);
+
+#ifndef OPENSSL_NO_EC
 #if OPENSSL_VERSION_NUMBER < 0x30000000L
     bool is_ec = typeid == EVP_PKEY_EC;
 #else
     bool is_ec = EVP_PKEY_is_a(pkey, "EC");
 #endif
-
-#ifndef OPENSSL_NO_EC
     char groupname[64];
     if (is_ec)
     {
@@ -2593,15 +2593,13 @@
            "builtin EC curves. It does not list additional curves nor X448 or X25519\n");
 #ifndef OPENSSL_NO_EC
     EC_builtin_curve *curves = NULL;
-    size_t crv_len = 0;
-    size_t n = 0;
 
-    crv_len = EC_get_builtin_curves(NULL, 0);
+    size_t crv_len = EC_get_builtin_curves(NULL, 0);
     ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);
     if (EC_get_builtin_curves(curves, crv_len))
     {
         printf("\nAvailable Elliptic curves/groups:\n");
-        for (n = 0; n < crv_len; n++)
+        for (size_t n = 0; n < crv_len; n++)
         {
             const char *sname;
             sname = OBJ_nid2sn(curves[n].nid);
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 94e79d5e..618772d 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1340,9 +1340,6 @@
     is_wow64_process2_t is_wow64_process2 =
         (is_wow64_process2_t)GetProcAddress(GetModuleHandle("Kernel32.dll"), "IsWow64Process2");
 
-    USHORT process_machine = 0;
-    USHORT native_machine = 0;
-
 #ifdef _ARM64_
     *process_arch = ARCH_ARM64;
 #elif defined(_WIN64)
@@ -1350,6 +1347,8 @@
     if (is_wow64_process2)
     {
         /* this could be amd64 on arm64 */
+        USHORT process_machine = 0;
+        USHORT native_machine = 0;
         BOOL is_wow64 = is_wow64_process2(GetCurrentProcess(), &process_machine, &native_machine);
         if (is_wow64 && native_machine == IMAGE_FILE_MACHINE_ARM64)
         {
@@ -1362,6 +1361,8 @@
     if (is_wow64_process2)
     {
         /* check if we're running on arm64 or amd64 machine */
+        USHORT process_machine = 0;
+        USHORT native_machine = 0;
         BOOL is_wow64 = is_wow64_process2(GetCurrentProcess(), &process_machine, &native_machine);
         if (is_wow64)
         {
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 3911006..a861e8a 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -711,7 +711,6 @@
         uiResult = MsiViewFetch(hViewST, &hRecord);
         if (uiResult == ERROR_NO_MORE_ITEMS)
         {
-            uiResult = ERROR_SUCCESS;
             break;
         }
         else if (uiResult != ERROR_SUCCESS)
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 769df6c..dd22cc5 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -473,7 +473,7 @@
                         return ERROR_OUTOFMEMORY;
                     }
 
-                    dwCountExpResult = ExpandEnvironmentStrings(szValue, szValueExp, dwCountExp);
+                    ExpandEnvironmentStrings(szValue, szValueExp, dwCountExp);
                     free(szValue);
                     *pszValue = szValueExp;
                     return ERROR_SUCCESS;
@@ -601,8 +601,6 @@
                         _In_ DWORD dwProperty, _Out_opt_ LPDWORD pdwPropertyRegDataType,
                         _Out_ LPVOID *ppData)
 {
-    DWORD dwResult = ERROR_BAD_ARGUMENTS;
-
     if (ppData == NULL)
     {
         return ERROR_BAD_ARGUMENTS;
@@ -628,7 +626,7 @@
     }
     else
     {
-        dwResult = GetLastError();
+        DWORD dwResult = GetLastError();
         if (dwResult == ERROR_INSUFFICIENT_BUFFER)
         {
             /* Allocate on heap and retry. */
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index fcebcdb..4baf8cc 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -217,7 +217,7 @@
 
 #if !defined(HAVE_OPENSSL_STORE)
     skip();
-#else  /* HAVE_OPENSSL_STORE */
+#else /* HAVE_OPENSSL_STORE */
 
     struct tls_root_ctx ctx = { 0 };
     const char *certfile = global_state.certfile;
@@ -228,9 +228,10 @@
     struct buffer keyuri = alloc_buf_gc(6 + strlen(keyfile) + 1, gc);   /* 6 bytes for "file:/" */
 
     /* Windows temp file path starts with drive letter -- add a leading slash for URI */
-    const char *lead = "";
 #ifdef _WIN32
-    lead = "/";
+    const char *lead = "/";
+#else
+    const char *lead = "";
 #endif /* _WIN32 */
     assert_true(buf_printf(&certuri, "file:%s%s", lead, certfile));
     assert_true(buf_printf(&keyuri, "file:%s%s", lead, keyfile));
@@ -292,8 +293,6 @@
     struct buffer work = alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer encrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer decrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
-    struct buffer buf = clear_buf();
-    void *buf_p;
 
     /* init work */
     ASSERT(buf_init(&work, frame.buf.headroom));
@@ -314,8 +313,8 @@
         prng_bytes(BPTR(&src), BLEN(&src));
 
         /* copy source to input buf */
-        buf = work;
-        buf_p = buf_write_alloc(&buf, BLENZ(&src));
+        struct buffer buf = work;
+        void *buf_p = buf_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
         memcpy(buf_p, BPTR(&src), BLENZ(&src));
 
@@ -345,7 +344,6 @@
     struct buffer encrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer decrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer work = alloc_buf_gc(BUF_SIZE(&frame), &gc);
-    struct buffer buf = clear_buf();
     struct buffer src = alloc_buf_gc(frame.buf.payload_size, &gc);
     void *buf_p;
 
@@ -360,7 +358,7 @@
     prng_bytes(BPTR(&src), BLEN(&src));
 
     /* copy source to input buf */
-    buf = work;
+    struct buffer buf = work;
     buf_p = buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
     memcpy(buf_p, BPTR(&src), BLENZ(&src));
@@ -641,7 +639,6 @@
     struct buffer work = alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer encrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer decrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
-    struct buffer buf = clear_buf();
     void *buf_p;
 
     /* init work */
@@ -658,7 +655,7 @@
     ASSERT(buf_write(&src, plaintext, strlen(plaintext)));
 
     /* copy source to input buf */
-    buf = work;
+    struct buffer buf = work;
     buf_p = buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
     memcpy(buf_p, BPTR(&src), BLENZ(&src));


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
