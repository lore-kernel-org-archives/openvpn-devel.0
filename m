Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAB1C5AC7A
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sis6oE38+xw9TrcIFTHxYkhtDlP+AvPHu0N3CaZFjsg=; b=CmDbOcHcLzbslijDkPSdGonp1X
	1h/maBS/Hhdli+xkKyw8afo7pKnzgdCQ8yhyaYWaBZOn7YOZjykR+VTptx8bZhnbxzVZJmGleh0Gy
	CzSRIDe+MzMSA+28dbEK4Sdr59opUX80VHJY6ZbEmmuiyKdMWTCcfQXNZPJSLdsgPtwE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMh2-00035P-N0;
	Fri, 07 Aug 2026 15:41:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wsMh2-00035I-2s
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:41:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=11IDMYg56vB+7+USd261TJSxKfeWOWOfikV8mKKIHaE=; b=gyuU0kgx3NGj9NHwNfp7WqNUue
 QCOTDVeYbZlU5mCzSCAyJd2wyKblD2F9E2XOz3HIQHj0+ultU8VUDONedhymSNdKcLgVeP+P434CL
 5V0GvJ6Gg0w+KZr+ZviB9RchF9FtONCf3d72NlNhQGmPlmJwYLlXN4GwAO6UDOuUO30A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=11IDMYg56vB+7+USd261TJSxKfeWOWOfikV8mKKIHaE=; b=SAVCeQaYc8rUCZmZ0nnNruyLl0
 ACW2jHXvLFuqaMG4c5VZwa/9Hi1dEEOuYY1sCUpyFEOvOy1UzUmzzPFsnD3LQxgPiClNUm72et4uz
 ofnPRp03RwU4cjgR93rddmRIbnttbvPjUNnJa1OSlsv7Pb3YV2cP6bQfBDOoTWnElKUc=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsMh0-0001jB-PO for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:41:08 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hGl585p46zKvv0;
 Fri, 07 Aug 2026 15:15:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1786108540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11IDMYg56vB+7+USd261TJSxKfeWOWOfikV8mKKIHaE=;
 b=wYU+HKnwVU2lRoCAhfUXWCKsnWf8U2TMCQqlYYj1LtR6qK+BrmcNfOAe6GZng3K7H2xNBA
 NV0d5EHyoV1YhTeuL6TgI9RV22aAik6RWBcd8G4h/EUhq9YdLkyJOFqTwzri4htlMWlk6r
 ITcG+lV8n42TinDQBZ6YcXYA9OUItdCvGG+fQ5VwuEPG7Gx9IGJA6NWzqQuXwQjME/Ymx1
 EJt1rBmsIVyykIS8it6Q35SISGTaPz8dJLMUWmiIN6B4GppmNUX/ljf2Cu1jl5UZ+/D4ZL
 SMRVVlntUL79xifVpZg22dfQtqqDmW3Jo9FTpf3+E7Ou/3mDmX1F/VurSkJUow==
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  7 Aug 2026 15:15:39 +0200
Message-ID: <20260807131539.53877-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
References: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wsMh0-0001jB-PO
Subject: [Openvpn-devel] [PATCH v2] Remove --with-mem-check=dmalloc
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
Cc: Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This code hasn't compiled for years and noone complained.
We generally use ASAN instead.

So remove the dead code.

v2: The first version of this change tried to fix the
    code. v2 instead removes it.

Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1582
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1582
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 74c080e..6b3b455 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -260,7 +260,6 @@
 
 check_include_files(arpa/inet.h HAVE_ARPA_INET_H)
 check_include_files(dlfcn.h HAVE_DLFCN_H)
-check_include_files(dmalloc.h HAVE_DMALLOC_H)
 check_include_files(fcntl.h HAVE_FCNTL_H)
 check_include_files(err.h HAVE_ERR_H)
 check_include_files(netdb.h HAVE_NETDB_H)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 34f289d..c3bb5a5 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -96,9 +96,6 @@
 /* Define to 1 if you have the <dlfcn.h> header file. */
 #cmakedefine HAVE_DLFCN_H
 
-/* Define to 1 if you have the <dmalloc.h> header file. */
-#cmakedefine HAVE_DMALLOC_H
-
 /* Define to 1 if you have the `dup' function. */
 #cmakedefine HAVE_DUP
 
diff --git a/configure.ac b/configure.ac
index 1aec805..469a475 100644
--- a/configure.ac
+++ b/configure.ac
@@ -245,10 +245,10 @@
 
 AC_ARG_WITH(
 	[mem-check],
-	[AS_HELP_STRING([--with-mem-check=TYPE], [build with debug memory checking, TYPE=no|dmalloc|valgrind|ssl @<:@default=no@:>@])],
+	[AS_HELP_STRING([--with-mem-check=TYPE], [build with debug memory checking, TYPE=no|valgrind|ssl @<:@default=no@:>@])],
 	[
 		case "${withval}" in
-			dmalloc|valgrind|ssl|no) ;;
+			valgrind|ssl|no) ;;
 			*) AC_MSG_ERROR([bad value ${withval} for --mem-check]) ;;
 		esac
 	],
@@ -652,25 +652,6 @@
 			[AC_MSG_ERROR([valgrind headers not found.])]
 		)
 		;;
-	dmalloc)
-		AC_CHECK_HEADERS(
-			[dmalloc.h],
-			[AC_CHECK_LIB(
-				[dmalloc],
-				[malloc],
-				[
-					LIBS="${LIBS} -ldmalloc"
-					AC_DEFINE(
-						[DMALLOC],
-						[1],
-						[Use dmalloc memory debugging library]
-					)
-				],
-				[AC_MSG_ERROR([dmalloc library not found.])]
-			)],
-			[AC_MSG_ERROR([dmalloc headers not found.])]
-		)
-		;;
 	ssl)
 		AC_CHECK_LIB(
 			[ssl],
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 5f2b233..23d714d 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -57,11 +57,7 @@
 }
 
 struct buffer
-#ifdef DMALLOC
-alloc_buf_debug(size_t size, const char *file, int line)
-#else
 alloc_buf(size_t size)
-#endif
 {
     struct buffer buf;
     CLEAR(buf);
@@ -71,22 +67,14 @@
         buf_size_error(size);
     }
     buf.capacity = (int)size;
-#ifdef DMALLOC
-    buf.data = openvpn_dmalloc(file, line, size);
-#else
     buf.data = calloc(1, size);
-#endif
     check_malloc_return(buf.data);
 
     return buf;
 }
 
 struct buffer
-#ifdef DMALLOC
-alloc_buf_gc_debug(size_t size, struct gc_arena *gc, const char *file, int line)
-#else
 alloc_buf_gc(size_t size, struct gc_arena *gc)
-#endif
 {
     struct buffer buf;
     CLEAR(buf);
@@ -96,11 +84,7 @@
         buf_size_error(size);
     }
     buf.capacity = (int)size;
-#ifdef DMALLOC
-    buf.data = (uint8_t *)gc_malloc_debug(size, false, gc, file, line);
-#else
     buf.data = (uint8_t *)gc_malloc(size, false, gc);
-#endif
     if (size)
     {
         *buf.data = 0;
@@ -109,7 +93,7 @@
 }
 
 struct buffer
-#ifdef DMALLOC
+#ifdef BUF_INIT_TRACKING
 clone_buf_debug(const struct buffer *buf, const char *file, int line)
 #else
 clone_buf(const struct buffer *buf)
@@ -123,11 +107,7 @@
     ret.debug_file = buf->debug_file;
     ret.debug_line = buf->debug_line;
 #endif
-#ifdef DMALLOC
-    ret.data = (uint8_t *)openvpn_dmalloc(file, line, buf->capacity);
-#else
     ret.data = (uint8_t *)malloc(buf->capacity);
-#endif
     check_malloc_return(ret.data);
     memcpy(BPTR(&ret), BPTR(buf), BLENZ(buf));
     return ret;
@@ -335,21 +315,13 @@
  */
 
 void *
-#ifdef DMALLOC
-gc_malloc_debug(size_t size, bool clear, struct gc_arena *a, const char *file, int line)
-#else
 gc_malloc(size_t size, bool clear, struct gc_arena *a)
-#endif
 {
     void *ret;
     if (a)
     {
         struct gc_entry *e;
-#ifdef DMALLOC
-        e = (struct gc_entry *)openvpn_dmalloc(file, line, size + sizeof(struct gc_entry));
-#else
         e = (struct gc_entry *)malloc(size + sizeof(struct gc_entry));
-#endif
         check_malloc_return(e);
         ret = (char *)e + sizeof(struct gc_entry);
         e->next = a->list;
@@ -357,11 +329,7 @@
     }
     else
     {
-#ifdef DMALLOC
-        ret = openvpn_dmalloc(file, line, size);
-#else
         ret = malloc(size);
-#endif
         check_malloc_return(ret);
     }
 #ifndef ZERO_BUFFER_ON_ALLOC
@@ -444,11 +412,7 @@
 {
     ASSERT(a);
     struct gc_entry_special *e;
-#ifdef DMALLOC
-    e = (struct gc_entry_special *)openvpn_dmalloc(file, line, sizeof(struct gc_entry_special));
-#else
     e = (struct gc_entry_special *)malloc(sizeof(struct gc_entry_special));
-#endif
     check_malloc_return(e);
     e->free_fnc = free_function;
     e->addr = addr;
@@ -647,11 +611,7 @@
  * Allocate a string
  */
 char *
-#ifdef DMALLOC
-string_alloc_debug(const char *str, struct gc_arena *gc, const char *file, int line)
-#else
 string_alloc(const char *str, struct gc_arena *gc)
-#endif
 {
     if (str)
     {
@@ -660,11 +620,7 @@
 
         if (gc)
         {
-#ifdef DMALLOC
-            ret = (char *)gc_malloc_debug(n, false, gc, file, line);
-#else
             ret = (char *)gc_malloc(n, false, gc);
-#endif
         }
         else
         {
@@ -672,11 +628,7 @@
              * that the caller cleans up afterwards.  This is coherent with the
              * earlier behaviour when gc_malloc() would be called with gc == NULL
              */
-#ifdef DMALLOC
-            ret = openvpn_dmalloc(file, line, n);
-#else
             ret = calloc(1, n);
-#endif
             check_malloc_return(ret);
         }
         memcpy(ret, str, n);
@@ -750,21 +702,13 @@
  * Allocate a string inside a buffer
  */
 struct buffer
-#ifdef DMALLOC
-string_alloc_buf_debug(const char *str, struct gc_arena *gc, const char *file, int line)
-#else
 string_alloc_buf(const char *str, struct gc_arena *gc)
-#endif
 {
     struct buffer buf;
 
     ASSERT(str);
 
-#ifdef DMALLOC
-    buf_set_read(&buf, (uint8_t *)string_alloc_debug(str, gc, file, line), strlen(str) + 1);
-#else
     buf_set_read(&buf, (uint8_t *)string_alloc(str, gc), strlen(str) + 1);
-#endif
 
     if (buf.len > 0) /* Don't count trailing '\0' as part of length */
     {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 1db9367..22e045c 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -147,32 +147,6 @@
 
 void buf_size_error(const size_t size);
 
-/* for dmalloc debugging */
-
-#ifdef DMALLOC
-
-#define alloc_buf(size)               alloc_buf_debug(size, __FILE__, __LINE__)
-#define alloc_buf_gc(size, gc)        alloc_buf_gc_debug(size, gc, __FILE__, __LINE__);
-#define clone_buf(buf)                clone_buf_debug(buf, __FILE__, __LINE__);
-#define gc_malloc(size, clear, arena) gc_malloc_debug(size, clear, arena, __FILE__, __LINE__)
-#define string_alloc(str, gc)         string_alloc_debug(str, gc, __FILE__, __LINE__)
-#define string_alloc_buf(str, gc)     string_alloc_buf_debug(str, gc, __FILE__, __LINE__)
-
-struct buffer alloc_buf_debug(size_t size, const char *file, int line);
-
-struct buffer alloc_buf_gc_debug(size_t size, struct gc_arena *gc, const char *file, int line);
-
-struct buffer clone_buf_debug(const struct buffer *buf, const char *file, int line);
-
-void *gc_malloc_debug(size_t size, bool clear, struct gc_arena *a, const char *file, int line);
-
-char *string_alloc_debug(const char *str, struct gc_arena *gc, const char *file, int line);
-
-struct buffer string_alloc_buf_debug(const char *str, struct gc_arena *gc, const char *file,
-                                     int line);
-
-#else  /* ifdef DMALLOC */
-
 struct buffer alloc_buf(size_t size);
 
 struct buffer alloc_buf_gc(size_t size,
@@ -186,8 +160,6 @@
 
 struct buffer string_alloc_buf(const char *str, struct gc_arena *gc);
 
-#endif /* ifdef DMALLOC */
-
 void gc_addspecial(void *addr, void (*free_function)(void *), struct gc_arena *a);
 
 /**
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index b602ba1..17085d6 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -102,16 +102,6 @@
  */
 void crypto_unload_provider(const char *provname, provider_t *provider);
 
-#ifdef DMALLOC
-/*
- * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
- * OpenSSL to use our private malloc/realloc/free functions so that
- * we can dispatch them to dmalloc.
- */
-void crypto_init_dmalloc(void);
-
-#endif /* DMALLOC */
-
 void show_available_ciphers(void);
 
 void show_available_digests(void);
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c
index debd53d..9e47c26 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -139,14 +139,6 @@
 }
 
 
-#ifdef DMALLOC
-void
-crypto_init_dmalloc(void)
-{
-    msg(M_ERR, "Error: dmalloc support is not available for mbed TLS.");
-}
-#endif /* DMALLOC */
-
 const cipher_name_pair cipher_name_translation_table[] = {
     { "BF-CBC", "BLOWFISH-CBC" },
     { "BF-CFB", "BLOWFISH-CFB64" },
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index fa9eb67..1191f20 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -39,6 +39,7 @@
 #include "integer.h"
 #include "crypto.h"
 #include "crypto_backend.h"
+#include "memdbg.h"
 #include "openssl_compat.h"
 
 #include <openssl/conf.h>
@@ -273,40 +274,6 @@
 }
 
 
-/*
- *
- * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
- * OpenSSL to use our private malloc/realloc/free functions so that
- * we can dispatch them to dmalloc.
- *
- */
-
-#ifdef DMALLOC
-static void *
-crypto_malloc(size_t size, const char *file, int line)
-{
-    return dmalloc_malloc(file, line, size, DMALLOC_FUNC_MALLOC, 0, 0);
-}
-
-static void *
-crypto_realloc(void *ptr, size_t size, const char *file, int line)
-{
-    return dmalloc_realloc(file, line, ptr, size, DMALLOC_FUNC_REALLOC, 0);
-}
-
-static void
-crypto_free(void *ptr)
-{
-    dmalloc_free(__FILE__, __LINE__, ptr, DMALLOC_FUNC_FREE);
-}
-
-void
-crypto_init_dmalloc(void)
-{
-    CRYPTO_set_mem_ex_functions(crypto_malloc, crypto_realloc, crypto_free);
-}
-#endif /* DMALLOC */
-
 const cipher_name_pair cipher_name_translation_table[] = {
     { "AES-128-GCM", "id-aes128-GCM" },
     { "AES-192-GCM", "id-aes192-GCM" },
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0236886..893670f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -838,11 +838,6 @@
 bool
 init_static(void)
 {
-#if defined(DMALLOC)
-    crypto_init_dmalloc();
-#endif
-
-
     /*
      * Initialize random number seed.  random() is only used
      * when "weak" random numbers are acceptable.
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index ea620c2..1f94582 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -43,67 +43,10 @@
  */
 
 #ifdef USE_VALGRIND
-
 #include <valgrind/memcheck.h>
-
-#define VALGRIND_MAKE_READABLE(addr, len)
-
-#else /* ifdef USE_VALGRIND */
-
-#define VALGRIND_MAKE_READABLE(addr, len)
-
 #endif
 
-#ifdef DMALLOC /* see ./configure options to enable */
-
-/*
- * See ./configure options to enable dmalloc
- * support for memory leak checking.
- *
- * The dmalloc package can be downloaded from:
- *
- *     https://dmalloc.com/
- *
- * When dmalloc is installed and enabled,
- * use this command prior to running openvpn:
- *
- *    dmalloc -l dlog -i 100 low -p log-unknown
- *
- * Also, put this in your .bashrc file:
- *
- *    function dmalloc { eval `command dmalloc -b $*`; }
- *
- * Or take a more low-level approach:
- *
- *    export DMALLOC_OPTIONS="debug=0x4e48503,inter=100,log=dlog"
- *
- *  NOTE: When building dmalloc you need to add something
- *  like this to dmalloc's settings.h -- it will allocate a static
- *  buffer to be used as the malloc arena:
- *
- *  #define INTERNAL_MEMORY_SPACE (1024 * 1024 * 50)
- */
-
-#include <dmalloc.h>
-
-#define openvpn_dmalloc(file, line, size) \
-    dmalloc_malloc((file), (line), (size), DMALLOC_FUNC_MALLOC, 0, 0)
-
-/*
- * This #define will put the line number of the log
- * file position where leaked memory was allocated instead
- * of the source code file and line number.  Make sure
- * to increase the size of dmalloc's info tables,
- * (MEMORY_TABLE_SIZE in settings.h)
- * otherwise it might get overwhelmed by the large
- * number of unique file/line combinations.
- */
-#if 0
-#undef malloc
-#define malloc(size) openvpn_dmalloc("logfile", x_msg_line_num, (size))
-#endif
-
-#endif /* DMALLOC */
+#define VALGRIND_MAKE_READABLE(addr, len)
 
 /*
  * Force buffers to be zeroed after allocation.


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
