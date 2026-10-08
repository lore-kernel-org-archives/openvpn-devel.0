Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5775CA600D
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aRAqbStrtvoLP9oHgMGNcm4pktWhkWKg2y3ivvomqw8=; b=lWdfkzoIvJB5K9etphfg5pQiic
	VSChuTwxIc1WDzsPxkvfxAw7jfaLOrLDL0UKeuIuI7o+VxCndYYBFrDc/SuqXIH1QlwoOEXxMr3qA
	1pFGFiusVvw3ZQTG/K3QD31qTwM9O1H8qWCguopJz9H4IuNwChdpT3onpWQWQKMa0ThU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEqkw-0007DA-8M;
	Thu, 08 Oct 2026 16:14:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xEqkd-0007BG-Il
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 16:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VpzcID78sXHC9qEMzclyMZJ6VfHIgVDkezNV4p1gcYE=; b=GHZdCQ+x3GyTVv7cVe0AeUC7JK
 U5g8rIbWZavUnGowEb+VWfygFtWb7QfFzpu4BTLuPSVXfoY6dAP+p+2nvFtOXPIwV1hakXdKiB+0z
 VZC41Jd8JQa02lVRuxdN1VbokDV8hTRW+GCT66AzwMPyuzSQmL5Q4XiELf8qg4v/G+BY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VpzcID78sXHC9qEMzclyMZJ6VfHIgVDkezNV4p1gcYE=; b=NZtE2VThCm6k+MJVUKsFBJI5Xt
 LaA6XOHE1uo10QAX3WLm+VbE+XIlcCDTmXj1LQcp9+Imv44m//ecDHKaJMIU/sMKJ+NpqfGZfb1WI
 iCvfxZK9dngV3rxF18hc74NEbvUgXPX8LCFiTeHM+9ENXAHK5p3kaM3I99PSyvoI0dIg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEqkT-0006yS-I7 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 16:13:39 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 698GDUXM032325
 for <openvpn-devel@lists.sourceforge.net>; Thu, 8 Oct 2026 18:13:30 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 698GDUqY032324
 for openvpn-devel@lists.sourceforge.net; Thu, 8 Oct 2026 18:13:30 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  8 Oct 2026 18:13:24 +0200
Message-ID: <20261008161329.32304-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
References: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xEqkT-0006yS-I7
Subject: [Openvpn-devel] [PATCH v2] buffer: Clean up rm_trailing_chars
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

This is very weird code. We re-run strlen for
every char that we delete, even though we actually
know which char to test next. Avoid this.

Also add unit tests to make sure I did not break it.

Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1987
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1987
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 8f558b1..a90ddae 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -592,21 +592,11 @@
 void
 rm_trailing_chars(char *str, const char *what_to_delete)
 {
-    bool modified;
-    do
+    size_t len = strlen(str);
+    while (len > 0 && strchr(what_to_delete, str[len - 1]) != NULL)
     {
-        const size_t len = strlen(str);
-        modified = false;
-        if (len > 0)
-        {
-            char *cp = str + (len - 1);
-            if (strchr(what_to_delete, *cp) != NULL)
-            {
-                *cp = '\0';
-                modified = true;
-            }
-        }
-    } while (modified);
+        str[--len] = '\0';
+    }
 }
 
 /*
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 2945e8a..bf486e0 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -435,6 +435,44 @@
 }
 
 void
+test_string_chomp(void **state)
+{
+    char string[10];
+
+    strcpy(string, "Foo\n");
+    chomp(string);
+    assert_string_equal(string, "Foo");
+
+    strcpy(string, "Foo\r\n\n\r");
+    chomp(string);
+    assert_string_equal(string, "Foo");
+
+    strcpy(string, "Foo");
+    chomp(string);
+    assert_string_equal(string, "Foo");
+
+    strcpy(string, "F\ro\no");
+    chomp(string);
+    assert_string_equal(string, "F\ro\no");
+
+    string[2] = '\0';
+    chomp(string);
+    assert_string_equal(string, "F");
+
+    strcpy(string, "");
+    chomp(string);
+    assert_string_equal(string, "");
+
+    strcpy(string, "Foo");
+    rm_trailing_chars(string, "o");
+    assert_string_equal(string, "F");
+
+    strcpy(string, "Foo");
+    rm_trailing_chars(string, "oF");
+    assert_string_equal(string, "");
+}
+
+void
 test_buffer_chomp(void **state)
 {
     struct gc_arena gc = gc_new();
@@ -616,6 +654,7 @@
         cmocka_unit_test(test_character_string_mod_buf),
         cmocka_unit_test(test_snprintf),
         cmocka_unit_test(test_checked_snprintf),
+        cmocka_unit_test(test_string_chomp),
         cmocka_unit_test(test_buffer_chomp),
         cmocka_unit_test(test_buffer_null_terminate),
         cmocka_unit_test(test_buffer_null_predicates),


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
