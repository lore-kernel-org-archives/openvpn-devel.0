Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D817DC5DF6A
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hSZi8o0LhstucNT0OEqd6HIo88C3OZX9k+NdoyL7nnU=; b=ffJXQcw6mTsXWKb7IHCN6sAhC/
	effKlFTut+3kXJPjBGKYlxIMiz1PjJ9aClDboG5d5DdXS2XuxwDFcRVrfcapqgMLitO04bJCcSUcy
	leud3rBEYauw5A1ZDvfp/Zw6ht3oY/6UKjI7+HaRPOycnAk6r3vIrwn6iwShNzFN3MB0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvE8H-0008Sw-Fk;
	Sat, 15 Aug 2026 13:09:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wvE8F-0008Sf-Gp
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 13:09:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0M5NrA2qFlt3ZvaN4J2vqBqp9sz3JsFD+df1yY5sbOI=; b=nUtNYjMjJyPmATIMwO+khJWyTY
 VJXUj5v0EWo+K811QaKmAkAod32x1mWraOjhpOqUSzRUU1djM9olcf76XR1/0NDxXEDGl8ILwlMR/
 n9TkfIvu815xuUUrJxqZCzp9B/lQmz6peFsdhGfqf0+si8eWatVyc06Rl5d9j/sNxWRg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0M5NrA2qFlt3ZvaN4J2vqBqp9sz3JsFD+df1yY5sbOI=; b=P5xhLecnTKTcjJVxsYcy1xGnmU
 1o59VtHgK7zTEcRqe8D5y9EiMDHDibZHitxKDCe6FzOt8gxJ71iwWHAFnCWsEMMJY6qqE80htdXSa
 a8u4M8+eDajLfUATMee3UmVg6i7eH1brqqLxqJKmwLmx4w++EYWYqiCavY6QK5mvD+3k=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvE8F-0000QO-CG for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 13:09:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67FD8uea020449
 for <openvpn-devel@lists.sourceforge.net>; Sat, 15 Aug 2026 15:08:56 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67FD8uKY020448
 for openvpn-devel@lists.sourceforge.net; Sat, 15 Aug 2026 15:08:56 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 15 Aug 2026 15:08:49 +0200
Message-ID: <20260815130856.20431-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1773073753000.Ie0b94b596637d660392bc4eda48d16cfecfeb971@gerrit.openvpn.net>
References: <gerrit.1773073753000.Ie0b94b596637d660392bc4eda48d16cfecfeb971@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wvE8F-0000QO-CG
Subject: [Openvpn-devel] [PATCH v8] init: Avoid sign-compare warnings
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

- Use BLENZ instead of buf_len where applicable
- Fix some comparisons with ce list length

Change-Id: Ie0b94b596637d660392bc4eda48d16cfecfeb971
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1562
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1562
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index caaa769..2196364 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -325,11 +325,6 @@
     return l->len;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static bool
 management_callback_remote_entry_get(void *arg, unsigned int index, char **remote)
 {
@@ -340,7 +335,7 @@
     struct connection_list *l = c->options.connection_list;
     bool ret = true;
 
-    if (index < l->len)
+    if (l->len > 0 && index < (unsigned int)l->len)
     {
         struct connection_entry *ce = l->array[index];
         const char *proto = proto2ascii(ce->proto, ce->af, false);
@@ -364,10 +359,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static bool
 management_callback_remote_cmd(void *arg, const char **p)
 {
@@ -466,7 +457,6 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
-#pragma GCC diagnostic ignored "-Wsign-compare"
 #endif
 
 /*
@@ -638,8 +628,8 @@
     } while (!ce_defined);
 
     /* Check if this connection attempt would bring us over the limit */
-    if (c->options.connect_retry_max > 0
-        && c->options.unsuccessful_attempts > (l->len * c->options.connect_retry_max))
+    int max_attempts = l->len * c->options.connect_retry_max;
+    if (max_attempts > 0 && c->options.unsuccessful_attempts > (unsigned int)max_attempts)
     {
         msg(M_FATAL, "All connections have been connect-retry-max (%d) times unsuccessful, exiting",
             c->options.connect_retry_max);
@@ -2176,7 +2166,7 @@
 static void
 add_delim_if_non_empty(struct buffer *buf, const char *header)
 {
-    if (buf_len(buf) > strlen(header))
+    if (BLENZ(buf) > strlen(header))
     {
         buf_printf(buf, ", ");
     }
@@ -2264,7 +2254,7 @@
         buf_printf(&out, "session-timeout %d", o->session_timeout);
     }
 
-    if (buf_len(&out) > strlen(header))
+    if (BLENZ(&out) > strlen(header))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
     }
@@ -2301,7 +2291,7 @@
         }
     }
 
-    if (buf_len(&out) > strlen(header))
+    if (BLENZ(&out) > strlen(header))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
