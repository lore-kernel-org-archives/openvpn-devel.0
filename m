Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97250CD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vfAMEGkh9MqX9S6Jsze1gaBAUkEefW1+KPBacCdjTk8=; b=kuL0tD5DZ5yOP1T8rrBHN0fxYP
	DGQbCobyQ9tWheLCM+CG0o+d7WCdRQwOPQ0hxfy8Cw8w8zuHin82aYPyiL+KGqr3sEs48+zPBpzxS
	xWTGhXAQS4EyfuKMQzwt11Gs6Mwx08GCztzMWKS6sBcmYBXzTLjN5HcksczWIY0Qf1G8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxIr-0003k5-NY;
	Tue, 09 Jun 2026 14:19:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWxIq-0003jy-Gl
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:19:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wbm3QAvfdvwySobG9t8eJ8EZN271XtLjGTj2GLgAdOI=; b=ipV4oPpdKz9ybtobpxA0LZuvvc
 p1EEbUfpV7qNG3tpo46uT6ORA1G6iRX8KTCLtHxvhlXTcBk/0t3Xl0BbF6iTSW3MWmAF6v0F6Aix+
 KMA7EvwNsS9qlqIl5fx1ZCamhxd4BFOganL7BjembSqPAv1yw7nWUjQL0EALu3FkEdR4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wbm3QAvfdvwySobG9t8eJ8EZN271XtLjGTj2GLgAdOI=; b=AjhsYSjc40cIXdjtO1WcUv/m6D
 G2q42tmb6/HmOOX9TB6WaaYN2NNiASMXq82gJEtHgg1VW/D1JOLQ8SDnoSH0d1eN+7LZI1hb5TjSq
 lVetbI8RlutsQqgeyhlSH4PNhjHI4aQS6bCc5jcmhoM72dovjVmXzmw/E1lbS1/lDY68=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWxIo-00014z-E2 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:19:40 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 659ANVTU032464
 for <openvpn-devel@lists.sourceforge.net>; Tue, 9 Jun 2026 12:23:31 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 659ANV1u032463
 for openvpn-devel@lists.sourceforge.net; Tue, 9 Jun 2026 12:23:31 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  9 Jun 2026 12:23:22 +0200
Message-ID: <20260609102329.32451-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
References: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWxIo-00014z-E2
Subject: [Openvpn-devel] [PATCH v5] mbuf: Fix conversion warnings in mbuf
 and related code
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

Mostly these were actually hidden by casts, but fix
them as well by using more fitting types.

Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1433
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1433
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 75110ed..07e3985 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -43,7 +43,7 @@
     unsigned long long res =
         (unsigned long long)m1 * (unsigned long long)m2 + (unsigned long long)extra;
     if (unlikely(m1 > limit) || unlikely(m2 > limit) || unlikely(extra > limit)
-        || unlikely(res > (unsigned long long)limit))
+        || unlikely(res > limit))
     {
         msg(M_FATAL, "attempted allocation of excessively large array");
     }
@@ -53,7 +53,7 @@
 void
 buf_size_error(const size_t size)
 {
-    msg(M_FATAL, "fatal buffer size error, size=%lu", (unsigned long)size);
+    msg(M_FATAL, "fatal buffer size error, size=%zu", size);
 }
 
 struct buffer
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 5e1b585..7b790ed 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -34,11 +34,6 @@
 
 #include "memdbg.h"
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 struct mbuf_set *
 mbuf_init(unsigned int size)
 {
@@ -46,22 +41,17 @@
 
     struct mbuf_set *ret;
     ALLOC_OBJ_CLEAR(ret, struct mbuf_set);
-    ret->capacity = adjust_power_of_2(size);
+    ret->capacity = (unsigned int)adjust_power_of_2(size);
     ALLOC_ARRAY(ret->array, struct mbuf_item, ret->capacity);
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 mbuf_free(struct mbuf_set *ms)
 {
     if (ms)
     {
-        int i;
-        for (i = 0; i < (int)ms->len; ++i)
+        for (unsigned int i = 0; i < ms->len; ++i)
         {
             struct mbuf_item *item = &ms->array[MBUF_INDEX(ms->head, i, ms->capacity)];
             mbuf_free_buf(item->buffer);
@@ -145,8 +135,7 @@
     struct multi_instance *ret = NULL;
     if (ms)
     {
-        int i;
-        for (i = 0; i < (int)ms->len; ++i)
+        for (unsigned int i = 0; i < ms->len; ++i)
         {
             struct mbuf_item *item = &ms->array[MBUF_INDEX(ms->head, i, ms->capacity)];
             if (item->instance)
@@ -164,8 +153,7 @@
 {
     if (ms)
     {
-        int i;
-        for (i = 0; i < (int)ms->len; ++i)
+        for (unsigned int i = 0; i < ms->len; ++i)
         {
             struct mbuf_item *item = &ms->array[MBUF_INDEX(ms->head, i, ms->capacity)];
             if (item->instance == mi)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
