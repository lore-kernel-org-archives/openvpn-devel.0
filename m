Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5969E606A324
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fpsRAuA1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=arQQCDqF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZP6yy+Zd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DFXg1FUlEZVcMx6CkbrPQnZpGdmYnAwvhCzSiheHu9U=; b=fpsRAuA1Ib2+k9
	7NltVUMliLpNSpR3af69GgSUcKMjCIU317wmksogpgoW+6yaSpS4FA8UCJb9QIoFkd/7TRrMipXG8
	eKnralSqbrBMHZJdZNzdpdRrDF+vSvxyik5qmST1tsuf8cAt11YeASXYQJ52hSJ8ItpGckuwqSK9w
	jcM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLgpU-0000000017Z-0k7A;
	Tue, 27 Oct 2026 13:03:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xLgpS-0000000017T-0g8u for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:03:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d3ht5+2cMac0zcogZ1kFcSInsAkvnUdo5byUigtDqM8=; b=arQQCDqFl1m0DrMPcAjQHYz01n
 4QFQzIQS553MGDC45TVXjfIT3zxs4CjKr2e2Zi21rM2BtpVho5Rin3uuv1SJiqjjjvQAa00R9ffim
 hmrAXclVWSIvBHGg3+EIJp8pmxwPIr/zIDTf1Ind1zLrgwwJyB4PybZ3C2PjZPqLWTWU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d3ht5+2cMac0zcogZ1kFcSInsAkvnUdo5byUigtDqM8=; b=ZP6yy+ZdbVB6/5txhJBJJg+jY/
 RkAR2JglxS3iBaZ/kCEdKl64PKtSdIk5HKSC4UIXACreTKA9SEII1klE+cvo3VAqbjSGqKCh3zz7q
 75FHDX81m3t8t3xB9onWMU3kzL2hFhcP0DNXsvMCI7UUYcP2QxGM98wp6HhpVB4HQXN4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLgpP-000000006JG-0wW1 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:03:02 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69RD2qmx002475
 for <openvpn-devel@lists.sourceforge.net>; Tue, 27 Oct 2026 14:02:52 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69RD2q45002474
 for openvpn-devel@lists.sourceforge.net; Tue, 27 Oct 2026 14:02:52 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 27 Oct 2026 14:02:45 +0100
Message-ID: <20261027130252.2457-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793032811000.Icf890b018b9950c698e46cc44b39edaa0c6ec566@gerrit.openvpn.net>
References: <gerrit.1793032811000.Icf890b018b9950c698e46cc44b39edaa0c6ec566@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xLgpP-000000006JG-0wW1
Subject: [Openvpn-devel] [PATCH v1] buffer: restructure some loops and
 assignments
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jeff Bindel <jeff@incrediblybased.co>

Small cleanups in buffer.c that do not change behaviour, in preparation
for building it with -fbounds-safety:

- alloc_buf(), alloc_buf_gc(), clone_buf(): assign buf.data before
  buf.capacity and drop the redundant casts of the allocator result
- free_buf_gc(): compare the entry address arithmetically instead of
  stepping a struct gc_entry pointer past its object
- buf_printf(): bound the length of the written string by the capacity
  passed to vsnprintf()
- string_array_len(), print_argv(), string_class(), string_substitute():
  walk NUL-terminated strings and arrays by advancing the pointer
- string_mod(): write through a separate output pointer
- string_alloc_buf(): use a temporary for the copied string
- buf_parse(): check for an empty line without strlen()

Change-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
Signed-off-by: Jeff Bindel <jeff@incrediblybased.co>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2034
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2034
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index c683f8e..8813fa5 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -66,8 +66,8 @@
     {
         buf_size_error(size);
     }
-    buf.capacity = (int)size;
     buf.data = calloc(1, size);
+    buf.capacity = (int)size;
     check_malloc_return(buf.data);
 
     return buf;
@@ -83,8 +83,8 @@
     {
         buf_size_error(size);
     }
+    buf.data = gc_malloc(size, false, gc);
     buf.capacity = (int)size;
-    buf.data = (uint8_t *)gc_malloc(size, false, gc);
     if (size)
     {
         *buf.data = 0;
@@ -100,15 +100,15 @@
 #endif
 {
     struct buffer ret;
+    ret.data = malloc(buf->capacity);
     ret.capacity = buf->capacity;
+    check_malloc_return(ret.data);
     ret.offset = buf->offset;
     ret.len = buf->len;
 #ifdef BUF_INIT_TRACKING
     ret.debug_file = buf->debug_file;
     ret.debug_line = buf->debug_line;
 #endif
-    ret.data = (uint8_t *)malloc(buf->capacity);
-    check_malloc_return(ret.data);
     memcpy(BPTR(&ret), CBPTR(buf), BLENZ(buf));
     return ret;
 }
@@ -182,7 +182,7 @@
         while (*e)
         {
             /* check if this object is the one we want to delete */
-            if ((uint8_t *)(*e + 1) == buf->data)
+            if ((uintptr_t)*e + sizeof(struct gc_entry) == (uintptr_t)buf->data)
             {
                 struct gc_entry *to_delete = *e;
 
@@ -238,7 +238,7 @@
             va_start(arglist, format);
             stat = vsnprintf(ptr, cap, format, arglist);
             va_end(arglist);
-            buf->len += (int)strlen(ptr);
+            buf->len += (int)strnlen(ptr, cap);
             if (stat >= 0 && stat < cap)
             {
                 ret = true;
@@ -607,7 +607,7 @@
 
         if (gc)
         {
-            ret = (char *)gc_malloc(n, false, gc);
+            ret = gc_malloc(n, false, gc);
         }
         else
         {
@@ -648,7 +648,7 @@
     int i = 0;
     if (array)
     {
-        while (array[i])
+        for (; *array; ++array)
         {
             ++i;
         }
@@ -661,13 +661,9 @@
 {
     struct buffer out = alloc_buf_gc(256, gc);
     int i = 0;
-    for (;;)
+    for (; *p; ++p)
     {
-        const char *cp = *p++;
-        if (!cp)
-        {
-            break;
-        }
+        const char *cp = *p;
         if (i)
         {
             buf_printf(&out, " ");
@@ -695,7 +691,8 @@
 
     ASSERT(str);
 
-    buf_set_read(&buf, (uint8_t *)string_alloc(str, gc), strlen(str) + 1);
+    const char *copy = string_alloc(str, gc);
+    buf_set_read(&buf, (const uint8_t *)copy, strlen(str) + 1);
 
     if (buf.len > 0) /* Don't count trailing '\0' as part of length */
     {
@@ -789,7 +786,7 @@
     } while (c);
 
     line[size - 1] = '\0';
-    return !(eol && !strlen(line));
+    return !(eol && line[0] == '\0');
 }
 
 /*
@@ -970,11 +967,10 @@
 bool
 string_class(const char *str, const unsigned int inclusive, const unsigned int exclusive)
 {
-    char c;
     ASSERT(str);
-    while ((c = *str++))
+    for (; *str; ++str)
     {
-        if (!char_inc_exc(c, inclusive, exclusive))
+        if (!char_inc_exc(*str, inclusive, exclusive))
         {
             return false;
         }
@@ -990,11 +986,12 @@
 string_mod(char *str, const unsigned int inclusive, const unsigned int exclusive,
            const char replace)
 {
-    const char *in = str;
-    bool ret = true;
-
     ASSERT(str);
 
+    char *out = str;
+    const char *in = out;
+    bool ret = true;
+
     while (true)
     {
         char c = *in++;
@@ -1007,12 +1004,12 @@
             }
             if (c)
             {
-                *str++ = c;
+                *out++ = c;
             }
         }
         else
         {
-            *str = '\0';
+            *out = '\0';
             break;
         }
     }
@@ -1103,19 +1100,14 @@
 char *
 string_substitute(const char *src, char from, char to, struct gc_arena *gc)
 {
-    char *ret = (char *)gc_malloc(strlen(src) + 1, true, gc);
+    char *ret = gc_malloc(strlen(src) + 1, true, gc);
     char *dest = ret;
-    char c;
 
-    do
+    for (; *src; ++src)
     {
-        c = *src++;
-        if (c == from)
-        {
-            c = to;
-        }
-        *dest++ = c;
-    } while (c);
+        *dest++ = (*src == from) ? to : *src;
+    }
+    *dest = '\0';
     return ret;
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
