Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AE4CD37B6
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 09:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IeF1dpSfOmMzWQBxptgzLzhGx8yxGTbrMwvhLu8hJNA=; b=ZWLp6744bAZ/7iCcI/S5DYd+EQ
	cnUARlTAyCP7ypE6yAhNI28zn89m4+pEVoO9PvbWIFfAyGTLji0d6AhdSSkYObilVMPbjDoyu0wxx
	9Lzropa2tCRfbYTqv/B/mslmoae3tGUL4dRmzMCapPGdxOlDQb3mde524euUeXdIAvQs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN5o1-0003AE-Oe;
	Wed, 13 May 2026 09:23:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wN5o0-0003A7-U5
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Wz4wJRG6lJCWnw58Xa+mY8gxQCkN73xw6CkDbGwfP4=; b=iGmWXo1fzWVzzRp5maVLxthR+k
 anXjPwt4oSX2uOZoodtrBX07fTVyCatr5KAZQHnATIOy1zDpR/bbWORno9jo9Zez+BbxNbe1kNfZr
 XiZuI1h+YAWQ0NmQS4eIvwfbaD8bC9YA1TnzcludNo0wL1JqBq1TiPHolLX17O+qnxnY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1Wz4wJRG6lJCWnw58Xa+mY8gxQCkN73xw6CkDbGwfP4=; b=O/qci1iDvF1WZsbYiCAxeRZ8Yk
 nfLlRIH4SZBCKIXlyBlhsVRQHhQ6UKgW3b60cSx9CZkCpT2Xqn387Df5IYhPljN3eGkOMyYcxzied
 5ZMPfkqoaX71HFMAFflwe5FlP3/uziquQpmV0mpspc8tqenVeSIfbhol9H0enkyPSh7g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wN5ny-00047t-Lp for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:23:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 64D9MpXs028877
 for <openvpn-devel@lists.sourceforge.net>; Wed, 13 May 2026 11:22:51 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.1/8.18.1/Submit) id 64D9MpFc028876
 for openvpn-devel@lists.sourceforge.net; Wed, 13 May 2026 11:22:51 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 13 May 2026 11:22:45 +0200
Message-ID: <20260513092251.28857-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <gerrit.1778102459000.I3ecb76d9022dcd7dae92eb5e9d62e5f018744883@gerrit.openvpn.net>
References: <gerrit.1778102459000.I3ecb76d9022dcd7dae92eb5e9d62e5f018744883@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wN5ny-00047t-Lp
Subject: [Openvpn-devel] [PATCH v3] buffer: Fix some issues with
 -DVERIFY_ALIGNMENT
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

- Fix some uninitalised fields due to BUF_INIT_TRACKING
  (found by cppcheck and the original reason for this
   change).
- Fix "unused functions" if only BUF_INIT_TRACKING is
  defined.
- Fix conversion error

Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f018744883
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1666
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1666
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 71f3769..1e19137 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -64,14 +64,13 @@
 #endif
 {
     struct buffer buf;
+    CLEAR(buf);
 
     if (!buf_size_valid(size))
     {
         buf_size_error(size);
     }
     buf.capacity = (int)size;
-    buf.offset = 0;
-    buf.len = 0;
 #ifdef DMALLOC
     buf.data = openvpn_dmalloc(file, line, size);
 #else
@@ -90,13 +89,13 @@
 #endif
 {
     struct buffer buf;
+    CLEAR(buf);
+
     if (!buf_size_valid(size))
     {
         buf_size_error(size);
     }
     buf.capacity = (int)size;
-    buf.offset = 0;
-    buf.len = 0;
 #ifdef DMALLOC
     buf.data = (uint8_t *)gc_malloc_debug(size, false, gc, file, line);
 #else
@@ -120,6 +119,10 @@
     ret.capacity = buf->capacity;
     ret.offset = buf->offset;
     ret.len = buf->len;
+#ifdef BUF_INIT_TRACKING
+    ret.debug_file = buf->debug_file;
+    ret.debug_line = buf->debug_line;
+#endif
 #ifdef DMALLOC
     ret.data = (uint8_t *)openvpn_dmalloc(file, line, buf->capacity);
 #else
@@ -140,6 +143,7 @@
     return buf_init_dowork(buf, offset);
 }
 
+#ifdef VERIFY_ALIGNMENT
 static inline int
 buf_debug_line(const struct buffer *buf)
 {
@@ -151,6 +155,7 @@
 {
     return buf->debug_file;
 }
+#endif
 
 #else /* ifdef BUF_INIT_TRACKING */
 
@@ -1152,7 +1157,7 @@
     if (buf && buf->len)
     {
         msglvl_t msglevel = D_ALIGN_DEBUG;
-        const unsigned int u = (unsigned int)BPTR(buf);
+        const uintptr_t u = (uintptr_t)BPTR(buf);
 
         if (u & (PAYLOAD_ALIGN - 1))
         {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
