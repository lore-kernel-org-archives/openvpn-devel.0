Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E36C5AD5A
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rkuvwTprE24fJNghi4ZBVGoXmVdkyqtzK8056YxkOMA=; b=Z2vJKQmwCdNKdXDsY0ItgqZD2p
	cScirOYM1fxO3bj/3wKfuIiKipG27iDjZgWhvIrfDld7gMvNpZ2dfNQ7H5KcCF19vQ1irPNWtPf9Q
	MrmTPuh3zkdatKyzES1/NClKSrj4Gn7x7pKrZzbrxzG8KwaKVsShe28kKPeBFb1Mkc7Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvE6P-0005tY-Sg;
	Sat, 15 Aug 2026 13:07:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wvE6N-0005tM-Tr
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 13:07:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gllhWvfh7w3BKPSYBNXOQwggUO8qGnC0x554PTpqb6k=; b=kyYoT6ggN++D8dHorWm9ytjI6M
 7NyTNevyFHs4/DhBUiK+xt9JgCzl7uYEQMu065WOXFBQQiGGh2X2hjcgEWVRVnrpheofgN/71kk7z
 ug02oCo0hAeJp98FAEF1G6204pnveypFa2SJvMO0ZwKNtN9FCDfe4TntI63tRyxCArdE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gllhWvfh7w3BKPSYBNXOQwggUO8qGnC0x554PTpqb6k=; b=Gch9gs7LgppsdF75BWKgAIay7S
 hk/YxV/Zn8p5W/w8jTVXiwVMI4atyjT+oB+oBBnIjjrdbz/GShcdqBPBX3xEqRqZr9sOApADl1/o8
 6z6xf76Zs0wz+zZdxdQjh04RRlD/3L08sDIb6ZWR5TaYkRiodP8bkeKkNyNpZa7jLTJA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvE6Q-00006l-HG for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 13:07:07 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67FD70xk020292
 for <openvpn-devel@lists.sourceforge.net>; Sat, 15 Aug 2026 15:07:00 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67FD70vA020291
 for openvpn-devel@lists.sourceforge.net; Sat, 15 Aug 2026 15:07:00 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 15 Aug 2026 15:06:53 +0200
Message-ID: <20260815130700.20272-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
References: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wvE6Q-00006l-HG
Subject: [Openvpn-devel] [PATCH v2] options: Move string utility functions
 to buffer
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

buffer seems to be where we collect string utility
functions, so move them out of options.

Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1775
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1775
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 2f4d037..6531f3e 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1142,6 +1142,38 @@
 }
 
 bool
+string_defined_equal(const char *s1, const char *s2)
+{
+    if (s1 && s2)
+    {
+        return !strcmp(s1, s2);
+    }
+    else
+    {
+        return false;
+    }
+}
+
+char *
+string_substitute(const char *src, char from, char to, struct gc_arena *gc)
+{
+    char *ret = (char *)gc_malloc(strlen(src) + 1, true, gc);
+    char *dest = ret;
+    char c;
+
+    do
+    {
+        c = *src++;
+        if (c == from)
+        {
+            c = to;
+        }
+        *dest++ = c;
+    } while (c);
+    return ret;
+}
+
+bool
 checked_snprintf(char *str, size_t size, const char *format, ...)
 {
     va_list arglist;
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 9bdb36a..2776bfc 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -952,6 +952,9 @@
     return 0 == strncmp(str, prefix, strlen(prefix));
 }
 
+bool string_defined_equal(const char *s1, const char *s2);
+char *string_substitute(const char *src, char from, char to, struct gc_arena *gc);
+
 /**
  * Like snprintf() but returns an boolean.
  *
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 03cda5a..a95b6e0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1101,25 +1101,6 @@
     return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);
 }
 
-static char *
-string_substitute(const char *src, char from, char to, struct gc_arena *gc)
-{
-    char *ret = (char *)gc_malloc(strlen(src) + 1, true, gc);
-    char *dest = ret;
-    char c;
-
-    do
-    {
-        c = *src++;
-        if (c == from)
-        {
-            c = to;
-        }
-        *dest++ = c;
-    } while (c);
-    return ret;
-}
-
 /**
  * Parses a hexstring and checks if the string has the correct length. Return
  * a verify_hash_list containing the parsed hash string.
@@ -3574,19 +3555,6 @@
     }
 }
 
-bool
-string_defined_equal(const char *s1, const char *s2)
-{
-    if (s1 && s2)
-    {
-        return !strcmp(s1, s2);
-    }
-    else
-    {
-        return false;
-    }
-}
-
 #if 0
 static void
 ping_rec_err(msglvl_t msglevel)
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d950a67..90a422b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -896,8 +896,6 @@
 
 void setenv_settings(struct env_set *es, const struct options *o);
 
-bool string_defined_equal(const char *s1, const char *s2);
-
 void options_postprocess(struct options *options, struct env_set *es);
 
 bool options_postprocess_pull(struct options *o, struct env_set *es);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
