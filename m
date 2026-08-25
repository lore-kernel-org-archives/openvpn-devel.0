Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25898C61DBC
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6GXivQ4b++m/3E1EhzYOllToIXr48GAQOwJ4xhdZ1Bs=; b=HCrbn2JDZKmrxUvvUFYJA4lhJJ
	pTnoUQew9Fv28skkTRerIqWht6Jp4DQQs6BlxMCYplIHZBg0SuYGrDorn2iW1jCPJQwYnHeU13yyU
	D6moyEiw6QTd68TNw+CRKUJbQmH2qYd8vmmO1EaInFWxiEUDVGUvx4iJG2Zhrz6AAbTo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyuMu-0000ji-Ob;
	Tue, 25 Aug 2026 16:51:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wyuMt-0000jb-Or
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 16:51:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9E1Qosj3QFrnxt0HZ+HJvcxbouYtCQNSdGeNsPi7Qmo=; b=DiWJOBqEBP8o4ghnV62BYfIuvw
 YNoDOc/I23owxwhljImTFpn/evF4JqTuxCIltYDP8emMWC+IaOsFOXQo38NJHEdWXJeCTv6wa8r/F
 XAcC8sL3hmejvC8z+sZrjGr5NM4ABBxtXhAbqnf7sH0zmHHVrvqEjGNSUFNgXpY/9keY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9E1Qosj3QFrnxt0HZ+HJvcxbouYtCQNSdGeNsPi7Qmo=; b=TOo4qQRzGQrvef5EEyBYSzP+8v
 7iHPD2DMkyL9InrCp/22Q7tcgLSbpKzA9Mz9Z8ZQ6ikHIzCrpARq5f9Dd0ULo7XIzWdmckXZKnTwp
 U6mRqyPKqLmK4a8F4DZFT3CJrhg5GQPfvDQpUkXAkKKIqp4CxxhNJRS8Y6GBCpbTjf2s=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyuMt-0004FP-K2 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 16:51:24 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67PGpH75009945
 for <openvpn-devel@lists.sourceforge.net>; Tue, 25 Aug 2026 18:51:17 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67PGpHWE009943
 for openvpn-devel@lists.sourceforge.net; Tue, 25 Aug 2026 18:51:17 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 25 Aug 2026 18:51:09 +0200
Message-ID: <20260825165116.9908-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787672720000.I6123c33b1434d77a0bc33dd5ef28da643d086b4b@gerrit.openvpn.net>
References: <gerrit.1787672720000.I6123c33b1434d77a0bc33dd5ef28da643d086b4b@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wyuMt-0004FP-K2
Subject: [Openvpn-devel] [PATCH v1] test_schedule: Make all the counting
 variables unsigned
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

cppcheck reported that "bit_ceil_n <<= 1" is
potentially undefined behavior if bit_ceil_n is
signed. Making it unsigned caused a ripple whereby
all counts became unsigned to avoid weird casts.

Change-Id: I6123c33b1434d77a0bc33dd5ef28da643d086b4b
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1870
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1870
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 8736c2f..59262160f 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -114,8 +114,6 @@
 # IGN: We reuse the same variable name due to macro usage
 shadowVariable:src/openvpn/options.c:1948
 shadowVariable:src/openvpn/options.c:1966
-# IGN: sure this is theoretically undefined, but works
-shiftNegativeLHS:tests/unit_tests/openvpn/test_schedule.c:183
 # FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused
 syntaxError:tests/unit_tests/openvpn/test_tls_crypt.c:684
 # FP: this file is never compiled on _WIN32
diff --git a/tests/unit_tests/openvpn/test_schedule.c b/tests/unit_tests/openvpn/test_schedule.c
index 52cd415..2b53d28 100644
--- a/tests/unit_tests/openvpn/test_schedule.c
+++ b/tests/unit_tests/openvpn/test_schedule.c
@@ -78,15 +78,16 @@
  * Recursively check that the treap (btree) is
  * internally consistent.
  */
-int
-schedule_debug_entry(const struct schedule_entry *e, int depth, int *count, struct timeval *least,
+unsigned int
+schedule_debug_entry(const struct schedule_entry *e, unsigned int depth,
+                     unsigned int *count, struct timeval *least,
                      const struct timeval *min, const struct timeval *max)
 {
     struct gc_arena gc = gc_new();
-    int maxdepth = depth;
+    unsigned int maxdepth = depth;
     if (e)
     {
-        int d;
+        unsigned int d;
 
         assert_ptr_not_equal(e, e->lt);
         assert_ptr_not_equal(e, e->gt);
@@ -138,8 +139,8 @@
     return maxdepth;
 }
 
-int
-schedule_debug(struct schedule *s, int *count, struct timeval *least)
+unsigned int
+schedule_debug(struct schedule *s, unsigned int *count, struct timeval *least)
 {
     struct timeval min;
     struct timeval max;
@@ -164,20 +165,20 @@
 }
 
 void
-schedule_verify(struct schedule *s, int n)
+schedule_verify(struct schedule *s, unsigned int n)
 {
     struct gc_arena gc = gc_new();
     struct timeval least;
 
     least.tv_sec = least.tv_usec = 0x7FFFFFFF;
 
-    int count = 0;
-    int maxlev = schedule_debug(s, &count, &least);
+    unsigned int count = 0;
+    unsigned int maxlev = schedule_debug(s, &count, &least);
 
     /* a stupid algorithm to do C23 stdc_bit_ceil_ui/stdc_bit_width
      * calculate roundup(log2 n) */
-    int bit_ceil_n = 1;
-    int log2n = 0;
+    unsigned int bit_ceil_n = 1;
+    unsigned int log2n = 0;
     while (bit_ceil_n < n)
     {
         bit_ceil_n <<= 1;
@@ -198,12 +199,11 @@
 }
 
 void
-schedule_randomize_array(struct schedule_entry **array, int size)
+schedule_randomize_array(struct schedule_entry **array, unsigned int size)
 {
-    int i;
-    for (i = 0; i < size; ++i)
+    for (unsigned int i = 0; i < size; ++i)
     {
-        const int src = rand() % size;
+        const unsigned int src = (unsigned int)rand() % size;
         struct schedule_entry *tmp = array[i];
         if (i != src)
         {
@@ -214,11 +214,10 @@
 }
 
 void
-schedule_print_work(struct schedule_entry *e, int indent)
+schedule_print_work(struct schedule_entry *e, unsigned int indent)
 {
     struct gc_arena gc = gc_new();
-    int i;
-    for (i = 0; i < indent; ++i)
+    for (unsigned int i = 0; i < indent; ++i)
     {
         printf(" ");
     }
@@ -248,17 +247,16 @@
 schedule_test(void **state)
 {
     struct gc_arena gc = gc_new();
-    int n = 1000;
-    int n_mod = 25;
+    unsigned int n = 1000;
+    unsigned int n_mod = 25;
 
-    int i, j;
     struct schedule_entry **array;
     struct schedule *s = schedule_init();
     struct schedule_entry *e;
 
     ALLOC_ARRAY(array, struct schedule_entry *, n);
 
-    for (i = 0; i < n; ++i)
+    for (unsigned int i = 0; i < n; ++i)
     {
         ALLOC_OBJ_CLEAR(array[i], struct schedule_entry);
         tv_randomize(&array[i]->tv);
@@ -272,11 +270,11 @@
     /*schedule_print (s);*/
     schedule_verify(s, n);
 
-    for (j = 1; j <= n_mod; ++j)
+    for (unsigned int j = 1; j <= n_mod; ++j)
     {
         /*printf("Modification Phase Pass %d\n", j);*/
 
-        for (i = 0; i < n; ++i)
+        for (unsigned int i = 0; i < n; ++i)
         {
             e = schedule_find_earliest_wakeup(s);
             /*printf ("BEFORE %s\n", tv_string (&e->tv, &gc));*/
@@ -300,7 +298,7 @@
     schedule_verify(s, 0);
     assert_null(s->root);
 
-    for (i = 0; i < n; ++i)
+    for (unsigned int i = 0; i < n; ++i)
     {
         free(array[i]);
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
