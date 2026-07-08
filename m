Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCC3C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OqLDpf/zTOhYbPusAUBkKuBsjV/vIF6r/fB/EnwxKEU=; b=f9XiYOMS7U3S09dM4850i/Konr
	ZSN814gyCSx4Awv/E7PPYF8aKsgYvino7wkRg+Tkg2gn4fqEW/cvOkec43J5+UcBv4+4dXb8Pg/4t
	0f67oW7s0gxx8tf7ltYqS1tqGq/ZlkVnRn7Wtg3hnbiBLysJtUaLn8Zy9B0yT46QAcrU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whUFC-0006aN-Vn;
	Wed, 08 Jul 2026 15:31:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1whUFB-0006aF-7n
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IIy+EALRAL0ceyV1XTTnWJ6MYnI6OELc4uJtMEGzTw8=; b=l7rxOcUCjevxG2QFxpwPe6cmX+
 cZ+F5NxPkgMOAm7aQIQOsZtxdx9ABoa47ZYnWbDl5mvr9YOggroRxiHLwkprBulh7CLi6CwXEqFz7
 vZx+cb3Sm18jsydK/t7uSvU2VMHZXR7bLKv46DK8+sjdL25ku7dm6n38ck6aqBgE4eLE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IIy+EALRAL0ceyV1XTTnWJ6MYnI6OELc4uJtMEGzTw8=; b=bUCUL5dtphiwly0YdD6FsM+dqw
 fuejz+jHsuFRYBsdwROD+Go9OYNz9faTX6b+JGZVSbkb/rkpW//Clve1kXZt8eq+YpqzsEurSWsus
 Xi4eitb+w72CwS2tPj5hQ+m7GOYXCsh1fwHk/I9w3wI2kBdzhw4hdTG8e0nb36hokYGI=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whUF8-0007dC-1l for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:31:25 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gwMWJ5zZ2zKw4B;
 Wed, 08 Jul 2026 17:31:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1783524668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IIy+EALRAL0ceyV1XTTnWJ6MYnI6OELc4uJtMEGzTw8=;
 b=Wu0w05Me717d00wn6g+mwGVkg7mNDd/pQyvj1DODLFZGqx67Wy2St+trP9xyjuvbdwhjXR
 CS8fOGyz3ozdS8Vs7vGCAUx9eKYR6XBZ+EGqnBmCU6IYR/zjG5E31zASKUpWLBWimQc8Xf
 tpSYwOBm/hfsYMlTurOUffr/Et90WV92wdhDbroe0K9a+HsBp5UjYaOtrZI901B5NgOoaI
 GSBUdkbDtebcEhaV7p3cu4VH+jEoK9eOZKggSdh0TJlykjBM3T15qLRjdSoD8hMbOHWftJ
 TKboMN30YNexQRcjmDrfN3ZJG2d0CoOSwlG+Oj4DEfCYFoa3e3KsbSUBGX56Ow==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  8 Jul 2026 17:31:07 +0200
Message-ID: <20260708153107.60809-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gwMWJ5zZ2zKw4B
X-Headers-End: 1whUF8-0007dC-1l
Subject: [Openvpn-devel] [PATCH v5] Replace strtok with strtok_r
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

From: Arne Schwabe <arne@rfc2549.org>

This dos not change anything in our source code but makes compiling
with newer Android NDKs (version 30 pre release) -Werror safe again
as it has started throwing warning on this.

The compat version is taken from current FreeBSD (commit dc36d6f9bb1)
src/lib/libc/string/strtok.c and reformatted to our clang standard.

Change-Id: I70560efd113308b7377424127eb2c1da4266371a
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1679
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1679
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 715d02c..ceafbb4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -248,6 +248,7 @@
 check_symbol_exists(chsize io.h HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)
 check_symbol_exists(strsep string.h HAVE_STRSEP)
+check_symbol_exists(strtok_r string.h HAVE_STRTOK_R)
 
 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
@@ -413,6 +414,7 @@
     src/compat/compat-dirname.c
     src/compat/compat-gettimeofday.c
     src/compat/compat-strsep.c
+    src/compat/compat-strtok_r.c
     src/openvpn/argv.c
     src/openvpn/argv.h
     src/openvpn/base64.c
@@ -733,6 +735,8 @@
             src/openvpn/platform.c
             src/openvpn/win32-util.c
             src/compat/compat-gettimeofday.c
+            src/compat/compat-strsep.c
+            src/compat/compat-strtok_r.c
             )
 
         add_library_deps(${test_name})
diff --git a/configure.ac b/configure.ac
index e19d651..188f8fa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -568,7 +568,7 @@
 	setgroups flock gettimeofday \
 	setsid chdir \
 	chsize ftruncate execve getpeereid basename dirname \
-	epoll_create strsep \
+	epoll_create strsep strtok_r \
 ])
 
 AC_CHECK_LIB(
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 69b2990..22867b3 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -20,4 +20,5 @@
 	compat-basename.c \
 	compat-gettimeofday.c \
 	compat-daemon.c \
-	compat-strsep.c
\ No newline at end of file
+	compat-strsep.c \
+	compat-strtok_r.c
\ No newline at end of file
diff --git a/src/compat/compat-strtok_r.c b/src/compat/compat-strtok_r.c
new file mode 100644
index 0000000..debcdd3
--- /dev/null
+++ b/src/compat/compat-strtok_r.c
@@ -0,0 +1,101 @@
+/*-
+ * SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Copyright (c) 1998 Softweyr LLC.  All rights reserved.
+ *
+ * strtok_r, from Berkeley strtok
+ * Oct 13, 1998 by Wes Peters <wes@softweyr.com>
+ *
+ * Copyright (c) 1988, 1993
+ *      The Regents of the University of California.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notices, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notices, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY SOFTWEYR LLC, THE REGENTS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+ * PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL SOFTWEYR LLC, THE
+ * REGENTS, OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
+ * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#ifndef HAVE_STRTOK_R
+#include <string.h>
+
+char *
+strtok_r(char *s, const char *delim, char **last)
+{
+    char *spanp, *tok;
+    int c, sc;
+
+    if (s == NULL && (s = *last) == NULL)
+    {
+        return (NULL);
+    }
+
+/*
+ * Skip (span) leading delimiters (s += strspn(s, delim), sort of).
+ */
+cont:
+    c = *s++;
+    for (spanp = (char *)delim; (sc = *spanp++) != 0;)
+    {
+        if (c == sc)
+        {
+            goto cont;
+        }
+    }
+
+    if (c == 0)
+    { /* no non-delimiter characters */
+        *last = NULL;
+        return (NULL);
+    }
+    tok = s - 1;
+
+    /*
+     * Scan token (scan for delimiters: s += strcspn(s, delim), sort of).
+     * Note that delim must have one NUL; we stop if we see that, too.
+     */
+    for (;;)
+    {
+        c = *s++;
+        spanp = (char *)delim;
+        do
+        {
+            if ((sc = *spanp++) == c)
+            {
+                if (c == 0)
+                {
+                    s = NULL;
+                }
+                else
+                {
+                    s[-1] = '\0';
+                }
+                *last = s;
+                return (tok);
+            }
+        } while (sc != 0);
+    }
+    /* NOTREACHED */
+}
+#endif
\ No newline at end of file
diff --git a/src/compat/compat.h b/src/compat/compat.h
index 6532b86..9e6f95c 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -61,4 +61,9 @@
 
 #endif
 
+#ifndef HAVE_STRTOK_R
+char *
+strtok_r(char *s, const char *delim, char **last);
+#endif
+
 #endif /* COMPAT_H */
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 47fe0bc..d72ea25c 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -48,7 +48,8 @@
         message = strstr(reason, "]") + 1;
         /* null terminate the substring to only looks for flags between [ and ] */
         *endofflags = '\x00';
-        const char *token = strtok(m, "[,");
+        char *lasts = NULL;
+        const char *token = strtok_r(m, "[,", &lasts);
         while (token)
         {
             if (!strncmp(token, "backoff ", strlen("backoff ")))
@@ -81,7 +82,7 @@
             {
                 msg(D_PUSH_ERRORS, "WARNING: unknown AUTH_FAIL,TEMP flag: %s", token);
             }
-            token = strtok(NULL, "[,");
+            token = strtok_r(NULL, "[,", &lasts);
         }
     }
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 8a0f7d2..07caf08 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -318,9 +318,10 @@
 
     /* Parse allowed ciphers, getting IDs */
     int i = 0;
+    char *lasts = NULL;
     tmp_ciphers_orig = tmp_ciphers = string_alloc(ciphers, NULL);
 
-    token = strtok(tmp_ciphers, ":");
+    token = strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
     {
         ctx->allowed_ciphers[i] = mbedtls_ssl_get_ciphersuite_id(tls_translate_cipher_name(token));
@@ -328,7 +329,7 @@
         {
             i++;
         }
-        token = strtok(NULL, ":");
+        token = strtok_r(NULL, ":", &lasts);
     }
     free(tmp_ciphers_orig);
 }
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 649665a..baf5a95 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -100,7 +100,8 @@
     struct buffer new_list = alloc_buf(MAX_NCP_CIPHERS_LENGTH);
 
     char *const tmp_ciphers = string_alloc(list, NULL);
-    const char *token = strtok(tmp_ciphers, ":");
+    char *lasts = NULL;
+    const char *token = strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
     {
         /*
@@ -174,7 +175,7 @@
                 buf_puts(&new_list, ovpn_cipher_name);
             }
         }
-        token = strtok(NULL, ":");
+        token = strtok_r(NULL, ":", &lasts);
     }
 
 
@@ -207,15 +208,16 @@
 {
     char *tmp_ciphers = string_alloc(list, NULL);
     char *tmp_ciphers_orig = tmp_ciphers;
+    char *lasts = NULL;
 
-    const char *token = strtok(tmp_ciphers, ":");
+    const char *token = strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
     {
         if (0 == strcmp(token, item))
         {
             break;
         }
-        token = strtok(NULL, ":");
+        token = strtok_r(NULL, ":", &lasts);
     }
     free(tmp_ciphers_orig);
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0804d2d..1db7f55 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -868,7 +868,8 @@
         return false;
     }
 
-    const char *client_method = strtok(iv_sso, ",");
+    char *lasts = NULL;
+    const char *client_method = strtok_r(iv_sso, ",", &lasts);
     bool supported = false;
 
     while (client_method)
@@ -878,7 +879,7 @@
             supported = true;
             break;
         }
-        client_method = strtok(NULL, ",");
+        client_method = strtok_r(NULL, ",", &lasts);
     }
 
     gc_free(&gc);
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 1128eb4..d861ef9 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -107,6 +107,7 @@
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/compat/compat-strsep.c \
+	$(top_srcdir)/src/compat/compat-strtok_r.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/cryptoapi.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
@@ -345,6 +346,7 @@
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/compat/compat-strsep.c \
+	$(top_srcdir)/src/compat/compat-strtok_r.c \
 	$(top_srcdir)/src/openvpn/ssl_util.c
 
 mbuf_testdriver_CFLAGS  = \


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
