Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE48CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SQPA3Hre7hffGJScYqzYC8FbCcckefjFAwEAArBdhVg=; b=Iy5yz6C0J6FvTCv47xFU/c8brW
	Bp04R8QEX3XwVb7VdkIZ2ieS1uOU72Rhrv01NcpjZT0SycSxZS3tdnn20tmR6j16YKRVNn/fkJp6/
	27F+IbMljJuDvDsJO7gRSvk/kSS78+9WeKFi1DeZp9/JLOncipbSKkBEt+YTmmScRaL8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xISxH-0003oQ-3p;
	Sun, 18 Oct 2026 15:37:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xISxG-0003oE-0V
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:37:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ysSKWhLvqFYErGLBTQ/MaltiUM3sSCztGdtSkojlYdI=; b=DVqINUQIIvMusA3K9u4iCvvUF7
 bMyCadK/2T5txfbj43raTrs8uf6grUn0MTTOZ5flU/pOSeX7MW8qHCeLZVIRH2CijsJyr+ZphHO/Q
 clJE45TQUZfBD38wLoOoLHEMN5V2a1cT7UXIs9wJtg3fAjLH8p+iVRdikbj3wzNJd1GQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ysSKWhLvqFYErGLBTQ/MaltiUM3sSCztGdtSkojlYdI=; b=EPowTZSI/eMrsenUyUBmNNcmsW
 k9LA+ocgyhsk/6ZBAbHUAQLluiStk0/ORzjOzn6+IeqqZZ5u6Shzl1ILv9ndq0PUfm8DdwpWzrlLn
 SUPqbk//YVcp3m8uwxPEZskmYaoU/2ZXVXfTAdUegY14G0NGKraH//SOF0W9Cx4tn9dw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xISxF-0001bq-R6 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:37:46 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69IFbc0a023289
 for <openvpn-devel@lists.sourceforge.net>; Sun, 18 Oct 2026 17:37:38 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IFbcwZ023288
 for openvpn-devel@lists.sourceforge.net; Sun, 18 Oct 2026 17:37:38 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 18 Oct 2026 17:37:32 +0200
Message-ID: <20261018153738.23274-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792255622000.I0245175f2884d56838990f53cee6381b981b79c1@gerrit.openvpn.net>
References: <gerrit.1792255622000.I0245175f2884d56838990f53cee6381b981b79c1@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xISxF-0001bq-R6
Subject: [Openvpn-devel] [PATCH v1] misc: Avoid conversion warnings in
 parse_auth_challenge
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

Make sure we have a sane length and convert it int.

Change-Id: I0245175f2884d56838990f53cee6381b981b79c1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2004
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2004
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 0e4669a..b420aac 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -72,11 +72,6 @@
 #endif
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 #ifdef ENABLE_MANAGEMENT
 /* Get username/password from the management interface */
 static bool
@@ -127,19 +122,23 @@
 parse_auth_challenge(const char *auth_challenge, struct gc_arena *gc)
 {
     ASSERT(auth_challenge);
+    const size_t len = strlen(auth_challenge);
+    if (!buf_size_valid(len))
+    {
+        return NULL;
+    }
 
-    struct auth_challenge_info *ac;
-    const int len = strlen(auth_challenge);
-    char *work = (char *)gc_malloc(len + 1, false, gc);
-    const char *cp;
+    const int work_len = (int)len + 1;
+    char *work = (char *)gc_malloc(work_len, false, gc);
 
     struct buffer b;
     buf_set_read(&b, (const uint8_t *)auth_challenge, len);
 
+    struct auth_challenge_info *ac;
     ALLOC_OBJ_CLEAR_GC(ac, struct auth_challenge_info, gc);
 
     /* parse prefix */
-    if (!buf_parse(&b, ':', work, len))
+    if (!buf_parse(&b, ':', work, work_len))
     {
         return NULL;
     }
@@ -149,11 +148,11 @@
     }
 
     /* parse flags */
-    if (!buf_parse(&b, ':', work, len))
+    if (!buf_parse(&b, ':', work, work_len))
     {
         return NULL;
     }
-    for (cp = work; *cp != '\0'; ++cp)
+    for (const char *cp = work; *cp != '\0'; ++cp)
     {
         const char c = *cp;
         if (c == 'E')
@@ -167,14 +166,14 @@
     }
 
     /* parse state ID */
-    if (!buf_parse(&b, ':', work, len))
+    if (!buf_parse(&b, ':', work, work_len))
     {
         return NULL;
     }
     ac->state_id = string_alloc(work, gc);
 
     /* parse user name */
-    if (!buf_parse(&b, ':', work, len))
+    if (!buf_parse(&b, ':', work, work_len))
     {
         return NULL;
     }
@@ -189,10 +188,6 @@
 
 #endif /* ifdef ENABLE_MANAGEMENT */
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Get and store a username/password
  */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
