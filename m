Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C5606A331
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TkK1ursT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gS7437uS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LWIgp+IT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9vUA7VedjLGjiAi2A9ZHxZFvVU4CzjZszwTnMk9F8RI=; b=TkK1ursTRccCxR
	WUv5fJS6zcoGt2GItYv+i4MUpAY28RXmzs3tTWZC7cpw92/FFSlZWcuWlsbPXZ+Wf0NEW6xF1jNF4
	T6RmLOpTeH0TfWFl6Iigz1+YUeOzWzIazt0wWlC99/aEOlBbUMsbVvvp1SBZWwZtutG2D0mdrhkWP
	Y4Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGMS-000000005J0-096z;
	Tue, 17 Nov 2026 10:24:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTGMQ-000000005Iu-3v4T for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:24:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NtecEGWRvPg5DzppZO8q/KYFvO6wHKOO6S5aA9hrDQA=; b=gS7437uSI4k9GSwc0drDqJZAi+
 IrQbntU4yVk/368tg/6aSXghRv/i1/3EXa34ZH9bJUEePvBF407NYBtxV3C6Ol740FL0rgoxjdhd+
 4e35u+HCKyOZhm/bIsORNk09YAmonpIhhEDpLv/9ETejmgUTIb6eBtHXMrpvSw+/Mx5Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NtecEGWRvPg5DzppZO8q/KYFvO6wHKOO6S5aA9hrDQA=; b=LWIgp+ITZB1ejpE9fv8Dn0sOHC
 scfUgRUFxqqapUgMzOci6R90IvQwoCSB+sBtmarKmsgb1M7I6mjXbdT2E7DPPIhzJqW2gHQVZ0Xtk
 3MMbE/LaWrxCXXl1H6kcK9PFO6WJvGe2K9scXPQpdmelN2yyEXVgz4CFyVupV9KDVu8o=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTGMP-000000006Fx-3p9H for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:24:22 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AHAOFQX031415
 for <openvpn-devel@lists.sourceforge.net>; Tue, 17 Nov 2026 11:24:15 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHAOFPA031414
 for openvpn-devel@lists.sourceforge.net; Tue, 17 Nov 2026 11:24:15 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 11:24:09 +0100
Message-ID: <20261117102414.31377-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
References: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTGMP-000000006Fx-3p9H
Subject: [Openvpn-devel] [PATCH v2] manage: Switch all sleep methods to
 unsigned
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

That is consistent with sleep(3).

Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2200
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2200
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index ae30930..86c498e 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3615,32 +3615,23 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 /*
  * Process the management event loop for sec seconds
  */
 void
-management_event_loop_n_seconds(struct management *man, int sec)
+management_event_loop_n_seconds(struct management *man, unsigned int sec)
 {
     if (man_standalone_ok(man))
     {
         volatile int signal_received = 0;
         const bool standalone_disabled_save = man->persist.standalone_disabled;
-        time_t expire = 0;
+        time_t expire = now + sec;
 
         /* This is so M_CLIENT messages will be correctly passed through msg() */
         man->persist.standalone_disabled = false;
 
         /* set expire time */
         update_time();
-        if (sec >= 0)
-        {
-            expire = now + sec;
-        }
 
         /* if no client connection, wait for one */
         man_wait_for_client_connection(man, &signal_received, expire, 0);
@@ -3662,7 +3653,7 @@
                 return;
             }
             update_time();
-        } while (expire && expire > now);
+        } while (expire > now);
 
         /* revert state */
         man->persist.standalone_disabled = standalone_disabled_save;
@@ -4026,7 +4017,7 @@
  * Return true if the caller should not sleep for an additional time interval.
  */
 bool
-management_hold(struct management *man, int holdtime)
+management_hold(struct management *man, unsigned int holdtime)
 {
     if (management_would_hold(man))
     {
@@ -4044,7 +4035,7 @@
         if (!signal_received)
         {
             struct buffer out = alloc_buf_gc(128, &gc);
-            buf_printf(&out, ">HOLD:Waiting for hold release:%d", holdtime);
+            buf_printf(&out, ">HOLD:Waiting for hold release:%u", holdtime);
             man->persist.special_state_msg = BSTR(&out);
             msg(M_CLIENT, "%s", man->persist.special_state_msg);
 
@@ -4244,8 +4235,9 @@
 log_history_obj_init(struct log_history *h, int capacity)
 {
     CLEAR(*h);
+    ASSERT(capacity > 0);
     h->capacity = capacity;
-    ALLOC_ARRAY_CLEAR(h->array, struct log_entry, capacity);
+    ALLOC_ARRAY_CLEAR(h->array, struct log_entry, (size_t)capacity);
 }
 
 struct log_history *
@@ -4332,34 +4324,6 @@
 }
 
 void
-management_sleep(const int n)
-{
-    if (n < 0)
-    {
-        return;
-    }
-    else if (management)
-    {
-        management_event_loop_n_seconds(management, n);
-    }
-    else
-    {
-#ifdef _WIN32
-        win32_sleep(n);
-#else
-        if (n > 0)
-        {
-            sleep(n);
-        }
-#endif
-    }
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
-void
 management_check_bytecount_client(struct context *c, struct management *man, struct timeval *timeval)
 {
     if (man->persist.callback.flags & MCF_SERVER)
@@ -4490,30 +4454,28 @@
     gc_free(&gc);
     return false;
 }
-#else /* ifdef ENABLE_MANAGEMENT */
+#endif /* ENABLE_MANAGEMENT */
 
 #include "win32.h"
 
-#if !defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void
-management_sleep(const int n)
+management_sleep(const unsigned int n)
 {
-#ifdef _WIN32
-    win32_sleep(n);
-#else
-    if (n > 0)
+#ifdef ENABLE_MANAGEMENT
+    if (management)
     {
-        sleep(n);
+        management_event_loop_n_seconds(management, n);
     }
-#endif /* ifdef _WIN32 */
-}
-
-#if !defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
-#pragma GCC diagnostic pop
+    else
 #endif
-
-#endif /* ENABLE_MANAGEMENT */
+    {
+#ifdef _WIN32
+        win32_sleep(n);
+#else
+        if (n > 0)
+        {
+            sleep(n);
+        }
+#endif
+    }
+}
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 82c0caa..697f830 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -387,9 +387,9 @@
 
 bool management_would_hold(struct management *man);
 
-bool management_hold(struct management *man, int holdtime);
+bool management_hold(struct management *man, unsigned int holdtime);
 
-void management_event_loop_n_seconds(struct management *man, int sec);
+void management_event_loop_n_seconds(struct management *man, unsigned int sec);
 
 void management_up_down(const struct management *man, const char *updown, const struct env_set *es);
 
@@ -522,6 +522,6 @@
  * A sleep function that services the management layer for n seconds rather
  * than doing nothing.
  */
-void management_sleep(const int n);
+void management_sleep(const unsigned int n);
 
 #endif /* ifndef MANAGE_H */
diff --git a/src/openvpn/resolve.c b/src/openvpn/resolve.c
index b8d9899..544e5ea 100644
--- a/src/openvpn/resolve.c
+++ b/src/openvpn/resolve.c
@@ -161,13 +161,13 @@
     }
 
     status = getaddrinfo(hostname, servname, &hints, res);
-
-    if (status != 0)                      /* parse as numeric address failed? */
+    /* parse as numeric address failed? */
+    if (status != 0)
     {
-        const int fail_wait_interval = 5; /* seconds */
+        const unsigned int fail_wait_interval = 5; /* seconds */
         /* Add +4 to cause integer division rounding up (1 + 4) = 5, (0+4)/5=0 */
         int resolve_retries =
-            (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);
+            (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / (int)fail_wait_interval);
         const char *fmt;
         msglvl_t level = 0;
 
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 079869f..f10c16d 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1533,13 +1533,8 @@
 }
 
 void
-win32_sleep(const int n)
+win32_sleep(const unsigned int n)
 {
-    if (n < 0)
-    {
-        return;
-    }
-
     /* Sleep() is not interruptible. Use a WAIT_OBJECT to catch signal */
 
     if (!HANDLE_DEFINED(win32_signal.in.read))
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 39ff7d8..8152e71 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -323,7 +323,7 @@
 int openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags);
 
 /* Sleep that can be interrupted by signals and exit event */
-void win32_sleep(const int n);
+void win32_sleep(const unsigned int n);
 
 /**
  * @brief Fetches a registry value for OpenVPN registry key.
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/openvpn/mock_management.c
index f572dbb..aea43da 100644
--- a/tests/unit_tests/openvpn/mock_management.c
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -59,6 +59,6 @@
 #endif
 
 void
-management_sleep(const int n)
+management_sleep(const unsigned int n)
 {
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
