Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F12EC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OrrlVy4JMmjp9zUkFjJBOJenAHKc/Xwh0JKiBirhLEs=; b=KqP8hrj00Ko4KhCQP39P5deFHa
	D/QraWzKgrnXKvbICcY9luWRrEIxXfc/c11j5fLNYOjW8PWWfaV1Q0bmPPp9IWZMX7gVmx89QuwXa
	+gvPIonJOWNVcmrawMD4enmht0UdaRuOCF5GhM+5QeOoeW7Z0HF0GQpCBlPqx+H4Adj4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjZOy-0005AI-G5;
	Tue, 14 Jul 2026 09:26:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wjZOx-0005AB-3m
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 09:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L6KHeXvMkTz4JdSfkoWOXhrjcZRBhUBxaQp4cq/NqZI=; b=gtVQRg/A5KYcdHKSWPnfNIrhMG
 1IAh340NY/L/zDaZWZzbBptSgfYc6k8AbDLl0bRtqOCtZgpQTJfaUcaCcPiwcjUKvm4fg9wNPoQcm
 Qa8iurod3r13wfeDoJpsDYViSKOeQH2aDd2wU3BxmVCcD9Yshk0QhcYn8ut9IcEPS9hk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L6KHeXvMkTz4JdSfkoWOXhrjcZRBhUBxaQp4cq/NqZI=; b=cycADmA8vt4hm1bnNeLr/X7cyY
 piL5emH44avKmadjtUP5LJHQnlTpJbOV5/dkHyA9v6tTHl3xBnaScCv4XCWvYq09adbCEJ4hV+sWX
 gEycmPCIF3dukdyVfCGl4YFWDEAG49Fer1c/ghtgdo4QKctUBJ8rFxSHv7PA0M0R1XEs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjZOu-0003GH-E7 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 09:26:06 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66E9PqjH018709
 for <openvpn-devel@lists.sourceforge.net>; Tue, 14 Jul 2026 11:25:52 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66E9PqcG018708
 for openvpn-devel@lists.sourceforge.net; Tue, 14 Jul 2026 11:25:52 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 14 Jul 2026 11:25:46 +0200
Message-ID: <20260714092552.18685-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wjZOu-0003GH-E7
Subject: [Openvpn-devel] [PATCH v3] buffer: Add buf_read_u64() and
 buf_write_u64()
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

From: Lev Stipakov <lev@openvpn.net>

Add 64-bit big-endian buffer accessors alongside the existing 8/16/32-bit
helpers, using htonll()/ntohll() for the byte-order conversion.

buf_read_u64() reports success via a bool out-parameter, mirroring
buf_read_u32().

Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1740
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1740
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index fcc923b..1db9367 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -25,6 +25,7 @@
 
 #include "basic.h"
 #include "error.h"
+#include "integer.h"
 
 #define BUF_SIZE_MAX 1000000
 
@@ -702,6 +703,13 @@
 }
 
 static inline bool
+buf_write_u64(struct buffer *dest, uint64_t data)
+{
+    uint64_t u64 = htonll(data);
+    return buf_write(dest, &u64, sizeof(uint64_t));
+}
+
+static inline bool
 buf_copy(struct buffer *dest, const struct buffer *src)
 {
     return buf_write(dest, BPTR(src), BLENZ(src));
@@ -827,6 +835,30 @@
     }
 }
 
+/* Read a 64-bit big-endian value (see buf_write_u64()). Sets *good to indicate
+ * success, like buf_read_u32(). */
+static inline uint64_t
+buf_read_u64(struct buffer *buf, bool *good)
+{
+    uint64_t ret;
+    if (!buf_read(buf, &ret, sizeof(uint64_t)))
+    {
+        if (good)
+        {
+            *good = false;
+        }
+        return 0;
+    }
+    else
+    {
+        if (good)
+        {
+            *good = true;
+        }
+        return ntohll(ret);
+    }
+}
+
 /** Return true if buffer contents are equal */
 static inline bool
 buf_equal(const struct buffer *a, const struct buffer *b)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
