Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CE3CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 17:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lLuwCLMad3JKaeSaLBvCXT6w3peB33vdzuuiE5S2uEA=; b=mkU6t4hcESg5yUS1cxsgoaAfl3
	N/MmSysVqn5G6FbT23wNthWMGCtEaqEoEWVmMMMK7Bd7R6AH9/4/qozIEDwqfQb8zMDdYYdV/XHAY
	GlNWH4uE7kcdOit2I7NxJxRC4R40CZCBDhZLDekP5lPdN1T8Wi4gipfI9tLXMSKHnKRo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI83o-0000CE-PJ;
	Sat, 17 Oct 2026 17:19:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xI83n-0000C8-GN
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 17:19:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CHSuPOmlApGIMU5zEqaeKsYkQNzwqx1hbB6lp/W2RtQ=; b=c+plBKmRlp5VbZeI65OT/irVb7
 YhPWwYhpEiCHO9MiqF2hiuSTRHdPVdjrUKbnDjgc7nyCFUNTvVO5oznMUqtmv6YzXdEwKt22sbVuI
 FBhl0Qm5LcaSfbe4BsO5cm96fqNV5RjIhg+aNdSJKU8IqwgV7H+sqlXn3H4Gm5bPsT1U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CHSuPOmlApGIMU5zEqaeKsYkQNzwqx1hbB6lp/W2RtQ=; b=czrNLklS0Df/zbPMHMGvExlx8h
 WJcwpqeboZn3sI7vXHnzV2qCsIDFAR2E6yxCVlrXT4evhI/HKquwLYziI4TMR1OBdFp1Sx3sOje/I
 JjegtJyLEP+JQzqzFDZkWa3j00H3B8P45zvLpA4FvoTHTF3qykec986kTrDMriEItFTw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xI83l-0006me-Ix for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 17:19:07 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69HHIwuj016221
 for <openvpn-devel@lists.sourceforge.net>; Sat, 17 Oct 2026 19:18:58 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69HHIw9G016220
 for openvpn-devel@lists.sourceforge.net; Sat, 17 Oct 2026 19:18:58 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 17 Oct 2026 19:18:53 +0200
Message-ID: <20261017171858.16208-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xI83l-0006me-Ix
Subject: [Openvpn-devel] [PATCH v3] buffer: Fix small issues in buf_printf
 and buf_puts
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

- Remove unused and wrongly document return value
  of buf_puts
- Add UTs for buf_puts
Both of these changes based on a PR by
cuishuang <imcusg@gmail.com>.

In both functions:
- Remove obsolete manual adding of \0
- Do not try to append if we can only overwrite
  the trailing \0 byte

Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1997
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1997
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index cc1b300..3599cc9 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -225,21 +225,20 @@
 bool
 buf_printf(struct buffer *buf, const char *format, ...)
 {
-    int ret = false;
+    bool ret = false;
     if (buf_defined(buf))
     {
-        uint8_t *ptr = BEND(buf);
+        char *ptr = (char *)BEND(buf);
         int cap = buf_forward_capacity(buf);
 
-        if (cap > 0)
+        if (cap > 1) /* can write more than \0 */
         {
             int stat;
             va_list arglist;
             va_start(arglist, format);
-            stat = vsnprintf((char *)ptr, cap, format, arglist);
+            stat = vsnprintf(ptr, cap, format, arglist);
             va_end(arglist);
-            *(buf->data + buf->capacity - 1) = 0; /* windows vsnprintf needs this */
-            buf->len += (int)strlen((char *)ptr);
+            buf->len += (int)strlen(ptr);
             if (stat >= 0 && stat < cap)
             {
                 ret = true;
@@ -249,19 +248,16 @@
     return ret;
 }
 
-bool
+void
 buf_puts(struct buffer *buf, const char *str)
 {
-    int ret = false;
-    uint8_t *ptr = BEND(buf);
+    char *ptr = (char *)BEND(buf);
     int cap = buf_forward_capacity(buf);
-    if (cap > 0)
+    if (cap > 1) /* can write more than \0 */
     {
-        int str_len = (int)strlcpy((char *)ptr, str, cap);
+        int str_len = (int)strlcpy(ptr, str, cap);
         buf->len += (str_len < cap) ? str_len : cap - 1;
-        ret = true;
     }
-    return ret;
 }
 
 /*
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index c66ed1a..eb64446 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -791,10 +791,8 @@
  *
  * @param buf   The buffer to append to.
  * @param str   The null-terminated string to append.
- *
- * @return true if the string fit in the buffer, false if it was truncated.
  */
-bool buf_puts(struct buffer *buf, const char *str);
+void buf_puts(struct buffer *buf, const char *str);
 
 
 /*
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index bf486e0..338265d 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -62,6 +62,10 @@
     buf_printf(&buf, "%d", 123);
     buf_printf(&buf, "%s", "some text, too long to fit");
     assert_buf_equals_str(&buf, "123some text, t");
+    assert_int_equal(BCAP(&buf), 1); /* \0 byte not part of len */
+
+    buf_printf(&buf, "%s", "more");
+    assert_buf_equals_str(&buf, "123some text, t");
 
     buf_catrunc(&buf, "...");
     assert_buf_equals_str(&buf, "123some text...");
@@ -79,6 +83,30 @@
 }
 
 static void
+test_buffer_puts(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(5, &gc);
+
+    buf_puts(&buf, "1234");
+    assert_string_equal(BSTR(&buf), "1234");
+
+    buf_reset_len(&buf);
+    buf_puts(&buf, "12345");
+    assert_string_equal(BSTR(&buf), "1234");
+
+    /* buf already full */
+    buf_puts(&buf, "12345");
+    assert_string_equal(BSTR(&buf), "1234");
+
+    struct buffer one_byte_buf = alloc_buf_gc(1, &gc);
+    buf_puts(&one_byte_buf, "x");
+    assert_string_equal(BSTR(&one_byte_buf), "");
+
+    gc_free(&gc);
+}
+
+static void
 test_buffer_format_hex_ex(void **state)
 {
     const int input_size = 10;
@@ -632,6 +660,7 @@
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(test_buffer_strprefix),
         cmocka_unit_test(test_buffer_printf_catrunc),
+        cmocka_unit_test(test_buffer_puts),
         cmocka_unit_test(test_buffer_format_hex_ex),
         cmocka_unit_test_setup_teardown(test_buffer_list_aggregate_separator_empty,
                                         test_buffer_list_setup, test_buffer_list_teardown),


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
