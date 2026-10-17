Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2B0CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QYZV0CuDDb3uL50z8xjxNZvLbUdUrbgZS/uFKt7iVl4=; b=NExT5NOylPEX7D0wFMxFuH8X9r
	KIyc2U9HRoAg3kYZeWn8fAHipmoPuq7LNpanw9FWDXabOCrrCxvLh0uMkCRSGzX6Ydbso7yUiyLiq
	AWF37HC2GhUZ27zm1EAREpTYBS/0oB+1ZHTegrYyfHTHhjdmWMyt1Of84GJa8QGeRPco=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI808-0003vJ-QY;
	Sat, 17 Oct 2026 17:15:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xI807-0003vD-MK
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 17:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c/GLfB5eDSOZf4OM5ohCbV+maoZ8mGy/pk17TwoeheI=; b=alCW8rbhKBzVLjjC0rRWDJKNnW
 KJrPuDja0ONibzsDPsOmFdvUB+5pjnUaOWj0+7OVDKkn5z6vO8BBXkSzKnskLux/LEI31G6JaYE7X
 b/qpBBXkyignRKDWw7EkxRAaFpdOLUDxTyf4mBeuB3QOGE2D5jDnaOtJtqmbOuvSQ0S0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c/GLfB5eDSOZf4OM5ohCbV+maoZ8mGy/pk17TwoeheI=; b=Yr8ey7i4ivXGeqF5Ls/s6CiVJi
 ibgOh4PMve9FP8Zos0GFxKjQnima2xFWRUFsRsla26WLntFCyWJOYeb9N1hgjJye4SS5IilPvn4B5
 957l0gAA5WaC0FnT55rlD3qba21xFJx18oKGlEWP8Z73P6If6KUGgaVPfTtgG6plslm0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xI803-0006io-UT for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 17:15:17 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69HHF9m8015944
 for <openvpn-devel@lists.sourceforge.net>; Sat, 17 Oct 2026 19:15:09 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69HHF9Pv015943
 for openvpn-devel@lists.sourceforge.net; Sat, 17 Oct 2026 19:15:09 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 17 Oct 2026 19:15:00 +0200
Message-ID: <20261017171508.15923-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
References: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xI803-0006io-UT
Subject: [Openvpn-devel] [PATCH v3] Replace strncat with strlcat
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

Generally much better API. Not a straight-forward
replacement in many cases, trying to improve the
code generally.

Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1996
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1996
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index a75bd8f..b9cc6a2 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -437,12 +437,11 @@
                     }
                     else
                     {
-                        if (strlen(up->password) + strlen(response) >= USER_PASS_LEN)
+                        if (strlcat(up->password, response, USER_PASS_LEN) >= USER_PASS_LEN)
                         {
                             msg(M_FATAL,
                                 "ERROR: could not concatenate password/static_response: string too long");
                         }
-                        strncat(up->password, response, USER_PASS_LEN - strlen(up->password) - 1);
                     }
                 }
 #endif /* ifdef ENABLE_MANAGEMENT */
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
index 12934ab..3d893d4 100644
--- a/src/openvpn/options_parse.c
+++ b/src/openvpn/options_parse.c
@@ -244,10 +244,7 @@
     else if (is->type == IS_TYPE_BUF)
     {
         bool status = buf_parse(is->u.multiline, '\n', line, size);
-        if ((int)strlen(line) + 1 < size)
-        {
-            strcat(line, "\n");
-        }
+        strlcat(line, "\n", size);
         return status;
     }
     else
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index c7d375b..981bb23 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -234,14 +234,11 @@
 
         if (so->fd >= 0 && !so->errors)
         {
-            strcat(buf, "\n");
-            ssize_t len = strlen(buf);
-            if (len > 0)
+            size_t len = strlcat(buf, "\n", sizeof(buf));
+            ASSERT(len < sizeof(buf));
+            if (write(so->fd, buf, (unsigned int)len) != (ssize_t)len)
             {
-                if (write(so->fd, buf, (unsigned int)len) != len)
-                {
-                    so->errors = true;
-                }
+                so->errors = true;
             }
         }
 
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 1149c7b..6908cbb 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -157,7 +157,7 @@
  * @param tbslen        len of data in dgst
  * @param sigalg        extra signature parameters
  *
- * @return              signature length or -1 on error.
+ * @return              1 on success or 0 on error.
  */
 int
 xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
@@ -247,7 +247,10 @@
 
     if (is_message)
     {
-        strncat(alg_str, ",data=message", sizeof(alg_str) - strlen(alg_str) - 1);
+        if (strlcat(alg_str, ",data=message", sizeof(alg_str)) >= sizeof(alg_str))
+        {
+            return 0;
+        }
     }
 
     dmsg(D_LOW, "xkey management_sign: requesting sig with algorithm <%s>", alg_str);
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index a4d2d0b..01cc4de 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -47,10 +47,11 @@
     }
 
     size_t tosearchlen = strlen(tosearch);
+    size_t searchforlen = strlen(searchfor);
     size_t replacewithlen = strlen(replacewith);
     size_t templen = tosearchlen * replacewithlen;
 
-    if (tosearchlen == 0 || strlen(searchfor) == 0 || replacewithlen == 0)
+    if (tosearchlen == 0 || searchforlen == 0 || replacewithlen == 0)
     {
         return NULL;
     }
@@ -65,23 +66,26 @@
 
     /* state: all parameters are valid */
 
-    const char *searching = tosearch;
-
-    char temp[templen + 1];
-    temp[0] = 0;
-
-    const char *scratch = strstr(searching, searchfor);
+    const char *scratch = strstr(tosearch, searchfor);
     if (!scratch)
     {
         return strdup(tosearch);
     }
 
+    const char *searching = tosearch;
+    char temp[templen + 1];
+    memset(temp, 0, sizeof(temp));
+    char *target = temp;
+
     while (scratch)
     {
-        strncat(temp, searching, (size_t)(scratch - searching));
-        strcat(temp, replacewith);
+        size_t skipped = (size_t)(scratch - searching);
+        memcpy(target, searching, skipped);
+        target += skipped;
+        memcpy(target, replacewith, replacewithlen);
+        target += replacewithlen;
 
-        searching = scratch + strlen(searchfor);
+        searching = scratch + searchforlen;
         scratch = strstr(searching, searchfor);
     }
     return strdup(temp);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
