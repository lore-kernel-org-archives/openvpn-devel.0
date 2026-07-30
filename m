Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B407EC54FDF
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=naVaPBXNLSw4YKUJjQgFeYjV7OlJItpUXcKZ9oN4t54=; b=LKj9YLQcIFOWB0+51/zEVg74iy
	2il6yCHpEBg/eV83kPOWcUGBo18oVZjdxSHNm34lq+DlEgopbiaqPC+qIDVEAi7BbrbQOYLz+He6D
	6rsPJ2ZEjgjKrGf6fdiaNKcrPKPkv2puJzJdti6xfTzdjXv8sizIYTAx1KiVisDTZgqE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpNoV-0000n0-AG;
	Thu, 30 Jul 2026 10:16:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wpNoS-0000mc-9T
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UAC/dN4qC+zz1dZ1VCdalM+r7vz0Z9Atxpw+pUhi5Vs=; b=BczD2BIpKy/SQ+iKHWHUz7rbPh
 J5FgdgoRgDf2HuQOpYbD+QNzF08OgeQEMeCPQFb5F7vdV2770wxesGXkXRXj+onXsSItbpFBTo/YZ
 3RFw73bBTdoXzpehIhrwMcTHCkrH+a9T0zOpKu/D0DmsvWvp3aNkKmvVyYk9MkBzZ7rg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UAC/dN4qC+zz1dZ1VCdalM+r7vz0Z9Atxpw+pUhi5Vs=; b=Wl/0uFtDPWuL50Xg4285d5tZg7
 hRw4wl14GB1M7IgHCl6qtKww5WsyocBQpU+yndOOZF42Y/+7qO4mYJuhw5PERwc4ctNJnHESK3pfn
 YaHaDNIoKqraiQDT8VqU49Eyo1kuR3Q/griS8t23soVNZTce0wt4NOmkAorG0LQMltUw=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpNoT-0003l8-CK for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:16:29 +0000
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h9lTs5QTVzKvyx;
 Thu, 30 Jul 2026 12:16:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1785406577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAC/dN4qC+zz1dZ1VCdalM+r7vz0Z9Atxpw+pUhi5Vs=;
 b=c53PcR8qGVQZL56XqKlroBJIXbdUzvYjZFj6LwfZsNKsFCLG/DjJrE3lqjd4MiS1YkSXlo
 xBV4ZrQoPAqgJ/1q4POqqh0XhlLKlXk132Xq1We8un/7qO34pJ8KpPt4KBE5J1xzfcwGN1
 DG+d/38lfvIfDC4pz43c6YUg18IY+u1ttInNrWa01MCC1UZoxwaT2wE44N1UvLXJ61FX0r
 B8vo6JjPafEHBMM/Uv1eDWcJhzRydcnMTPSr+DKrvj28pB3kQN6X8upKrNgO27Ho+tskWn
 trf4Q13QsR0N1OWaUSPcmpRNeaRVQK3KgcGQFqlwOVWEpMU8TJnq/zvQqqzh/Q==
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 30 Jul 2026 12:16:16 +0200
Message-ID: <20260730101616.28738-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wpNoT-0003l8-CK
Subject: [Openvpn-devel] [PATCH v5] Move schedule test to a unit test
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

While this test might not be extremely useful this change removes
the dead code from init.c and schedule.c and moves it to a unit
test.

Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1828
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1828
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7473f15..74c080e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -828,10 +828,14 @@
 
     target_sources(test_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
+        tests/unit_tests/openvpn/test_schedule.c
         src/openvpn/options_util.c
+        src/openvpn/otime.c
         src/openvpn/ssl_util.c
         src/openvpn/list.c
-        )
+        src/openvpn/session_id.c
+        src/openvpn/schedule.c
+    )
 
     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch.c
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 914d191..0236886 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -53,6 +53,7 @@
 #include "mudp.h"
 #include "dco.h"
 #include "tun_afunix.h"
+#include "schedule.h"
 
 #include "memdbg.h"
 
@@ -876,11 +877,6 @@
 
     init_ssl_lib();
 
-#ifdef SCHEDULE_TEST
-    schedule_test();
-    return false;
-#endif
-
 #ifdef IFCONFIG_POOL_TEST
     ifconfig_pool_test(0x0A010004, 0x0A0100FF);
     return false;
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index ad79120..f02cc31 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -150,80 +150,6 @@
     }
 }
 
-static inline bool
-tv_lt(const struct timeval *t1, const struct timeval *t2)
-{
-    if (t1->tv_sec < t2->tv_sec)
-    {
-        return true;
-    }
-    else if (t1->tv_sec > t2->tv_sec)
-    {
-        return false;
-    }
-    else
-    {
-        return t1->tv_usec < t2->tv_usec;
-    }
-}
-
-static inline bool
-tv_le(const struct timeval *t1, const struct timeval *t2)
-{
-    if (t1->tv_sec < t2->tv_sec)
-    {
-        return true;
-    }
-    else if (t1->tv_sec > t2->tv_sec)
-    {
-        return false;
-    }
-    else
-    {
-        return t1->tv_usec <= t2->tv_usec;
-    }
-}
-
-static inline bool
-tv_ge(const struct timeval *t1, const struct timeval *t2)
-{
-    if (t1->tv_sec > t2->tv_sec)
-    {
-        return true;
-    }
-    else if (t1->tv_sec < t2->tv_sec)
-    {
-        return false;
-    }
-    else
-    {
-        return t1->tv_usec >= t2->tv_usec;
-    }
-}
-
-static inline bool
-tv_gt(const struct timeval *t1, const struct timeval *t2)
-{
-    if (t1->tv_sec > t2->tv_sec)
-    {
-        return true;
-    }
-    else if (t1->tv_sec < t2->tv_sec)
-    {
-        return false;
-    }
-    else
-    {
-        return t1->tv_usec > t2->tv_usec;
-    }
-}
-
-static inline bool
-tv_eq(const struct timeval *t1, const struct timeval *t2)
-{
-    return t1->tv_sec == t2->tv_sec && t1->tv_usec == t2->tv_usec;
-}
-
 static inline void
 tv_delta(struct timeval *dest, const struct timeval *t1, const struct timeval *t2)
 {
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 6d9bb62..6772ad6 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -33,20 +33,6 @@
 
 #include "memdbg.h"
 
-#ifdef SCHEDULE_TEST
-
-struct status
-{
-    int sru;
-    int ins;
-    int coll;
-    int lsteps;
-};
-
-static struct status z;
-
-#endif
-
 #ifdef ENABLE_DEBUG
 static void
 schedule_entry_debug_info(const char *caller, const struct schedule_entry *e)
@@ -75,12 +61,7 @@
     }
 }
 
-/* This is the master key comparison routine.  A key is
- * simply a struct timeval containing the absolute time for
- * an event.  The unique treap priority (pri) is used to ensure
- * that keys do not collide.
- */
-static inline int
+int
 schedule_entry_compare(const struct schedule_entry *e1, const struct schedule_entry *e2)
 {
     if (e1->tv.tv_sec < e2->tv.tv_sec)
@@ -226,10 +207,6 @@
             /* parent <-> child linkage is corrupted */
             ASSERT(0);
         }
-
-#ifdef SCHEDULE_TEST
-        ++z.sru;
-#endif
     }
 }
 
@@ -284,10 +261,6 @@
     {
         const int comp = schedule_entry_compare(e, c);
 
-#ifdef SCHEDULE_TEST
-        ++z.ins;
-#endif
-
         if (comp == -1)
         {
             if (c->lt)
@@ -320,9 +293,6 @@
         {
             /* rare key/priority collision -- no big deal,
              * just choose another priority and retry */
-#ifdef SCHEDULE_TEST
-            ++z.coll;
-#endif
             schedule_set_pri(e);
             /* msg (M_INFO, "PRI COLLISION pri=%u", e->pri); */
             c = s->root;
@@ -381,9 +351,6 @@
     {
         while (e->lt)
         {
-#ifdef SCHEDULE_TEST
-            ++z.lsteps;
-#endif
             e = e->lt;
         }
     }
@@ -422,280 +389,4 @@
 {
     s->earliest_wakeup = NULL; /* invalidate cache */
     schedule_remove_node(s, e);
-}
-
-/*
- *  Debug functions below this point
- */
-
-#ifdef SCHEDULE_TEST
-
-static inline struct schedule_entry *
-schedule_find_earliest_wakeup(struct schedule *s)
-{
-    return schedule_find_least(s->root);
-}
-
-/*
- * Recursively check that the treap (btree) is
- * internally consistent.
- */
-int
-schedule_debug_entry(const struct schedule_entry *e, int depth, int *count, struct timeval *least,
-                     const struct timeval *min, const struct timeval *max)
-{
-    struct gc_arena gc = gc_new();
-    int maxdepth = depth;
-    if (e)
-    {
-        int d;
-
-        ASSERT(e != e->lt);
-        ASSERT(e != e->gt);
-        ASSERT(e != e->parent);
-        ASSERT(!e->parent || e->parent != e->lt);
-        ASSERT(!e->parent || e->parent != e->gt);
-        ASSERT(!e->lt || e->lt != e->gt);
-
-        if (e->lt)
-        {
-            ASSERT(e->lt->parent == e);
-            ASSERT(schedule_entry_compare(e->lt, e) == -1);
-            ASSERT(e->lt->pri >= e->pri);
-        }
-
-        if (e->gt)
-        {
-            ASSERT(e->gt->parent == e);
-            ASSERT(schedule_entry_compare(e->gt, e));
-            ASSERT(e->gt->pri >= e->pri);
-        }
-
-        ASSERT(tv_le(min, &e->tv));
-        ASSERT(tv_le(&e->tv, max));
-
-        if (count)
-        {
-            ++(*count);
-        }
-
-        if (least && tv_lt(&e->tv, least))
-        {
-            *least = e->tv;
-        }
-
-        d = schedule_debug_entry(e->lt, depth + 1, count, least, min, &e->tv);
-        if (d > maxdepth)
-        {
-            maxdepth = d;
-        }
-
-        d = schedule_debug_entry(e->gt, depth + 1, count, least, &e->tv, max);
-        if (d > maxdepth)
-        {
-            maxdepth = d;
-        }
-    }
-    gc_free(&gc);
-    return maxdepth;
-}
-
-int
-schedule_debug(struct schedule *s, int *count, struct timeval *least)
-{
-    struct timeval min;
-    struct timeval max;
-
-    min.tv_sec = 0;
-    min.tv_usec = 0;
-    max.tv_sec = 0x7FFFFFFF;
-    max.tv_usec = 0x7FFFFFFF;
-
-    if (s->root)
-    {
-        ASSERT(s->root->parent == NULL);
-    }
-    return schedule_debug_entry(s->root, 0, count, least, &min, &max);
-}
-
-#if 1
-
-void
-tv_randomize(struct timeval *tv)
-{
-    tv->tv_sec += random() % 100;
-    tv->tv_usec = random() % 100;
-}
-
-#else  /* if 1 */
-
-void
-tv_randomize(struct timeval *tv)
-{
-    struct gc_arena gc = gc_new();
-    long int choice = get_random();
-    if ((choice & 0xFF) == 0)
-    {
-        tv->tv_usec += ((choice >> 8) & 0xFF);
-    }
-    else
-    {
-        prng_bytes((uint8_t *)tv, sizeof(struct timeval));
-    }
-    gc_free(&gc);
-}
-
-#endif /* if 1 */
-
-void
-schedule_verify(struct schedule *s)
-{
-    struct gc_arena gc = gc_new();
-    struct timeval least;
-    int count;
-    int maxlev;
-    struct schedule_entry *e;
-    const struct status zz = z;
-
-    least.tv_sec = least.tv_usec = 0x7FFFFFFF;
-
-    count = 0;
-
-    maxlev = schedule_debug(s, &count, &least);
-
-    e = schedule_find_earliest_wakeup(s);
-
-    if (e)
-    {
-        printf("Verification Phase  count=%d maxlev=%d sru=%d ins=%d coll=%d ls=%d l=%s", count,
-               maxlev, zz.sru, zz.ins, zz.coll, zz.lsteps, tv_string(&e->tv, &gc));
-
-        if (!tv_eq(&least, &e->tv))
-        {
-            printf(" [COMPUTED DIFFERENT MIN VALUES!]");
-        }
-
-        printf("\n");
-    }
-
-    CLEAR(z);
-    gc_free(&gc);
-}
-
-void
-schedule_randomize_array(struct schedule_entry **array, int size)
-{
-    int i;
-    for (i = 0; i < size; ++i)
-    {
-        const int src = get_random() % size;
-        struct schedule_entry *tmp = array[i];
-        if (i != src)
-        {
-            array[i] = array[src];
-            array[src] = tmp;
-        }
-    }
-}
-
-void
-schedule_print_work(struct schedule_entry *e, int indent)
-{
-    struct gc_arena gc = gc_new();
-    int i;
-    for (i = 0; i < indent; ++i)
-    {
-        printf(" ");
-    }
-    if (e)
-    {
-        printf("%s [%u] e=" ptr_format ", p=" ptr_format " lt=" ptr_format " gt=" ptr_format "\n",
-               tv_string(&e->tv, &gc), e->pri, (ptr_type)e, (ptr_type)e->parent, (ptr_type)e->lt,
-               (ptr_type)e->gt);
-        schedule_print_work(e->lt, indent + 1);
-        schedule_print_work(e->gt, indent + 1);
-    }
-    else
-    {
-        printf("NULL\n");
-    }
-    gc_free(&gc);
-}
-
-void
-schedule_print(struct schedule *s)
-{
-    printf("*************************\n");
-    schedule_print_work(s->root, 0);
-}
-
-void
-schedule_test(void)
-{
-    struct gc_arena gc = gc_new();
-    int n = 1000;
-    int n_mod = 25;
-
-    int i, j;
-    struct schedule_entry **array;
-    struct schedule *s = schedule_init();
-    struct schedule_entry *e;
-
-    CLEAR(z);
-    ALLOC_ARRAY(array, struct schedule_entry *, n);
-
-    printf("Creation/Insertion Phase\n");
-
-    for (i = 0; i < n; ++i)
-    {
-        ALLOC_OBJ_CLEAR(array[i], struct schedule_entry);
-        tv_randomize(&array[i]->tv);
-        /*schedule_print (s);*/
-        /*schedule_verify (s);*/
-        schedule_add_modify(s, array[i]);
-    }
-
-    schedule_randomize_array(array, n);
-
-    /*schedule_print (s);*/
-    schedule_verify(s);
-
-    for (j = 1; j <= n_mod; ++j)
-    {
-        printf("Modification Phase Pass %d\n", j);
-
-        for (i = 0; i < n; ++i)
-        {
-            e = schedule_find_earliest_wakeup(s);
-            /*printf ("BEFORE %s\n", tv_string (&e->tv, &gc));*/
-            tv_randomize(&e->tv);
-            /*printf ("AFTER %s\n", tv_string (&e->tv, &gc));*/
-            schedule_add_modify(s, e);
-            /*schedule_verify (s);*/
-            /*schedule_print (s);*/
-        }
-        schedule_verify(s);
-        /*schedule_print (s);*/
-    }
-
-    /*printf ("INS=%d\n", z.ins);*/
-
-    while ((e = schedule_find_earliest_wakeup(s)))
-    {
-        schedule_remove_node(s, e);
-        /*schedule_verify (s);*/
-    }
-    schedule_verify(s);
-
-    printf("S->ROOT is %s\n", s->root ? "NOT NULL" : "NULL");
-
-    for (i = 0; i < n; ++i)
-    {
-        free(array[i]);
-    }
-    free(array);
-    free(s);
-    gc_free(&gc);
-}
-
-#endif /* ifdef SCHEDULE_TEST */
+}
\ No newline at end of file
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index 3847186..3c93208 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -34,9 +34,6 @@
  * a ping or scheduling a TLS renegotiation.
  */
 
-/* define to enable a special test mode */
-/*#define SCHEDULE_TEST*/
-
 #include "otime.h"
 #include "error.h"
 
@@ -63,11 +60,6 @@
 
 void schedule_remove_entry(struct schedule *s, struct schedule_entry *e);
 
-#ifdef SCHEDULE_TEST
-void schedule_test(void);
-
-#endif
-
 /* Private Functions */
 
 /* is node already in tree? */
@@ -139,4 +131,14 @@
     return ret;
 }
 
+/**
+ * This method compares two schedule entries and return which one is
+ * earlier,later or equal.
+ *
+ * A key is simply a struct timeval containing the absolute time for
+ * an event.  The unique treap priority (pri) is used to ensure
+ * that keys do not collide.
+ */
+int
+schedule_entry_compare(const struct schedule_entry *e1, const struct schedule_entry *e2);
 #endif /* ifndef SCHEDULE_H */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index d861ef9..4a76269 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -370,6 +370,7 @@
 misc_testdriver_LDFLAGS = @TEST_LDFLAGS@
 
 misc_testdriver_SOURCES = test_misc.c \
+	test_schedule.c test_schedule.h \
 	mock_msg.c test_common.h  \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -377,7 +378,9 @@
 	$(top_srcdir)/src/openvpn/ssl_util.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c \
-	$(top_srcdir)/src/openvpn/list.c
+	$(top_srcdir)/src/openvpn/list.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/schedule.c
 
 push_update_msg_testdriver_CFLAGS = -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h
index fb070aa..8db4ea6 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -78,7 +78,7 @@
  * @param filename      name of the filename to retrieve relative to the
  *                      unit test source directory
  */
-void
+static inline void
 openvpn_test_get_srcdir_dir(char *buf, size_t bufsize, const char *filename)
 {
     const char *srcdir = getenv("srcdir");
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index fc9840a..cd86fd2 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -41,6 +41,8 @@
 #ifdef _WIN32
 #include "win32-util.h"
 #endif
+#include "test_schedule.h"
+
 
 static void
 test_compat_lzo_string(void **state)
@@ -488,7 +490,8 @@
     cmocka_unit_test(test_auth_fail_temp_flags),
     cmocka_unit_test(test_auth_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
-    cmocka_unit_test(test_atoi_variants)
+    cmocka_unit_test(test_atoi_variants),
+    cmocka_unit_test(schedule_test)
 };
 
 int
diff --git a/tests/unit_tests/openvpn/test_schedule.c b/tests/unit_tests/openvpn/test_schedule.c
new file mode 100644
index 0000000..52cd415
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_schedule.c
@@ -0,0 +1,310 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+#include "schedule.h"
+#include "test_common.h"
+
+static inline bool
+tv_lt(const struct timeval *t1, const struct timeval *t2)
+{
+    if (t1->tv_sec < t2->tv_sec)
+    {
+        return true;
+    }
+    else if (t1->tv_sec > t2->tv_sec)
+    {
+        return false;
+    }
+    else
+    {
+        return t1->tv_usec < t2->tv_usec;
+    }
+}
+
+static inline bool
+tv_le(const struct timeval *t1, const struct timeval *t2)
+{
+    if (t1->tv_sec < t2->tv_sec)
+    {
+        return true;
+    }
+    else if (t1->tv_sec > t2->tv_sec)
+    {
+        return false;
+    }
+    else
+    {
+        return t1->tv_usec <= t2->tv_usec;
+    }
+}
+
+static inline bool
+tv_eq(const struct timeval *t1, const struct timeval *t2)
+{
+    return t1->tv_sec == t2->tv_sec && t1->tv_usec == t2->tv_usec;
+}
+
+static inline struct schedule_entry *
+schedule_find_earliest_wakeup(struct schedule *s)
+{
+    return schedule_find_least(s->root);
+}
+
+/*
+ * Recursively check that the treap (btree) is
+ * internally consistent.
+ */
+int
+schedule_debug_entry(const struct schedule_entry *e, int depth, int *count, struct timeval *least,
+                     const struct timeval *min, const struct timeval *max)
+{
+    struct gc_arena gc = gc_new();
+    int maxdepth = depth;
+    if (e)
+    {
+        int d;
+
+        assert_ptr_not_equal(e, e->lt);
+        assert_ptr_not_equal(e, e->gt);
+        assert_ptr_not_equal(e, e->parent);
+        assert_true(!e->parent || e->parent != e->lt);
+        assert_true(!e->parent || e->parent != e->gt);
+        assert_true(!e->lt || e->lt != e->gt);
+
+        if (e->lt)
+        {
+            assert_ptr_equal(e->lt->parent, e);
+            assert_int_equal(schedule_entry_compare(e->lt, e), -1);
+            assert_true(e->lt->pri >= e->pri);
+        }
+
+        if (e->gt)
+        {
+            assert_ptr_equal(e->gt->parent, e);
+            assert_int_equal(schedule_entry_compare(e->gt, e), 1);
+            assert_true(e->gt->pri >= e->pri);
+        }
+
+        assert_true(tv_le(min, &e->tv));
+        assert_true(tv_le(&e->tv, max));
+
+        if (count)
+        {
+            ++(*count);
+        }
+
+        if (least && tv_lt(&e->tv, least))
+        {
+            *least = e->tv;
+        }
+
+        d = schedule_debug_entry(e->lt, depth + 1, count, least, min, &e->tv);
+        if (d > maxdepth)
+        {
+            maxdepth = d;
+        }
+
+        d = schedule_debug_entry(e->gt, depth + 1, count, least, &e->tv, max);
+        if (d > maxdepth)
+        {
+            maxdepth = d;
+        }
+    }
+    gc_free(&gc);
+    return maxdepth;
+}
+
+int
+schedule_debug(struct schedule *s, int *count, struct timeval *least)
+{
+    struct timeval min;
+    struct timeval max;
+
+    min.tv_sec = 0;
+    min.tv_usec = 0;
+    max.tv_sec = 0x7FFFFFFF;
+    max.tv_usec = 0x7FFFFFFF;
+
+    if (s->root)
+    {
+        assert_null(s->root->parent);
+    }
+    return schedule_debug_entry(s->root, 0, count, least, &min, &max);
+}
+
+void
+tv_randomize(struct timeval *tv)
+{
+    tv->tv_sec += random() % 100;
+    tv->tv_usec = random() % 100;
+}
+
+void
+schedule_verify(struct schedule *s, int n)
+{
+    struct gc_arena gc = gc_new();
+    struct timeval least;
+
+    least.tv_sec = least.tv_usec = 0x7FFFFFFF;
+
+    int count = 0;
+    int maxlev = schedule_debug(s, &count, &least);
+
+    /* a stupid algorithm to do C23 stdc_bit_ceil_ui/stdc_bit_width
+     * calculate roundup(log2 n) */
+    int bit_ceil_n = 1;
+    int log2n = 0;
+    while (bit_ceil_n < n)
+    {
+        bit_ceil_n <<= 1;
+        log2n++;
+    }
+
+    /* Since this is a binary tree the maximum level needs to be at least
+     * log2(n) */
+    assert_true(maxlev >= log2n);
+    struct schedule_entry *e = schedule_find_earliest_wakeup(s);
+
+    if (e)
+    {
+        assert_true(tv_eq(&least, &e->tv));
+    }
+
+    gc_free(&gc);
+}
+
+void
+schedule_randomize_array(struct schedule_entry **array, int size)
+{
+    int i;
+    for (i = 0; i < size; ++i)
+    {
+        const int src = rand() % size;
+        struct schedule_entry *tmp = array[i];
+        if (i != src)
+        {
+            array[i] = array[src];
+            array[src] = tmp;
+        }
+    }
+}
+
+void
+schedule_print_work(struct schedule_entry *e, int indent)
+{
+    struct gc_arena gc = gc_new();
+    int i;
+    for (i = 0; i < indent; ++i)
+    {
+        printf(" ");
+    }
+    if (e)
+    {
+        printf("%s [%u] e=" ptr_format ", p=" ptr_format " lt=" ptr_format " gt=" ptr_format "\n",
+               tv_string(&e->tv, &gc), e->pri, (ptr_type)e, (ptr_type)e->parent, (ptr_type)e->lt,
+               (ptr_type)e->gt);
+        schedule_print_work(e->lt, indent + 1);
+        schedule_print_work(e->gt, indent + 1);
+    }
+    else
+    {
+        printf("NULL\n");
+    }
+    gc_free(&gc);
+}
+
+void
+schedule_print(struct schedule *s)
+{
+    printf("*************************\n");
+    schedule_print_work(s->root, 0);
+}
+
+void
+schedule_test(void **state)
+{
+    struct gc_arena gc = gc_new();
+    int n = 1000;
+    int n_mod = 25;
+
+    int i, j;
+    struct schedule_entry **array;
+    struct schedule *s = schedule_init();
+    struct schedule_entry *e;
+
+    ALLOC_ARRAY(array, struct schedule_entry *, n);
+
+    for (i = 0; i < n; ++i)
+    {
+        ALLOC_OBJ_CLEAR(array[i], struct schedule_entry);
+        tv_randomize(&array[i]->tv);
+        /*schedule_print (s);*/
+        /*schedule_verify (s, n);*/
+        schedule_add_modify(s, array[i]);
+    }
+
+    schedule_randomize_array(array, n);
+
+    /*schedule_print (s);*/
+    schedule_verify(s, n);
+
+    for (j = 1; j <= n_mod; ++j)
+    {
+        /*printf("Modification Phase Pass %d\n", j);*/
+
+        for (i = 0; i < n; ++i)
+        {
+            e = schedule_find_earliest_wakeup(s);
+            /*printf ("BEFORE %s\n", tv_string (&e->tv, &gc));*/
+            tv_randomize(&e->tv);
+            /*printf ("AFTER %s\n", tv_string (&e->tv, &gc));*/
+            schedule_add_modify(s, e);
+            /*schedule_verify (s, n);*/
+            /*schedule_print (s);*/
+        }
+        schedule_verify(s, n);
+        /*schedule_print (s);*/
+    }
+
+    /*printf ("INS=%d\n", z.ins);*/
+
+    while ((e = schedule_find_earliest_wakeup(s)))
+    {
+        schedule_remove_node(s, e);
+        /*schedule_verify (s, n);*/
+    }
+    schedule_verify(s, 0);
+    assert_null(s->root);
+
+    for (i = 0; i < n; ++i)
+    {
+        free(array[i]);
+    }
+    free(array);
+    schedule_free(s);
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_schedule.h b/tests/unit_tests/openvpn/test_schedule.h
new file mode 100644
index 0000000..55dc591
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_schedule.h
@@ -0,0 +1,27 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+#ifndef SCHEDULE_TEST_H
+#define SCHEDULE_TEST_H
+/** Runs the schedule test */
+void
+schedule_test(void **state);
+#endif
\ No newline at end of file


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
