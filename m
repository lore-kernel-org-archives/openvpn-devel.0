Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E46C5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 21:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KNsXlmYW3UtC/NN+QEOreoXCqYXl5of/7wl4L0/fXJU=; b=cKsejwYYQr5rfrUR2SDMLU4HcL
	qRxckhBZ4ZaUtAgNk0P6H1HT6y5WEjNhOXMH3QK67VPObmWsXL2qxH34+IBVs/VP14JI7OphAGCsm
	3og0J7IEOIfIplDJA+RrIMf0uS1VP8ZUzriyuiN2pLelNIEC8tQ+jdjV1X+ex9s+XWss=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwnfy-00026e-BC;
	Wed, 19 Aug 2026 21:18:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wwnfw-00026W-S0
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 21:18:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tklaHUHfH0dJBj6AHNnkqPopgXJraQAzRK1c+yNQv/I=; b=RkbR0uVO3syulpvs1PgtqZaCKT
 Xrz1hE4zOdSCdbu/q7QroMQAHUu7lHKE4lM4jPlMPIkqt6JR6396EGWU8bgFFBAtL8JLtcWlzHfTM
 55cFqC9mis4QGsqSc8j8kg81IhjRh1HBK4D2vCZYBUbEFleH2y7LKZxaOUjKrXBR54KU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tklaHUHfH0dJBj6AHNnkqPopgXJraQAzRK1c+yNQv/I=; b=jCZczssfDXMs47NtoNMrwLwWxw
 G+rut10jgIbdnW9zZXmla4tvRVBCO1OXwK9qkrpcZqkvdmoC4MzIGq30GUCriYo5sZo3QvaEM9w4o
 ZNmsuMF3BJX00jEDU0OaOiQsCB1vG+XtBmnAi2AF2+x/lHLQZzEjGlGF6X7C0y5UW4Iw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwnfv-0000Zd-6u for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 21:18:20 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67JLIC7h003239
 for <openvpn-devel@lists.sourceforge.net>; Wed, 19 Aug 2026 23:18:12 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67JLIC8U003238
 for openvpn-devel@lists.sourceforge.net; Wed, 19 Aug 2026 23:18:12 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 19 Aug 2026 23:18:05 +0200
Message-ID: <20260819211812.3214-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
References: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wwnfv-0000Zd-6u
Subject: [Openvpn-devel] [PATCH v5] options: Move string utility functions
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
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index f14caa2..8c19902 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1086,6 +1086,38 @@
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
index 85277ff..651aaed 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1766,6 +1766,9 @@
     return 0 == strncmp(str, prefix, strlen(prefix));
 }
 
+bool string_defined_equal(const char *s1, const char *s2);
+char *string_substitute(const char *src, char from, char to, struct gc_arena *gc);
+
 /**
  * Like snprintf() but returns an boolean.
  *
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9f060e3..418329e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1087,25 +1087,6 @@
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
@@ -3566,19 +3547,6 @@
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
index 0fd505a..c23d0b3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -901,8 +901,6 @@
 
 void setenv_settings(struct env_set *es, const struct options *o);
 
-bool string_defined_equal(const char *s1, const char *s2);
-
 void options_postprocess(struct options *options, struct env_set *es);
 
 bool options_postprocess_pull(struct options *o, struct env_set *es);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
