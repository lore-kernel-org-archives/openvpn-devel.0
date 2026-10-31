Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A0606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=elg8HveF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SmnJEVw7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Sg4bea3B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jMK/NLjpPwLal9xo5ecc9g2Dyint8F6RUl8JFQP+tQw=; b=elg8HveFPE40Zw
	7qcvYNUYbooMuuf0qmapPPLeDkgWJksqapVM3RWZsaIFXJVp/xbpp434nX4FMcS+s038RQWWQI9cj
	fd8a0tuXBQh4Kj+3a/f/tuxAK40uwA7n53bSgQ5CjT0Tw2K4tmK2NzUEQuyb6WBvbpvyyzkaZ5g/I
	H1M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN3pa-000000004qn-1YqD;
	Sat, 31 Oct 2026 07:48:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xN3pZ-000000004qg-12KS for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 07:48:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4GwL4wR318x0nR6njNSIU2hoBKW44nKVdoLZeBj1bm8=; b=SmnJEVw7NNbVvLAFyixU5IwAvy
 H8EsSA8G3HlmRLe4V4FdLYVxuOWFtPqzKFPObwKhtwC0mKUXBwTb7/anmEbzYoM8ZUUYe5EhULu6L
 DIfWrzZ6Nwb6fU55D2qa9fEkrdIKssaadlodu0K9K1MvZLkpoGv75gEwBKmryqme6vQg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4GwL4wR318x0nR6njNSIU2hoBKW44nKVdoLZeBj1bm8=; b=Sg4bea3B+L45s3o4zAjbi9uAAc
 NllaqR0SfZ8IvQDF0c6d30L8C1hpkr5P13R00vMM51C+uccyR+vna5uNTjH3l+K6/DmcCipu63zkD
 JO9Lz6Kg7XzRcNwR3l5+j/jS/9Q8bBUKE8DXsafp226i0Zy/NH25ctG534/zIGM4skJ4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xN3pX-000000000ub-3yEO for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 07:48:49 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69V7meMv027560
 for <openvpn-devel@lists.sourceforge.net>; Sat, 31 Oct 2026 08:48:40 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69V7mebj027559
 for openvpn-devel@lists.sourceforge.net; Sat, 31 Oct 2026 08:48:40 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 31 Oct 2026 08:48:34 +0100
Message-ID: <20261031074840.27546-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
References: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xN3pX-000000000ub-3yEO
Subject: [Openvpn-devel] [PATCH v2] Increase the buffer size for
 alert-message in management user-pass query
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

From: Selva Nair <selva.nair@gmail.com>

Increase the buffer size from 128 to 256 to accommodate a reasonably
long username and static challenge message when both are included in
the prompt. Print a warning if the text is truncated.

If the encoded " UN:<username-base64>" string is longer than 128 bytes,
skip adding it to the prompt. Print a warning. This caters to up to
about 90 bytes long usernames.

Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
Signed-off-by: Selva Nair <selva.nair@gmail.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2073
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2073
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 65e2881..16864c8 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3618,7 +3618,7 @@
     {
         volatile int signal_received = 0;
         const bool standalone_disabled_save = man->persist.standalone_disabled;
-        struct buffer alert_msg = alloc_buf_gc(128, &gc);
+        struct buffer alert_msg = alloc_buf_gc(256, &gc);
         const char *alert_type = NULL;
         const char *prefix = NULL;
         unsigned int up_query_mode = 0;
@@ -3680,23 +3680,31 @@
              * Indicate it in the prompt as base64 encoded.
              */
             char *user64 = NULL;
-            if (openvpn_base64_encode(up->username, (int)strlen(up->username), &user64) != -1)
+            const int user64_len = openvpn_base64_encode(up->username, (int)strlen(up->username), &user64);
+            if (user64_len == -1)
             {
-                buf_printf(&alert_msg, " UN:%s", user64);
+                msg(M_NONFATAL, "ERROR: could not base64-encode username");
+            }
+            else if (user64_len + 4 > 128)
+            {
+                msg(M_WARN | M_INFO, "Preferred username too long for user-pass prompt sent to management; omitting UN:<username> hint.");
             }
             else
             {
-                msg(M_NONFATAL, "ERROR: could not base64-encode username");
+                buf_printf(&alert_msg, " UN:%s", user64);
             }
             free(user64);
         }
 
         if (sc)
         {
-            buf_printf(&alert_msg, " SC:%d,%s",
-                       BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO)
-                           | (BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_CONCAT) << 1),
-                       sc);
+            if (!buf_printf(&alert_msg, " SC:%d,%s",
+                            BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO)
+                                | (BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_CONCAT) << 1),
+                            sc))
+            {
+                msg(M_WARN | M_INFO, "SC:<challenge-text> in user-pass prompt sent to management got truncated.");
+            }
         }
 
         man_wait_for_client_connection(man, &signal_received, 0, MWCC_PASSWORD_WAIT);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
