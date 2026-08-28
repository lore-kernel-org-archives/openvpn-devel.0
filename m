Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEC1C61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+NGczbSW8Yq9mHeInrLF7dkkjMUkEWMIjoL8fFm2x8=; b=RQBXeYmg9n0L1t5us1ZMLDOhvU
	E3kxgAl8XCwZD7M+FG4+TzWPXaF5w9TLanYJZ9LeEJzREwZ6IOs61XVHzE2XjmE/vGku68YPDG/v8
	oSDclN3diPViYpb2Gh7PqnPhvy8yNfiCDk6AnInoUX20SG4uVW3k557yc+uZZVHIutlo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztvh-0006Fd-Lh;
	Fri, 28 Aug 2026 10:35:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wztvh-0006FW-CT
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:35:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Uv4AgJb864Oo8fEunn0I1p0heq9K3zddfNrinpotJnY=; b=HzyPceEfG5GU+EmZ21DANFFadv
 fXlO20/RqcgRXZm3JrBGdwlKDZCGgk0wTVaXao1zosxdrBN+uZ7Qfl3br3SeFQtLboM5gpvYmpIhv
 UoI1iul3JuBZE5OoKLctNeOw/ojP6ApTsh1G6ZK7u8ibAcc5BNkWNkcygaAcGI6D1Wao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Uv4AgJb864Oo8fEunn0I1p0heq9K3zddfNrinpotJnY=; b=NqesdSsjvu27stq1IQvz/CCJAX
 sU2aEKAuYaeDki3tmUpLr1VhesoVn0G1ZIj5bq7b9dBUYsoy/+A7aHv8XWfpdbn0K3w92JJKs2Gg0
 CCky2orWbU8wcCjjcE45lAaIEz+lXIFZjZjzp7C4OJ5OINUtihaNgwaxr9l1taaId56U=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wztvg-0001TE-Fg for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:35:25 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67SAZH91013340
 for <openvpn-devel@lists.sourceforge.net>; Fri, 28 Aug 2026 12:35:17 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67SAZHJt013339
 for openvpn-devel@lists.sourceforge.net; Fri, 28 Aug 2026 12:35:17 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 12:35:11 +0200
Message-ID: <20260828103517.13327-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wztvg-0001TE-Fg
Subject: [Openvpn-devel] [PATCH v8] Add helper method to extract a field
 from a buffer
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

Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1855
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1855
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 046e231..5ce2e39 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1384,3 +1384,27 @@
     fclose(fp);
     return ret;
 }
+
+char *
+buf_extract_field(struct buffer *buf, char sep, struct gc_arena *gc)
+{
+    if (!buf_valid(buf))
+    {
+        return NULL;
+    }
+
+    const uint8_t *seppos = memchr(BPTR(buf), sep, buf_len(buf));
+    if (!seppos)
+    {
+        return NULL;
+    }
+    size_t field_len = seppos - BPTR(buf);
+
+    char *field = gc_malloc(field_len + 1, false, gc);
+
+    memcpy(field, BPTR(buf), field_len);
+    field[field_len] = 0;
+
+    buf_advance(buf, field_len + 1);
+    return field;
+}
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index bc5cffb..4471697 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -2243,4 +2243,14 @@
 /**@}*/
 /* End of Buffer Lists */
 
+/**
+ * Extract a field from buf that ends with the \c sep character. The
+ * returned string is allocated in the gc_arena. If the separator character
+ * is not found, the function returns the nullptr.
+ *
+ * The buffer is also forwarded to the point after the separator character.
+ */
+char *
+buf_extract_field(struct buffer *buf, char sep, struct gc_arena *gc);
+
 #endif /* BUFFER_H */
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index ce38bbe..7fb9162 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -456,6 +456,35 @@
     /* Check that our own method agrees */
     assert_true(string_check_buf(&buf2, CC_PRINT | CC_NULL, CC_CRLF));
     assert_string_equal(BSTR(&buf2), "CR_RESPONSE,MTIx");
+    gc_free(&gc);
+}
+
+static void
+test_buffer_extract_field(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(1000, &gc);
+    assert_null(buf_extract_field(&buf, ',', &gc));
+
+    buf = alloc_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);
+    const char *ret = buf_extract_field(&buf, '5', &gc);
+    assert_string_equal(ret, "1234");
+    /* nothing left after the 5 */
+    assert_int_equal(buf_len(&buf), 0);
+
+    buf = alloc_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);
+    ret = buf_extract_field(&buf, '4', &gc);
+    assert_string_equal(ret, "123");
+
+    /* 5 should be left */
+    assert_int_equal(buf_len(&buf), 1);
+    assert_memory_equal(buf_bptr(&buf), "5", 1);
+
+    buf = alloc_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);
+    assert_null(buf_extract_field(&buf, '6', &gc));
 
     gc_free(&gc);
 }
@@ -567,7 +596,8 @@
         cmocka_unit_test(test_checked_snprintf),
         cmocka_unit_test(test_buffer_chomp),
         cmocka_unit_test(test_buffer_null_terminate),
-        cmocka_unit_test(test_buffer_parse)
+        cmocka_unit_test(test_buffer_parse),
+        cmocka_unit_test(test_buffer_extract_field)
     };
 
     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
